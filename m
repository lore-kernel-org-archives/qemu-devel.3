Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C01DCD6E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsaU-0000EC-5B; Wed, 03 Jun 2026 16:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZp-00089M-21
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZk-0004Il-4t
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653Gj9d82260700
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HcsLIn0GwPs
 PIHV8RI5dCIz6YCsvDXVP5MbZpOwf0gU=; b=CJn9d1T/0C4aVnI9EkfkHa7EbrP
 eKIOaVLjbR6dt5xZxnyYjnUz7n6mE7SqHmQI4OxR5ZcPQKe22iNFCC1uAOALTajY
 FFzxY9KFL0CEj2/rEycNZD48WDu6Rf07MeE5CejqdBRJ12Lo6rFU3B4YOzjpVBW/
 dcddgUKInJgvdcw7sofIyOAxWnB5wE4In0NWNL4xqRgqsBAEVeouYxTqDi2L7vas
 XDi2CYCx50027AD1ZXVVzPVRFkWETumfzbV6VJzwgqkiUPbLLSPBS0B4jhS0Ujky
 csBSRQ9TLe98llyB0jfUW6IvcQEQ+nrty9ITGWwQQPk6UrwfhH8ZMEhOROw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejr2mh0vc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304f23c55b2so5686227eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519948; x=1781124748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcsLIn0GwPsPIHV8RI5dCIz6YCsvDXVP5MbZpOwf0gU=;
 b=RZ5MI6VHTtE9nGCEKj5jVHvBqCjMvikw4TiO7MhftLEPdDVVHnSVdz5KuGWc0HA/5p
 jch8comNDvo6gz/frAf8Hd3ETZhrePIjVs/Z6VxagxiEq88OXtWuWIUPDgi7tg8wq/bJ
 vL6VQbQTjQta4C+7U0gPYGD65Ms50m9DEb57GD3VE8MbUWf54X6p3Moh4LFjbYbs6Q5G
 Jb8+12ie72XSEcBCj3rpkV+RyXf+h2BjdTSfXjz9YMwYNilMR0dA/8s7tkF5O7+RfCk3
 3YKE9JicPsRez31jLcV28JK56Jui5VKd/jVUaTgPBAdf7tCEECpBxDpXPrgR/iFRw7RA
 Mk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519948; x=1781124748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HcsLIn0GwPsPIHV8RI5dCIz6YCsvDXVP5MbZpOwf0gU=;
 b=SHXHWBw0i7mJV8HmgUzWI2N/4f7FRzIVAom9f8a9AlPwxpn5o1Ti9Tn5Pa9PgOl3cc
 ysaY6h+E8KukFG/6GYFlWZGkL2dk/qqAu0PTN/pABDGHLW4OFVf5+IgY6P301i/ZlhSu
 0IRb5VuatJv4ledlvvhQ56GjlfzhQ6AvmuLhXJmNjdcRsW15e4MN1Ip005FYPQwe/kw0
 kTXY/gkL5lwrrbTtjhFjzqcMsj41bQVR6sxHfjmBk7pmcyGkBmr5vlrkiH0sjLYcGT1k
 nv8jcobkOHg0pDYudCJGcmi+LcWRAB68fZsi5+9DnjuDX4J4QSXdRqqkHvT6XExmtBsb
 YEuw==
X-Gm-Message-State: AOJu0Yz58Yro0Ts6rhug7+WpwDLXKlG7i9H7dji/lHWdKUc0F1YVH4Ds
 6M9xNyli2kFBzwdzgyWkrB5hOzQ6yEQlodM8+5XDlWSr5v2B37cDk4HH3b5aztlJPD6QbzqJtsl
 wmFQgcvRJW9RHD5KojNgFH2yhmWCYlKwkP+Xpa46TWNPUGbjmIUvPCOXD3txsORWSqWCY
X-Gm-Gg: Acq92OGUdMIFrykZtudytvz7AeBmAbQwXLTxHmumGqKMfQcpEpX2o10WCLnpZYHc3nO
 EmpJPz37EEbE7gIF6YiujERd7DVSyf2dfWKs/n+mtpdn/sFioxFFbxwzk5pKNyxke9sMN8wah3e
 lm+U54yEMkiDcGTIzrXI8/Nj2ZiqE/bIHEpVW61MbZm1zvObiGZrnSicNeXNgTUKN2lQx301NYK
 9sUYn1SMCHPACyauImwv6X/azawbNvwDr1daae6mAmw0KFoTnQlepcq9ka2Uyrd+Pl01hA2PnGa
 RKUsKbQORsO88x6UyXCIU+bIZH9OwD9JTnEqadixnCbNSdtGS32TsGKqih0DVcOobe6bb98K9p4
 LZ+F8ogTezVe3C4d9q7bNl9wiAxtzu6fP3hDwO6TZGICCPX0clC7QJoY4GBisqrX53yTU0oCD/M
 SGW4y/KCeoW07no6+J
X-Received: by 2002:a05:7300:7fa3:b0:2d2:96e8:1bf5 with SMTP id
 5a478bee46e88-3074fa3b84fmr2644747eec.3.1780519948244; 
 Wed, 03 Jun 2026 13:52:28 -0700 (PDT)
X-Received: by 2002:a05:7300:7fa3:b0:2d2:96e8:1bf5 with SMTP id
 5a478bee46e88-3074fa3b84fmr2644729eec.3.1780519947786; 
 Wed, 03 Jun 2026 13:52:27 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 21/25] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_syscall_ret_cb_t
Date: Wed,  3 Jun 2026 13:51:48 -0700
Message-ID: <20260603205152.1440291-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7stvX0Yd-nHOXhKEPBlBt8Jj4QLwKhzy
X-Proofpoint-ORIG-GUID: 7stvX0Yd-nHOXhKEPBlBt8Jj4QLwKhzy
X-Authority-Analysis: v=2.4 cv=A91c+aWG c=1 sm=1 tr=0 ts=6a20940d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=r2ysFZ-m1ga4sL3LQvwA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX/Z++iLTC3zCI
 EF/dURkJOc0gTFohukruNiZJv6i97AmqbfJtY3YEK92RViUHVmZL7CSv8G6GzbpSMeV3CToPkxb
 U6+agXUy4UkKbdbUOtr59KtvhEHWpiWiBhRS0OuOQnur4APuRcFpN3dp5lXKB0EomNUFVOUpm2v
 Iiqosyq9oLJxkgMmP6R3U+0TiTa8ibMp/iMOnkpTSf4vM2gh7QcsRYG3EaTmbx8uWghuj6q/jlM
 zCG6C84EnqOkmnC8b0eS/AHlYCCF9IyrpAoZd/LS3xA8Z/knA4X8ShC0/L0GmreyZ98o1xoMaxN
 Npso61JiSpbS8et4DvI/W+BWVHhAvZE71P/vyFMmAdW5yT+/sIjT2pmnL4pdSrs8Kb7yEvZvUi5
 IzOUhZ7E/3GcF0X0JF7ipli5y3O3zrpINYfG3xW0W4eeOnx5bUOCfBVet9NOMesKB86LNLbHpm1
 xauO5BVW8mJhDdtbiqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030203
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 4 +---
 plugins/core.c                | 2 +-
 tests/tcg/plugins/syscall.c   | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 33d6f8e0b7d..4f0c73c7b33 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -879,14 +879,12 @@ typedef bool
 /**
  * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callback
  * function type
- * @id: plugin id
  * @vcpu_index: the executing vCPU
  * @num: the syscall number
  * @ret: the syscall return value
  */
 typedef void
-(*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id,
-                                     unsigned int vcpu_index,
+(*qemu_plugin_vcpu_syscall_ret_cb_t)(unsigned int vcpu_index,
                                      int64_t num, int64_t ret);
 
 /**
diff --git a/plugins/core.c b/plugins/core.c
index fe292a098da..887267f8174 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -557,7 +557,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
         qemu_plugin_vcpu_syscall_ret_cb_t func = cb->f.vcpu_syscall_ret;
 
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        func(cb->ctx->id, cpu->cpu_index, num, ret);
+        func(cpu->cpu_index, num, ret);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 410fe617804..1bc737824ce 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -151,7 +151,7 @@ static void vcpu_syscall(unsigned int vcpu_index,
     }
 }
 
-static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
+static void vcpu_syscall_ret(unsigned int vcpu_idx,
                              int64_t num, int64_t ret)
 {
     if (statistics) {
-- 
2.43.0


