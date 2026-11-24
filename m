Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D37606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UdIYEwi2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=csebHLap
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzw4-0001M5-4c; Tue, 24 Nov 2026 18:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzve-00011v-VE
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:11 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvc-0007do-9D
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:02 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMaekN2139924
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7gYsIXwTaszQcpOyy4otxYDosMLoNMInMcKGYLuPU5A=; b=UdIYEwi2wUfKxtWp
 7IVJDU6MuC+wYW1oRWF9RUJuedyo81tGgTASVtucmes4Z+kxi6T9k+gylBO2+BfT
 eQyHKjUaJiFH4nRJwvDX98SbQenbyUTUpn/SYadDf1mSPr6S4tDFcGLUvCFjj7IZ
 scSwsZcfmT7TG9zoy2sFFZdpxZ0EgBbLtba0Izdo+AsKcTXZXphcnOFP/3SzPw/9
 V3ILrgzjHGsQ90AdKnxlXoE+MoRP2CU+UEg7Sx6QO6rxMYref/+p/lorAvO0+3Bb
 tLv9HMLl4lmAZJ1uzzmcpXvsXAZgP7bzUWUfdagaawezvt/7jR4+rHdgq33qTo7S
 xtohDA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gns8sdn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:27:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94960bd17b5so838756485a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562870; x=1796167670; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7gYsIXwTaszQcpOyy4otxYDosMLoNMInMcKGYLuPU5A=;
 b=csebHLapg8Br+Gxu0uXWUguPp+cPdmDwzJBsq20ssnwdtpKguzL8+CbC3Ghi9WadQR
 4vop4dvlFYLt9jNy4tmHHvoZPnqh8FBcsdqZRagvA1Xn1w80ZA0tksPXSkDM2ozwEGwe
 ixPG05vYPfK0kLOycwmF7JYmk71zLLIJCaToteJNOCOAggmhyJc4MPgK/uN4AI/9xx//
 b3lgE5LrCaG6ZT15BN71F8LCYluykpn39tJbfmhTxzaugi4D3eq1kJBFTfeCTH4BHK/C
 vCKqLYH+/o8KPQu0OGIrMauPAdDaD4QpYZ9HaNtm44JWEJ7HmQqsjFwrtTV7QfSb3/vZ
 88kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562870; x=1796167670;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7gYsIXwTaszQcpOyy4otxYDosMLoNMInMcKGYLuPU5A=;
 b=xqjWA/RQSyf2WhROKX2/iSC3IItb49FLXLdjncMgSACGNjEvtZRjvCn4HLHHYhoyv9
 kp6x+PwB1ijXCKd/pb4KqGz09EWOmHdA1fgJZOzTwO+kN+bg2IfQUHl/bLeXDZppbjA+
 0QqfuBt1PC7BrBxdjLkH3vBsqfAzTZ42UKjLptPPIdMAQPIL+MtQ5xdtp8oBQpyn9dR/
 pFAGYcRvPS0Y217c89BHEKuvMn3QTTjS25dV7heKw+/y/rDMjdOMJyu2psKAdaN0zspP
 DnymwyFb0jNvbZAilctsjqU/oewLWI6OZV+NycWLIBQTDVac3KjqgYQxLr9/8YCPwHno
 /Fww==
X-Gm-Message-State: APuU4Z8hQ8JF5Y+KYehh9m1j1jkO1s/ssI6tNg5NVnBp+kuA72m8m1bC
 2KsrYabHO763h+w6wjlB27vjgi/xNCMRFhlhljlG5fV7CfkCdMonbYdE9U6+kp4qJTzh0VeW8QH
 R2RQXHuCfC5y2Rh943nP/lkxfomG3YGo/gGWzGpXhqcTEe0REUBcfMNFSsPgr68O8s3e2
X-Gm-Gg: AZFdTZfr16QJ9t43rFqwZXtfVYHTjCIh74yeNQ08RDcs6BZyX6091ZyM+ahFNRNFqwt
 ajfRHL8Cm+iUpZ0f4cnyZ9fbfI+Sx66sw5A+AIO7Ml2gNmNGU/FG/pPu/lCnsQ2JmLqEVS7CCDc
 +PjIKt4cSSloeQ4r3Wt9LOpD2g1lt0/H4O6zBljHBTPBdMUcTJRZ0Xpyf7KnKoFxHjtWYd8R94R
 CMaKJp7PjwlU/6IVrh3l2GU8qR8lJZ7UjbKiFKL3rOOSQihmkOY5eO21R/NhHMATKnVXAoEttH5
 PC6DYsZr7f6Bxfwh1Y5wUFWtLMGsAUhL/qWkus/JQjhc9uC2iru/K4wRtVet/Ai3bWJy2gFfMhO
 CnGBZmmcWvA7cmF41cPIINZfCpmW12bs9zZ8Z/j7FwBpHIw+R5H8rUa1PINWlV+wWZbVBSaTPLp
 oXCoVQTqAxns8zLw==
X-Received: by 2002:a05:620a:8812:b0:949:78c0:e186 with SMTP id
 af79cd13be357-949ba95de77mr2704337985a.25.1795562869597; 
 Tue, 24 Nov 2026 15:27:49 -0800 (PST)
X-Received: by 2002:a05:620a:8812:b0:949:78c0:e186 with SMTP id
 af79cd13be357-949ba95de77mr2704334885a.25.1795562869113; 
 Tue, 24 Nov 2026 15:27:49 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm380647295e9.0.2026.11.24.15.27.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:27:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/18] target/arm: Kick other vCPUs on SEV under TCG round-robin
Date: Wed, 25 Nov 2026 00:27:07 +0100
Message-ID: <20261124232722.90234-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZEP3AjnGj9d0a5QsjKfgUMc_WOmQszUi
X-Authority-Analysis: v=2.4 cv=G+SJgNk5 c=1 sm=1 tr=0 ts=6b061d76 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX/Cd5qLXrmZPW
 cZzoZ66XWcx0VhFo2jspcR6yh7eKQfJgqMLAsYMl3tXJn6Xe6ivhF6Lob6DYkG7vVhQ7/TbOvTr
 fGyqyOfP9cPgCC3i4s0H6faRWifP9/g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfXzVrWdE7CyTzG
 TkRPiSGjMfXrtzalyVUymNfuJ4UIOVVLHrLJQ6QtwQFPFmcdtWcpFqkzCk4ltUiYetL++QuOaDL
 LCglAQ6XUmJ4MhaD5johLp/q0v6UXv2yM08YgbafHLeEiHn+ggOGmmAa/sXKF/4VHgINTCWwxD4
 UvfIkbclGpjdJ5x7TPBEooRqM803fD0DxH5/kkOpeC03w4GPN3urEcd3kvVWO2e1W0lghiEAsy8
 Gj9OoWvBf8Kw3Tq5EGYZu9seXe1uD+FkMHx72j5lgJtBZTrpLmCXvP8pp9Ynhm3XmHq9sfm/B9f
 5QEp4+q33W8+o4TxHXomGAlkAhyJnbc0N9qFyXn9NtYJgQjpxQPKdfoUPLkY1P3k73LGnAwJ07e
 Nd4n3t3WMWe0BS2/Hswd1j4JbIVlfP0MuRH9bDGPJeoG4WWQffIvxjYuU1+hyKtJEBCerrb86y7
 8JpMab9JUN6d1/8DvJQ==
X-Proofpoint-ORIG-GUID: ZEP3AjnGj9d0a5QsjKfgUMc_WOmQszUi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240092
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

In round-robin (single-thread) TCG, all vCPUs share one
host thread, so qemu_cpu_is_self() is true for every vCPU.

The SEV helper used it to skip the kick of the issuing vCPU,
and so skipped it for every other vCPU too: a vCPU sleeping
in WFE is only woken when the RR kick timer fires.

Compare against the issuing vCPU instead.

Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261119225514.4080-5-philmd@oss.qualcomm.com>
---
 target/arm/tcg/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index a862b9eb02da..c2fdad7411db 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -470,14 +470,14 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 
 void HELPER(sev)(CPUARMState *env)
 {
-    CPUState *cs;
+    CPUState *self = env_cpu(env), *cs;
 
     BQL_LOCK_GUARD();
 
     CPU_FOREACH(cs) {
         ARMCPU *target_cpu = ARM_CPU(cs);
         target_cpu->env.event_register = true;
-        if (!qemu_cpu_is_self(cs)) {
+        if (cs != self) {
             qemu_cpu_kick(cs);
         }
     }
-- 
2.55.0


