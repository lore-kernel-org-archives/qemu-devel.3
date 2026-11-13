Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591F606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SAAt+Omy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gf7bH6jf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmD2-0003cZ-PC; Fri, 13 Nov 2026 03:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmCj-0003OC-6w
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:00:16 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmCd-0000IK-WF
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:00:12 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD576D03119860
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=U8CqxUR8zSS
 M2sdXuf4vUBTBhl40+ZbSvhj1c1hLA7k=; b=SAAt+OmyU/jr5vFyga4Ankq105E
 X1pMe4xKFEcJKQTQBvh93oebN2PH9bOd9/BGfCxNuIB5UiO0xAFcBG7TKo+04MBe
 rYX4UAmHs6yE6LLk16X7hEaHJBvGg5BwJLRWv1yGBVkh8O0tuP4gpmn0gFtkChuV
 kEMTqF81erptmCfXsSkpddEc9fNKCIRELCbrKXCoKz+CyVDo9FUGDkG786LnPUXV
 6Z54h5iW90rOp3ZQvKYyGwSG6boz+xyJqYCMwOXSL76UJ7Xj+qz9kNkaphJ3BoP9
 cnNbGlfKUfr1qSk9LQ4RAScRtwY3OdMZ81MmHH3Tjq58RLBj9xjZqLZco2g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwa3er-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:00:05 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33bf1d17dfeso93295eec.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 00:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794556805; x=1795161605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U8CqxUR8zSSM2sdXuf4vUBTBhl40+ZbSvhj1c1hLA7k=;
 b=Gf7bH6jfOy7nKrEJeZ/HJE4cbxm1eDB/w6xPfwsOCpqTBgBbkJUsZdx23JRPyZXHCG
 tMDdJsgL8ju1Kchbx+OL53T70KNMbcm1LEIRqYsfqlmikO255Q11Ym4YhKl2wTNbPUEH
 qjb2Y3HWP43Ba//k8EsAK3WPqiOG4VwjdjKZZLQXuR6hR7UsSmoCUgVWLY4dr/q3H9sh
 B0GD1dg96W1TewOD6Zz8V/BypNyuuxe32kkVpo7m762yKixmHq8p8UbWK3dECDTWopcy
 gbGLwciHtOFyrDFDn6rJSU2D2wECONcflqWQp5z31diORW61RtQNIplgqaXx/WwgWCe0
 V6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556805; x=1795161605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U8CqxUR8zSSM2sdXuf4vUBTBhl40+ZbSvhj1c1hLA7k=;
 b=b6IQyyUkTOqLmCFogVlebS2644Z3rTddPXECBNyIpT2ZlShZkn+7KpQgrVUZudEFeM
 nfPLCMA7dozGOZzo1I6OsRA+j1ehNZz8pCipPwkLkKsWTW8bDigyuea2bdAosA1dpFVB
 bjW9WCYi5MoFSL2ZTLy+oLkhxq0wTelOFoor6eeDQ186Rnj+syTRkKlKl6cMiWqirVIc
 nyKnPYIyJz/+XNhklFnOx0duX/sOm62hELLxfyKCSPg8YXefjeEqsdrMGEpDV6HJU1QM
 0rBIT/CTXFJNdqEzZ+aejFbyEGcUgsBTDyQDCbDdtHDML0fIgBainNwWxA6lA9rLcTsI
 ayyw==
X-Gm-Message-State: APuU4Z/hzgGJ7ghiYpU4hrirxQzx9FZ7fE1l7NgEoGk96bxM0QsFoEzg
 hEGXWU0huIbC47Cn1If3+yHLsYWGIoam8RsldaHY5t6mFf4pn14N+/i15u6BlfckHooCsBnI2eE
 QOU/+4PeSj5HNKMekywUcbRxlCQHAoNqiyyEBcorXwYgeRPtFWCD6dgpmrCV+uV09+A==
X-Gm-Gg: AYBFou0hA/TwQriXXnM1IPNrlu74uRiYV5DEf/2SgKrtyZ9FSkwPhLnXndrztr5jJE7
 kYo02H9O4TEGCu2Ypz1RJxdwUnZBnxLspFUqGDaQzgXZNuCde28fql5ryTUl2/pAu8LPvCQtwgp
 U5aeRISPb7LNDniXlzOb9j4LhtSXRNhles7B5IzB1PqLquNVidBM0xKyBIlBK0lxhDfysMAFHpC
 euvvfXc8ab/KUb0mAD75NzIBwpGu7F2QsFmsDOZA/QhYkK2ovGgmdkqyyoKfVIparZ2sL6A7WUu
 QX+Yk7kI+Re5oHZT8OaI5Ov5sTxxGMVoOyu6Jz8xQUDt1DdeiPiSH2E5u7OinzDXgKBHlSaHwWh
 a7WbZz2y/Mh7pOtMe2zNmXFt+H170yMiVcXmLkgrZ4ZVmdJKE+70Be8vuHp29opn3QWIN6zmhOV
 7UJXTZX8YaexPnaelR60LthwoFt+bnBUhv5ptkgbQbbUo9IIfkGJEe2oFJZbx3EaBF8/O5ujrh7
 uM+c4s=
X-Received: by 2002:a05:7301:a0a:b0:36c:a1bc:6114 with SMTP id
 5a478bee46e88-3796038259fmr2345822eec.0.1794556804244; 
 Fri, 13 Nov 2026 00:00:04 -0800 (PST)
X-Received: by 2002:a05:7301:a0a:b0:36c:a1bc:6114 with SMTP id
 5a478bee46e88-3796038259fmr2345775eec.0.1794556803519; 
 Fri, 13 Nov 2026 00:00:03 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378c2fesm5213376eec.1.2026.11.12.23.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:00:03 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v16 10/10] tests/functional: add initial RPMI virt guest smoke
Date: Fri, 13 Nov 2026 13:29:05 +0530
Message-ID: <20261113075906.715870-11-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113075906.715870-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261113075906.715870-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af6c385 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8
 a=tZD6s3AVAAAA:8 a=EUspDBNiAAAA:8 a=90goSig_s_BKn4pKddUA:9 a=O8hF6Hzn-FEA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=DklORoM8RNzucgFJxVk_:22
X-Proofpoint-ORIG-GUID: aPPXiisvrdpPvJciZom3AGDIR7NE4hdu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX/03m4SestG+X
 45Fob72kSdcQAzHWuT4VNDETRf5CutqGJKmd8S+T+XmRZDGAhiVm2bl4zJAREoTK9bA643CQWLk
 q1CpbXFRzwwPTq1lSmMYOV85kCc4DlgwTcLzyk5t8VNy7BpUHrUjEs9u/FnMmyJLS5fvT9Sz56G
 8lzuhZLni0UrsBADp/tawjRO0cUAte0BbYwiU2Nw8kLQ0dbWJE8TSOzxDIhakKcJefB31j8J0/c
 i3EkI/Vu6wk++t255+MxyPjD5xFxwEyBVJURe/gNuFmDc05laj9JUhU4F/pI+aquvliw6Qp3T7z
 pcj6bIrzEL8T24Kn5QxPxa2xNelAW7ZD735NuVxXFOduNutS3wp9XPyb+Rhef6qG9B4ysmf0KXF
 LnhL4D387fwOLUfAe0uey+eWKQJY+CDKGB+atrNbl+3n4cN24Yc0LKGd6qgHwtcANtFDaVcQLRY
 OpAYwMvIIqvLqoS25UQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX/z3YJfmflr+o
 8rJeThOv7LcPhItiA3138V8qhA0bYXkCG0dP/SN8x9f771HfIyzgOPfilb/Hqy8ExwZBWUDykcR
 HKistpYdFj1oPtQJZiWM/H5F5KkraQg=
X-Proofpoint-GUID: aPPXiisvrdpPvJciZom3AGDIR7NE4hdu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Boot an RPMI-enabled RISC-V virt guest and exercise the initial HSM,
system suspend, and system reset paths.

Require completed CPU offline and online transitions for HSM stop/start,
repeat the cycle, and stop a hart running a busy workload. Reboot while a
secondary hart remains stopped, verify the next boot restores both harts,
and repeat HSM control afterward. Also cover HSM stop/start immediately
after suspend/wakeup and a fresh suspend cycle after reboot.

Reject definitive OpenSBI HSM failure diagnostics instead of accepting a
shell marker that only appeared in the echoed command.

Linux can report CPU death before firmware reaches STOPPED. Bound retries
of the subsequent online request, retain transient errors in the console,
and require a completed online transition rather than assuming that an
offline sysfs mask proves immediate firmware stop completion.

Allow transient RPMI_ERR_DENIED diagnostics after a successful stop when
the subsequent start completes. Keep stop-only checks and fatal stop
diagnostics strict.

Keep the suite bounded by Meson's 420-second timeout. Fail immediately on
the suspend failure marker, and split that marker in the shell command
so echoed input cannot trigger it.

Use pinned kernel/rootfs assets with optional local overrides, clean up
setup failures, and escape commas in overlay filenames. The pinned
rootfs has Python but no taskset; pin the busy worker with Python's
sched_setaffinity and require liveness and CPU1 affinity before stopping
the hart.

Provision pinned librpmi and RPMI-capable OpenSBI firmware in CI.
Build QEMU with RPMI explicitly enabled and require all six
guest cases to pass without skips.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 .gitlab-ci.d/buildtest.yml                 |  58 ++++
 scripts/ci/build-rpmi-deps.sh              |  49 ++++
 scripts/ci/check-rpmi-guests.py            |  36 +++
 tests/functional/riscv64/meson.build       |   2 +
 tests/functional/riscv64/test_rpmi_virt.py | 310 +++++++++++++++++++++
 5 files changed, 455 insertions(+)
 create mode 100644 scripts/ci/build-rpmi-deps.sh
 create mode 100644 scripts/ci/check-rpmi-guests.py
 create mode 100644 tests/functional/riscv64/test_rpmi_virt.py

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index b1e95395d0..7ed7b9a19c 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -92,6 +92,64 @@ functional-system-debian:
     IMAGE: debian
     MAKE_CHECK_ARGS: check-functional
 
+build-rpmi-opensbi:
+  extends: .base_job_template
+  stage: build
+  image: $CI_REGISTRY_IMAGE/qemu/debian-riscv64-cross:$QEMU_CI_CONTAINER_TAG
+  needs:
+    - job: riscv64-debian-cross-container
+  script:
+    - sh scripts/ci/build-rpmi-deps.sh opensbi "$CI_PROJECT_DIR/rpmi-deps"
+  artifacts:
+    expire_in: 2 days
+    paths:
+      - rpmi-deps/opensbi-build/platform/generic/firmware/fw_jump.bin
+
+build-system-rpmi:
+  extends:
+    - .native_build_job_template
+    - .native_build_artifact_template
+  needs:
+    - job: amd64-debian-container
+  variables:
+    IMAGE: debian
+    TARGETS: riscv64-softmmu
+    CONFIGURE_ARGS: --enable-librpmi
+    MAKE_CHECK_ARGS: check-build
+  before_script:
+    - !reference [.base_meson_job_template, before_script]
+    - sh scripts/ci/build-rpmi-deps.sh librpmi "$CI_PROJECT_DIR/rpmi-deps"
+    - export PKG_CONFIG_PATH="$CI_PROJECT_DIR/rpmi-deps/librpmi-install/lib/pkgconfig"
+    - export LD_LIBRARY_PATH="$CI_PROJECT_DIR/rpmi-deps/librpmi-install/lib"
+  artifacts:
+    paths:
+      - build
+      - rpmi-deps/librpmi-install
+      - .git-submodule-status
+      - ci-runner-env
+
+functional-system-rpmi:
+  extends: .functional_test_job_template
+  needs:
+    - job: build-system-rpmi
+      artifacts: true
+    - job: build-rpmi-opensbi
+      artifacts: true
+  variables:
+    IMAGE: debian
+  before_script:
+    - !reference [.functional_test_job_template, before_script]
+    - export QEMU_TEST_RPMI_OPENSBI="$CI_PROJECT_DIR/rpmi-deps/opensbi-build/platform/generic/firmware/fw_jump.bin"
+    - export LD_LIBRARY_PATH="$CI_PROJECT_DIR/rpmi-deps/librpmi-install/lib"
+  script:
+    - cd build
+    - pyvenv/bin/meson test --no-rebuild --print-errorlogs
+        --logbase rpmi-qtest qemu:qtest-riscv64/riscv-rpmi-test
+    - pyvenv/bin/meson test --no-rebuild --print-errorlogs
+        --logbase rpmi-guests --suite qemu:func-riscv64-thorough
+        qemu:func-riscv64-rpmi_virt
+    - python3 ../scripts/ci/check-rpmi-guests.py meson-logs/rpmi-guests.json
+
 crash-test-debian:
   extends: .native_test_job_template
   needs:
diff --git a/scripts/ci/build-rpmi-deps.sh b/scripts/ci/build-rpmi-deps.sh
new file mode 100644
index 0000000000..dcf76b7523
--- /dev/null
+++ b/scripts/ci/build-rpmi-deps.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -eu
+
+if [ "$#" -ne 2 ]; then
+    echo "Usage: $0 opensbi|librpmi OUTPUT_DIRECTORY" >&2
+    exit 1
+fi
+
+dependency=$1
+output=$(realpath -m "$2")
+case "$dependency" in
+    opensbi)
+        repository=https://github.com/riscv-software-src/opensbi.git
+        revision=2aed4ec24f5d85312e528d2a40d7009800d55aeb
+        ;;
+    librpmi)
+        repository=https://github.com/riscv-software-src/librpmi.git
+        revision=fbe6f0594925d304147638d943228bea3e91bd62
+        ;;
+    *)
+        echo "Unknown RPMI dependency: $dependency" >&2
+        exit 1
+        ;;
+esac
+
+source=$output/$dependency
+if [ ! -e "$source/.git" ]; then
+    git init "$source"
+    git -C "$source" fetch --depth 1 "$repository" "$revision"
+    git -C "$source" checkout --detach FETCH_HEAD
+fi
+test "$(git -C "$source" rev-parse HEAD)" = "$revision"
+git -C "$source" diff --quiet HEAD
+
+if [ "$dependency" = opensbi ]; then
+    make -C "$source" -j"${JOBS:-2}" PLATFORM=generic \
+        CROSS_COMPILE=riscv64-linux-gnu- O="$output/opensbi-build"
+    firmware=$output/opensbi-build/platform/generic/firmware/fw_jump.bin
+    test -s "$firmware"
+    sha256sum "$firmware"
+else
+    make -C "$source" -j"${JOBS:-2}" CROSS_COMPILE= CC=cc \
+        O="$output/librpmi-build" I="$output/librpmi-install" install
+    # The pinned library emits /usr even with a separate installation root.
+    sed -i "s|^prefix=/usr$|prefix=$output/librpmi-install|" \
+        "$output/librpmi-install/lib/pkgconfig/librpmi.pc"
+fi
diff --git a/scripts/ci/check-rpmi-guests.py b/scripts/ci/check-rpmi-guests.py
new file mode 100644
index 0000000000..0f87f0e9e1
--- /dev/null
+++ b/scripts/ci/check-rpmi-guests.py
@@ -0,0 +1,36 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+"""Require the RPMI functional suite to execute six guests without skips."""
+
+import json
+from pathlib import Path
+import re
+import sys
+
+
+def check_results(path):
+    records = [json.loads(line) for line in path.read_text().splitlines()
+               if line.strip()]
+    if len(records) != 1:
+        raise ValueError('expected one RPMI guest suite result')
+    result = records[0]
+    output = result['stdout']
+    passed = re.findall(r'^ok ([0-9]+) ', output, re.MULTILINE)
+    if ('qemu:func-riscv64-rpmi_virt' not in result['name'] or
+            result['result'] != 'OK' or result['returncode'] != 0 or
+            passed != [str(number) for number in range(1, 7)] or
+            re.findall(r'^1\.\.([0-9]+)$', output, re.MULTILINE) != ['6'] or
+            re.search(r'#\s*skip\b|^not ok ', output,
+                      re.IGNORECASE | re.MULTILINE)):
+        raise ValueError('RPMI guest suite must pass six tests without skips')
+
+
+if __name__ == '__main__':
+    if len(sys.argv) != 2:
+        sys.exit('Usage: check-rpmi-guests.py MESON_RESULT_JSON')
+    try:
+        check_results(Path(sys.argv[1]))
+    except (OSError, ValueError, KeyError, TypeError) as error:
+        sys.exit(str(error))
+    print('RPMI guest suite: six passes, zero skips')
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index 211ea9acfc..b7c2a29ead 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -5,6 +5,7 @@ test_riscv64_timeouts = {
   'k230' : 120,
   'server_ref' : 120,
   'tuxrun' : 120,
+  'rpmi_virt' : 420,
 }
 
 tests_riscv64_system_quick = [
@@ -21,4 +22,5 @@ tests_riscv64_system_thorough = [
   'tt_atlantis',
   'tuxrun',
   'milkv_duo',
+  'rpmi_virt',
 ]
diff --git a/tests/functional/riscv64/test_rpmi_virt.py b/tests/functional/riscv64/test_rpmi_virt.py
new file mode 100644
index 0000000000..0b349a1803
--- /dev/null
+++ b/tests/functional/riscv64/test_rpmi_virt.py
@@ -0,0 +1,310 @@
+#!/usr/bin/env python3
+#
+# RISC-V virt RPMI Linux guest integration tests
+#
+# Copyright (c) 2026 Qualcomm Technologies, Inc.
+#
+# Author:
+#  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+from pathlib import Path
+import subprocess
+
+from qemu_test import Asset, QemuBaseTest, QemuSystemTest
+from qemu_test import exec_command
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import get_qemu_img
+from qemu_test import wait_for_console_pattern
+
+
+class RiscvVirtRpmiGuestTest(QemuSystemTest):
+    """Boot Linux and exercise RPMI-backed services through guest APIs.
+
+    Supply RPMI-capable OpenSBI firmware. Kernel and rootfs overrides are
+    optional; otherwise the pinned TuxRun assets are downloaded. Set:
+
+      QEMU_TEST_RPMI_OPENSBI=/path/to/fw_jump.bin
+      QEMU_TEST_RPMI_KERNEL=/path/to/Image
+      QEMU_TEST_RPMI_ROOTFS=/path/to/rootfs.ext4
+
+    Exact RPMI packet command-ID coverage remains in riscv-rpmi qtests. This
+    functional test verifies Linux/OpenSBI integration paths visible from a
+    real guest without adding probe hooks to production RPMI sources.
+    """
+
+    ASSET_KERNEL = Asset(
+        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
+    ASSET_ROOTFS = Asset(
+        'https://storage.tuxboot.com/buildroot/20241119/riscv64/rootfs.ext4.zst',
+        'aa4736a9872651dfc0d95e709465eedf1134fd19d42b8cb305bfd776f9801004')
+    PROMPT = 'root@tuxtest:~#'
+
+    def _require_path(self, env_name, required=True):
+        value = os.getenv(env_name)
+        if not value:
+            if not required:
+                return None
+            self.skipTest(f'{env_name} is required')
+        path = Path(value)
+        if not path.is_file():
+            self.skipTest(f'{env_name} does not exist: {path}')
+        return path
+
+    def assets_available(self):
+        return ((self.kernel is not None or self.ASSET_KERNEL.available()) and
+                (self.rootfs is not None or self.ASSET_ROOTFS.available()))
+
+    def setUp(self):
+        self.opensbi = self._require_path('QEMU_TEST_RPMI_OPENSBI')
+        self.kernel = self._require_path('QEMU_TEST_RPMI_KERNEL',
+                                         required=False)
+        self.rootfs = self._require_path('QEMU_TEST_RPMI_ROOTFS',
+                                         required=False)
+        try:
+            super().setUp()
+            self.qemu_img = get_qemu_img(self)
+            if self.kernel is None:
+                self.kernel = self.ASSET_KERNEL.fetch()
+            if self.rootfs is None:
+                self.rootfs = self.uncompress(self.ASSET_ROOTFS)
+        except BaseException:
+            if hasattr(self, '_console_log_fh'):
+                super().tearDown()
+            elif hasattr(self, '_log_fh'):
+                QemuBaseTest.tearDown(self)
+            raise
+
+    def _create_rootfs_overlay(self):
+        overlay = Path(self.scratch_file('rootfs.qcow2'))
+        subprocess.run([
+            self.qemu_img, 'create', '-q', '-f', 'qcow2', '-F', 'raw',
+            '-b', str(self.rootfs), str(overlay),
+        ], check=True)
+        return overlay
+
+    def _boot_guest(self, smp=4):
+        self.set_machine('virt')
+        self.machine = 'virt,rpmi=on,aia=aplic-imsic'
+        rootfs_overlay = self._create_rootfs_overlay()
+        rootfs_filename = str(rootfs_overlay).replace(",", ",,")
+
+        self.vm.set_console()
+        self.vm.add_args(
+            '-cpu', 'rv64',
+            '-smp', str(smp),
+            '-m', '1G',
+            '-bios', str(self.opensbi),
+            '-kernel', str(self.kernel),
+            '-append', 'printk.time=0 root=/dev/vda rw console=ttyS0 '
+                       'earlycon=sbi loglevel=8 no_console_suspend',
+            '-blockdev', 'driver=qcow2,file.driver=file,'
+                         f'file.filename={rootfs_filename}'
+                         ',node-name=hd0',
+            '-device', 'virtio-blk-device,drive=hd0',
+        )
+        self.vm.launch()
+
+    def _expect_rpmi_firmware_and_linux(self):
+        patterns = [
+            'Platform HSM Device         : rpmi-hsm',
+            'Platform Reboot Device      : rpmi-system-reset',
+            'Platform Shutdown Device    : rpmi-system-reset',
+            'Platform Suspend Device     : rpmi-system-suspend',
+            'Standard SBI Extensions',
+            'susp',
+            'tuxtest login:',
+        ]
+        for pattern in patterns:
+            wait_for_console_pattern(self, pattern)
+        exec_command_and_wait_for_pattern(self, 'root', self.PROMPT)
+
+    def _run_marker_command(self, command, marker, failure_marker=None):
+        out = exec_command_and_wait_for_pattern(self, command, marker,
+                                                failure_message=failure_marker)
+        self.assertIn(marker.encode(), out)
+        return out
+
+    @staticmethod
+    def _marker(marker):
+        """Build a marker without putting the complete token in echoed input."""
+        prefix, suffix = marker.rsplit('_', 1)
+        return "printf '%%s_%%s\\n' %s %s" % (prefix, suffix)
+
+    def _assert_no_hsm_stop_failure(self, output, start_retry=False):
+        # OpenSBI may report STOP_PENDING before its state reaches STOPPED.
+        # CPU offline and a successful later HART_START prove the cycle.
+        for diagnostic in ('ERR: Failed stop hart', 'Unable to stop the cpu'):
+            self.assertNotIn(diagnostic.encode(), output,
+                             'OpenSBI reported an HSM stop failure: '
+                             f'{diagnostic}')
+        if start_retry:
+            # Only start retries after a successful stop may report DENIED.
+            output = output.partition(b'RPMI_LINUX_HSM_STOP_PASS')[0]
+        self.assertNotIn(b'RPMI_ERR_DENIED', output)
+
+    def _validate_hsm_boot_start(self, online_cpus):
+        self._run_marker_command(
+            'echo RPMI_LINUX_HSM_START_BEGIN; '
+            'cat /sys/devices/system/cpu/present; '
+            'online=$(cat /sys/devices/system/cpu/online); '
+            'echo "$online"; '
+            f'if [ "$online" = "{online_cpus}" ]; '
+            f'then {self._marker("RPMI_LINUX_HSM_START_PASS")}; '
+            f'else {self._marker("RPMI_LINUX_HSM_START_FAIL")}; fi',
+            'RPMI_LINUX_HSM_START_PASS', 'RPMI_LINUX_HSM_START_FAIL')
+
+    def _validate_fdt_service_layout(self):
+        self._run_marker_command(
+            'base=/sys/firmware/devicetree/base/soc; '
+            'if [ -d "$base/sysreset" ] && '
+            '[ -d "$base/hsm" ] && [ -d "$base/suspend" ] && '
+            '[ ! -d "$base/mailbox@10200000/sysreset" ] && '
+            '[ ! -d "$base/mailbox@10200000/hsm" ] && '
+            '[ ! -d "$base/mailbox@10200000/suspend" ]; then '
+            f'{self._marker("RPMI_FDT_SERVICE_SIBLINGS_PASS")}; '
+            f'else {self._marker("RPMI_FDT_SERVICE_SIBLINGS_FAIL")}; fi',
+            'RPMI_FDT_SERVICE_SIBLINGS_PASS',
+            'RPMI_FDT_SERVICE_SIBLINGS_FAIL')
+
+    def _validate_hsm_stop_start(self):
+        command = (
+            'echo RPMI_LINUX_HSM_STOP_BEGIN; '
+            'if [ -w /sys/devices/system/cpu/cpu1/online ]; then '
+            'echo 0 > /sys/devices/system/cpu/cpu1/online && '
+            '[ "$(cat /sys/devices/system/cpu/online)" = 0 ] && '
+            f'{self._marker("RPMI_LINUX_HSM_STOP_PASS")} && '
+            # Linux reports CPU death before firmware has necessarily stopped
+            # the hart. Preserve transient start errors, but bound the wait.
+            '(attempt=0; until echo 1 > /sys/devices/system/cpu/cpu1/online; '
+            'do attempt=$((attempt + 1)); '
+            'printf "HSM start retry %s\\n" "$attempt"; '
+            '[ "$attempt" -lt 50 ] || exit 1; sleep 0.1; done) && '
+            '[ "$(cat /sys/devices/system/cpu/online)" = 0-1 ] && '
+            f'{self._marker("RPMI_LINUX_HSM_START_PASS")} || '
+            f'{self._marker("RPMI_LINUX_HSM_STOP_FAIL")}; '
+            f'else {self._marker("RPMI_LINUX_HSM_STOP_FAIL")}; fi; '
+            'sleep 1; '
+            f'{self._marker("RPMI_LINUX_HSM_STOP_DONE")}')
+        out = exec_command_and_wait_for_pattern(
+            self, command, 'RPMI_LINUX_HSM_STOP_DONE',
+            failure_message='RPMI_LINUX_HSM_STOP_FAIL')
+        self.assertIn(b'RPMI_LINUX_HSM_STOP_PASS', out)
+        self.assertIn(b'RPMI_LINUX_HSM_START_PASS', out)
+        self._assert_no_hsm_stop_failure(out, start_retry=True)
+
+    def _validate_hsm_stop(self):
+        command = (
+            'echo RPMI_LINUX_HSM_STOP_BEGIN; '
+            'if [ -w /sys/devices/system/cpu/cpu1/online ] && '
+            'echo 0 > /sys/devices/system/cpu/cpu1/online && '
+            'sleep 1 && '
+            '[ "$(cat /sys/devices/system/cpu/online)" = 0 ]; then '
+            f'{self._marker("RPMI_LINUX_HSM_STOP_PASS")}; '
+            f'else {self._marker("RPMI_LINUX_HSM_STOP_FAIL")}; fi')
+        out = exec_command_and_wait_for_pattern(
+            self, command, 'RPMI_LINUX_HSM_STOP_PASS',
+            failure_message='RPMI_LINUX_HSM_STOP_FAIL')
+        self._assert_no_hsm_stop_failure(out)
+
+    def _validate_system_suspend(self):
+        exec_command(
+            self,
+            'echo RPMI_LINUX_SUSPEND_BEGIN; '
+            'if grep -qw mem /sys/power/state; then '
+            'echo mem > /sys/power/state; '
+            f'else {self._marker("RPMI_LINUX_SUSPEND_FAIL")}; fi')
+        wait_for_console_pattern(self, 'RPMI_LINUX_SUSPEND_BEGIN')
+        wait_for_console_pattern(
+            self, 'PM: suspend entry', 'RPMI_LINUX_SUSPEND_FAIL')
+        self.vm.event_wait('SUSPEND', 10)
+        self.vm.qmp('system_wakeup')
+        self.vm.event_wait('WAKEUP', 10)
+        wait_for_console_pattern(self, 'PM: suspend exit')
+        # The resumed shell prompt and suspend-exit message can share a line.
+        # Send an empty command so the console always produces a fresh prompt.
+        exec_command_and_wait_for_pattern(self, '', self.PROMPT)
+        self._run_marker_command(
+            'marker=RPMI_LINUX_WAKEUP; echo ${marker}_PASS',
+            'RPMI_LINUX_WAKEUP_PASS')
+
+    def _validate_reset_poweroff(self):
+        exec_command(self, 'echo RPMI_LINUX_RESET_POWEROFF_BEGIN; poweroff -f')
+        wait_for_console_pattern(self, 'RPMI_LINUX_RESET_POWEROFF_BEGIN')
+        wait_for_console_pattern(self, 'reboot: Power down')
+        self.vm.wait()
+
+    def _validate_reset_reboot(self):
+        exec_command(self, 'echo RPMI_LINUX_RESET_REBOOT_BEGIN; reboot -f')
+        wait_for_console_pattern(self, 'RPMI_LINUX_RESET_REBOOT_BEGIN')
+        wait_for_console_pattern(self, 'reboot: Restarting system')
+        wait_for_console_pattern(self, 'OpenSBI')
+
+    def test_linux_guest_service_enumeration(self):
+        self._boot_guest(smp=4)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_fdt_service_layout()
+        self._validate_hsm_boot_start('0-3')
+
+    def test_linux_guest_hsm_stop(self):
+        self._boot_guest(smp=2)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_hsm_boot_start('0-1')
+        for _ in range(3):
+            self._validate_hsm_stop_start()
+        # The pinned rootfs provides Python, but not taskset.
+        self._run_marker_command(
+            "python3 -c 'import os; os.sched_setaffinity(0, {1}); "
+            'exec("while True: pass")'
+            "' & echo $! > "
+            "/tmp/rpmi-hsm-worker; "
+            'worker=$(cat /tmp/rpmi-hsm-worker); '
+            'attempt=0; while kill -0 "$worker" && '
+            '[ "$(awk \'/Cpus_allowed_list:/ {print $2}\' '
+            '/proc/"$worker"/status)" != 1 ] && '
+            '[ "$attempt" -lt 50 ]; do '
+            'attempt=$((attempt + 1)); sleep 0.1; done; '
+            'if kill -0 "$worker" && '
+            '[ "$(awk \'/Cpus_allowed_list:/ {print $2}\' '
+            '/proc/"$worker"/status)" = 1 ]; then '
+            f'{self._marker("RPMI_HSM_WORKER_PASS")}; '
+            f'else {self._marker("RPMI_HSM_WORKER_FAIL")}; fi',
+            'RPMI_HSM_WORKER_PASS', 'RPMI_HSM_WORKER_FAIL')
+        self._validate_hsm_stop_start()
+        exec_command(self, 'kill $(cat /tmp/rpmi-hsm-worker) 2>/dev/null || :')
+
+    def test_linux_guest_hsm_stopped_reset(self):
+        self._boot_guest(smp=2)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_hsm_boot_start('0-1')
+        self._validate_hsm_stop()
+        self._validate_reset_reboot()
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_hsm_boot_start('0-1')
+        self._validate_hsm_stop_start()
+
+    def test_linux_guest_suspend(self):
+        self._boot_guest(smp=2)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_system_suspend()
+        self._validate_hsm_stop_start()
+
+    def test_linux_guest_reset_poweroff(self):
+        self._boot_guest(smp=1)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_reset_poweroff()
+
+    def test_linux_guest_reset_reboot(self):
+        self._boot_guest(smp=1)
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_reset_reboot()
+        self._expect_rpmi_firmware_and_linux()
+        self._validate_hsm_boot_start('0')
+        self._validate_system_suspend()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()

