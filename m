Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A68CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 00:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnFu-00078O-Tv; Tue, 13 Oct 2026 20:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnFs-00077p-Tz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:54:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnFq-0004KM-Gq
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:54:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DKx40n1402944
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vChicHzJdk8
 fx07dp3F4nySlwDIblWP3jMlYYISqgzA=; b=NRWsd5/O4Mqvvcp/vSP7XuQvJET
 EVM/C11n/og95sDPszlsB4RJUPimEoZV1Ly3fLDbje/j0DRi3o5bhskfXc1y/s3R
 v14snUGZVjPXvfXEq4QQga6znta/m3EmYcpk3TOB+JEYa2Oq5ihwzsdHoGFfuRnC
 GiV5Srt8+O5SUAX/iyLv3Q1YnilixtJv4AW0BmpI83sbkqWZuPM5Br8y+PDIxFip
 kZ7xplTQ4OrwY2Sj1WkaOpVzI8TdVKV2KwwYciwMzvQkT7EOazV4wlljVATAJBdU
 ViRR9aoFGRmeb/H5BSUOeJ2OgzN/c56EfrrSGshL7Qq6dxYzs0lDY0QKZPg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9psk2aqn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:54:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso5338340eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 17:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791939240; x=1792544040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vChicHzJdk8fx07dp3F4nySlwDIblWP3jMlYYISqgzA=;
 b=LIJHg6+T9nG1y5iwu6gCEOCeSMcOduQcerChDIZbRWVQuqlKgPnDmQDD8a8y30PIc7
 XLR90pkRrHv6AcbmlrRBmETBhjP704/bIQoCyUvcprYpWpy/w5qWLts7KrVqExukCZoR
 YTPo6r8DPE6dt3dKXtnA7ZXfUT1TqCjWnVxYTSlb42Z+trLYnXf1O6mjoMxMfLKKuny3
 SOJvj6c9iPtl+i08gW7HKsONmKIwLjRqz7F20o+FmA2S2fyR5McbUnnvSglvA0zkk81d
 gTSuaZvIkSf/BX+hNZP+6SbBieT0l7GqjUT7FguEpmn66xiG7ufCOcNkxRibHoOLa7bX
 7DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791939240; x=1792544040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vChicHzJdk8fx07dp3F4nySlwDIblWP3jMlYYISqgzA=;
 b=J/AVu13UpbmuPo2L73jeC8Z9w67IpdCu7ncK9kUL5zdiAQHkZTsavGrLDnzXY+RsTK
 GSsXXk85WcH0RnuzEmJSYnORq7rTnDcD/XyMdrbbuWgCZBXKuKWF12SPuOVqqy4WrFhG
 uiiF05sEzGKQlHDIh6lYXClL1in6ek1e8OgTclDdwNd9bZ/s1/1kVlYOGrWl+/ozQaxx
 5XTgZumUCapiVVgHCmsNgvn4EFWGVlTPDOQjZLCO9hGuzEDisjBpnMoIITCYl7egBvSj
 iaXCOeHV1mhpDju6OtdlNPcQUO6zMDDEQH3ydTcQ05Kk0rtpO6/ERNmSp8Zz+u6pLx9/
 xLMg==
X-Gm-Message-State: AFq9FYJxgRCDdySCqmqAUoiLuxv4t+ZUv2Ag5UcN+uOdckoj54dr/Mi2
 sdEEJX5Q14sWWC967qSjbxrlwvgOioWYsvMC6qUjAh5TbOu41dE3iBzECkG2UEn5LIZZoru+oln
 9ZE9nAhRYT67tn2CRdFtvLuNfXbRzdrAlLSjJgUXi7GiP9mB4eIehykVvFeeGY5fw1g==
X-Gm-Gg: AYBFou0Dgs9Pu6JtFWp3kkF6Jz3vdbbgrdW+fA3rjtf3Bfz55YQu+NCBSiuYtpbkB4Y
 od7BRTGB9sSVxxnA6AhAscceRkJ29hWOTohlP9rU4hSj/om+/OprgSpffF8LbLtW5VVDQsBVsjp
 fO5eiPc/o+Qt4sl8AAUWPa8V8fZ8vl5+vgAJTlRVRXS596GK9bFaM2qWnYfzd6TLvd52Ck+5qTx
 cuvr6ByWLfFWyNaw8vIxfS6uWLaVZMqONGq3YFmu2lxEIDHkKQlFg09TfrEt4E02a9cLlrfywzn
 wrT6oggYLwLtGLrVwA4tTHGLF2aJ6g1qY26QfwA3XSWnPOyI6QAvApQ8zue462jLHzwpmZGGQMZ
 K9OdN3SLsavCyL5L1QKFhPX2i+y14/d4ulMuTmtMXcEz0fMTVf1kMZdW5MkK3
X-Received: by 2002:a05:693c:23c6:b0:351:1f56:3a89 with SMTP id
 5a478bee46e88-3537e00a83amr28132784eec.23.1791939240300; 
 Tue, 13 Oct 2026 17:54:00 -0700 (PDT)
X-Received: by 2002:a05:693c:23c6:b0:351:1f56:3a89 with SMTP id
 5a478bee46e88-3537e00a83amr28132738eec.23.1791939239730; 
 Tue, 13 Oct 2026 17:53:59 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-359789fde97sm31823564eec.20.2026.10.13.17.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 17:53:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 mjt@tls.msk.ru, peterx@redhat.com, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 2/3] scripts: add build_release_container.sh
Date: Wed, 14 Oct 2026 00:53:37 +0000
Message-ID: <20261014005338.34657-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HxlbkPrlKRaLmJNy583Q6LVFWTBYpY8t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwMyBTYWx0ZWRfXxife8hkHoejU
 h2wR+ulFMCfRZyjQOIifyZxIcbL1EqgC3GFie2kxYHIoxMNlt2jTy/9O6FIgaq/C47smPvlVOgX
 GGlvRPGSo79ZJSC+KAMbR+RzrdaxRwQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwMyBTYWx0ZWRfX+KE6cVHwGdur
 HCfEPrHzzd8j1HDb6os1vKEWZqp4J5VfL3b9FOIJSXJv1JPbwgcv/oCDAWqyXAXEE0/S9PFUupm
 uPvD/3vCEV8FvJeRchpcPVMSgOCVkmGK35sRxXGZi+oFHHDpKtoumqeMraUIIhn/bxYtlVQzeB8
 kCK3p1+H6YQwNaPsrI09X6008nWV9Zg0TRM8VsRwY7/qu+QUj2FSfhXn2u8M3zh33lvVHrGTGKe
 zaehn/9S4y8Cdx8uJ6CqPL08gTGGSaz4EhOdqnVOJecNQH4FKloYc79W3qJDwTDViXjZYWGfcrk
 3CFr9TouG41WKWqt/yRUkobjzlRMcWf+jELvrv/4rpeo2ejWNGqmDh6fQbAxh5B9jCzkwe1ddrR
 sdaEOY1bODr2RH5Mla0k0p6W7NQGy/RPJqUlWOEw1tARmoUdJZr32RLDJ2vBlJmlbwKhAro2seq
 I0l5aO0obrxsaI0wdzA==
X-Authority-Analysis: v=2.4 cv=cbJHPXDM c=1 sm=1 tr=0 ts=6aced2a9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=HuU_MOfc58QDrxAvbQAA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: HxlbkPrlKRaLmJNy583Q6LVFWTBYpY8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140003
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

This script allows to easily build a qemu release container, based on
dockerfile introduced in previous commit.

It filters available versions, names image "qemu/$version", it
automatically detects which ubuntu version should be used to build it.

$ ./scripts/build_release_container.sh v0.12.0
$ podman run -it --rm qemu/v0.12.0 qemu-system-arm --version
QEMU PC emulator version 0.12.0, Copyright (c) 2003-2008 Fabrice Bellard

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/build_release_container.sh | 62 ++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100755 scripts/build_release_container.sh

diff --git a/scripts/build_release_container.sh b/scripts/build_release_container.sh
new file mode 100755
index 00000000000..38910f60e8f
--- /dev/null
+++ b/scripts/build_release_container.sh
@@ -0,0 +1,62 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+script_dir=$(dirname $(readlink -f $0))
+
+# We use ubuntu LTS containers, as original repo urls still exist for old
+# distros (>= 14.04). On ubuntu <= 10.04, binaries (including apt-get) segfault
+# due to missing vsyscall emulation on modern kernels, which leave us with
+# 12.04 as the oldest distro usable.
+#
+# The oldest buildable release is v0.12.0, as previous ones require gcc 3.X.
+oldest_release=v0.12.0
+
+if [ $# -ne 1 ]; then
+    echo "usage: tag (>= $oldest_release)"
+    exit 1
+fi
+version=$1;shift
+
+tags()
+{
+    git tag --sort=creatordate | grep '^v[0-9]' | grep -A 10000 $oldest_release
+}
+
+if ! tags | grep -q "^$version$"; then
+    echo "version $version is not available, check git tag (>= $oldest_release)"
+    exit 1
+fi
+
+year=$(git log -1 --format='%cd' --date='format:%Y' $version)
+month=$(git log -1 --format='%cd' --date='format:%m' $version)
+
+# Ubuntu LTS are published every (even) two years in April.
+ubuntu=
+if [ $((year % 2)) -eq 1 ]; then
+    # pick latest LTS from previous year
+    ubuntu=$((year - 1))
+elif [ $month -gt 6 ]; then
+    # LTS published this year should work
+    ubuntu=$year
+else
+    # pick latest LTS from two years ago
+    ubuntu=$((year - 2))
+fi
+if [ $ubuntu -lt 2012 ]; then
+    # oldest ubuntu release available with containers is 12.04
+    ubuntu=2012
+fi
+ubuntu=$((ubuntu - 2000))
+ubuntu_version=$ubuntu.04
+
+dockerfile=$script_dir/../tests/docker/dockerfiles/release.docker
+docker=$script_dir/../tests/docker/docker.py
+
+set -x
+$docker build \
+    -f $dockerfile \
+    --build-arg QEMU_VERSION=$version \
+    --build-arg UBUNTU_VERSION=$ubuntu_version \
+    -t qemu/$version
-- 
2.43.0


