Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41575C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24th-00033Z-2y; Thu, 03 Sep 2026 06:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24te-0002w0-Lg
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24tc-0006pK-RU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:18 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHR1r3852489
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o/0+Uxr6/ZY3JhK/GkDs6id+76A1kYT7Zsx+XZ3AK0Q=; b=E2gJbo2MdiWioXHX
 mVYsOqXNbPZKdja6JTyM6eVJwwPrA4SW69TpzIrWFG4oYPmou0vlv2QR1xOtpuiK
 uJFcqOLEDT175BzGA6msODADYPEGSdiW92aaTaHcb6MMMHgFc0jkJcCepTNNnJqs
 OtmGMJgOGdzyEU6U+K3k1s5A23bJgpH7c2k4QDfOHuS2C3Mtdys7VWf6Vb21Zaj+
 xYggEsMiz2yoXh1diMMcl+bInBtT0+Y7zO+ygnTUJ5wK1HtljUKOs+UhQA/9QexN
 i2zg50FLfVtZX/jkNAGmc6g09qSSIFfnavZK64r5694jOVmD3w97ufEnxJU8s2Jw
 t6EipA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf51m0nb4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:42:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e4f946461so457201385a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432134; x=1789036934; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o/0+Uxr6/ZY3JhK/GkDs6id+76A1kYT7Zsx+XZ3AK0Q=;
 b=OOGdZYICgBG+cJcetT+skKr70JIwoDf6XzdA9GjFKiVfWCK6hC9A+hHFoO+1uQoSdc
 sF3d4lN79Gan0u9QofoXTZGoY2UuRdiKyI6SwW3GS3QOzxgcSp1KWi0tWvNYt9y6eeY/
 Hwbsc6iiVLwgDywVfdupSs28dLcET32AlxEdXZMKWlOldU2rjFGgUHXv7FgLUqihIIEq
 wGakb0sUQN44fUtO66U3EzQaE0fAStr5TT3UJkGXx+qcf09vUccJgJbR8u4oB2ZajcWd
 5IW0RmNqyiue0uw/poQt+5BhcXzb5WP5tVOu7S5C6Bxk6E9QIayS089d+WneqwbLpMAW
 AtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432134; x=1789036934;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o/0+Uxr6/ZY3JhK/GkDs6id+76A1kYT7Zsx+XZ3AK0Q=;
 b=YkoFuPoetGY5kD4ZpnYXGDnCbrWF0jTJy0OckORegKxf1GH+06JPhrJG2NSp4z6eYt
 +RD1oKJeGKJ7PDLb5uEYqRSp+zFVNtW7sJyxPPNeysNgrvKzbYuRYDWCVfLa6kU7JkCe
 b5HdeQkJ02rSFE5YwaqKGyeewCYfJHsEIiuLoIcFuAjTRFVbe6zagEI8bv4j2Ahbj5f8
 F5zGI33M/pM7g8MrtOJMj3fOAu85edEqp6bi3BNW5Hfh7E58rc7df4IYh2OoWqKvYoDP
 a+xb1wjTtRc08WrkjDj7nDY/CaQP6XYA5pLA4zgqHOF8YjLUoJnZL4CMFX4lf6fAkw1w
 P5oQ==
X-Gm-Message-State: AFuF++kUEig7B4iszt1ncqF8tPzZ7Ypjyz45USPjm1wUy/VRVcdGWZkQ
 KwQMIOrlVFXxEPIYbFcYiRAoiKXq5Bf8pkpQRtcGeXyOj7Jg2TNMqeue6ooR+O6Ch8Yp+cZ4N4S
 Ocg4nyLl8ZuHK77WaqTzGsE0DB2mP5cyeOd0vO49BidCUNGdT4NH1LGsr4QDmSzWBbQ==
X-Gm-Gg: AYBFou1cHYjwaBfUBGMfMFONzGlbYxK9kICejcBCi1F4G63fErHED65MSnJb2NDdY9H
 9fwIDKLL/fqRm+GRPG9HS73aShlLeu99aKAy6AH85lS+CGpcorckW0/K0qs5LSheqSEGsAQCiZJ
 gJEFnO4GBxEnAHGl4uZ4/JMToA8vihiw430+7MYvoLnZ2g1OF+7ouNmJo1/rC/bOi+MJdyLZzQ/
 g6kh2PF27tdN2cOKUZAC0eWlJJgGTnDsN1F53PsswyWC03QYMehlK/jjfdT80JCP6a3XdHbsDrk
 tkTpHp+1a/3pe2F6AH1fw2gI3Rxi4pn+/4aBlr/0NtcApgqd38FtHQSzQD/62uWV+7P1/sBnVjZ
 Y+kIJ0kJ+800WXmMjnsRRY1/K1DoIeEilYfE+iFbQ
X-Received: by 2002:a05:620a:4904:b0:939:6de7:a624 with SMTP id
 af79cd13be357-9396de7ccffmr466201585a.48.1788432134166; 
 Thu, 03 Sep 2026 03:42:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4904:b0:939:6de7:a624 with SMTP id
 af79cd13be357-9396de7ccffmr466198085a.48.1788432133644; 
 Thu, 03 Sep 2026 03:42:13 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed30c0sm13195916f8f.24.2026.09.03.03.42.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:42:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/51] linux-user: Uncast void pointer argument as Object in
 target_cpu_free()
Date: Thu,  3 Sep 2026 12:39:05 +0200
Message-ID: <20260903103936.62355-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8gKP0iy0dOyeCaQHsy9u9TeeBsdclqpA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXxWoPYHvtYkKG
 1oc7PU2jc8O8t6LI4kdIjgFJ7XVBnm2pdB+Ax73SfJTrs2U4Hx3yTgijRPtluXkPtJFoS2srjIr
 1ihPZrEF2D5lWqfEHVsd0gn9zxsAqOOFP0623TVfEGniKPA2wgLtCEk0e0ooSv9Z+b1FUsceO6P
 /OMNpzt9jGS0xDTErC8W2kIdxVlEm9SkE9MplAjHSDQR8/U5ipRZRU+8qZXVcOLrn8rU2KEC565
 nQAy2DcTuXUZMoKkSK078NswP+J9YA5UgB/cdp8i6bka9jPcbJV64yOCkfp/ineYG0+ilzz0gTg
 swAJ1Wj09Lhb7bXxiV61MxIYsfjTKXROoB0AHR118EWsInL4T8zUDoGcKYwjZvohvNhce8OmBMP
 zYq83S9oyJaFDhHhvGwI+zPg/mE40BaDq2xxB/xG72Krim5UC08sfQ2cnPVAhx6wvSfNq+vJf5T
 8JJm/YBLr9/JvySftPA==
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=6a994f07 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=2RGiIWwp3e7TAFkeQGYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX9DW+z3chZzy0
 02OfmI40eMKUJQ2gHsVCwwgygg+Xp1RE4xHnHiEPlcSsW6+CNzYMVXQCQo/li7YKJ+JDBOtNzrd
 fcKzvmHS3Ohz4S4kvXT6MCLRqk8t3KU=
X-Proofpoint-ORIG-GUID: 8gKP0iy0dOyeCaQHsy9u9TeeBsdclqpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-Id: <20260901095229.72018-3-philmd@oss.qualcomm.com>
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


