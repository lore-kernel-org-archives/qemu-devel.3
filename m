Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C89B606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A5PUYCXm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V7ecCTVa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0kj-0005p5-TL; Thu, 22 Oct 2026 17:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0kh-0005jJ-3a
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:55:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0kf-00084f-HK
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:55:10 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKWplJ3413397
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yHld9MMMXcLmKS0hkrcHdEUGfxdpa/G/zGBpwpoW6tM=; b=A5PUYCXmBK6Jcedt
 da7O9/Mz4+PrUARhx4guQNFRKglcpkeudXWK3poXfI0iPkFmLMrQQK9ggpfJKoA5
 qHL29LZn6hum3cWVHaGVjl22FH2LHiiaHZfopLt9t5dz9lipqJanQJuBFU/HjvOr
 gXOsb2EKUV/gZQQHQ0iGeMzQmNUoWsaE7u1m4kaz3InNN4ewh947am5z2i6CMrUy
 xGSiLRqUqG8pxUaQxUYwNSgAg9MN/VglOfCXodrEPxfkbl0XBVrptpKPbXLDgr/p
 Iwjs53GOBuS0WZSt/lg/Ij11iDL5N/6QFWR8i6MZFJUseNMti4lAIRRZlW64EA2o
 a0WWXA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmar83x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:55:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb98809caso41903785a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706107; x=1793310907; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yHld9MMMXcLmKS0hkrcHdEUGfxdpa/G/zGBpwpoW6tM=;
 b=V7ecCTVa1okgrKub1lJTj8wLjdjDQlDZC/tZxJwaf3TK2s6R7b78TccK+krKerqoDd
 fstLS2dHYKs9bAHqUhnjvF/kYdBl18ZCXEqiaCGEn+5LKDOdMz+RiENrvAzi+2m3wbQi
 RHRS/5jrAP08wLXuC+ToYZp1FNrBBoAmKvUry41ZudO16dLemBzzvN+8AsU1InhLXcCS
 wiCNPAbGWPgpWHSXvoIwH6loOji73RncEM7YZJ1AMHTKwIYBqxTGQQFuR9gML5wtLZnq
 0mPYkWSzSe57epP7oO7MKgHfEMUCRNyDg07YfWCINQlWjGNxoVfpmmFP/nYwghd1ehUc
 IkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706107; x=1793310907;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yHld9MMMXcLmKS0hkrcHdEUGfxdpa/G/zGBpwpoW6tM=;
 b=YtFZP8MTN4ljZhMFket2qrj6ygf3klUBCUgwNCqSE7nHfp5SbCTM2qsV0UljibPzAn
 YgDth+KhVQ6DHe7J42jc1524fbRYgKNFu1sT0s3VXTb28jEjUzYbWm6lEf99Px56gkj4
 5fcf4mL+i7BV+0RLESG+OZxfwLSPew0wsIHrVmM0MgNsy0eocVfCMhY4B90Gv5lKvomd
 2R6M3f5OGqQa6xKb8/2oLKTiRMLudwRnB/YwcoBsxPGJKSh1SNxaxa9y4+2c7MDPXw8g
 CH5ijIqp0TU0Ghx1pb0Bm7RRW3idCLhUl9OV7xqbVQez1Ubhi3mF8BhquWxJ1qUIbBYA
 3KVA==
X-Gm-Message-State: AFq9FYL2+xQdQqbIPtx1A4PM8rhO6J7tWVu/95KIFw2uf6786JnPQwnW
 A5MhDjHqHOzl5M5sIVWlde3r8c8jFu7a2woVOXrlekFYGOzMkG7ISYlo/gCSiqDrJzYSClXQ4xl
 W05vSizcXHFy1/MNo/6X0q+9J1qSVJgDsIxG+EnmxOguDK97KSJGKN92W+zwivgO9VQ==
X-Gm-Gg: AYBFou0d+wsv+vXFuhd1nO93IEMj0bNswOu6xscNRTeSEwGCNux3lOtaw0GdQPT4aPe
 9kvpo3Z7+lRZkBSACN+jWO5xbDo4kCJeqt7M+U7v85NRNq6Fo6/W/CGOJn9OYQTgggsTTrjEU82
 qI9TD/LebO1UxJruJiUTOP4NDxD9VZND4Ur1dq1SGQqM00M73nNu3fFJ4tCLsuLUa1xY6u28OmH
 aKV2AnGr5lm49uxhtoCsaB+fnF96cszhlJGPnkARTb51U0rURFhy/cd+SaReNg6AkNr6JLWjXb4
 hEaIT1eebOu3TsZkoa0wMtfRQO/KWjFKkSxjIx1F6R4Ske6rX49Tq1344Flgh6zcubwuz+nEgjJ
 t9Nkc/E2cR6rs99TbcM3ulQTopr3xfPy5UXcXS6Yi
X-Received: by 2002:a05:620a:6008:b0:93f:43a4:a479 with SMTP id
 af79cd13be357-93f6f83d137mr137522085a.66.1792706107003; 
 Thu, 22 Oct 2026 14:55:07 -0700 (PDT)
X-Received: by 2002:a05:620a:6008:b0:93f:43a4:a479 with SMTP id
 af79cd13be357-93f6f83d137mr137518585a.66.1792706106401; 
 Thu, 22 Oct 2026 14:55:06 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edfb3fsm837478f8f.8.2026.10.22.14.55.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:55:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v3 31/33] target/sparc: Remove always-defined DEBUG_PCALL
Date: Thu, 22 Oct 2026 23:51:11 +0200
Message-ID: <20261022215115.19680-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6ada863c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=d8nHZlMCPPOsqsKe8PUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXwwYgfEOLwnlA
 t4WSi4LgMtGJtqOObBl9OrM2UnIVDl60APTMjSYF4dVHiEPc092RfMAkzqo15IYXkMjzt6C90xH
 aStWvrPIGG/+jB/xEU1v9iwY67Vq+Wc=
X-Proofpoint-GUID: LYiNZlRkD0JbAgrDHrrXMJwL3f_6NKdT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX2PzbFOrwuJSY
 5kgY8R9DpLufEu+IZVu5+hWDnDVQRSnCOqxRLijtNWZpd/t9Nq95Vbu9XifwfhPxZxMcfaqxid6
 7wVmd0AnatEk+QizE3jwc3087xkFVnHryRwXILmMEbKSiOdfWVtxg1z85t6rB+4HikwJMIZY3QY
 fS4c6cXZFvBilYKK8Aq/2E96RtyAh0dkZdU9hB5c1TpeHAA2SCQclaJwZRAVjE3N14GY/cuS69d
 vm8sHgkCbFqS8mXDjji1Cv2cqpI4mbshdLKyERFOFZyvJSekoeMTCArgPdkxdsk8XaxE10bBO8G
 0/e7Qwqf5FCGwl5kUSPR+xyoyZJFgGSZRnoKK0MGLn3MwTfcNEQ5iw/O9ZhP6qYKiUSMCOYp4ER
 8o6vHPDpQqw+lvBME16cybv2SeFfwCjMJWVqYHUvOTTqDt3I/kbwAGUmLR5rEruFyfVFmGSycd4
 HneogvpV7P2HshXnf7Q==
X-Proofpoint-ORIG-GUID: LYiNZlRkD0JbAgrDHrrXMJwL3f_6NKdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DEBUG_PCALL has been unconditionally defined for 14 years now
(see commit b884fc5ecaa "target-sparc: Make CPU_LOG_INT useful
by default"), so the #ifdef guards around the exception name
table and the CPU_LOG_INT block are always taken. Remove the
define and the now-redundant guards.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/sparc/int64_helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 60ab0478fc6..10341e0c282 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -26,9 +26,6 @@
 #include "trace.h"
 #include "qemu/plugin.h"
 
-#define DEBUG_PCALL
-
-#ifdef DEBUG_PCALL
 static const char * const excp_names[0x80] = {
     [TT_TFAULT] = "Instruction Access Fault",
     [TT_TMISS] = "Instruction Access MMU Miss",
@@ -62,7 +59,6 @@ static const char * const excp_names[0x80] = {
     [TT_EXTINT | 0xe] = "External Interrupt 14",
     [TT_EXTINT | 0xf] = "External Interrupt 15",
 };
-#endif
 
 #if !defined(CONFIG_USER_ONLY)
 void cpu_check_irqs(CPUSPARCState *env)
@@ -138,7 +134,6 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     int intno = cs->exception_index;
     trap_state *tsptr;
 
-#ifdef DEBUG_PCALL
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
         const char *name;
@@ -177,7 +172,6 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 #endif
         count++;
     }
-#endif
 #if !defined(CONFIG_USER_ONLY)
     if (env->tl >= env->maxtl) {
         cpu_abort(cs, "Trap 0x%04x while trap level (%d) >= MAXTL (%d),"
-- 
2.55.0


