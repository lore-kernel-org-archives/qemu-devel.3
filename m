Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66961C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 07:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJq54-00088J-T2; Wed, 19 Jun 2024 03:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJq53-00087m-3V
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 03:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJq51-0005uq-Ne
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 03:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718783406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0go2MmwOug7Kk4Kw8l1SxCzn4Kij0LtVXdFpMf3FCM=;
 b=euBvVuFR1VC/URTAbWNBxEjeng3dHYq+ULDwME+SzsviyV0t+tdRBjEYVgMwprvz4lkPtn
 vmIeKLqdOF/AZ5YeqcwgGmF1zs1+tZHL7Iqo9h7ls86fSZEBY4zdhFYKKmWRyZtxzKShpP
 feEkvwFBd3AmjxqTgK9LtSpjBTE8Joc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-t3gR51_TP7yvVscv1iqIPw-1; Wed, 19 Jun 2024 03:50:04 -0400
X-MC-Unique: t3gR51_TP7yvVscv1iqIPw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42108822a8eso3015735e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 00:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718783403; x=1719388203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0go2MmwOug7Kk4Kw8l1SxCzn4Kij0LtVXdFpMf3FCM=;
 b=WpqC59ocsKi7bbR4hC6isPjo7vSI/Aj7hnG7iOAzvaez6tpRsdRluyhN3DzanEm09l
 D64WRiF5yUcfUr0FVs77p1RpDmpYcubMF4j7F4/ShbNehTDAEoyTxS9zpRH4SCVPdbRF
 4hJn4k2RiNC9qcRbZInXcMh1Cdgj4toEuXU4xVdvYFJ4lMsGyytf4rq8IP6tEHUsBIN5
 U53YSJBZflr5Ywh4uoxIQgJXY1uwcVKXEgTI0qrE4Hj9kZht7N+nzzlNNjSc8yZj8t43
 X/s/6cn4BUiw2T/0jmFQBusJn42F9HASnjOAkc6G6rFEepVjdG+m8OhgeY3YThO2HIJ4
 N6Zg==
X-Gm-Message-State: AOJu0YzLJ4XJS3Bna8NcXwcbFA+vjZc+tbF3UU666+n5/6gw/0jwyFqH
 UK9rWcwKRkFpsMtfpJYJTPJU770I26pNOPwuZ6IVefzHCB0/8pZ3USyJ+Z/xMHn1K/+ZUYNOXOE
 teDnS2O1gFThB3bzZZg82xbjDw7OBvmy0kNZCFQg8GUTglwywvT5DAhbgezGWvfv7ieq7gBzV24
 DkR7s5NdwZBGsz68DIHRuVTyf/fK8=
X-Received: by 2002:a05:600c:4658:b0:421:81a7:b0b9 with SMTP id
 5b1f17b1804b1-42474d1a37fmr18901045e9.8.1718783403208; 
 Wed, 19 Jun 2024 00:50:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz9xePY044LfWVewieN1jswCaPM1PW6thMweBdLi6cxWsE/2D0eLaPwM0C5XEwZ43Hvg3BfJgQDF5jZcssCIA=
X-Received: by 2002:a05:600c:4658:b0:421:81a7:b0b9 with SMTP id
 5b1f17b1804b1-42474d1a37fmr18900855e9.8.1718783402819; Wed, 19 Jun 2024
 00:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240529155548.5878-1-philmd@linaro.org>
 <20240529155548.5878-4-philmd@linaro.org>
 <CABgObfYmuvMq80Xz0ZBZQiHmKgoiSTVVqio8FmmpttT8rg64kA@mail.gmail.com>
 <7ce86375-779d-43d6-9871-7f9587c95ba6@linaro.org>
 <CABgObfbvjG9bBgCwM-kL+YhjhMw1qLnQdQToCEkKW+V3trskoA@mail.gmail.com>
 <d2b81c56-a57c-4fbe-a65e-86e9755e7c48@linaro.org>
 <5c913504-d917-4fd1-86d5-85d3bc293623@linaro.org>
In-Reply-To: <5c913504-d917-4fd1-86d5-85d3bc293623@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Jun 2024 09:49:50 +0200
Message-ID: <CABgObfZ_V+K6mShNVpb3KXG_uyNJatk=0btY8grcpMvoo=seYA@mail.gmail.com>
Subject: Re: [PATCH 3/3] semihosting: Restrict to TCG
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 12, 2024 at 3:13=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> Building qemu-system-mips configured with --without-default-devices:
>
> Undefined symbols for architecture arm64:
>    "_qemu_semihosting_console_write", referenced from:
>        _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>    "_semihost_sys_close", referenced from:
>        _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>    "_uaccess_strlen_user", referenced from:
>        _mips_semihosting in target_mips_tcg_sysemu_mips-semi.c.o
>    ...
>
> So this one has to use "select".
>
> Similarly m68k:
>
> Undefined symbols for architecture arm64:
>    "_semihost_sys_close", referenced from:
>        _do_m68k_semihosting in target_m68k_m68k-semi.c.o
>    ...

Go ahead and use "select" for these. The file to be stubbed would have
to be target/m68k/m68k-semi.c (for do_m68k_semihosting) and
target/mips/tcg/sysemu/mips-semi.c (for mips_semihosting), not the
common code.

Paolo


