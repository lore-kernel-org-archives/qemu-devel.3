Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E30C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZYP6-0001EY-Cy; Thu, 01 Aug 2024 12:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYP4-0001CJ-1o
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:11:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYP1-0006CO-RK
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:11:45 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42816ca797fso42847855e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722528702; x=1723133502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IXOe2oCgMbv2tEutIjcK2r/oyREZzaqfz4sK7BVHm8o=;
 b=bi6zBywhi9dDAdNxLpkGYWSJMkoo1u01RFu8KHUhh4CCV3hjScG1WiXLAiTCjpxYna
 KxHJzbUp+d5VU7uAHgnjA2IMzDOOKvOS4qDROQWDFhB5O3SXCAGAalLXtrt6+/JjQPDG
 /SojT08UbpKJatP34VKeZDCN7zInCzfc/pbdCUuQ6SpNy0wmY3SbhIGUO/is8Mrm/ZuT
 2FbyhVNezxKkrtF7ZEFem5rwQKKzzpgohBWpKJCghvLa/wFuIgAhfI04N5HKx3GBw+KC
 Mypebxp4xq/S7usKS9vbEfQ8BzMs1lB9jnrV3uhCNSFuDlejp8BCDti+TIAi0KBQVW1O
 vmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722528702; x=1723133502;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IXOe2oCgMbv2tEutIjcK2r/oyREZzaqfz4sK7BVHm8o=;
 b=ppGDd+SWyPltTm4k0fkOnMbdWlgb2/slLaMAE3PI+2E+MlJ/DRito+42D9y1+eHBMx
 Et3MhHH0lHKiW5B29k7ZCD3ceOjSvKaQd8AEUog6UfeszdU2vFOifmhGnRuPMAQsVgLt
 40rGfTNu+dbB4N2FCSzTrvjwdxAlic1lUmSJ6HW1TYArvAzaI2jtRhUePzfvupmiK0zJ
 O5DCG+Z29+ZQXbdgEy8YMp1Oub0Ndo2Xw5Z94gKF+m3ewkOa+do8zQ/9gJoJp/qgLaTF
 B0EYqOBNowzfucJBmuxB3/SzGd3usr7lMmZ8lEhflEdnF/KLtQ45QJ9c2BYuowyMsBf/
 edxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHD13Ebu5tNTyy2QOwbhYcnR//GYYjqOsthi38MaG7L1RxcCPsNaf+gDCnv2ahp/9MRTTEi9ZHxPRTVAq1gdyYFpYOAJM=
X-Gm-Message-State: AOJu0YwnEB/3nxPPiKU8L2MltQJX2EgfcoDhpd1G5ejrLPBMy054hVck
 An0YatX6jWB9TLiUQuyXXzLP+fKLKLJWYpKiNRoXxdviTyKb0w0YhODNy94gKcU=
X-Google-Smtp-Source: AGHT+IF++jWCC8D+TNjqYV+2dx+rUV/+civnaubvAkU97Ez2imcm78Yf83WoG4u5RzNGKMBkVgMjcQ==
X-Received: by 2002:a05:600c:1987:b0:428:2502:75b5 with SMTP id
 5b1f17b1804b1-428e6afa2eemr2973985e9.11.1722528701904; 
 Thu, 01 Aug 2024 09:11:41 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb9d54esm62441235e9.43.2024.08.01.09.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 09:11:41 -0700 (PDT)
Message-ID: <7e690384-e357-488d-a4aa-a3e5da0bc109@linaro.org>
Date: Thu, 1 Aug 2024 18:11:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/24] tests/functional: Add base classes for the
 upcoming pytest-based tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-3-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The file is mostly a copy of the tests/avocado/avocado_qemu/__init__.py
> file with some adjustments to get rid of the Avocado dependencies (i.e.
> we also have to drop the LinuxSSHMixIn and LinuxTest for now).
> 
> The emulator binary and build directory are now passed via
> environment variables that will be set via meson.build later.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> [DB: split __init__.py into multiple files]
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/__init__.py |  13 ++
>   tests/functional/qemu_test/cmd.py      | 171 +++++++++++++++++++++++++
>   tests/functional/qemu_test/config.py   |  36 ++++++
>   tests/functional/qemu_test/testcase.py | 154 ++++++++++++++++++++++
>   4 files changed, 374 insertions(+)
>   create mode 100644 tests/functional/qemu_test/__init__.py
>   create mode 100644 tests/functional/qemu_test/cmd.py
>   create mode 100644 tests/functional/qemu_test/config.py
>   create mode 100644 tests/functional/qemu_test/testcase.py


> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> new file mode 100644
> index 0000000000..82cc1d454f
> --- /dev/null
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -0,0 +1,154 @@
> +# Test class and utilities for functional tests
> +#
> +# Copyright 2018, 2024 Red Hat, Inc.
> +#
> +# Original Author (Avocado-based tests):
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# Adaption for standalone version:
> +#  Thomas Huth <thuth@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import logging
> +import os
> +import pycotap
> +import sys
> +import unittest
> +import uuid
> +
> +from qemu.machine import QEMUMachine
> +from qemu.utils import kvm_available, tcg_available
> +
> +from .cmd import run_cmd
> +from .config import BUILD_DIR
> +
> +
> +class QemuBaseTest(unittest.TestCase):
> +
> +    qemu_bin = os.getenv('QEMU_TEST_QEMU_BINARY')
> +    arch = None
> +
> +    workdir = None
> +    log = logging.getLogger('qemu-test')
> +
> +    def setUp(self, bin_prefix):
> +        self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
> +        self.arch = self.qemu_bin.split('-')[-1]
> +
> +        self.workdir = os.path.join(BUILD_DIR, 'tests/functional', self.arch,
> +                                    self.id())
> +        if not os.path.exists(self.workdir):
> +            os.makedirs(self.workdir)
> +
> +    def main():

[*]

> +        tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
> +                                   test_output_log = pycotap.LogMode.LogToError)
> +        path = os.path.basename(sys.argv[0])[:-3]

Moving the 'path' line in [*] simplifies patch #9 (no duplication).

> +        unittest.main(module = None, testRunner = tr, argv=["__dummy__", path])


