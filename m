Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16601C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA7t-00089X-2W; Fri, 25 Sep 2026 13:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7r-00087Z-5S
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7m-0000dI-DN
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:22 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0KYd1363024
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=8TGxjYWUh4LT+rbGbg5Y+a
 tFspa+7gaHfuxBJQXQEDQ=; b=Icfa2yVQ1FrQ1PuBMH4Cy3unbkQ/1pvG5MCfMA
 b8jrxKD4fWTJm+d/4NpXZLtv2J4cfiEqw08FaGTbYDOQ5duKYwPDAhHCNB/uG81v
 0Fg5LyuuUpRgtKpFeuKWoD5WGzXd1I+eYJSObvEoPiFzduxmPzR8PL9ohZW14DAU
 PuseQwlj5k7WD2p2pFMexFnRqFJA3G4eAbkN1x2CIoyJ+Ca88vr5mbUpDUvvEM82
 NSQLcMgwsrVtbGv3zETMD4sSJ+bng40P/C5YMzXvUXVz12e3H6i0QjTRWNxUmbca
 nKpY8ggF4UX9emwUcX63YAZEOeGiZolIVkuhxUgBfEs0HRCA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvnsmkd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:08 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-32b8c2b30c4so2050624eec.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358847; x=1790963647; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8TGxjYWUh4LT+rbGbg5Y+atFspa+7gaHfuxBJQXQEDQ=;
 b=OcQbrgUxFz5EotNIwULW0A0rbkmSrhNzndlDMf8G/5Qg8LwuL+iXsrgv/bquhtN9UA
 UjZIjk66LYmgHCkZ+c5M18q3QGbOeeMkhVte9rXmU0D2rJz/jlWZg6J+oj/MlHmA9Pxc
 uxaEK9y0ljC9/vbem7F4VaPv10pDlASlYHZdHJKkXIC2eQUwkLhx0REmTRxhj8k34Thn
 Euqe5QWPncx9fv/qxF0ihkbLJFUliHfrgSP8dzWUUblNEOU2nCJzhGZe2qvfzr7mSdd4
 S+W9PWfLXngFfbXuVIAjOHQT26F/HX4imQhZbHFnzktqpBbCdsMVndgmJSeX4pujdpcM
 pn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358847; x=1790963647;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8TGxjYWUh4LT+rbGbg5Y+atFspa+7gaHfuxBJQXQEDQ=;
 b=troYJotMowjnMMPw+dnG7j6q0In2snK+bF/g78JflyBRHUdjqcxR3naFBORdLtX9pN
 pjkRA4USJx317ZLIuQGWyQcD7LB0fLA5u4WZ9f+C0aDGVuWrh4UQvAvkK2MQWKSBglEc
 Pi4Jlpb8baDtn0H3demTg3P+DWWFk5fTwz2dzCMJOwztRmlZZ+3f0NFLOz66WlFrnCah
 ga1YiZP82v31Gzojhx34uMPK4UCQk8JPdFTRswbZVPQezmA1Pgq3i/fTI7wehdoHCuaI
 PVKvghHLjpZ0YHkx0xRF7KWEqcVx8BckECGxiUmOiBAZBNr7HhVwcAA9pZbUjC1wYGKn
 fF4w==
X-Gm-Message-State: AFuF++lyvmhNETzXV9OgYQlhtriZdT1hUhz5BwRwZd49fa5M6dRaJiyg
 sJcAKmq8j/Q2AH+mgcSIrL3XnW09VCjGwDpuixxHJ6eqOO2KHFGS7CaNgZCufUzzFj8OfrGGMI3
 UbSdoOXm2W7if1AG7EO7A7u+gVUv2LQDOkDypCDcGrIe7NGHn+XGupuCulLg4RvveAA==
X-Gm-Gg: AYBFou2/oNYulCOag9CEmMayfxCj2Ea2sF0nMftOZkibCmB4GHxd4C32/RuFqja0sqf
 wvbTL1GGQa4R92xHoE91ZeIlIev9EE7MNhr2mFUG+HCBa3AQ2A7NX4KzpqY4pBs0dygY55uBM97
 JLId4smEbTbSN9Wrd1Cmq+0kwIUJOArcRj7M/04G3T5E3MUBj5GBHUS5qP2Moa0YLbeT31EnvQf
 EA0j08xxjhkqZEoUfrdFH6x6rECrmRHySaJGda525rNR0IDFRncYNiwhpchcmiPHHZhKZA2p4Gx
 NlV5hEWlNMXcbzbQtSpy+vTf4/IpMWbFeq7l7HkJ7snTXOQ6rdjM+H/G9RRusCjiFNGK3okv0R5
 bbifEXdgcEhkqcFtW+OfkO70thvPm+rarcpNL73NQlGg9FSaVqeqUhrCR9A==
X-Received: by 2002:a05:7301:1448:b0:342:6595:d750 with SMTP id
 5a478bee46e88-342711aadcdmr843242eec.2.1790358847088; 
 Fri, 25 Sep 2026 10:54:07 -0700 (PDT)
X-Received: by 2002:a05:7301:1448:b0:342:6595:d750 with SMTP id
 5a478bee46e88-342711aadcdmr843219eec.2.1790358846429; 
 Fri, 25 Sep 2026 10:54:06 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 00/13] tcg tests 20260925
Date: Fri, 25 Sep 2026 10:53:47 -0700
Message-ID: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hk8J3gh9C3WOYgwG1IMRFnUImqBftIZt
X-Proofpoint-GUID: hk8J3gh9C3WOYgwG1IMRFnUImqBftIZt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX/PxAzCYU59nn
 hu30uctVW64ncJENAHb3om6V3C/8V9ZzpS14InDZYlsuQ4VbmkDIp8qQXaOsBUmQUx1qaTl5Ijq
 AKLsNBJSnn1DhCKBbFBRHm3FlZKRWiU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfXyHES5KnwwZAT
 O6SgnHSf9QIS6zP6SOaVJ8BHvu0xAKtBhBiva03/annT4ue5DAetH5Vu/8zn6Mi60eV+Ghy2zzf
 lTCpxrb84KeuZu2BjgONshHhFIvVt47dcHXd2qEOuqri2T9guXJQTBsveCsOSuSu7uCGs9BtUiH
 JtwQn0B9uV82VhW4dj3de7Dvczt2tq3hJFMqjd6XWdnlaxOdu5uh72qbZDbFYJBzQZjoMQ4848T
 a02pxQAE+qHhHifN7YE2VoyJ6StT69YpKrXlAgn1/JttappwykBz2m5pYjdyJOofX/LIMPSRz0A
 /XHIvUKkVKr6i1ZXZm0eRVWDAf+U3OEvH5Ch/YcnkUL6XA0SzYdLogOIyW0QeJK3I5prVSwn+eR
 0lE4irsEIEFXY5wrk2HQHmjHXbuVbsvUg77gR8Ti9GtuDvCCMpIbfDffUo167xqjEFv5jSWBWLf
 l9Oy3CZkCThgzJ8yiQQ==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab6b540 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=NFqucfQ7s-eWkH41LbIA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250071
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

The following changes since commit 80c1d80c10a0676728d65874a9641eb578626d7c:

  Merge tag 'pull-hex-20260924' of https://github.com/qualcomm/qemu into staging (2026-09-24 19:35:55 -0700)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg-tests-20260925

for you to fetch changes up to 2ed098a7f2549781fc06e5228bf1fddcaf402db1:

  tests/tcg: add alternative cross-compilers for macos (homebrew) (2026-09-25 17:04:17 +0000)

----------------------------------------------------------------
Changes:
- [PATCH] tests/tcg/meson.build: reintroduce build-tcg target (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260918202704.9790-1-pierrick.bouvier@oss.qualcomm.com
- [PATCH] tests/docker/dockerfiles/debian-loongarch-cross: update (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260923000510.218473-1-pierrick.bouvier@oss.qualcomm.com
- [PATCH] tests/tcg/meson.build: compile test with -fno-stack-protector (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260924202012.2465-1-pierrick.bouvier@oss.qualcomm.com
- [PATCH v2 0/6] tests/tcg: use x86_64 cross containers on all host (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com
- [PATCH 0/4] tests/tcg/meson.build: detect additional cross compilers (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (13):
      tests/tcg/meson.build: reintroduce build-tcg target
      tests/docker/dockerfiles/debian-loongarch-cross: update toolchain
      tests/tcg/meson.build: compile test with -fno-stack-protector by default
      tests/tcg/meson.build: force use of linux/amd64 platform for containers
      tests/lcitool/refresh: generate dockerfiles using --host-arch x86_64
      tests/docker/dockerfiles/debian-all-test: remove arch specific bits
      tests/tcg/meson.build: remove cc_docker_host_arch
      tests/tcg/loongarch64/system: deactivate loongarch64-softmmu-memory (hang on aarch64 host)
      tests/tcg/x86_64: speed up compilation of avx, mmx and 3dnow tests
      tests/tcg/meson.build: report correct cc in summary
      tests/tcg/meson.build: introduce cc_alt (alternative cross compiler)
      tests/tcg: add alternative cross-compilers for fedora
      tests/tcg: add alternative cross-compilers for macos (homebrew)

 .gitlab-ci.d/macos.yml                             |  7 --
 tests/docker/dockerfiles/alpine.docker             |  2 +-
 tests/docker/dockerfiles/centos9.docker            |  2 +-
 .../dockerfiles/debian-all-test-cross.docker       | 39 +++++----
 tests/docker/dockerfiles/debian-amd64-cross.docker |  4 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker |  4 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |  4 +-
 tests/docker/dockerfiles/debian-i686-cross.docker  |  4 +-
 .../dockerfiles/debian-loongarch-cross.docker      |  2 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |  4 +-
 .../docker/dockerfiles/debian-riscv64-cross.docker |  4 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |  4 +-
 tests/docker/dockerfiles/debian.docker             |  4 +-
 .../docker/dockerfiles/fedora-rust-nightly.docker  |  2 +-
 tests/docker/dockerfiles/fedora-win64-cross.docker |  2 +-
 tests/docker/dockerfiles/fedora.docker             |  2 +-
 tests/docker/dockerfiles/opensuse-leap.docker      |  2 +-
 tests/docker/dockerfiles/ubuntu2404.docker         |  2 +-
 tests/lcitool/libvirt-ci                           |  2 +-
 tests/lcitool/refresh                              | 37 +++++----
 tests/tcg/aarch64/meson.build                      |  4 +-
 tests/tcg/aarch64/system/meson.build               |  2 +-
 tests/tcg/aarch64_be/meson.build                   |  2 +-
 tests/tcg/alpha/meson.build                        |  2 -
 tests/tcg/alpha/system/meson.build                 |  1 -
 tests/tcg/arm/meson.build                          |  2 -
 tests/tcg/arm/system/meson.build                   |  2 +-
 tests/tcg/hexagon/meson.build                      |  1 -
 tests/tcg/hppa/meson.build                         |  1 -
 tests/tcg/i386/meson.build                         |  2 -
 tests/tcg/i386/system/meson.build                  |  2 +-
 tests/tcg/loongarch64/meson.build                  |  2 -
 tests/tcg/loongarch64/system/meson.build           |  6 +-
 tests/tcg/m68k/meson.build                         |  1 -
 tests/tcg/meson.build                              | 92 +++++++++++++---------
 tests/tcg/mips/meson.build                         |  1 -
 tests/tcg/mips64/meson.build                       |  1 -
 tests/tcg/mips64el/meson.build                     |  1 -
 tests/tcg/or1k/meson.build                         |  1 -
 tests/tcg/ppc64/meson.build                        |  1 -
 tests/tcg/ppc64le/meson.build                      |  2 +-
 tests/tcg/riscv64/meson.build                      |  4 +-
 tests/tcg/riscv64/system/meson.build               |  2 +-
 tests/tcg/s390x/meson.build                        |  4 +-
 tests/tcg/s390x/system/meson.build                 |  2 +-
 tests/tcg/sh4/meson.build                          |  1 -
 tests/tcg/tricore/meson.build                      |  1 -
 tests/tcg/x86_64/meson.build                       | 10 +--
 tests/tcg/x86_64/system/meson.build                |  2 +-
 tests/tcg/xtensa/meson.build                       |  3 -
 50 files changed, 142 insertions(+), 149 deletions(-)

