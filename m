Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A6606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eITrlHj/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TQTgoVmD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI0e-0001GV-Sh; Fri, 23 Oct 2026 12:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI0X-00015D-Vf
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI0U-0002xg-P4
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:40 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE661Y3018953
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l1lqnjP7naulAaIaoUswheUlFqomEI5Zxfp5GnOchz4=; b=eITrlHj/OBuvCMcQ
 KA5nUlZlGc4y/tEfGyv+tg+brlQAfwR+iP6OUH0jCBWhAx5K8Iujj3aOL1alCuFi
 AASu7ZJP252+KAyNhyO7yNTvEDKtUDH8NdrjLybZsDpx7whxaQ8VLcKalWl/2M9s
 0fxwrc6xuYJJSnesL7Q+qFMIa6JzDAGdEZzdlqxrf6QESxKFvJ9X9sv7vVn1IIfX
 Yw4Jd93tg908YR/XFI6yE8drX57V7SdMwj7zuPNGY3u0E2lEHP6ib6gEm6geyy7h
 ebTQvdcnhevwzHpCHwYvIZ2Cb9nlpgAJe2mpVNtVt59yFw6fz7ecoz57lU+i3+XX
 nBE5CA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsykby54-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5ab5c136so168547585a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772434; x=1793377234; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l1lqnjP7naulAaIaoUswheUlFqomEI5Zxfp5GnOchz4=;
 b=TQTgoVmDzEfESs28NH4wUlF1LM7sRz3CahyT+ofLFxy0VTaJ8o8IavBXG38ARYSV18
 hdSXc3zNWdAeAwbvX5RqtlgmhoahmktGlvkW9/BDmA+z19vLsOVC86TOM3R7ilRVgXQI
 XHEZOWeYD5kK1f0ljtDdrr//Nd9odh0qzcl6yguwrkb0UGlRREODrkVEJbFHUDX1KfO/
 dihPyOsTVzfOvI5OKOWMN2U6K8b6+MbVxvOgl/8OMtqDcBvzut+m9OOzGNu+VEyHWf+2
 BEUX8fRkCu4pW+Tdyacrw1vL+wRYvYbm9t/ceJd++XO3PI8TYpm1PHWlA5EHzX39n6H8
 +KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772434; x=1793377234;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l1lqnjP7naulAaIaoUswheUlFqomEI5Zxfp5GnOchz4=;
 b=xYwpl/G4JIWhKruov0IDvU/q/kgIScAJ0+TmBt/YxPxx70QKfQMOgTp3jVBL5wXE6Y
 2IRMDNude6Oo/5ma+cQILQUd/e3dsZhqstmDuvkywMaFB1tcnr2PEWZs/wnwP/wlWJQJ
 FPNGIX0EXudvaKCfIKvH+wKDRJ0E4X83shtgnVis2e9uOtZbFvPcpL//SWuqv8qYuhqw
 QANrip0E83yY9MVLmBdts5s96nAwbgnBaenXn9+MpFYPtttyBvQw5buNmggvVokrbV0L
 tYRp5zvC3uRwWv6aRK1tTxg49XKaqKY/8ephOLfcrCHEdBNtagaFUw/nr5zMgOlc0o57
 soZw==
X-Gm-Message-State: AFq9FYK7C1SMarhoG/9RNN2UGtLfhyN50GkeOn8GKEj3NUw2eZncI8H+
 uksQkDrJXmo0kyB2vkKcY3ctumEiSPCE0UxtQKcFlHhEGdCds9iMu3khQUCux+FAMs7rLp16pbX
 71gpPMXdP9tYpsSmURNbpikFqGBElb4wbAxGQi+xtCYPMK+i4R1INjk9cWRo4Tp7owJIZ
X-Gm-Gg: AYBFou2owSfB0RcqE25LgKIN8DwGofWuIJQqHa0VsIZGUnOvYVohrsQ5k47NSSadscb
 m0wn3Ro+NFmKAzBU12F//8w3JwWNYAEWMMLwTOSQJQqcqMGRCM/7IznrCLZlp6Wv3TuL0TfgiQo
 +6wUKOtUMqtFzcy2fMGfYO3zC569f4m6VC8R9mKWenlCpMWKeXsBH2CRfW5ifGZLlZLS/eJvfZL
 /gLph6hRhcuvmfgC3pfvjL5NwrKYT5sb9aF0XckVBlXSMQ1WykB5uboLmgD2ZxRwJZUTX+H+/nm
 JizL+I3gcdhQJYB21LoaAlh6Ns8zCoK+9gp2p01mVCTaHEAE+RhN4gKT1QmOHSQQb74YPcw1GcE
 ewFAMDcPIH5toZYPEH0yK6+T/4YJAVcLEi214fX7n
X-Received: by 2002:a05:620a:439e:b0:93f:1cd7:734b with SMTP id
 af79cd13be357-93f6f796974mr485611085a.34.1792772433923; 
 Fri, 23 Oct 2026 09:20:33 -0700 (PDT)
X-Received: by 2002:a05:620a:439e:b0:93f:1cd7:734b with SMTP id
 af79cd13be357-93f6f796974mr485603285a.34.1792772433149; 
 Fri, 23 Oct 2026 09:20:33 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d42b275sm917818f8f.55.2026.10.23.09.20.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:20:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 58/83] target/alpha: Record masked exceptions in FPCR for /S
 insns
Date: Fri, 23 Oct 2026 18:13:06 +0200
Message-ID: <20261023161332.60153-59-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX3DLQ3VsJ/MfS
 A1aSWx/eCe5WWjAKgS2oihn/Uk36s93PT+JmbDP3vxC3PPhHPokXqcDUD7iUITRmypW3775cTpJ
 PzBNtweBtoe4T6wHM8nD8gNF3bOxXq/07G/LIYMETx+QxPyeg9JxthCtCZlaM2JGVZraF7yEYNB
 x+jpEHiH1jBNVh93+xHqf5PXEXpi4BKutLooPqGIiwYHVYLyWF/wC2Cz40TRMkyP5vQUcyqk4rm
 HOewkr4k1JxaSYjsst5n4Tz60XWMM5MzP3rwbV9lfJHau35nqFzSMyPs1vsYfjXyaBt1oLCGCYR
 3Tx6NFEg4oa3RC6xZRu/ix+VCRACvM6laWN8uzK0uqn1gCOOV/6Yimmf6k7lgMSrZta//ul0ncB
 TRQoSxk8KonVSo8hbdDDYsl5LnXSSI6JwTVKbz19oe+7EV1r3cqfGNY6Ss8aQ2CXazTXOXTX5tF
 ynV0oMCkhtu4rtlu+Fg==
X-Proofpoint-ORIG-GUID: y1AqgYsH4DAiY1QxKHtsLyRqGgcaDRHB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX9Xq+MYGOnjbD
 FwYumgbxbpzy6U05wCOzrIDP+Gm3QraR5fiFtQ50veeVsGfocBJFCo+EDT33FbzeuluBN8Sbp37
 1nw0UlTjhKLi4C5E7KrXIva1IVPZEIc=
X-Proofpoint-GUID: y1AqgYsH4DAiY1QxKHtsLyRqGgcaDRHB
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb8953 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=jx90jitu5bfcP4pVPFUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
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

From: Matt Turner <mattst88@gmail.com>

The trap qualifiers (/U, /V, /I) control whether an exception traps,
but EV6 still records every exception in the FPCR status bits.  Commit
471d493047 ("target-alpha: Set fpcr_exc_status even for disabled
exceptions") made helper_fp_exc_raise follow this, but in
helper_fp_exc_raise_s it only added a second "exc &= ~ignore" and left
the mask in the initializer, so for insns with software completion the
masked exceptions still never reached env->fpcr.

The most visible effect is on inexact: the IEEE-mode code generated by
gcc -mieee (e.g. ADDT/SU, DIVT/SUD) has no /I qualifier, so FE_INEXACT
was never set.  Many of glibc's math tests fail because of that, and
the narrowing functions such as f32addf64 return results 1ulp off
because their round-to-odd step depends on inexact.

Record all exceptions first and only then apply the ignore mask, as
helper_fp_exc_raise does.  Which exceptions trap is unchanged.

Fixes: 471d493047 ("target-alpha: Set fpcr_exc_status even for disabled exceptions")
Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261016-alpha-fpcr-status-s-v2-1-4719bec02b3b@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/alpha/fpu_helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 529eadca9f2..643ce641e83 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -86,9 +86,17 @@ void helper_fp_exc_raise(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
 /* Raise exceptions for ieee fp insns with software completion.  */
 void helper_fp_exc_raise_s(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
 {
-    uint32_t exc = env->error_code & ~ignore;
+    uint32_t exc = env->error_code;
     if (exc) {
+        /*
+         * The qualifiers can suppress the raising of exceptions,
+         * but real hardware still records that they occurred.
+         */
         env->fpcr |= exc;
+        exc &= ~ignore;
+        if (!exc) {
+            return;
+        }
         exc &= env->fpcr_exc_enable;
         /*
          * In system mode, the software handler gets invoked
-- 
2.55.0


