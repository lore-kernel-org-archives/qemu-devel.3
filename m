Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB19C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 13:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rURjm-0005Ml-RC; Mon, 29 Jan 2024 08:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURji-0005Kz-Pu
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:31:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rURjg-0006vX-1R
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706535098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8W0tWw6D8WpMAhZ5jtzvDfADgPsvW7ZxK/VNwOpyY4Q=;
 b=cD4te4Y02tVSnduD+lJCQrd4/OZOA/LCD9+tdlE/IdYOW+/fhhCR+ioLWGA9ulLiytYBGU
 wh0UOwjfBXUKG0u799+04Ht31ZQ5rUm0K7lmAXud/Qri42WerVKK/iXCvBF5JURY8YuLmC
 y4cHsOXKtQx+KIc4CiTR5wxslOdyS3A=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-fxKKdz6lORiNWTcMSoWcsg-1; Mon, 29 Jan 2024 08:31:37 -0500
X-MC-Unique: fxKKdz6lORiNWTcMSoWcsg-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7d326aa3f86so928610241.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 05:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706535096; x=1707139896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8W0tWw6D8WpMAhZ5jtzvDfADgPsvW7ZxK/VNwOpyY4Q=;
 b=Kg3IzI+ZdM1m38Bl+P9eOHBRUiJ1FjyG24axanWLXCExeMbANJdK4e9Lf0/cCTXD/K
 thr8UV53UJ0Nns3DXBZ+MzYstuxeDwkftnanFXfkiMtsf9FAShOLEAkl3qaQ3BO0kSu1
 7ny4EX3Jk6mZv4lGZHkF8HZyP7yypoGtAr84xkHquO7TsF9k4vDa5PpXefGx9+VRRdg/
 YEj2q77F7QI1lwKJSPGMnXGv3VLmgypA62O2ZBjYid9+QERqJw+P0ExWOqXkO5+i3Wy2
 jRaeWtSfEz9lkI38ijXVioOGKRo9XncNHrwOA2yNm81N+JffC3Gg623StyU7QMVX8S3X
 DSFA==
X-Gm-Message-State: AOJu0YygOHiD/0Kjuev6M1CaQkpV0/79ydigGBE6LCahfPcxk56/VOvD
 sJeh52s3+wnIbd7vysXbOmISnQIx7t8umOxH3lXiHwJClCcHuWD8PmBEfen+Fqly+z8elSd4qVO
 exwnmKGwgODYOqUlZfMUUacgSKDiBrQMnjOz26uKqgqqOgl56tO0r7+0tfkqXaMMhO+D0/vqyKK
 FcbybdXHBJdSh18T+EQM1KtdKQRWY=
X-Received: by 2002:a05:6102:513:b0:46b:267e:30d4 with SMTP id
 l19-20020a056102051300b0046b267e30d4mr2264574vsa.1.1706535096322; 
 Mon, 29 Jan 2024 05:31:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2rutFpb3cg4c7aXFJ6i65pwjRxuxEaH0cj+KRHxZxVyPaEaK1uevwSXic56cqu1W9hqo25DfJYpFflL6ET3E=
X-Received: by 2002:a05:6102:513:b0:46b:267e:30d4 with SMTP id
 l19-20020a056102051300b0046b267e30d4mr2264558vsa.1.1706535096005; Mon, 29 Jan
 2024 05:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20240129121312.1057281-1-pbonzini@redhat.com>
 <1ff4b856-352b-4eb0-944e-67ab75474be8@linaro.org>
In-Reply-To: <1ff4b856-352b-4eb0-944e-67ab75474be8@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Jan 2024 14:31:23 +0100
Message-ID: <CABgObfZ5r9DRjaxWZcOJ4u5+8zz8LmKtY562-6phu6FiYBV7bA@mail.gmail.com>
Subject: Re: [PATCH] mips: allow compiling out CONFIG_MIPS_ITU
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 29, 2024 at 2:30=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Paolo,
>
> On 29/1/24 13:13, Paolo Bonzini wrote:
> > itu_reconfigure() is referenced from TCG, provide a stub if needed.
>
> s/itu_reconfigure/itc_reconfigure/
>
> What are you trying to achieve?

I'm trying to build all MIPS boards one by one (to clean up
configs/devices/mips*).

Paolo


