Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6A0CA9EBD
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFwP8-0001aM-Cd; Sun, 11 Oct 2026 12:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFwP5-0001Z6-3h
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 12:28:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFwP3-00078H-0s
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 12:28:02 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85JFV3491385
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 16:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=E6LNlyppH92
 5J5W84+bwby3Bn6N27zg0oeJiiMV9S10=; b=A2ZDbkXfRqkiUIweP5fwONvz4An
 pRqQEPmxfIPD7jPTqiXs1fuxYkaADhk+5pDyfkj0036vPAc2tZtY+WqHR0pp4g3p
 hZxuukckbxcB+42qwiIAOW3IgsoEd+u8tA/hHClilKMbu3BcbjIbUpIyTTjTOv5x
 iRngvCIAN2JIRvdMy5G3j3Nog2Iv22nlkjvZi1upG62vjeQ4CXqHaHR2GaAyZly3
 sDZ0FU7wbw65X/KTfmsHERWkCREdmwXwgHej9Q+JrhW56YvkmjghhhY8GeuubMSp
 4R59499LVLB1nzfY3P9yc/GWdiSbGJm3naUUjYDlkiTUfxbdRvL4aDUd8Ug==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cxxkga4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 16:27:59 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-152d1363a29so5722107c88.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791736079; x=1792340879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E6LNlyppH925J5W84+bwby3Bn6N27zg0oeJiiMV9S10=;
 b=BRN+vXQbs7RCHHkq8VwaZgqJsuXB6ozesVnIfWZ++yBe+G392/dlMmug9d7fXjDtAG
 dv0mj2rQLGNZjEnMXfu50lCFggjGrGcpWQaRfsnwXOmbrjidjdCH2gKaal3AA98nRrOQ
 /KHvAaj6YZtwHIiqrIaYPUv9Dpmzl2MoOK1F8HWee3BF9NlNPHd4KuesFjFUlS9jbaBI
 ObmaS22DRFpvG/VxcetHkQPZdMItk1GaBnyxjAGcYyhLRbgZV733jcFs6ITypouhTW5y
 3i4Oa6sgkqHmpl5AbWATwHrt+PRucqlFdKiXV2vcehGA1dhdoWi56PhTEsX3ZnaIhyLj
 XX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791736079; x=1792340879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E6LNlyppH925J5W84+bwby3Bn6N27zg0oeJiiMV9S10=;
 b=r6WWSMJwqw9Xawp2LL+ljF24ALLNtEj5JhlSqQIYOXS+cfPI4eh+ocjOk6O9u0wEVJ
 8acgBNeWO2dZ4qTvBTnP1ndHrlATeHttLsUUeUjR+caGHO+5nvmKXFaHkBdxD2A/7w8Y
 IsIeX/JqfEvYMloSO4EbB1+uxGvP25/s+RU0hd1dyqqsd374imcNlFW8OM41CCkzcyuM
 rsvHyDxfwr6id40g7oxEn0eeqPBBGuG6cLqQKZ5pqVjp338LJ1bv/tzu2D6uQWOMx0gN
 GLmYZP0sQVMfXvjlzE07pa5ZkyLJjj+TCZDmcmtBytbhMPnM6EuIMhWnk9V7/DrkSbsj
 jCXQ==
X-Gm-Message-State: AFq9FYJEjTSXL1Zw6NlId3fBMjfYidepcDOEufrFtlyGjWrrlm2T0re3
 wAanRiAFZLcsBcaRZksIJ3jxE1JyPqAcOog9qSkviGfZ3QI+N7keKoYwcD3nFChHrk+6Hesy4nV
 FL/fP31ZT3GGnejit69X9K+k7k8vqhZWeZFLdQ87Wkeq3k8mkuMpBOBStcg+Q2AbYgA==
X-Gm-Gg: AYBFou3z8bKstSGs3FkY7KqIfkKaeMShAwnxKiD1ZPspzwFo7WbLFjKGjpM7yhCMh68
 BdwOkXOGZZfsiWQXqA7zv35/cUKb6nH3LQ/Eure0kTzGFJ6/9vhzbpzkI0KpI11AWEYBQ+rfXcj
 4eHYcJSLRlehRp7L1dwyewi7FkX7HmDUzuIEFx79dmruzedRa98n16HYA9SMoHZm+1aiBGbVaje
 RGxlB/5iGPLyXDK2GC4OWilWQALe70f5I1vv+8wYMzkAZ47shmJ64KITyx1Agcep8saX/EqPtHK
 mNS9NLU9whvAldgWAWdq0jCh4RIZj1G96BO+jAPJgKxTQgxtJ4K4lcloaviDKarZOAJPqYl7f+X
 FfX4z1+8Khgn5tJlqeYg5Gc8aN8WnDtdEvNxVfk+yTiwhFo1o2kLcly/68XL9
X-Received: by 2002:a05:7022:ea8b:b0:16b:fdbf:4a9c with SMTP id
 a92af1059eb24-16bfdbf4fe6mr7220863c88.23.1791736078822; 
 Sun, 11 Oct 2026 09:27:58 -0700 (PDT)
X-Received: by 2002:a05:7022:ea8b:b0:16b:fdbf:4a9c with SMTP id
 a92af1059eb24-16bfdbf4fe6mr7220834c88.23.1791736078281; 
 Sun, 11 Oct 2026 09:27:58 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becf08sm25001242c88.5.2026.10.11.09.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 09:27:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peterx@redhat.com, mjt@tls.msk.ru
Subject: [PATCH v2 2/3] scripts: add build_release_container.sh
Date: Sun, 11 Oct 2026 16:27:36 +0000
Message-ID: <20261011162737.3024-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P4u8Z3cdKKPa919WcyUNYxiLUv42bJ4W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA2NSBTYWx0ZWRfX+ok2ZGPLWhCU
 Nr29VdOzU+7ru81JV4Kdlc3cw9P9ShVoZiLDUqUwFTKnBY+AfqS1A7wEcQYHO+H+4uX/KoH5WSO
 6yyNGh4Gq11Eqn0OS+roqV5HWCu0kAY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA2NSBTYWx0ZWRfX/HdHfYl8Ovlp
 cN+uqs893y9rwpPs4Vf4h+w+VltfrDkLIzkW1gHirMeZQqT/mbhYQzkoDBbj5dclr9gLBNO9FOz
 qnE1CdT1ii5hw5MYzRJVLA3Yw6cJBo2kVU7G3R4lOEPEEjCuQbH2O2qWrBNDdU0FiHJh5GNIB1p
 TagutFNARmOsu2kKzfphPSs0+sQWlkdPZOLXzZl/nvnmsNJi9s1D+q/DCABrBaBbo31ao/uWq+6
 2X5TzxCD12DqgoWsLlMYqtrv0zqdAxJQn8A4IPEST0nQ/M/e3/jPzXOdG4XFqytuAQvVtF1wZ93
 glcS20IyzZrNULenMRVnBhjw1EpOeJi1O73jMjXI45MRvVauXiFfgPNq611TMYqGUZCxPjWaLUB
 FdmjJVMmv/J7dHQ/D+QVXMPF5bEaU/F2QsJfNp2T0gk6SITow3T/TMJ0jOD4EnutrEbpf7yryy/
 rcvrmB2BNtcJ6SrlSHQ==
X-Authority-Analysis: v=2.4 cv=AsJ7T+9P c=1 sm=1 tr=0 ts=6acbb90f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=O1M4xD0Y80AByxq8toYA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: P4u8Z3cdKKPa919WcyUNYxiLUv42bJ4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110065
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

$ ./scripts/build_release_container.sh v1.6.1
$ podman run -it --rm qemu/v1.6.1 qemu-system-arm --version
QEMU emulator version 1.6.1, Copyright (c) 2003-2008 Fabrice Bellard

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/build_release_container.sh | 59 ++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100755 scripts/build_release_container.sh

diff --git a/scripts/build_release_container.sh b/scripts/build_release_container.sh
new file mode 100755
index 00000000000..0189d5ab9ac
--- /dev/null
+++ b/scripts/build_release_container.sh
@@ -0,0 +1,59 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+script_dir=$(dirname $(readlink -f $0))
+
+# We use ubuntu containers, as repo urls are correctly updated for old
+# distros. Oldest available is 14.04 (in 2026-10). The oldest buildable release is
+# v1.6.0. We want to skip 1.5.3, so let's start from 1.6.1.
+oldest_release=v1.6.1
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
+if [ $ubuntu -lt 2014 ]; then
+    # oldest ubuntu release available with containers is 14.04
+    ubuntu=2014
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


