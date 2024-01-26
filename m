Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A391CC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 09:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTI5H-00008V-Vh; Fri, 26 Jan 2024 04:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTI5F-00007i-S4; Fri, 26 Jan 2024 04:01:09 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5gEp=JE=kaod.org=clg@ozlabs.org>)
 id 1rTI5D-0000ab-SD; Fri, 26 Jan 2024 04:01:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TLs9s1JYBz4x5K;
 Fri, 26 Jan 2024 20:01:05 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TLs9m03Cnz4wx5;
 Fri, 26 Jan 2024 20:00:59 +1100 (AEDT)
Message-ID: <6a7c98da-c0de-4c59-9476-5b5fe17232c7@kaod.org>
Date: Fri, 26 Jan 2024 10:00:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/11] Introduce model for IBM's FSI
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20240126034026.31068-1-ninad@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240126034026.31068-1-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=5gEp=JE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Ninad,

On 1/26/24 04:40, Ninad Palsule wrote:
> Hello,
>   
> Please review the patch-set version 11.
> I have incorporated review comments from Cedric.
> v10:
>    - Moved aspeed-apb2opb to hw/fsi directory
>    - Split some patches.
>    - Fixed crash.
>    - make check
>      Ok:                 319
>      Expected Fail:      0
>      Fail:               0
>      Unexpected Pass:    0
>      Skipped:            9
>      Timeout:            0

I did some minor comments. v12 should be queued for upstream. I will
reorder the Signed-off (mine) trailers.

Thanks,

C.

> 
> 
> Ninad Palsule (11):
>    hw/fsi: Introduce IBM's Local bus
>    hw/fsi: Introduce IBM's scratchpad device
>    hw/fsi: Introduce IBM's FSI Bus
>    hw/fsi: Introduce IBM's fsi-slave model
>    hw/fsi: Introduce IBM's cfam
>    hw/fsi: Introduce IBM's FSI master
>    hw/fsi: Aspeed APB2OPB & On-chip peripheral bus
>    hw/arm: Hook up FSI module in AST2600
>    hw/fsi: Added qtest
>    hw/fsi: Added FSI documentation
>    hw/fsi: Update MAINTAINER list
> 
>   MAINTAINERS                     |   9 +
>   docs/specs/fsi.rst              | 138 ++++++++++++++
>   docs/specs/index.rst            |   1 +
>   meson.build                     |   1 +
>   hw/fsi/trace.h                  |   1 +
>   include/hw/arm/aspeed_soc.h     |   4 +
>   include/hw/fsi/aspeed_apb2opb.h |  46 +++++
>   include/hw/fsi/cfam.h           |  34 ++++
>   include/hw/fsi/fsi-master.h     |  32 ++++
>   include/hw/fsi/fsi.h            |  38 ++++
>   include/hw/fsi/lbus.h           |  43 +++++
>   hw/arm/aspeed_ast2600.c         |  19 ++
>   hw/fsi/aspeed_apb2opb.c         | 322 ++++++++++++++++++++++++++++++++
>   hw/fsi/cfam.c                   | 168 +++++++++++++++++
>   hw/fsi/fsi-master.c             | 170 +++++++++++++++++
>   hw/fsi/fsi.c                    | 105 +++++++++++
>   hw/fsi/lbus.c                   | 112 +++++++++++
>   tests/qtest/aspeed-fsi-test.c   | 205 ++++++++++++++++++++
>   hw/Kconfig                      |   1 +
>   hw/arm/Kconfig                  |   1 +
>   hw/fsi/Kconfig                  |   7 +
>   hw/fsi/meson.build              |   2 +
>   hw/fsi/trace-events             |  13 ++
>   hw/meson.build                  |   1 +
>   tests/qtest/meson.build         |   1 +
>   25 files changed, 1474 insertions(+)
>   create mode 100644 docs/specs/fsi.rst
>   create mode 100644 hw/fsi/trace.h
>   create mode 100644 include/hw/fsi/aspeed_apb2opb.h
>   create mode 100644 include/hw/fsi/cfam.h
>   create mode 100644 include/hw/fsi/fsi-master.h
>   create mode 100644 include/hw/fsi/fsi.h
>   create mode 100644 include/hw/fsi/lbus.h
>   create mode 100644 hw/fsi/aspeed_apb2opb.c
>   create mode 100644 hw/fsi/cfam.c
>   create mode 100644 hw/fsi/fsi-master.c
>   create mode 100644 hw/fsi/fsi.c
>   create mode 100644 hw/fsi/lbus.c
>   create mode 100644 tests/qtest/aspeed-fsi-test.c
>   create mode 100644 hw/fsi/Kconfig
>   create mode 100644 hw/fsi/meson.build
>   create mode 100644 hw/fsi/trace-events
> 


