Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE84CCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHrGp-0002v3-Mb; Fri, 16 Oct 2026 19:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGn-0002uJ-So
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHrGk-0001SO-B4
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:23:25 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GNFGlW552038
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YPgk74j0Ver
 Di8vyc+2Qq309omIYhnrRYn8VjK48BiA=; b=Pnb7iK/WpFDfx5TV3YKQti9rxF6
 P2vtgOdTMBcEmF9zvNqTxfxVO/rEihO1Qx/LmJs7KYMsqiR+W6Ja4axNR1aw0MwA
 nZRBX+Ua6+3/xrrHNC7adO8konVG4W+nMqE/oD2pXKBjD0j/wveVHzbZvDrcVGYp
 h8BWI5CIRcYHxYYbZsk5+LujXyQ82TqVjRc2AkxsuIPhWM1ijBvlgX08M1IjCwE8
 Rir5yljxmyHjZMcvNFg8dmrEGiyTHWl+dfJ+0S0oSnaFeSRrexTw/EkSj+vvSw/V
 2q1ymQNMf3wvzn2GXO35W0ZDSZb/XGRYNLdB64BuCZBm6/UVsmY4Gj2D+Zg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbrw70wqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 23:23:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so1391654a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792193000; x=1792797800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YPgk74j0VerDi8vyc+2Qq309omIYhnrRYn8VjK48BiA=;
 b=A0S37W8DEqCwTN+AR0sb5Er0YTnHJw91Ie59Db/6g8wbd0Gb7LZMOxGc0biK/kVNbt
 3fMmwL1cIFhQiF4ohktDaR3vrLOcTS0z7aOm2buYTDX0kVB31f3n2rwKaq3KmQ/KbGKF
 bPHuC1VNSB3I7l1w3tKaXCh9rSlGKJo+mWIBcW9LmzTP0HR0oyUMx6nNTlu5sWpTRvHu
 r9Nztdb020k7+8gwS+K6RHivyrI6yi3fSJ491rrEQHD0xA+B+RLAD/hDaCWnxB6CbBqe
 IA1/hrmGHJPijD8UXPjoO0M0hZ4PN0FA6efrP7MkIp6oBK25z/x9Kp8louYjrTz+M828
 /5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792193000; x=1792797800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YPgk74j0VerDi8vyc+2Qq309omIYhnrRYn8VjK48BiA=;
 b=Q1MsLYymXOvaKoGEOD+PUUQqI6Uj7CeS8lGJhmySvUEX2H2xPDGIWkQGn5IMJUDoqH
 VB7/UaES3bhLQpcYM0ThwPSJeAaywmkMc0PQTR3yC7UxT1jQJwREHiKeCn2l7tCsBFh5
 /mqlIyN8C1XqilBLe8FmuuoyISJyMINU9IxJMpT7P1C8lMzL/hgou6CA5enJdHwpRsLB
 UWU5BYNe9+kwdvOPSJZ36NUL4M9q1SsuKaqsM2iCJ6hWtXOA+zuM0cCnHNZawFYEnX+/
 SsDaJp8rxhPdnkf3ErXFi5t2wm5boH4paUOwdf3pDxz0F02bKmMkwJtGWuTIPMTmAs6C
 fSLg==
X-Gm-Message-State: AFq9FYJjMWrXOIzFPYO6Lbj0PmAsqwME5EgCwxcEPLWu0kUQhbWcaNka
 w+O+rRHNtKxwAk7Su3DobLMp3PMvc/ZJQLdKxit9rdA1dMYtPq1Frem4HO8FI/rmOxvNZNj6s+U
 lBbaSiRDF55fzqLg6t7qvUgGHey+3Kzb8tYbByPWS/uneYF+W6k6N4foFz4XL8J6e6w==
X-Gm-Gg: AYBFou3L3iOXeUD41Vk4f7WeKYTXCN5lisrnMB0TVK2X0+kGlH6u2ViSOrVlB7IPNjF
 dg3UU2nw5EP9gRYY2bV6SFEhydWKQJbCU3in17s/KPhLAQRQJROFU+N74Zq5UTLQ/TZRkgnPxla
 t0VtnNzfQrn48PNFoIAb+MsgRYG181o1gzRJCFWQ2ev4xkC0iU+Ux6/ycI/v9D1n9GfExTeaWQf
 17u/5hE8hipMp50jB9Cem8zdvAX61Sx3GERODf76DX64oR5/cyP+zV/IL0XiJJp3f4zNAZmcf5b
 ZL8xpk28f/3ax2ZRAm+QQOa/tAOux5MfCuzPmjKaBWBBgM1DgIQyEsfz3NYmGiN/nB8CuCihcvA
 F4jBQglRKZpPY5s9xgoA1aR2BERrUcCmYxo0MMvsHf2f1/J9SQjYWwzoEdu8rgGA=
X-Received: by 2002:a17:90b:580c:b0:3a8:337d:228a with SMTP id
 98e67ed59e1d1-3acee2768cfmr715509a91.6.1792192999851; 
 Fri, 16 Oct 2026 16:23:19 -0700 (PDT)
X-Received: by 2002:a17:90b:580c:b0:3a8:337d:228a with SMTP id
 98e67ed59e1d1-3acee2768cfmr715469a91.6.1792192998274; 
 Fri, 16 Oct 2026 16:23:18 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd0cde4fdsm2829304a91.4.2026.10.16.16.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:23:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 6/9] target/riscv: prefix helpers conflicting with other
 arch
Date: Fri, 16 Oct 2026 16:23:01 -0700
Message-ID: <20261016232304.1215119-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX5JBhsABWc3SZ
 lrMAdOsFHkx5oUHQ0n2zbrSGhFzpInEwivAFsMSs34LpvJP+KfkrifJIqRRosJGH3loa5TrxNkE
 JTI3NG5k6koR/nwZxR++/pkISMNlG+o=
X-Proofpoint-ORIG-GUID: zq47U4183b92QeMd5SK48-OwQUxptrdp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA5MyBTYWx0ZWRfX9GRILPHnz4zw
 KF6J/wUpcpnaLoTFAqW2LdR2qjVWSlsehbmBHIWSBxYZoFPLIU3gMw1qxOA6y97UrWWbL0kHmW3
 zbgS0f3DpeTUZiB/nhC30XqUZ/iIV6rlHzdmIS+3XKGODlFtSc1AD/UfKJfiys0Kvo3nC3GlX2L
 p/GV6rvPTN5LuDWC07XAF5BIT32f8XjWBgueJPETM9IIVmyD1oc+zeXImw0Tlv1cCLKLhrrdOb7
 AU1SKhJ+sneo4mFUPGFGyWTWZELaIAN89izihvpbUiaFp8Wcp2c7untbmvFgO8vR9TgqjMaJ008
 BXVHq5g6yjBHlhGnAIagTT81mTK3bXGnjEw2pyJXWJ8LdtKQ89gUMDBplcMzp3Z4ksz+Cl1NVij
 mRiyIxkP0VkDm5OBDWhdL1DISN2ob60ql24UtXcNzEfU54mXVWChQmIAJlhLz9CrLGulLkqriPx
 23KN11RBMz/yBjWlumw==
X-Proofpoint-GUID: zq47U4183b92QeMd5SK48-OwQUxptrdp
X-Authority-Analysis: v=2.4 cv=XKKl2ghE c=1 sm=1 tr=0 ts=6ad2b1e8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ESivkgfRQ2zMwmjiJYwA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160093
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

List of helpers:
- fadd_s
- fsub_s
- fdiv_s
- fsqrt_s
- fadd_d
- fsub_d
- fdiv_d
- fsqrt_d
- crc32
- crc32c
- raise_exception
- wfi

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/helper.h                         | 24 +++++++++----------
 target/riscv/tcg/bitmanip_helper.c            |  4 ++--
 target/riscv/tcg/fpu_helper.c                 | 16 ++++++-------
 .../tcg/insn_trans/trans_privileged.c.inc     |  2 +-
 target/riscv/tcg/insn_trans/trans_rvd.c.inc   |  8 +++----
 target/riscv/tcg/insn_trans/trans_rvf.c.inc   |  8 +++----
 target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  4 ++--
 .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  2 +-
 target/riscv/tcg/insn_trans/trans_xlrbr.c.inc |  4 ++--
 target/riscv/tcg/op_helper.c                  |  4 ++--
 target/riscv/tcg/translate.c                  |  4 ++--
 11 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 372f1049726..6aae192112a 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1,5 +1,5 @@
 /* Exceptions */
-DEF_HELPER_2(raise_exception, noreturn, env, i32)
+DEF_HELPER_2(riscv_raise_exception, noreturn, env, i32)
 
 /* Floating Point - rounding mode */
 DEF_HELPER_FLAGS_2(set_rounding_mode, TCG_CALL_NO_WG, void, env, i32)
@@ -20,15 +20,15 @@ DEF_HELPER_FLAGS_4(fnmadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(fnmadd_h, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 
 /* Floating Point - Single Precision */
-DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
-DEF_HELPER_FLAGS_3(fsub_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(riscv_fadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(riscv_fsub_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmul_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
-DEF_HELPER_FLAGS_3(fdiv_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(riscv_fdiv_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmin_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fminm_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmax_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmaxm_s, TCG_CALL_NO_RWG, i64, env, i64, i64)
-DEF_HELPER_FLAGS_2(fsqrt_s, TCG_CALL_NO_RWG, i64, env, i64)
+DEF_HELPER_FLAGS_2(riscv_fsqrt_s, TCG_CALL_NO_RWG, i64, env, i64)
 DEF_HELPER_FLAGS_3(fle_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
 DEF_HELPER_FLAGS_3(fleq_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
 DEF_HELPER_FLAGS_3(flt_s, TCG_CALL_NO_RWG, tl, env, i64, i64)
@@ -47,17 +47,17 @@ DEF_HELPER_FLAGS_2(fround_s, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(froundnx_s, TCG_CALL_NO_RWG_SE, i64, env, i64)
 
 /* Floating Point - Double Precision */
-DEF_HELPER_FLAGS_3(fadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
-DEF_HELPER_FLAGS_3(fsub_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(riscv_fadd_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(riscv_fsub_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmul_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
-DEF_HELPER_FLAGS_3(fdiv_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(riscv_fdiv_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmin_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fminm_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmax_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(fmaxm_d, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(fcvt_s_d, TCG_CALL_NO_RWG, i64, env, i64)
 DEF_HELPER_FLAGS_2(fcvt_d_s, TCG_CALL_NO_RWG, i64, env, i64)
-DEF_HELPER_FLAGS_2(fsqrt_d, TCG_CALL_NO_RWG, i64, env, i64)
+DEF_HELPER_FLAGS_2(riscv_fsqrt_d, TCG_CALL_NO_RWG, i64, env, i64)
 DEF_HELPER_FLAGS_3(fle_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
 DEF_HELPER_FLAGS_3(fleq_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
 DEF_HELPER_FLAGS_3(flt_d, TCG_CALL_NO_RWG, tl, env, i64, i64)
@@ -83,8 +83,8 @@ DEF_HELPER_FLAGS_1(unzip, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(zip, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(xperm4, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 DEF_HELPER_FLAGS_2(xperm8, TCG_CALL_NO_RWG_SE, tl, tl, tl)
-DEF_HELPER_FLAGS_2(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl)
-DEF_HELPER_FLAGS_2(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl)
+DEF_HELPER_FLAGS_2(riscv_crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl)
+DEF_HELPER_FLAGS_2(riscv_crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 
 /* Floating Point - Half Precision */
 DEF_HELPER_FLAGS_3(fadd_h, TCG_CALL_NO_RWG, i64, env, i64, i64)
@@ -135,7 +135,7 @@ DEF_HELPER_1(mret, tl, env)
 DEF_HELPER_1(dret, tl, env)
 DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(ctr_clear, void, env)
-DEF_HELPER_1(wfi, void, env)
+DEF_HELPER_1(riscv_wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
 DEF_HELPER_1(tlb_flush_all, void, env)
diff --git a/target/riscv/tcg/bitmanip_helper.c b/target/riscv/tcg/bitmanip_helper.c
index d8d94bca7ba..5af3efe194d 100644
--- a/target/riscv/tcg/bitmanip_helper.c
+++ b/target/riscv/tcg/bitmanip_helper.c
@@ -117,7 +117,7 @@ target_ulong HELPER(xperm8)(target_ulong rs1, target_ulong rs2)
     return do_xperm(rs1, rs2, 3);
 }
 
-target_ulong HELPER(crc32)(target_ulong rs1, target_ulong sz)
+target_ulong HELPER(riscv_crc32)(target_ulong rs1, target_ulong sz)
 {
     for (target_ulong i = 0; i < sz; i++) {
         rs1 = crc32_table[rs1 & 0xFF] ^ (rs1 >> 8);
@@ -126,7 +126,7 @@ target_ulong HELPER(crc32)(target_ulong rs1, target_ulong sz)
     return rs1;
 }
 
-target_ulong HELPER(crc32c)(target_ulong rs1, target_ulong sz)
+target_ulong HELPER(riscv_crc32c)(target_ulong rs1, target_ulong sz)
 {
     for (target_ulong i = 0; i < sz; i++) {
         rs1 = crc32c_table[rs1 & 0xFF] ^ (rs1 >> 8);
diff --git a/target/riscv/tcg/fpu_helper.c b/target/riscv/tcg/fpu_helper.c
index db1475271b6..85fc419eb95 100644
--- a/target/riscv/tcg/fpu_helper.c
+++ b/target/riscv/tcg/fpu_helper.c
@@ -230,14 +230,14 @@ uint64_t helper_fnmadd_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                       float_muladd_negate_c | float_muladd_negate_product);
 }
 
-uint64_t helper_fadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t helper_riscv_fadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
     return nanbox_s(env, float32_add(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fsub_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t helper_riscv_fsub_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
@@ -251,7 +251,7 @@ uint64_t helper_fmul_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return nanbox_s(env, float32_mul(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fdiv_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t helper_riscv_fdiv_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
@@ -292,7 +292,7 @@ uint64_t helper_fmaxm_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return nanbox_s(env, ret);
 }
 
-uint64_t helper_fsqrt_s(CPURISCVState *env, uint64_t rs1)
+uint64_t helper_riscv_fsqrt_s(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     return nanbox_s(env, float32_sqrt(frs1, &env->fp_status));
@@ -434,12 +434,12 @@ uint64_t helper_froundnx_s(CPURISCVState *env, uint64_t rs1)
     return nanbox_s(env, frs1);
 }
 
-uint64_t helper_fadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t helper_riscv_fadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return float64_add(frs1, frs2, &env->fp_status);
 }
 
-uint64_t helper_fsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t helper_riscv_fsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return float64_sub(frs1, frs2, &env->fp_status);
 }
@@ -449,7 +449,7 @@ uint64_t helper_fmul_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
     return float64_mul(frs1, frs2, &env->fp_status);
 }
 
-uint64_t helper_fdiv_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t helper_riscv_fdiv_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return float64_div(frs1, frs2, &env->fp_status);
 }
@@ -489,7 +489,7 @@ uint64_t helper_fcvt_d_s(CPURISCVState *env, uint64_t rs1)
     return float32_to_float64(frs1, &env->fp_status);
 }
 
-uint64_t helper_fsqrt_d(CPURISCVState *env, uint64_t frs1)
+uint64_t helper_riscv_fsqrt_d(CPURISCVState *env, uint64_t frs1)
 {
     return float64_sqrt(frs1, &env->fp_status);
 }
diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
index e22df6fbe71..4f18b6c3fa4 100644
--- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
@@ -168,7 +168,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
     gen_update_pc(ctx, ctx->cur_insn_len);
-    gen_helper_wfi(tcg_env);
+    gen_helper_riscv_wfi(tcg_env);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
 #else
diff --git a/target/riscv/tcg/insn_trans/trans_rvd.c.inc b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
index 1be2bee9465..596a4ad888e 100644
--- a/target/riscv/tcg/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
@@ -194,7 +194,7 @@ static bool trans_fadd_d(DisasContext *ctx, arg_fadd_d *a)
     TCGv_i64 src2 = get_fpr_d(ctx, a->rs2);
 
     gen_set_rm(ctx, a->rm);
-    gen_helper_fadd_d(dest, tcg_env, src1, src2);
+    gen_helper_riscv_fadd_d(dest, tcg_env, src1, src2);
     gen_set_fpr_d(ctx, a->rd, dest);
     mark_fs_dirty(ctx);
     return true;
@@ -211,7 +211,7 @@ static bool trans_fsub_d(DisasContext *ctx, arg_fsub_d *a)
     TCGv_i64 src2 = get_fpr_d(ctx, a->rs2);
 
     gen_set_rm(ctx, a->rm);
-    gen_helper_fsub_d(dest, tcg_env, src1, src2);
+    gen_helper_riscv_fsub_d(dest, tcg_env, src1, src2);
     gen_set_fpr_d(ctx, a->rd, dest);
     mark_fs_dirty(ctx);
     return true;
@@ -245,7 +245,7 @@ static bool trans_fdiv_d(DisasContext *ctx, arg_fdiv_d *a)
     TCGv_i64 src2 = get_fpr_d(ctx, a->rs2);
 
     gen_set_rm(ctx, a->rm);
-    gen_helper_fdiv_d(dest, tcg_env, src1, src2);
+    gen_helper_riscv_fdiv_d(dest, tcg_env, src1, src2);
     gen_set_fpr_d(ctx, a->rd, dest);
     mark_fs_dirty(ctx);
     return true;
@@ -261,7 +261,7 @@ static bool trans_fsqrt_d(DisasContext *ctx, arg_fsqrt_d *a)
     TCGv_i64 src1 = get_fpr_d(ctx, a->rs1);
 
     gen_set_rm(ctx, a->rm);
-    gen_helper_fsqrt_d(dest, tcg_env, src1);
+    gen_helper_riscv_fsqrt_d(dest, tcg_env, src1);
     gen_set_fpr_d(ctx, a->rd, dest);
     mark_fs_dirty(ctx);
     return true;
diff --git a/target/riscv/tcg/insn_trans/trans_rvf.c.inc b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
index 636dec1664d..551c9b39861 100644
--- a/target/riscv/tcg/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
@@ -178,7 +178,7 @@ static bool trans_fadd_s(DisasContext *ctx, arg_fadd_s *a)
     TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
 
     gen_set_rm(ctx, a->rm);
-    gen_helper_fadd_s(dest, tcg_env, src1, src2);
+    gen_helper_riscv_fadd_s(dest, tcg_env, src1, src2);
     gen_set_fpr_hs(ctx, a->rd, dest);
     mark_fs_dirty(ctx);
     return true;
@@ -194,7 +194,7 @@ static bool trans_fsub_s(DisasContext *ctx, arg_fsub_s *a)
     TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
 
     gen_set_rm(ctx, a->rm);
-    gen_helper_fsub_s(dest, tcg_env, src1, src2);
+    gen_helper_riscv_fsub_s(dest, tcg_env, src1, src2);
     gen_set_fpr_hs(ctx, a->rd, dest);
     mark_fs_dirty(ctx);
     return true;
@@ -226,7 +226,7 @@ static bool trans_fdiv_s(DisasContext *ctx, arg_fdiv_s *a)
     TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
 
     gen_set_rm(ctx, a->rm);
-    gen_helper_fdiv_s(dest, tcg_env, src1, src2);
+    gen_helper_riscv_fdiv_s(dest, tcg_env, src1, src2);
     gen_set_fpr_hs(ctx, a->rd, dest);
     mark_fs_dirty(ctx);
     return true;
@@ -241,7 +241,7 @@ static bool trans_fsqrt_s(DisasContext *ctx, arg_fsqrt_s *a)
     TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
 
     gen_set_rm(ctx, a->rm);
-    gen_helper_fsqrt_s(dest, tcg_env, src1);
+    gen_helper_riscv_fsqrt_s(dest, tcg_env, src1);
     gen_set_fpr_hs(ctx, a->rd, dest);
     mark_fs_dirty(ctx);
     return true;
diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index cc1b5dbbadc..8d63efe09b5 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
@@ -55,7 +55,7 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
          */
         tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
                         tcg_env, offsetof(CPURISCVState, sw_check_code));
-        gen_helper_raise_exception(tcg_env,
+        gen_helper_riscv_raise_exception(tcg_env,
                       tcg_constant_i32(RISCV_EXCP_SW_CHECK));
         return true;
     }
@@ -68,7 +68,7 @@ static bool trans_lpad(DisasContext *ctx, arg_lpad *a)
         tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, a->label, skip);
         tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
                         tcg_env, offsetof(CPURISCVState, sw_check_code));
-        gen_helper_raise_exception(tcg_env,
+        gen_helper_riscv_raise_exception(tcg_env,
                       tcg_constant_i32(RISCV_EXCP_SW_CHECK));
         gen_set_label(skip);
     }
diff --git a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
index d47a9f9c7d2..0556f37805a 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
@@ -43,7 +43,7 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
     tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
                     tcg_env, offsetof(CPURISCVState, sw_check_code));
-    gen_helper_raise_exception(tcg_env,
+    gen_helper_riscv_raise_exception(tcg_env,
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
     gen_set_label(skip);
     tcg_gen_addi_tl(addr, addr, tmp);
diff --git a/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc b/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
index 01da2b6ce1d..795231f0839 100644
--- a/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
@@ -29,11 +29,11 @@ static bool gen_crc(DisasContext *ctx, arg_r2 *a,
 #define TRANS_CRC32(NAME, SIZE) \
     static bool trans_crc32_##NAME(DisasContext *ctx, arg_r2 *a) \
     { if (SIZE == 8) { REQUIRE_64BIT(ctx); }; \
-      return gen_crc(ctx, a, gen_helper_crc32, tcg_constant_tl(SIZE)); }
+      return gen_crc(ctx, a, gen_helper_riscv_crc32, tcg_constant_tl(SIZE)); }
 #define TRANS_CRC32C(NAME, SIZE) \
     static bool trans_crc32c_##NAME(DisasContext *ctx, arg_r2 *a) \
     { if (SIZE == 8) { REQUIRE_64BIT(ctx); }; \
-      return gen_crc(ctx, a, gen_helper_crc32c, tcg_constant_tl(SIZE)); }
+      return gen_crc(ctx, a, gen_helper_riscv_crc32c, tcg_constant_tl(SIZE)); }
 
 TRANS_CRC32(b, 1);
 TRANS_CRC32(h, 2);
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index b8b3e43ccd5..3df01016dfa 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -48,7 +48,7 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
     cpu_loop_exit_restore(cs, pc);
 }
 
-void helper_raise_exception(CPURISCVState *env, uint32_t exception)
+void helper_riscv_raise_exception(CPURISCVState *env, uint32_t exception)
 {
 #ifndef CONFIG_USER_ONLY
     riscv_pmu_decr_instret(env);
@@ -625,7 +625,7 @@ void helper_ctr_clear(CPURISCVState *env)
     riscv_ctr_clear(env);
 }
 
-void helper_wfi(CPURISCVState *env)
+void helper_riscv_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
     bool rvs = riscv_has_ext(env, RVS);
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index ede9c2563f7..2ffbf26bb19 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -259,7 +259,7 @@ static void gen_update_pc(DisasContext *ctx, target_long diff)
 static void generate_exception(DisasContext *ctx, RISCVException excp)
 {
     gen_update_pc(ctx, 0);
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
+    gen_helper_riscv_raise_exception(tcg_env, tcg_constant_i32(excp));
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
@@ -1407,7 +1407,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         tcg_ctx->emit_before_op = QTAILQ_NEXT(ctx->base.insn_start, link);
         tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
                         tcg_env, offsetof(CPURISCVState, sw_check_code));
-        gen_helper_raise_exception(tcg_env,
+        gen_helper_riscv_raise_exception(tcg_env,
                       tcg_constant_i32(RISCV_EXCP_SW_CHECK));
         tcg_ctx->emit_before_op = NULL;
         ctx->base.is_jmp = DISAS_NORETURN;
-- 
2.47.3


