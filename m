Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424CCC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 08:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYiF0-0007Cd-MW; Tue, 30 Jul 2024 04:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYiEz-00076U-4m
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:29:53 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYiEx-0004SH-CH
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:29:52 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5b391c8abd7so1925099a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 01:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722328189; x=1722932989; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bvctSTCxXDG9vkXCPJRFSO2OwM56i0h+SX57avLe2Sg=;
 b=M/4mS9IqJBN5Th0IgQzBCJ1+1LRDe6cN0zwPEmCSIPTbo2P946F3PGZhWAbJO/pXH0
 2nDkd/iDUheQcmrcgNbKORpzqUUKgYyY6pXCZIGNqP7G9o/qPuNsOL1pRRe5nVSd7SoN
 5+6yJHvqhV3DhLaZ/H7O9pK4Pgsla8jpUo6AUIw+G8oMBbqhW1IquE4yRxQT7U7alRa9
 rKLlL9Kn5sJwvsu+NL/MamZxxmivJ97pnyC504c09WAuMbFfze+DoVCPixTjEpdHHFhr
 8qjdMuuGP32Q8XDQ9UL3tjvjcQzPYx2f6rAQjC9NNrLvUbbPI/uFhXjkA75rW+ek0bOZ
 sh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722328189; x=1722932989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bvctSTCxXDG9vkXCPJRFSO2OwM56i0h+SX57avLe2Sg=;
 b=L1VsmW+WZOp73o2ZftuYEUY2hIIS5GVLGlmOEbY5QePbOtCJnTvfSZE9LiueeO2n6B
 dPWVga7LIwq2BKu1FlB0pliYQK0m+5lK+2bfrv0bo/ghpl7BtLYREB5Og7A0n6dnnq+X
 g2x2qjjuVwBNXmeQeZl7bipm/FUk6DdxytGuEvfTQwT/tBT/NotVCm6FMT/nbAUdablT
 dE3SZe/UPdx3vNKASiQQGiJStYZxl7vjWl/kIwL+p0Sz+tWIg1Xr57+c/zT+uLwNTIfa
 /SVTv8o0wcY7JMmkPDBU3l84qHJ16ceJ04/jk/EDmvUL8UmrMGK8GadLXvXR8bMDpIbF
 4CHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeche9Du1wGLoT5ZxaIYdtMBlomx8DhW0+5LuxUeVtc2eY4rPmvrMvCJwVQPF5DUN6vquiDOac2YRGxOTLIdW1WnemZ8w=
X-Gm-Message-State: AOJu0YyzswpQtQxvjHlGAyipHqLYawxP6KcgrLkPrQunvRl1B8kJK/Po
 ofCO/vght42By6QfoObmT+/tladJRGUYzwK1XN/lSV4taoNFNgjF7kTOZj1TcbCJXMvUnf01apd
 yMk4cA31GI+cCo4y+nvXIKQFS4W4K/+7uBRMHcA==
X-Google-Smtp-Source: AGHT+IErCc8jLnL94ZNnMfdPeD4RlLQ0Wtssx5HIgjIRj8h1yZKWV6ZokNRGFXEBilq3W+viB6Om7wZ7Cday52qL5Gg=
X-Received: by 2002:a50:a411:0:b0:5a1:7d68:62d8 with SMTP id
 4fb4d7f45d1cf-5b022c81f43mr5928071a12.38.1722328188753; Tue, 30 Jul 2024
 01:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <bf8367bddfdc95e378b5725c732533c3ba20d388.1721630625.git.mchehab+huawei@kernel.org>
 <20240730092549.6898ff3c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240730092549.6898ff3c@imammedo.users.ipa.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2024 09:29:37 +0100
Message-ID: <CAFEAcA8VWc3eQZqfJP9k5LYF-9aLChHQ+uS9UBfGV6nvybDxqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] arm/virt: place power button pin number on a define
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 30 Jul 2024 at 08:26, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Mon, 22 Jul 2024 08:45:53 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>
> > Having magic numbers inside the code is not a good idea, as it
> > is error-prone. So, instead, create a macro with the number
> > definition.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index b0c68d66a345..c99c8b1713c6 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
> >      if (s->acpi_dev) {
> >          acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
> >      } else {
> > -        /* use gpio Pin 3 for power button event */
> > +        /* use gpio Pin for power button event */
> >          qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
>
> /me confused, it was saying Pin 3 but is passing 0 as argument where as elsewhere
> you are passing 3. Is this a bug?

No. The gpio_key_dev is a gpio-key device which has one
input (which you assert to "press the key") and one output,
which goes high when the key is pressed and then falls
100ms later. The virt board wires up the output of the
gpio-key device to input 3 on the PL061 GPIO controller.
(This happens in create_gpio_keys().) So the code is correct
to assert input 0 on the gpio-key device and the comment
isn't wrong that this results in GPIO pin 3 being asserted:
the link is just indirect.

thanks
-- PMM

