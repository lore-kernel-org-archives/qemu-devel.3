Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A8606A333
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EIM78m2+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cILL5kKB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMaH-0001yZ-JW; Tue, 17 Nov 2026 12:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTMaF-0001vw-JE
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:03:03 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTMaE-0006U6-0D
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:03:03 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQhI2534599
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 17:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=0MGFBCMiYT3iivHZgTlhN22IIhCg3Zi6Q2/
 bH2WR/TU=; b=EIM78m2+ovLLpzKPGaml0SqyG3SpCfJEJVqbLiwaRnUH0pnisPv
 7QB76GGXh76ahQYCQXkCywakXh+fnPAjRPkM8oNwhDVga6OcSmSaOASwWxiHjjpG
 0JWQ3AyNVOf9kRJbQj//UnePYsq8nzCFPQ1Z0Z6rK3AvgQ+6rd6gU99898VEEhLy
 /WD5F1exxjb0+CSjLxZ9Eqhrf9wUn6IiERgsUkhLCs4SU0NUxcJKgfb0htCai3V1
 y79JQFwWPLamFORUrwiStYmd1x0d08d5KniPYrfgnVdoRy2if2cGWOHrM6tJyoKF
 MYBFL3WPNcK8MQg7aCPuAumKdJmUKKYPweg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0gfr2v2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 17:03:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b167bc8e16so4207154a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 09:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794934979; x=1795539779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0MGFBCMiYT3iivHZgTlhN22IIhCg3Zi6Q2/bH2WR/TU=;
 b=cILL5kKB1kUkF0aBWgcDZxdZuxZ/q0i9T6e9UyegM1fQoYlZ7AjDdwpas++VK5ROQf
 CGgEZhqls6PZ7fz+DOhhf/aOPXsIvl0pQcZo6Cjo914XPkUGElmADfq7z420A0O+5ou7
 RL6scIBRLox0NFdL8eFfjb9QGkC8p7b1BfyjKpSYswM2fYYEeHNvyp0uzZKVWsYu3SZi
 GkqK5fTzjBzxqoofxhkDmCmkHVG7JK//D7vZDJw+Mnj79gqo7AFwGm+82irqTm5SczxB
 Dk0VOaybv1hOt4CWynHhmT9QzyVeo4xRYGO6BLVkge58oso1o4KiMDLzTw2XYlbgp/50
 //rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794934979; x=1795539779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0MGFBCMiYT3iivHZgTlhN22IIhCg3Zi6Q2/bH2WR/TU=;
 b=h9TLxqePpnsUT/sNILEbZTGujclzepUiIAI78qa0UkDHt0D+TE5IPrwdTo5N/Sbgn7
 mdQeErsoTunLsCKgAoKjo8L0OlzNLD4vpZeK5+ciOWRtd1lm9gz1/gpoSIZKJ8xugmkO
 7TwlBMv04LiokrHTlM5uM91XVj1dkPc60wES4fleTHtgOF7eIWXajMMqOngT0CSU4wy5
 fglV+/BHsUOlnFr8LEAPh6n8qaSdiA5LIV+o2gizRqlYUXJlW6XiNpRbTAgGtBdVUjTc
 uV642K2pVPkapTeqIvrfWSQPYaxLeFZs4LjQvMmV+sflusCnuSwiNjCLUWWs9foZbE2J
 iB0w==
X-Gm-Message-State: APuU4Z+r0XdPPlyNQiLUBTAtYYUEE5iQZYYA/tKpY4Ho0rVdQ66SoodJ
 9TkXn4TI6fzbuevOlFQvQl1tECyiFzI/gHuHib2+Ujw4mDcLaeOxwuCgktDp5n5uOxjOzeC7/6p
 t2v6XnAn4hCpjNJ18VIe9VPdlIvq4tCUnsTW9b4Eei9CF3+TqcJNdjyaewoOEUL8s8A==
X-Gm-Gg: AZFdTZfnmBPSrAICrfN7WiEzZyV+PMCKLj71v0sFZp9/pPwuOkBKZLhFxS/wTmMQjk+
 uSo/lMrkL1skNgeZ3aCqlg/2DSB8MyT1zKSXpTpi3Og4Dxy8+34tHYkAO20R+bBSNy4wwTZuLQd
 7634v0Vs4wWYksfxsaF1AQg1Z3oQ/19J2MNjeSSGzZ0J1SDsBIoCOLNPkD/Y2r2Ry8nN8S97Stl
 zVan8uaa9+Ml4xgEEQnvlQCTIpBZqT177jV4QpEFXKcSOuA3J9XDE+jmJZiA8FkkxtWoPe8Fycs
 740hAKwWVFNjZoV60FUZprdxsKgiDE8pjOqGHuunZZ8COXFtwzh+WO1ucpenaboDIFHT2lhtHDU
 67TC+P2+nyLDd4HKevPB136+ID29mOe3TLx+kP1N7zynq587VXN0fp77CFAf4NCmG2gJr6FfnjA
 l/GHpaLT2JGZTml+dpEHcKDqnpsQQ6GmwRLq0M
X-Received: by 2002:a17:90b:2790:b0:3ac:9d83:8861 with SMTP id
 98e67ed59e1d1-3b3d0850989mr20986a91.67.1794934979200; 
 Tue, 17 Nov 2026 09:02:59 -0800 (PST)
X-Received: by 2002:a17:90b:2790:b0:3ac:9d83:8861 with SMTP id
 98e67ed59e1d1-3b3d0850989mr20944a91.67.1794934978710; 
 Tue, 17 Nov 2026 09:02:58 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abd04015sm4978382a91.7.2026.11.17.09.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:02:57 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, pick Peter Xu <peterx@redhat.com0>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2] tests/docker/dockerfiles/release: use full registry name
 for image
Date: Tue, 17 Nov 2026 10:02:44 -0700
Message-ID: <20261117170244.3180399-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X/rHu2Te c=1 sm=1 tr=0 ts=6afc88c4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=VcoGlQnK1AbXNVE_XfsA:9 a=0lgtpPvCYYIA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: uVwWABtGyhd4YMKvFbWmzVDJQceSi9lW
X-Proofpoint-ORIG-GUID: uVwWABtGyhd4YMKvFbWmzVDJQceSi9lW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2NyBTYWx0ZWRfX2FQvuyPG7DYn
 ybMZ7OhR48Nsq9H6FodmqS/ObMuUEizrGT+JDSwQoNX9rAiiGBzpNRXARu+370p00dljEGpH8aV
 abhxxc6J7ZlsGxAfjT2lBlod/7THtTWH/wBN0pmmfjC7HuXPxeCsXOIacyEH+T4Dac0A5zsBbbi
 0toIWaH6Y6orzeASEnF70bxcPRY5Rp16b61BdSftTfWGpBGeygHSFuV+wlYvVC6SFnMQ3yWAVjE
 yq2DFwI4y3IvxsV52PqTf8rUSK9Ad6tyh4sOhf4DDHx0JeTguUQjwxctaH32ywJCVvcTu0fqq2t
 YyT4trqSNhLJ384V+etSoiBwdjWxNQY3iaCvJTevT+uoquNjgmgTLELsrDyTuVMqAossziyv587
 qNPMZlaAl/jyUhLeZAd5ry5hwcK0P3gXwzFQAC4hQlDJ1BK9tWutHslfJU0VRuIjJjwnJNY2cba
 s4ECgXV6BaKdzsxQmwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2NyBTYWx0ZWRfXxsMseI1p2nkA
 ZVLYdCne2cn40Qz1RcJCb4CB93RkCStSQFE2F1ZycbD94EaJQ4t6x46Ytuw5Woh5v9wutd6W4YB
 mm0Y2OykqINLynvYksRF6GcwetPs8PQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170067
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

By default, podman does not have docker.io preconfigured as default
registry, so building fails.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/release.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
index ca6babde01e..23cd64a9829 100644
--- a/tests/docker/dockerfiles/release.docker
+++ b/tests/docker/dockerfiles/release.docker
@@ -1,6 +1,6 @@
 ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
 
-FROM ubuntu:$UBUNTU_VERSION AS build
+FROM docker.io/library/ubuntu:$UBUNTU_VERSION AS build
 
 # add deb-src for apt build-dep
 RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
-- 
2.47.3


