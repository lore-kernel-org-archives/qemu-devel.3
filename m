Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A8FC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhjb-00083W-CQ; Wed, 19 Aug 2026 10:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjA-0007w5-TJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhj9-0000Vi-Ff
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:16 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbtG4909043
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tIBdeUm/Geiqpku6GpbK+H1wz9UlnhN9i1p8xodXuro=; b=kEbvODjjgpra+cVn
 U4pvZneTFG6wARxvJCvRLmCQkq85RWAjqVH9T1LnSt4tIY3lNATUvPnS3i/8TPYs
 ndk/6l7/A3YyAXCwF9PgX1ZHO8ze2Nt6pywkK+EawZX6sMnjssLclvtXXMqAhR1F
 L83yduGDN3UZwg3gXg9TdQIEPNCpMoQU1ZcScZJS388cg/jbe8XWF36aowmgLxpT
 0A/PMjlq2p61VG3505eLZVQwoEfBfCgsWYXFT6Ccnz/800ryqhyf4p3HkdwBite/
 DP2NJJskNjffgAOJF0hAHTcpK+tJ0svVgqwAn9NXPo5MDT/SQ67t+QNtDU2PeT/B
 qxn1/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmbt54-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so153320385a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787151433; x=1787756233; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tIBdeUm/Geiqpku6GpbK+H1wz9UlnhN9i1p8xodXuro=;
 b=NgDUvH4ZytFPh9Lsovf/wbkA/agLldkUnlKVI6x2WeqBUXUnlzYJfxZ5G6vAN1SbbC
 l5Ja0FdGBfLbeyTRiF77tpEQl4rYC63ktZIWciqP4TOQ+8GIkwMOQwUqKccCkAk6v6Sh
 4srrH2zh6pGCN3kRfZDBxXFOOwdFVVkGTmOOwKukcQ3DGTH3zrB2lZ72kcRSjHrnefN5
 QgBJSLDFX67EJTCOmMQvLTQD4JvnADYsX2OXAZKc8Bew3f0Cp7P8nSJy5Sr+A7xtouma
 VPWnM9bZCR/WVM6diOrECKzlx9Fsd1pjW/xfousLYcI4BPL3H1uTVxZI9SCM180YOvXX
 OjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151433; x=1787756233;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tIBdeUm/Geiqpku6GpbK+H1wz9UlnhN9i1p8xodXuro=;
 b=kMuf2gTHpU5vYgH399k2GFeBUHwqIaJ7yU8h3CULfvJmj3/apCTV65MNkKAQiNd0nj
 5JK4LBWvgaaz/d6y26l9qSHs6Ug1aX5VXSZzEbrL5MkVKl4nfWDhes0rZ3jF3ySDsHM6
 rvkSJnmkLWQt2JK++WixnjQBsFTHvE7tS5yU4hTyZFbnILnXfrGJ+PPJsFI8X5W5VEgF
 Ng549rfYs6lZtOTYj4gLyw0S4zB74xfU7Pp4HOxnlwHeyD+orAtUAxRu0ZwTJhGCrI/q
 Nop65etqKFi7jaJcFHerfICXKceMaGjti7vbX0EzNNfb4I4G9n41o+M+JcqyIbpqcURk
 EqKg==
X-Gm-Message-State: AOJu0Yya/wJslvPd3UmZkJkhEeUjwAfMi0Ys+p7cmk+glR04lDRfvpCi
 rSE0zfzKUNKyhnTDQo4iavsZbXMZam8kq+21hcPR7gtMpQgAsQS3X+olBReJSVspI6i5l/4VeiA
 By/zqYnmOS6o2gJHnv8VBFkysKwbWrFKqM7ZcR8lFqzBYO4jBtWcgGAaGgo7sJXCICQ3B
X-Gm-Gg: AR+sD121ihACpb5/TWoscHKgtAmwEDdyEOJK8kNKPGMmrjOhiajUttszUIQTboJ61X5
 z1X84hS/q/D+sO3J0nkJTGQFoXiWbkxlGOjrxnL9V13y4lBshJ+Xp5HUD1voWeCFgNVyrVp12CC
 P8sB/eWBCSU2dle2SZ0Ithzw0FW4EmcYGEZFIZjPAgfUJb1r5xDbZKHBO+J+YvlnKaClkAoPVzD
 RxJAqsGxl68gkrC4H4Pr3jfVVpR7YIzplbxo5QqkgIuF+28lvm/pnUuR7As2TzSfFwmgWU0dwez
 PnJPFTQxrZ3Ag17PMFqyJI0pqgwaUTsUmRFYwiC6fHa6IXkJk1HBZWCR3RzV3GO7ujS8dYUAFks
 Qq/DGhFiI5mh5H0z043Frt5lQ7RedqAfPeUfPo1q51g==
X-Received: by 2002:a05:620a:4594:b0:936:f984:bbb4 with SMTP id
 af79cd13be357-9371e2cfc85mr415894185a.3.1787151433029; 
 Wed, 19 Aug 2026 07:57:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4594:b0:936:f984:bbb4 with SMTP id
 af79cd13be357-9371e2cfc85mr415890985a.3.1787151432639; 
 Wed, 19 Aug 2026 07:57:12 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa09b199sm58981715e9.0.2026.08.19.07.57.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Aug 2026 07:57:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 03/11] accel/tcg: Check %halted field in cpu_handle_halt()
 caller
Date: Wed, 19 Aug 2026 16:56:41 +0200
Message-ID: <20260819145649.23439-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145649.23439-1-philmd@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jztOiEC-pnNnFQdN7Ib8PypPdbsn1NHw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX7h2rBUfzYsju
 xAJtFxDWUgOlcxn5zzgsRDCV+0/IxKcNtrFA9syoPxLfvrKyWrQmQuwLKJA5yreOV/TDArltDAB
 vnAt5EpK9pmgBFGMsqvvonZVypCrg5I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfXz6IwZn6gSK4d
 SyyVd/rqOmmYaWKSjb0600X9E9tEd9VjX/7q2FNna5/220CocJ/f98uehcpStQkzV2nJMefONaJ
 mHyfTuQILDEvDX/1oAOrlw8rQkMtyn5r6G3Rv6LxIJzFZbWjIEpoCq+L2JWvxdYCDQCNQv7O1iU
 vC6xPec5iH75iljwuvHUAKawW0yPO4rRcmABXqhqFC1xIFh8vsIV7QUko3mcar8zvOnj6tcbDRc
 v14PCHcHBg5sFVfs9gYsBlr66SHphOLhJbuIN25B/lMPdJI//0lI9g6EZQG6enXJ0DfzG7VHpLM
 XqVDDfuyyjQ8PW3pumfo8PZDNqKQgLTRFNUqS37vJNjWufLwqa04UeMjLu8q6gVS6ysp9o/+2hg
 D3oTFZk4An8Eae7QWqahTJroruQw++z9IQi9ETpZ2rHjf2tnNHE52h9l/IvSUCN4cGI9c+6CJl+
 bPO0J6VYxUvplhLAMsA==
X-Authority-Analysis: v=2.4 cv=aNrAb79m c=1 sm=1 tr=0 ts=6a85c449 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=kT6ZeTLHU-YqpJqovYkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: jztOiEC-pnNnFQdN7Ib8PypPdbsn1NHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190116
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

In cpu_exec(), check CPUState::halted field early before
calling cpu_handle_halt(). The logic is the same but allow
to simplify the async event processing hooks that will be
added in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/cpu-exec.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 69207301d1d..46b723cb734 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -656,17 +656,15 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
 #ifndef CONFIG_USER_ONLY
 static inline bool cpu_handle_halt(CPUState *cpu)
 {
-    if (cpu->halted) {
-        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-        bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+    bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
 
-        if (!leave_halt) {
-            return true;
-        }
-
-        cpu->halted = 0;
+    if (!leave_halt) {
+        return true;
     }
 
+    cpu->halted = 0; /* allow execution */
+
     return false;
 }
 #endif /* !CONFIG_USER_ONLY */
@@ -1028,8 +1026,11 @@ int cpu_exec(CPUState *cpu)
     current_cpu = cpu;
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu_handle_halt(cpu)) {
-        return EXCP_HALTED;
+    if (cpu->halted) {
+        if (cpu_handle_halt(cpu)) {
+            return EXCP_HALTED;
+        }
+        assert(!cpu->halted);
     }
 #endif
 
-- 
2.53.0


