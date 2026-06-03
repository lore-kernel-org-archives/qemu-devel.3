Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6064BCD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsb3-000270-7g; Wed, 03 Jun 2026 16:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZi-000852-A9
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZY-0004Fe-A2
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653Gjew42262005
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nF9LqZx18bG
 3EfHDJMdpL9kLXE5N189/TK0QSN9ACyY=; b=fdl6MAW/GPq/F+xMlHFGfjw6NzN
 KUPG1EwGRnFKcJw5WkLxkaoDdGYBPvuVeZtVxdhux0gwls+/j6o3goNrV8hu1cE8
 /JltOkBwEubdXawRe/PiOaSVlu/jLA1y7KhlFuLR4TdNPnd6PHjfI1Nffq5KiP1U
 hGS8iIhmHlPpAUbOgAIcsf5VS1qAok40OinYwmm7ntDMx26xTNtPRzXiO9U6UNzn
 CT9dcxOgvsoUd/dXkFJVgRwpQtFiTaVppUQ6cCA6+g/3vNbN4Lz51CuiI9+CZhqS
 N9eN2WQagzJwYnJyPMbo0uUmM91N9Lg8UNuljm+fCcmIYvzkINNYTMW0jiw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejr2mh0uf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-307625ee07fso1180176eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519935; x=1781124735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nF9LqZx18bG3EfHDJMdpL9kLXE5N189/TK0QSN9ACyY=;
 b=V2JTzCWMdn7ypSxGb/XjhQcrnRnryw0O9Y2R0bTyxE8feKh6WFT/ZLmUFVeE6go/Eq
 GfDcSzda0Y129rbBDMhLExDIAsYck5JY27NAi6RZ1r2lIOYRTJOOl1TASxP5PShssuST
 cTJ4a8ZpKLFCSX+vbuAn8UfgV2a0rAopy4GzucSa4wYHx2crA8Q+fNXLd7d3VuunIHg7
 Rw7LsuOdN/h+45CQqm1xkc5KgT1PBtuoado5xPZ2bsqgEQDEwGc/EC1G2jC/Mze+S8S2
 1N0f897uLHeK4CPDITJmefxk7Ryh3X6bqpuKW+tT8K9znq6saIPoVWHvr3pnL4D3Q7SL
 /dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519935; x=1781124735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nF9LqZx18bG3EfHDJMdpL9kLXE5N189/TK0QSN9ACyY=;
 b=sSmZMX03O/MCTXKkmopxCGlSQfYKfJFZAru/5K8YCbBB3tZRdMWERPWwcY1bnFwISb
 wW93t+OTaB92JvDsB/SPleQyMiG69PublT3/2T+4ps0YmlmZbUrtMBsmJDNHmOJw6bL8
 q0ovjylsN9XI94RcuTg3WuHpOn9ZubYj/6V2ufV3VADBQhWG0S0JKNXQsf99YZbgMJsq
 A0C5gmiwBC0LpeOU5AGdR/81FXPzjTdW+Cbd8xxk10FH222dQgH9sEsLbFdqriB67Ksx
 fs5Ktpru28nlJmlRfwpEHNF8QzCO35jX01Au15Bfrp7/+hvTTOAonwpP0IjgZbRSy3cd
 6YUA==
X-Gm-Message-State: AOJu0YwdVSTtl/z/fjIZA9pqwB27jjqf9uWhia9H7pIMfEdpt5ulJvLq
 7l/Y377fn1fUABCiawzFXkKF0Iyphwah3TZR7I8PejPCtvCKun9R6gqz1l719wLT/ymTi4iA8et
 VqgvYj9xkQuR9my4VKFLYuWjdr8lL//TXVuscd2Opbhvyj8QG2Ipb4AE+HuIUuplhak4W
X-Gm-Gg: Acq92OGuI447Lc9S/W/15o+WbbnWL8U8wst1NWwxPIHJ2Y2ECDoKUFddwLKjTGKoiqL
 oU87xzgtEj0/fInJXukRLx41kUrE3XpoPiEeFhHTf+hy2P42lC31hsHkTn+BCIhTjvRCxDFfGVZ
 6c+yCPoQC0EZa0eKtpj5H+nrvD0SuFj1LcJBM34hKqIjL6lidqtVebduwIGaiTitlJpJopeyZvm
 +rPsMJKEPheqrgO2iijtrB8cSboRTRrfGkO99nXCnDr4bMDKvRaWaQUGWftXqEUwc5QlBE4wPtM
 wej/qqbYDA+pXAOu0baLkR7FI7EEq1j8MVlqWwOkPX5X4NAxrELXM7Yi8A/vYZHiTuVY0yfNtBW
 yiDykvB558JPpNEgTDQfpWUJXgFMB7CJrTIy/s/tx8qxuHq8zg0ai24BSpO5wPEfciJC/pa+QY9
 Sxdh3/BBhtZP2Buais
X-Received: by 2002:a05:7301:1685:b0:304:705f:e4e8 with SMTP id
 5a478bee46e88-3074fc366bcmr2538999eec.32.1780519935315; 
 Wed, 03 Jun 2026 13:52:15 -0700 (PDT)
X-Received: by 2002:a05:7301:1685:b0:304:705f:e4e8 with SMTP id
 5a478bee46e88-3074fc366bcmr2538989eec.32.1780519934788; 
 Wed, 03 Jun 2026 13:52:14 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.13
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
Subject: [PATCH 12/25] plugins: remove type qemu_plugin_vcpu_simple_cb_t
Date: Wed,  3 Jun 2026 13:51:39 -0700
Message-ID: <20260603205152.1440291-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qU0X8YUXEaBgtwJewQi5ilJ2Do_n9MaB
X-Proofpoint-ORIG-GUID: qU0X8YUXEaBgtwJewQi5ilJ2Do_n9MaB
X-Authority-Analysis: v=2.4 cv=A91c+aWG c=1 sm=1 tr=0 ts=6a209400 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=O-HLJylWCwHPwwrsMNEA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfXzyar695O4vf0
 HY13toCkkzIyem1WQ4+CUMcQqh9/KMKnanx284E7+pb1BHZVbqYU5jVZnSgn9bPZFgEBgO1r5TA
 P5fKtnzW2/utZpphKcHata44kShhYBdwAFe0uCXFayO1snoJvKFRtu92bKrW1IYapoa2cocXsrL
 R4jmxZ7/svhBiX/d9gvRGRQd6DuZnH04pMd5gPcJiV8jKGHZtCOuiEiTOpWTW4jyecVvU4y9M41
 qd52vPYTGvxruAUurdgaZ+R4AscOHkk7ROh1I2Fqjc98kIlH0KYMJ4qI3XVNNkH9jj1Rfdu1uDC
 3fLIaZUkaZE8Uy7pQLKhkfEFnGzyumsIoqr5msx8Y6A2EsgWGNRKwwAnyEV45BgSZW99G5vI8vp
 7wcKyxvILdAsq73PP8N2Jo2RRqZYoP00LVVPxmi1wGbERW3G5vRZA0lmIGXxD372Anoyromjflj
 Cdzna1K3ePWx9Z595sg==
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


