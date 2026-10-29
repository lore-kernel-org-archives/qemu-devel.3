Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05974606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RF6fppYM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cDWBzVkC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMDhb-0001kt-Ri; Wed, 28 Oct 2026 20:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMDhZ-0001kR-Sj
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:09:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMDhW-0000EU-Mx
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:09:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SM9u3I1512875
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lQcOz/ELA/sLti/t7VIWZNE7juScjTeknU2VKG6UgK4=; b=RF6fppYMEWLMeePC
 A4KbBKrkklOQZF0GJlILSO9kF3Ty1WESS0vKG9ZuTVMvrEj/rif1sceFekTrnSF7
 m5H4cXAZj2ly8H4bQcy2l+Aj1cn7hMsjGwEQPiSRx77R44aRqf+ZPerVnjMVJ4o+
 TyEbshkkyD06tozT4Dbdv5wzXgTxwPM8jOXKLK8f+2PBuiouAtlHq6Xs+v7/1QzK
 pRwR1xNJKfuCNIEWxlq9Wo3wetIFfpbjm4L4gGZAoMT1bFxqNvDVJKxV2uKoCgeX
 7Fl0AnElkfZA9uKAHUtOGCOfgz3yC5A9CtDJj+LazKFNBp6BnbasJQ/CalCvBt1n
 4xA/fg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb29f85-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:09:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc4ac5feaa4so978489a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 17:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793232540; x=1793837340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lQcOz/ELA/sLti/t7VIWZNE7juScjTeknU2VKG6UgK4=;
 b=cDWBzVkCd3EcZk8YMpBNRwKRokrfhNziIWBodKFrLrUgrBsRrlGPOYhH3TEUTQrPqI
 NWRyRBQuDlAFn8Ivo9dng9sv4vvJ31MFPovjiT9vQWfu3iYhzjpQ6ZJnbIN0U6cH2LLr
 4KHgkNcxJvMAu3LT/fAs8S/mUtezEmtvME+zVV4VnRFjCPsXH7h7O2FCOyFAtXWMPzfO
 qFNs+X6H3LIncyHZUIXMrC97p4CQt4L7zdUpMUaPzRG476DZ+ywW2kKR8vTduPt7I8F2
 LPJFbOvm77SmsDaYRhOHIJMNnVbIusDoaoUWZzUM5Ll5964kE/6Ixph/AerNfQBX7b0a
 iuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793232540; x=1793837340;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lQcOz/ELA/sLti/t7VIWZNE7juScjTeknU2VKG6UgK4=;
 b=aFVJZmRrFI66j5nFkaIxKSyrSC6Sw1qCTE55kHM6rWcV3xBDVU2OfY8cEIDaPh2nGs
 CPdgQOAmKr6JJIC00IGegiyp+0dopSoAhetCHU0ay5rOUfYud2oxGOkJ13Z4wWNWSQyg
 tp3hNuE/9elxn3FouSN6+Ww6xvv/MJmQwr2y+xd7cKFQzENfU0el7Rqabl0jfhnvtHfo
 mnkMkbOlznfSVOWE2Ea5xi64AdIlXcLIdEdXLz3+ye+nT3klKGc+153GaTh/s3z8xCpc
 28Lv7nZNgvG8yB4p94pzLkb8Z6klYmNXmvchzg6AvjpskGowF1OW7vDwqCa0iRQa1ICK
 59vQ==
X-Gm-Message-State: AFq9FYJle6aQnghIIyexNrFhxfQXONFWV8JbOhlwQfqOcBiSms+bWmib
 xzNi5sbsy3hWg2ue0KuIJ0mCeyXRY3/sF+IQhm1dtItR5EjOj5N5n9tOUTmir9fc4jR9MWA+8RZ
 /gmXRCTD6uh5+huGu+YvLKdIGuZ2Z2aVHIJi1ggNqrVAxSTJdLbrSTRTT/rLoFOHxRA==
X-Gm-Gg: AYBFou30KA0X5NWUzNcOkhqiiPgjDAKND9mKoLjodA1cow2cv9HkEz370cSqJzqdOxN
 CnS5RcIrXcBaoZVKnCz9nymvQnbqDzojPimfBwgpam4sC+kBldqJIQ8NSz0blFpEso3wppyB1H0
 MGIswaO7j4jNFsZU+gQNXc9BRmv5/iLjJoXDQILHS5AtqFTWFQJw2r0NA7TyaepRKyo7rWHWGEK
 2pP7hgQrt1IiyjMyk4S6oXPzbusCv2UqUfDRKcGAuPi7g4iA6f8S6ov5Yjwc49LAryaBJ98MWMX
 uU7G+jNbVFgUyW2I0mQErvN4cZZYDJHLxjSxgcetjGb8MhIIDFH/jh2lsZoUVSFKDOgpgJ3ii8u
 km08cQf0WHLnsTQ6Fpxeb/xCCP27nRsd2+hZo7XlnFV3a+ejcfxpFYZmooEjHLMjv1/VcI+lnl2
 rl8LIcPcewMzTbdbyQsMsKdcrkGZUOhD+mZaEX
X-Received: by 2002:a05:6a20:2445:b0:3de:7bd5:fb47 with SMTP id
 adf61e73a8af0-3e9023a4ad3mr3261607637.39.1793232540321; 
 Wed, 28 Oct 2026 17:09:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:2445:b0:3de:7bd5:fb47 with SMTP id
 adf61e73a8af0-3e9023a4ad3mr3261587637.39.1793232539897; 
 Wed, 28 Oct 2026 17:08:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ccc682d8sm4644744a12.18.2026.10.28.17.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 17:08:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, mjt@tls.msk.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 2/2] scripts: add build_release_container.sh
Date: Thu, 29 Oct 2026 00:08:53 +0000
Message-ID: <20261029000853.15166-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae28e9d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=Ab9DfM9NdPcTtTRkZkQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: AeFwP0wEB2e_sR-Q5hKE5NMhiv7w29Zu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAwMCBTYWx0ZWRfX5W2ewomRVxTd
 sb42Do1m330pXzULOZhFkrmyhPhr2duOCgXGZCfK1U+sShkidf5vtLwsNEvu+VQyOJhimZiAVY/
 lXrb5EDISIS/by4Fzu/+EsmLzG1M8pk=
X-Proofpoint-GUID: AeFwP0wEB2e_sR-Q5hKE5NMhiv7w29Zu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAwMCBTYWx0ZWRfX5vBpXxjSBGB3
 lwTd7X1Nd28s4MQ0NqewzV3EcCHs9peoHHUHHcPnHXTtPVaJWpaigpxA9+U8n9EuJOEjGCKfkAM
 9RKcf7TunIhK3spjFOs0t+yOh7RuuxRvnsbUH4Y4qDMF+YzuXXRAu31GbsGGkOxmO+SLSXjIfxU
 StAsUWiGQ41skDhicgpREho6BCpHzGYTGc9Nftcw2whYmGnpsNqoxGBFx1Dnbeotd3p9huQ6c01
 lzGcPXKGEd/9T5cbUJRsgJx7sbc4BKEWtTc0Am7o3MRhmqfZJxamkSSh5Go6v2uUa28/qLsr0HP
 cYhKnJHFiSCb2Q3DoazlBnzOMU83dFx6P3BztaTE8DQNs7RSiUeCIuoh4HoKCNnZStz1vTYtr+j
 ZpEFff7sEaedD3dzn1IVlhg9YQ9VPlZ6QK+Bh6TeCqUQMm7pDsXijQV5jxWvEjwt5lCsdK7SfTv
 QhNlJhlloLr98jCKoiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290000
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/build_release_container.sh | 63 ++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 scripts/build_release_container.sh

diff --git a/scripts/build_release_container.sh b/scripts/build_release_container.sh
new file mode 100755
index 00000000000..7dd477deea8
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
+$docker build . \
+    -f $dockerfile \
+    --build-arg QEMU_VERSION=$version \
+    --build-arg UBUNTU_VERSION=$ubuntu_version \
+    --build-arg QEMU_REPO="$git_repo" \
+    -t qemu/$version
-- 
2.43.0


