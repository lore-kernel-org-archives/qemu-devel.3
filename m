Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629CDC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR5RB-0006fb-0u; Tue, 09 Jul 2024 03:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sR5R9-0006f7-Al
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:38:55 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sR5R7-0005hB-OY
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:38:55 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa6b3so2547472a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720510730; x=1721115530; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gpCUWUUDAuqYfJpkPsTRK/s6Cjm8F8IuDVTIuMaEKU=;
 b=GXdNftFkj8rVFJqnYO/Lmm73dW5rv1bO8Mds/V8n8RbYpavwv6J9xf4qkVNUKky05v
 G1bekjW3UKAavpsZux9FXNvR5lPDq3icEiEHVz26zeXuEiu1JzRy0zK1YNk9SbOyx9RL
 DwuNHbGIL5PCFhrI6zqGy7hP1kuWHSOKLQFsdFDlhAWhepQFBmxsOnSQXOC8q0LVhnZ7
 Usj4JaGS07cJWWoZ2M2W6lPzQ0+AbZAecMhJp3bfDf1GX4AicjpTZpJMnzbF2cMQX3Uh
 JihmrRLaVFQ4AGgWpmYDxcpH/rqOItotBCr08Hak4niW3Jkz5QHO6+12s7yIHWkH3X/t
 0kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720510730; x=1721115530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gpCUWUUDAuqYfJpkPsTRK/s6Cjm8F8IuDVTIuMaEKU=;
 b=D788hmm2CHRQf6yrDoKidJ8/AWfTN+VsP+TNQ/f00kLiSsNg5qJwJhDCXxkhF+ZOc9
 H7vXQVJQlsF7KoVTfthDaZiig8qO7pqCnZSlFccY9jmWaFlPzRVLurd7VuOa2Boyw5pK
 7//joyCtOveqV/fg/okJpNyqOzU9da6n7VYn7tTNaxgjcbNV78LXKAt0oH/tRipa9LK4
 5gMxAiWdMojoF44VejSXmqygEs5yXiRs9d1odh0NQdLASNsQ8juAADHOIPuT/oKYW7hl
 gp7xnTJ0AFXMG5zAX6FMTZ0XHrK2enHONDM9s7G8HgnmjPls14NaECU+0IL6LgcEPxVO
 V4CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUExP9U63Yai2pRM2XTlz0u+bWzHhc4QbDYpfcw4m25pDu9LDyubHx7F5ZCqnFjZ4LIBOsCXYJqgrOa4n6VnbObIG3FYtQ=
X-Gm-Message-State: AOJu0YygnCgSSTlM2519dnu7jyJveagzL7OuHc/nR7YDhkSOlrJZj5+Z
 ahDYFRWbLBqhk0ZPWgBOet/ujAXTLIUPIYi3QdwUBitcPFuf6X0n+EWp6oCkznosCLjRHHftk1E
 fuXfHms12HC/zENm/HYcfgR3d5uqWfkQFND8DEQ==
X-Google-Smtp-Source: AGHT+IE3mLebaNuNvKvACUA5TaXl+ZCAqL7IOyBAIvYroGVwsufAPN1JRnDOpnqe8KS4euxR/Mm0MmDn77wUyrKGRb0=
X-Received: by 2002:a05:6402:1258:b0:57c:dd3a:f399 with SMTP id
 4fb4d7f45d1cf-594bb18066emr1388592a12.12.1720510730243; Tue, 09 Jul 2024
 00:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <8dfd1047-436d-4157-83cb-9cad399544fe@redhat.com>
 <ZowUyFX7zcK1FvuG@redhat.com>
 <CABgObfZfQNSeYeCqcuNHcu=pyKz+f_MUc=9rZGRYxaPNBO-U4A@mail.gmail.com>
 <Zowd-UxAnPmJSA0G@redhat.com>
 <CABgObfaDKhKBcpmgypST=bo2KSqoNMCLKP-8oAvppxt9GDxBPA@mail.gmail.com>
 <CAAjaMXa6E0koPXcytY9hEuUbhLeFcJqZsA3fz10q_HF0grz24w@mail.gmail.com>
 <CABgObfa8KQOu6RPs1aqKww8qPeOjHppbH15aBCN+KvaOL=_W9A@mail.gmail.com>
In-Reply-To: <CABgObfa8KQOu6RPs1aqKww8qPeOjHppbH15aBCN+KvaOL=_W9A@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 9 Jul 2024 10:38:34 +0300
Message-ID: <CAAjaMXZ+Sx_+4sNFs=zy+bP0d5gbyf_Buh9JS-ixsRCfxsdN4w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/7] Add Rust support, implement ARM PL011
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 8 Jul 2024 at 21:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
>
> Il lun 8 lug 2024, 20:39 Manos Pitsidianakis <manos.pitsidianakis@linaro.=
org> ha scritto:
>>
>>
>>
>> On Mon, 8 Jul 2024, 21:34 Paolo Bonzini, <pbonzini@redhat.com> wrote:
>>>
>>>
>>>
>>> Il lun 8 lug 2024, 19:12 Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
ha scritto:
>>>>
>>>> That's exactly why I suggest its a pre-requisite for merging
>>>> this. Unless we're able to demonstrate that we can enable
>>>> Rust on all our CI platforms, the benefits of Rust will
>>>> not be realized in QEMU, and we'll have never ending debates
>>>> about whether each given feature needs to be in C or Rust.
>>>
>>>
>>> In that case we should develop it on a branch, so that more than one pe=
rson can contribute (unlike if we keep iterating on this RFC).
>>
>>
>> If you do, I'd really appreciate it if you did not use any part of my pa=
tches.
>
>
> "We" means that you would accept patches, review them and apply them unti=
l any agreed-upon conditions for merging are satisfied, and then send eithe=
r a final series or a pull request for inclusion in QEMU.

Ah, alright. That wasn't obvious because that e-mail was not directed
to me nor did it mention my name :)

I do not want to do that, in any case. I do not think it's the right approa=
ch.


--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

