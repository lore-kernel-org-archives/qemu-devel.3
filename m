Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58045CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6OO-0007hB-C9; Mon, 15 Sep 2025 06:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy6OJ-0007gV-5W
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:25:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy6OC-0008JC-66
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:24:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45df0cde41bso30755965e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757931883; x=1758536683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NnZ7HK41La3PWu2ZUpDu+1qHYEFqEXDMtmlq3v3OY0=;
 b=XmqWrnOgSieeOB7Qf93Gazyl6/JZD2DPQev9zV9L7yH9SOT/wuD1+3DUeg+nRIvDzx
 b+jilY2/zCQU+k1ls1k3RYrTJxyHD/dykQpNLGycXEy9K4pnqT05TTOukSsTg5Bgp2j7
 cR0pLp7D5jeh1O+TlO+3n5Z1gmLiC14NzIi7Ozzuayato/zdmyIE14J0Mfh5a1Nmphtq
 SqTxNutJ7cE9q2t9g+mti3kmCuwn0tlmgmFzvXIcgi0/lM3JAxf09+Tcnu7zSneiwnf1
 UkZcX1yUaz12BMNA54ggpceQAL2ay8txaZXRcopQAq6O5UTTLcd3cKRVEboPW/URlG/g
 tpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757931883; x=1758536683;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1NnZ7HK41La3PWu2ZUpDu+1qHYEFqEXDMtmlq3v3OY0=;
 b=SWf7FqH+657IFmGRg6Il8tBFwIz9HoVgzVSRxulsr6I0csSvcGVwq2uEcB/PBSKpht
 9EK98r3FppeEn3N+J00AH2HgAFTIBhz/R3chydf3x9MjWlcqrZRgLNbUGg/iD2VT7Dsl
 TyPB17onLlEWIKLLcizGNB+L3u6Pl0RT3bD3n+cGbVhh7zjOeve75UKU4s8QlO26E8ha
 iFAUcdp1nK91Jk5MRzNE1kyDg45fI5XOCmo74WgCO7HchHd2TxBUF3q9XJn5bPlUu7jV
 PAJfgbuNE2zu7x4Kp9PIuAQYTRmeSreKmrLPBeh7/x23Mjht6/nAOz/QRuuiKrWtq/rL
 sX9A==
X-Gm-Message-State: AOJu0Yz+8A/g3uExDVJnULpfrCKKbVO9nso+wpJE4pVFgM+5nsn0AB7Y
 9ee1eMU25l8KPbo3n+0NOzcEcKE4HyBpjn1VinT9ZMWyxcdT128VW3dHpZwXA6pA5hbXUvkrSgW
 f4sb3Ipk=
X-Gm-Gg: ASbGnctXwXH2S82BC+jGuOtOPONPG7hlqjlkmgqrFek8DhhPdamKcmBIYfviw6sj2nY
 9CyolMDs2T1e9NX/Qcsm/H6f1/q2iQRwH3No2P3SqsHOeCRdn+g7DNs1E7NZaKcr+kkiSzKklGD
 u834kRM994ymfsOpdvfLR0d01XwTKAjFjupd6b1OQ9qP0v5TEqFMMR5nVGdoLPuGlWfvDje70SH
 aTshvQwPjLPQ2avAXTlYCi3nep0+DxgtSgEnZzxaEeeiRqfM1wnsn7O8LOoyzN7gp8xAX9VT9Nf
 bMjJhJM0nkGPX4nQ/aCoecJlifMdNwOZuSKoZfWxO7ae6oQhMbXPdOppFxp1rA9onCIUKieNE9u
 6cPi+L4Z3CUxJU+ezKbuuERo=
X-Google-Smtp-Source: AGHT+IEJJm34jmJwfxG6Paoten8F54jjVBaWUC/Qk7K4eVcMqdfvv5X5SlUEutJKYAoRL3IrnARCyA==
X-Received: by 2002:a05:6000:2481:b0:3e7:5044:4fee with SMTP id
 ffacd0b85a97d-3e7658c0f2dmr10553479f8f.24.1757931882963; 
 Mon, 15 Sep 2025 03:24:42 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e98b439442sm6670527f8f.38.2025.09.15.03.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 03:24:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 82CCD5F867;
 Mon, 15 Sep 2025 11:24:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/6] tests/functional: remove last use of avocado.utils
In-Reply-To: <20250912182200.643909-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 12 Sep 2025 19:21:54
 +0100")
References: <20250912182200.643909-1-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 11:24:41 +0100
Message-ID: <87qzw8qahi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This simply imports the GDB code from avocado.utils to the QEMU
> functional test suite, and drops the other redundant avocado
> usage.

Missing patches include dropping the:

  @skipIfMissingImports('avocado.utils')

from the reverse tests.

With this done can we remove the remaining references to avocado?

  python/Makefile=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
  110:	@avocado --config avocado.cfg run tests/=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
  118:	@coverage run -m avocado --config avocado.cfg run tests/*.py=20
  python/README.rst
  73:- ``avocado.cfg`` Configuration for the Avocado test-runner.=20=20=20=
=20=20=20=20=20=20=20
  python/qemu/machine/README.rst
  5:QEMU. It is used by the iotests, vm tests, avocado tests, and several=
=20=20
  python/qemu/utils/README.rst
  5:debugging QEMU. It is used primarily by the vm and avocado tests.=20=20=
=20=20=20=20
  python/setup.cfg
  37:    avocado-framework >=3D 90.0=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
  python/tests/minreqs.txt
  35:avocado-framework=3D=3D90.0=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
  python/tests/protocol.py
  7:import avocado=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
  160:class Smoke(avocado.Test):=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
  208:class TestBase(avocado.Test):=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20

>
> Daniel P. Berrang=C3=A9 (6):
>   tests/functional: import GDB remote code from avocado
>   tests/functional: convert reverse debug test to local gdb module
>   tests/functional: replace avocado process with subprocess
>   tests/functional: drop datadrainer class in reverse debugging
>   tests/functional: close GDB socket in reverse debugging test
>   tests/functional: use self.log for all logging
>
>  tests/functional/aarch64/test_virt.py      |   4 +-
>  tests/functional/arm/test_integratorcp.py  |   3 +-
>  tests/functional/mips64el/test_malta.py    |   3 +-
>  tests/functional/qemu_test/gdb.py          | 237 ++++++
>  tests/functional/qemu_test/gdbmi_parser.py | 419 ++++++++++
>  tests/functional/qemu_test/spark.py        | 850 +++++++++++++++++++++
>  tests/functional/replay_kernel.py          |  16 +-
>  tests/functional/reverse_debugging.py      |  59 +-
>  tests/functional/x86_64/test_acpi_bits.py  |  31 +-
>  9 files changed, 1557 insertions(+), 65 deletions(-)
>  create mode 100644 tests/functional/qemu_test/gdb.py
>  create mode 100644 tests/functional/qemu_test/gdbmi_parser.py
>  create mode 100644 tests/functional/qemu_test/spark.py

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

