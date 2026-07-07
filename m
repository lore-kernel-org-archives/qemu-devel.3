Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41FCC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAKq-0004Js-Fg; Tue, 07 Jul 2026 14:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAKc-00049s-NQ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:15:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAKb-0006Ha-1P
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:15:42 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FT7bR4045084
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KWT8CSu8Vo3TtXOAAOy1RxM5NBgioT01Wt7T3+uVgBM=; b=dB90+3JITGvKzKIL
 5uSZBRSW32T+3xdbNC5oFvJM6ZUO14jnVUcT/mrmA8w0sujOUO7QNzaAn1sgapOB
 5bHO5bWsb6jZ4ZlGZ7G5zpiRVaXBoL6LSVCJi2atReHxES6Lnf4NYf1rJ3N1EepG
 zfP3U44zwhGD0UCl145BoeKxufDovqpnQ7fQ5xLarHJbv0uSqktzG7z3EWCdkJyN
 w5RbarRLIeSq9wMXeLp7FncFZJufn7EueFzJxtPl+nLfo9RBdnLFh1wRfMiisxbv
 Nx7T9jW2hKpRV6c8R0xHsMpLRaFlIX9W8Dxv3edtaHQQdD3ojcL+pmRa4PmZXbAr
 an7vAw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2uaru7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:15:39 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso84896071cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448139; x=1784052939; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KWT8CSu8Vo3TtXOAAOy1RxM5NBgioT01Wt7T3+uVgBM=;
 b=W5rnKQzYpLd2WKh0/oEMMZ3OcxgyKkR0IDmrSntbZI/5RoYBED5DI0YBn0Sm3gFGrO
 tlp69iTDlgPVTVvlusM6EfsKIzPxVi9JG/gTYRh0GXst4wGm/HDBlXtGLwlRItkhqHMD
 7yBzHRQ64iEIURwTqPqYVCUdXoB3gtrGaRPb9bvUP09r3aT5FmojJFvsC+Ifvr6fumz0
 OgEZvQs909bkJomliWg9WYTB5MIFKRrSHjRjtDDWfHATwv/6EYESERaXJ9BPN94s/hi5
 etWr3K4JWrhco+QS9e1D27D/hl5Jzv6CQd/Febpl9w9oaGAC9HxELCyUWCD/l0pmfuXh
 JPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448139; x=1784052939;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KWT8CSu8Vo3TtXOAAOy1RxM5NBgioT01Wt7T3+uVgBM=;
 b=rn21FjhRCpE7oZo0ey0czo8qJckdwe3EUpM5RnFaymkRyTa+cqTwwxONHorERmjKT+
 3H7e9yWfumatzL9HTsnN9p4LAvqU1B1X/Q3b1ZGRAgfugwKQQrhHEsUViAzcADg4Y5Z2
 jkuERGHi0vmS2Lud3V2AxDv+Zue1bGsLy+MOogwlXkmn0RU02vHn30yk9Di3/qrQsiWp
 ugMcEDGfLBmc4Md+B15S7OQWK/nxwCvbiai/COM2Avv62enieow33RbgKln9xtw9C62J
 eun5c/JkO2kndjU+3rnJUdxNSmxwhP8ZZMb6Qk+7B+xYe5G1cB0HWNAbMjyGTa2wv6t7
 pR8A==
X-Gm-Message-State: AOJu0Yx5S+ZYaj/8/Zo6tmf3EEH8qic0OBay8HAmZfAwxg0AWM6OuK0P
 4dLH/MpaEBldte1OW/tVcpQNFqQ1Yyme5HZCCYffS/Fzb5QYM+36LFdj83GtWbXow6YFMZVC3G9
 xuissSQ0ndUYSv98CvkGJQ74TV331mBzY1v858DSbT/Iz/j57mPv7VSW3WsaVPTMNOA==
X-Gm-Gg: AfdE7ck5hEpTvLO8x5/zakYbaiDWe26i+k5c5yajivrIuRxASqqNg3vbX3UB8V4oA3b
 BLry2YZwcK+b8k+Fw6a4forVw+qUZ3GgMnXbeidaDm8EekRPYKn1ETQLcq69zmRktD0s2HW8Hug
 ugXrpzuMLLg9Gssu/QUyJXZNkXJkF4+aIaxW3TK4XOaF8PayZPDbArc1z2i7zjrxjdTRa8J4JSB
 DKVeQ+qydanCEdOixnlg0dojG0MiuTtiWTfdbdVENdk2L/YhRLRdYhuEC3+a1MPryto59Mpwlzd
 rUdr4DO4Blt7Q7WTsGNXzBUa62tJ8vdtHjxD4coFP1Xq0bJgg1RXtoj1TG3w0CEOy9SutuJheX6
 swWImPPSqGbpjAvK7Baw8FQF2oUoLcBiaWAzHtoHa4faSpGBAbFrOwyqIpDPVRlQcfQ+W
X-Received: by 2002:a05:622a:4c:b0:51c:7b12:1211 with SMTP id
 d75a77b69052e-51c7b1217femr37693171cf.79.1783448139011; 
 Tue, 07 Jul 2026 11:15:39 -0700 (PDT)
X-Received: by 2002:a05:622a:4c:b0:51c:7b12:1211 with SMTP id
 d75a77b69052e-51c7b1217femr37692361cf.79.1783448138297; 
 Tue, 07 Jul 2026 11:15:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0faed08sm66734045e9.11.2026.07.07.11.15.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:15:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/23] target/mips: add Octeon COP2 crypto state
Date: Tue,  7 Jul 2026 20:15:06 +0200
Message-ID: <20260707181529.60191-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfXxqifxhJfjxwV
 zQr5E02Z923nOkpTN9XX/B0sHbhm3kIB+zvRUAJTi2qZU3Mo52t8YY31as1W5QG7Ldu8n4y0euI
 u/xw9MG36YXTAIqzu2mh0LywBKz61Jg=
X-Proofpoint-GUID: mZK8wiDwNNuL2tsFLd--ZnfHYBd4wR1j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX/UYdtWJIlj5N
 yFxscMdKQPfzWzQYL4H9vHoNGEU5122Qcqm3OI4EDsSPKFZsEpW5jwCYtjZP3bYpF9uLU8bxAFL
 bddHVnL2NBXAkDP7s/jUjJ0kCjYmXAUF/cawcnnvrM18Pxs9PnKrtJSI4guwQ+ZvvGSJR2CWyMP
 M22TNc5G9TaUIr09pXfCi8xmWAWhzzgyVA7RCOXzzvpibOBFyhxBiO+J29tKiSN01w+0KTUMpm/
 wrS0hVNqK55hyobC1wEV3sWRlSAVtt8JP0pkWTB29PLPNrR8zS84v50aOYtQ3cERxs7GF8Mxp45
 mXpm71lBDa8ZSJF7FtocJOMn84S8PHlY+3iWeRHN6tMO8V0bl0qXqV59aeVAfPpmAUZE35rFvBd
 LTE1qNVD7y8q+2B7kog4ognStG+fF8/tAsp1qe1wDYO1ZaJdORK6jDLlWojH6ZxTMYz28kF5Ydc
 WxS2dFE7+IEuf6Ej0JQ==
X-Proofpoint-ORIG-GUID: mZK8wiDwNNuL2tsFLd--ZnfHYBd4wR1j
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4d424b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0dRJNWE_jSRIec9sPJcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070179
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

From: James Hilliard <james.hilliard1@gmail.com>

Add the common architectural state needed by Octeon's selector-driven
COP2 crypto interfaces. This includes storage for the base hash, AES,
CRC, GFM, 3DES, KASUMI, and overlapping HSH/SHA512/SHA3/SNOW3G/ZUC
selector windows.

Keep selector values and helper-local aliasing logic out of the CPU state
header so the state definition remains limited to architectural storage.
Helper code uses the same register banks instead of adding
non-architectural shadow state. Model the SHA3 view as a direct 25-lane
alias of the architectural HSH DAT/IV/SHA3_DAT24 storage.

Migrate the state in an Octeon-only subsection so non-Octeon CPU models
do not grow migration data.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-1-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/cpu.h            | 26 ++++++++++++++++++++++++++
 target/mips/system/machine.c | 27 +++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 392406aff8a..3df71adf9bd 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -537,6 +537,30 @@ struct TCState {
 };
 
 struct MIPSITUState;
+typedef struct MIPSOcteonCryptoState {
+    union {
+        struct {
+            uint64_t hsh_dat[16];
+            uint64_t hsh_iv[8];
+            uint64_t sha3_dat24;
+        };
+        uint64_t sha3_dat[25];
+    };
+    uint64_t des3_key[3];
+    uint64_t des3_iv;
+    uint64_t des3_result;
+    uint64_t aes_resinp[2];
+    uint64_t aes_iv[2];
+    uint64_t aes_key[4];
+    uint32_t crc_poly;
+    uint32_t crc_iv;
+    uint64_t gfm_mul[2];
+    uint64_t gfm_resinp[2];
+    uint16_t gfm_poly;
+    uint8_t aes_keylen;
+    uint8_t crc_len;
+} MIPSOcteonCryptoState;
+
 typedef struct CPUArchState {
     TCState active_tc;
     CPUMIPSFPUContext active_fpu;
@@ -558,6 +582,8 @@ typedef struct CPUArchState {
 #define MSAIR_ProcID    8
 #define MSAIR_Rev       0
 
+    MIPSOcteonCryptoState octeon_crypto;
+
 /*
  * CP0 Register 0
  */
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index f988b3695bc..77f576a25b1 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -279,6 +279,32 @@ static const VMStateDescription mips_vmstate_octeon_multiplier = {
     }
 };
 
+static const VMStateDescription mips_vmstate_octeon_crypto = {
+    .name = "cpu/octeon_crypto",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_octeon_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_dat, MIPSCPU, 16),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_iv, MIPSCPU, 8),
+        VMSTATE_UINT64(env.octeon_crypto.sha3_dat24, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.des3_key, MIPSCPU, 3),
+        VMSTATE_UINT64(env.octeon_crypto.des3_iv, MIPSCPU),
+        VMSTATE_UINT64(env.octeon_crypto.des3_result, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_resinp, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_iv, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_key, MIPSCPU, 4),
+        VMSTATE_UINT32(env.octeon_crypto.crc_poly, MIPSCPU),
+        VMSTATE_UINT32(env.octeon_crypto.crc_iv, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_mul, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_resinp, MIPSCPU, 2),
+        VMSTATE_UINT16(env.octeon_crypto.gfm_poly, MIPSCPU),
+        VMSTATE_UINT8(env.octeon_crypto.aes_keylen, MIPSCPU),
+        VMSTATE_UINT8(env.octeon_crypto.crc_len, MIPSCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -396,6 +422,7 @@ const VMStateDescription vmstate_mips_cpu = {
     .subsections = (const VMStateDescription * const []) {
         &mips_vmstate_timer,
         &mips_vmstate_octeon_multiplier,
+        &mips_vmstate_octeon_crypto,
         NULL
     }
 };
-- 
2.53.0


