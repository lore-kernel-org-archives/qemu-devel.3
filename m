Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43938C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 18:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQtTa-0005Ir-3C; Mon, 08 Jul 2024 14:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sQtTX-0005HY-SY
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 14:52:35 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sQtTV-00063H-CS
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 14:52:35 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C8FA84E6005;
 Mon, 08 Jul 2024 20:52:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id aoNd3EPphC7c; Mon,  8 Jul 2024 20:52:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CD8284E601D; Mon, 08 Jul 2024 20:52:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CB7C0746E3B;
 Mon, 08 Jul 2024 20:52:27 +0200 (CEST)
Date: Mon, 8 Jul 2024 20:52:27 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] include/hw/qdev-core.h: Correct and clarify gpio doc
 comments
In-Reply-To: <20240708153312.3109380-1-peter.maydell@linaro.org>
Message-ID: <8575cb58-ffae-c136-deb9-9daba82752b1@eik.bme.hu>
References: <20240708153312.3109380-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 8 Jul 2024, Peter Maydell wrote:
> The doc comments for the functions for named GPIO inputs and
> outputs had a couple of problems:
> * some copy-and-paste errors meant the qdev_connect_gpio_out_named()
>   doc comment had references to input GPIOs that should be to
>   output GPIOs
> * it wasn't very clear that named GPIOs are arrays and so the
>   connect functions specify a single GPIO line by giving both
>   the name of the array and the index within that array
>
> Fix the copy-and-paste errors and slightly expand the text
> to say that functions are connecting one line in a named GPIO
> array, not a single named GPIO line.
>
> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Does this help? I wrote the text and know what the functions do
> to start with so it's a bit tricky for me to see where the docs
> don't state things as clearly as they ought to do...

Yes, I think it is clearer. Thanks for fixing these. I could figure this 
out despite the errors and I've used multiple named gpios for vt82c686 and 
mv64361 before, I just forgot how these functions work. Making the docs 
less confusing helps, for quick reference and especially newcomers who try 
to use this for the first time.

Regards,
BALATON Zoltan

> ---
> include/hw/qdev-core.h | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 5336728a23f..77bfcbdf732 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -624,8 +624,9 @@ qemu_irq qdev_get_gpio_in(DeviceState *dev, int n);
>  * @name: Name of the input GPIO array
>  * @n: Number of the GPIO line in that array (which must be in range)
>  *
> - * Returns the qemu_irq corresponding to a named input GPIO line
> - * (which the device has set up with qdev_init_gpio_in_named()).
> + * Returns the qemu_irq corresponding to a single input GPIO line
> + * in a named array of input GPIO lines on a device (which the device
> + * has set up with qdev_init_gpio_in_named()).
>  * The @name string must correspond to an input GPIO array which exists on
>  * the device, and the index @n of the GPIO line must be valid (i.e.
>  * be at least 0 and less than the total number of input GPIOs in that
> @@ -673,15 +674,15 @@ void qdev_connect_gpio_out(DeviceState *dev, int n, qemu_irq pin);
>  *                              GPIO lines
>  * @dev: Device whose GPIO to connect
>  * @name: Name of the output GPIO array
> - * @n: Number of the anonymous output GPIO line (which must be in range)
> + * @n: Number of the output GPIO line within that array (which must be in range)
>  * @input_pin: qemu_irq to connect the output line to
>  *
> - * This function connects an anonymous output GPIO line on a device
> - * up to an arbitrary qemu_irq, so that when the device asserts that
> - * output GPIO line, the qemu_irq's callback is invoked.
> + * This function connects a single GPIO output in a named array of output
> + * GPIO lines on a device up to an arbitrary qemu_irq, so that when the
> + * device asserts that output GPIO line, the qemu_irq's callback is invoked.
>  * The @name string must correspond to an output GPIO array which exists on
>  * the device, and the index @n of the GPIO line must be valid (i.e.
> - * be at least 0 and less than the total number of input GPIOs in that
> + * be at least 0 and less than the total number of output GPIOs in that
>  * array); this function will assert() if passed an invalid name or index.
>  *
>  * Outbound GPIO lines can be connected to any qemu_irq, but the common
> @@ -796,7 +797,7 @@ void qdev_init_gpio_out(DeviceState *dev, qemu_irq *pins, int n);
>  * @dev: Device to create output GPIOs for
>  * @pins: Pointer to qemu_irq or qemu_irq array for the GPIO lines
>  * @name: Name to give this array of GPIO lines
> - * @n: Number of GPIO lines to create
> + * @n: Number of GPIO lines to create in this array
>  *
>  * Like qdev_init_gpio_out(), but creates an array of GPIO output lines
>  * with a name. Code using the device can then connect these GPIO lines
>

