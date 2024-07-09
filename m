Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92E3C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 10:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR8Az-0003I4-9F; Tue, 09 Jul 2024 06:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sR8Ay-0003F5-GV
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 06:34:24 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sR8Av-0007K2-3u
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 06:34:24 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-58b447c5112so5601285a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 03:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720521259; x=1721126059; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+oILmoLrI990Vx21r5HdKpI2tOk6tNKi1Eso8W3tIA=;
 b=MzHvDtcQwhViz/r9nX2DXx8qXRmuiI0dAAWQ2sKj76c3O8ufxj4i2MHAU+4LIs1f0L
 3rEkXEslWQ2AOGkiO1B/kU7Wlt7n1/VI6EGM1DLFhgvxXkH7R7LaGgAzK7r0RPQEIR2e
 6bV1crABUH8GBuntoNlsfSMlvOuCXC4iSjDBEDWxecR/55KjDMmLZzuTYDrg5lWMFoP9
 9gVRyGiFkkfpg/CBSYOX7WWPqh3G2vrUjdTFGK3Lt3qfXwrQYPBbua31PW6hZGKRr73t
 VYRbJTPErz/4aXqv8aD8YKfACRcAJAn8ljdQgi3hxgdAuhQ/fWZtQl5e4/hUux0y0KOW
 GbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720521259; x=1721126059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+oILmoLrI990Vx21r5HdKpI2tOk6tNKi1Eso8W3tIA=;
 b=vR0a4WbPLsmmeZ8MtsoIMfIW5lj+gpnIYGRa4PxZPBzn+cswWJrbKBN4/JHrU+wgCk
 qfMONYFQjOg4r0gjHlOU/Av5AxxHaYg0xWbbpKjSt9y1CoGW34FPv0hVClQc1/tMn9If
 HnKDmNGXgpEPPEs45vVqaDDHws4yRi2tqbja6bKbNFwRg3Ng8MNubwHlVN1wDzEvlTb3
 IF4Uteq7CiEHbQOXiWQO/HCCQJE6ZlhAtGBJirkJm8sfusBhsQud+Q03ZuA+MEJCC7gO
 H6bYzNKRyQ0WJd0ZeejpD/qErFoFA6BMwCN9d51ZjKjMvtYy5RpFHVrtb607D1L+95wx
 wrBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ5NcKSs7yvZvR5AaNVoMDnkaLL1Y8QvlNb5lcTYpq+mLIss5/Fk+VX+IYg8LVX+2mtX5fAaFU0m/oVTYg6r6kjI6Yquc=
X-Gm-Message-State: AOJu0YyTsO7kO/cT81A78QK45hPOvgA5oYu7V0gXLgjtgcZeIumxTRuR
 vPzY2cXo3hF1QL6y5W0BEXDCVo1CTpPNvMKSKF2vsFnVuJEEvS/Fn2OGIOSabBJQzQ9SYcz3kjE
 2y9Ogu9vHxO8YilryfZUMEI8OnStDe8SgRMQkfQ==
X-Google-Smtp-Source: AGHT+IGOp3ulL5WhZDnJbpNOL/VnSHXSqBkRsMM0QJP2Nn1SLROCqlyX6Nx43WVV1LMk8ErXTW2UWfsblCJdi0aOPpk=
X-Received: by 2002:a05:6402:1ed0:b0:58b:8a20:f553 with SMTP id
 4fb4d7f45d1cf-594baa8bb88mr1555950a12.9.1720521258512; Tue, 09 Jul 2024
 03:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <8dfd1047-436d-4157-83cb-9cad399544fe@redhat.com>
 <ZowUyFX7zcK1FvuG@redhat.com>
 <CABgObfZfQNSeYeCqcuNHcu=pyKz+f_MUc=9rZGRYxaPNBO-U4A@mail.gmail.com>
 <Zowd-UxAnPmJSA0G@redhat.com>
 <CABgObfaDKhKBcpmgypST=bo2KSqoNMCLKP-8oAvppxt9GDxBPA@mail.gmail.com>
 <CAAjaMXa6E0koPXcytY9hEuUbhLeFcJqZsA3fz10q_HF0grz24w@mail.gmail.com>
In-Reply-To: <CAAjaMXa6E0koPXcytY9hEuUbhLeFcJqZsA3fz10q_HF0grz24w@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 9 Jul 2024 13:34:02 +0300
Message-ID: <CAAjaMXbW1tf8c9nGr4JxbsY_aHHgL26hWj1dzU04R=-7izaRww@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 8 Jul 2024 at 21:39, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
>
>
> On Mon, 8 Jul 2024, 21:34 Paolo Bonzini, <pbonzini@redhat.com> wrote:
>>
>>
>>
>> Il lun 8 lug 2024, 19:12 Daniel P. Berrang=C3=A9 <berrange@redhat.com> h=
a scritto:
>>>
>>> That's exactly why I suggest its a pre-requisite for merging
>>> this. Unless we're able to demonstrate that we can enable
>>> Rust on all our CI platforms, the benefits of Rust will
>>> not be realized in QEMU, and we'll have never ending debates
>>> about whether each given feature needs to be in C or Rust.
>>
>>
>> In that case we should develop it on a branch, so that more than one per=
son can contribute (unlike if we keep iterating on this RFC).
>>
>> Paolo
>
>
>
>
> If you do, I'd really appreciate it if you did not use any part of my pat=
ches.


Someone pointed out to me that my wording is really bad here and I
agree, I apologize. I did not express myself with the right words.
What I wanted to say is that hypothetically my work can be used as a
base just not the patches/sign offs. The changes in the patches are
all open source and part of the QEMU community now, of course.

