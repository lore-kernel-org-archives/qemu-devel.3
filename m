Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63199C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZlY-0005g9-EF; Tue, 28 Jul 2026 00:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZk2-0002n5-19
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjz-000297-PW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ai6J1715002
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=I72i8fmmW5R
 rqAPZKyyIEUFoZ/nEA3u1hbKO/gLuVeY=; b=jzgA35ebOBLyYfQ2hQniV/F1Eor
 I0iVpFvDICqfcty4sP0K1MtpFzXyQO3smAG7Z75wcydPfD4pcZx5IZidYPHquwdj
 vaxjXqoxHzDZniNoORnjG+x/SlJVqLkkOYWr/UW6GaMESvvdiCuITvToNydmDslb
 gKGVC+OTc5E8IpR/p3UoqXjLy+dhH1A/XvdjEZf7dTg+V5/HvVv8aA4+wP/M0N6y
 8aZWxtlUejmuKSHFWlSoy47Oms5qGc6CC3kDzJfvW0YbRNsjS0NvjCePNcdY1KI9
 CDw2U18b04GoIytBDXhq1q+S0R7O7CDVyEyTzRTDZc2o9zz8AFIqB+M7mPA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkjyjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso4061771a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214100; x=1785818900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I72i8fmmW5RrqAPZKyyIEUFoZ/nEA3u1hbKO/gLuVeY=;
 b=K/OZndI7ZGXxwTGMpIBw3w5kVlCrj7IRQI9uhu/VG5lJhInROlEBphcIH8yPfNt08t
 yPTjVlZTajgSPPy3HqoTnS1bgmT64LN2LTtTaLKpKA1SemHvE2mRCQJkQ6la2xt9rFgF
 4hIBOQylkhzVaKP+y8Iz82q2ZeWJKTUM47+gKzfL3RRxX9UVmWHQFN1xWhHIQOi536JC
 7Y4CtPJpL2gQ7aY1ERSt2qnbvwpfJDujy5vXpTpquUDR5Tbl3VlYwe93ivqPvMIVAgkq
 vGzt0URbuRj5qbrAWdYRge4ICLwY31tIZ1ie+f8oD6jg48tSyO2D5hjLAvK7/q1pnpgE
 2N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214100; x=1785818900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I72i8fmmW5RrqAPZKyyIEUFoZ/nEA3u1hbKO/gLuVeY=;
 b=GQRNDnuOOpu3WnQ8Ou+J6C53aX+uVZ8YoBHPqkpNrQZpF2J/WA76l7opZ8pD/rccDl
 Uxjc7p3hmAga3ulGcZ4mVcPYRUiBlj0Nz/TixodcS0pGLRK1+iEoamSNMtIFrKX6wMNT
 mewMbkDHq1QOv08N5laYQ8vxFOylqpSLO7cKfZuL8WgMvkvLN0U/JHYDqUdq0tN1kG0A
 mYPoe0kHZImyfMVn7Gu4z0opvIYx+rQ+ExK/si60DVMAaaDKcA5l7AhN76zx7/Ym4mAD
 FnDNKQlOjdiqvk9TOxXv+oELRDuRQZh3uJUIi06Mc5wTvNV2Az0Vt50X98RWzns8T6sN
 qzcA==
X-Gm-Message-State: AOJu0Yx8Z+DjKsTcewNooolwYUAD07Z75Xn/Pf0y7ffKNze8ZJI+VTUQ
 f3Frvdj6ZlGPwFiC3qzcGylhmX7nxR3xoQ3Prhxjj5mgOsIyNIcML+KpDXs1Mmf5wRCMoBd/S5k
 ofGiPzc3G1Qx2BFZIT2kDzD5MeJ6lBu1oaUVY3l9vXBCmXfW1ETHLuZ8uBrGRbgkkMg==
X-Gm-Gg: AR+sD12AiARq+HUGnjqLmrKBtqtGDEMfAB2oTKsQPLqmh0kl1aKZPsSBVhuK0aJ0qRE
 /+iU9RLqfIF9ehbGGrAgjyruaeDf2T6ywYH0uUSCNRMFNorB0AHlVBfhC8oBWBIjoaxOTtDVuZZ
 nLZP0Loa9Txh/Vf5ipTZ7qg5E2deHO5LWw51rkr348d8dkYpcpaU2puAdgWZ+LuNwOr7BQGPa/c
 F3m6z7zR3uWVkLcoP8O9kR8+iYfS8Whk6Vi/LPn/dGwR6VTeG62ZMJg8fd5r9GIhWqZjhQTsCrK
 J/4Xsja5sCli6iYzIZmeIxpOxSzddHeBDXXJtlAqJLJcHp5IkBdr3NvCbkScpf5HwfQyvfk+3C5
 G2F6RS4GMRZCw8Kz2sCQm5XwQb4hTRGkySd2fdD8use1RsmV+cZmU60TZBWUDGtI8YY5pN44=
X-Received: by 2002:a17:90b:3143:b0:38e:76f8:fcbf with SMTP id
 98e67ed59e1d1-38f6a45f6f3mr865392a91.31.1785214099648; 
 Mon, 27 Jul 2026 21:48:19 -0700 (PDT)
X-Received: by 2002:a17:90b:3143:b0:38e:76f8:fcbf with SMTP id
 98e67ed59e1d1-38f6a45f6f3mr865353a91.31.1785214099182; 
 Mon, 27 Jul 2026 21:48:19 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 067/103]
 tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k toolchain
Date: Mon, 27 Jul 2026 21:42:11 -0700
Message-ID: <20260728044248.137626-68-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Rr03xRadlQK5AL9lXV-eCRejgnkeK0R_
X-Proofpoint-GUID: Rr03xRadlQK5AL9lXV-eCRejgnkeK0R_
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a683494 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=TNSyY6zQAAAA:8
 a=3B-k7g5EAAAA:20 a=EUspDBNiAAAA:8 a=ucEKaO2-bgP9YeC-RA4A:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=01gnQneks5i7xkQX6LlV:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX2rdsU1vJMB6z
 xCVPiS4sAo4UgIeNSwtoITZb7rQl9fFhi9JxYZWItaAsC4lW0s8triU+bQ1njLqtTeqxJa2uG+h
 cZRYgHUOLcQjmZXj9SHVSOvxhRC9XM9X7uc7cH7OUarAr2cmX9weNd8VVJqFxRmPoOimGGDWJaB
 16pcgD17uDVmiiT9af1U0SJ4GpGC93NHk7aEFrn+4yVQiJKW47gnQTZZqJcufcQ7q5TXf1NQCOu
 UspHw3usbFD600lVixaERtKVf05P9RUQu7+wA/lb3Bxa30iP9ugi2l2TfVxRTL0OEXt+P0YSk8b
 WLjLHnMxofimVn0k7mbdoGx8SS7GhZLtkoKDNqHlCH7Z/5ftw1UbaRdT7oo+hAKYjvLlCCx+Bi/
 jLBfZaWX6/vmSh9092O84LBTYJGSVq4C2HWHbrH/Mts0DdWeD4+hia6Wb3rRyWpSus0/Lv9Nkyl
 l4LlSepF2TVVx8ezOIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX8K7MYCX45Gxb
 +YW8qk760n8WIr0Hughm1teruR7ZWNf/2rEQxYpc1IpTKUAwMH6B5mWT65ekw5ixVIt/haxHbbN
 8ZNA5gkTXQ3ETjA6LG5DXJi6GOq2Dps=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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
 .../dockerfiles/debian-all-test-cross.docker       | 14 +++++++++++++-
 tests/lcitool/refresh                              | 14 +++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 2dc580552e3..449ea0301a0 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -61,7 +61,19 @@ RUN apt update && \
   clang\
   dpkg-dev\
   gdb-multiarch\
-  libclang-rt-dev
+  libclang-rt-dev\
+  wget\
+  rsync
+
+# https://openrisc.io/2025/04/20/toolchainrootfsbins
+RUN if dpkg-architecture -e amd64; then \
+cd /tmp && \
+  wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
+  tar --no-same-owner -xf *.tar.xz && \
+  rsync -a or1k-none-linux-musl/ /usr/ && \
+  rm -rf /tmp/*; \
+fi
+
 ENV AVAILABLE_COMPILERS="\
   gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 6bc611b0e6c..9a71af0e41d 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -172,7 +172,19 @@ RUN apt update && \
   clang\
   dpkg-dev\
   gdb-multiarch\
-  libclang-rt-dev
+  libclang-rt-dev\
+  wget\
+  rsync
+
+# https://openrisc.io/2025/04/20/toolchainrootfsbins
+RUN if dpkg-architecture -e amd64; then \
+cd /tmp && \
+  wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
+  tar --no-same-owner -xf *.tar.xz && \
+  rsync -a or1k-none-linux-musl/ /usr/ && \
+  rm -rf /tmp/*; \
+fi
+
 ENV AVAILABLE_COMPILERS="\
   gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
-- 
2.47.3


