Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46896606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aIvCBZtx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iFSUbWiG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLRv1-0003Pw-SB; Mon, 26 Oct 2026 17:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRuw-0003H6-07
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:07:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRus-0005No-OG
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:07:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QIoFPB986039
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=w/E95QJX6jM
 V5a0xDDXY0X3ohkAb3KmnILiG6H/GNlk=; b=aIvCBZtxUc3d6Yu5jVf7GaAdNDy
 flXTXOlX6eYgMBetttcwIl9rA7lDuEnjEEV1UGesS5XT+rAVckZfU8bKM/YK0YAB
 0uhyQAg3YEs0VYXI3S52bFrBlj5kSTicNhJoicT2Uu2o9AxL8U3HpC+cL5EdSt3f
 YTcCsSR5IFX/Z2JDs5HptwxXmTeJyPi3q9l9QlwW36XF9kR2G+wV9GLCe4ZVqlZM
 Vc7GEO6bcOQfsVbWVRrVOuZ2AzFWPJLLPsksvsXptITxKwM3Idg+Tli5ij4mdv3d
 x9ZzNufUi5nKmnR+b9C2kQQIoeW9z4bF/QpkdbSsWQvb8Jvl4rZ933Q01dg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q2d61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:07:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad704d4760so3164430a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793048857; x=1793653657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w/E95QJX6jMV5a0xDDXY0X3ohkAb3KmnILiG6H/GNlk=;
 b=iFSUbWiG7dp+ob9ShzelWonSiyTOkXiAZ8QIs6DKpUeMuCYbi6M6scRvkyRF22AuoG
 Ls8BOJqUVgJwpV0sq9upmLQjKxLa5NiTDEJkIwgqHK+ORpmgEeEr0hh6t2n6yiXw+ATN
 /CNQtdzPg8MrnIRTUCOyqcYSoJ1bF60gDNf1tMnHOOTQsioPBWCcep0t0clzKR6kDa3Q
 4lHc46xaNyvLP+P86CInviGwHzvvJYwAJuLBN2xNKsTCs6JzmVOgTlyGhOnV4NEcCDJI
 MeYCPG4TDPjARJXhQzkbU+2Kh8vwmbaZ0l8YJl/bwMskDeTywMYY7uCVuJ6rkYnuV8hp
 6ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793048857; x=1793653657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w/E95QJX6jMV5a0xDDXY0X3ohkAb3KmnILiG6H/GNlk=;
 b=j6kvw3ME/D0oYuNEB0hGP6ZjPw1O9ML3K+O9zw2q4P/QSK4H5degIUm0AlJPcZnYiy
 e0r7qAhIwbAyPinlWQhtamNo7FFgg3fv5pmUo13nvBkfp96TeCmoijZa4a3ppsP0E6JL
 3cCmheHkZbqWaWxUUb40vvt37FjStAWIN03xoGPRthw+6gT5pKXU06umYspKHa8uUbnE
 A0l73gk5efzSY89UNWtDP5WpptJlmvg/INAfD4j75KLOWugo2JCRUOEfmPWH07UQJ9Uu
 zV1sR1rgYYTbZVbmDT3LLuosBERM7PIjXpFUFNQEuaeFKUCV2B8x4pCZNmzw0zdWCc10
 AIwA==
X-Gm-Message-State: AFq9FYIxM8237ETmX9htYS4Fvwqh68jTflhV8wd4jj84OlbsTgRHTNsE
 6NrtscCWkCbyYH4GB7If7YyZZaaYI9F/Edu28qiUUHZwaKFowhXmyO/scJGrPPtRVDyUriy3wFD
 zEOlKcvzSQRmFYHoGrGXHCoAMvQLQJoZsMjL9oVcF1wi8CTAm2wkCtvFgsfnELQ9OQA==
X-Gm-Gg: AYBFou2295oefCeubkcK5QOuCYpJFRGvSkhUds+Fr1oA8SgMG+ZBNaEpYpOFIwxfc0H
 Vmq9dPhWOpnZJwwqDJerNTX3QTxgbLDo2T1Z+EDzLH36cjKPNKpzME4tm79EdSwvNB5VegkBh9n
 gm+oDnXmucHKYmodizkF5Z/HaWonajGYC/WX7xlT2BNQd0A46A0e4y4mdtmztVR9FqxWpkI/ZIW
 V9bkS+3S4ztrb72QVHSJ5DrAOyV2uqcxu1/ziRAtDLprwZ2XTgpLrlerYI3VFUX0T0+7KqcIrOM
 bEKGRlx+a+r1PEAw+Kc5nxJrmJ31tkfhIhvf57eIza5VAcnoBulF/3AJAPPoHhlmuZAPDPyEgyk
 m8urRoqRTXus2e7CJS3Y/DNmL206Zs9d1qol6unTkX3yMLjGuA/7bN75oECxML6c=
X-Received: by 2002:a17:90b:3b41:b0:3ac:7c52:fb04 with SMTP id
 98e67ed59e1d1-3adeae7b8f9mr6640505a91.44.1793048856487; 
 Mon, 26 Oct 2026 14:07:36 -0700 (PDT)
X-Received: by 2002:a17:90b:3b41:b0:3ac:7c52:fb04 with SMTP id
 98e67ed59e1d1-3adeae7b8f9mr6640487a91.44.1793048855963; 
 Mon, 26 Oct 2026 14:07:35 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb0dda7sm6421185a91.4.2026.10.26.14.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:07:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peterx@redhat.com, mjt@tls.msk.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 2/2] scripts: add build_release_container.sh
Date: Mon, 26 Oct 2026 21:07:19 +0000
Message-ID: <20261026210719.178107-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026210719.178107-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261026210719.178107-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfXwjq6Nfy5rejD
 VFiouw4Vha2fSghmQ4cXktENXvdCdwPceT95iQuzOGXGOkMdKf2k1N+DXYvloqhm6ACLmnVTHZs
 JJ1dXlVUhz9OnOeZsR93utJ/eRn/ciM=
X-Proofpoint-ORIG-GUID: Boxs4Jm_4wtPbijYWNb3xYRd7ptuB1Uc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfXx3CKlLl075lK
 uI/9sNIZkWEgRE8xKux8RtogGhlT0oxNiGu+xJS2j2FAw3Qiq9bCAERY1Y1onTZJ/F6O68O+W15
 M7dKkGf78Ue5RZA6iW/7q4OvHzicCvxioCy2+d4/vANlwRU5S9OAhIWlQ2xtc8CWaaUBHpj4zIa
 dAa53Bm+30686RFcnaT3O2wcqo7SflNtRBXfAvS+liWJmpjNurvwlZYDCU9ykSLRfQ0xJA7nESN
 8uqsm+t81X7R0j6cEFYmuwgIBD9uQkvR87rJow+hP/LZXMd36r0/PUZykcMeFbr5rsm4PiusmL+
 fSUrTRCBEwyaHO2rkBa6levG8QDTJz5QL5m3nOWh8zUHHZ6EPEZJq4E+h6BrE/YdU8JHGKV65O9
 zxFlO0zgkrWJMEH6tFUydrkwZGugLvecvuhchOSECRLN48nV+Qur3uSGkKivBKZVQWLDLmCxmNe
 wY7cgeHR+DgVyD/GWGw==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adfc119 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=Ab9DfM9NdPcTtTRkZkQA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: Boxs4Jm_4wtPbijYWNb3xYRd7ptuB1Uc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260084
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


