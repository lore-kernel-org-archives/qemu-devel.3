Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7389CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsb1-0001wz-Br; Wed, 03 Jun 2026 16:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZd-00082K-82
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZU-0004FT-TG
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653HA02L2650441
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Io4yuv4tevI
 OYY189QmremHgeYn53Ys8ay1vkrP1kNI=; b=Y1DajhaTEW+KTbEhstKLTFhIAV+
 +fLtiqOPYtHAdzzkVTdqxjHjZrU98ELYSRdXZN+ek0gAaXh1F1UJjnojUjYbBGjf
 +niso9abW5S+SYhoWuyTujkOGBQIEs6tfjFhdYWi5scVfHqkEVYtW+km3YScAPvr
 9FSEsZAoKZd60opK2W5bivTuRxu1uGF2vlbbU5dPFpwd+ZG6J6Nx/0bsqVQV4X2B
 e8oG/DakcrKr6t4tm9JJFWKMHR449ZCakdhCWjONHqrDwUSmJW0j5/mNFqF5EV/5
 FsrTlUwCcPrkrOA2LJLk2UlAG7pkqRs1L/4N8b1WfgoETrGAQyq3Wvp5lQA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejre9gvgn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304d0d0b28eso867101eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519934; x=1781124734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Io4yuv4tevIOYY189QmremHgeYn53Ys8ay1vkrP1kNI=;
 b=FjbhmEMKsAwP+5qOLVh5t2uwiSXTCUKleA0UwHfWAJEmRER2NpRpGhm8sfLwa9G0wN
 BAz1IT3RSf6LeYb6EpB0IbRjw6DmILysCFDnzzzhu/jaNsCFWagjBpCmX6+cl/0B4m3b
 UnYGUbHZiXiyRvrdcU0omJeByj2oDKdri+hl/4GzmbVGxQ1zZOP+aH3ADeWMoS5LdRJy
 005Sjtut5vznQfYFhoRKtzJbEvQ3ZPOT+dZfNqER6X1iVW24fDL/ZFKzYZUtsMP0Myb1
 dC9+nBEygS0wI0F3BpFBy0xXUlfJXFaOmHD8NdEMivlkHovuzCq+jKZ8+8QkWBAspK0Q
 a/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519934; x=1781124734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Io4yuv4tevIOYY189QmremHgeYn53Ys8ay1vkrP1kNI=;
 b=OHsd6OXaggnFM/bsB0EKpbbYjwuBjFMukmvK81FslU6rRPVd0b6JoeNNB/bhZIKerb
 fPc+sX4SshVCJGicccqA0JvQP+aUYWvXVXEpbT7DUM9c2blnG1JIF9Ir++82bhx+IPb8
 hYpyu4c4Ua9LD33GX+wf2xBh6lscSUjuEZDUvobXWiUhRo9fSa8klOELzpSmGJxXJ8iv
 hHucq2+ZHssfTgGX6cJF+Chew79RkIR0znXYGjsQXN1iAfaUAfnZqn1Vv706vo0qYt09
 y0How80o3La6nDJgPmnSwp3oSJX4djmsLApyFDPvi7aMmlHZozCeervN7zjqRrb/3PoG
 Cc3w==
X-Gm-Message-State: AOJu0YyV/FrePgWGEkfJGo9HTsbtEAhHAHHPhUlrJWMgVwb5RTG/rjHu
 OxF+QWCF4nwggvySDSfW8NtPYiLQAbwKSqJ1N1eZpEId/UQUGeb5HV8xcClkcUPzlm1w0rSXC3a
 vU8ZR49eWvZHbFPqVCS1EDYjVatiQdj/yJCTPp8/NwfxQa1Iv7KEQrjmGhTXDfI4tktLi
X-Gm-Gg: Acq92OHrXNVsOWaPvkzEXjRkTHOlLf8xbRoDcm/Y3HwB26rPw2gyDMeWgJ0sTLpr3sl
 XkeKmOkzFppLuzPJS4HM8t/CxZqsX4eN/ckWxxj5lusQSyiET33vaU2sZHNot1OMJCJHqcpOLhw
 7lXtpWyhOgzKRziHvHRLiPsd2X6v9QjuZu103cuhkJl4UaFSThwdRuwWifRkCaJ8OF+ADclxb0o
 GRg1yuSI65OCplr9DS5uT2Z1+cTmULCipm68mBQnLp8GnIB6+SxwWcGgdt1Rah9AnzU16zQmu1F
 /syIUm5JG6hvWJtrwPqY4w05GSF8LUl70nGIM0M6xb2EYCeXPFloQn5l4+QfVewcBTLwsbQhNjc
 mwrBnCiXc88WxSyWdkQAvjqVcYmX56jcmVBFzY+PnCO5PlWqQd/qCqlHtv3ls8h3A+164Ywi9J3
 vHwmPnL6rX2uFpX0JE
X-Received: by 2002:a05:693c:23c9:b0:304:b15:17d6 with SMTP id
 5a478bee46e88-3074fa5732amr2319301eec.6.1780519934105; 
 Wed, 03 Jun 2026 13:52:14 -0700 (PDT)
X-Received: by 2002:a05:693c:23c9:b0:304:b15:17d6 with SMTP id
 5a478bee46e88-3074fa5732amr2319291eec.6.1780519933568; 
 Wed, 03 Jun 2026 13:52:13 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 11/25] plugins: add userdata to qemu_plugin_vcpu_for_each
Date: Wed,  3 Jun 2026 13:51:38 -0700
Message-ID: <20260603205152.1440291-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CEQVTxwTZmk9Dl8HQ2wwpTqtmbjMcTT-
X-Proofpoint-GUID: CEQVTxwTZmk9Dl8HQ2wwpTqtmbjMcTT-
X-Authority-Analysis: v=2.4 cv=KoF9H2WN c=1 sm=1 tr=0 ts=6a2093ff cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=cNRYNflkPMW_Fags0lAA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfXwyBNMKyyaOSc
 nV78pVWxjxubF9DzFXJrYGZkUMJ2j08a83S9VARJo1zn3T3ukFGRb1JRlxJGaSQjy41mLRCzXlM
 wNTj52AORJZQhkjAggy8bJYl5C8cK80XZtcCnuXJhgTP3Op2M6G2se1oeU8gUUfBtbAUjiFmcjP
 bsrVzepEpovYw+8Y/+WGMRmZ39wKKQoXC7Hf2Ce19HGitksr3bUMxHzogzXqxJTqiw0JyDfoYJd
 QoVtABzoziK15MUquuJV4D3G/9DOg6zhp5V3YIsQT+AnfCrOLMm78QjkDmBSaN6UoFO+0xYHbJx
 DxYFeddQAMn7HYVbvU4YY/aIUX6BySLJ7ds+llxG0h8CuqjEQRnrRs/TetoCrSKUDt/+C7TOgPH
 nnjI6SIyJzJrgHG3Woz0G9BiEMHVduNr/UrAUPv3Iwa8bNCNj1ALsIprq9g/B2+95xAaCglJ8my
 lVX88tZ3JUTNrZMyQ0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030203
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
 plugins/core.c                | 9 ++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 8c146ea49c2..320644a2f0a 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -957,6 +957,7 @@ const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn);
  * qemu_plugin_vcpu_for_each() - iterate over the existing vCPU
  * @id: plugin ID
  * @cb: callback function
+ * @userdata: user data for callback
  *
  * The @cb function is called once for each existing vCPU.
  *
@@ -964,7 +965,8 @@ const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn);
  */
 QEMU_PLUGIN_API
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
-                               qemu_plugin_vcpu_simple_cb_t cb);
+                               qemu_plugin_vcpu_udata_cb_t cb,
+                               void *userdata);
 
 /**
  * qemu_plugin_register_flush_cb() - register code cache flush callback
diff --git a/plugins/core.c b/plugins/core.c
index aa9240fe21a..a5aac1062aa 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -296,18 +296,20 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
 
 struct plugin_for_each_args {
     struct qemu_plugin_ctx *ctx;
-    qemu_plugin_vcpu_simple_cb_t cb;
+    qemu_plugin_vcpu_udata_cb_t cb;
+    void *userdata;
 };
 
 static void plugin_vcpu_for_each(gpointer k, gpointer v, gpointer udata)
 {
     struct plugin_for_each_args *args = udata;
     int cpu_index = *(int *)k;
-    args->cb(cpu_index);
+    args->cb(cpu_index, args->userdata);
 }
 
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
-                               qemu_plugin_vcpu_simple_cb_t cb)
+                               qemu_plugin_vcpu_udata_cb_t cb,
+                               void *userdata)
 {
     struct plugin_for_each_args args;
 
@@ -317,6 +319,7 @@ void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
     qemu_rec_mutex_lock(&plugin.lock);
     args.ctx = plugin_id_to_ctx_locked(id);
     args.cb = cb;
+    args.userdata = userdata;
     g_hash_table_foreach(plugin.cpu_ht, plugin_vcpu_for_each, &args);
     qemu_rec_mutex_unlock(&plugin.lock);
 }
-- 
2.43.0


