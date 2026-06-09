Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F403BCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4Ii-0006bX-CL; Tue, 09 Jun 2026 17:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Ih-0006aD-4S
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:47:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Ie-0007zE-Dn
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:47:58 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4tOB1642698
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=bYRX4PtOOrCKJZaTFCUrzl
 lnKk873R2NqVzmStEiJJc=; b=H6WKwJ9etyoic49hP+dg5eboBGcgcaj6Cc/bDj
 qwUb8PFllWfcHaAd2Rv8PFurIrqBsNUZqdBmhEzj5UoZoDaX+hJQNzAmLOZN3Sah
 2qadhbs4OZqXd0fuREzld0tG2v9fZZH2uEGWRn0ktz45N3W3D+6mahN44TxqCnUI
 wH66906YLFLRib882bGT3pssWFLIu8RgpbI+PSyaaug3dUf5T2oGZU7TNzJoDbl/
 2nnLh4EO1al23KnP0kyeuBh+TvSnghbuBQBSmF3J5bUffFU7euVJdGrla0fFbSG8
 e9ZixFxGhbwMyl6ueRqz+WyWS1wjiDnlWkBKE7ZQnI9f7K9g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epf0suvsn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:47:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304d8613efbso6200531eec.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041672; x=1781646472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bYRX4PtOOrCKJZaTFCUrzllnKk873R2NqVzmStEiJJc=;
 b=OD6KbA9Y2T7N84tAPXG7P00eDz9uYVxLzVS3SYerxrTA96+5Ziwgk/HrlC8+nL9Fc+
 XIRW7nMqxcvYTKwkrqsaAlzr+cJ6V3c7QDiyukrZ7bUANR7SMPrnv12RjEyVl+hcNriO
 nKhmhAM/KlcFgo67VkTW1rrGhA75n4WlgPb0g9+FAbfQbNPM2AFc7DDW/dre4enUMVVi
 O/byGrFJYj2Np6NcAi0kGpuS8+QKLBm5R4ZMj1dIszwrBFX2Fwjn9DoowBNlD19gHjbP
 YGGuBz+KFAlhjxDWjEJ4pa6nzDtl70TxvVlSLaoSFnVWykaDiaWe/o2HwJ0oJ1Ql48Gj
 RxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041672; x=1781646472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYRX4PtOOrCKJZaTFCUrzllnKk873R2NqVzmStEiJJc=;
 b=Nmw2zZtUcXNmhrG60nF0FwAW/Sbsr4Ld1lXwKX+ie715Yy2xDcbidIZfabc4tQqJrC
 QXgFdS8N1hdnunV3hu+Abfqh+vd7NLKcrBc3M6LlpM50wjj/vK8eyTaWp1/+OfYNCZkn
 x3EwVGs5AC4BV7+BeFl/xlg5Q48b/DPMK4AlfYH0Hz4YyE8cwbY8YYB8HtniZKKC1vut
 hCt6HIxHQkZnu+Wq7iNrF3vxj4wuO/kMh59UtOe2iKttwJJ4Q8cE7JhFfCox2lkKcIOi
 UDPp4dNcW+WApEJR6peFw5YbrXy70s5FVd0QMPrvWZiyxGIzqqmhzRooLHNRvSubMw2c
 +ulQ==
X-Gm-Message-State: AOJu0YwkK9t11UFRIYvu3fBPoHAx2I60xgjppC6u33nvKKWdo6krRjJv
 6ho+Vop/CUKmw/6EO5VGZTjIZ2L964BRXpm9lirkB47rxuDGA81lDP/FP18v4yGWDyKf+WaceaD
 6oKCNpGbR0DPCPNp0nNxQlu/1MreBP7it4XAG5Wz/LJzsVYnTugNgel8JdN09vLoIYg==
X-Gm-Gg: Acq92OEiddwSHKfy/VVBc7aljKIOYSW3x3ieESJcxIB8H5lCCKOFGkx7MXmVz6HUdwJ
 n3TFs07HIPHRj+s/Lz6m3GcwI8VdsXWr9tNYmAc3jrvTzb9bBfUk7ekMdHdv+HXe9iCVmKScGuJ
 rrExr69Ffku8ozmVHQ/4QOctLGGwbGXDECPhwVMl6L37jvpHw/sZvOV24jMOEyHB6cAOC+w1VGL
 y34P5Y1CBO2D7UgIZQkTQNLn2EkzgywiovfPwUH39rSB8T0GyKNqaVG3nvmgHVK78u5CYdhCyVL
 ey8pZsJNmCXkdNwK03aCNXOonuU50aqKi+BihaIJ5L6lD+sO3PFDYHNbwnK2WHIkaK3jT8RGGTk
 nL1g5aTrk29kfL+8z8ljGQu92rTNWZ0Yvn0uM6iBpw9JSVHlZTUny07ifNhTLsbzVOMVgVB7CSj
 AmO1lFsozZiSeZ5RcC
X-Received: by 2002:a05:7022:1a86:b0:138:3612:7e77 with SMTP id
 a92af1059eb24-1383612808emr1712120c88.13.1781041671674; 
 Tue, 09 Jun 2026 14:47:51 -0700 (PDT)
X-Received: by 2002:a05:7022:1a86:b0:138:3612:7e77 with SMTP id
 a92af1059eb24-1383612808emr1712090c88.13.1781041671072; 
 Tue, 09 Jun 2026 14:47:51 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:47:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 00/27] tests/tcg: run tests with meson
Date: Tue,  9 Jun 2026 14:47:18 -0700
Message-ID: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNCBTYWx0ZWRfX50Y6xv3+Se2B
 uO12jDC1EUf0ZMy7exVPWANUyPa7YaQvEQl9KZ+nLqlRzSPdEroJdndEtYh8wg7lkoL233jFvx0
 rygRAAeWt75VSd1nHeKHzIvBCXuvxPcFIk2DAgBfbCBYN+qbaHjk6vcrdVgeYs+AssuCThSP7O9
 7f7ckfoIdss+DowY4Fk6ae0IAng0HZpHB+4zs5XXGQmPD1qBIydcWOyZp+58Ig9wfJLL2W8Wk/e
 m9gGadUyNzACH6iP4rmG1sDODc8THrn7lM0Df+c+TFI/vXj8cANFJtY8Klv0XNHY1Pwyyv72thZ
 YIsw3i+5AovtBS5ceQ6smjAsfY/+CyXp2KP1rfS15o62l0vBhBealCntwJr34eJ/Zp1dLXi7pXx
 AujK/ZNCXvzfCZZQTQeIZhVHjJ0X0CIW3AkxBvEt3SUHnzr196NHatwl45uLi9KNozqcNat5z7/
 cHSgHNRFewiRh+3V+qQ==
X-Proofpoint-ORIG-GUID: M4mRXEukcQk4UuRJtIAT5bN5hJsneSEf
X-Proofpoint-GUID: M4mRXEukcQk4UuRJtIAT5bN5hJsneSEf
X-Authority-Analysis: v=2.4 cv=GeonWwXL c=1 sm=1 tr=0 ts=6a288a08 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=TAPdDoJ7-Bd5JvRZq9IA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090204
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

This series is an experiment to replace TCG tests makefiles with meson, with the
goal of having something more readable and maintainable in the long term.
Also it closes the gap that tcg tests had with the rest of tests, by integrating
them with meson directly.

It covers all existing tests for aarch64 architecture, including
user/system/multiarch-user/multiarch-system. I'll carry the effort to port all
other architectures once we agree on a base. We agreed with Alex to not merge
anything before all arch are covered.

Series first declare the global infrastructure, then add aarch64 and multiarch
tests, and finally plugin tests.

For review, I would suggest to start with aarch64 patches (end of the series) to
get an idea of what they will look like, before the implementation itself. You
can also compare that to existing Makefiles, they follow the same order.

It implements all requirements listed on original thread [1], except cross
container support, which can be easily added on top once we agree on the base.
[1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/

We also have for free:
- correct and complete dependencies for any test, including:
  scripts, c.inc, headers, reference files and binaries/plugins.
- catch test declaration issues at configure time vs test time.
- proper data types for variables instead of string expansion with make.
- we could now build tests binaries by default with 'all' target.
- hopefully, better readability to your taste.

Main ideas for the current design are:
- make arch files as simple and explicit as possible. If it conflicts,
  always pick explicit, as long as we don't expose meson details.
  remove any kind of "skip, override, filter" logic.
- never expose custom_target and meson details in arch files.
- catch any spelling mistake on test or any dependency.
- keep complexity contained in tests/tcg/meson.build.

Usage:

```
make check-tcg
make check-tcg-aarch64-linux-user
make check-tcg-aarch64-softmmu

from build folder:
./pyvenv/bin/meson test --list --suite tcg
ninja clean
./pyvenv/bin/meson test aarch64-softmmu-asid2 --verbose
```

Pierrick Bouvier (27):
  tests/tcg/multiarch/system/memory.c: remove unused variable
  tests/tcg/multiarch/plugin/check-plugin-output.sh: take test output as
    input
  tests/tcg/multiarch/plugin: rename check-plugin-output to
    regex-compare
  tests/tcg: introduce meson.build
  tests/tcg/meson.build: introduce exe_name
  tests/tcg/meson.build: introduce test_name
  tests/tcg/meson.build: introduce cflags
  tests/tcg/meson.build: introduce qemu_args
  tests/tcg/meson.build: introduce env_var
  tests/tcg/plugins: build list of test_plugins
  tests/tcg/meson.build: introduce plugin_test
  tests/tcg/meson.build: test gdb support and introduce gdb_arch
  tests/tcg/meson.build: introduce gdb_test
  tests/tcg/meson.build: add default flag for testing compiler support
  tests/tcg/meson.build: introduce wrapper
  tests/tcg/meson.build: introduce expected_output
  tests/tcg/meson.build: add wrapper run_and_check_forbidden_output
  tests/tcg/meson.build: add wrapper run_with_input
  tests/tcg/meson.build: add wrapper record_replay
  tests/tcg/meson.build: add wrapper check_plugin_output
  tests/tcg/aarch64: add user tests
  tests/tcg/aarch64: add system tests
  tests/tcg/multiarch: declare user tests
  tests/tcg/aarch64: add multiarch user tests
  tests/tcg/multiarch: declare system tests
  tests/tcg/aarch64: add multiarch system tests
  tests/tcg/meson.build: add generic plugin tests

 tests/meson.build                             |   2 +-
 tests/tcg/aarch64/meson.build                 | 248 ++++++++++++++++
 tests/tcg/aarch64/system/meson.build          | 100 +++++++
 tests/tcg/meson.build                         | 276 ++++++++++++++++++
 tests/tcg/multiarch/Makefile.target           |   3 +-
 tests/tcg/multiarch/meson.build               | 149 ++++++++++
 .../multiarch/plugin/check-plugin-output.sh   |  36 ---
 tests/tcg/multiarch/plugin/regex-compare.sh   |  28 ++
 tests/tcg/multiarch/sha1.ref                  |   1 +
 tests/tcg/multiarch/system/memory.c           |   3 +-
 tests/tcg/multiarch/system/meson.build        |  53 ++++
 tests/tcg/plugins/meson.build                 |  11 +-
 tests/tcg/scripts/check_plugin_output.sh      |  19 ++
 tests/tcg/scripts/record_replay.sh            |  16 +
 .../scripts/run_and_check_forbidden_output.sh |  19 ++
 tests/tcg/scripts/run_and_diff.sh             |  12 +
 tests/tcg/scripts/run_with_input.sh           |  12 +
 17 files changed, 943 insertions(+), 45 deletions(-)
 create mode 100644 tests/tcg/aarch64/meson.build
 create mode 100644 tests/tcg/aarch64/system/meson.build
 create mode 100644 tests/tcg/meson.build
 create mode 100644 tests/tcg/multiarch/meson.build
 delete mode 100755 tests/tcg/multiarch/plugin/check-plugin-output.sh
 create mode 100755 tests/tcg/multiarch/plugin/regex-compare.sh
 create mode 100644 tests/tcg/multiarch/sha1.ref
 create mode 100644 tests/tcg/multiarch/system/meson.build
 create mode 100755 tests/tcg/scripts/check_plugin_output.sh
 create mode 100755 tests/tcg/scripts/record_replay.sh
 create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh
 create mode 100755 tests/tcg/scripts/run_and_diff.sh
 create mode 100755 tests/tcg/scripts/run_with_input.sh

-- 
2.43.0


