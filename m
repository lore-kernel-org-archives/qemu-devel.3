Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16518C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVRu-0008EU-TS; Wed, 08 Jul 2026 12:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVRa-0008D2-Vv
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:48:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whVRY-0003pW-3S
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:48:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GLFBs3329919
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 16:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Vtku7rkGveb
 IwtehmYO8HYcXlaF+Fo4u8kpZYxmwjY4=; b=RWHzNM5HbvbpI2kWobtX5SE1o3k
 +NRJBBFu4dbNkHxi/QYFLPnCofdz+INWsXVfh4jPU2ftD4L3NB6BgZs7RogtZxW8
 kSEZoYmI+ZJVF/9cIz2sO7Lv7bI6El9Qk/nejrSF4XB44hbr+sJtKA7sK8xn0H3d
 +RbJzRPD7WNSaupuGBNdlPVjyaaa8A3oZw42XeWJO0RTeHBIijL8vZ+SxmTOl4p+
 yVrybYckMoRB/FkX4goeov6DidB9uKfa9Vy0SfG2mmYqCyndTKtHvvOQZ8USPZRr
 sCL/bMsxwT5QHTdSylamnyTm01SklWh7ejGfvtMg0E1q7HjhuoJR2xHCS+g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv2ggg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 16:48:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-388cfc4848dso35918a91.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783529293; x=1784134093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vtku7rkGvebIwtehmYO8HYcXlaF+Fo4u8kpZYxmwjY4=;
 b=AOk8HhMzxs1dqcLcP+/N7BjYFU+WRPu8uFTcLoIpnVhF4ZcjfyVk4RvZzRi18UJdI9
 SwYraDlLgyySiIPmWxXC+6QxDw/yQcMNp/BU+EtxABNiYRXYIoTiXJx4DgDoH2/EyR4X
 IskwhqshHs2mvPA2x3U2zSKRLd8PaQn9ZFJdJj1iCcx7eeBK4jtNMz+ZSZVnXlI0mxah
 uJq6HOYpGbPMmGOioZhL4v4nLH4StD+726XSv1FUVrPwL6j1lh5btGIT5buiyIdyQgbl
 8/RdFaOPpF8F7jcifn0EOGZcuqwOfh4YkNBk0iBqOlRLZzFcj1Muzl5Wdwndg5fH83Zm
 5+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783529293; x=1784134093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vtku7rkGvebIwtehmYO8HYcXlaF+Fo4u8kpZYxmwjY4=;
 b=cU+f2ECYxbV0qyrbSaTUZdL/nuGZNjhLdt412m4vgGA/YjYf2c1FgE8jBTavMPHv6c
 4COz195yuA2T//yLWzGBaAf0OOTh0yGBlN43X5+1myiJrvk/7tfOxfunmAdWJepiMpZ0
 gRgISHiMyg+Zscu6hwEoDOAArN9voNRrf2ICtNnSN0JllRNAI5427mJAX1h149PB8hRO
 EHY4B+oKQRV1HlCbMH763TGqezgvvy9JjDQD1Z9Zm+r22MQmZoSSRm8n0g+z+ZuXVd+7
 4sJEKluyOXJaKL6pC5vy3JX932AHCAOTEcHNrekOaQ/HL4WcqqoiuP6qSINxikYTgC5S
 opJg==
X-Gm-Message-State: AOJu0YzMxTxRPGC0cfb7TiD0LN1wO6Tw/9FbT495ia+v2HochJCtCjjy
 CNsCZ3sjqIir/fH+vUeEsA+CkmDGf/j2xfqujpxTGU+v0rnWaebWHtOn6eHSspIIEADySpRCssU
 woCMRHrciBmin4DEoSdZrZ24LRGNwFtd/YWbnDxo0iDqrHkhTT7GFWN3gbyIn1IqzkQ==
X-Gm-Gg: AfdE7ckGz0hZy2ZxiiIJr73rJ4h36yDOs15JqWXSzrPu8JiddxIsnv4aCuM3pAaoyia
 azgKdkt3bI7LrrzSx+018Py/9rIECB0ytMOPxEctDEteXQ5x2jGgo+YjnCyHwytc/kA+XvvGu9p
 AXfLZjX9T3zIf6sgcnHdvMEtYV8pFwFktWHdUDZyKvala83y7xYAqSJlmHD7r1++yQZ81oRNvhM
 NVBUUkx3qjfZ2wwKFTTB9H9cQj1BNt9r8cqyU61ErfhC5XiMIzVKCeBj7VEXgsmJbuEDqtrovAC
 h4+RUoppxuuoiTpFEBn40UhYm64TR0dyQTlVZzno0Hvt+b43/qdJaOLn7DwQeEmnI1bSZvRxDVj
 HwV0IYV/JW03BNif++6eoKrA25ERNJwT/9bFrta+UL+t/emcje1CTcQwdtYOSc8eGNl8f00BURv
 iVcYIr7w==
X-Received: by 2002:a17:90b:1fc8:b0:380:7d9f:81f1 with SMTP id
 98e67ed59e1d1-3893f6937ecmr3420107a91.3.1783529293019; 
 Wed, 08 Jul 2026 09:48:13 -0700 (PDT)
X-Received: by 2002:a17:90b:1fc8:b0:380:7d9f:81f1 with SMTP id
 98e67ed59e1d1-3893f6937ecmr3420080a91.3.1783529292569; 
 Wed, 08 Jul 2026 09:48:12 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f5975sm20603290eec.4.2026.07.08.09.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:48:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/4] tests/docker/dockerfiles/ubuntu2404.docker: add missing
 apt update
Date: Wed,  8 Jul 2026 09:47:56 -0700
Message-ID: <20260708164758.1168667-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708164758.1168667-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260708164758.1168667-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4e7f4d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=n6MYwUk4AAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WKaNRiMFEbhJKHKE1H0A:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE2NSBTYWx0ZWRfXwwWLj24KGTDF
 eNauwd9BigIGUDlGOFSZohSjSuOMn/G3U59Bbuc8cm9fMZmpW3Qmim+yhHnvB7HMIXYJDBvCS50
 YOmwqx9bHIi36kndhu6hm9M4LM0IVRw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE2NSBTYWx0ZWRfX6FTUfLhzpwk9
 qpx7/eI6mH3DfsjGhRFJfJVcKy8M6XPz7OHF1Sec9SliIxpAtjWIZ2HFykgrLz0zK7tgNH4ZT1N
 pVmfJ05SrAluiNmFqRHjBROiSKAqKCGOIcuGdt48b4ZCOZELIabs4KNHwjorpUfJK5TRZOaufD1
 qzxtZ/+yVDUH3uJYBCmPg+YK+lAnnWiLCwewGjFZWrdsITJ36Nl83LJCHuH6+vZ0C+BUC+sYHoM
 LNziEbuYRf2s4/oExrfgsJAygtf1dsXK9QQtYJ8nYhYwq31jLY6OgxYoOJ01PR+0vALgfpkLjAF
 ERAhoTCOh1GOzskyDBFc4DAfb7xmAn9ZOzcPhy8YMl/WQNcIC0GH+ToaNSyJ7a8CMQoU6rb9Irb
 YV+iItysKZc90eqbM7y97AhcLLbi0/Nebh47VvLyS/psmjlLcca3DO1YCtwj1NZWE/oyOvP+LIh
 MP77UxW8O5P2/6XmT7A==
X-Proofpoint-ORIG-GUID: wQ2yIMedUpmHzqprRDUYfKw0VLn1dXWF
X-Proofpoint-GUID: wQ2yIMedUpmHzqprRDUYfKw0VLn1dXWF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080165
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

RUN statements should always use apt update && apt install together:
https://docs.docker.com/build/building/best-practices/#apt-get

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260707214655.1138626-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/ubuntu2404.docker | 3 ++-
 tests/lcitool/refresh                      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
index 26bc2dd94f4..27992e34fd9 100644
--- a/tests/docker/dockerfiles/ubuntu2404.docker
+++ b/tests/docker/dockerfiles/ubuntu2404.docker
@@ -160,7 +160,8 @@ ENV RUSTC=/usr/bin/rustc-1.83
 ENV RUSTDOC=/usr/bin/rustdoc-1.83
 ENV CARGO_HOME=/usr/local/cargo
 ENV PATH=$CARGO_HOME/bin:$PATH
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends cargo
 RUN cargo install --locked bindgen-cli
 # As a final step configure the user (if env is defined)
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 1fdd37440c9..bbbc6d3c46a 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -157,7 +157,8 @@ ENV RUSTC=/usr/bin/rustc-1.83
 ENV RUSTDOC=/usr/bin/rustdoc-1.83
 ENV CARGO_HOME=/usr/local/cargo
 ENV PATH=$CARGO_HOME/bin:$PATH
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends cargo
 RUN cargo install --locked bindgen-cli
 """
-- 
2.47.3


