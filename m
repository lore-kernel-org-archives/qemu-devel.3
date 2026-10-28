Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE6606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HTtahMnP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IpFlziLP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9IL-0001K6-FH; Wed, 28 Oct 2026 15:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9I5-000113-Oj
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9I4-0006DQ-5k
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPeFF2431678
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1UVz0peLYIv9lkbu1FajOKWXrs6a0uO7OXsEuuE+jl8=; b=HTtahMnPRdB8TSoQ
 /Jo/yGcIOgy5nlPA+iGHrQ3Qc0TjR3HueidwUpPaGEv1UG6FDMuOk5sBoFhJ4+H7
 UeeLoAsdLvKlap2cUfnqDF3sC792ECfKHmBdynRGD4C6lais/yBOZBlp0MX4MhW4
 AbV0Gkh4OdCrgKoqJI1AE5H0sIM5n8LJsILEGKudaU5Xv6nwtL4zdUXS3udxv5p3
 gltb40VhveDTrLwHfhVYfbRouLqmSJbksTmAA7+jFgP7qc5PgdLkyiKRxAFfcAkM
 /NDUWR96akC1nJIpaaewfqETWm3asO429W4EEO91GSreWzPlnhdfZBE4ca/+WSoU
 s/ywrA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkdf7tqhk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f13c143c8so248077185a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215585; x=1793820385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1UVz0peLYIv9lkbu1FajOKWXrs6a0uO7OXsEuuE+jl8=;
 b=IpFlziLPE8nar36nyi8zkMtGoX+wip7bpz7MaP3CpWfCP4md7NPaivhrJ5HWLTwckx
 tYahkbE+HeYE8D/RUGX8qHy+bBd1c+isojnOtdz5ZXLzt/eLBTdtyjDLFiHarQkIPbTg
 DLIuv5DdClSj91q1omy10E7jI3eXuauvYkBuVf4t8fZ1wXbAYd083R3gJx+DBVxKK0ea
 YBap9ls23TpQyEvCBXTCMmN+b5+GWoIkjn8QQUFZVb/PWYoq2/SI/Vk4bWNzkCle4KW9
 pw0DekVJZz8eL56THJi+jGO240WFkF9dXqjyDBhjTjROV/tLmuJsktc/sSxYi3YHkZGy
 0YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215585; x=1793820385;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1UVz0peLYIv9lkbu1FajOKWXrs6a0uO7OXsEuuE+jl8=;
 b=ucEhlF8OEaGc5iUGBJ0ZJ5wYGNTIx1+28SOiTliICW+D2ijMUlPCQt/vXI/3k6FaTy
 VzCpYaI+wHqd18moeXs/a+FEXgRRBDP1Q4nE1qmSUaTGnbqBPyuUloMsO1eGyP5a7xkN
 Lc2Jy2R29Qkd6oeYCSHmtxmXZyQbnA89wU2GW6EpeuSGXir9gdxZBvRKfd5NNbcuC75V
 Nm7SqEVg+OW0kRU6iFq5rgh7xwCdq582v/G/3pGSsnAHs+SCVn9i2hAE5Asxx6CkpOOy
 nuEYml0vDS4kfaGA1wBcsVx3bUaScFpHddgBd6GRn1sHb+1c5gUWQfIJCh4REZmzZO5N
 MTWg==
X-Gm-Message-State: AFq9FYLBaVYcwLSLZ0BmU+Hknr8+pfEupi9fW0mQn8JwQOKcAgA13wDJ
 JsIKtxLP5Cv2nz3DtiMzrWUAG3Gf1tnyAO/60bJzr8hcjJjZr7VsBOnuLZMUHEQ80eZof2n0PUN
 NUPf5CWXDDQ7oQRHnOwgDhcjdKCwxSkbZLvLgGjvtxYdvSZMhLFxZ9BVs41OTIr/ADvWf
X-Gm-Gg: AYBFou1WCkZfgHFFKpGZxikfzjmkeGgC1pM2MCf+v7hoeyuy2pjxl52ypvN+37oMazc
 TAwCfILD0ihVtmdjuhU4NR6/w18F6VfX5UGB2BZItJZjYYV21mFfvMOQhDVYSXT38K1iese39OU
 GsEmkXlHFfUSB+AeZhMWLIOao4sBitaHfZtF0lGrClS9Mh5tw2fSuLxRikMLRpeUVgkQZKH5HmR
 t5VjGnxJLi5z4jcGicI9BIWIgAm+Vu4udfd66BOr0oPU4Zabk1gGK14PH20uIJuP5cauuhvkzTU
 xwI6x3MNHG3V+rCyqovlDT/mtDCHDjFkVU26L5X7UndUZq9YgkqHN+9rlbCcCBH5B3U4JGwxAop
 MkGhzLswrXGfHdx0WH0ZwJ2VRyAyt+y1JjostSA8ugMQ1RemCPXtfObqmQcvTPaYWoGJYjm3VUA
 fYwFl1TOG/xvX6tdkTUtr75oTRFa9ADQ==
X-Received: by 2002:a05:620a:29ca:b0:93f:322b:2209 with SMTP id
 af79cd13be357-94408aa1437mr510991485a.28.1793215585305; 
 Wed, 28 Oct 2026 12:26:25 -0700 (PDT)
X-Received: by 2002:a05:620a:29ca:b0:93f:322b:2209 with SMTP id
 af79cd13be357-94408aa1437mr510986485a.28.1793215584839; 
 Wed, 28 Oct 2026 12:26:24 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3c5bsm30776392f8f.9.2026.10.28.12.26.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:26:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 6/9] target/mips: Factor mips_gdb_read_value() out
Date: Wed, 28 Oct 2026 20:25:34 +0100
Message-ID: <20261028192538.31600-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028192538.31600-1-philmd@oss.qualcomm.com>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M4bYuCws c=1 sm=1 tr=0 ts=6ae24c61 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=HtJe7MdhqgC3Aa1Pb9sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: zPq_ea97mkD5ibNT1XMJIdkQWQkA5wPW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfXzXUQIPHw0pEv
 gQpRoJb+ne0+4KWZ7eWBHmntpONSZISdRSF2M/IBVpiha5kplP+TYEwtmmhOiiRNfz3boPOWNS5
 GhXJLngA5GZuP263N7wKHEmYhK1a11k=
X-Proofpoint-ORIG-GUID: zPq_ea97mkD5ibNT1XMJIdkQWQkA5wPW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfXzxS0TCcyGqvy
 DF651hEmiWMxFT+8ebWp3f+3bgE6BupyU7985ZnQTUiUQb+j0Q8GendRRF2OlfMJkFSms6OvG9I
 dI/CGAGRWeDAkAyWfvZp5Mw5ZXYqVrrX5ExsV568eDL6cwCvxWCfLCea3cog2h/ShSPlP5G55SZ
 qFnRnKBxYv6uWRrXgJlax8qd3BVoHS+oRpkcmQpUv6j/8aW6Tp7S1v80ODBq9r9WN7dMqRXkgb9
 0gac9erRGOXMN2sPA9ccskdA+TxYMqJhVzkWJecbeRWpxKkusmqXErZEn+XG4VYY/0iWdwr3bRc
 0R8t2mdZglDtBtVtyxxszDil5JzGogL9hz+je9nWrXyKH2mkTTbGuWxVRKFfya3Y9+ipvxn1h4e
 nXgDwhiYRumvQxwr1DN6hLgHGwRn9v/usQU8iEk9Yh1lG0UNHuPtLwRCoZAhyZBRidEWK/f6e9f
 3k/5vf2IjfBbMmzFTFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Factor mips_gdb_read_value() out of mips_cpu_gdb_read_register()
for re-use in the next commit. No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/gdbstub.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 78d3e9a5b9b4..54649bfffc8d 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -31,13 +31,13 @@ static int mips_gdb_get_regl(const CPUMIPSState *env,
                                   : gdb_get_reg32(buf, val);
 }
 
-int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+static bool mips_gdb_read_value(CPUMIPSState *env, int n, uint64_t *pval)
 {
-    CPUMIPSState *env = cpu_env(cs);
     uint64_t val;
 
     if (n < 32) {
-        return mips_gdb_get_regl(env, mem_buf, env->active_tc.gpr[n]);
+        *pval = env->active_tc.gpr[n];
+        return true;
     }
     if (env->CP0_Config1 & (1 << CP0C1_FP) && n >= 38 && n < 72) {
         switch (n) {
@@ -83,13 +83,25 @@ int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
             break;
         default:
             if (n > 89) {
-                return 0;
+                return false;
             }
             /* 16 embedded regs.  */
             val = 0;
             break;
         }
     }
+    *pval = val;
+    return true;
+}
+
+int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
+    CPUMIPSState *env = cpu_env(cs);
+    uint64_t val;
+
+    if (!mips_gdb_read_value(env, n, &val)) {
+        return 0;
+    }
     return mips_gdb_get_regl(env, mem_buf, val);
 }
 
-- 
2.55.0


