Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B09C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMp4-0003pn-FU; Fri, 21 Aug 2026 06:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMp3-0003m5-6T
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:50:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMp0-00035f-Mo
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:50:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9M1lo1895875
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RXSFdJhduuq/vV0dSoh2i7hiqI/DLrn0WKuxvW2l1mE=; b=jSHD2uT9+Uu7LLDr
 c5rFt2uITfugowPNazmZYv4w0L9T2Qczp6qzcWHvWIQ/zxhOELgmw4ttom4w0Nht
 +UIjgjXFUgW0t9RGfK+a/Z2tAOQzflBd6vpdzq/jwOfF/eA98uMiPDOBMvZOPID0
 qqRhxtrOS8vUB8o55F/JmXJObsWUc8sNfKdg7J0asNRLeKbXE77+D0x5qwctvi4I
 8tsMEqMgfbTUtH+3frundZyGm6pPLN6l/LvR5rpQ5Kb3aVZpviHA3HwHVrcpNHK2
 E5BJNBmXpbbQs7sNGu0QkeD6RSTBzaznZN4wsoGdAQOK0ucTybO0QHpTKvlCSw+g
 /iuGJQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdn9720-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:50:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c01ff996dso10843641cf.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787309401; x=1787914201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RXSFdJhduuq/vV0dSoh2i7hiqI/DLrn0WKuxvW2l1mE=;
 b=aAXPjyCzWBeD65U/T4aKkSXxiGQsqXAJe45QDJM/5GRtMQo+qzixl3Ra2t7Ug7ope+
 1d5zKVc18WSWhkwrRYL9gchCaE9OYhcRJNKXE+ZpDKVCe0/eo2wuN5Z29AUPmucypczQ
 RcE/drW3Fioo7AHTnEuM2wwino0zLVO8fTbFXaEkGfEhUDJP2UpvRY1ibTROsJli94Qa
 DswM7zpNglTobNc3I5c/+8O2WGo52FIc33QY+44rGbJIJO21P51U2Fj35WGupBnwTh8S
 QwRyZF9DLoD96bkBEwIoJoaioMqj+Vn+LutciHF9iPoMG5dZWwqtJJ7u7TdpWscfJWBq
 Tq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787309401; x=1787914201;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RXSFdJhduuq/vV0dSoh2i7hiqI/DLrn0WKuxvW2l1mE=;
 b=QH31y+JBIkiwMJmp5oF93v4rjlgVhZDRQHA0AEa3REfdp3JKct+SW7ubXhCu4cRr7r
 RJbz6LL8iUYw8mYmp8M0YLHOs2bJ3YUbGVRYgldcGEJ1+k+8pkRMaGEvw3928TCG9/mp
 bCBiTALvPXB/pOCJIiQ0ix5h7QMdGhnbUZfVDSEOToWssBacX5uH4/2b0OJKDx0gsZsH
 MGTVU0EthI59sAC06zINhKgDX+NyFSYFJQ/ckbGlc53oh3AfO+orWsk+9ZCeOH+Fi54E
 fMnTqep8POxhqTcLpCVERaY4R6kl/Z20lnHr/Sx+eh9e7Mf+c6U2kYkJqgqq5p5dZBte
 Fctw==
X-Gm-Message-State: AOJu0Yz0lEMsKCBf1leQpI3j3xxHHkNuguCJO4UdYDOVhn4gtcXfMaRi
 FqEdHz+qDVRKzGwxoPPfNuzpSyxbNxJ8B7GSRpnusbvQhpdQ5yec5Stf+62cyfBdOOzOedEeB+C
 7FbdnhVVaoinTNp11Ret423OuFtu6AaCoJB6bDUkfTpZWrms4qVynd/2bItaRRXKhvyem
X-Gm-Gg: AR+sD12LSownXA8DLqnQVxFmSUmtKgMnVDgjSXT27dKtspON/nuCQIEbzlQ6G/doxTa
 HaoA2vv87QkhAmY30RSC7lwcxuBzUZPBLdK8EHdcWAkE+bnRBmHYmV84v7RY/cqUsyMTzl+30bX
 BBRVtN/zOQd9SB8sX/XksWAQhYnCepUAPskhvd2QVATUawrjc0a8UD2b8J4CrkH9KhCaetJwfwi
 d/mOPfMKx2fKCpIzMJ+Shdj6QFYm7es13Dps0SNCmC5J9VtiIE5wvWq2gcE4cD/zpu9fJqrp+LQ
 GzAPMpr4sn6xNHrh95U/nctxz2BNRjrhEheC9Ngd+o44VsfROMX2q4oudIIO+VegvVdkpBCC1G+
 z1EkSPkAGJ+XA1VcXCTS7AQnih7Df2gEpUwPbq1x6mQ==
X-Received: by 2002:a05:622a:a11:b0:52d:918b:92e2 with SMTP id
 d75a77b69052e-52df56f1740mr49132761cf.6.1787309401033; 
 Fri, 21 Aug 2026 03:50:01 -0700 (PDT)
X-Received: by 2002:a05:622a:a11:b0:52d:918b:92e2 with SMTP id
 d75a77b69052e-52df56f1740mr49131911cf.6.1787309400169; 
 Fri, 21 Aug 2026 03:50:00 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b145153fsm16798002f8f.12.2026.08.21.03.49.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Aug 2026 03:49:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 01/15] linux-user: Uncast void pointer argument as Object
 in target_cpu_free()
Date: Fri, 21 Aug 2026 12:49:35 +0200
Message-ID: <20260821104950.32108-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821104950.32108-1-philmd@oss.qualcomm.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfXwnNagSfbRLpm
 QF0sOEsLcXzaahgwRsqg78LBuMhjBT6VcJ4L9ODoN/aIc/vH8jFPb0YktDPMDVCGMwsyySyzvm7
 tYjFCS/IWWGsanjXfYVkjljxEwck4kZ5CRQw1wga3qbHNmd0G4nE7Ytd6koqHH67z7k+SjlITKs
 iGvg6VtXsRWidBvsEZOb6apaaGuI2bJj14yzj3ogdCyf4qgyIvXSz1uYle3Lwo29J349SI1wJuD
 ga8rdJN7eBzChnjO+k06xo5hHt7GIrBMGA08ZODRvgc8ioNi0c/fbfCoLZheSNiDhTtP6px3vqG
 SDjZbdmZynHSRdlcICOkKrLtCcYn8lNusv5WnTRvXzJVB/fvAI/qTZ6akukJFzzcAqClTxnVCDa
 F6Pdw/K4jYvFpsX9s798lUvQHPGD3iD4lolpOHD3oGvg9Rz9bR7HjtoF3PVzUK24p05lzv+gn+g
 vKMEzsDQM8iVVuRJ94g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX5z/8cQkbz8a+
 A5Jr46Z86KmifItGzHZc5atVSNgiK947Au4xFhvVZf3MovqUfLgiGB11JwGS4BigoxuW/Se4mJa
 pRfHBgdv8QecdRN781kasnKgLIxsBc0=
X-Proofpoint-ORIG-GUID: HdWzm42_lOfD4TPNwT4yY5SoZ_NVj2t9
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=6a882d59 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=2RGiIWwp3e7TAFkeQGYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: HdWzm42_lOfD4TPNwT4yY5SoZ_NVj2t9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


