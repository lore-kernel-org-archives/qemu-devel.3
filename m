Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE6ACCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 07:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAkKD-0006lS-Jx; Mon, 20 Oct 2025 03:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vAkK8-0006kg-SN
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:28:57 -0400
Received: from 3.mo548.mail-out.ovh.net ([188.165.32.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vAkK4-0000WB-L3
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:28:56 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.197])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cqn923T4hz5ygS;
 Mon, 20 Oct 2025 07:28:38 +0000 (UTC)
Received: from kaod.org (37.59.142.103) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 20 Oct
 2025 09:28:37 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0054fb7cc32-d1d6-4163-b4e1-4d87f315fd4a,
 FF32B7A34F2DEDF77D336B29AD6F053710A0DB6D) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <c39cc3e2-bbd3-4ac9-a3e3-ac2515fdb141@kaod.org>
Date: Mon, 20 Oct 2025 09:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] sd: Add RPMB emulation to eMMC model
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
CC: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, <qemu-block@nongnu.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Alexander Bulekov
 <alxndr@bu.edu>, Alistair Francis <alistair@alistair23.me>, Joel Stanley
 <joel@jms.id.au>, Warner Losh <imp@bsdimp.com>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <cover.1760702638.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: f4002407-2c46-47c5-868f-29b40cab8406
X-Ovh-Tracer-Id: 16475574812710570939
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGQlzlVYbhOAII8hMbfQchPNB7XT1OOlqAlnqnllKf90Qyi3BKBP5lqqDCkNK/760wiSC9W2JqVwfCsbExbIQ9pvqErxQ+N+osjyuS2WMb8yTlhQ7v4aKmgQfdCPo9pDpavXqytOQMEt+ioVBOshsbc7W41i2NAsNWeX5F1Kgp6InFOTnr5YXRybVVyaLrr4DBDRkXn1/6Cbhs9ophDKQ9rCt3lVEGpNrsLIILjyHzBTLtNw9IBW7ij2Oi1rawa+peRb24yDu9YL0VegahgGdTYt8VtQPTsK3lj0qcdtBiAf4nQriN9ewj88iH+C3dFkSbYqW3CwK6eV09j6u5PiGJWWrjFi8X49+4uoOXrCTGYrsnnrlxovQjOoNXrghH7a3YQzEhCOWdVZGKwJAmLLbZHjH7UI8nN47USKUtgyUFba/Fgh6+c85MUd1MhGyEEqVvOIYkNgCGa51+3pk/FCYSzoa+DWb7nQ+rep/JSEkl60WzpeYdSNQCzCts+uFUpJ892EnxlvVR2bUHNAy4LC/0s+jwW+pv8qDOfoPXUYcJdEukJVrxvlVDNdEIQbyNlJZKvP0jBnP3AaJAUy1g1d7PTOzFy4umDOwx/GoEz4QyS7iAPgvSjUWnDfxV0QWCezu8VEu5G0z1D3Xws5qD6dcDOK/c6BuDFNKr2+z0bHMTChw
DKIM-Signature: a=rsa-sha256; bh=KICs8DkhjPiYGTh500ScPV935mZdL7uEaQTIDwe+TL4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760945320; v=1;
 b=Pn9QMaS1/eSdglrvkuErK28mj6U8EtZK4dF4pW03hQfYUfLpLQKi8UQi2fWS/9Pv38e/FfOP
 kg4Pcj+eHhCT1yQWOrCEzxv4cOpiWCx8Doo1s3581DCVvheK6Y28EPNe87qgG+94qlxKlHiqTPD
 +ubOIo47vnrlw6aoD+GDGiX9bIhnFIjIODoF3vv1iq0uTS39n9AVemk4hz6mawPJdfnWNO1W73+
 8U90d/6lJgO/yCK9K3DDLcNS0TFMYXl5DeWExcuBKSQQrUIa/ppiOuzcdpriCRFupAM524+F071
 dvSOX/tY6uKgwGhVxYr4KLwj12aHnniImDo+DkS9dSlig==
Received-SPF: pass client-ip=188.165.32.156; envelope-from=clg@kaod.org;
 helo=3.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/17/25 14:03, Jan Kiszka wrote:
> Changes in v5 [1]:
>   - fix regression of patch 1 with unplugged SD cards
>   - address review comments on documentation
> 
> Changes in v4:
>   - add truncation warning to mkemmc.sh
>   - fix typos in doc and mkemmc.sh
> 
> Changes in v3:
>   - rebased, dropping merged patches
>   - rework image alignment rules to match hardware
>   - improve/fix mkemmc script
>   - add emmc documentation
> 
> Changes in v2:
>   - handle write counter expiry
>   - assert() availability of QCRYPTO_HASH_ALGO_SHA256
>   - add missing SPDX-License-Identifier
> 
> This closes an old gap in system integration testing for the very
> complex ARM firmware stacks by adding fairly advanced Replay Protected
> Memory Block (RPMB) emulation to the eMMC device model. Key programming
> and message authentication are working, so is the write counter. Known
> users are happy with the result. What is missing, but not only for RPMB-
> related registers, is state persistence across QEMU restarts. This is OK
> at this stage for most test scenarios, though, and could still be added
> later on.
> 
> What can already be done with it is demonstrated in the WIP branch of
> isar-cip-core at [2]: TF-A + OP-TEE + StandaloneMM TA + fTPM TA, used by
> U-Boot and Linux for UEFI variable storage and TPM scenarios. If you
> want to try: build qemu-arm64 target for trixie with 6.12-cip *head*
> kernel, enable secure boot and disk encryption, then run
> 
> $ QEMU_PATH=/path/to/qemu-build/ ./start-qemu.sh
> 
> Deploy snakeoil keys into PK, KEK and db after first boot to enable
> secure booting:
> 
> root@demo:~# cert-to-efi-sig-list PkKek-1-snakeoil.pem PK.esl
> root@demo:~# sign-efi-sig-list -k PkKek-1-snakeoil.key -c PkKek-1-snakeoil.pem PK PK.esl PK.auth
> root@demo:~# efi-updatevar -f PK.auth db
> root@demo:~# efi-updatevar -f PK.auth KEK
> root@demo:~# efi-updatevar -f PK.auth PK
> 
> Note that emulation is a bit slow in general, and specifically the
> partition encryption on first boot is taking 20 min. - we should
> probably reduce its size or understand if there is still something to
> optimize.
> 
> Jan
> 
> [1] https://github.com/siemens/qemu/commits/queues/emmc/
> [2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/qemu-rpmb
> 
> CC: Alexander Bulekov <alxndr@bu.edu>
> CC: Alistair Francis <alistair@alistair23.me>
> CC: Cédric Le Goater <clg@kaod.org>
> CC: Joel Stanley <joel@jms.id.au>
> CC: Warner Losh <imp@bsdimp.com>
> 
> Jan Kiszka (6):
>    hw/sd/sdcard: Fix size check for backing block image
>    hw/sd/sdcard: Allow user-instantiated eMMC
>    hw/sd/sdcard: Add basic support for RPMB partition
>    hw/sd/sdcard: Handle RPMB MAC field
>    scripts: Add helper script to generate eMMC block device images
>    docs: Add eMMC device model description
> 
>   docs/system/device-emulation.rst |   1 +
>   docs/system/devices/emmc.rst     |  53 +++++
>   hw/sd/sd.c                       | 352 ++++++++++++++++++++++++++++---
>   hw/sd/sdmmc-internal.h           |  21 ++
>   hw/sd/trace-events               |   2 +
>   scripts/mkemmc.sh                | 218 +++++++++++++++++++
>   6 files changed, 618 insertions(+), 29 deletions(-)
>   create mode 100644 docs/system/devices/emmc.rst
>   create mode 100755 scripts/mkemmc.sh
> 

I checked the series on the aspeed tree :

Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



