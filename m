Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B988FC982FA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 23:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8nEE-0008Ex-Ob; Mon, 21 Sep 2026 19:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nEA-00088R-JV
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nE8-0000Ek-5d
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:14 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LKfhb41751643
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=GMejoTEO+0c+goq+GBscoj
 u338N3mj5RRHpg9ewaZos=; b=B9GHOJZHzYsjv3rocghD2dLm9egOjm/CMOz8O0
 mPx7Jz1BRvKCj9k58b7fjH0UZJGQfq2YD9VYpviOb9QOijliQELJV2K6PW6zBAJ1
 9rD/xz6FAa0jPXrTM0BZwweGB7gF1xos6hjl853ymefQaxi9SRJ7Bbp1Z0JZdmFJ
 biVkqGM8cic/hw7xuL3LsuH9Qc5lPRPd2ZFOaQPP6YXYf2Rg2P1uJXaj0YhcxTsW
 UsOE2lFbAiIBMd5uV52t3AqNraeDHRZ3HbVPSmvEWU9hjQ8MbcKyC9qkFSrGBo2j
 NVRGxRijo1bsD4SuECErtQZ88KAVHP3I4RhbL1rI7tV6wzlQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8xes6rg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:09 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e1118e4abso6167490a91.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 16:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790032509; x=1790637309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GMejoTEO+0c+goq+GBscoju338N3mj5RRHpg9ewaZos=;
 b=NnK9j1PxVXL8Xt/L+kUrQyKAFsRkgOHPJoPhBEyaFFsCYyQcb+5TBosg8seccXnB0d
 fV3EmSV0ZkL7XfuRU6L/MtrnXPJoemtQhLOncHvJdGhCPisI+FVS6qGSUA5kH52+7ZH8
 q7YGNhrM1tJNlYBT7FnKc6nZAg7FXWSY/vuFe3rN23yyZoEGZNZpocM31By6uUeLpqWE
 tgQWyFCR5omg+atKLMcwnhQqb8eCOD6zgR1KVDtLZtsWzb1/LU0AfxPhKMngOR9kLCwK
 pkFaa2Jj2kKQLDaAuQ6n6DMaB4iplYpYbGtbWqKakt/T5vWzOsweY2RfXKAFYcrMDs9A
 argQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790032509; x=1790637309;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GMejoTEO+0c+goq+GBscoju338N3mj5RRHpg9ewaZos=;
 b=YT0dyP+D34lTPXvC526MJyGWpMLDLBaf2v+qSC6HR0oKrvJu+qDVs6KGgpf1JEmXCX
 jjvT/YMCDV7MmxWy6Pu7LVvX2AGqzCB5GWkqVpLWy++6quzHgkJHokJ5ZDGiqXs5ygjk
 VUEiOraCq23dDBwKEq2ISJUbUVWzJdZQeC7aDZw8m+6c0pNK7TY9YS67Rq8JmkkmQPFU
 PXvln2its9xh+oTfo8qADyaNdHvht7zcIK/JokZeAmJSay3n2xCZB345XVouUBedYV3d
 kDxEbV2obCBWlnDN50y5YtSPjz8xPXUyXMtVGviLKPIHOKuqu4lF65Wbvnxat4qhjL5K
 76iw==
X-Gm-Message-State: AFuF++nROk6QFCohTE2w4aeNpGOzALTB81gSvf7O5wFb+F4wnNl3nv1g
 x5BJFud9Tl56rYWZFzWWpYix8whrEkj84R19lfgUJz11LMevxzGs0kuv6qDHWa7DGsfWfUNq7F0
 kfYUXJ2cdInFJwveAl50aXPwKoxler3di7LhZ5S7mSIXlQ+jiHK3cgpKMtfilUIlm9A==
X-Gm-Gg: AYBFou1UayhVvDb2cwgKPHqE9a8VDrN/GbBApEqv4YZxJBPv4jqcfXS9o4rMXkglxAc
 l7fZCQVkS1fUvXEoIRC9lDPuPWGlpZFUYkLNq6YRtgBZeZgF52ex/TX1nWd30yiiYZ+RCJZhxRu
 +A7be8JKHBlf1vKZi4E3ehXFBNYtBKBSj+Gpw4X5XzaffVkGzCVcQj1qn5OjXrpIt4LrSfWYxTH
 NeJKFoATAb358YnZHNLER6N4RSA7MY6keOtZJg/nwH9OvI+AR2V1p3aIpaGSyhZPcqWarj0beGb
 swffsApwAG3nM3xDRHaKTdFQpn5Deztj/npAIhikQBrXgxyWlI8q+IoZXToATRBTqm9my5xbMSA
 s04/KgMP6UtvpTo6XGvPUx7fLIEmAHyuZUbYdE395VTABk9T0oaMvz4yx2gmxpg==
X-Received: by 2002:a17:90b:4ac6:b0:396:65dd:4093 with SMTP id
 98e67ed59e1d1-39e54c01efemr17962445a91.14.1790032508686; 
 Mon, 21 Sep 2026 16:15:08 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac6:b0:396:65dd:4093 with SMTP id
 98e67ed59e1d1-39e54c01efemr17962418a91.14.1790032508067; 
 Mon, 21 Sep 2026 16:15:08 -0700 (PDT)
Received: from localhost.localdomain (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0674c0b4bsm1295939a91.13.2026.09.21.16.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 16:15:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/7] tests/tcg: use x86_64 cross containers on all host
 architectures
Date: Mon, 21 Sep 2026 23:14:51 +0000
Message-ID: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4NxxMwd48l63iM8tXxl-uLWSo7wHV6Mp
X-Authority-Analysis: v=2.4 cv=PZhqFShd c=1 sm=1 tr=0 ts=6ab1ba7d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=h9dPQR45iktX9hhwoA0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 4NxxMwd48l63iM8tXxl-uLWSo7wHV6Mp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfX6BCNemm7w2vh
 Kyu4K8Z9d3Qhe2ejbMPhZTuFnVCFJqDXh7rlAOnr5h+OT/MNL5nlQ/WCBOy5hqlJVGGJJ0pMVD/
 +O2B/Bh2297yXY69qWI66tIB1IfMhdFHelhbJV7OW3O0c9m1bfBqmzwXSqDjDi12B6pQ/onK+tV
 oPUxo7XtY9uVALtwFzESvyI2JAYG0eyBV5Dqb0Ro4iF6OAksb8j0lfdukmduTjbHkKAn8C9wcJ8
 fAVUR41AEmMCFE0+zJpB84jeDpmPJBpohu56Y4v2DPXng8UFxErzt0g2yYa/ksg+o7s6D5djU73
 Tjc4lB0UJd570YIBGRLi3OcC35iTETPlFJbIaxAgzCr13bwtSwensHP1dL7BTB1qNo/L4uC6m7o
 3xt0XVwCLtO8j0zG2/vkFDAfwRffq9z/toiPzKXTu7nC9Z0L3itMLoTYvU3eJdG7/7/xyuLBn5i
 l56YUPzfXW2taF6le7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfX+Wpb360kmuEQ
 VoLk7xm+lTUzpYD841yNOrx9WvTT3k7FP4aRNDGOY4himULosGt1oINxw7Jd5uPv0WGeBw+D4rE
 7YwD8k/GbX2wfszK+RY1jGslgwGyAlU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210340
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

To increase our testing surface on aarch64 and other hosts, and also to ease
maintenance of docker images, this series introduces x86_64 base containers.
We rely on qemu-user-binfmt (available at least on Fedora and Debian/Ubuntu) to
be installed to execute x86_64 binaries on other host arch.
With this, we can run the full tcg tests suite on any host architecture.

This series exposed an issue with on aarch64 hosts with test
loongarch64-softmmu-memory that was reported in issue:
https://gitlab.com/qemu-project/qemu/-/work_items/4567

Pierrick Bouvier (7):
  tests/tcg/meson.build: force use of linux/amd64 platform for
    containers
  tests/docker/dockerfiles: refresh images
  tests/lci/refresh: add parameter to override container registry
  tests/docker/dockerfiles: use docker.io/amd64 for tcg-tests containers
  tests/docker/dockerfiles/debian-all-test: remove arch specific bits
  tests/tcg/meson.build: remove cc_docker_host_arch
  tests/tcg/loongarch64/system: deactivate loongarch64-softmmu-memory
    (hang on aarch64 host)

 .../dockerfiles/debian-all-test-cross.docker  | 37 ++++++------
 .../dockerfiles/debian-amd64-cross.docker     |  2 +-
 .../dockerfiles/debian-hexagon-cross.docker   |  2 +-
 .../dockerfiles/debian-i686-cross.docker      |  2 +-
 .../dockerfiles/debian-loongarch-cross.docker |  2 +-
 .../dockerfiles/debian-tricore-cross.docker   |  2 +-
 .../dockerfiles/debian-xtensa-cross.docker    |  2 +-
 tests/docker/dockerfiles/debian.docker        |  1 -
 tests/docker/dockerfiles/ubuntu2404.docker    |  1 -
 tests/lcitool/refresh                         | 58 +++++++++++--------
 tests/tcg/aarch64/meson.build                 |  2 -
 tests/tcg/aarch64/system/meson.build          |  1 -
 tests/tcg/aarch64_be/meson.build              |  1 -
 tests/tcg/alpha/meson.build                   |  2 -
 tests/tcg/alpha/system/meson.build            |  1 -
 tests/tcg/arm/meson.build                     |  2 -
 tests/tcg/arm/system/meson.build              |  1 -
 tests/tcg/hexagon/meson.build                 |  1 -
 tests/tcg/hppa/meson.build                    |  1 -
 tests/tcg/i386/meson.build                    |  2 -
 tests/tcg/i386/system/meson.build             |  1 -
 tests/tcg/loongarch64/meson.build             |  2 -
 tests/tcg/loongarch64/system/meson.build      |  6 +-
 tests/tcg/m68k/meson.build                    |  1 -
 tests/tcg/meson.build                         | 30 +++++-----
 tests/tcg/mips/meson.build                    |  1 -
 tests/tcg/mips64/meson.build                  |  1 -
 tests/tcg/mips64el/meson.build                |  1 -
 tests/tcg/or1k/meson.build                    |  1 -
 tests/tcg/ppc64/meson.build                   |  1 -
 tests/tcg/ppc64le/meson.build                 |  1 -
 tests/tcg/riscv64/meson.build                 |  2 -
 tests/tcg/riscv64/system/meson.build          |  1 -
 tests/tcg/s390x/meson.build                   |  2 -
 tests/tcg/s390x/system/meson.build            |  1 -
 tests/tcg/sh4/meson.build                     |  1 -
 tests/tcg/tricore/meson.build                 |  1 -
 tests/tcg/x86_64/meson.build                  |  2 -
 tests/tcg/x86_64/system/meson.build           |  1 -
 tests/tcg/xtensa/meson.build                  |  3 -
 40 files changed, 78 insertions(+), 105 deletions(-)

-- 
2.43.0


