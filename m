Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39235C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjP8w-0005yc-Kq; Mon, 13 Jul 2026 18:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjP8v-0005yU-Ba
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:28:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjP8t-0001gR-62
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:28:53 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9OpM2409448
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Epo8cKiAmE65C6PjDODBwgCz2pXhweVECtk7sly3kNk=; b=ESK3/q5lWa6myz09
 yWnP7bJA/QRbauVYXIM0R52kqu9QQ84bXRsqRAdF4ElXcMHdzAnTiYaaKON7moSf
 QzfxyMyEvMIgVTFp/msKYPf8prNscb9zPhhkXs/h2e25OZ9PZhGYMhxS3Vhqv+9c
 EzpJt0lAtTbCTN7k7VfDBWM6fkpDvJ4gr744iWyvHYCvBdxvhXBka3SLGTobEGHJ
 ojz0XUEA90mGsKm5uaDys3PksCqtJpj+6QchxYZuMKD0m5wa40bOITb42fPlQUpJ
 /2T7+x7XSMn3vhHjKyCh1bL5lWD9sgHuF9nPOKbNwAgJ0f0S9gT9D2WhS/0xaqtv
 EspnNA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcuj03c8b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:28:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-caf5fa127d4so480388a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783981729; x=1784586529; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Epo8cKiAmE65C6PjDODBwgCz2pXhweVECtk7sly3kNk=;
 b=chDfCiYmmr7Bd8Qs3Dnofg1NfeMLUa8x/Ab85ZpxITUq6s9/i07DWYAicCd5/f3EWh
 xd9yJNyoGbqg/0RQSfrWjFo09SDngx26SMCvSy9Wy2hyOTB3WLvL1yl+2CabnqifNlTN
 AkEeGQmflWRF2/b7C80sIlGSJceNVbT6UMUnXetALqVWBT3HEo9cGAYhSTUDlo0lmcIj
 L1fqgBws8FLHx2NWfjTW39PXiqP4ZLcY8tR51WgaM2dIy6tVTmzsE41tLoFpRPN5WZl3
 n2o9LfYd/+IJiTxI0F3IRkRzRc9pkOuswgwUkoD1CQpBEI2ehqRT1SvcdoIB8t/nGv3C
 jxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783981729; x=1784586529;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Epo8cKiAmE65C6PjDODBwgCz2pXhweVECtk7sly3kNk=;
 b=G5nCyX5r3sFFUTg2mGmu5EY7L2iUxi2xlD+bZocOmQoVLOTiXhf+AUm7hBcLYj8/68
 /CwnGJP1rB/EEKEFQjyYGkdbh7asjeJLhL5FDp+MMCIFHthsRLwH2puZjjnSb9nfhokQ
 DnHOD1XHm5w8mggxKxk2GIuuyDJMmdo2+KCuQN7DiUqsvGzgcN/WkMx5bNL8sDU75l6x
 VwrBl+dXUyAc++3vqavun1mvW5YWYc2/Mi3qm50C57gcZtids2RPpCKDS/x8cqzwJ6Jo
 ZfLyB65DiS7GZmsptpu93YaLrJpkTJGC964Z4fQFWJjR+WWDKMxIBhNn9s3op6xJYNm7
 jqaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUJoX8aA1d84f+3idIIG8vfNhKW8QZrolN6pEdrG5skj6lu8f018wB/yzWwlFTC7tht0KFvDEkt9Vr@nongnu.org
X-Gm-Message-State: AOJu0Yyqg9SB5YNN4v0bjzG3PBFCfQbVmNNuQ7OcwWE1GS6M+jQCO+Wn
 rM6WZ4ooA+bp+iY3TbndjZA38vXh4Wy+cXL+v5lWRS0QsWwkr/dWV4dRHtXtm2yRp+I9f5yJb7u
 Lmje493mSGGER7NcXGNTy9G4IJ8DG7YcixTRCr7aHFwE6nIra1U6n2XN0Mg==
X-Gm-Gg: AfdE7cngI7unx7E2aQHXpTSo3Sy6AqUbxlVXfBzGM8fS/qjaJVhVLhjG9K1MIVoXjSF
 rdyAHP4hJZ1WhRB67ZmSbwaR3J/Eip4NUix6lDTy2TFJdrNqYuuZj3SOkqlhQ7EbUFTuQYnT4+m
 ZZos6Z5/8TC31g0m9pLhlf3IW3uitfRk7yFOpRbCSJf6VdU6VfarMEiV3RvSTTDNcLWtYKqJS+s
 VCCoWlwPXSMis2BbeSP+59mI6o3K8vqQbAxhJcCp+mcEqYh6h5XUw/xkulnkZmjgZNnVY6VJ+GA
 6v8KHgdngGP4G/1mvqSvfUCzx2Zze5oCtPuG/xuOpQ2aEPSDtKk3OJcnoYudRMLoYX6rToLOV8V
 o1Jw+ifM2GrbeEaEMs/OUAaiklejbFDoD/Teg9kZwZqYBP87e7A9+uvor91OcO9QtHGRspkk4EJ
 9nErE=
X-Received: by 2002:a05:6a21:1b81:b0:3b4:93b9:2b91 with SMTP id
 adf61e73a8af0-3c110009b82mr11778980637.12.1783981728926; 
 Mon, 13 Jul 2026 15:28:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:1b81:b0:3b4:93b9:2b91 with SMTP id
 adf61e73a8af0-3c110009b82mr11778947637.12.1783981728473; 
 Mon, 13 Jul 2026 15:28:48 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117d847e17sm73244507eec.18.2026.07.13.15.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 15:28:47 -0700 (PDT)
Message-ID: <c80dd868-f943-4bd2-828a-4a81cc6a59c4@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:28:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] tests/functional: Add hexagon semihosting systests
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <da280da8fec576b2cc59e7bf48a2845312ee50cc.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <da280da8fec576b2cc59e7bf48a2845312ee50cc.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIzMSBTYWx0ZWRfX+a2XNuA7Ln4n
 JfNMgXA+QXz1ExedCYvSBhjyGv0HnJn8yFFMgXzkrlNO9JxNMO3mZYOaIKjaINcqgW6L+xIcB+Q
 ithomfbEcQpWX/uuCfEJ5Vdx7FxQgBI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIzMSBTYWx0ZWRfX59T5xO0tp6/j
 WLGgmU7QCQhGUYlNwO+Aojb8UDqZ2lnU0NpnYSjWwpm02KsvRBhNpulhxZVHQpSaYiHA7sv/gb6
 PJhq1hq4nYRNBJ/CXZfCfkhE/cs5sVR/rBIxhqneQ401JjanQxYsGXbGfal5AaCxojuZCLLREK0
 9UDQycaJ5gIR3KV68gOXWhxGbtoMpDxkYkD3OWuEb3dJkMfYMFOOSyoP59YUtMQun8D0z5mfyfv
 bsbvxt0YHquSL3P5Dc3uWxScrXJaUYB3yQBQsvRF1G9j2UkiXawPzDfQJ8ha0JCgtAB2jQeaqTM
 MC60uCVTofQaJpkLFKPm1MicAfz8eAga6TOmKaw/GXpoGylCa8YB8kholBUzIrNYNgcsEgENWxO
 swx3XaokrzNlbsR3xvFMfbrqgWTerkYiNN1gefLheg01I+nCR48iN3R+EOZ/Jo/GRvUBH5ajanH
 KM7k0QfLt8ChvVSimnQ==
X-Proofpoint-ORIG-GUID: c8x61cIZ2zfGI-S5tDwOm3lpaWuAlCGG
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a5566a1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=TN0qJJ1VG7o8IOI7uFcA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: c8x61cIZ2zfGI-S5tDwOm3lpaWuAlCGG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130231
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

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/meson.build      |   9 ++
>  tests/functional/hexagon/test_systests.py | 133 ++++++++++++++++++++++
>  tests/functional/meson.build              |   1 +
>  3 files changed, 143 insertions(+)
>  create mode 100644 tests/functional/hexagon/meson.build
>  create mode 100644 tests/functional/hexagon/test_systests.py
> 
> diff --git a/tests/functional/hexagon/meson.build b/tests/functional/hexagon/meson.build
> new file mode 100644
> index 00000000000..6cd684b0df7
> --- /dev/null
> +++ b/tests/functional/hexagon/meson.build
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +test_hexagon_timeouts = {
> +  'systests': 180,
> +}
> +
> +tests_hexagon_system_thorough = [
> +  'systests',
> +]
> diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/hexagon/test_systests.py
> new file mode 100644
> index 00000000000..b20b9fc56cc
> --- /dev/null
> +++ b/tests/functional/hexagon/test_systests.py
> @@ -0,0 +1,133 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright(c) Qualcomm Innovation Center, Inc. All Rights Reserved.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import re
> +import time
> +import unittest
> +
> +from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
> +
> +
> +_TARBALL_BIN_PATH = os.path.join(
> +    "systests_standalone_package",
> +    "StandaloneSysTests_6.4.0.2_v68",
> +    "bin",
> +)
> +
> +
> +class SysTestsStandaloneTests(QemuSystemTest):
> +    SYSTEST_TIMEOUT_SEC = 30
> +
> +    ASSET_TARBALL = Asset(
> +        "https://github.com/qualcomm/qemu-hexagon-testing/releases/download/v0.2.9/systests_standalone.tar.gz",
> +        "db961ea3fcc389b478b3d5c2f3bac60bec87e7f3d7efef5e58a9ae8ee78d0e40",
> +    )
> +
> +    def setUp(self):
> +        super().setUp()
> +        self.archive_extract(self.ASSET_TARBALL)
> +        self.bin_dir = os.path.join(self.workdir, _TARBALL_BIN_PATH)
> +        self._orig_cwd = os.getcwd()
> +        os.chdir(self.workdir)
> +        self.addCleanup(os.chdir, self._orig_cwd)
> +
> +    def tearDown(self):
> +        if hasattr(self, "_orig_cwd"):
> +            os.chdir(self._orig_cwd)
> +        super().tearDown()
> +
> +    def binary(self, name):
> +        """Return the full path to binary *name* inside bin_dir."""
> +        return os.path.join(self.bin_dir, name)
> +
> +    def run_exit_zero(self, binary_name, *extra_args, machine="V66G_1024"):
> +        """Launch *binary_name* and assert it exits with code 0.
> +
> +        :param binary_name: name of the binary inside bin_dir.
> +        :param extra_args: optional pairs of (flag, value) strings passed
> +            to set_vm_arg(), e.g. ('-append', 'myarg').
> +        :param machine: QEMU machine type (default "V66G_1024").
> +        """


We could check self.binary(binary_name) exists to provide a useful error
message.

> +        self.set_machine(machine)
> +        self.set_vm_arg("-display", "none")
> +        self.set_vm_arg("-kernel", self.binary(binary_name))
> +        for flag, value in zip(extra_args[::2], extra_args[1::2]):
> +            self.set_vm_arg(flag, value)
> +        self.vm.launch()
> +        self.vm.wait(timeout=60.0)
> +        self.assertEqual(self.vm.exitcode(), 0,
> +                         f"Test {binary_name} exited with "
> +                         f"code {self.vm.exitcode()}, expected 0")
> +
> +    def run_console_pattern(self, binary_name, pattern, *extra_args,
> +                            machine="V66G_1024"):
> +        """Launch *binary_name* and wait for *pattern* on the semihosting console.
> +
> +        :param binary_name: name of the binary inside bin_dir.
> +        :param pattern: string pattern to wait for via wait_for_console_pattern.
> +        :param extra_args: optional pairs of (flag, value) strings passed
> +            to set_vm_arg(), e.g. ('-append', 'myarg').
> +        :param machine: QEMU machine type (default "V66G_1024").
> +        """
> +        self.set_machine(machine)
> +        self.set_vm_arg("-display", "none")
> +        self.set_vm_arg("-kernel", self.binary(binary_name))
> +        for flag, value in zip(extra_args[::2], extra_args[1::2]):
> +            self.set_vm_arg(flag, value)
> +        self.vm.set_console(semihosting=True)
> +        self.vm.launch()
> +        try:
> +            wait_for_console_pattern(self, pattern)
> +        finally:
> +            self.vm.kill()
> +
> +    def test_fopen(self):
> +        """fopen reads a file passed via --append and verifies its contents."""
> +        with open(os.path.join(self.workdir, "dummy.so"), "w") as f:
> +            f.write("valid\n")
> +        self.run_exit_zero("fopen", "-append", "dummy.so")
> +
> +    def test_ftrunc(self):
> +        """ftrunc truncates _testfile_ftrunc from 6 bytes to 1 byte."""
> +        ftrunc_path = os.path.join(self.workdir, "_testfile_ftrunc")
> +        with open(ftrunc_path, "w") as f:
> +            f.write("valid\n")
> +        # Sleep 1 s so mtime change is observable
> +        time.sleep(1)
> +        self.run_exit_zero("ftrunc")
> +        self.assertEqual(
> +            os.path.getsize(ftrunc_path),
> +            1,
> +            "_testfile_ftrunc should be 1 byte after ftrunc",
> +        )
> +
> +    def test_dirent(self):
> +        """dirent lists a directory passed via --append; output must be
> +        '. .. fileA fileB'."""
> +        dirent_dir = os.path.join(self.workdir, "_dirent_testdir")
> +        os.makedirs(dirent_dir, exist_ok=True)
> +        open(os.path.join(dirent_dir, "fileA"), "w").close()
> +        open(os.path.join(dirent_dir, "fileB"), "w").close()
> +        self.run_console_pattern(
> +            "dirent", ". .. fileA fileB", "-append", "_dirent_testdir"
> +        )
> +
> +    def test_access(self):
> +        """access checks R_OK|W_OK on _testfile_access."""
> +        with open(os.path.join(self.workdir, "_testfile_access"), "w") as f:
> +            f.write("valid\n")
> +        self.run_exit_zero("access")
> +
> +    def test_semihost(self):
> +        semihost_dir = os.path.join(self.workdir, "_semihost_dir")
> +        os.makedirs(semihost_dir, exist_ok=True)
> +        open(os.path.join(semihost_dir, "fileA"), "w").close()
> +        open(os.path.join(semihost_dir, "fileB"), "w").close()
> +        self.run_console_pattern("semihost", "PASS", "-append", "arg1", "arg2")
> +
> +if __name__ == "__main__":
> +    QemuSystemTest.main()
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index c158197c4b7..c7362dd00ef 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -14,6 +14,7 @@ subdir('aarch64')
>  subdir('alpha')
>  subdir('arm')
>  subdir('avr')
> +subdir('hexagon')
>  subdir('hppa')
>  subdir('i386')
>  subdir('loongarch64')

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


