Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC1DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1okM-0005Z8-JY; Tue, 30 Apr 2024 10:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1okB-0005SY-2p
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:46:09 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1ok9-0004YA-FF
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:46:06 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso7518548a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714488364; x=1715093164; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2BufZs0kEfZhSREW2kr3ncdJ656wrt8XpmqX2L/UqWo=;
 b=GaYIN1/hq0qxVu9pQEnpwp4SMssjaEVxeW5S10ssOodUjR1Kr7qHZqmfJlU4t5G0O2
 iLGBoJlYZaPQrK3P4/4LuoPaOVVl6H8/B62IbReYYax+5KDr6PCldnrhVwuxEBgon055
 VdIeyfnDh7Pv4NvOdMXlviHwhhXJfreFmpWvUOZmMqJKNlj3hOC/ys6A8nIr4jwanXhk
 p6ixdVBAazAl1gTl9BGgAEBh+JyysIpbhs3wQUA8OuXdeYtIYvHJxuHut/9kLV9crWS3
 i8zd6poy6PUWlsvsu37ujh69QzM4HuocJ+BE/eOaUx6LLwvnuYe1CKodD69wUGTvPxBw
 U/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714488364; x=1715093164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2BufZs0kEfZhSREW2kr3ncdJ656wrt8XpmqX2L/UqWo=;
 b=EqFqFupfKpljVOxYfLVb4y5JgXZizuFjbCpTehCYukZEj87GAcW7CiJ6ftJu3oEzhO
 AWRJACQ31yDIIAWqDc5IGy1L7SpCU1YW1hjxvbmpLgnX6oW3fVt98osoUaBZin0ivrzL
 hStNhrVQD9JAo+YjRlBfgfKrc+xbRZTbAJ1tAubn6ReoTuQ0nKue27q4y83Xce1ndU7y
 kMXsJeUhQSznUyo60tSbuOrBiATHy/eRrRDiovahhsFY9fWAt5BBV5HhislrcQ94otSv
 S3uL+aUaiL/2Vf1+bmRugMNpU1BBT/VdCGj+fRiRgpJEpwR4REpbOq1bhj45UMxA13pQ
 00IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLjBS7PX1FHcGAm+/ybNuOBLBkKj8CJyOrzKgNtD/tFt1vJIAL6e901y1aBp+U/dEgPUOisMH4gOptZVScb1KRWPD6cTo=
X-Gm-Message-State: AOJu0YzeBUhZ1ApYL0V2G/7LmfKi2N1mL0SywzrH/TvPgPfcGR/i1ayT
 fxbzzg1qwl3qlzkVQVTN9t4qvXqohnQctIod1g0Vipc8cNGK2TzLn3FQTvc6A3FfXzwqDmDwQ/D
 WqX8qtWAB8VM/p4qWrgbZ3Q/9XYiQda5jK2XOKg==
X-Google-Smtp-Source: AGHT+IGJU1wHKt/JnsN7b16H8JhUza2iUYDxSWI13nQW5yTA2oM1fDNwBqvz84EzY1Z8NRv3Oht3C5A9QWoEirBLZkw=
X-Received: by 2002:a50:9b11:0:b0:56e:603:9fc9 with SMTP id
 o17-20020a509b11000000b0056e06039fc9mr19388edi.3.1714488364071; Tue, 30 Apr
 2024 07:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240429075908.36302-1-thuth@redhat.com>
In-Reply-To: <20240429075908.36302-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2024 15:45:52 +0100
Message-ID: <CAFEAcA8iUvPfsESA4+1iA4uvjDorj-99WxhV8rN4-dHkrsB8SQ@mail.gmail.com>
Subject: Re: [PATCH] hw/char/stm32l4x5_usart: Fix memory corruption by adding
 correct class_size
To: Thomas Huth <thuth@redhat.com>
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 29 Apr 2024 at 08:59, Thomas Huth <thuth@redhat.com> wrote:
>
> "make check-qtest-aarch64" recently started failing on FreeBSD builds,
> and valgrind on Linux also detected that there is something fishy with
> the new stm32l4x5-usart: The code forgot to set the correct class_size
> here, so the various class_init functions in this file wrote beyond
> the allocated buffer when setting the subc->type field.
>
> Fixes: 4fb37aea7e ("hw/char: Implement STM32L4x5 USART skeleton")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

