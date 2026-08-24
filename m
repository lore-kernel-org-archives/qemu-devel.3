Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B345C61CE4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySgS-0001YO-BJ; Mon, 24 Aug 2026 07:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySgQ-0001XG-PY
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:17:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySgO-0005AQ-UL
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:17:42 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99IjF2083097
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RXSFdJhduuq/vV0dSoh2i7hiqI/DLrn0WKuxvW2l1mE=; b=OSe90LJwxG9ZWXwF
 dmjkFE2qLrIhuEzcmfuTqA6lfzImvEfhNz8/DM8oqiiGpqh8FV8cyKpo67r3OX/3
 ilf2de8tV/srIa5Hn/UsZwjIEAHogc4tCx11qc6nXi39p+Q6joVvwbng2xphoLVe
 jmG0LNECb8kpDKpu/+l6+YykEkV8dxDwjhJFJ/ipQRG9GhfW3yShaRccODVEhcTQ
 15OdA3CQzC4dSJCeLfPZUz7jVQL0v2IfRflAgmuZAZMEpvJid0xO9EhDAaFoCfDd
 soHQMQUuG9ek7x2cOcSV4slSlRLRx8D4SdRpDkRsPQ5TokGhA8s4OdR0xVvPgEyK
 XdWMYQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hbth08y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:17:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a8db414c7so50831611cf.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570258; x=1788175058; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RXSFdJhduuq/vV0dSoh2i7hiqI/DLrn0WKuxvW2l1mE=;
 b=KLGV0VOKYjoAEDZ8s8MctpquTeTDQX+SFDZUQULjaxFitfh7Us/KU2KXns6FZ/MXLZ
 rnLgMpSZ7grmvER+RQrOXpPUysuFFjjRUqB5UL6b+GAQE4Q4+0CJ/a+O8u2Tq6s8IWz5
 OQmAkZxS3iYiqMk4PjDnipL27SSMv42kc4/AGvTK/DFb16qY7uE7iwacYY/6CreQy3aY
 MVuMG3V2HkUVg87Zbo1TNnComDbXs0kYZ25gUlDhZKVL+nEGep7Px/Lkr4AUfOGOUj34
 PEyQ7/qW54Ok2+NqXxTbBq7Qjv35gXRPDrscDhXMiZbK1+gtJ7qcT2pi3nI+RYrfH0CL
 alWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570258; x=1788175058;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RXSFdJhduuq/vV0dSoh2i7hiqI/DLrn0WKuxvW2l1mE=;
 b=TX20rUKuW0XyqHXIBmajpcI+8leMLdatZFnNgFFc3FppPT3pEb8q2OiwVuVGk2D19q
 zGW2wdQUStnR6GOpydVmqECmdc5y1Dx1zVMWyiwOKGSvgCc+Ckchzm53OXboROoOMsvj
 FI2DkN2Kb88scziIie5hZ3nOdlmeJLELi4/XjuwUuSP64a2H1nAZKa27o7O8qDmZ7u2i
 qbAiSdcV2hfdh53cJXxZ9fDOHTiPaGd29g08ysZ2thKDFNPhPmG2seQdorvwqExFGZYi
 6tkdmb0Ms8omXBX9YQzrOmnmH7D5d0Iq/G3P2kQWHSBzL6mon9sYWVnXwZ66thvKyk+K
 uE7Q==
X-Gm-Message-State: AFuF++mUAdiJZaCmYfzxZUHVkf1YYRSetPyh0zF5xCC3lEeR4JyIeu3S
 fdcyBIA0MMf2LG3v/cwy+PnVtrDrcrd6QVNWqo1NwZ5fXM9gFGUbf03+8i1oOI0iNr0N+sYc6OM
 QXxUQ/JHA0NZFHldvx5o4c6SdTVXsBNa/4DFOlk4JkyUtf6PsvMiW29XeYjrlylJwbg==
X-Gm-Gg: AR+sD13Uv6xx2bHQC2YQMid+g5SWUrc4omHPjGs0TzmOiWE+29K6fXXqEyXEfqzldVa
 4kewPWmPLYOCrWDrVfvIfVojtITgNePld6FjtFOeuE0Qb80FMB7SA5x0eTJRnbvPv0UdXn6R2x7
 6tOUPmzKYSZ/7ZbBavkPAvvFa/4EAk6sTgFNRoPozQgw1y7h6QghbyJJhu6qFtYlcuHsUuGROrH
 YqC+5I+tgwRIt12psyQSXW4Gp8u4YyLjmcqS0+PuH4KHGTn0lRdZ+ohcrKLNdSh/ZIPGniq6wcv
 NPE28ZrSnHSnRcqHyKBW4oiHWiMCym1bsWhkjrYGuQliXQg1GsheEIYSipMkZM/nAEVhzhOhqwd
 bLG+Kc7PYHYLNuVgjIWFOYzr3wEl0awTFS0mk8+dS5cnikC9o6Q==
X-Received: by 2002:a05:622a:1481:b0:52b:71dd:c930 with SMTP id
 d75a77b69052e-52e09d22017mr178947271cf.38.1787570258335; 
 Mon, 24 Aug 2026 04:17:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1481:b0:52b:71dd:c930 with SMTP id
 d75a77b69052e-52e09d22017mr178946741cf.38.1787570257708; 
 Mon, 24 Aug 2026 04:17:37 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f99basm1161443666b.37.2026.08.24.04.17.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:17:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 02/20] linux-user: Uncast void pointer argument as Object
 in target_cpu_free()
Date: Mon, 24 Aug 2026 13:16:51 +0200
Message-ID: <20260824111711.26297-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfXy0jQsMOoHX5e
 YIn9HsOJixfQYGpDS8kQRAfHNkh4UKyjO9s3s4bfkOWfTqePuFOypeV0ayMSLX6UL//NcpAvirc
 AMmcDjR+mODWOrArQ9PtqpvAtIcIndmVLTzEhsY9rbgaRrAF+IYe6P25Q8TdyE9igPhcAgGaIK0
 UKAnSuMXEwv7zfjLaAo3gzyy7pAXDY6PWaE3PmI5SRD1lOlNl+BOTIFz5bQu/OcG0PBadxmKQbl
 RsRZzFKBXmIyfxEikLeFoEdvoYkPxqCfV0jt2/ZdYcQk7el9vvtz7zzAEuv2VnzHnyJhun5nPiR
 M3yo7br1NFrHEdsIy2fOJYJvcB3Dobjqq+oZXUkVW7c9WWxXdm1UZE1EPwNh4nXiIseFWAfPzs0
 gl7Ccw+FqW8IpANDy8slxavmOTr8+WEC23xUiA3AXERJB6w3UQ3Jn+yMD/a3MidaDlDpsCm3wCe
 doUn5Y5MsHRRdLOcVpQ==
X-Authority-Analysis: v=2.4 cv=JL0LdcKb c=1 sm=1 tr=0 ts=6a8c2853 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=2RGiIWwp3e7TAFkeQGYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfXxfIhR7oZC6Zb
 osDbEwcfH3XdfAFyq43rQzLXhsNZNB6wQ7jwboDDkOXaquZGpCLAGURF2BzA7uJQiAE5iPyFBBw
 eFKKznzCOITTPAyH5A07S3GM06w+1lM=
X-Proofpoint-GUID: h6pBBSYR1wC68Yd5k3ovC_4ztzqDRRLC
X-Proofpoint-ORIG-GUID: h6pBBSYR1wC68Yd5k3ovC_4ztzqDRRLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

init_main_thread() is registered as Object::free() hook, thus
take an Object* argument. Uncast the void pointer as such.

While now cpu_env() accept any pointer type, next commit will
restrict it to CPUState* type. QOM-cast the Object to CPU type,
otherwise we will get:

  ../linux-user/i386/cpu_loop.c: In function ‘target_cpu_free’:
  include/hw/core/cpu.h:604:31: error: ‘_Generic’ selector of type ‘void’ is not compatible with any association
../linux-user/x86_64/../i386/cpu_loop.c:331:19: note: in expansion of macro ‘cpu_env’
  331 |     target_munmap(cpu_env(obj)->gdt.base,
      |                   ^~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/cpu_loop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index fe922fceb5a..2f733b0b477 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -326,9 +326,10 @@ void cpu_loop(CPUX86State *env)
     }
 }
 
-static void target_cpu_free(void *obj)
+static void target_cpu_free(void *ptr)
 {
-    target_munmap(cpu_env(obj)->gdt.base,
+    Object *obj = ptr;
+    target_munmap(X86_CPU(obj)->env.gdt.base,
                   sizeof(uint64_t) * TARGET_GDT_ENTRIES);
     g_free(obj);
 }
-- 
2.53.0


