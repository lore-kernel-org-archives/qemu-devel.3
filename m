Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD708CA9ECE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 23:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFgJS-0001EV-Ej; Sat, 10 Oct 2026 19:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFgJK-0001Da-8y
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 19:17:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFgJI-0003qo-6F
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 19:17:01 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69AMEFTe763973
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 23:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=E6LNlyppH92
 5J5W84+bwby3Bn6N27zg0oeJiiMV9S10=; b=GmDNB7CjTqA5zJc4hZ5YSLKV65j
 Hgyoz3764P7nTnour00meqbCj2nmyGGKIHo9YgquuCiqoDR3OsFljphNutAcVZNX
 U/IoEHdCJ4sqJztMuDQgzpaW7KkFo3FBiZJH1DdsCPHcg0GinZVLLMU8+Ak3K7j+
 ZHKl8gYc+1Hg62YWm0Bv7tsnUfebxZEmLSS/xdikDXhnZAy9hoVmv0NWupg/pgut
 E81Y3+hWV37CNCeeQySSJSFxr0WHL2X7OWKI2TVqQSeep7Fs2StR9r1e+LigF5HQ
 1TnzyPnyzOvNmjn5Dq1gCbf/Dd2nfW+di98JmfOplSewZujHcBA4KQIR4yA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dr7hx90-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 23:16:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33713e5e6daso1293981eec.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 16:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791674218; x=1792279018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E6LNlyppH925J5W84+bwby3Bn6N27zg0oeJiiMV9S10=;
 b=NlfeDRZe3sDBq+8pzeqLj1n+vJdLVlBRXFpz9Lrp5xHAS3qwspmKbFuUY+ulXSrYfm
 CwzXCNMMdgRUxdoz2cXbxpM2qcfhnLA0eyj3AdSdOdBU+IPWKcKuQ6xPj6ZLo5EhDeW2
 b8z5dXM5LirB7h9PWm6RMVgMUxnjQujqEs1KBWfN2b7tGHSkuM/Lb4pTTb3wG+NKLCX2
 XqPUJAFbSSpbkXjpt+8vuGX2w1q88U5yWdvL38gzrapU7u57nP5tUlO9UTnBcL0ktjh/
 Ne2mKr78IW/FhQBnvDG5zbD33hiIo0YdE+3mkG3v5vg/Q/1KKsaZgyOytXHrhqwYMQpq
 ClGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791674218; x=1792279018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E6LNlyppH925J5W84+bwby3Bn6N27zg0oeJiiMV9S10=;
 b=dgX4745sChIPuWgDCOtMrnSauI2Hv+dJ7bw0x7FAzx3W3jMyPAI0dUnMAxt7c9vneI
 vQz/DCFtF/HijobXBlo4+RQLlYv9HyKrzGl1qsOFC28Msk3Y8srffIIE05T5E83IqpsW
 ZqYgwjvI1nQXpl11637FrYXM9aS2B7OlqI3bSPW+4V0mWQiPPFnNCxeZ6gmxF7pve0CG
 +gzWRIH1S8DftFEN8WuwW16GwOHRI+nUq0O2QP1xJF+YdiMQc8ygcGe5h5hqMdkoaWVa
 culNseV6t/J0nhH+ZKf3leT77bc3rhu4EAQ1YoTYSKusNAkE8YzsfEmlBF/U7eP8vQb2
 2G9w==
X-Gm-Message-State: AFq9FYKN/0605YfKPwsyIIxujHWDbQ2UO93AWRBmARNUEbdzMtDkquah
 yDO/aeZ4OAaEvSZRmzJfTlOcHqJ6QsYFfQbcPGtlaGsCkyKZUNjp1F6W6+8jWyjISAAg1+/sNLe
 oADPSioYlCee8pRLCU99R2hCRvkWaytSQfG5Rgg2//EsYU6XLiN0CG0esI9C8PEGLCg==
X-Gm-Gg: AYBFou2kWT/xR2PyNAK5jBNsfyyS7TUn6qQ/9pJ3AXwOQK9qYbmxZWT1qKLwZtRVlFd
 UwSGtCrjqIpxtAtOUDrpMgkxeNNy0CqMyHNCdjBg4nDFjW8OFGbqDwsEfPFicIWR/iBvgprk0nr
 bxVKmTsnFWTlE8751UdIEI7NwFKx4Qfeo/VvuDqEZCtvnmZf1anC2OClXRy+KdgiD9aZn0P6RGo
 X5uW2mPZifSmpCp0J9uc8E8OLsl7JBKTS28uYHcFmWj+ODrsr3umIkh2Y22RfbKv6MmB48dacGO
 OckQmQBrc3IlljRKXuCIJNfdjyhGn+Xufbvu8ccl6JH7SdxfQ62H0qqX23YNk5twqUertFqkEF3
 8EEEOP+/QyP5AHIty+1OkWBlct38ejs4EvnK8YmY4OE0muJR+Z50H3ZmYE4ws
X-Received: by 2002:a05:7300:ac81:b0:353:7e33:664c with SMTP id
 5a478bee46e88-3537e3369c5mr11507357eec.37.1791674217858; 
 Sat, 10 Oct 2026 16:16:57 -0700 (PDT)
X-Received: by 2002:a05:7300:ac81:b0:353:7e33:664c with SMTP id
 5a478bee46e88-3537e3369c5mr11507332eec.37.1791674217302; 
 Sat, 10 Oct 2026 16:16:57 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca67b21sm18285396eec.11.2026.10.10.16.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 16:16:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, mjt@tls.msk.ru,
 peterx@redhat.com
Subject: [PATCH 2/3] scripts: add build_release_container.sh
Date: Sat, 10 Oct 2026 23:16:47 +0000
Message-ID: <20261010231648.3105-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010231648.3105-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261010231648.3105-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5-Tx3AUtYASdg3sGedkVzJWh1xlMpVuK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA5MiBTYWx0ZWRfX2X8wbyZd8Z0C
 IvIT4svrQ3qMBsrvhg/9YXtNozsPT7sjOxCWBg57GuwntbZexUz81FyjSGQQ5psHAo+eLGcHakh
 qVh3W9t7+WapTSwS0wJeiy2H0Ht7leg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA5MiBTYWx0ZWRfX3e0OITJXHckt
 s2bIW/lLtUCRMstf8c6cOsaZ1kjcpyOAgSGIjdvXU9DxMMa7/g1ubbX+M1iR70p4QSVafuUFRjG
 wnqnMNOEBT3tqK+ljJ78MPLTrng9gzcdBmCI6wYJ2TOy2P09VMLS5ACY3hQE6ueyBLZSTNboqrs
 SgjvwnYmjwF8brn9cKTk+/SMjuq/xtUX1jzp181kjIHkRV9kN+HbPPK41xa+ZKbxYKSIAkvsmhL
 /PUFlp2a7+vcnxDMN4KmdMqG2SAjzrjvEMRPpnFjdlGTQn7FyGPzmg8w59CcGMJG/taK9SFmPL1
 4Z/fDtjBg+AZ3FPOkUMCjPLhU6jqYQg8LdAZHTzyrxxYtosEPC+MHiS6dV3J+A2dn9btSrBgfRq
 5zY3webq+belJbsMS2PikpdeOToP4UShpOQ9rko4n0exz/CYtLkFhKOdy087gnkL0cGjGqr+gVt
 oEtdbJ8dQjanTjBf9LA==
X-Proofpoint-GUID: 5-Tx3AUtYASdg3sGedkVzJWh1xlMpVuK
X-Authority-Analysis: v=2.4 cv=asknmiZV c=1 sm=1 tr=0 ts=6acac76b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=O1M4xD0Y80AByxq8toYA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100092
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


