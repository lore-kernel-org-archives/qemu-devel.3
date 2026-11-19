Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116EE606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BNH6cgeD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LmU19VDn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUB2k-0000uZ-HX; Thu, 19 Nov 2026 17:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB2g-0000sp-SE
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:55:46 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB2e-0006S1-Ez
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:55:45 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1buS1936469
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R7wwqe/KT78E+7twyyNjAKxhVK4VE4hhQmJ+EkK7gG0=; b=BNH6cgeDTN1ukAdK
 kxmijT4A3fyEP8JgDJu+nEwpNmh1jWc2QOpev9MAChFLLLeNhL8BOhoBYEFJYL5y
 HZHjOuN5l5HjxbBD9A3J6AGoJqxw5FW9brmEprc5UPriXATklDwC/IyqesqBR4d4
 oUSniYCHAfdXvBdQGtq8sRYTCfwye2F8d6lNnBmSF96NGqa8CGv++oFHNH4nEhpM
 rQ8NcbqLUaNy/3h0n1xDKln8jtaq3ivql5U+xUpifu5Rt6Ds6TXENKTvqJnVLOYL
 7qU4VlUazlvLjqZ+MozBpgcFmsj/jhPO4hAybXfr02kgJYza+9d6O7StPXv3ckUI
 HwInVA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j22ugtf36-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:55:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94961511b61so60181185a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795128942; x=1795733742; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R7wwqe/KT78E+7twyyNjAKxhVK4VE4hhQmJ+EkK7gG0=;
 b=LmU19VDnY00Yb2vZQ2/e+iNRhT/RFhrh5rG9v8pn+NWP5smpFdJ+WbqwHgP/IJsYhe
 1kxgV1TgH/6PzxaJVlJBZTFOVoLfpgWt7QeuBoF7aoLvc8twPtwYYWsH/w1EbgdhWiaA
 hzvVBWqsuwzRgrNOO6VEdIbmz17MAs26IDYa/pZhJk0UMwE3JYurkEhF0ncc03dyQngj
 WdOXLgja9KPwU+vnbvzW79xFx+uTNZjtwTO31BTCnORIq1do3MNyiTlylWySM+dR+yBZ
 jHRV3hStL/H5X3pQLsu+QQsbKjW/u9QiqI2E+6sPkX9fjQG0EBnxqsp+xeiXoUNimF4E
 Is3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795128942; x=1795733742;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R7wwqe/KT78E+7twyyNjAKxhVK4VE4hhQmJ+EkK7gG0=;
 b=ndc4NtjMVILNM+BB4y163DF4Rs+9TQj4mwyPNTpS5efh9h1QK46foC9MLKprihm/hp
 qLROvTgLJfScsknxAnZikA6o7v9Fsp0G9LFMH/Z5vUs+smiUr5id0ld7wRe/CMJlzzfI
 kyfb3Ddy8v4kQFv5ebhySeON/XJz29NwaILoO8ca/VmMW49iPqMQzdMXUhV6uUC4rkBD
 yXv/6w35d2/DXmN9msLDOmooohjbYQvXgkC41wgUIb2bzCZKKlVZ/cafq5Ys+Ae+CB68
 OsKZF3oJwRuATy1ybEILIHnJ98nxH34xjc0d+403JPG1AxIkZbzG3YXVQaPJpeGDIqWN
 DyHg==
X-Gm-Message-State: APuU4Z+lgmhcQAYB9ukND/DqbTAeohXewV+FsjuMvzmByBp7S4smwTZb
 vYd0l7ASHaPYAFJVE2QeoB06K8HAr0L8BNNWDbzStcKYSQG0uM50vmCnxisMMdwvLz5uNKPiylR
 857ye9k6udZzLD3LueRI9F246TAuT203UDDtFWoEgSwRjYHvWoWV1DWS2v3In9osoNNvR
X-Gm-Gg: AYBFou2cghmlzf4mEdecfnkauHcRQmckOxfNX5OBAApiyfXqOH5/ZjW4KXskG+HNVMS
 H6hKMP9a8AT7/qxIS/NoSJ3uxNqrDfOrdN9+S7bt4xDJ/W8TVuVvmKreI+jmG0uYofplQyXWp7G
 o3aZwLYrvOowuomSJOZyZiUKvQGrQE2RFCltmbNCdaQfFkAK2Xb1iiVF/AtPbkfGD+1ctNZt7oQ
 a580g6WSycMajuMUW5Ix1F4Buncg0m+QYEI4L65oygmG3WKbK9U/vrFfH5ldsXnXJ1gB1suDuSJ
 Nb5ayPY8iZVD+WhbygA/snlhz16BUBjB2vQ4CIn1gxc24uwcJ/3YFDifXfSnv9Z1056og9wev7e
 QoB/wmPKau8pxnB+k43QjBL5kgd/oK9VtfRvLTLnMpB9IssTdj5bCwCbtQNR7YCIn2S0TtEIAKF
 Gfvwun8FIUD3CAzQ==
X-Received: by 2002:a05:620a:3915:b0:93f:21de:f3da with SMTP id
 af79cd13be357-949ba9555f3mr177913485a.15.1795128941657; 
 Thu, 19 Nov 2026 14:55:41 -0800 (PST)
X-Received: by 2002:a05:620a:3915:b0:93f:21de:f3da with SMTP id
 af79cd13be357-949ba9555f3mr177910785a.15.1795128941146; 
 Thu, 19 Nov 2026 14:55:41 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989eesm1978908f8f.50.2026.11.19.14.55.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 14:55:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ashish Anand <ashish.a6@samsung.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 3/4] Revert "target/arm: don't pass env to the sev helper"
Date: Thu, 19 Nov 2026 23:55:13 +0100
Message-ID: <20261119225514.4080-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119225514.4080-1-philmd@oss.qualcomm.com>
References: <20261119225514.4080-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: p6IMrLKUmew_njBH4qdcm6JSa1AZzNG9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX+8m58O2MdBr/
 3b6YHNkpiLBa/n9yNEzE4xv42DBWrpOmri9RKiKNqpWZnp8X50rqfEwuoS71N1lf0llaUzIycei
 0BXGHRw5idLtaF0q7XWeoqL4j+ydbsI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX0w6xg1PSPDQ1
 KsxB0Uaw/e9ccVbstIKMl7ZmIEDQ33kiMyIpWaDq0TDQ7Xa4rZpH18hThdgUKq2pnikjfLri8Yf
 3KbUmEyZa0eMtHHnk9lwZYhyep3SdrkOfyeTQsJzELbA5OMbhIgROobGru7/qbNYsSZKPBVZKK3
 xFThsE7cPz3hLPU1IigFdDlhYQ5T2RTQ9LdYpBiELbCjCX7vV7kcEBp1mJTPhPrmtclL7qaf2UV
 kltSWmtGPn/D73wHEeqkUrJgUE7ozfNKMY0c30Nc3wG4tu7ilbX4ff1qFkfYYadh852jAAG2E6+
 gnMV2DZ1x1XKpvWMgI9YJYqa8HqxB2DyJKFBNI00j1W4S+bOZtR/DkVTNbJz/EPBQpSmyBet7D2
 y/vZUeDzEK/8Z768WF3FN5ezO6gOH8y82LWIFfILMh2g3eG0V/rqs6SHJmkwCj+WcyQEgdPLaNa
 4jU5Ada+Hb4OXTHJ3pA==
X-Authority-Analysis: v=2.4 cv=YeEodARf c=1 sm=1 tr=0 ts=6aff7e6e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0IfE5_SyZpeHhCFVD98A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: p6IMrLKUmew_njBH4qdcm6JSa1AZzNG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190092
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SEV needs the issuing CPU to distinguish it from other vCPUs
sharing its host thread under round-robin TCG. Restore the
explicit environment argument before fixing that comparison,
avoiding a dependency on the global current_cpu pointer in
the helper.

This reverts commit c5ec1bfad10346aefb8d7a18cea5118f2056f8a6.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/tcg/helper-defs.h   | 2 +-
 target/arm/tcg/op_helper.c     | 2 +-
 target/arm/tcg/translate-a64.c | 2 +-
 target/arm/tcg/translate.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 4f9736e6796d..269ac5150657 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -60,7 +60,7 @@ DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
 DEF_HELPER_1(vesb, void, env)
-DEF_HELPER_0(sev, void)
+DEF_HELPER_1(sev, void, env)
 
 DEF_HELPER_3(cpsr_write, void, env, i32, i32)
 DEF_HELPER_2(cpsr_write_eret, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index b6113096b53b..a862b9eb02da 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -468,7 +468,7 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 #endif
 }
 
-void HELPER(sev)(void)
+void HELPER(sev)(CPUARMState *env)
 {
     CPUState *cs;
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 49472f7d9757..14888202bada 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2148,7 +2148,7 @@ static bool trans_SEV(DisasContext *s, arg_SEV *a)
      * SEV is a NOP for user-mode emulation.
      */
 #ifndef CONFIG_USER_ONLY
-    gen_helper_sev();
+    gen_helper_sev(tcg_env);
 #endif
     return true;
 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 442c34ce84fc..9d80294c9bb2 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3282,7 +3282,7 @@ static bool trans_SEV(DisasContext *s, arg_SEV *a)
 #ifndef CONFIG_USER_ONLY
     if (arm_dc_feature(s, ARM_FEATURE_M) ||
         arm_dc_feature(s, ARM_FEATURE_V6K)) {
-        gen_helper_sev();
+        gen_helper_sev(tcg_env);
     }
 #endif
     return true;
-- 
2.55.0


