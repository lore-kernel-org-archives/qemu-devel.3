Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1AB606A32E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E6G8eztw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B2zF7jZq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLRvT-0003UF-Np; Mon, 26 Oct 2026 17:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRvQ-0003TH-1X
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:08:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRvO-0005PR-8K
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:08:11 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QIpGiT4081391
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=w/E95QJX6jM
 V5a0xDDXY0X3ohkAb3KmnILiG6H/GNlk=; b=E6G8eztwou56KxdlwCaJlBs2pNL
 gET87sskB3iSgK5cSX/YBKMfVtZthzMdtvcG5T5OIfP/oWaE0XUvyD4fsdv0UygH
 LSBvCpGct2LZF9LwP6jgoZG4C+kF4MJ8CrDHurYpVnwLHJqXn7eCgxt8ODr4uPof
 Ddln37wEhhkPmvJ63HgQIC3PYzXxGPdFi9dFV0bijxTgQn+VflWYaVffhQn1RmZj
 GcUqrGfpY/SZl4o5udfmlThhFrK2ELr5Eie4+guT7VYy7kYBqX0D6gySNBhetCqc
 WdETuagCXp4/o4w8iAR9q0YcyWZaLTfHR+Ddawh0G0wB7/tV7yu9nScCOYg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y2c32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:08:08 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8a086f5d91aso5022210b3a.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793048888; x=1793653688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w/E95QJX6jMV5a0xDDXY0X3ohkAb3KmnILiG6H/GNlk=;
 b=B2zF7jZqGqXHfmr2GG1LupCWNlosSc+5lS7mu/2DodJcKtoYTkMiagbhWMEi+NKGLP
 LvPqyR3C9183fXO/TOCfL5Md/U6YXsTs6s/1Iq+isNgXITTqjH6SzQwHLJgR0ZP7x8IW
 RD9W+o7JnT/npHhjHwIR3dmULFKsJitn375kJpyz6PeEeMF78PJt8Rf3+RD8D3BKVCt4
 wSkTvVPU5lxo2YcyL67oWNXOka0waghSON4gTKBVVv+Ah/AQFsKKtWxyn2Dw0QgXuCx2
 Oi4HHx08WB8bpX4+pE7bco8qcu+x3afjxH8tsTziLAB3YAWzqsNh1ALAFYzSPvH+wvvE
 FMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793048888; x=1793653688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w/E95QJX6jMV5a0xDDXY0X3ohkAb3KmnILiG6H/GNlk=;
 b=SEkQU6CUAOAf0B+xKB24irfPEADGChBPczJprZC5MIZiN3TayAGzFeYo6x+mKJ5bRA
 ICAkz7Qu8A+knUprIcCUg/kRdBCTcwXIB6hvFooC+w8QHs6hk98w7owVdTRqTe8oAS/W
 PKd5yrWEjjsoj6dwmTxxAb5cYoATFI6zRpGzpCqL4GAdBIBcW4gF54wKnPUQ0yOXqFsI
 X/Oj4tOGMbImNHXPCMLwY5/bz7FHMxXaDF0hD0yQLTxgMbGuy/vzTCVyja1LtEtKlvHY
 AQuDLHB7En9uE27pSKNS9J06Z9e8A5sUo4WOfahsd/VbmypBWWWWGXPTwXAI2DpAhf94
 Gprw==
X-Gm-Message-State: AFq9FYJcUwofilEKyfp8FIpmZiqCmUptLguzykarlrquUhHaobhtTmSB
 w+eAdABSFB+nBvt9KVn/PXAprOeRh3iHGTR7+J51HjGIZpRPujSNCJBBpQyFosZnTi3uuXqRCJ8
 xjS1gsLqF2crgzMay0sUJHs1spxVjWDZXggSBoJzy2GJ8k3ZP3/201sf9n+kj67jRMg==
X-Gm-Gg: AYBFou1toKk1SLNQK0kmOnh/2Ekw7JhIQKZAitPy2Ei/KORV8kZGPPYU8/i2S23rBKr
 hSh5Mj35N41jWBCclSm81fvElGZkSdgOR2wdhdSYBhPgZlLo3RxE39F57tYXgwqKGxXkalq/KIX
 LadPmE5FP67RCfhuMg3rmbEFpDc1f3+VdH6YDm9/6sGMj3+T7i6aoMMJKFQQxF9BM5fSBNJhPUz
 PJWn9ZIq77kDMMzwCj1PcDMz5zewpaYd6i/SLBxWH1wa2I+4bltOWx6LkNeAzFXmHc899eL033I
 tZRGZwfnRt10lf/QGJYQFM835iogsTBagu3PyiOaJMO1cc4GeWmbhjK/otvThR3dhZMilYlOQOq
 1eOtAioZTtRNQFPFoZVjnQp6AMTjKkieG2jMxXbzBmzPEiz9K5GQJz5yqcORtfQc=
X-Received: by 2002:a05:6a00:9093:b0:878:3783:8a88 with SMTP id
 d2e1a72fcca58-8a3689a9e0amr6544289b3a.52.1793048887585; 
 Mon, 26 Oct 2026 14:08:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:9093:b0:878:3783:8a88 with SMTP id
 d2e1a72fcca58-8a3689a9e0amr6544263b3a.52.1793048886977; 
 Mon, 26 Oct 2026 14:08:06 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a36bb2a2cesm1650508b3a.36.2026.10.26.14.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:08:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mjt@tls.msk.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 2/2] scripts: add build_release_container.sh
Date: Mon, 26 Oct 2026 21:08:01 +0000
Message-ID: <20261026210801.179790-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026210801.179790-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261026210801.179790-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfXxcu1WaGG278a
 vExeLUu2yZmpAaDLxk6JEc3PzWFqXOQKP6C6lgE/8GWz1x2cakkXdRtyRa0BZtVP30Gpf+6UTtm
 WP01JxCAzYPviaTju1q0fIoTVU23bts=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6adfc138 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=Ab9DfM9NdPcTtTRkZkQA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfX3Y4FxIAue8u9
 1SL2IXY5AkK+0j8UZNLbP1gKfp7svTKiSJCRwwLZs9RLXLRKeMAMl7vX+PdmbNroYrAuh10sXEd
 jql3Ljbe0nekTcsU+tZHOr0A3qJsMmGicb6RM8xIoFVtXsEYekjth6AV1pGaoPEwhHHvkfrsWhR
 o4NuhfgVx6SAt160xhJTjfyj0YbZ0KYlhs2D79mog+eaxdJYbhTHt70Nhpd+OFMG2a8ilti9Kh2
 aZ84GAMBUpbvMnIzqHy2Kvgq8nQhqWYN0V+/s+3Kqy2/gXKjNxZ0sannL/DnJzzCzMD6K6D5+He
 Di+Z2EXqFIrXK8Ot3LVYPMDkEeomVilBpxxbfxulIx4C4qjIoB8PdmIGh1RaLn+AWuXQyF98Zrf
 8xL4EGXWUKYKUfzODW834k8u1aDsLoLDq7IMlHH2KjEPptw0H10zUmdZGOsJEoXgO2D4ghI78+K
 Svc4oEjGsDlTDtOP+Bw==
X-Proofpoint-GUID: Q_nlMFVfvNpFpLT50sU_n6wg3hNfOLYa
X-Proofpoint-ORIG-GUID: Q_nlMFVfvNpFpLT50sU_n6wg3hNfOLYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260084
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This script allows to easily build a qemu release container, based on
dockerfile introduced in previous commit.

It names image "qemu/$version" and automatically detects which ubuntu
version should be used to build it.

$ ./scripts/build_release_container.sh v3.1.0
$ podman run -it --rm qemu/v3.1.0 qemu-system-arm --version
QEMU emulator version 3.1.0 (-dirty)
Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/build_release_container.sh | 63 ++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 scripts/build_release_container.sh

diff --git a/scripts/build_release_container.sh b/scripts/build_release_container.sh
new file mode 100755
index 00000000000..ae57aa21db3
--- /dev/null
+++ b/scripts/build_release_container.sh
@@ -0,0 +1,63 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+script_dir=$(dirname $(readlink -f $0))
+
+# The oldest buildable release we support is v3.1.0, as previous ones require
+# additional tweaks in Dockerfile.
+# For building previous releases (down to v0.12.0),
+# see: 20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com
+oldest_release=v3.1.0
+
+if [ $# -lt 1 ] || [ $# -gt 2 ]; then
+    echo "usage: version [git_repo]"
+    echo
+    echo "- version: tag or sha-1 (>= v3.1.0)"
+    echo "- git_repo: (optional) QEMU repository URL"
+    exit 1
+fi
+version=$1;shift
+
+git_repo="https://gitlab.com/qemu-project/qemu.git"
+if [ $# -eq 1 ]; then
+    git_repo=$1;shift
+fi
+
+year=$(date +%Y)
+month=$(date +%m)
+if git rev-parse $version >& /dev/null; then
+    year=$(git log -1 --format='%cd' --date='format:%Y' $version)
+    month=$(git log -1 --format='%cd' --date='format:%m' $version)
+fi
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
+if [ $ubuntu -lt 2014 ]; then
+    # oldest ubuntu release available with containers is 14.04
+    ubuntu=2014
+fi
+ubuntu=$((ubuntu - 2000))
+ubuntu_version=$ubuntu.04
+
+dockerfile=$script_dir/../tests/docker/dockerfiles/release.docker
+docker=$($script_dir/../tests/docker/docker.py probe)
+
+set -x
+$docker build \
+    -f $dockerfile \
+    --build-arg QEMU_VERSION=$version \
+    --build-arg UBUNTU_VERSION=$ubuntu_version \
+    --build-arg QEMU_REPO="$git_repo" \
+    -t qemu/$version
-- 
2.43.0


