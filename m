Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFD7CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEb05-0008CF-1P; Wed, 07 Oct 2026 19:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEazv-00084p-Hs
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:24:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEazs-0001Po-LO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:24:30 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LtXrP1466268
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 23:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sPCw/EvdFwhIRkHyh7pr3TPRAXD+Y54XtaA9bAUaGb8=; b=A0+A+1sdr4RqpJFA
 3gjU/HwBszuZDOWfJ98a1FqlBblMJXUnUiFiIdrg5lfOYJPyk9g07XIa29gCZgzs
 EQ4ZonBoCmQD0IhS7wD2ttwjq9LUbQWU8BMtprHgJ4nwIsAU5SI04yQ9iFFRtcEQ
 /nsypqVaGYRnAwGiS+JoMA/MiOabyGuu2Qw85dn9u/KTndRcQiqcn507ALbFl9M0
 mnpm4jqFN0Fqt/gbGCqOLnHNZ/9H54X7+ivdTL72svqxf367yJ6dEymWWasjP17m
 z5Z9iB2sMG5+LgAI/cfdKuANuX9D1JkmvIbcczUjZwgnSO9FYR8dEgpPSp3f+cak
 xcK9bQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe409nw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 23:24:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934956beec8so1000929585a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791415457; x=1792020257; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sPCw/EvdFwhIRkHyh7pr3TPRAXD+Y54XtaA9bAUaGb8=;
 b=RAR/0fxFqlgbuIkbqq6l+qEmE3Io2jr0r1Exwaulmz29jZxivwdJAIJGZ8gsi6g2ca
 r8A+g1+QnLZgFef3muV0sT7ZOODkD/7Ej+zk0OlEU3T4l0f0tPW5lKmC1qxVjrPuVX4D
 x1hNJJUKtpwO/Gcdt2ucI3x+QCIlE4K1eDoufnTdrwwVIYG1AoYEtd393L9PsfQ1u5dn
 7/cBEjtGJDpsQcCWA+HW1sWLrUNxTMDexGOmWyZiv9H3ja0wTjBun0iwHslCSI6wiseI
 mW0UO9yYyxZSC5TnYkhREVF3bOPcZWBubemzPetSE2LHs9OKBx1HzTVNYUHpwSbPk5pB
 Xdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791415457; x=1792020257;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sPCw/EvdFwhIRkHyh7pr3TPRAXD+Y54XtaA9bAUaGb8=;
 b=czcQ6Fhgdy7gSoi77NN9bUpVqdrx7vIuOLZFJaJoX3DQtDdZ9TAgT9EVP1X03uVaAZ
 TQrZ6sSxwjpfd8Mlpw7mDBedAuNKDtAlI9eGYQ4QVFvh6AtTrW/ntIZgC2G8M/Is4Spg
 0S2RuTw6sVxxiRljtFSPoL0BBbRM6ZN9EpEYuBUf5xpzyyET0OHTzwzZcto+hKcGKFgf
 FP8Bb+rha3BPBAnFH5qP6r8lEhvocQO02aNKNKAQKDEbCvt+Dpf/S2B1fvlNffA94+Km
 3qab4OIZ8wTe1ycKGgAwfcaKI6yP/bIJjYiBd4Je5ArY3JIH8rrC4kkdXvmRmLh4S6fZ
 qS2Q==
X-Gm-Message-State: AFuF++kAQd7gx1YKZedCasDFzj/4vZGrhtpkiu3gaOfGgXwLr8Cjmx+L
 XIZ9LBu+TB7fAJDoZiwpLFtFNjhdjuBava2AbXTDjLLIQNfwQQM2faiTushYnsF8zqYsH2rmUoF
 8ZhzvuMiv0o530OGN084FfTF7NnE8okJKwxWmUiDbCeq0mqa6WzJMIWbs8IVNwrZdv8ep
X-Gm-Gg: AYBFou38XG2PljkIs1lHn+W5FQIKwrVwitJINPT5DjDAZPFnJGBIzILeX26qJPtQseM
 AwEpD7kCn65AMRaqLfEfGr8+kh44NT3WL1sa7GL8eFKBXZL2Mq7YGdJIk8j6MatJggvATJvfDYB
 U47qrUQUb/j3xYDdD8I+CTglpBW/VKtlMPH3pQ6e8p4J9nHWEj6KcBO0tdAXFRuu5RZoBnGQGxC
 GydPuu2CUb4Ezig9eo3WAI7oK2iy7GzCWNZLOu60QHNBkz6qThhTF1E3c3r4bmudQ5VXasN9ot9
 MySKG4QBC69wtTS1uzxIhv6iOM/bBYaKoc/KzhL3Czr5AJEu/ubr4Dx/E/Zj3xJm8TntDfGikyz
 2udnMKGVuoy7405AlRhKCN3XX6qNIPnybIWa5bPFl
X-Received: by 2002:a05:620a:2a08:b0:93e:980a:88b9 with SMTP id
 af79cd13be357-93e9b895493mr749890885a.72.1791415456671; 
 Wed, 07 Oct 2026 16:24:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2a08:b0:93e:980a:88b9 with SMTP id
 af79cd13be357-93e9b895493mr749887285a.72.1791415456175; 
 Wed, 07 Oct 2026 16:24:16 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1814ce9a0sm78762415e9.3.2026.10.07.16.24.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 16:24:15 -0700 (PDT)
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
Subject: [PATCH 06/10] target/ppc/gdbstub: Replace gdb_get_regl() by
 ppc_env_is_64bit()
Date: Thu,  8 Oct 2026 01:23:21 +0200
Message-ID: <20261007232326.66240-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007232326.66240-1-philmd@oss.qualcomm.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DUAhvMSidCpWar4ZutH6SgFCKmzC3Ppd
X-Authority-Analysis: v=2.4 cv=AbwkjHXG c=1 sm=1 tr=0 ts=6ac6d4a1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ECGyvcmLiFpczC5RLToA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX7kS+uNQ3xWbc
 xuICuKzWYEmXvVxh7lmbWl1aEH8ESZT0itmbU5Tp/wZbiX2IP2I9yPfzrqPSJyEpV37PfoYzMLx
 QF3ApTLYWTdpgHu3YuFcZRxxpU5IwNQ=
X-Proofpoint-ORIG-GUID: DUAhvMSidCpWar4ZutH6SgFCKmzC3Ppd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfXwFpFQVrESNbG
 PkEEtYoAZXox7wqFkQc65rYFuilVKAuK2Xydrq+Zz10bTIA8swn5XZiBvWIIh3QJSIaTVDCv+S6
 p7NbGQahmnKtKANfPpTrVLjWIkRfwu2FlUz7rneKA47CVM20uO/Ar+Z9YJ+nWdYx+kwOjq5DyN5
 uUf9LHGUn9dQml8snIL5ZT22bQjl3j1qUMWUQS9ynM3wEGeMSHWijUjHJIliGL5q1xOxsmIY/qD
 WDrBWfua7Nbi4lpu1/0sBBLs9AwNa8yDGSJfkmjONWco7rlbJYzTQ94c4Nn6gCqXsUWCH0oPcGo
 L5/JsPJwyvgPsL0eqn0pHJjMJ8PW3sYH/Yu18uZ7KviJVShf4EsPZWHpM+nAWZINkhUnUZm4iZI
 vUKTkP/iPlwJowfCIQRJowtRaedPB7dn9dph4jZ9HkMsA8Lel8K9WDp76p4jjgsQmspcw5v9vly
 +pzsMp3qDyU/z8msCgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
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

Inline the deprecated gdb_get_regl() as ppc_gdb_get_regl(),
replacing the target_long_bits() check by a ppc_env_is_64bit()
one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/ppc/gdbstub.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index ee02be63ce8..0071c2b3bab 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -53,6 +53,13 @@ static unsigned ppc_gdb_register_len(const CPUPPCState *env, int n)
     }
 }
 
+static inline int ppc_gdb_get_regl(const CPUPPCState *env,
+                                   GByteArray *buf, uint64_t val)
+{
+    return ppc_env_is_64bit(env) ? gdb_get_reg64(buf, val)
+                                 : gdb_get_reg32(buf, val);
+}
+
 /*
  * We need to present the registers to gdb in the "current" memory
  * ordering.  For user-only mode we get this for free;
@@ -98,14 +105,14 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 
     if (n < 32) {
         /* gprs */
-        gdb_get_regl(buf, env->gpr[n]);
+        ppc_gdb_get_regl(env, buf, env->gpr[n]);
     } else {
         switch (n) {
         case 64:
-            gdb_get_regl(buf, env->nip);
+            ppc_gdb_get_regl(env, buf, env->nip);
             break;
         case 65:
-            gdb_get_regl(buf, env->msr);
+            ppc_gdb_get_regl(env, buf, env->msr);
             break;
         case 66:
             {
@@ -114,10 +121,10 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
                 break;
             }
         case 67:
-            gdb_get_regl(buf, env->lr);
+            ppc_gdb_get_regl(env, buf, env->lr);
             break;
         case 68:
-            gdb_get_regl(buf, env->ctr);
+            ppc_gdb_get_regl(env, buf, env->ctr);
             break;
         case 69:
             gdb_get_reg32(buf, cpu_read_xer(env));
@@ -281,7 +288,7 @@ static int gdb_get_spr_reg(CPUState *cs, GByteArray *buf, int n)
     default:
         val = env->spr[reg];
     }
-    gdb_get_regl(buf, val);
+    ppc_gdb_get_regl(env, buf, val);
 
     ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, len), len);
     return len;
-- 
2.55.0


