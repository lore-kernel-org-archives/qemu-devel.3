Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3447CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPol1-0004iq-Pu; Wed, 20 May 2026 17:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wPol0-0004iP-Bk
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:47:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wPoky-0003Ag-H7
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:47:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KFR2cj4115189
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=0LUPazkY252ZfDmvIkH/3reOlRK37BNk1/G
 ET75yJGI=; b=cDccgQmbK7deeeqzrhJ9JHP55yZBDBOKNIQ8zkpSAmkWbxWwo/R
 aX2c65iTuADCL4yOFrI2a+nm0HJKXRlg2LU4pcsUdsBmt4XiFDd05h117GkY/MOA
 OpYa7dU8trWgNOsMOLJ8r97rRWBoqmntPhe0ZN+K2siIE5/rUI89VSt2sjT6d7Yx
 3w5c/0TztRGmnVIvMF7ly3hXBpxSj0lXsoZ58x5V9w2/EILQTjSkkoolyYjguvKG
 bF+ARXR7wyZPaiffufj8CGJ3doLoojuOFA7vYR8Imh5PkEGO3+iWwfVtW5mrbKqU
 Jo/VzrxFY9CqUnROMcgLAHmKHyXw8Z0hcSA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e99w0jyf0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:47:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-90fbc9782c9so1318111285a.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779313630; x=1779918430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0LUPazkY252ZfDmvIkH/3reOlRK37BNk1/GET75yJGI=;
 b=Vp8Ykw0jrpQco1sRfbDmzGevjQ18MkJjPKQ63SnqlCxBuZblsSlO6KXRxxV2T8f0bc
 dursV35SN87c/KtMRWbFFN33UV43LcOOU+Wu0/oOtFUHjpW2441rdHOkjEWn6h+nV9KQ
 QdR/immA5XoTV5MUzJzkX4jnIuZKOJ3+Y4fTpKEr3vFr2vMfYv0n2q0EwcWqbHkbYyI9
 SlveTkw1/hbehzSvtEkwmI/iNqGnzWSRqYzpqo88YV3kOc+/Dh59s4DWKSDkfZRipJd4
 tlAHYBJE1h+0siJFBPPZli5NRgHOROLPhvMVn2Gd0GMUdWBUY0C/oNsCzPs/4qgdNvLc
 NdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779313630; x=1779918430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LUPazkY252ZfDmvIkH/3reOlRK37BNk1/GET75yJGI=;
 b=TfF8RTS7TwvRcm2bKzb7vbsH+2UzfevcoPmCdRYYckMOOQECAqE9iASqdpC9J0RVl9
 j9kdHxydiIxh2sEHUk5w+F9LjnBdckVOMQRfPRkIHHmkpluCfEqK343gP7tRowTORTOi
 uT6GdWwPpNGuLrVE2W8vMUUgEKhghBYOeJV7EZHT2hbXncPsUC8b3Az4se4msWtyG5XG
 tgGy99bxIzr8kw9oqh2b1g15Ok2b/8RRbvm9NACZAs7Nbtg+mAinzuSib4CHC4zc9VFj
 HnJtN9gHMtaQFvL4bsNKFyReVgr8DqbNdpnL4eoojk04RrkvyW8vy6Ww91uIhaIDICH+
 3L3g==
X-Gm-Message-State: AOJu0Yxxx/O6C2gQVUPWVMAtlzqjQnkAWtZz5RZai0+7bMvtWFVIQKb+
 gNTIKq1QWYHgrR+8h3ifPDGcjVRVM/X1ZMZ7hyJKzWrQPl2wsohYClE+VKsx7wi60364phEd47k
 3iQ1JfvPcvi8MkRkl9C0LWFqng32ElNYSlvN6cNri47z/MER965vqnSxW0rK77NVK8g==
X-Gm-Gg: Acq92OFMFSECugLTIhH+weI+MXajFAzIZ2/Vgq9fYSmQUum56CdYRz7aWaTOFrt16in
 45/gUe2QYHAA1TamCoIE0vOT9i7q7UkSTFi/205eQczVPUGW9zdQEMbuy/5pd/p61sUU6hqnV/5
 GvQyieFdVtf3pF/0QmRF+Zn5qWxQlrkMTvYuiF7WRY0H4Ni2OB/azyPp8JVQHGJSrUqmIWufXxU
 Ks25p9Dy11yrRhlROuvhmMl69cI8ZwutcaXQ/PDv/LX7bk1umKSST1mYwRwVY0XeqBfBI7kmDXy
 6G84esEJoLrljbCtYZD2lro999ZgyF+5rAxnmdHgaDAiMB7sDD0brUFJVEEN8Esxuj69Qb7u4cO
 1lpP0ZYMgmmBdefrgpEv0OaQwu1fyWJ/uBhjEj3QnYzPj2lJlXZun9WJf2Ihy
X-Received: by 2002:a05:620a:19a1:b0:911:3e08:23fa with SMTP id
 af79cd13be357-914a2a63a2dmr8328485a.19.1779313629546; 
 Wed, 20 May 2026 14:47:09 -0700 (PDT)
X-Received: by 2002:a05:620a:19a1:b0:911:3e08:23fa with SMTP id
 af79cd13be357-914a2a63a2dmr8324985a.19.1779313629089; 
 Wed, 20 May 2026 14:47:09 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca36190497sm132027896d6.29.2026.05.20.14.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:47:08 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] target/riscv/insn_trans/trans_rvzicbo.c.inc: save opcode
 before helpers
Date: Wed, 20 May 2026 18:47:04 -0300
Message-ID: <20260520214704.1943652-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oPrDIwX2D1jBGLRcuJa-qWbRUppkd_iw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIxMyBTYWx0ZWRfX7oxnml1JCQU1
 KWw9EpJzfHD7rgnOADuFjUCKO47DMTj469556IZnl+o1VMNX41FnNjLmFpMt/rEwwApuhgrEhNA
 8bFzkbql9jLDtUZxoHddjZUJkt6mVo54jPdy5HNjCZZTG+FVAXO2EJ3bNqzBRbX0cTe7ma6zLly
 hYuu9wEtLgGp0aVx75ED1PoKECir6726oeuLSqY4ODoh+ElhiZjVPc1DwuJle/psIvEhhWjvjuR
 JhmT5erMNY/2JT/Il+6OVmNzN9zHKArSA2sxM8VVKdu1KbFI0f2oU/cq8ZfquIQ3o1i4OoOC6X8
 wN8lVAlZcCTNS6sewOIUNJQBU9eSCjK4P55ZnFS2UASivXIXJNnFsQ45qBpxVvqWx55lzhy4i77
 lOTrKbhahAboaVPmJWgCOjqz3NCg/dFtd712l+6o+/Kt4DM63deAEtwIT6IIl8csh+pFUKkwX5D
 ACPU2kXH99zMu5IFzvQ==
X-Authority-Analysis: v=2.4 cv=RZigzVtv c=1 sm=1 tr=0 ts=6a0e2bde cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=zPVu6S-7jbvgiBxhS2sA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: oPrDIwX2D1jBGLRcuJa-qWbRUppkd_iw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200213
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

All helpers from this file can trigger ILLEGAL_INSN exceptions via
check_zicbo_envcfg() directly, bypassing the usual exception code from
translate.c.   If we don't save the opcode before each helper,
riscv_raise_exception() is triggered and env->bins won't be unwind during
cpu_loop_exit_restore() (code path cpu_restore_state ->
cpu_restore_state_from_tb() -> restore_state_to_opc()).

And finally, in riscv_cpu_do_interrupt(), we will set (m)tval = 0 when we can,
instead, set it to the cbo opcode that generated the exception.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3380
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/insn_trans/trans_rvzicbo.c.inc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/insn_trans/trans_rvzicbo.c.inc
index 15711c3140..096f7dde27 100644
--- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
@@ -33,6 +33,8 @@ static bool trans_cbo_clean(DisasContext *ctx, arg_cbo_clean *a)
     REQUIRE_ZICBOM(ctx);
     TCGv src = get_address(ctx, a->rs1, 0);
 
+    /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
+    decode_save_opc(ctx, 0);
     gen_helper_cbo_clean_flush(tcg_env, src);
     return true;
 }
@@ -42,6 +44,8 @@ static bool trans_cbo_flush(DisasContext *ctx, arg_cbo_flush *a)
     REQUIRE_ZICBOM(ctx);
     TCGv src = get_address(ctx, a->rs1, 0);
 
+    /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
+    decode_save_opc(ctx, 0);
     gen_helper_cbo_clean_flush(tcg_env, src);
     return true;
 }
@@ -51,6 +55,8 @@ static bool trans_cbo_inval(DisasContext *ctx, arg_cbo_inval *a)
     REQUIRE_ZICBOM(ctx);
     TCGv src = get_address(ctx, a->rs1, 0);
 
+    /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
+    decode_save_opc(ctx, 0);
     gen_helper_cbo_inval(tcg_env, src);
     return true;
 }
@@ -60,6 +66,8 @@ static bool trans_cbo_zero(DisasContext *ctx, arg_cbo_zero *a)
     REQUIRE_ZICBOZ(ctx);
     TCGv src = get_address(ctx, a->rs1, 0);
 
+    /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
+    decode_save_opc(ctx, 0);
     gen_helper_cbo_zero(tcg_env, src);
     return true;
 }
-- 
2.43.0


