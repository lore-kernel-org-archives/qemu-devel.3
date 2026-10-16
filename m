Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C091CCCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmfU-0007iy-JC; Fri, 16 Oct 2026 14:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmey-0007dD-5f
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmeu-0002x0-So
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:28:03 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE65VW1451773
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Xn5yLlAal5E
 dekAgD06heSprBaA9iowyGv1vatdfD5o=; b=N01RYkpr5MF+rORcI/6/li8PmFV
 u1OXwo06vvzorqKc2s9WkV3fJFhrmsU3tShuTogSBIVj5nKDAi8z45FCKegmv79h
 WBxSjg1VkzDQNbBtOYlKZIO9kHEpRS5SNUO09zUMEru0Enus0YOOLo43SjvqiFrK
 YNBkKA+6YNjp+6q0szG25pjDg7RoXYK454C/VsPtEPhpViQSH6fYnpDjdISfebli
 TLFMgm+ROoOHiWeNERBOemh/wdOvySzoKTLxogeUT0Qi97WVJm5EsxbTrrYM71Tg
 tIroaCAs2QBjBv1EXYrJHFq3SVEymBOpzwicQShx7WoCzvvyLcWc7DudAjg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhur1uxf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:27:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd1e45a268cso135307a12.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792175279; x=1792780079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xn5yLlAal5EdekAgD06heSprBaA9iowyGv1vatdfD5o=;
 b=EF7BpqcIBXUHQOxibuEgt0BhtUuhSAB22pKkaBa3KJQkbpmALiOt+aizECx12DVYMD
 FrbroE0Yzk4F/a8tIwVIUQoM76yS9DilpoEQyMf2WJlDCHwDJmsfs8FcAOSEl+rrVLiN
 2uvRGhOWYbqx3kfws7PA40a4s0HH4K4GERUHtAu0rElYJqFCIk0e//1XyaVNFo3za8DR
 jOI5TSDng/liPjCjdfHKimC1z8welULl/PI8LOA+MujDUceHhkko6UxrhdR4QaeVrPLh
 D/bz59+Z1atH1WiSHv284rc9u60Q0fTE3kyFtarGgBI2j3j9IVsmbaTo88QkGUdF6ZZX
 D6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792175279; x=1792780079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xn5yLlAal5EdekAgD06heSprBaA9iowyGv1vatdfD5o=;
 b=rmwl7Qy0rlClkh4fXZR/IkqSo7c4vN8lVnhG6eKl7J0pHvp7ZphQx8x453xLoOy34t
 bn0jSHM7aEP4tgG1OQHSg+BfTBbC0Q3/OAudnhtzpSiGaUjly0hEk7W66g4TUfSDL4eK
 0OG/jhujVSgNrE+S2CL2wrPLx9ZLVY8513ax4nGA00G3JOMuvrhv9163B3TnuScze7Ii
 Hnefw5eS0ZN992iTP3RgGWWGsgbbABtnZtyIRJ8b1OoZE0FGKBr3cmeptsjrHvy93bly
 PQCvVzmGsoYvOa8E3YEN1I3ul5brRBqXvub4sgLFEfTTtSkKtlZ4rloEzsQ0NhsZXtCG
 dE3Q==
X-Gm-Message-State: AFq9FYLn9G6lSQamaRaqGSt/7wM9yKiDOH0wW6uWKp42hV6xsRfd30Eb
 5PBzNZiyWeJcZmW1MoVBaXJpnmMSE7LWRYcfb8BYLq9FmhiYaCpnmpwBQ2Y6Q2zL8gubhfY4Tn8
 ENla+lZ/s0vL+bCIxOEmzY2Hvnu1icSfi6AQ6vSEV747dGR9sgopsmQvSxqGOEeJtqg==
X-Gm-Gg: AYBFou0CgP+oF80qsFjtsj9OpEhCd4M4hdJwMfojC1SDO0BExv2XAauHvSUO1ixkTWx
 ZniLDeS3a+6OP/kNquSjDBtZVCDAfwAT3ouySDn5zOe/lLUkNpGWeNkqzvhXk5F6+lQLNoGmi5s
 hejn+rqxHPLmLZSsefWEHFiGkXPV/VMVaCWbA0AeEgXyFE1nvHy5cjS70IXaVFbZ1M0ACojI7/D
 wHYpQh+J23ltjHJX34xnop51gP7Mq2CuyyuxEybFL+d6ZEEVBztPHhZMOuJYL8z1ZScOIjwvmvn
 UPVjbWY77FXe94UZNsKZ3jhcXDYEd82NTLl9OO59TkYlReVh1X2ktO/BbQ78ndemuP8dO/y5/XG
 DmxCrzZypweXBF4XYFfvBCzeBIgO9EwsMO0tZOJUO1XYAukukmcf6qhz4pMAVXCU=
X-Received: by 2002:a05:6a20:c5aa:b0:3dd:a195:fa22 with SMTP id
 adf61e73a8af0-3e22606feebmr160676637.71.1792175278518; 
 Fri, 16 Oct 2026 11:27:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:c5aa:b0:3dd:a195:fa22 with SMTP id
 adf61e73a8af0-3e22606feebmr160603637.71.1792175277220; 
 Fri, 16 Oct 2026 11:27:57 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6549c7034sm1557291a12.16.2026.10.16.11.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:27:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/6] target/riscv: prefix helpers conflicting with other arch
Date: Fri, 16 Oct 2026 11:27:48 -0700
Message-ID: <20261016182751.264704-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfX3U7SoJm06loq
 ZWEkwvihMA0DfGyU1TzKm4ChvbgA8UTrGr0R2hJ1FSMNIbq9nk7+lPRuyncMn/JAYMF2JHa330o
 OML+d4tLc4exDclM7i68GHmeUVmKrTPBpy+o9yim8M165VEC798r5X3xLecdLcMVfhwqccw2Ca+
 WuPQbiZfYxRtp0RyEvhwuz0uM2DCTLjLcHF3EhgwIFt+oEzkKPJKZ93XVcGPXgF5XWHoKVwK4Yt
 +EvSdGQzq6p4GFUJYCfBzetxL76wrflIfrL+u6WdThS7unjii3OF3K1gFSlqpgbpYqgbUEx9KF5
 DpRF1pIkLlOSfVqQQoDLuL4MhHNoR646zdHAMnFRk/jWeYQUG0ekWKKIgFD3Xiq9/55Nhn753ME
 7fmV7PcllZ9kzwss3jQj6v9AglUBAfN8/ovI4WwThEdCwz3QFr15a2xBnTSUMQJP4JDF7HWJAR5
 cTJEmpQqzNhBsUw6i2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MyBTYWx0ZWRfX11BR/0V7ZMoc
 MSC6PhURwvCqvSJbf4v4jAtoovQh4BILwlg2Rgrn1sVqTYwi0XrwITvHEYMcxANnb6mQ/NIYzhn
 WtYpmgECzo+i/h8bc4P7ncDIwvtMCnE=
X-Authority-Analysis: v=2.4 cv=PqsG/AM3 c=1 sm=1 tr=0 ts=6ad26caf cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=xvrvNg-cL0jB7nB0D5MA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: mY3V1lPA8zJkioEIweViC5TXjv4D368Z
X-Proofpoint-GUID: mY3V1lPA8zJkioEIweViC5TXjv4D368Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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


