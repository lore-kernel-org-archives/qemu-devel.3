Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E81C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XoR-0002sy-Fj; Mon, 07 Sep 2026 07:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Xo5-0002iE-5L
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3Xo3-0003FQ-5x
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:46:36 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AvKYD496165
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 11:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rQRIvS4B5Ef
 nTVfHSEcinZ01H6Ql1EnlvJudtDsuPNE=; b=Jr1/YFrtmYToCltqTwneyOSSWOF
 9gfJIIdJLxvUAB6qoZLUIJcoW/oQJXfNhjXKITXzmsdov/SQt7kgOpIBDBWFpVGU
 64eGviFsj16lX+mvmI3PLgjHnzjC11NyGVnLO5iTXqSm1EIbmVclrPQzgQSSGCAl
 NLSu+oSdsF68o81VxICFN0kqe0Ds05k4DtU+ScE8rZ4B7JldhejJ4mIsmiF7LLFJ
 HickOgTbiLYQFKEvXTa3/3VX6CPHmmmQIy655ATyX+prvQJYsRa/kttRXQe0kRKR
 9DVbpSYlpAmrL08L9yaKJxwuq1Mi+LOnyDbvMdieMV/+qljH0EH9zB98F1Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuyk852w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 11:46:33 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9102f07f2fdso76466706d6.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788781593; x=1789386393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rQRIvS4B5EfnTVfHSEcinZ01H6Ql1EnlvJudtDsuPNE=;
 b=KHBbfDRw69bXLBYS5wnVAzqknT0m1YT4JszMSl/wL00F+x4XSc7ed7ftofUziO/XKE
 q1lf5PtFRfh5TLTx1obPdhLArOMR/FOf4SCGArcjCl1nthcbFSLQo1ZholWX8gcNKMtn
 vbHZI6HLCXzrUGSlek1z2R0yJwyBfDQ9F1/n6NVf/aDTM7p6Tpwq+k1dmZJtkE2KDdmB
 pYIpUr3S/LYpay4vEGG3s6Hq+NFM2xtkREUwx2IimZYF4tCXSGJ5frXTG15RXCGJMAj1
 +A/+NcYG9nJwzFZqVHwtYFhqilNZDI/4J2+N1yTqynP6FXr5FwctNBIX0D2O8+g1Zu4F
 sV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781593; x=1789386393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rQRIvS4B5EfnTVfHSEcinZ01H6Ql1EnlvJudtDsuPNE=;
 b=BxjDT6vM4EUoH4IK+y3xRUBbgzkOZ+1+hmJ2yav9WAuTyHgnFmysOPkpNFTIS/LrJ6
 VA/jskFFh55LqTQJDZQy3UTyFVrDTMepE8GqZDkFEmYXe+JnqiH+Lf6J4F8qv4SGc4ct
 pa+wvNqWh9m4ZhukR6edjLugSpiKYB+3sdkyaD7+uw8tmzPWvwZ9stV8i8QR0+lKBBkn
 Pt/UfhrXXzfW2ApdbfnMUbyHaz/5DDnLc9PPFN3Lu9YQhoMugXthN1ituAmGQINf9fLk
 xNRWW2LreCqkL9uZ2HMD3BEcvUIOBBAE+CsXDvDySWJA/8Jw+ZINy81xPy88k1KrI5bc
 XhKQ==
X-Gm-Message-State: AFuF++l/lbgh0v1fjVad4qzlwOhCPnt3mqzu5ljKR/TFdaHYax+laP4z
 9ju/c+cLP9+Ui6nKqqE7h4BmQrMemwSvB0rFfjLM7lHZHf443w8d2oebQlHTwwCLAdu5cKCmUOJ
 wS39cv4kT9Daanx8azacxTg1UV1p3sPQC+Edzdm0dydac7zessTd8mYBWWH9Esg4sEQ==
X-Gm-Gg: AYBFou1bPxZ1QJzOUMA2rTimZDE0cMrnTdN8Dfk+ogvDkKakgFKxk/VitV+BS/lmgMI
 KSdliyzNPM+xC/udQRNeBlG/NdmK3xtTr5QjKm6/8itexeaTrkBe9u1X8LwPEHtWQlIPfmRyE1j
 Ia5Pkl3bTo85cacb7GZTShTBn91d/Zlr4jIiBDoUGccCT2ZrVC5YBW6GNeF9td0aBU0Q0KcIedT
 26wBwYna61JQ3IfrrV+1nOMU8dk9cy2ZERPW0hBLCxV1zK2Df6cgsq0eOUClOTlkh68nenWhKss
 z5LJJgIplRxrqd4cANDCbgx+KjKPmFgxud5xOzDXT06fp9OhV8n5yyXMnlvORR/3nustVw50Dk5
 wj57Y/sr7+VNYd/UuLUcGf2O/pDy+SCe9sTA9
X-Received: by 2002:a05:6214:4001:b0:90e:940d:afe6 with SMTP id
 6a1803df08f44-9106202083dmr4093836d6.15.1788781592716; 
 Mon, 07 Sep 2026 04:46:32 -0700 (PDT)
X-Received: by 2002:a05:6214:4001:b0:90e:940d:afe6 with SMTP id
 6a1803df08f44-9106202083dmr4093496d6.15.1788781592267; 
 Mon, 07 Sep 2026 04:46:32 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040679e13sm89834876d6.26.2026.09.07.04.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:46:31 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v8 3/7] target/riscv: add dret instruction
Date: Mon,  7 Sep 2026 08:46:10 -0300
Message-ID: <20260907114615.1609913-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com>
References: <20260907114615.1609913-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyOSBTYWx0ZWRfX/7EzO5lhVw7t
 MKEbcf22EdeGGBeq1ZCnaA4MidDQ0jC7q8nW3hD4H41cllllT9CHLGIUAMr+E1HLLQcsanZ5xem
 DdPdloy9urXUNNHeSo8diID/Q5isSCs=
X-Proofpoint-GUID: xSS1srNtfdlPSGJ9w68V86GYnbBhltfN
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9ea419 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=2wZ2TuoAFSEcmpuqsd8A:9
 a=iYH6xdkBrDN1Jqds4HTS:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: xSS1srNtfdlPSGJ9w68V86GYnbBhltfN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyOSBTYWx0ZWRfX+utj0yeOzHnY
 wFzn09UPttRa4Rrs6mB4C1PhTZ79jl7g8u7mKPacxl8K/uxfxcmSk+iC6tSrW4+/is25y6uSEsg
 wvvtyU59M/RZrixYDxKoC0pkVgUp4CCsKo64ITYd80pnNHWkhK8Na2DUoJwc5mNXXqYVRvP5910
 vF3v57UlSPY2QIJOr3ieWkk/RPpsc4IT1z6uGzColENcVgTjbwNcY28cWn4xxDPVuXwP0yxashp
 CNpLOnG//03hU3Mp1R+jRrnau2GmYPEBy9JaKBQ4hvDndnVTnIMYdTmAjAJCsPmrUFeBIkd8Sfx
 LwO/7y79TXjROW3SU0GGz3bF+EbiokffPrLRwnOIavas6HbKvFvYEmzvG2yTeGD9Gs2ezD8v37T
 MuyhVE8LuYv34NnOLoh5VWu4oANB+jAGHbVHK1HccKgiLiFM7QS3AbUfGo8uphMXnfwslYXx7uC
 QRsLTFYQ2Gt8lTnM+KQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add DRET decode/translate and a helper to leave Debug Mode and return
to dpc. Executing DRET outside Debug Mode raises illegal instruction.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/helper.h                          |  1 +
 target/riscv/insn32.decode                     |  1 +
 .../tcg/insn_trans/trans_privileged.c.inc      | 18 ++++++++++++++++++
 target/riscv/tcg/op_helper.c                   | 16 ++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 4fc2d3a155..b4c47d0738 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
+DEF_HELPER_1(dret, tl, env)
 DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index aa02dae3c9..46b00411ff 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -118,6 +118,7 @@ sctrclr     000100000100     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
+dret        0111101    10010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
 
diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index a8eaccef67..4e57901880 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
@@ -125,6 +125,24 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 #endif
 }
 
+static bool trans_dret(DisasContext *ctx, arg_dret *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (!ctx->cfg_ptr->ext_sdext) {
+        return false;
+    }
+    decode_save_opc(ctx, 0);
+    translator_io_start(&ctx->base);
+    gen_update_pc(ctx, 0);
+    gen_helper_dret(cpu_pc, tcg_env);
+    exit_tb(ctx); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+#else
+    return false;
+#endif
+}
+
 static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 3e94005d2b..54269efee1 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -473,6 +473,22 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
+target_ulong helper_dret(CPURISCVState *env)
+{
+    uintptr_t ra = GETPC();
+#ifdef CONFIG_USER_ONLY
+    riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    return 0;
+#else
+    if (!riscv_cpu_cfg(env)->ext_sdext || !env->debug_mode) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    }
+    target_ulong retpc = env->dpc & get_xepc_mask(env);
+    riscv_cpu_leave_debug_mode(env);
+    return retpc;
+#endif
+}
+
 target_ulong helper_mnret(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
-- 
2.43.0


