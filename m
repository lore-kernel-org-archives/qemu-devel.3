Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3CE606A331
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=saFwULBy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNpPy-0005mL-S6; Mon, 02 Nov 2026 05:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNpPv-0005lP-I2
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:37:31 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNpPr-0007fm-Nw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:37:30 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8aea7b7ca0cso23529937b3.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:37:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793615846; cv=none;
 d=google.com; s=arc-20260327;
 b=h2Q6m4KEnvTHrnQEj/yDXpKUnMUh9mP5+BVmwDR5Fbz6/DMIanFbM6hvM6eXfzu8U8
 +U8DYSTt+Lk3aqnD8bEfq7vDmHkYJr1Cua/zmS6RaR8BYLhTOPFw6JSwsNVVTLDBOmYe
 WjsevWyDKn3SEU2qUl1weiQpLCbFsxryh9YinOUTDkfM5UzRIBNUpAvp84TRjGStG5mu
 0iYVixUL6Mq46M6ktEnQPMEfse7pQgeybZ4LpztpEveF6Golm5ETuydLPv1fOcrfc9id
 Lvc2L3K47QowAnTpnkQFX0QlNJNnyBAuVGsS6aORtS26xNGcDfAjScEu6+PnuHZABdOS
 toVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r9pyvIRnD3vmYnXZpLcZCfOXmqy5lBFgrsoMC4kxlr4=;
 fh=TYgLo6LSaCnSg4LxfB/cFu8QqHO9C1zPedgQPfry9ms=;
 b=GDCBFyaVKs2yQKcvQWBwZ5H1+u/XoPbsILu7N8+RvqDerLCIRTSMlu7s2l9sFwKbsb
 p4nFz6XHHukShfb572+whIhWXjViQ0zwEf9w3a+HJDNy1zE48mCcb3HK4PeiNtzY7t7F
 /KC4HIC25/LB5HpBdRDjjgKc7j/KkdoBGuNQ0Uyi3X/zkkw6hXgxBIsqplX0EWPVL0F8
 U51CTHn9d7ENqQZUV5ySO4lxxiWEzS6ChCLdfVWtgX9F9rM7KXr1M0k237aCSEWqcP6l
 hrs22ViLar13mjKDZs/11gb0c3KsSqGGcwvW3XsBN99hDkwLecC6mKM75er/puEFMiSO
 y3Rw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793615846; x=1794220646; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r9pyvIRnD3vmYnXZpLcZCfOXmqy5lBFgrsoMC4kxlr4=;
 b=saFwULBySCtX2D0sep2RST8rtLCGGnkK8x9GF+uzWKZ+8isR4th8M14iN6Lq232Fab
 lg6Z9PUpA+XeY3fpoh6ZWbCYLLmeZSfiL5jixHU0ExhvIthLKiaIwtTXl1Ks4CR8EViw
 EY7UInXQIpNjtdTuzLTytfknC65F5dbeRhAZ37tA6OQ2K4nd1rmTY3N/ffa+WoFccqPs
 PO88LEbmcxjkNqYt5R5EWjJY6p9omgkkUmDwW/bbZOz8i/IBOGwLnurw5AIK/N/wnnNS
 M2iorbjr8UNCfhpze/fJxra8jW+zaJGdUy3T2incJLJuYkVCj9sQMSRMUeHJcMzSDwxb
 zrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793615846; x=1794220646;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r9pyvIRnD3vmYnXZpLcZCfOXmqy5lBFgrsoMC4kxlr4=;
 b=hWQxjt7Dh9rF97RWFVblWppxrDo8NMOi+nL0G9NGJn7DP+TadBHJnX3xIhSCh2VMye
 eQ9OqWWdriDzhk+k7ueo53QoExF1Rxme1lCDYmrelZenrIAOavo3gnAgY+Wz86RJVdwX
 LZUPLTdzlAfF9SfPvs/MAfhXP1b9bR9uEr1k/lrPU/EUDUEVddcgFuVrSooRJThCET7R
 Y9S6mWUaf+389jM2XqB7Rl7lbcg/SaA19tpES9sZldEyHn6rX0mQlwJMe3pAySnzNK5e
 KMdl3Ol4nCDNfy1uaH8Akv2z4fQ/94mgUftaG7S7RAbZ9dkmRxKnc9jyimRA/rMmhiuI
 ef5w==
X-Gm-Message-State: APuU4Z+HiOehISAB7Br5TpdWg72pxDaG0sCPMnLaUP9cUJhqbyUHnYmV
 qnVZ2DM633F8kO280QI2+Xb63fhokKM4FCy8rOHk/CIC6cl03i6oUnBfiewSWcbZNc51wnpU7uV
 E4YsaXZ9RVoBUe6RMqXeWsrXPWBoLdW4WJX5Bo5BzjA==
X-Gm-Gg: AYBFou3xa3LDRF74sntCgUFI7llC8Ifc3Nt9Mwkw9kXg1tPV4w38BPBA459WPNpcyoX
 G6pB5clvPhVZ6cjU6a3WrvQb5g0eNyXSl3eB6DlDiKXFLZb0XkAAeVER33Xb+I7H3RQVghzmjbY
 ANDxokSiiyM9CKgjqrWgZmG+SOfGDPrDYerM/sQCLW2KtfKumBmTKUg8HMwya6rIqvn2BJvS8Ra
 XHSYb0c2AQ6wWZHbAnuvH/6KD0xMIA8vLTXiegwICtjNB2u8CMp5HhBPg7kzNUuZhBCMtN7Ui3e
 DPruOkPKk4RxsOoYZcRx3qA5El6dnnpTQ/yKMv851LuWo4X5ZJriksJDllbn2t8h4QOuQjRrzVK
 Sq4iDHeSKpylJ1tH8uxlnvlRgWPHU86RlraRTakTdyFITc1uo/JLoSTEK79j9KnjWunxX5fyk0f
 tXKatWcJPlLNt+B7Wb7/J1
X-Received: by 2002:a05:690c:102:b0:8b1:813e:91b0 with SMTP id
 00721157ae682-8b2b65b8d51mr59408477b3.9.1793615846051; Mon, 02 Nov 2026
 02:37:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793613972.bcm2835-fixes-v1.git.lorandmarton.dev@gmail.com>
 <9772fc00645a13988570f4107bf2eec7f5bbe2b7.1793613972.git.lorandmarton.dev@gmail.com>
In-Reply-To: <9772fc00645a13988570f4107bf2eec7f5bbe2b7.1793613972.git.lorandmarton.dev@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2026 10:37:14 +0000
X-Gm-Features: AclHuK8mZLfuhdBR07Z57F3KMBKZ98ksUfQclceLnehyrLJSu-OLaN5uUxlt-fk
Message-ID: <CAFEAcA8nvMRdEbecDq6buH5PxRuGwh2Um-CSdMZutKNsHW394g@mail.gmail.com>
Subject: Re: [PATCH 3/5] hw/ssi/bcm2835_spi: lower the interrupt on reset
To: Lorand Marton <lorandmarton.dev@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 10:21, Lorand Marton <lorandmarton.dev@gmail.com> wrote:
>
> bcm2835_spi_reset() cleared CS, so neither DONE nor RXR is set
> afterwards, but left the interrupt line as it was: a reset in the
> middle of an interrupt-driven transfer (a guest reboot while
> spi-bcm2835 waits for DONE) kept the line raised into the next boot.
> Update the interrupt from the new register values.
>
> Test that a reset during a transfer with INTD set drops the line.
>
> Fixes: 28004fb74134 ("hw/ssi: Implement BCM2835 SPI Controller")
> Signed-off-by: Lorand Marton <lorandmarton.dev@gmail.com>
> ---
>  hw/ssi/bcm2835_spi.c           |  2 ++
>  tests/qtest/bcm2835-spi-test.c | 42 ++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build        |  3 ++-
>  3 files changed, 46 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/bcm2835-spi-test.c
>
> diff --git a/hw/ssi/bcm2835_spi.c b/hw/ssi/bcm2835_spi.c
> index 01763c458c..4ab47787a4 100644
> --- a/hw/ssi/bcm2835_spi.c
> +++ b/hw/ssi/bcm2835_spi.c
> @@ -246,6 +246,8 @@ static void bcm2835_spi_reset(DeviceState *dev)
>      s->dlen = 0;
>      s->ltoh = 0x1;
>      s->dc = 0x30201020;
> +
> +    bcm2835_spi_update_int(s);
>  }

No, device reset methods should not call qemu_set_irq on their
outbound IRQ lines. The qemu_irq itself has no state, so on
reset the expectation is that this device resets its internal
state, and the device it's connecting to will also reset its
internal state (which will be to the "signal is not asserted"
state)". Calling qemu_set_irq() from reset runs into problems
with ordering of reset between different devices.

> +/* A reset in the middle of a transfer drops the interrupt */
> +static void test_reset_irq(void)
> +{
> +    QTestState *qts = qtest_init("-M raspi3b");
> +
> +    qtest_irq_intercept_out_named(qts, "/machine/soc/peripherals/bcm2835-spi0",
> +                                  "sysbus-irq");
> +    qtest_writel(qts, SPI0_BASE + SPI_CS, CS_CLEAR_RXTX | CS_TA);
> +    qtest_writel(qts, SPI0_BASE + SPI_FIFO, 0xa5);
> +    qtest_writel(qts, SPI0_BASE + SPI_CS, CS_TA | CS_INTD);
> +    g_assert_true(qtest_get_irq(qts, 0));
> +
> +    qtest_system_reset(qts);
> +    g_assert_false(qtest_get_irq(qts, 0));

This test is really running into the fact that qtest's
irq state for intercepted IRQs is not cleaned up on
reset; so you get a bogus answer if you call qtest_get_irq()
after qtest_system_reset().

-- PMM

