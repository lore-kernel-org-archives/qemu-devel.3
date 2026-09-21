Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3770C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 23:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8nEC-0008An-KZ; Mon, 21 Sep 2026 19:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nEA-00087b-8p
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nE8-0000Eq-50
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:14 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LKe6cm3423704
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=q0ZexaBhVhX
 alrgnUMGH/rGozk+hdy/24zRSO/OAn7I=; b=a5bF/zmSAeOL/jBOQcW7ec5GVIv
 I5Vub8/nYtrpGkKDUGEKVv1MqgAUd1sIaWvjatEHul33mk812oA9cWG1HyrfFzo/
 qIXgu3zzpdRlgVwytBPJqE8rvAUG11fmrKldI5S6BKa9AEM0/mupi7vB3oWbq/HM
 dx+O/Fs+t6mKyX3tJta76mm2dXNtmaMyKwuqTkc2iVp+SsEr78SjRXxwbfZVFXfH
 kQdWSlTEXZZNkbFiypDMx30rlhC01rJMcYGAlKdGL74vbnmARdpJ06WgAhkMyqRg
 4zftrsBNsqBVdCmUwStxNw2/BMpR1Ja0MC9X4EhO57gU8ryKw/KeW+oMHOQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8v517t7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39e3f521346so4042239a91.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 16:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790032510; x=1790637310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q0ZexaBhVhXalrgnUMGH/rGozk+hdy/24zRSO/OAn7I=;
 b=Apjy5XoFxs3iV2ZyUIkYQG8ZFOBu6EgxruiCxS2Z+xavpdNHoOaahq3fHDyPakCyot
 7KrRRlJqsf3onMshnlnabWRQuQ15ge54DqicMGubJCVOHjh6IGgbqKghqT0hn2S8+mL3
 IUltj/bOThkHlFcr+kPw20F1+aCYtA/dR9to/NjhnWrW79mze5Clz7LjiPQBt2rU837p
 u2g1bZuIgUppr9jgJ80ockDjDDwan9DB05mPujvPBC5wiVpTWUHWpFM0xJORPZ76H0wa
 fiRvXh4IJ+ukkEKiHgvUEGX211zAfNxISLZBevH8rqAFjsdZm0yZpVW4iWMBseW0Qkqx
 xRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790032510; x=1790637310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q0ZexaBhVhXalrgnUMGH/rGozk+hdy/24zRSO/OAn7I=;
 b=GLnRbivzybdBxj+t0yMWWvBBlRtq/qsWBbW4EjwjaHaVZkGDhT3eDQbIhUTHPFXMKi
 ZZJEJA30+5363LiAsiZVIgAsj/Eo5bRoCI1xBvHImCJZGRtr10iXLYZwBbuosk6jR0vr
 OuiljBtA5IZM83dsDM77ycbHrXewKkUyWe6GQjF5o57Xpt9uX8RJ3aQRg/Nezf6J+iql
 wCPvr6eSRAYhHHb5iBW1U2Aa3Xuy34+UAqkVOqGVdaDvFCYLC+1uzzfgw7JoWxxj9PF6
 ytcVo87atbb1MzY2OVG4GEoh/dxA10ZYYGT1zezoEP/MHzknMfSuf43AxTMqPYmtJX0R
 Kw1Q==
X-Gm-Message-State: AFuF++kFwMzb2AvAlJW5dlRlz1NuXvzdb8unTui/vTMokk3yjRvewHjD
 tAd+KiQDq0vpEIUNrjBAqS3A38wFr4Ln5BnVeNmEYFE09zOvxAtbGVQYUZmoNoZEjSe7y4nwqDO
 mZuIHGlSaexuXgR4BPWZ5PjcBfiI73JaNcIvYaorfvxyCFUmi6WLdgYchOWqdcc04kw==
X-Gm-Gg: AYBFou24bnySZR73F3isidICOdC3xfL6RsPxiImuVcqWscz5J6qQEv3nXSTxBxpyrKH
 m2gxybbG97ZYhgRuGMofLbR8RJlXgqPjfiN8Xj8sKUl/RAEK8EXnA4kbZychF5rAPiWSJq5c0tJ
 XhmGbwtUubFtZSn+s8dDzYymYuRhuxtAlYU831PsolGwWxkCRGWKKBMrS5oZROSZcXMiL4XoWNM
 7VT7bstMlg9VaqQh9L5wiwdxtW8zUlI2cC53J/xacl2C4WloLzYLpRMOf0Fzc7+u/idP2+9nacB
 TIQPZc6mYIT9Vu9/imIxHofvOf6jab5O3pm8qi86GZlfvzk6GzAPXGLbQBcHMDipphF0Qaj2Cdi
 5jUQvUlaFOUrVtpAIt85aW696vmQcPuXQfJo1FdZILzZ+i3NHNfwHYkppGdLJig==
X-Received: by 2002:a17:90b:5305:b0:39e:4c81:6c63 with SMTP id
 98e67ed59e1d1-39e54dbe3c1mr18425915a91.30.1790032509923; 
 Mon, 21 Sep 2026 16:15:09 -0700 (PDT)
X-Received: by 2002:a17:90b:5305:b0:39e:4c81:6c63 with SMTP id
 98e67ed59e1d1-39e54dbe3c1mr18425885a91.30.1790032509435; 
 Mon, 21 Sep 2026 16:15:09 -0700 (PDT)
Received: from localhost.localdomain (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0674c0b4bsm1295939a91.13.2026.09.21.16.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 16:15:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/7] tests/docker/dockerfiles: refresh images
Date: Mon, 21 Sep 2026 23:14:53 +0000
Message-ID: <20260921231458.3369-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NOqmo-_TU_c7IB8UUbg1Y_nq1UHYP1jo
X-Authority-Analysis: v=2.4 cv=B+0sQ+tM c=1 sm=1 tr=0 ts=6ab1ba7e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=kVxbpUQxIV2XF0y7jvsA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfXxblBIVTkCr4A
 Z1riFguKEzoiOufYGJh2SIR5jTngfiVZbhrgNeukiKSnfQPJrCVHQ2olyyvWH+hEPrIppeMOr5n
 pfBj6t1791p22mKyeZ7U1ZhVK+6oiIQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfXxhhmt5/bVINc
 u6+uA770O+3aCXPwsNvYaFTIYlVBvr8ieWyAyukchaxSsUQCKgAOwn8Vl3XXmsh69mTvWhzr8JC
 emAKWBP5q6LeyCOABF8ufhJvpJCQ88yU35nMoTyUQNXrCDEzLzPFdBgx64KNp/mK6oEFPRDIpIe
 tftsbeNhB7WaOb8iMbf+73pEQU8ZM9mhpRpRW8hvzFOsJ1S/r9LVyBjdyuIQtYoTgQsDKgzJkPo
 0MkqYQDKURZUv2SjY+z8nH2HyuINkfa1qDw5NATagZN1GyuyFgLMliy8S+fIKoXOCUIX/WePc0s
 vXqDIUu47ftLbSastpg28RhbGa26BleVLiTWxPOqEN0TchWMPmyraYn9dzTo3l8jEBFvbn9owj4
 EG68QgVz49hrN94W7XSLf8XqbHZpTpUF/kknclW8tKIpVaTzn3XP4kwc5eqYgATdenUbkMlYHCs
 SJabCB4zCkVB5zQ4TqA==
X-Proofpoint-ORIG-GUID: NOqmo-_TU_c7IB8UUbg1Y_nq1UHYP1jo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210340
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

latest update of libvirt-ci changed packages, but images were not
refreshed.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian.docker     | 1 -
 tests/docker/dockerfiles/ubuntu2404.docker | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 77869f71546..2d03ff03c8d 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libpcre2-dev \
                       libpipewire-0.3-dev \
                       libpixman-1-dev \
-                      libpmem-dev \
                       libpng-dev \
                       libpulse-dev \
                       librbd-dev \
diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
index bb8f4e4e53f..440699a5005 100644
--- a/tests/docker/dockerfiles/ubuntu2404.docker
+++ b/tests/docker/dockerfiles/ubuntu2404.docker
@@ -73,7 +73,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libpcre2-dev \
                       libpipewire-0.3-dev \
                       libpixman-1-dev \
-                      libpmem-dev \
                       libpng-dev \
                       libpulse-dev \
                       librbd-dev \
-- 
2.43.0


