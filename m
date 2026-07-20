Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE080C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 22:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlwIk-0003yW-8W; Mon, 20 Jul 2026 18:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlwIj-0003y5-25
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 18:17:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlwIh-0003aN-Dz
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 18:17:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTRdk3491991
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Oc+JzOP3dek
 vrqSq35vjqf+pJXDkdiSTWJZRhjnCpqk=; b=PJo70N3gqT2nLStcnQ2+82bNaQI
 Qf959xEgviZeAc8yOJVmNnieMFlQFIjFbXkjPHPfXH8Obrth1/K0a9wou28PMD90
 VGdx4jDHIyHcozk45WzIFj9/nJhmmh+yfILZZsZcmRLfPiBqhYayPBJqmcsfhNf1
 WWMA3k9oHDvzNYB2KfabzialBocItlfecjQLoRmSoAc5RPbZPlrWt+sGIV3p3rnG
 xL0WDDAcIinsWI+u6VDP2jQ3PuzUgVH0yz3Mo4ivf2I4zt/gAfn7Igme5Y/lDibH
 L9tRF3/7pReF7wyrWAsADzMudcOvUfuzKX05vLKzqMtZPZQDdcVGT+GggHw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv4164w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 22:17:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dd87656d3so10198002a91.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 15:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784585845; x=1785190645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oc+JzOP3dekvrqSq35vjqf+pJXDkdiSTWJZRhjnCpqk=;
 b=i9p6vDxiHAXtQI17lQi1RtzIP11ydl0yXyR8b3TjmQfL1jwCd/4LCW1WYh36lovOym
 JqfDtskwsKhU60hDnEJWxqbvafau4+PoTT4Ozhu6TCJzUZAqW6W1Q1jnlPQ5rGRm1Lpn
 cutNUa9upzId2M+Aua1bd+znkZGlSkX3rvLAlNIJw4g1WF5qyNxN7Z5wvhKST665tHQP
 blSqNVBXSC/jdG9L+3lJV1ti+A9sO25sD9HYDlKHTBCFK8+FakpdT1SbbSf1iTnMsa6n
 h6VB455gNZwSzY94O5XnvgqONcje8eQI9fNQkbm+i/Q6pxxO10B/85cu10q84p9Ng+DS
 lUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784585845; x=1785190645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Oc+JzOP3dekvrqSq35vjqf+pJXDkdiSTWJZRhjnCpqk=;
 b=C+Qzi9vZWz+1NwmmYelDPk26GjIXX47aPfSV8UdBaS3Hm2K+v24Iufs1Go8nCuSW8y
 zqyLPlgy/PuVfylIMfo/qKIC1pvk0ESSgHBRu6v2e4ae5AAt5P5Ltb0cQOalkvUFd/+U
 dMUyts/6PHrBFeBorisKcxJPPYxxP1mc9YtHYBc+e7MYM7gYKfiE/b+VOUCyqNtB209u
 b7FOn8fAHj24nw+q3Z49M9HsgqtFwa1TvhW/ZqTWh9ml3ojwc22P5RWPWt0oWp9K+dWm
 hbmXqI8M47sVDV5ONx0G5FE4hJ1NzUdyKeo7VkGfBcj8pe6IvQZaPiLNrsGrabQRa796
 tQ7Q==
X-Gm-Message-State: AOJu0YzbgK3Z/rNurhvu0f1t/kRCb/4koOzBG7errxO4ErEfIfFOi/Ui
 jbDJHpFKb0AaxElmCGYuilR04SU5CqDQxVs11w1TAZQPqwN18lEv9pYKDPrHsHxoV3DYux9Ovll
 uWnX+vy0VSn9WR5FOJygFFhKr0gAkbGOIFZLQG7uSEsws2qgPh3/ym+U3E1oGDN+WYw==
X-Gm-Gg: AR+sD12mN+vehwvIHnq0gFshdb/Shd7BvuSZClWjKDgxmXurYRnTZknfZMu3Egw+9hv
 GnHJ1v4aQVXmMUapRtJDiKX4bvpNIWeWgGo92YakDaHdZz8/bJWmZGOkruqp6OxVP3NSBQ5O/54
 OpuPOMFPzQJ6QAGgGYNHMIAbL6MnCRtOAffx3s4z7SiSv2AMuAlVkwA6BLLrZEk5P5VMXr+FjQe
 ABLDqo8mF9BS+D3qWKnP9+ypISTck0hDVau/5Ml1AziS9Ci83d4GOV+w8AQNaMv41jOhLbD3xAq
 +PbluNP+lEp4dWJUEcNuBsn9udHSF8t7mL7UjUyla0A3Wl/J1a03Spp7RQEo4Ma1+fy9crGcAkw
 Zn2HS5+TUQKVxvDI55nIw0Q566wtebrD1AWXQp+ZkA+ffteMuxguBoSZWK8+uKTs3ZrKKLMI=
X-Received: by 2002:a17:90b:4a43:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-38e4b44138fmr17061430a91.10.1784585844953; 
 Mon, 20 Jul 2026 15:17:24 -0700 (PDT)
X-Received: by 2002:a17:90b:4a43:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-38e4b44138fmr17061408a91.10.1784585844543; 
 Mon, 20 Jul 2026 15:17:24 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2cd6e6esm33855000c88.13.2026.07.20.15.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 15:17:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/2] meson.build: define CONFIG_KVM_HOST
Date: Mon, 20 Jul 2026 22:17:14 +0000
Message-ID: <20260720221715.27108-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720221715.27108-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260720221715.27108-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 44IP9Fa4Px7g0bTi9pCfBfzlDcZKshml
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDI0MiBTYWx0ZWRfX63S2gIFrpBLl
 LbyEQzMKM5qwNtT6w8r+ujLlN2ZCQLPjIOgbAKQTzJZrQKlT5P47lf33dKV7KwwXWJw4MwWHgIE
 mdbmoyTW90u1I6icWpcrcCHxDH43keE2RuDGgMHKpIYVow5P5GzGHOR7yjvrQS8jQIwgowaHdCN
 TCcbe3y2Rhs0uMQTQ6jMv9H3nNUh+ZHG5L0Y9OMzQlJvO6Mb+DJH5z3dMl/YzI+sW7xIMBTe94O
 ckHXPU9CdujyrSaH6mIZFLldWQya8sXaJoA8zF3iE5fHKdIvyUYK63Ea/IfKKBZzc8D9L7mlrLM
 cxfliDLgMCxc8zMDKIu/B38oB0km8+lydY1vPwkcwP4dJFomPPvi1BRS39D/jg7UqsOcDO54Hc1
 YzsrV3NafiIqse/6b4HuOzQw0fO5mtt28VJgeXAsHM8sE2V+JRpO1+cRL4h4S7XMfr/31D5e+dx
 Kwr+Id720+Q9cS0UO0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDI0MiBTYWx0ZWRfX8ndv/y4ZNzsy
 cBSOuSjjV56xII4w9AFe69Z42hI9I9xjV+Nfe6g7ZkV9rSb/wmoDKqHZs7SirZYjP2TW6/0pniO
 mpJxxAN5AESZ2v0Cu0VGsPV+qGo48XU=
X-Authority-Analysis: v=2.4 cv=daawG3Xe c=1 sm=1 tr=0 ts=6a5e9e75 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=DzptWh3yG9ibc3xU_dMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 44IP9Fa4Px7g0bTi9pCfBfzlDcZKshml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200242
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

True if we are on a host providing kvm acceleration. To the opposite of
CONFIG_KVM, it will be enabled for all targets.

We used that in next commit to enable hw/vfio on kvm hosts only.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 Kconfig.host | 3 +++
 meson.build  | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/Kconfig.host b/Kconfig.host
index 933425c74b4..a7d8baaf723 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -64,3 +64,6 @@ config HAVE_RUST
 
 config MAC_PVG
     bool
+
+config KVM_HOST
+    bool
diff --git a/meson.build b/meson.build
index 164328ded83..632650e7d09 100644
--- a/meson.build
+++ b/meson.build
@@ -274,6 +274,7 @@ else
   host_arch = cpu
 endif
 
+kvm_host = true
 if cpu == 'x86_64'
   kvm_targets = ['i386-softmmu', 'x86_64-softmmu']
 elif cpu == 'aarch64'
@@ -288,6 +289,7 @@ elif cpu == 'loongarch64'
   kvm_targets = ['loongarch64-softmmu']
 else
   kvm_targets = []
+  kvm_host = false
 endif
 accelerator_targets = { 'CONFIG_KVM': kvm_targets }
 
@@ -2255,6 +2257,8 @@ endif
 
 config_host_data = configuration_data()
 
+config_host_data.set('CONFIG_KVM_HOST', kvm_host)
+
 config_host_data.set('CONFIG_HAVE_RUST', have_rust)
 audio_drivers_selected = []
 if have_system
-- 
2.43.0


