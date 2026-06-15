Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C719ACD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD6Z-0002bF-Up; Mon, 15 Jun 2026 15:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD65-0002QP-Ao
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD62-0001QB-6b
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:49 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FJ1KcG1220422
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BKZEN3raS7Q
 3k0uk0ljirFYhp5lfYqBU2MUCfY6EoSM=; b=jqNm/SKHMBGPYbV3Sx2/udO88v8
 tKOVHlH5TqjgWF14sy7IukR/DN1EvQgKFEL04P+Pu1CRZbUvbfbJ45sRwZwXCDXN
 WvttY1TmHfTZXZ/4ki+R5f+zi3UHQIHAzOT+REBVJ+dXf20+7UIsWnsKwe8JraXb
 Yov8AuimoWdWU+yLWF0+vSxKkevIhI+HLRPsvjt0ol7b/YVP0KqhEqFlB54B2SwS
 G+4S0Ulzt7hHth4WID+lsk6KjJoisnlQw9nAnRTHSeGpMzf8lYeKjBNpl1rvY9P6
 JFF0ooXMxgrZCGEHKMOINz/Y2FnIkyZH0iUlw4x/gD1AMKCKtw+tM4GJMUg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx2k24-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:44 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137fe4a3640so5732552c88.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552144; x=1782156944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKZEN3raS7Q3k0uk0ljirFYhp5lfYqBU2MUCfY6EoSM=;
 b=AS0XP7zLCWCyhMxgcGAc+M3XWCJs4oQNboAriLwIt6Bxfk8N14d6u8Wwa6R16qGGmh
 RwH0N+eNgQ53GPVVNU8145vbg8ONjzIsy+ytLpWtGCjOIs6z/HqUPiDPy3V0ZsSVWNDW
 17ufgOlv5OuRZUfrEWXrq6s7lazD+HO+BG4MBX7gUHdMNM6fFByVGTSTeJtdOoXDF3/F
 TbXJR30DlJzMHZqqx/g+z696hk41OUC5GrMSw96QgstMHpIGzyYY5P0AKIpojDVuLdUJ
 +hPi+xxn8P3x96n0mFgx34+6g0UsiZkxHjx6yOAGa8d99ILrmbIAsuSv9nz5cEGAvwuk
 effA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552144; x=1782156944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BKZEN3raS7Q3k0uk0ljirFYhp5lfYqBU2MUCfY6EoSM=;
 b=rMc6h9ujdkT4u/mcNSR92GziGlXxCty4KwvPutHcN/0aPyBL018YDJVWAlsNbkVcmQ
 T78vHBUh3tLDZLO9AckDy7jAvXmvC1/Wj4OVKcpMd4rT74hARnQkjR5zKCHH579lUGcq
 23CVmc4zeOeBk8zKH3/+MPEGhrmRvshkElDa+WBvHHxAfDddYG7xj5bUhpwUTM751WAc
 K/KQUlkvkIL77+IobfdcptG1ddIIUNUX2q2TMqqFldK8coxnM2gTYWI2iE2/UTvDzd+F
 Wo6iv0VK/QcsuOa2eKPuJN9ThAaqDPA+/S81QXTfm2Wg6Sr7PfCQMWanV0bLSnjTD0p6
 6+Fw==
X-Gm-Message-State: AOJu0YwvC8UFFLRlRJUsrQMMJFB/DBOZXJzgx+2ck/aLeP04mBM8ph8n
 qpPbcGkJxMA5LwWZz/0MFwwJFewr2cQRc20Y6KTIkqTCiiuGy++momY+yim661LWCh33AR00ANP
 lrcRIkYpCCV3ajZvCyV9uN2JKAYA/mfk9JxdnoWoH5nDSQ+S7LGgU56u7yxFqfg7nwYp6
X-Gm-Gg: Acq92OGCPXofEP3UGZXB2edyABcR6bpBcsbsuNKcFxCztELlFQvZxou6rE38VsvnzZz
 nDp4+2fjY0mQ7uH/9PqLxToxFjL8g7FxSUK8xXC+GGBvb17HM95lgRkiNN3WmEVjZ9Gb9IQjwWz
 sdvzOADElk6jL8VWVRReVL+HY4ccSdJTc9Ke9poxTjnijwhxftWu6y4586izQph+olukxVZjde0
 Bp05OgQyTzDr6H+bNzr2eM2cKdN3iyeBpoO21ZZmEbXUAloT/kDcI73nZN4UY4+Qxtf2tTNvJ1D
 FETJz3N/FM3ouhO5VcrmD8kN3RmhY8JIRhBVfF2MuFTgRCzyGQXPuShwdAry78qrSdPi9CPcrtq
 pPbL9ba3GhFZv27JRU8EnkJdG570BAA8x8NZPbuo+/EifiYD2+ULHHTpO88E1fgQK0LxMivEDaP
 qNorpubQ==
X-Received: by 2002:a05:7022:607:b0:138:56d:27e8 with SMTP id
 a92af1059eb24-13985ea8a03mr217245c88.1.1781552143709; 
 Mon, 15 Jun 2026 12:35:43 -0700 (PDT)
X-Received: by 2002:a05:7022:607:b0:138:56d:27e8 with SMTP id
 a92af1059eb24-13985ea8a03mr217223c88.1.1781552143214; 
 Mon, 15 Jun 2026 12:35:43 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 12/26] plugins: remove type qemu_plugin_vcpu_simple_cb_t
Date: Mon, 15 Jun 2026 12:35:11 -0700
Message-ID: <20260615193526.2883349-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ia_kjgtDqFuzYQacm8EJJ6UrG-1FnLH0
X-Proofpoint-GUID: ia_kjgtDqFuzYQacm8EJJ6UrG-1FnLH0
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a305410 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=O-HLJylWCwHPwwrsMNEA:9 a=vr4QvYf-bLy2KjpDp97w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXx3OiranczeEP
 okWX9fDQgcj54YKfGpylZTBz3FDvwdDj8zlGgm0DBzmBvnTy4lyEhzBgrrnsWOzr5WOXflZi95p
 3eOjgZKFPcNUeEY2YcPkLOaGrXFanMU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXzduP8TWE8dNo
 nOUno4XmGKd88+PnglruM++E5ocfKOjYQn8hxpPJtRIKaekqK7cFFAIb6vTgsrH1HmYuTiuaV4F
 D+QBbXuDNUWwZhh/XADCfgIaLD3M4R7sYjViaBquDim578+Z9bmwccuJPfccGdlzMkYjjSrlZZD
 0b0tDFV0So7zsVC8vniqTAUx9sM8WYPAZ4tnA5k6LWj/O9/MvuByLobYs7tc3+6UjmsbqMe4CSo
 tKTe6ab+W2sUWkYfpngcdhwTZWKx9Cs8KfkLhG37IZtLthzS1Pi0JoH8rCpaB+FwHc3+K4NWI/g
 Q2HLmJvqr1v9/d1T0NbCA1cJl7uDjXkPTTOoWZXVNdmwtgAGbJnPGrvRMUUfrSQFyzYUjExidMC
 SEslGcz8T5oLNLs1I3N6m0GbZe2pXVSWZyqEGfBaNOMSLOLWSXmaWHRep6ULpf8ZPJ5lP4+mAOu
 AGEMgmaxqpmiR1/hSWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150207
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 6 ------
 include/qemu/plugin.h         | 1 -
 2 files changed, 7 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 320644a2f0a..cf937c60ee7 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -147,12 +147,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
  */
 typedef void (*qemu_plugin_udata_cb_t)(void *userdata);
 
-/**
- * typedef qemu_plugin_vcpu_simple_cb_t - vcpu callback
- * @vcpu_index: the current vcpu context
- */
-typedef void (*qemu_plugin_vcpu_simple_cb_t)(unsigned int vcpu_index);
-
 /**
  * typedef qemu_plugin_vcpu_udata_cb_t - vcpu callback
  * @vcpu_index: the current vcpu context
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index dac08cdc60c..9356ee836ac 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -56,7 +56,6 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
 
 union qemu_plugin_cb_sig {
     qemu_plugin_udata_cb_t               udata;
-    qemu_plugin_vcpu_simple_cb_t         vcpu_simple;
     qemu_plugin_vcpu_udata_cb_t          vcpu_udata;
     qemu_plugin_vcpu_discon_cb_t         vcpu_discon;
     qemu_plugin_vcpu_tb_trans_cb_t       vcpu_tb_trans;
-- 
2.43.0


