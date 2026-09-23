Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777E3C98311
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 18:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9S9z-00014Y-R0; Wed, 23 Sep 2026 14:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9S9y-00014I-0L
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9S9w-0003XP-4h
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTh2U217671
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=EAuM7b6In9uZ4fxn165B8m
 cfIRLA/VDsqH+AZK3vuSI=; b=oxDqomRhiI1BeROqeUvhlmatRD4Z8o/be+TGIC
 EMw/g3Zqb7uo15HYEaoqrKjB2VKSc5B5GA8R6yTuYzd7KcqO3bW8ddQn4OPO/uFo
 I+z3x9Y59tc7qGKf1ZsVxj10IwdXyuDx9Zy0XFIxS8Kjw5DsaMVHJoqGuEUDKBP+
 Q4EqVxL/p03Gf+vNr8HtiPBuSpc/nWGfUqbwd5qFTeSnQp0fg6sbSNwal2TtgIl0
 CCz36P/ZcTTvezw98GbSKCm/d3W+4hRrZPZY2wpb/X0g00EXFz8F0FAg6PufmKgu
 +MjzE7uLAd2UbYlviOsIOlILoNDkW/EL/B8pZorYwKreRXNg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvdb622hg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33bb08e80a8so179339eec.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 11:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790189852; x=1790794652; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EAuM7b6In9uZ4fxn165B8mcfIRLA/VDsqH+AZK3vuSI=;
 b=BfFazNNw0b2F6NNRjCI6ejLPX2VZ1qnLXLsfjWwzWl0fiZgdnGApCP03t1wp7RcGxu
 MGYpW8Dp94I2gNihBPV2PHHoTwHIv6dwzTtjtpyjDelcdV/lpzjnVsTiwrPec1n6g2+Q
 L6udQ3LzIPCgnNV0huuBd6esCjXed9EMG0prlOXIK1yFR0a39b5iUM4e6cIMfORgZ0Q1
 39aGg6RTslCsKZMiQPu9I5wUTfKm0m7Mnz8KOEyahzWLYKpm+sehg9NFjmeJ7hTm7kiQ
 a3VrmZ6cjGn6JGcR430fULUsgq6qdKBpaTHry80suVmPvKottk+2A6rQby7NY5tvPWWv
 FQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790189852; x=1790794652;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EAuM7b6In9uZ4fxn165B8mcfIRLA/VDsqH+AZK3vuSI=;
 b=MaOjrYxJ/vdV1a0A2f/uIDZnfKL1YtIBMlzZS82dUs/zyrM5OC4xaUEOiv9fjU2bD6
 F4FXIT5m8hZczc/CoZS13oxwKoGDtHvXaI20EKV5B5hlROjEmphj1g8iOu/jfyqBmrNN
 IquwtXdfAuR/LzM9g0RdbMQDd3ZZ0abJLCQ1YJBDVcfYg5pvePI9KLn9j432rv3T+hYT
 l8i/yU/dpggFX3pq/RjB8IzmWkRxQuzp8q0qB4bs4S7+X5qlQlBCx41gPvgb2jR+vaNh
 roC2165aFRKXjt4DaJILxvCNOiNs6IarrKx1EdWKq8THD3f1JCfqyrTzWOdKIujA7FFs
 nKWA==
X-Gm-Message-State: AFuF++nix2Nxp/ha+eCdGwM0HqYvR8mfPaV4sCqDnIMCtttzo86CSXy6
 Q3HuvkKlTNcMfLbudVMtrYuw01WXz7PkyT4+flnmV5JTARpTmV52m/EjsbEbgjhZARpVFtg0mmU
 oIFdHsIVblmeg1q91DhILgZn/N0oXrh2wWiVs38X4EPNncexKGIOcTFrQ5/GxxevY1A==
X-Gm-Gg: AYBFou1DDRtPuMi6uMtx/hJl+th4JHJq3JzLbtj1YCdiqA9zqG+bRYfhPbHMuHVNlRi
 b+yTISsLZhFylHhXOJK47MQ+AaQu6yFv4UmlGcjll1NIIO4yV0iKA5cCu/bhSqrlw+6D6zyqNV1
 GsXwwLEXnbaIce1BBnD0YEZCbFmUO2emLkavNrRnpCzkH3VSFPwu5Jhraz58W/0Ail3xpNdqIJO
 ax2LFEyf1Gn+PJAZPm9KIw9UkjukkP54wwiOa00yLyw73MmwYSZmUo6Br6CvMam+wuUB+OrdXwT
 VOwlG351hTiWqOwrqUQf+21/1635RMjB2aEkzRi1PXIKlSiTX7zYmPyhwbn24AppHwGJ/AsolAq
 sipr6ZDtD7h83NYh33j5i7u11lhoWai52jtpypPlvRz6/HzKIJiJl+MbSFw==
X-Received: by 2002:a05:701b:4555:20b0:144:ef65:13a0 with SMTP id
 a92af1059eb24-1450404927bmr43997c88.6.1790189852034; 
 Wed, 23 Sep 2026 11:57:32 -0700 (PDT)
X-Received: by 2002:a05:701b:4555:20b0:144:ef65:13a0 with SMTP id
 a92af1059eb24-1450404927bmr43962c88.6.1790189851378; 
 Wed, 23 Sep 2026 11:57:31 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f9820ca5sm8154931c88.3.2026.09.23.11.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 11:57:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, philmd@oss.qualcomm.com, 
 berrange@redhat.com, alex.bennee@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v2 0/6] tests/tcg: use x86_64 cross containers on all host
 architectures
Date: Wed, 23 Sep 2026 11:57:19 -0700
Message-ID: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IpdLqsmxUGOQ7ZcgHxD2IMJ_vBir7aLN
X-Proofpoint-ORIG-GUID: IpdLqsmxUGOQ7ZcgHxD2IMJ_vBir7aLN
X-Authority-Analysis: v=2.4 cv=QeXzLcbv c=1 sm=1 tr=0 ts=6ab4211d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=OVqUXPvxL_SbygzQYh4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfX1hhbrWJa0SBp
 h4/jT44JGXSiLyt73zsNgUdVL8i4gTVDKW1a5hXh3RRmfBd/P78fbBe2H1t/uWc2v3VxwYjQ3Nx
 yXdGZtHIvm+SAAevWUh1VXP6BQh9UQE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfXywacoTzIW4zN
 pno3nWpI5B1f0kcXayIt+vNClPPSO1IycSNRhJEWZR2zyZ0wJJgA3UOd3PNfJSJ7JQNR8iUmIPH
 wvOL4ZD6O1RNxjjWODQXnazKc9hu2P/fW8nNA2s3gXLZjh452ZvytzEziPU7orSO3qG9AGHmgab
 slvrFJJp66wd0A4ddscaatAayCT4UgoYBrQt4HBwBlah8OJgTAzoTybEaC40zWP0Qa2ddNvW+eT
 v4apiqg7poFQAG/0zaSLYBBZbiw+BWID+GyxdAfRULo/ldceo2ExIRbkn8ifo4Z/7eknFQK+Qdo
 HIRfDj2ZOHD26OG7EAeTaathLjxuJpOCYR/K8+himmHxEXgIU02XqATs+8l2sR8ylYLtHVtTEf5
 EdeJ9vd1hf6UzQNWGs13DOgbTPFdzzzDgksZIihe7PeDXjSi504kLiKRkE3Ce6egGESqEfhCRly
 Zd5tslJevJqin91j64g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230075
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

To increase our testing surface on aarch64 and other hosts, and also to ease
maintenance of docker images, this series introduces x86_64 base containers.
We rely on qemu-user-binfmt (available at least on Fedora and Debian/Ubuntu) to
be installed to execute x86_64 binaries on other host arch.
With this, we can run the full tcg tests suite on any host architecture.

This series exposed an issue with on aarch64 hosts with test
loongarch64-softmmu-memory that was reported in issue:
https://gitlab.com/qemu-project/qemu/-/work_items/4567

v2
--

- Add comment in patch 1 to explain we detect x86_64 containers execution
  capability
- Replace the registry change patch with updated libvirt-ci, that now generates
  arch specific Dockerfiles by default
- Use lcitool --host-arch x86_64 to have stable refresh output on different host
  architectures
- Add a patch to speed up compilation of x86_64/test-avx.c.

Pierrick Bouvier (6):
  tests/tcg/meson.build: force use of linux/amd64 platform for
    containers
  tests/lcitool/refresh: generate dockerfiles using --host-arch x86_64
  tests/docker/dockerfiles/debian-all-test: remove arch specific bits
  tests/tcg/meson.build: remove cc_docker_host_arch
  tests/tcg/loongarch64/system: deactivate loongarch64-softmmu-memory
    (hang on aarch64 host)
  tests/tcg/x86_64: speed up compilation of avx, mmx and 3dnow tests

 tests/docker/dockerfiles/alpine.docker        |  2 +-
 tests/docker/dockerfiles/centos9.docker       |  2 +-
 .../dockerfiles/debian-all-test-cross.docker  | 39 +++++++++----------
 .../dockerfiles/debian-amd64-cross.docker     |  4 +-
 .../dockerfiles/debian-arm64-cross.docker     |  4 +-
 .../dockerfiles/debian-armhf-cross.docker     |  4 +-
 .../dockerfiles/debian-i686-cross.docker      |  4 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |  4 +-
 .../dockerfiles/debian-riscv64-cross.docker   |  4 +-
 .../dockerfiles/debian-s390x-cross.docker     |  4 +-
 tests/docker/dockerfiles/debian.docker        |  4 +-
 .../dockerfiles/fedora-rust-nightly.docker    |  2 +-
 .../dockerfiles/fedora-win64-cross.docker     |  2 +-
 tests/docker/dockerfiles/fedora.docker        |  2 +-
 tests/docker/dockerfiles/opensuse-leap.docker |  2 +-
 tests/docker/dockerfiles/ubuntu2404.docker    |  2 +-
 tests/lcitool/libvirt-ci                      |  2 +-
 tests/lcitool/refresh                         | 37 +++++++++---------
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
 tests/tcg/loongarch64/system/meson.build      |  6 ++-
 tests/tcg/m68k/meson.build                    |  1 -
 tests/tcg/meson.build                         | 33 +++++++++-------
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
 tests/tcg/x86_64/meson.build                  |  8 ++--
 tests/tcg/x86_64/system/meson.build           |  1 -
 tests/tcg/xtensa/meson.build                  |  3 --
 48 files changed, 87 insertions(+), 120 deletions(-)

-- 
2.47.3


