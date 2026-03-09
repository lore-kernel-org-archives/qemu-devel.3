Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1D3F417E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbur-0000yM-Kc; Mon, 09 Mar 2026 10:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuS-0000q2-8Y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuQ-0005Dv-2w
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:39 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629ElN2l3773575
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XLzYwfmXprCszJeukw3r316VheQil5NoQyrXsV7xvIQ=; b=nGZS8ys8/Gfjiqkt
 PTJhsZq3y1CRhgE1oYai2P2pA5XA1zFp9UeeWpVnhTQHFzQeLjvzQTQpJe2HTbym
 40UGl0zNuaj2AkDtHpxDJEKYJ/1NN8f9cFD+vy0rDZ+7etigYDZ83s8X2B9VxYrC
 NizMKwoAuQtU14IDov/q4E/oD57Mqf144haMdDthcmobtQAoZl4HLIrdse/oJHTT
 fqIDGdlaHf75N9T7Qf+MHPkWDnguTqYJJ6iR3KDb9iPN/myYmw6mKPFHhNvR2zg5
 ZPwwrFqSXVdM7jjwwI1sp3PaUZB7UuSP9JEm6VJ/XJSnyUrDiwIi3UVYrH5t9wet
 7Q0QZw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cstsa98dp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2be27d4e3e5so79009197eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067715; x=1773672515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLzYwfmXprCszJeukw3r316VheQil5NoQyrXsV7xvIQ=;
 b=TfRhJ8WnIwumgHgEdthCMOAKr3StbfH37w7kAK/qWOiXZJc7Qg53M7cGvjuAwigI2k
 PL4qKsjimZgpa4GxytDgZkb2NMm2+JWifuX3Qde7kDDE6z+serN5Gce9n7q1lCsIig+B
 hG8owHsKcrah6xefDUQFFTOfKi6giwk0FRWndKrQ6Mbe4WTB9EHecKE/HrFomHAI70Vm
 fkcASjYhgBgxPkJYu2/1+6YuHm0XGGzF1u5+uU9JsIRhkzAOOvFe3A3H4EUJc3xovMWI
 69vpmkb3k47T1YbPUZsNCu6Z9CunE/gyvHDdYAxiGx/Eq7e3vvCkYXhVFYzKBytdv0cx
 vJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067715; x=1773672515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XLzYwfmXprCszJeukw3r316VheQil5NoQyrXsV7xvIQ=;
 b=frrSmEY7QrLUugS7/ynpqHEzjj9C0CTaugQiWlDbZS75Jf5vrQIxYGKdjkxknA2Fa8
 b4jksJmqTiM6W2SIhCB8FeemHeIbzxyMaNO54SlU5/L2V5cqP14OF5cIDQrRj/MESB2/
 QQLWa5CD9Bj2/xrXKW1RgYF5JiCL4mp4uFABd4xb65pow63lE/J5eE8sEN82SJ8Tl3gD
 FVvtagYbpw6uJYD3uWIYSWeYQ62HDJNBmEUqjeGRqwcXGNZqQdL1J/kw/8NyHqHTDVMW
 VC7+6OTkw8iGMkUZyqiVgXZzmAi88UAahybLRqch2xahkRn3wBp8e85KoZeYst7ZHYWF
 NTBg==
X-Gm-Message-State: AOJu0YxhM6uZ6ak6skVkrv52E5dU5Becq0SDa+Da8ZO69ZVyZTVPah9h
 0k721yS5NAErJXZfQXC130fk1CB91o7paaeR8DeOgD+osRuQuBRuGUXy91AFNSWXirg5Zo2uEki
 /9PWzEGahbFzuIa4q6p7KoUREEpPyO3fm8lJNTO9jefTy2UAoqu8eq2/PsEl2ET26Yg==
X-Gm-Gg: ATEYQzz0MMWfPExIIT2RETcXfsTivEBMfiVI3J5DGMbXw/0/OYSpxlKh1xAnlwDEoeJ
 cVOIeVincZovRWPpBF6AO0uBkM/v7DbSq0RJhljy2aFhBwmIAjL8py9UkXnLtsVO+09uElzvdBn
 uIDbTFsl+2YrNoawU/dss+JpFhACxu4W9P0mEAidJwOe//sfiIZf1776G6cI5fSyUIFJTLXMyJC
 zkKwNCkMsii0Cu11Cvg/LnRjtdix8FBS+vxgq32JDjDPRmG7GDBH3NLPuK6BxobMD90q8wReCjW
 d9j//74yoIZ7hK9S3JvkEEuJmP6m8IQ1wcv++f4IIgDm6UdtD3j4newxuy0yhpHyiQMefe9ERi0
 35XLzn47vYINNHTFTkjztUDih06RCHwzQWoA+H1RyINOiL0iz3jrB/boUiDv88NxYyrFMDA==
X-Received: by 2002:a05:7301:4591:b0:2b6:ffb9:9633 with SMTP id
 5a478bee46e88-2be4de9a868mr4665611eec.15.1773067714617; 
 Mon, 09 Mar 2026 07:48:34 -0700 (PDT)
X-Received: by 2002:a05:7301:4591:b0:2b6:ffb9:9633 with SMTP id
 5a478bee46e88-2be4de9a868mr4665588eec.15.1773067714046; 
 Mon, 09 Mar 2026 07:48:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v4 06/35] target/hexagon: Suppress unused-variable warnings
 for sysemu source regs
Date: Mon,  9 Mar 2026 07:47:53 -0700
Message-Id: <20260309144822.877695-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kSaYRaVxsL3LOIN05dfJfawmGRcrqgPE
X-Authority-Analysis: v=2.4 cv=I+Vohdgg c=1 sm=1 tr=0 ts=69aeddc3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=dvhcR3axvtdXbCCTPW8A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXyKAP1SGkDI+n
 TjtGAJO7AeUcRK8SkXkeisMFOjFkSGNcTEvVMv4c7eAgmq7U6tH5IbbbEbK7nvp2QkYDG+VMp1k
 jbu3wd28TZH4gFX0ih6lq6ss110mjpXZ0xaMsq8R9bCcjiFW6iOF/oZJamGcU+EzxfnA2dp6MPm
 0KBePvIIHbaHg/qURpy8lGYFzeo9D5ElmO26K7CUieH086ZYrDqcTVaQMkHw9KAYznJXb0CcJIk
 H309nYyOk6XgyxS7abJk5yoeYFTp4ozMaAkwyuVeeYULm7WzbKqiqXpzlbcVAb5m084XAijg3C/
 jDas7NUFrL48qLEB/Dt95UaszIK3FE8IhS+srUgHOrPNqb366gGSl8v0L+2jRgc3bRnclWE0/c8
 bx0v6wz267IX1CGcriJcEGIdj6t++xdCZx5DKvTSXfcxuQJ3MF/y6VgT8yV1aw7C5qIMXrl9YUS
 VL/SVxGXrkvSJcKjYdQ==
X-Proofpoint-ORIG-GUID: kSaYRaVxsL3LOIN05dfJfawmGRcrqgPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The analyze_read() methods on GuestSource, GuestPairSource,
SystemSource, and SystemPairSource were no-ops because these
source registers do not need read-tracking in the analyze phase.
However, gen_analyze_funcs.py unconditionally declares the
register-number variable (e.g. GsN) via decl_reg_num() for all
registers that are read or written.  When building with
hexagon-softmmu, the generated analyze function bodies are
compiled (outside the #ifndef CONFIG_USER_ONLY guard), and the
declared-but-unreferenced register-number variable triggers
-Werror=unused-variable under both gcc and clang.

Emit a (void) cast on the register number from analyze_read() to
suppress the warning.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/hex_common.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 1e2c2e46506..85745ef48c2 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -1075,7 +1075,9 @@ def decl_tcg(self, f, tag, regno):
             gen_read_greg({self.reg_tcg()}, {self.reg_num});
         """))
     def analyze_read(self, f, regno):
-        pass
+        f.write(code_fmt(f"""\
+            (void){self.reg_num};
+        """))
 
 class GuestPairDest(GuestRegister, Pair, Dest):
     def decl_tcg(self, f, tag, regno):
@@ -1100,7 +1102,9 @@ def decl_tcg(self, f, tag, regno):
             gen_read_greg_pair({self.reg_tcg()}, {self.reg_num});
         """))
     def analyze_read(self, f, regno):
-        pass
+        f.write(code_fmt(f"""\
+            (void){self.reg_num};
+        """))
 
 class SystemDest(Register, Single, Dest):
     def decl_tcg(self, f, tag, regno):
@@ -1125,7 +1129,9 @@ def decl_tcg(self, f, tag, regno):
             gen_read_sreg({self.reg_tcg()}, {self.reg_num});
         """))
     def analyze_read(self, f, regno):
-        pass
+        f.write(code_fmt(f"""\
+            (void){self.reg_num};
+        """))
 
 class SystemPairDest(Register, Pair, Dest):
     def decl_tcg(self, f, tag, regno):
@@ -1150,7 +1156,9 @@ def decl_tcg(self, f, tag, regno):
             gen_read_sreg_pair({self.reg_tcg()}, {self.reg_num});
         """))
     def analyze_read(self, f, regno):
-        pass
+        f.write(code_fmt(f"""\
+            (void){self.reg_num};
+        """))
 
 def init_registers():
     regs = {
-- 
2.34.1


