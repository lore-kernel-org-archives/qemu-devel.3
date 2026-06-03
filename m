Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F9FCD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsZy-0008Bz-Pi; Wed, 03 Jun 2026 16:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZY-000804-IU
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZS-0004Ep-QL
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:17 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653HvwOe3233934
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bNzpG63Yigt
 97XcfKyuqNMGgW8/n53Gf74/534GXLd0=; b=nprlaFcWQ44mxif7Nz3LWb57CNX
 1w79DqpZ0RLfBVT3EQlm0/lYU7vyRtKtimezVMJJngSMD+33W/LLoMMahQk46g4d
 wW1Yen4bt9QiWsr4vk8kgdNt+tZE5/08/0hejPJGMu01Zy5WXWP9LM3YXQNHTAxT
 Xcz/jFGJjSrTOtNyphdb8MoXRTRS39lUXBQiC5owIUbsM/UgMQ6En8vqo1kiDcsC
 hJjV0mIZWXkMdKIXucuFvli/ocSpjb5AtMng+Qf03D8BPdUxq/B2p2TBscRRxKUv
 3kLmSTcIIOHbXX9HTrlvuFAP+MT843zGg5DBfCRkTp7z2SHy24WPeUc7TQQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs4s0nbu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-307625ee07fso1179922eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519932; x=1781124732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNzpG63Yigt97XcfKyuqNMGgW8/n53Gf74/534GXLd0=;
 b=cTNGchQg0sybTsVilELzCYQCDQon15ePS18efYzm2M8JJQUc+fz7ype9Jy1LVvAmMT
 CK6tlgM8pHgTYm6z6t2PYGfedfcQoJwzf/6gGI6by97vQofq4d8qkPl3pEbG3BFgGhnH
 OzprusssUXxaqV9pT55BvIZ9MUtDwj3OczfU0ujhyXH2JVzuq2OSI54+w6kUevibfsFK
 GyNnxiTfOVrpbBqnCikTIhTQKclEQ/gaGRqWqHsbyf3I6WfpXVonYmN3NVmmKUGaJvgc
 eHE7g/iquZ17XQBhHEN7lVWU2e7n4Sx4Qy7Yy2pftHbkX2JyXWpo7BSKVLWzQVFz/JYl
 2vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519932; x=1781124732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bNzpG63Yigt97XcfKyuqNMGgW8/n53Gf74/534GXLd0=;
 b=WjtaV4qX06a5J0IM5jGBE0aB+ddLotuUhrHgASnK7bjoOW1m9/SLhOBwdyMmrI10sH
 M/DEGUdgIhAyxTR5zo7M+Ootx+T7L0LncCVN3fkvR8QK/CLpwh3+AcCu4BP5yDvr/G+/
 D5ma1s/q/Y7pxiCzGeGJae4a5F/n9T4AyuV/PodHInnFHKNWEici8+DzbrtMHxXTro0z
 s0orRkdrzBn0sx2ZZXxErTk7GZnQLDMQv0ra7twyCxLbTBzdzs7wGooiP9mbY6OcTy5g
 wGvvdWx9RBTu7WGAq9Qc9ZlN35+bwNYjRAsGCLgais4/u/oCR9iDa9Rb4IWoHACg7R1X
 biGw==
X-Gm-Message-State: AOJu0YxZVvypThTf1YIkK2dEpjN1CdOq8m5kEiMpr2KhB+XJ+mX3v/u3
 FX9IiWr8oF3IXDLXxn3DtPrI/VyP7X4WTfPZ+tzIIK8/6oEyTeKFKjVgG7Q0WGHd9oEiBqv3ept
 H2fnvVQ7zexa38Y5B+DGvpcDu8MN/gOh+EDvv2Q2B5kkEw8+wKQ8yAOf6ijSHpMGlcuCq
X-Gm-Gg: Acq92OG+16iX63M3dZPPhcCo6y22FvqcEBCo8iEzMSWliZD2ShydmVQNWUmvn/P5M5X
 QsVXl7Np25inG7GbUtpsPzfutH93i81cPGweQuG5LZwOip2W/oVoWAhHF0ZTCyv3yZcwSB8kH2b
 jxFvu9AI20erzdMDeZoVWkzHIcH8Rop6mpBy/90TpvX1/Fb8ARIoc5iCsopWnKuzimnwcKT9FgL
 8mo2/mAGeDzrYBmGLJy9epm/HySX3UeJ30FibuKL1blv0zfsEs6yo8Laz8SVHaNMV4y8Gra6EYs
 3OJTX4Gqu65axYbMWUhPJ5+jdlHmge7yUhCIk59T31FGO5fHyldc3NgpvLmLrA+lJaAqrB4Uj2c
 cg80zJKP2+wOGQfBkqGjHtAWuUDE9r5Nlouli9PVCLVtMzECqGuv8IFBjeI/GS4OOxlmnmJadX9
 8D/6IgS/2gTRDa0mEl
X-Received: by 2002:a05:7300:4347:b0:2d1:d434:cfe3 with SMTP id
 5a478bee46e88-3074f840d0amr2872226eec.0.1780519931960; 
 Wed, 03 Jun 2026 13:52:11 -0700 (PDT)
X-Received: by 2002:a05:7300:4347:b0:2d1:d434:cfe3 with SMTP id
 5a478bee46e88-3074f840d0amr2872210eec.0.1780519931431; 
 Wed, 03 Jun 2026 13:52:11 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 09/25] plugins: add userdata to
 qemu_plugin_register_vcpu_idle_cb
Date: Wed,  3 Jun 2026 13:51:36 -0700
Message-ID: <20260603205152.1440291-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dQPv5LdN95TVuT2CUjw6YsfXosfcGsO1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX2hIyqIfRilxU
 cP7EpRk72T7XE9REMjJcaHTovMB35aJ0dVWAw4kfl3WJEYIKTSMhDXhkbC4Qbd9JST9R0rpxadZ
 SJLMthk6r2NBRGF4283JxJ3Qz2Qz5PCGE+MsE/eL56A0bomApLr55aLFI5UUnsddgouOgYDr5DL
 0P8QeDQFqLkS8xDvpJIEMMAsGv1b+ZCWK0SkXxJ5AqS776Rzvu2pMcMTU7G6CMp28Z5ZA+0rfBl
 Dm3lMHKNULSNXT+TCdSgtONXNGSFmNrFBiwFupilfGnPtVReiKMVKh4PM86sPS4bzZz21Xj7EYY
 ylOux5HsCkOh19BXwjtoYLaLtrmh6b50eqnLF/zAm4L9ARn12r+TnCoeIxj6WdRvYWmaz+1sM2y
 L6hS9EEiLVbzWgjV+bGVWUWoahz11dPPpz9f6PsLMzD2ywNlwsYppZ0jw6efel9lF1kqV01Ndli
 X29G1t4gtP/duJ4sLcw==
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a2093fc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=1QjUMDCEHWFJ5QTWXisA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: dQPv5LdN95TVuT2CUjw6YsfXosfcGsO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030203
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 4 +++-
 plugins/core.c                | 9 +++++----
 tests/tcg/plugins/bb.c        | 4 ++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index d4f8a99027e..75d2a69a3bd 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -272,12 +272,14 @@ void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
  * qemu_plugin_register_vcpu_idle_cb() - register a vCPU idle callback
  * @id: plugin ID
  * @cb: callback function
+ * @userdata: any plugin data to pass to the @cb
  *
  * The @cb function is called every time a vCPU idles.
  */
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
-                                       qemu_plugin_vcpu_simple_cb_t cb);
+                                       qemu_plugin_vcpu_udata_cb_t cb,
+                                       void *userdata);
 
 /**
  * qemu_plugin_register_vcpu_resume_cb() - register a vCPU resume callback
diff --git a/plugins/core.c b/plugins/core.c
index 15fb548f68c..111ceeea285 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -89,7 +89,6 @@ static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
     struct qemu_plugin_cb *cb, *next;
 
     switch (ev) {
-    case QEMU_PLUGIN_EV_VCPU_IDLE:
     case QEMU_PLUGIN_EV_VCPU_RESUME:
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
@@ -114,6 +113,7 @@ static void plugin_vcpu_cb__udata(CPUState *cpu, enum qemu_plugin_event ev)
 
     switch (ev) {
     case QEMU_PLUGIN_EV_VCPU_INIT:
+    case QEMU_PLUGIN_EV_VCPU_IDLE:
     case QEMU_PLUGIN_EV_VCPU_EXIT:
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_vcpu_udata_cb_t func = cb->f.vcpu_udata;
@@ -626,7 +626,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
     /* idle and resume cb may be called before init, ignore in this case */
     if (cpu->cpu_index < plugin.num_vcpus) {
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
+        plugin_vcpu_cb__udata(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
@@ -659,9 +659,10 @@ void qemu_plugin_vcpu_hostcall_cb(CPUState *cpu, uint64_t from)
 }
 
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
-                                       qemu_plugin_vcpu_simple_cb_t cb)
+                                       qemu_plugin_vcpu_udata_cb_t cb,
+                                       void *userdata)
 {
-    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_IDLE, cb);
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_VCPU_IDLE, cb, userdata);
 }
 
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
diff --git a/tests/tcg/plugins/bb.c b/tests/tcg/plugins/bb.c
index f29b466dab2..ba605246eb0 100644
--- a/tests/tcg/plugins/bb.c
+++ b/tests/tcg/plugins/bb.c
@@ -56,7 +56,7 @@ static void plugin_exit(void *p)
     qemu_plugin_scoreboard_free(counts);
 }
 
-static void vcpu_idle(unsigned int cpu_index)
+static void vcpu_idle(unsigned int cpu_index, void *userdata)
 {
     CPUCount *count = qemu_plugin_scoreboard_find(counts, cpu_index);
     g_autoptr(GString) report = g_string_new("");
@@ -124,7 +124,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         counts, CPUCount, insn_count);
 
     if (idle_report) {
-        qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle);
+        qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle, NULL);
     }
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
-- 
2.43.0


