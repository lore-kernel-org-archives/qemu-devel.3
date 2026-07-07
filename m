Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087B1C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whDdH-0002Fq-2Z; Tue, 07 Jul 2026 17:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDdF-0002FR-HE
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:47:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDdD-0003Kx-Sm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:47:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667J5w9o510395
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 21:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5QYAjb48QAK
 qHQkKyMdUn8rNqjO4IeqIHTaJxxo3k8Y=; b=AVwZ7k9eHU6bs5JgT+vdghUXU2k
 uTUd/2lDeZhGlLwemYlgRWPiDL7wNFgAn+4jR/y95SIJu+/tMRASYEXzKK5WfENN
 NLbwlwojR+YYsVjp5kgmpCjzhi5EHzSy5hcmqYB5bVVa8iGq9qL3nTGI8uzqqwzA
 vDK1nqLrGAUS7FMBo1ABCzicbvXtTQ/DAH6TOZXAqvDT3Z1s/EGfXGzhisl44pxo
 Dda4X7kJUDdguUnu4A3Uv2uXchffl6k+nwcpbS8cnqNBWj9yRq7qGlQny/57OOQm
 7P3Bg9ixQQMp7jDPxB40rGGP5oXAp6WlnfrMwrLBWTTJkoehzZ2+qEwuU/A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep3fp8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 21:47:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc640dfde3so725115ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783460826; x=1784065626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5QYAjb48QAKqHQkKyMdUn8rNqjO4IeqIHTaJxxo3k8Y=;
 b=jh6nJBhGgw68mLL1G+X5y7StxuhlFGWiHwZUhj3k7vgY+3clzpXHK0oP1xO71h4cQN
 J1zR35cAspMDp10FSi+kXm+5JlajyNa8Y7hRnMJBtPZXpJDfgKB8rjbGwC9nzIwm9j8T
 PB45SqEGieTELoDOf2w6MSRfPK6v9+ASeO1c9KhCUQSl4Tc62WToha9KJU1sQVrcw1Hk
 BXlrvL19G6hqWaPorsJCdI5KXIKSzDr5H06tNc90gGNI16KoUavWIEYnQuaqRs7ML3Gq
 qm6yKd9PwU/dxA2PSP1cRU5SbZvuo42awWjRoTS3qT1KHPiLjKsjrfaMNq/PqzYX/TEX
 L7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783460826; x=1784065626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5QYAjb48QAKqHQkKyMdUn8rNqjO4IeqIHTaJxxo3k8Y=;
 b=UWJxCyBLm2d1bAR7G4CwLj2tUe9Ib0cgoHpMu2RkAiLqJuEnp3oRgX/EzRqkknSzPe
 spfsepFe//5fcRgmUO0EYhXu0kRZCpeqz12uQAuLJvKnDGb1I5vtn3X/hkzkmKonvcFe
 aICSGoGgzWnCMRbaLT3mJyP4fu4582GCe/z3ChO6UgzQBpqCFRLjUa/FudNVT6fxFu0j
 ncH0D+x0XLkayvWD4V/wBdDDMX3M7igkKLgJdWd0W3sLeMhtmx4qDemtvNStNQ+U1wgk
 H8WKiqubD3M5X/bmfJnS6ovyNsE2stK+VVmiL7R/lbL8xFjCV3+nYRCpyO+X7hTgOOeJ
 QtcQ==
X-Gm-Message-State: AOJu0YxRCYPXOZpXWXYyCo8vEu5bFXoOEhfNBO3WdEy6l+LgtB/U3hWe
 wI0fAMvCqdWkcQCI+VrBbX5ilEfQrmdiU/vlcgCTr2J/Uncm5ADa/z2alG0pVE8tl5058nFbI6z
 g9eUsyMkpNnIDoUIu4hfuea5uxvTNf3ju46tEDJKXC2fYqsJMD6pMJPNnGJeaBNhFAA==
X-Gm-Gg: AfdE7cmY9dN5DqiWs4frpoO+bRrmfPoWYX50/njPwGTXUo8Az8AwqLyTkO3Fn6YoPtH
 CCFqyRCLFlJvwHn+h2LIT+o9GEWzcDjo3XdtDtU09YrNuqTTJGwh3AHzVDfTx2+rvwAOYKvR7hx
 2QBZ3VIekkl157wdFllPHMK/NtFMAygtUZV6Viw9bkfNBOKdXPXrha8P8f0O3RU1W+OlZBmBvfo
 WVnJZNLHRYmA1B8+bnL6I05wR9KhgFg7EGOfOGW5UveOIyckmHIbnj7v8j2qDtnHrrCoiqEXyc8
 D8Waxlh9Mkc9i7cnhsC+PUfAORtXGVAsw/SeZ7uc1vhLqzrpXHDFgvP4QmkOdbjaDQ1myrNw1zW
 OK4d4kGSd3ov/MhYzzgA40nf7MDo7sC9twNej8m3BFz3sBW7vuETHb1vYDlb92V/TxR2OZdEr
X-Received: by 2002:a17:903:1b44:b0:2ca:6d2a:871 with SMTP id
 d9443c01a7336-2ccbf1894c1mr77031785ad.37.1783460825793; 
 Tue, 07 Jul 2026 14:47:05 -0700 (PDT)
X-Received: by 2002:a17:903:1b44:b0:2ca:6d2a:871 with SMTP id
 d9443c01a7336-2ccbf1894c1mr77031595ad.37.1783460825351; 
 Tue, 07 Jul 2026 14:47:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdcbe2sm18368045ad.9.2026.07.07.14.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 14:47:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 berrange@redhat.com, mjt@tls.msk.ru
Subject: [PATCH 3/4] tests/docker/dockerfiles/debian.docker: add missing apt
 update
Date: Tue,  7 Jul 2026 14:46:54 -0700
Message-ID: <20260707214655.1138626-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uqaK9wPywRGyRK6G0qvPXTRRl0yHKz8N
X-Proofpoint-ORIG-GUID: uqaK9wPywRGyRK6G0qvPXTRRl0yHKz8N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIxMyBTYWx0ZWRfX96Ze7igQtCSG
 H1NZmaoOapbt41zjytpJxbMbP3WkXnxWK9ugBTtVyeNdzHVu53LRSaecj+AwIAzHAOabytOvKoS
 SZR5T2Oqs2gjBuMF+K8oG6M6A2283S3N9b9QESVfv36zR2iqL7IYnx2IePSssRQ9jG9wxoW4FeG
 cxGX44ZeLIBqxtCIFvf/a2gZy1IdFFlSNUDfPdYOPBwaNlJBKdF1WoL1AlbZ+eJiQcWZ1Dvrsbk
 hVDC7gQy3ZgXApnHtHhr2FYJmd4l+RlgzVpiRgAj2ESJGXOr/MrnofJOByCty8je0WZ+rMPelti
 oTVvKKuVbThEcaKTdqseTV99RU7K29C2nSZzdJfa4LMb6GYlJodLLHvF9LVQKsgAZRJdrDdJyg9
 y8+euST64XFqpvOLyi8rnX6GQYXQ00rWNaDlOU0VbGCexLIJB5//KsTKc/qUILzATB8jmQIDr07
 OqG1D/tvCu3sFzSUq5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIxMyBTYWx0ZWRfX0hQWX3rW6pUO
 qZ6FOk+ZEjuhon5xCMnnQbe41kWCO9S8Ugn94l6DIJYhPOvD5297yykPXjzZH2Hxi2GnhSxx9Vt
 Ebg5Pi/Y9uLpUY9U+OnBoc/19DUI4g4=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4d73da cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=n6MYwUk4AAAA:8
 a=EUspDBNiAAAA:8 a=TfQWm953iMTqW6bhDMEA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070213
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian.docker | 3 ++-
 tests/lcitool/refresh                  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index ee8b313d654..413986d3f07 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -157,7 +157,8 @@ ENV MAKE="/usr/bin/make"
 ENV NINJA="/usr/bin/ninja"
 ENV PYTHON="/usr/bin/python3"
 # netmap/cscope/global
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
   cscope\
   global\
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index bbbc6d3c46a..8def84d946e 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -111,7 +111,8 @@ RUN apk add clang19-libclang
 # test
 debian13_extras = r"""
 # netmap/cscope/global
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
   cscope\
   global\
-- 
2.47.3


