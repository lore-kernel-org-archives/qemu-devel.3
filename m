Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCE1C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5tN-000864-AQ; Thu, 06 Mar 2025 02:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq5tL-00085m-I8; Thu, 06 Mar 2025 02:43:40 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq5tJ-0004Gn-II; Thu, 06 Mar 2025 02:43:39 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-867129fdb0aso331325241.1; 
 Wed, 05 Mar 2025 23:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741247015; x=1741851815; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqNGyI//q83eMzRxlxja32xoaCTlCbUk9n2MSqaDgKM=;
 b=S+a9TMVXhOVhHVfUMW9gt+EjSvXP7rTEzOJiGqzomSd6CYJx013qAZRv+yGIhs5LIt
 m0E99Si3CNXk0FqJiRbZ1UxxnJ5ORe3cGf0cb79XKdKEtNXwbf8yI27Uiwn5s22vMoVT
 lseaOLboYMtrQ9d3zAvL7bOJuRiuafpVost0OVXX0JOwAuJOfv4K+znyNN3+gw8GGrr7
 NGP3/USMjvrH5gmkl5qj6W09klQ4n7JJkRihH5sb8MQejyh78j8SeifuI4P193jfqTcD
 T7T9tMGt3QTV8ciIJpF+5CHsc5syj9iOe79LJv9RJEhFo7pnrOzD0YSSsUg1tkjqJ8Sz
 5gFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741247015; x=1741851815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HqNGyI//q83eMzRxlxja32xoaCTlCbUk9n2MSqaDgKM=;
 b=Kmm+rEPj0W2kg0VzEUlEis5oc/q4Eko+GigmufVywWxsoCFUQm8M7p60kiW2DsDvTk
 qgXxx+KGptSgc1VqZ06cGj7thVQJDN9OgOEihF2MZ1gRBggHeDCscrSpfvQ+RBT2tShV
 h/74+eoYvKEwe+SfSNms8s5aNTVr9UeFbOTIKIMxLmv7aKdB/WS2Zn0BVayGchKO4gma
 cBPzh3qbzQEhPj1o9lVUkShdcRiW7XuhzlKnNul01Oq2oxNX+02M07MNraHpZ/FP82Ih
 mLT7ucoTw7IxeCPxELsQnt+2DMvKUwqGMMBu2rZYVHXriVwsR/ddYSCD1PPFdHoG29Sd
 njhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3+h9NXU58FGhF/w2FWhUmPHaKexnkaTwha/JLt97Z+af9PIL4YIEiKHDykKOgLInAnFE7ppPxgwRHuA==@nongnu.org,
 AJvYcCW83f4e/yOop+4cbUe/6HAehULMzUzlkLGBkkKSniaIzXOTqGN57sw9Zh83HLABceiUxXM0a2J3Qi0bldk=@nongnu.org,
 AJvYcCWkKDhxwk2bhbDgJbzD08fYY0Ez5NFI0wR9WRHVPkQdCHEKdYzWGjm15hxi/KDzdHaHNm/Hizv14Vcd@nongnu.org
X-Gm-Message-State: AOJu0YwUOTM0RM92VKDMQzOQm6RCJ3lm8Esxvv3jSyKcIGF/X+VItmti
 BWMh3SoRc1NEj/OFnkbdHaOqbFMt7Ky7FRcvpGFbUkimyGNNrqfq3czrCuH9hY/yQALj7lYnRF8
 lQ3v+rBwy13+n6DSpVDSNeybVfw4=
X-Gm-Gg: ASbGncvUAKwc3RMwlgJZVGPl0tEGSf7vhxw8wTitztbdYqD0Q2faC6YxQdzpRV0Ucsp
 4GruvEE03L80zcSCQa8F0XWTnwwBMw7gfNZXETXHmlKZpueuN4yVDSwJovlK2Dj65nWaz4rg0MJ
 bCRMvVzhlH7lOSQh2PGZ3ZjBu9NYfjSQUp5CGTGAyivAQ/VaRTyBpgvVj8
X-Google-Smtp-Source: AGHT+IEPASYQj/Hyp3BsdPQEaFGu5kINDlxXANE49uya3QAPk5Wmij3MOrddE2T7FU5g/+8cley3k/GR1huquNBRTOo=
X-Received: by 2002:a05:6102:4bc5:b0:4bb:623:e1f7 with SMTP id
 ada2fe7eead31-4c2e2920642mr4103259137.16.1741247015566; Wed, 05 Mar 2025
 23:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20250124101452.2519171-1-max.chou@sifive.com>
 <26e6ce70-94f8-4fb7-8a56-77135ef3928f@tls.msk.ru>
In-Reply-To: <26e6ce70-94f8-4fb7-8a56-77135ef3928f@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 17:43:09 +1000
X-Gm-Features: AQ5f1JpJEODXqsEL28-CyC5iaxcKj8JYQzzGXBW4Sia-2yMeP7hny9YpI2hLY2Y
Message-ID: <CAKmqyKNDry=f_Y7BCqAEPLVziyyWXyKm0BXwnov8JCaXwprinw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: rvv: Fix unexpected behavior of vector
 reduction instructions when vl is 0
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Mar 6, 2025 at 4:27=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 24.01.2025 13:14, Max Chou wrote:
> > According to the Vector Reduction Operations section in the RISC-V "V"
> > Vector Extension spec,
> > "If vl=3D0, no operation is performed and the destination register is n=
ot
> > updated."
> >
> > The vd should be updated when vl is larger than 0.
>
> Is this a qemu-stable material?

Yes

>
> If yes, how far to previous releases it is worth to pick?
> (Current older stable series are 7.2 and 8.2).
>
> I currently picked this up for 7.2, 8.2 and 9.2.

That's perfect

Alistair

>
> Thanks,
>
> /mjt
>

