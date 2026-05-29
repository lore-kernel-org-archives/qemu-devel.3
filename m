Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E3DCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwUw-00089u-Jc; Fri, 29 May 2026 08:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wSwUu-00089Q-O0; Fri, 29 May 2026 08:39:32 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wSwUt-0003jQ-6Q; Fri, 29 May 2026 08:39:32 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 38D0460598;
 Fri, 29 May 2026 12:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6861F00893;
 Fri, 29 May 2026 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780058369;
 bh=IQn9hbomT2+VOq3l81AfM2P8zSEc9/5kIp4YlnBQCBw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=jq+JeRr0Qu89IoAOxpNiMelhlh5BsXXHJg6jB0Rd6Jp7GoILx9yhqLn+I/9D/62EW
 fjB4MPnY/L45prEolrsb9d7B88P7cISSn2REXlkE+macLNw9jwhv8bkD9KQUoyOje4
 aKyJq1HnDuOi+T8+uSTIBQk+ItPl2e/rryq2go3KH+SVIv9Q+JeIxDpVZkTCiX8D/Q
 SGIeO8H8vJdj+/s7ieLXf8MKVpC21Hl/w9/puhPSKKsCgKSO6rNyYoCrnFR4MftWP3
 W+5NVvPgdirk1p9YqCz5GK2Rvn/RHCJcZ+15TEihueIVK6RADu0MjZn4idKmtSDgVO
 81kZlt9fFE9+g==
Date: Fri, 29 May 2026 13:39:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexander Hansen <alexander.hansen@9elements.com>
Cc: qemu-devel@nongnu.org, Titus Rwantare <titusr@google.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v4 4/5] hw/sensor: support MAX11615
Message-ID: <20260529133919.3194636b@jic23-huawei>
In-Reply-To: <20260515150610.381066-5-alexander.hansen@9elements.com>
References: <20260515150610.381066-1-alexander.hansen@9elements.com>
 <20260515150610.381066-5-alexander.hansen@9elements.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 15 May 2026 16:58:01 +0200
Alexander Hansen <alexander.hansen@9elements.com> wrote:

> Product: [1]
> Datasheet: [2]
> 
> Sensor readings can be provided upon creation of the device. In case no
> readings are provided the ADC reads a pre-defined arbitrary value.
> 
> root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/name
> max11615
> root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/in_voltage0_raw
> 1922
> root@yosemite4:~# cat /sys/bus/iio/devices/iio:device2/in_voltage_scale
> 0.500000000

As I mentioned on v1 a lot of the standard linux driver operations with this
device will not work. The emulation doesn't deal with multi channel
scans for example.

So what is the purpose of limited emulation vs just not emulating it at all.
(which will fail a couple more things obviously!)

I'm not sure what the standard expectations are for this when the
features that aren't emulated are not discoverable (i.e. the driver can't
tell it should not use them).

Jonathan

> 
> trace:
> less /tmp/qemu-trace.log | grep -i max116
> max11615_realize i2c_addr: 0x33
> max11615_realize i2c_addr: 0x33
> max11615_event i2c_addr: 0x33, event: 0x01
> max11615_write_setup i2c_addr: 0x33, data: 0xd2
> max11615_write_config i2c_addr: 0x33, data: 0x0f
> max11615_event i2c_addr: 0x33, event: 0x03
> max11615_event i2c_addr: 0x33, event: 0x01
> max11615_write_setup i2c_addr: 0x33, data: 0xd2
> max11615_write_config i2c_addr: 0x33, data: 0x0f
> max11615_event i2c_addr: 0x33, event: 0x03
> max11615_event i2c_addr: 0x33, event: 0x01
> max11615_write_setup i2c_addr: 0x33, data: 0xd2
> max11615_write_config i2c_addr: 0x33, data: 0x61
> max11615_event i2c_addr: 0x33, event: 0x03
> max11615_event i2c_addr: 0x33, event: 0x00
> max11615_recv i2c_addr: 0x33, reg_addr: 0x00
> max11615_recv_return i2c_addr: 0x33, returns: 0xfa
> max11615_recv i2c_addr: 0x33, reg_addr: 0x00
> max11615_recv_return i2c_addr: 0x33, returns: 0xd2
> max11615_event i2c_addr: 0x33, event: 0x04
> max11615_event i2c_addr: 0x33, event: 0x03

