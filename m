Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F416CC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Xd-00007k-0S; Fri, 28 Aug 2026 18:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XY-0008VS-3G
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XU-0005iM-Ms
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMU9Fw3187524
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ddmkLQUBU7610s3nOY6qaWJHlMmjo6pQmB3fm52mVWM=; b=bOhpEwI3UGbYwi0P
 S9U3Ejh4haZYuaRmHR34BvPhGbV8JNTrUtiKqTZIBBte+0fnURlm7pKJJXSuJ6ri
 wN3oyX06l+SuhQ6+5G9RKyGtXBpFW8nJCE0/wOdi4Y10fnpMiqjsJpo/fg+ZZHX5
 OMRydm2fz++cbA+9baixh4S5Vvw8G8nEiZMQ7OKACST1MVuBxytp/pW/pVBzTKUW
 qgGtf7sZx4uhQgvKC6YqQfriY7IMeCgyD5IwViQUrB8+L9snctYaRB/nP89Pfnnj
 arfbv1vbSdGn5rbUqWrKvd5INaT8+3V6kHuUbjl1hHTsV3UbyLKKTQIBGjp+ariR
 uyoPfA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbag9t2q2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so2206757a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957948; x=1788562748; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ddmkLQUBU7610s3nOY6qaWJHlMmjo6pQmB3fm52mVWM=;
 b=ZVVYJOHhsMQK763Ri4uLU+0KMZct77AcAJ7e5PAMegnjKkUtBi/gOEa5YULU8TDmKR
 QBf1OUzJ9XrRADZDfmM386j6TlgHu57SfMsdIblyM5NBWuLtxFQEJAV6dyE2ZuRkRrIT
 3PJNsSYvkEwOy04jPIv0Npkcc1Y7DEu8evUEWSrMNk7mryuTonK2uta2QImpghMHbu2d
 bpLHXYTzaVebVjy+luVGhw1FP95dQLP5JP/8f4UQ4GQi50eMUBZnlxrveEPPJmleOUUd
 8MBBqJSYvvej4qqgE1oCoDcP+CX9cja9obJczh1adae3z6OQDRMGOH+8mrjA/0t07Cm7
 xbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957948; x=1788562748;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ddmkLQUBU7610s3nOY6qaWJHlMmjo6pQmB3fm52mVWM=;
 b=SK4wgti7jmAtqXHmIGI7YDF1Jra75epuKn7+p70jzfikjq4Ka8+pmhpS7Dir+C3QmV
 C0QHyyhSJ/G02zTuxH+SMYBXMDuJ9d61A2hqe2Or1QZg4lDYhWWAsWLiNgdlDbxpSHfR
 EWV9r+/AOcBWRWrDJDjniTmTl6QGcJXtPtPCE4rJ9iwiDvueuWi63uwFLmkI983+7rfH
 3TvjUCC2EMmUSjF6bacicbvbR0AUdP6FfEGDzBa/0R+r2FD7fewlbhFq7yo7h+4Bth2o
 pI3/+bke0/McDhU2INj9Xm+aUCe88CC1EDr9jWay6p8K3NRw46TKekdQWOqMcHhLJkjF
 G9SQ==
X-Gm-Message-State: AFuF++na3aeuC3ptRxM+23LGfkNtD8mQSJYjdwrmF6riMQ7834RqvB3T
 UhoUufjQ97q7aN0L3kmGydqY4VmtV+2QpDC8QwDFN/OfzXlCoztcNNcdzkpjgNzKFebo0OPI/qJ
 I5lJnxCC8ysjyfQyANS4ne/1rFjjFRimfmqGYfLshMIqFVAl2m3zLuFw7L6UwlyNImg==
X-Gm-Gg: AYBFou0fxgZC/l+K+nwtdkWrz0TUMsBIyQGAgiVW1b11wR6Mhg2jPeBmMieWpt1ZPoa
 3HXUuMnz3V3v2X2kwO3mxFYuJfkJNbb96fUFgWpZe6ARAzn08gFWEMWPgkEEeGhEaGQ4DZ5su2v
 nnFClasu0HS+bGqEJH6cdxkLOL0xrKzxi7oXDxelab7Q9WA3OEWTI20L/fccI2iFAOjKOo7XHHT
 l8UNNC54qWGMeQKbfsY4MV/XPWlgh5U9oaLLVlRdSZ5A87voLLe9Tc2+5XTuGdgl8CdY9r4xUlT
 pR6EosSw3yU22MrhYCqGkTIlXpoSxPcNEbVnK3hl13V1gOfFyQXtyZcpPjmeLy0o2FdBuR77bbU
 KfrO9ZzV0ma2Q4pDVCXufQ7XNNgBVO1ScsCHKJZJkb+xUXPtUSAFtkPeIj5E=
X-Received: by 2002:a17:90b:48c5:b0:398:9be9:ab8c with SMTP id
 98e67ed59e1d1-3989be9ac97mr4464210a91.17.1787957948386; 
 Fri, 28 Aug 2026 15:59:08 -0700 (PDT)
X-Received: by 2002:a17:90b:48c5:b0:398:9be9:ab8c with SMTP id
 98e67ed59e1d1-3989be9ac97mr4464168a91.17.1787957947970; 
 Fri, 28 Aug 2026 15:59:07 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 03/47] target/arm: Rename and adjust aarch32_max_v8_tcg_initfn
Date: Fri, 28 Aug 2026 22:58:17 +0000
Message-ID: <20260828225901.367438-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UalhjqSN c=1 sm=1 tr=0 ts=6a9212bd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=rPU-NYjvpPHPYHSWSY0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXzXqwF1MlHNi1
 MVYiko0wdMFgxGaa/WEsxv2Tl2oldGcnXUA215i/u6qLTahTfIiyH+f+v+EYIJk1aQ1Z2GlA2zU
 c+86aSWWugOYLgn0QIgdSWz5njdLvIU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX0vR1LSyr6g30
 JinV1NtRMZ2zKvjb5seJV9pFjPG+GCKDYxZFu/VP8vaOakpaJ3bRxlpDdsZLfHNe6xJLTlApSgt
 H5Xbsmi+T1VwR+C7Je9hHGFcN04pyoa+d8XGAnRXc29t8wEKqohC4QmEx2P4VGgZmNUNS6yt7Tt
 CFnQJ+mGEDRnAV7vMNH9pwzWrka6rhEL64lIsHH/22Diueep4HqphIj0TJyn8Lhg+y44D1rYJ9X
 LmIvTy2JaNEA+dG1MfWS1ZJgk+GmvxNJlFAp5owI9Bs6RekmmbFvi+1pFJ4ZMuPbHEf8FH/ilTi
 GoNuAFWvoC3a88sNiOoIy9SEq7OvpxgGmYKNqZBdiKVvdicV4tGWyUpElVdpkWejBWsrcc33F/B
 oChKK/zqvyZVu9ggTyfGW5NoaCzkwYbNhbx+1yfZ/poOUlPD/8dOf0RCbEiQBuZxnG7npp/BCJl
 qh/PGi5vu1TDTwBjapw==
X-Proofpoint-ORIG-GUID: RcIEA9uSeLNa1puM42DEVjnzVq8NFNjh
X-Proofpoint-GUID: RcIEA9uSeLNa1puM42DEVjnzVq8NFNjh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Rename from aarch32_max_tcg_init and take an Object pointer,
in preparation from being used with TypeInit.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/cpu-max.c        | 2 +-
 target/arm/internals.h      | 2 +-
 target/arm/tcg/cpu-max-v8.c | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 4df52bcb08e..9ed45c8764f 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -108,7 +108,7 @@ static void cpu_max_initfn(Object *obj)
 
     if (tcg_enabled()) {
         if (!aarch64_enabled) {
-            aarch32_max_tcg_init(cpu);
+            aarch32_max_v8_tcg_initfn(obj);
         } else {
             aarch64_max_tcg_initfn(obj);
         }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f6b4e173a54..fc7d5ad6f2c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1838,7 +1838,7 @@ uint32_t *arm_v7m_get_sp_ptr(CPUARMState *env, bool secure,
 bool el_is_in_host(CPUARMState *env, int el);
 
 void aa32_max_features(ARMCPU *cpu);
-void aarch32_max_tcg_init(ARMCPU *cpu);
+void aarch32_max_v8_tcg_initfn(Object *obj);
 int exception_target_el(CPUARMState *env);
 bool arm_singlestep_active(CPUARMState *env);
 bool arm_generate_debug_exceptions(CPUARMState *env);
diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
index 5c0ba28edf8..5a9845d88f3 100644
--- a/target/arm/tcg/cpu-max-v8.c
+++ b/target/arm/tcg/cpu-max-v8.c
@@ -101,8 +101,10 @@ void aa32_max_features(ARMCPU *cpu)
     FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
 }
 
-void aarch32_max_tcg_init(ARMCPU *cpu)
+void aarch32_max_v8_tcg_initfn(Object *obj)
 {
+    ARMCPU *cpu = ARM_CPU(obj);
+
     aarch64_aa32_a57_init(cpu, false);
     aa32_max_features(cpu);
 #ifdef CONFIG_USER_ONLY
-- 
2.43.0


