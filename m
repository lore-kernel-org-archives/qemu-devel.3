Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83506C982FE
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 00:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9AUT-0008UV-2G; Tue, 22 Sep 2026 20:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9AUQ-0008U3-Ky
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 20:05:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9AUN-0003k2-MA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 20:05:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIXPCP268302
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 00:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=OogBYc5AjVZLXOWAIBchxjCjFZVlTTil2D1
 2nA51tM8=; b=locv2GUzurM9i77D+FkRanuh/bd40wOed7FNMAlHXsnKTzxU+zl
 AxDZ4cZuVvo9uttI9h0FMrsZFa63qwu7++kGd2U+mse7mNTq4iERal3m+s14dtRn
 2Pk4iWBUT62lGCGXFaNlKHkHtQUjtI+yPtlXLw+POku3YCfFXUWUzPZxB51PGWPJ
 dPG8jXmeHpBp9NE40kbFnVfEE3T2+h/u7sb31DuUMnlOoWPW4m2O9/apECJ0TxxJ
 VYZRuazT+iVbiFJNVZmFiNenpXD8085ZhAtWYoI5n5wTFrKhUle69ggU9phI/cvQ
 OnQzxmWj53V/wTFEQuKncfGPLUuyqE/PpNg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guy2c1arn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 00:05:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-32850005b6bso413005eec.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 17:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790121928; x=1790726728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OogBYc5AjVZLXOWAIBchxjCjFZVlTTil2D12nA51tM8=;
 b=YgTNmKTg+EscHPuNowBH9EKNWh7lBEphJ4iytJlOXY443/pSSO6F0NbeUGQiHFfhgE
 cf4wgpuEITjkIJNg4vs/QJHIOBma0/jXec8VmRNFhD9VlLpodjE+GF/SE5fpBypqa+az
 /82TgqybDt8j7U9NLbsGCs9APVHDiBbs67zEU7hZfNa88VuF0adPd99HvRaTZPexiW0b
 cs8qEy0VpdJBTBqHWJVLNJKJvCaoxll2GoWrw40X3i3U0GS/T9SsP84DbNPERcIT86rA
 jcYmgcNjuBAhp2UU7mKgnocAYpzCL4u+bBTknEnH+xQiIEbY/WfS2K7EvuuDAjkTfAA9
 O5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790121928; x=1790726728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OogBYc5AjVZLXOWAIBchxjCjFZVlTTil2D12nA51tM8=;
 b=t3UisyHXCi2ChKxPE5P3Y/d2vzcO2+htHbg2NXC7Sk8qLAscr7GK1+DNS1Pxa2/Wen
 aMpm5vdeoj6GfCWVD0pFl+P+xoyQZuRRrALYvTu24k3W8aq3VnSXcp/MBiNueeJlR3nX
 pRDkm5LfXkOhmReS4Yh25UNem5GbfpdUxQh78Jk3xI3gF2HY+V6/DNO6bAzImQ8XaCar
 /vVq2wmIEYBKJ/xygMD3mUPiSVhqKdsU1nIIVazDi4i37Mcq+L4u3IcuAQVSxn7wCP0U
 XPsUfwnk5r0dR4bgyAgZtuxxP+2XVno8q754l78N6u+Vrnhep+sZhcOY+A3PvcjjhRp0
 ySmQ==
X-Gm-Message-State: AFuF++kFtjpNWbQHX85IRv4sPCzCRvvAC/f6wgiSIv9CZSAGAleGYpdz
 G2HmelCSbaONcW9ybmnj4bdaVTLNOkx2Vkq4oN4a6c8gbIGwk36UMS6Rg9H3hFqeouh6ucM5ZE0
 cR/9apyXFZCqQQvZ/9r6qP4HwwS3EfckyCxJzsk1pGF5R/FvqcE3HAFlgF85DH2BD7w==
X-Gm-Gg: AYBFou0EYcwn7IGU/1VyG6IMAJWYLe1LTkc9cx9DAu3+P/ur/R1+I052ZMlO2ZkA0Og
 plsZ6BqVD+y99LbVnRIGiFMrZc/CiszuJ8iG9iW6/1KK9WN6vQ1bIMBQZgZm6gCtakBndmUp1NN
 arpbHN7XNs+z7+8NMCGmYejE21T8md3J7UAlKKINraVVUkL3iKrsJl1jkb5zl+f2OI+L1dNlQce
 JWxjGyaY3gtO8UDD23fqTtB2XaV8jDIQTMTAMQ29ydkznYanj8+D5v7Q24UTj29RMDAi/lGvsRx
 1D3elQP0dkROe3Eo2RHYPmkORPXUo1Mqe0OycRR0V6SM5ydK/VHnWTbRzdbZE3flVhVl71r5Eg4
 KoG4z4Ngbv0GR6h6Nf5D8PHSZ+SEue5HeL/TRCF9TTSs/X9+3eH0JQTUUuQ==
X-Received: by 2002:a05:7300:6702:b0:33b:bae2:27d7 with SMTP id
 5a478bee46e88-33e8c72c4f7mr1051608eec.17.1790121927770; 
 Tue, 22 Sep 2026 17:05:27 -0700 (PDT)
X-Received: by 2002:a05:7300:6702:b0:33b:bae2:27d7 with SMTP id
 5a478bee46e88-33e8c72c4f7mr1051574eec.17.1790121927214; 
 Tue, 22 Sep 2026 17:05:27 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e9625921asm1541450eec.15.2026.09.22.17.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 17:05:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Xianglai Li <lixianglai@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/docker/dockerfiles/debian-loongarch-cross: update
 toolchain
Date: Wed, 23 Sep 2026 00:05:10 +0000
Message-ID: <20260923000510.218473-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bTRvCzm6kG-OZguvvHL36Ozm6bi9Kd0E
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwMCBTYWx0ZWRfX7agCfnxyZ8qx
 M2s1edRkPQG0tvdqFSjEWcbem9WlNZcuNC7lPu2LXQwGYVbhgwqsCDVyWG/kmMeX/NR9nSOhARl
 J9k9VebSdJWpIzNKYOk3efJjt8GLyWQ=
X-Authority-Analysis: v=2.4 cv=Zsh4uN7G c=1 sm=1 tr=0 ts=6ab317c9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=tz06iiwTAAAA:20
 a=EUspDBNiAAAA:8 a=XKAN2JTTLjoc6SpHPz8A:9 a=PxkB5W3o20Ba91AHUih5:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: bTRvCzm6kG-OZguvvHL36Ozm6bi9Kd0E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwMCBTYWx0ZWRfXyWp+RZyaW/8y
 h6xFIK5RFcTvjIKqGLsickMiCULFgzEDdQca+v5Eeq19T11oaMeQ0BtbaX2pLpGkFyMjIekNmZw
 BMRjscj8Ih7svHLpDJGIrBZJhTuJLBaJ/USKk7hNQyQq0m7QV1g3/tzvtykEQqpL6as2ZZ8rnok
 J6aTxDCmmmAjBoUs+VCN0akzEygu50fejEbNpyIvkQVabRH3dgq4bf+PGjNlgyFau4+c03eDLib
 02hFSlbSyQMqRNCXTcJdOUQNaEAVO11GWeq3VUkQLhAIL6Gc9HjQTkTxi+7y0llcxnHzwUzj5ED
 CDZL2tsRkDVpaf4iKtVfwNA1MeDSsa/0gE29HzcjOeYY5c2mcnKVI+PODVvs32zEoeMj+UL7vk8
 o/H71rFSVAFvDjFn7k05hn19v3qP9MVNNrllL8pJuhBq2qRZJjXsrRpJEPaHQoVmJGUBpgRDGxv
 bSqqEjyJiYiahQfj0AA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230000
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

The previous toolchain was embedding full libc when doing static linking
for tcg-tests. As a result, each binary was 4MB is size.
With updated toolchain, only needed functions are linked, thus reducing
binary size.

As a result, we save ~140MB of disk space for tcg-tests.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-loongarch-cross.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index d2ba07972ce..c3c3c0a4996 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -37,7 +37,7 @@ RUN apt-get update && \
         python3-wheel && \
         dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.08/CLFS-loongarch64-8.1-x86_64-cross-tools-gcc-glibc.tar.xz \
+RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2025.08.08/x86_64-cross-tools-loongarch64-binutils_2.45-gcc_15.1.0-glibc_2.42.tar.xz \
     | tar -xJC /opt
 
 ENV PATH=$PATH:/opt/cross-tools/bin
-- 
2.43.0


