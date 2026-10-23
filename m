Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2B4606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OzRrH+7E;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RCXWMMMY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHvN-0006MA-FA; Fri, 23 Oct 2026 12:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvI-00063K-FJ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvG-0002Kg-Lz
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5vET4063351
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ws3bqIizag87NJdmi9/5Ducto5GBS7L74eKuIpUR/EU=; b=OzRrH+7ERGbdDoJF
 1p3Vq3vTiqTRDhb2bFXKi13zL0qxMigqLhgSgNPmxkf4Kksj+6kWtVM70oCOuMZF
 tYyKondTALsWx01ro3ciOAnY/GoeVY7h+tK8UD1X2VzON9XgeRoaHnN2CygK9gmK
 ZHIrRZs4PxCt3o7PwfsVfbLBaa1yvEebzwyshjAz6nW2rNDK3fMEQYxwNa/wEvrj
 8zKAjHo9uSHKfqdopW4Z6S3izhKim00ZSvhOzV9CWogQBL/rKTe7oMlDcQ/QGofq
 9NUPA29a60q5BFED8L/bUfeT+uCxgI6PRDYKfWUzGHyoqRpnvHkvpd04gtdBxlHz
 ByKs1Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrcgjw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f37c94ceeso425875085a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772112; x=1793376912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ws3bqIizag87NJdmi9/5Ducto5GBS7L74eKuIpUR/EU=;
 b=RCXWMMMYWJgBaBnzyO2HYTndJrjvpRu/Jkhcu2adS9mX6Ge6elsXLwb4EPWO28SG0J
 hNN8FZzlVrrvlolkBCVDNXqjoR2glnHvN19ZRF66vtpr7qRgCV9W0cbmt8++E1TKXb3B
 9dccV9xdFB0iLF+TkoeqX3s5M+QG1h6hTDxkxV3xxWD8fu9qBw/02lgUAzLt7KqzbiYJ
 UtIrKmyk49QByyI0Ib4Oa7r4ALaeUNI34Zyk7LfCsKtjye0wJTaI1kClLycz+ysoWTRX
 k9HQ0HKCWgKfYj/ZMX2f/woVAWfCj58OxIUlJk0cVPlzQUDIdTx94bpcAPrN85hZYBJo
 j84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772112; x=1793376912;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ws3bqIizag87NJdmi9/5Ducto5GBS7L74eKuIpUR/EU=;
 b=jko2SdUfe+RVxq9Qu3V/srjl7FLapuW6jMSLfziZtZDTBztY/ToOdncbOrtVbbuptY
 paPco0t+FFFWWmu1FDyCOK9nGX3DEbINpnfQdrN/r6+TM0cXAdta0aV+aTltdON45+GU
 Reuz5pfo46B3n2XheUaBQ/Ctk0EASPrAFrasJQpal++hfZHP0XKHP2+QLvXArTlk8aLe
 /zYYoA+H2ata2YG8Swo3Npq/i/1HFjPQcU8G4hdylpod28J/5jJQxwmpjC+uubgJJ+qG
 LPHSlJo1kpCTwNkgnpsKCpqVGy5CzfTHQrNaGb4NNz7vhqv/qRad7cwQXyt2kfVpU2Ns
 gEBQ==
X-Gm-Message-State: AFq9FYJiFFSTtiuhrDvJhRuQ+Uc5YwIMJmv1zxSZmLEIpINxO6DtxbHP
 BLSOZ7X8586Wv6hUKvvYpJQjc2aQcswp3xik+aCyBjSNBHUjJBzqE5TvJKMkGh2OCIuqsAh4pC3
 igzSq1D81wTJkAlDAUa6hHbR/EzJo2V0owC75AV7W3OHo8R4aObrKcbR3PmCummVnvGQ4
X-Gm-Gg: AYBFou14fGkf16xCg6+Wiebx7/csoeYae7NYltaQEFv3UUr8bSvGQxNS/Yd71Z5U4sJ
 z+ZBD1yliVCcGJ2fPD+3EL7hpkV2rgoDrHgkFf8Y797gMTadokTI5UOcY2wjPJ5SrZspYKRbHZh
 T+bnt0F3+ljLxvckNwWsq0wtUWrVUuJMeBpFND/xf4UMS2OdynezHSsC2rDDb4+OZ3Ab3usif7u
 VUqQWrNc8+qyXq6pdWktgqKaD9ktDiOinkIxpD6qYDi91Z5QPKhbZOXl8AX6HIHRRCClmt+ZC81
 kb5Gdgm4Ai0hRSniA8OXvjsqN6kkarhz49jzIynqjM0wjAzRhuHd83g6BSbSHcfdyEb0sRGdZJF
 hiiJBLu0Y/PQ/geVq5HEDerfk83Cm3hhxX2gYexZ1
X-Received: by 2002:a05:620a:460f:b0:93e:6e6a:b686 with SMTP id
 af79cd13be357-93f6276d418mr1034076985a.29.1792772111945; 
 Fri, 23 Oct 2026 09:15:11 -0700 (PDT)
X-Received: by 2002:a05:620a:460f:b0:93e:6e6a:b686 with SMTP id
 af79cd13be357-93f6276d418mr1034071585a.29.1792772111447; 
 Fri, 23 Oct 2026 09:15:11 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe0e577csm9117375e9.0.2026.10.23.09.15.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:15:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/83] target/ppc/gdbstub: Replace target_long_bits() by
 ppc_env_is_64bit()
Date: Fri, 23 Oct 2026 18:12:21 +0200
Message-ID: <20261023161332.60153-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TYnXdfSEXcNvSEwfcWXRXrUqE6IXyrl1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX4gvyaCH4Eok7
 zutGOWY7AGJk0dmTxmLzIfGzzNdkqjbnSdXf8kjGmYGEqunfPNt7LdaKebHoD5SJ/Kr+JgqrgqY
 1VNHDhtfx6+lpC1pZYyp3GWEg44SdQE=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb8811 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=XEEDF0r_pM4_IqxSCIsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX1pyFWP2Ei8TU
 o2a2PckkaW+n+51XkFoDhvS3Sd6kxL1ATJBXMiGeJodOEw8QXRp80w82B21+PR4aEHoctYFSU2e
 zERGFQvdPKeHUgqjEDhMPK8QxoJXGyCDFbkrv0wzPpjB7QQdm9V3Qu0zF+lfJHL4qKvmGHSzie8
 a8DN+FnQgJQTekSuPi7EgvlJ8NCOlkvEU8gZ1gh0JocMWqmzjPRuC9Ski72zErAtxtc3vsOMGCN
 iAd9DgcDj6NIqYxlPWkjOPA41/VzB+fryDz0S3Ei9OzFQ+YcfowU6LsVX1mZKgMkTC0eUiZP7qA
 xFOs3CzVSldB16Mit4QCijdQaLRcyi4EIWx1HfTe789ECc+Qf83kD7/A8p/GYAV1GUacfHDmMTH
 akfZU4R6VEyUxTHZyedRFgCmrXl38oUAHaGJahlnJv6Rg4s5KveSy7HFFcw5ElmLjauxMgNm0Xk
 KrbwQLWICyiyq7vcAJQ==
X-Proofpoint-ORIG-GUID: TYnXdfSEXcNvSEwfcWXRXrUqE6IXyrl1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
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

Add a gdb_get_reg_bits() helper deriving the register width from
ppc_env_is_64bit(), and use it instead of target_long_bits() and
TARGET_LONG_SIZE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Message-ID: <20261007232326.66240-6-philmd@oss.qualcomm.com>
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


