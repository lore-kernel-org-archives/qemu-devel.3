Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1076C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 10:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3rk-0002HZ-6T; Tue, 26 Mar 2024 06:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kyiP=LA=kaod.org=clg@ozlabs.org>)
 id 1rp3rg-0002Gv-3g; Tue, 26 Mar 2024 06:17:08 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kyiP=LA=kaod.org=clg@ozlabs.org>)
 id 1rp3rd-0002lm-WE; Tue, 26 Mar 2024 06:17:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4V3m1j0ddJz4wxt;
 Tue, 26 Mar 2024 21:16:57 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3m1Z5hJKz4wd7;
 Tue, 26 Mar 2024 21:16:50 +1100 (AEDT)
Message-ID: <f6f6e771-0820-4de5-b9cc-1e64b9729712@kaod.org>
Date: Tue, 26 Mar 2024 11:16:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc/pca955*: Move models under hw/gpio
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Glenn Miles <milesg@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
References: <20240325134833.1484265-1-clg@redhat.com>
 <10713c68-27d8-49b8-b50f-6648eef8d277@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <10713c68-27d8-49b8-b50f-6648eef8d277@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=kyiP=LA=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/26/24 10:55, Philippe Mathieu-Daudé wrote:
> On 25/3/24 14:48, Cédric Le Goater wrote:
>> The PCA9552 and PCA9554 devices are both I2C GPIO controllers and the
>> PCA9552 also can drive LEDs. Do all the necessary adjustments to move
>> the models under hw/gpio.
>>
>> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   MAINTAINERS                              | 4 ++--
>>   include/hw/{misc => gpio}/pca9552.h      | 0
>>   include/hw/{misc => gpio}/pca9552_regs.h | 0
>>   include/hw/{misc => gpio}/pca9554.h      | 0
>>   include/hw/{misc => gpio}/pca9554_regs.h | 0
>>   hw/arm/aspeed.c                          | 2 +-
>>   hw/{misc => gpio}/pca9552.c              | 4 ++--
>>   hw/{misc => gpio}/pca9554.c              | 4 ++--
>>   tests/qtest/pca9552-test.c               | 2 +-
>>   tests/qtest/pnv-host-i2c-test.c          | 4 ++--
>>   hw/gpio/meson.build                      | 2 ++
>>   hw/gpio/trace-events                     | 4 ++++
>>   hw/misc/meson.build                      | 2 --
>>   hw/misc/trace-events                     | 4 ----
>>   14 files changed, 16 insertions(+), 16 deletions(-)
>>   rename include/hw/{misc => gpio}/pca9552.h (100%)
>>   rename include/hw/{misc => gpio}/pca9552_regs.h (100%)
>>   rename include/hw/{misc => gpio}/pca9554.h (100%)
>>   rename include/hw/{misc => gpio}/pca9554_regs.h (100%)
>>   rename hw/{misc => gpio}/pca9552.c (99%)
>>   rename hw/{misc => gpio}/pca9554.c (99%)
> 
> Thanks, patch queued.

This one is merged,

https://gitlab.com/qemu-project/qemu/-/commit/6328d8ffa6cb9d750e4bfcfd73ac25d3a39ceb63

Thanks,

C.



