Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB38606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l3ecjgzJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YjZKa9lA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMWBE-0003kq-En; Thu, 29 Oct 2026 15:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMWBC-0003kQ-LS
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:52:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMWBA-0000xN-Pt
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:52:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJk3Zj532607
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JDZ2MoleeX553s8/IIwaZjXemU8akwhasbvj0bLPzWk=; b=l3ecjgzJLmdhhPpg
 +GkRIaGhHlEastrA8su/RM3PaeqA3f18UZ+oIn4LNbYZ/Cd4IwzZoGo7YXCmwYgp
 y/gMu5wTSSoM6RyUF73URFHPORT2gFY08mMySUVRsQONyjRhJe6ynC0UorPnt/m6
 qqHQdOGc7zlOYfb+JpfyrgcVnfg45Z6OhGGBIxB2/+nu68KJT30Bqz+DN0v5Oz4Y
 o4ePDMolf+wuWY6pH0mRIcBDeHIHLaxCX5rtXzzKrl2A7JQXsweKTL00TC9XWgoU
 WcRI8u3cxE0MTYcIQYQ/rKd7qYVjbXKtDMckAANWr6JPnGL2jgLlAscCaiAsp113
 KKrV5g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmac0rs2y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:52:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ae72da2f57so1500076a91.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793303570; x=1793908370; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JDZ2MoleeX553s8/IIwaZjXemU8akwhasbvj0bLPzWk=;
 b=YjZKa9lAH1VSkN7aSmQwU11R0mwS56l18Z/2tXHt6nt+G/P7DROGIHbrLJp3rDudhH
 610uuoaD0Sh4W2Ym/HA0BiQy4iZ968CYhtvdNgXLggkz0dF+sJlt+H76GSJzQmn475IK
 ZyACTORM2ImUgaSJF/ztyP4d2EpOVisgo4MGDZJhdCmD6diCezGf6oJsqsrC2kcl8gMf
 qA+BLE//u+Z1G3SZWdOdVPeU0uayNx1xwfG1c9ebI2hnmJkaqU01msJIotJQOsUHPYdn
 BMWL5UBS1ZU3i5ck745RriLNR5US62v3Dn6Dbw/6PSr7P3hVTKDhxaMQ1Y/PO9VyKDvY
 XhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793303570; x=1793908370;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JDZ2MoleeX553s8/IIwaZjXemU8akwhasbvj0bLPzWk=;
 b=KcRaBe7fSch0/l+2Qy+5gmMUJC8CtKEf3fR4Vm4xl9B3TEIdPtxxsjjj1HPyX15LPQ
 8pmEnj7UkefECHxEpzwskQ0CvdykXZTTuVUzMWs9DygqXrFZAiIBllIAvnTIBk6ozME5
 jSzb0nY5CsdNtdkAHIZ6r0P0Tw7lZGtzMXEVyHjynQ3rypYSB7d6HdWc1lvfXEUvvWIQ
 2xdsYjZMeOawgp7jSBtWinulg0sVVDW54h+1A1rtLmEV9uDR0WDUdKuAYXhCEp2AALbE
 cli9LDG8F+ne6LPrK5qeKe0n6fT4qJ7O/4e0toEPRG88b0ofYwBEj5MDKRFM9oMBMkmF
 R0Aw==
X-Gm-Message-State: AFq9FYKZJUidsv1wJjueJ6F1nFN7fhH6GqecyuAZiBme6nUqkYuxAcpO
 +ArdBAlbRtlIQ+yQtX0fZKsmuWg5KNpPnBla9/gj7oHDktx6x3+Pg9JwGnhxcoySTXBZKkh0TUw
 8zVPHEpJht8F7zVoV9wK6nWiGvdxJGNBZLTZ+QfC5bSY/mNz+BkPSnkw9D6WCcBIugg==
X-Gm-Gg: AYBFou1Y5HmGlOlkOrIZdjHYWIqxRGcDKzXQOzvTC6p21wWvIjzjGQIcs4nZBrs2WG+
 /YzhywJtEzCLTzPgWrhpwzYZFuX+dnJnlof+4FZZtLrwvvGqiNOg3/t75qsDZxDd/SBOw7qcW8m
 D5XijnL0jyfKZvP9ghdV8C8USRVazxf5eImtrIRPTuc+KEJZBYM6GH49PJDMiqCG0clBmYrvGc4
 ltju86fynLT8sEXphKa2/qBJhfJpBdXCHT7Rh225R/FyLpNFcMh3IGyyQC1pfPR4Dpr68rhR8QF
 pIoXit2NQMb9FsFRUNAhqC3YBk28ROL/6p6sdb16gp3MsrfZ/zQDd19mGoxxsIxmNtYBnPX6+Vj
 cKa9ckP6gn2DOl9arpQevlva64Dzd9aZOIk+t9DWdBII+qG3R3Xz3iCLLCcnTfvUUoVr9uyto1A
 RpkzvK7RP8U5LKH4VlwrUtCmsnVAlgaALE1u+x
X-Received: by 2002:a17:90b:3c90:b0:3a8:bbc2:5551 with SMTP id
 98e67ed59e1d1-3ae8918adcbmr63761a91.0.1793303570301; 
 Thu, 29 Oct 2026 12:52:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3c90:b0:3a8:bbc2:5551 with SMTP id
 98e67ed59e1d1-3ae8918adcbmr63734a91.0.1793303569722; 
 Thu, 29 Oct 2026 12:52:49 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e9b1506sm5275862a91.15.2026.10.29.12.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:52:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/2] scripts: add build_release_container.sh
Date: Thu, 29 Oct 2026 19:52:21 +0000
Message-ID: <20261029195221.6125-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029195221.6125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261029195221.6125-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: O9tBRZV2fhqKoxPBuuxxBD9MWZDSVLCv
X-Proofpoint-GUID: O9tBRZV2fhqKoxPBuuxxBD9MWZDSVLCv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OCBTYWx0ZWRfX6k+iovftbz5E
 XG9VXdJ1EKGmsHll3Qmzr2wuHt0+pgJxgzjsoZtlZnWnRQ3I7cYdw8jKosCR+eQi9b/Y08lfnqF
 ahOA3/YjZhzyPs4A6nd7fIGQJtVlc8k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OCBTYWx0ZWRfXxZWBg17ce6uP
 udboAHzLqPIZ1+7vvPTzwWVoSolzM3w50PsSKBPnlHmsItK6guOcTuY2dXnnGuRt2gTAi36+BDb
 hhrvFSDZmCIzkqTGDIt8rk5T3fwDKbwyL034LVbSaUqrv5VYqvZydUy2i/uuRLxEpy9Rvyaob8H
 pUS+x0auIVvZ5SVkd0k7vGSfU3OyNjUAxVFZylsEtquEDKYwt75Nce1q4QcnIP9ezyEUS/aGToI
 N6uXVpWStcl5B/ip0NJ7KDFW60wfJoP1g8fgJoh1PZ3trq2CiM+5oxOYyvynOHLSczeWEKNIt8c
 zbDnm5f0etOMA519uWgFFyQSpWnq4qRDK9XP2n82KoXOEP0ofPXHmQ+Wg10/EUEsw/eQW+/J59k
 J57sEM/urSPP0xWmg8xmG8RPQaJImVWSeEytPu3tiFo6Pm6K6RTU1Rlljl/zbfyKr+NLjRitIys
 N+2b9F13D4bi/Ubf+Sw==
X-Authority-Analysis: v=2.4 cv=I6/w19gg c=1 sm=1 tr=0 ts=6ae3a412 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p0WdMEafAAAA:8 a=Ab9DfM9NdPcTtTRkZkQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290078
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/20261029000853.15166-3-pierrick.bouvier@oss.qualcomm.com
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


