Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D16CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnGy-0007og-Ai; Mon, 05 Oct 2026 14:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnGe-0007nE-Qo
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:18:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnGb-0002Eu-6B
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:18:27 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLKMn2909389
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3oQBqCqzUxBQw0X5HB1vUb
 PUa4rFBwr97Qk3QzG+Bmg=; b=V8QV6tzsxtYidcHDOShXo9Lvetz62Lfx/hxDKm
 bZ8oSPw3xOyvu84DF0DVwanhKDgli4qG4d2QMTuZsXFQ3iyqNeOsBdQsn6on1IE1
 C+25+tGr+IpQSk9rORE3F+MfqIaofiufELp+eczaY/XgxBGCKBj6BW/IktZz2Y4s
 oBe+wSlGmEDMgnhXXT5d33xj/tHqCGP4ic2PWFIhuSxQ7sp4WgaN+2eFWONcwQJY
 BOfkIv12I/LFCQRtd5+oM0GiLUntE7Vu6/eMFEK3QFt/+zcXJRZicU4nW1ueUJSg
 j2ovYUxuOPZKX+T4S2NIAA2BEMNCHQTxH/yLwt7tp2UnzFng==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4bhg1j68-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:18:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34d84114044so8711608eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791224301; x=1791829101; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3oQBqCqzUxBQw0X5HB1vUbPUa4rFBwr97Qk3QzG+Bmg=;
 b=flaN/3IDlsypS0GUqQ0KXVJs4C03sJqwz3fe6dC0ZOt9P3T6KrJTuKanLGO5E6y41y
 Ke1BYPrnjJ9/+LxlLPqbmPpoLZkrQoDAKaAbMkZrCLmjM7YDlrICsrRCFk5BTzAJOTUB
 8Y3IY8kSfaLBHp9+VZBEx0kr6DxiIv1Fve1mHZ6KZV+2PICHmB428U7QhIPosG3kjsaN
 hbu3C7Qjk1KLLvmNCOWVLKiVNEQo0yM1yQj4N1WLjfNDihuBOpSWa9waHUvm+ScBgu+Z
 PCrnlljCNiO1PURdl7MzOsx8D2kppWUD35jW8mfQ60E4sJnYijwA5VDgOhG0SXNWl2hb
 eH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791224301; x=1791829101;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3oQBqCqzUxBQw0X5HB1vUbPUa4rFBwr97Qk3QzG+Bmg=;
 b=AP4F78NXnHOLDKapHFUS3SoxiXmcwFGTm7yDa25FaOtQ2R+8QsLJDJ5eHnE4kC/UEk
 JpjoPHGEersAXlG8qZMM9+x2Z4JRlNFmsZloocW9+2/GwifyLmL0wCqRjE2GJ38MBr3V
 Y+TeESsHylIsOKHCpHOK7suJ9qZjhBItjNMuyBJM5H+CmS7kd3+UEP41bO0RKcy+++V8
 xRT8AsLW23CYRdDjwwail66+vujIjD8ZaZYbohkWfTQGf8c23tr8jkguNL/VjBONJvut
 2B0V8vNh7RS84KX3hLU3i38MYpViseZtetP1RImalbVaS2VKprr5hPx0lL0PhHURA+Wl
 9fhQ==
X-Gm-Message-State: AFuF++n56kkfiHSe8YN9DFJieiIKEqUGaxCaK4RJtjZr28rsG3gqPWkl
 KcVJNnLkFqWeHWOQ4xUZzmxkE24eNDaABdzbypiuwyx0wVQbA/qOTAdPr3wJSQjazwycLA2tdEh
 CpkuwQ0C6hs0OaeeOcb7Ig0cKTqQ/gNzMjTa5uSH9xcPqPYjsvFkZXKu/XsEGM3Op9A==
X-Gm-Gg: AYBFou1AcaUmSdAyVT8GC9tC83DpaTP2q2pMaFOaJiWMv++WkoDHc3RPMbhUMvSr8LR
 uagt0m9GzseA9m765i3cK5YUYbxl4wceXh6SLn5iMLvhFfJaIkaTm4RvgxQRmUZudFElS/AqFFc
 dFTMQFiZFBLjwu+wuQ+PgQeQNL7jfSvpMtz6xvLJHwP8DKIDrNBV5e8LFmblPslKSWyVl7YR+GA
 yx9Nqsz+0fKkzvOtJqCkYVJroLnjoUm1uMv/PQE2SxKWyWW2ELt7877kQ3I+/IoLMK3XofZx2b4
 Jz8J8aAzpCC6eRjYa4hnyfG7WTzZSS8NvRpeaQu1MClv29W8rSNR7wAAfiSo/v2CUt9HcywWhyT
 EuOQ+BhVzBEQYkREAjPlqLjyNz0aGvIjR8SS8C5RTr/FWYM5sBhIT6MWZxi6J
X-Received: by 2002:a05:7300:d80d:b0:351:1dff:ae1f with SMTP id
 5a478bee46e88-3511dffafd0mr8658262eec.41.1791224300713; 
 Mon, 05 Oct 2026 11:18:20 -0700 (PDT)
X-Received: by 2002:a05:7300:d80d:b0:351:1dff:ae1f with SMTP id
 5a478bee46e88-3511dffafd0mr8658232eec.41.1791224300123; 
 Mon, 05 Oct 2026 11:18:20 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35146b07310sm89796eec.24.2026.10.05.11.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:18:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 y zhou <yzhou.dev@outlook.com>, qemu-stable@nongnu.org
Subject: [PATCH] plugins: fix register handle encoding to reserve NULL as
 invalid
Date: Mon,  5 Oct 2026 11:18:17 -0700
Message-ID: <20261005181817.403766-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -rnC0QRmI2xPsntFNm8ePoJ1u2w0_235
X-Authority-Analysis: v=2.4 cv=GMGdgeNK c=1 sm=1 tr=0 ts=6ac3e9ed cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=UqCG9HQmAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dGsWvjqBAAAA:8
 a=69wJf7TsAAAA:8 a=lzdKdEW7bAII_ysEmBsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22 a=EwAE0RQWx3bH85eTCWcH:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3MSBTYWx0ZWRfX6F7WCwCVwsyi
 nLnDfO2SEXANKeZ8wtuxnnqOmjc8V92x0bDLB/N8vibnQ9kh8yo6aIrrdVoY1dqbR8PUiAmKn4E
 lGazS3It8SINwIhIBXcJmCqlaqXVtYM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3MSBTYWx0ZWRfX2FK7eyMX/1Jy
 p+X9FPPs/5VBTxo66SiOMYbIAFIVg1/bNKLDvZcxPtJjTwGUQdH7snZbw/fKIBhOzVpFMp17Mgt
 GzWaDwxyDWHI583LfVMc15f6vXuzKxKGQylj5y9vLLG9A/RbxloLlux7X3ib1FjdzEXEDJDol5h
 nGPsuH8NvqUTk2wN2l5tsKjEVtwnZE7/d3yQ8TerZBGidGtXG60CrSUn57Xx2vRP+07ISzqeY+4
 IJdWuPwfP/yfidI0zo3zCtSMzCdeqzwCgdGZiV9NeEVE+4uRTWYh1f3uiBSsnpPTuAbxzipQrmx
 o6U4uWBKJNHK3OiVdzeMuwTElt8xc3IzrmWRrXDjOgoFRABVPsVhEhyEpvk9hDoQOrVdCyonu/0
 7UXM/RGCYpePs2ldhs3BmEIcGFIBjGCyUcK1W+3hzQh/j7R9ZC4HngRfziOWY0YkyJnS8oguutA
 QQVsNvrEk+a+puVazNQ==
X-Proofpoint-GUID: -rnC0QRmI2xPsntFNm8ePoJ1u2w0_235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050071
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
2.47.3


