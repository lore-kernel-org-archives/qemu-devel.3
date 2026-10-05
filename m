Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C58FCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqBM-0006xQ-Vr; Mon, 05 Oct 2026 17:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqBK-0006wS-5N
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:25:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqBI-0001EC-2V
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:25:09 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695KN7u03925839
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 21:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p/bonR61ADK/maRXbec+ZAJNDa4QrZHG/F5/k7ke5EU=; b=XEOY57SMXmkQ8r8r
 i05SOkEefemqOsMk9CCA36nc8qur5NtY9G5O5AtI+Zt7EFWGe6sP5lOGdCHhwlhs
 1cIoBOTM9KND1FJl9y1/wlyVdNpay7TvLiTV82OfMKuoDWwdT7uMqS6KUbv1oNCu
 tS7dwZviussinJZZzl72cofGn3HbxC+NtnWun7wmG5WlxhtliVpBameQE/tgEUWU
 QblN6RiP7cLmNCNymkceR+pz+7yu0mhZpYSaANaN2uciqLr+iWhQxULfENb3Sfud
 atGHsZDtoVqw/BE6ikuS1GZVRko8i+GaJo/UqLoc2wqxeVBrhh5NW80LUSN9r4TO
 JIP9dA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49u42gmx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:25:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34d62bb27a1so8997690eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 14:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791235505; x=1791840305; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p/bonR61ADK/maRXbec+ZAJNDa4QrZHG/F5/k7ke5EU=;
 b=DZiE3MydG2qPn9r64kk0L0EEi31kIdHeUMuLWblRKR6F/q+XvQwk2UpVzcJa1mIRHa
 Ee1ZrCswvgeb13X5McL4J8WNJ+pNWkuVSCo5IPSXRim6s04T/Nhbr6Xpxkwb5X6elRe5
 q1d4MH+E9n1ssieWVMOkiNej9dAQTGzCdn/PCe1sKKiG4JtiQLarpszMfUA/40Kw3G9I
 qFFNx+jgyD/zl9KJHVyIqHo4l31pYhXUwSO9SpjV1iH1On3QBU6KMeM/x4B5GjFb0MqU
 7ZwaaN+EuNfWXSgGzRCQlx1wmQ6Ct90DnjAxgo+YZI2cDLfZtRZFGWhOnk76aekkCXFx
 Yeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791235505; x=1791840305;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p/bonR61ADK/maRXbec+ZAJNDa4QrZHG/F5/k7ke5EU=;
 b=HieLnHG030KWJy9iSecOXaua+UOXfQmB3dfYfyLXmQRQ458EIlZ+5rjwwYrW3EhWmV
 A97vI6dNdFWnxt4g47eSQzPg4tSqatVwR1ZvGbm+XpBK6OzHhB7cy20Jc26dvanN7UmP
 yrYx7elfV9cAeZ4Q+Qu5jmSC58a6vp7R4vN06j+SnPRfS1PmKGx36iieQHKzGlMvacec
 K8Ms8Q2Ek8yRme2HEdiBxrYIjyyeRROLO6GxNFkcMgT0Ta5egUiPG/UnnrQ3uXNXAXqK
 EVM5hQfPu53llw89GQBLDZhLOPevfCUaZtpAOrSR6Yb9//8byJzClBwxLPxP5u7k2iiq
 ywUA==
X-Gm-Message-State: AFuF++lOrOFUWvawGPWfCOWAlcgkp+ltiMjx1/yyd4AAP1Ta/2FB72Dy
 KsMik2rvrhS78iMck7UD94K0MOlfI8kMTGxYSvMsp9vdBzCxP/G1cbyqbui/UZ11xs5/xEf/gEC
 VTUmXkT0KPe+yBOxQXYi69uFmjV5kYcVqvrQdjtwzU260o1kw8AgUNIDy15f7mrfQcw==
X-Gm-Gg: AYBFou2TfT0YsZ1Kymip9LgvjRP90qke9k6Nh6mTOZ40QC3jqM7m4v7WLzwIJE5M0v2
 bXfrwiU9t7fwd82YJ/KGoWZkoKHj+fYlzg6LH/1+Eim4z3rBxbL+ZL1TcAEc2zW0RPIH3udHr7G
 kUcUgY8GpwjKauNME4a+N8RwTIF+eroSrs+B1Ks4TwgmKhTeRtMnDuQy2w3oo3C3ds4SLdKNYVg
 9k0WYF5eKndkmUQINM3ip5Sxdos5eiDbH/NuxXAfEZeydqx8FrtdlqyOov9nZ5CwInz/HkHzWoY
 vweIm6iz6XCgrJQwNSrwOQDJCpK+AXySRkEKVsvjauobdXx4AfnMhbluhZRZFE5MEtvNp2gFt/7
 HK8HWFyq9kcl6BG74tyoY9rmpI2dhQJsqCqkU813wISmZwNpT/jBFr2uSf+eB
X-Received: by 2002:a05:7022:150e:b0:143:298f:33ba with SMTP id
 a92af1059eb24-151c4e01656mr14645684c88.46.1791235505235; 
 Mon, 05 Oct 2026 14:25:05 -0700 (PDT)
X-Received: by 2002:a05:7022:150e:b0:143:298f:33ba with SMTP id
 a92af1059eb24-151c4e01656mr14645638c88.46.1791235504430; 
 Mon, 05 Oct 2026 14:25:04 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d819cbe53sm869166c88.3.2026.10.05.14.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 14:25:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/2] plugins: fix register handle encoding to reserve NULL as
 invalid
Date: Mon,  5 Oct 2026 21:24:58 +0000
Message-ID: <20261005212458.970-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005212458.970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005212458.970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8sXY-Pi4sbFsSuO-ojIR2415vtpOwLDR
X-Proofpoint-GUID: 8sXY-Pi4sbFsSuO-ojIR2415vtpOwLDR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfX7FIqvl48ZYlt
 aj/1hXP1oEhAlpp7EIMWfqH5oozBl7QM2n+IFK18spNyMlQx2dOPqO0Yvat15fL+18YTxXxg9AU
 41sBuHeEBgAJ2egtJ3n5ZmmUBwNpNCw=
X-Authority-Analysis: v=2.4 cv=LuEHWXdc c=1 sm=1 tr=0 ts=6ac415b1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UqCG9HQmAAAA:8 a=KKAkSRfTAAAA:8
 a=dGsWvjqBAAAA:8 a=69wJf7TsAAAA:8 a=lzdKdEW7bAII_ysEmBsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
 a=EwAE0RQWx3bH85eTCWcH:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfXxBl3vzn/Mo/R
 PnIHZeoIbl6cQz/t6dXABNkMfpnwLk2VplZZ95AxEvbZUB6OeTLBgHt8yQxPk3YlezA85APUvpv
 d6An4ZT47gIgnf3s2yRajk627yZ/Wl6yN0T1+gG7CAzpwfUih7EGvaVZBCZIOe2FTM04MKnfVlH
 W55IoNX41/igtZdqKnO+0tfYe85LR8oL3C5zhjYbVU0C+tt0RUUZEMdmx6Y4JqDh0/dq3Voa771
 yeLneJHXrwlNfjPSQmGBQ2G4pQ7xcFS94vSGUHiRsFbgBfgYw/MIWht7VkEUrVsCOGy+PL3t/Gk
 UqfSRozbiRxd1Ff1n6SoSSWiT4sbHdMTfCGX811w6GC3Ul5GmGpSNe6tESmbYhqUbX9Ds1N1Q4g
 fZGigFDoRWIIdd9ErJi1kQwat5QqE1rrlZlWq3BCmy5S4cS8lqCum7SdBUguZeGKKxbvI+vXjoW
 9BT2+WJx+0JeFnhQ9mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050084
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

From: y zhou <yzhou.dev@outlook.com>

The opaque register handles returned by qemu_plugin_get_registers()
are currently encoded as:

    handle = (gdb_reg << 1) | read_only_bit

For the first core register of every target -- gdb_reg 0, not
read-only -- this encodes to GINT_TO_POINTER(0), i.e. NULL. That is
x86_64 "rax", aarch64 "x0" and ppc "r0", among others.

A NULL handle is indistinguishable from an invalid one, so any plugin
that defensively checks its handles silently loses access to the
first core register (where the Linux syscall number lives on x86_64,
for example). Passing NULL to qemu_plugin_write_register() instead of
being rejected silently writes register 0.

Restore the invariant that NULL is never a valid handle by keeping an
offset on the gdb register number, as was already done before the
read-only property was packed into the handle (see v10.0.0, where
handles were encoded as GINT_TO_POINTER(gdb_reg + 1)):

    handle = ((gdb_reg + 1) << 1) | read_only_bit

Also assert in tests/tcg/plugins/registers.c that every descriptor
carries a non-NULL handle: the current test passes the handles
straight to read/write without checking them, and a handle encoding
that maps a valid register to NULL goes unnoticed for that reason.

Found while writing a system-mode syscall tracing plugin, which could
read neither the syscall number on x86_64 nor the first argument on
aarch64 (both handles came back NULL). Auditing every
GINT_TO_POINTER/GPOINTER_TO_INT site in the tree shows this is the
only place where a valid entity encodes to NULL.

Fixes: 55327b85ce32c ("plugins: prohibit writing to read-only registers")
Signed-off-by: y zhou <yzhou.dev@outlook.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Alexandre Iooss <erdnaxe@crans.org>
Cc: qemu-stable@nongnu.org
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261005181817.403766-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 plugins/api.c                 | 7 ++++---
 tests/tcg/plugins/registers.c | 8 ++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index 3520c96f411..46cba6796cc 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -455,7 +455,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
             desc.is_readonly = true;
             plugin_ro_bit = 1;
         }
-        desc.handle = GINT_TO_POINTER((grd->gdb_reg << 1) | plugin_ro_bit);
+        desc.handle = GINT_TO_POINTER(((grd->gdb_reg + 1) << 1) | plugin_ro_bit);
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
     }
@@ -480,7 +480,7 @@ bool qemu_plugin_read_register(struct qemu_plugin_register *reg,
         return false;
     }
 
-    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) >> 1) > 0);
+    return (gdb_read_register(current_cpu, buf, (GPOINTER_TO_INT(reg) >> 1) - 1) > 0);
 }
 
 bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
@@ -497,7 +497,8 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
         return false;
     }
 
-    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) >> 1) > 0);
+    return (gdb_write_register(current_cpu, buf->data,
+                               (GPOINTER_TO_INT(reg) >> 1) - 1) > 0);
 }
 
 void qemu_plugin_set_pc(uint64_t vaddr)
diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
index 0e41734435f..02058fe8a82 100644
--- a/tests/tcg/plugins/registers.c
+++ b/tests/tcg/plugins/registers.c
@@ -29,6 +29,14 @@ static void vcpu_init_cb(unsigned int vcpu_index, void *userdata)
     qemu_plugin_reg_descriptor *reg_desc = NULL;
     bool success = false;
 
+    /* NULL must never be a valid register handle */
+    for (size_t i = 0; i < regs->len; i++) {
+        qemu_plugin_reg_descriptor *desc =
+            &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+
+        g_assert(desc->handle != NULL);
+    }
+
     /* Make sure we can read and write a register not marked as readonly */
     for (size_t i = 0; i < regs->len; i++) {
         reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
-- 
2.43.0


