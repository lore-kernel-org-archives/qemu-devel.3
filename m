Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCF7C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 01:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuiMH-0000Eh-Kb; Tue, 18 Mar 2025 21:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuiLb-0008Fn-3R
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:35:58 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuiLZ-0007Ys-II
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:35:54 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-86b9d1f7249so5752991241.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 18:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742348152; x=1742952952; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eg9C+/HLRATlJEPnRAb3vk6RChN+GHbFU9e9gUHnq0w=;
 b=Gon0xm8RO1B3tFxlnNKZunlQHeM8XMBG8NRIAFjkSgxl2TXt0pEk19Jvt+bj1ulQ6s
 1dNKM4tlINeKPwfJeiZOHm6xRgdO3URiBGWZGo3Vr97TLGDejCbpyTQxoASpaX5GFisj
 N+TP5iCTV4KzqlHXxLxgB4ZOUhjgojSfpWwLxEP7OlVKmVQL7XJ9vch+hla1LC4CxmxA
 MjX0YN7Ngnt2iHHSoIUicuQphuSBfnDIjPn7o7mUGXJN8i8QJG4M6mmlOxLzCZdsy8KE
 +NZ9b1ImiFxTM2sv5RDx1PjhLhbd17uW9hBVSM8u44GbDVPhC1gNt0uSLY20axKnH5H4
 ACaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742348152; x=1742952952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eg9C+/HLRATlJEPnRAb3vk6RChN+GHbFU9e9gUHnq0w=;
 b=oIIsDKgZlHhemjcM2Ey2FnL1DOeYVXqbleRKvNvOML9B2xch7jsbODeFZMklYIF1qS
 y8mbkDrZhYRECGdE7hoJXkVWQWn+UTBdzCcl3MabLZkJQkyaqauSUlx23Q3ajwQ/tSaB
 YF6BPG4JlQK9NAeclUFHqrSWMWGb5TPJDprw75gkQfYynBfrRPP6nXJClmpubbIUXWAW
 SlBCjKECyB0ox4onVB+4HvdaGKTgn9+oN06osZ0igt1tNFoQ3vCD7W1+AsJdd0+F6YDy
 bk9edRVkQhUgMvj5vl2fQu8FWuEvw2WiTxyTZrnX59yVoQ0JQtec3zWYLEk4XrZlOwQp
 pxHA==
X-Gm-Message-State: AOJu0YxqepGFr+jgQgHiRdoMUmEdij0QcqFkTjcHqNLX/r1TwHWakQ09
 ekuSACpkOKrPqgL/2+35dJ4U/6iRddIHTMBu0rrVmWkULBpjb83ESAklgspUkn8vz6JO26IQz/b
 OWPBYNpbLBmFTJmKi/bf+wQ9uIiA=
X-Gm-Gg: ASbGnct6PUmrtSTvuS88r8TBYa9iABQJD2Ko3OjxaH6ZSITsAzGcBLH9c1FLrC5ZR58
 /IhR+c++j3sItBnpsXSxDkWS1j3pnIxuKyCov3APb3NwsQQB2BSePu9/ZTk5rREdoqIZ7lfrGNM
 WNBHl+0K3t2120hAva6HxdhgL5r+Iu+Yhu3P+mto39K5t7EtSNS6kYpyg=
X-Google-Smtp-Source: AGHT+IEDVhru/he0tWRsQ6SyqHO6TFanjSuSEup6ObHyTJN1DNBt9nAuXJxS0V4vpKOo39/cgmBYchSgmv78EgvntSs=
X-Received: by 2002:a05:6102:80a1:b0:4c1:9b88:5c30 with SMTP id
 ada2fe7eead31-4c4ec816546mr754920137.19.1742348152246; Tue, 18 Mar 2025
 18:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-3-pbonzini@redhat.com>
 <CAKmqyKMdUONoXD69m3RH1PeoLLtL8qT-eXweVh9WHEZM5Feufg@mail.gmail.com>
 <ab9b6720-cb48-4b8f-9059-2856c78b5577@redhat.com>
 <CAKmqyKP4Fe1FHyW=fpxa47SDq=Tz2-7rAcjTxv8W2L9+q5-oCQ@mail.gmail.com>
 <CABgObfbVWoCwM7W0Mej_4FyfDLHagtun-ieHPpynsfO=s9M4=A@mail.gmail.com>
 <CAKmqyKPOdzB=yKzv2q3+Zn-MrpAuaPwbeZscvreT1=2CWebvTQ@mail.gmail.com>
 <CABgObfY3wQUMPiUOQnU+GAv68rE2LtWhBTCrPupbF_NuxxhvhA@mail.gmail.com>
In-Reply-To: <CABgObfY3wQUMPiUOQnU+GAv68rE2LtWhBTCrPupbF_NuxxhvhA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Mar 2025 11:35:26 +1000
X-Gm-Features: AQ5f1JqjM8PT92tCN7No5Te9efj5oC3L3pNNQPltfeC7xWqk8RXA6WXsbrwYpbo
Message-ID: <CAKmqyKNV=A5kkN3QR=_MWQ2=BC7raX3y2puh7LR4f7Zmk9UW8Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] target/riscv: env->misa_mxl is a constant
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Tue, Mar 11, 2025 at 4:18=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
>
>
> Il lun 10 mar 2025, 23:18 Alistair Francis <alistair23@gmail.com> ha scri=
tto:
>>
>> On Tue, Mar 11, 2025 at 3:34=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
>> >
>> > On Fri, Mar 7, 2025 at 1:45=E2=80=AFAM Alistair Francis <alistair23@gm=
ail.com> wrote:
>> > > I'm not convinced that this is the thing that we should be checking
>> > > for. If someone can corrupt the migration data for an attack there a=
re
>> > > better things to change then the MXL
>> >
>> > In principle you could have code that uses 2 << MXL to compute the
>> > size of a memcpy, or something like that... never say never. :)
>>
>> But couldn't they also change the PC at that point and execute
>> malicious code? Or MTVEC or anything else?
>
>
> The point is exploiting the host, not the guest.

Ah! Ok, I misunderstood.

>
>> It just seems like this check doesn't actually provide any security.
>>
>> In the future we will want to merge misa_mxl and misa_mxl_max and this
>> patch just makes that a little bit harder, for no real gains that I
>> can see.
>>
>> > Do you prefer turning all the priv_ver, vext_ver, misa_mxl,
>> > misa_ext_mask fields into VMSTATE_UNUSED? That would also be okay.
>>
>> I think we do want to migrate them, they contain important information.
>
>
> They are constant though, aren't they? Properties aren't migrated, they a=
re set on the command line of the destination.

I didn't think about properties not being migrated.

At which point I think it does then make sense to make them VMSTATE_UNUSED

Alistair

