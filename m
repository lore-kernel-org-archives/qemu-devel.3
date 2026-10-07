Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED5CCA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEazg-0007sl-SB; Wed, 07 Oct 2026 19:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEaze-0007rR-70
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:24:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEazb-0001Oo-8s
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:24:13 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697Lu4D8626311
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 23:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kiFRfa1vn1nAsyqHzl2RG/M+r+e4c9+WlXmnF6qfFAk=; b=PJ8NbanocVGIVUqb
 cE7J31UG1Iz/vqCjjOSqHuyLJkEYZ++NV4veKF8ZjK0+DjXX+jBAgv0+UuJs2Zei
 OGoB12sRV7Tbnu4XX0U10kMJSZPljxMvREhgPBJHCoJzuFc7Gv6m8gGFVD7fHNjv
 JBXHaSfHkT3cyUXNW6LDLPZ9GwlTq0XOz200zw7Cs/EF8GRPZ2ONfEg3wbQfOJV4
 kwxI9OhT1O8QexGAlsU5908LmMev4XYUjZAIYisybxq5BB6uuVa2wZNQjHq6jj13
 xK2v3y6ANnBLRtLoMbO28gWRP3vcnTdDZaURD0lvui6poQtv+KLEEu5iV1zpx4SN
 Hr5U+A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3gc6n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 23:24:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93bf4c0af4eso93665885a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791415450; x=1792020250; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kiFRfa1vn1nAsyqHzl2RG/M+r+e4c9+WlXmnF6qfFAk=;
 b=fTYcKRiHV36gAOxac/o5gnCg6jraAIeuZf0lE0ekRSiF20227NA3SF3R9miVlgjV0+
 ZJ4CGY/ugbdijEszJLqs+mAZlp6FNyokI14o0lnuuK2WnqwuhU0qmiy+te+Zde7bkCWx
 LKe8Cbi/ZXnqacvMsG5GF1xHDbtBIcFqldo4Qps3z4a9JGDnwZToCAzohXFs3nfLQAA5
 ao+0jEveY+vs4UGSuI5KGJivg7eAkSz/RhmgKA2kWKX0LQhYBhYojSOSu7N3906zQad0
 zU3wXONrd0hryo3Ysk65pqSPSrpbV33yQZaOMrISvFuFkJUn8wpzU9uGMmeOywXOJrco
 1fNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791415450; x=1792020250;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kiFRfa1vn1nAsyqHzl2RG/M+r+e4c9+WlXmnF6qfFAk=;
 b=2bKxQ0ZOc5RxC6NxNJC1VM9tD5ZGisbJSCJ47aLcQoAtZ546D82EO3EEUzzKeB+aJ2
 IHB0ai8VW58D4f9x+7VCSjewgrQSDfMJVyQQfNHAGRtGCazPYKub3GKSPyILZbFR12Xd
 +O5lLi3QQr9fz07LL1u1ODbzpiVwT8IxsW+YYF+TiCm+iNqT7S92K4DuUilEXqL+ibvl
 CJ11qZd2QX6sULNvaO6/m7wJKmp3TPae5v/+tie8D6wAamIRWcjv13ck9FlRr5pgUqzb
 tEfbyhI1M8SZaGaiv1jAJm8wUN+DMAYdmovh9KtfmO2MApFNsCc9mx8faKt8zaa4avBc
 SwGw==
X-Gm-Message-State: AFuF++ljq4/TcxD7jTvRC/aGDu7s84zpXEJ6lVcTZrVa+K/iJ+KqDaC/
 nOxwgdmoxMCX3hQFi5AZJ08C0y1UKA5WZNNSbEnlDjpWpjuVPvp5/zmfgrdSSiRrfebqXY2sSNl
 pPNyb6xOyM52jADAB3vdhzceQ6C5utOoQ1H28ZH0im1O5XnVOXcawIusw1T2bSidEjqyx
X-Gm-Gg: AYBFou0gce2yJrIP+oPYWSqaSkAa1yerOxjK7DEbU35pwtZujJQ91JTptQnF7pX9jPs
 GjuctPZEIAhS+lv/LPGEVLyGOeEnT/BMlOpQCVXNmvF5ZUN3Ag0PYRGcF3chLSolQGwjFAXtUDo
 xAa5/jYGPqc+d7O1df5vpxQ4MFMWSrXUpYvB/9hIBEZ9rF6WFRAERfGA0O/zwlfkW1U+Wcu58rX
 +4jv4yv2lUlzm+/yCXBRoN2XmvvmXnndSIYJKkdrddgvgj3ejJ8ZN4MyCPpEdobH8Tc8PWNtgxn
 woHForDFvHJElEL3475H/oLj9avX3zm5FXkRBLLXiCExRDWPMbn7f6jxUwfYsacWF0R7sPYoKCE
 gePZJJm5rmhJzd05F1wTEdF17O4FPNKykB0f9X9kB
X-Received: by 2002:a05:620a:880f:b0:93e:5677:317b with SMTP id
 af79cd13be357-93eab120455mr135400785a.25.1791415449507; 
 Wed, 07 Oct 2026 16:24:09 -0700 (PDT)
X-Received: by 2002:a05:620a:880f:b0:93e:5677:317b with SMTP id
 af79cd13be357-93eab120455mr135396785a.25.1791415449037; 
 Wed, 07 Oct 2026 16:24:09 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d1f8fbsm7145472f8f.33.2026.10.07.16.24.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 16:24:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 05/10] target/ppc/gdbstub: Replace target_long_bits() by
 ppc_env_is_64bit()
Date: Thu,  8 Oct 2026 01:23:20 +0200
Message-ID: <20261007232326.66240-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007232326.66240-1-philmd@oss.qualcomm.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX+Dx2sXcafLhu
 zdQd8854lT90ynYYiOLsy+49SNUkr8UQN65hOiuQqrUtQjMEePMkcg2i890bqsDxql1M4E0enJJ
 FTP6sTi8UFId8xKzfFAXND7vJjxXxxY=
X-Proofpoint-ORIG-GUID: 1uPqIFMuwMMKoBDSI4zaISwyqz1jUZXT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX5YD7c5HvVt8m
 OFv4nKzD1Axi4giSYcGD/u0QmmBclpAfGVvVgmsh+lf8qfdeJRtKL+cJmrRhi6lUO4zcgsK+5mu
 8YHHodXZjCjfTdlge1AIfCa/eYLqZgpf1qhdzq/XSvkHMbsrCIC7rOHKyJZMLKJjD6j9EZ4BkDU
 n4ZQ8fzeg1qHtTyKd0IMIjsLjM9n/A9BS37SpWdPC5K4PIC6YwA3zjhg4ZLT5peQGjuxE5nEhc4
 5fKv2kGbNVXIC9eR0R1RxGOXuQ31LAgMiR97Bb2P6l71YIc+KzmIpNr4XwQkrI79KaWcH7FvSu1
 v8kZg4YWqZuNVWUXFPoMH1AHar8V24kMkMDdIAzXh/7teGZzB5NrajaJKxaFyLKEbFb553MshvV
 unfHtKrKVxutq2/s56ykbhXOEd9qOX9wEGz7aFyO5eJx4zPsJT62f7+pOMahzrq3r+NtGsHb9Xo
 AqZJQgaJwGPxJiVyitA==
X-Authority-Analysis: v=2.4 cv=IIuXmQvG c=1 sm=1 tr=0 ts=6ac6d49a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ECGyvcmLiFpczC5RLToA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 1uPqIFMuwMMKoBDSI4zaISwyqz1jUZXT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Add a gdb_get_reg_bits() helper deriving the register width from
ppc_env_is_64bit(), and use it instead of target_long_bits() and
TARGET_LONG_SIZE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/ppc/gdbstub.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 4d622c5cad5..ee02be63ce8 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -23,12 +23,17 @@
 #include "gdbstub/helpers.h"
 #include "internal.h"
 
-static unsigned ppc_gdb_register_len(int n)
+static int gdb_get_reg_bits(const CPUPPCState *env)
+{
+    return ppc_env_is_64bit(env) ? 64 : 32;
+}
+
+static unsigned ppc_gdb_register_len(const CPUPPCState *env, int n)
 {
     switch (n) {
     case 0 ... 31:
         /* gprs */
-        return target_long_bits() / 8;
+        return gdb_get_reg_bits(env) / 8;
     case 66:
         /* cr */
     case 69:
@@ -42,7 +47,7 @@ static unsigned ppc_gdb_register_len(int n)
         /* lr */
     case 68:
         /* ctr */
-        return target_long_bits() / 8;
+        return gdb_get_reg_bits(env) / 8;
     default:
         return 0;
     }
@@ -85,7 +90,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 {
     CPUPPCState *env = cpu_env(cs);
     uint8_t *mem_buf;
-    unsigned r = ppc_gdb_register_len(n);
+    unsigned r = ppc_gdb_register_len(env, n);
 
     if (!r) {
         return r;
@@ -127,7 +132,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUPPCState *env = cpu_env(cs);
-    unsigned r = ppc_gdb_register_len(n);
+    unsigned r = ppc_gdb_register_len(env, n);
 
     if (!r) {
         return r;
@@ -251,7 +256,7 @@ static int gdb_get_spr_reg(CPUState *cs, GByteArray *buf, int n)
         return 0;
     }
 
-    len = TARGET_LONG_SIZE;
+    len = gdb_get_reg_bits(env) / 8;
 
     /* Handle those SPRs that are not part of the env->spr[] array */
     target_ulong val;
@@ -294,7 +299,7 @@ static int gdb_set_spr_reg(CPUState *cs, uint8_t *mem_buf, int n)
         return 0;
     }
 
-    len = TARGET_LONG_SIZE;
+    len = gdb_get_reg_bits(env) / 8;
     ppc_maybe_bswap_register(env, mem_buf, len);
 
     /* Handle those SPRs that are not part of the env->spr[] array */
-- 
2.55.0


