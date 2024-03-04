Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9907C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 09:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh4lp-0004ya-8q; Mon, 04 Mar 2024 04:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rh4lk-0004y4-Rp
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 04:38:01 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rh4lj-0007BT-54
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 04:38:00 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29a5f100c1aso2279834a91.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 01:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1709545077; x=1710149877; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZVaYJSDIJrKUudt1EhW6wPABzYYVV8eR2a9ldebosM=;
 b=W4eQEjE8cY4U0DuglxOsxVTgnLyG9B7GwmR+Ne3CHpuXLAcSBqsheJYCmnoNoJf/3k
 s/3GySvNeulO849kK0/mFRUH/9yLI7JCnzKM5l+YkWSGPoLkZ4Mwx24VqeydiiIe4SVG
 4lyCb/Lz9s+11/fVMv28cdwCmtnUNE9qXCF3mm8fHQNoSMTieWxMY/yd6Ap+GtL37u4O
 sQzOpT15Z93m4JoDMdQ2QstsRQXQ9zkpjAZU9qYUrFLmPxe+50IaG8NK9UNki+LWTDSJ
 Fj/ztaD34AXiJZL7HLYY0I48EZ/bJ9+T2fz/uSDgLIhXyyxQh46qBkgiZKnMIchySvIS
 1S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709545077; x=1710149877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ZVaYJSDIJrKUudt1EhW6wPABzYYVV8eR2a9ldebosM=;
 b=D6T7QsMiMbYiR+ujEb/RWLJVR3qsJVSeqedDJgkVcp27vRtE0Jnl0E2wTNTRQleSre
 cCmhJwyUXzeF8OebmaPXmqAUCeRGw2WNd6bhxhENsa7Fzd/UqiHG43nJpIkljjYJTh4I
 F4JVUkie8amp+4YrJNzd9TmJjDh5Nk+z5yU4YxidnDEtO/oVH441b1aa8Qyxw+iaGDDx
 nkaLOIozee5AAHTdF4MSAyCKkA5IOeIUY8zK/gieF1KGnJVQqEe8mNfZBexwUD+EyAHf
 zHFzUdY0pvykvbwOgBGvx5DX+MYmBcxN7wd+YtFsad2gc+z0rbsGMa8d+vgRXqRF8ghL
 r3mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz5xV6XvJ0GtEtHDCOOcLxYYBOjAwhtpvVSXh6BN1pv6bH8xiFeOzAonf4Zb8yCoEXnsH5RpaSUy9RddCNO4dVOB9jIiI=
X-Gm-Message-State: AOJu0YwGob4sIUSV5HATvjrxWWcOcBWC2pkrOy8DEsB9EtZNF8D2GpNF
 1rOBdXQFQJZawCtZGBaEkPtCsdTRWy3DgIznODIawhvEafUWYKoPynHLzJ3rYEz3SpQ7U3mdL3N
 SDRL5a2z8Z0fBUaGq9CeyW3XQEmyrvrRD17iz
X-Google-Smtp-Source: AGHT+IG+53Uh8pz/yPGc5HvHTG5YWJ+r/87+7XUJ8Psz/XGc2px1Fkja0v07UKZCS2yQVfNcAa1ckgBUWsmxRYScg7c=
X-Received: by 2002:a17:90a:ca8e:b0:29b:4dfc:7107 with SMTP id
 y14-20020a17090aca8e00b0029b4dfc7107mr1469953pjt.38.1709545077474; Mon, 04
 Mar 2024 01:37:57 -0800 (PST)
MIME-Version: 1.0
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 <87a5nvci5n.fsf@draig.linaro.org>
 <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
 <87y1bfawik.fsf@draig.linaro.org>
 <CAOpGCn+_=5Uxi9mt-C1V3pguNT0OUJura-H3SwBOsJnW5tyJ4g@mail.gmail.com>
 <CAFEAcA-03JYx9szd3FrQ_786gaRLWCJVHeMgjBxxvgH85f-78A@mail.gmail.com>
 <CAOpGCn+vQ7wupMqeH8ZLarT0c4gD85R6cgRqBMhVeAXtZ1F_Mg@mail.gmail.com>
 <CAFEAcA9Yp=ObPhgagAbf2Ev=6=D+9sCfHC_HCxPUr2JgvWa4oQ@mail.gmail.com>
 <CAOpGCn+BHsVPG1_2-avx6Ex10dc-nKYuVv=3VTct=MYRb4TmYw@mail.gmail.com>
 <CAFEAcA9_MDHQyQ6q76OpUXgEO9f_osS23oMhyTC4vNSBqtD1-A@mail.gmail.com>
 <871q94ahui.fsf@draig.linaro.org>
 <CAOpGCn+-T3e8arn0UPTM5-1gJu9626wP3=FHamXvUFW6NrDJcg@mail.gmail.com>
 <CAJ307EgMiRDLaHD1P8_EBLwhLct6z+Wp15sXTqMV83F0mC1sLA@mail.gmail.com>
 <CAOpGCn+PhxqRb=UjKM=z1q79u_iCH=RKW1=DDGUbWnBf4Q0kog@mail.gmail.com>
In-Reply-To: <CAOpGCn+PhxqRb=UjKM=z1q79u_iCH=RKW1=DDGUbWnBf4Q0kog@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 4 Mar 2024 10:37:46 +0100
Message-ID: <CAJ307EhpocLQ5p+MU++pTpotMuDTCedzNGWohvm6F02LXkhcrA@mail.gmail.com>
Subject: Re: QNX VM hang on Qemu
To: Faiq Ali Sayed <faiqueali.109@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Stefano Stabellini <stefano.stabellini@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=chigot@adacore.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Mar 1, 2024 at 6:48=E2=80=AFPM Faiq Ali Sayed <faiqueali.109@gmail.=
com> wrote:
>
> Hi Cl=C3=A9ment,
>
> So the output of the command
> |  $ qemu-system-aarch64 -M xlnx-zcu102 -m 4G -no-reboot -nographic
> -kernel qnx.img
> is
>
> $ pulseaudio: set_sink_input_volume() failed
> $ pulseaudio: Reason: Invalid argument
> $ pulseaudio: set_sink_input_mute() failed
> $ pulseaudio: Reason: Invalid argument
>
> I am not using the "mkifs" rather I am using the command below..

I guess we disabled some options when we built our kernels to allow a
simple command line. However, I don't know which ones.

> $ mkqnximage --type=3Dqemu --arch=3Daarch64le --build  --ssh-ident=3Dnone
>
> if I use the --run option with the command it creates a VM which is worki=
ng fine.
> but when I use this image, with qemu command terminal is getting stuck.

I wasn't aware that such a command exists. However, the --run option
seems to call the script "runimage". You might want to take a look at
the options being set or maybe simply retrieve the qemu command line
created by it (if that's not how you created your first command line).

Sorry to not be more helpful.

Cl=C3=A9ment

> BR!
> Faiq
>
>
>
> On Fri, Mar 1, 2024 at 4:29=E2=80=AFPM Cl=C3=A9ment Chigot <chigot@adacor=
e.com> wrote:
>>
>> Hi Faiq,
>>
>> On Fri, Feb 23, 2024 at 3:55=E2=80=AFPM Faiq Ali Sayed <faiqueali.109@gm=
ail.com> wrote:
>> >
>> > So as far as my understanding, we provide these binaries using Qemu co=
mmand as depicted in the example you provided and there is no way I found t=
o put them into a single image.
>> > Regarding the overlapping space, I don't have much idea but I think we=
 could provide a starting address separately to these images something like=
 addr=3D0x00100000.
>>
>> Where is this 0x00100000 address coming from ? Could you confirm with
>> "readelf -h" that this is the entry point of your image ?
>>
>> Alternatively and that's what we used locally, qemu is able to guess
>> the entry point of an image, when passed from -kernel. Therefore, our
>> command simply looks like:
>>   |  $ qemu-system-aarch64 -M xlnx-zcu102 -m 4G -no-reboot -nographic
>> -kernel qnx.img
>>
>> I'm not the one having built the qnx.img we're using. But it looks
>> pretty standard at the first look, made with "mkifs" and the kernel
>> specs from zcu102 evaluation kit.
>>
>> Hope it helps,
>> Cl=C3=A9ment
>>
>> > So as per your suggestion, I compared my images and I found that the i=
mage does not show a virtual disk, and other commands like mkdir, do not ha=
ve these binaries.
>> > So these binaries are not included at the time of image creation and I=
 don't exactly know that how can we add these binaries into the QNX image.
>> >
>> > The Image that is currently installed in real hardware does not have a=
 debugging symbol, so I can't use GDB  to debug that.
>> > Now I am looking for a way to create the correct QNX OS image for Qemu=
.
>> >
>> > Any lead in this regard will be really helpful :)
>> >
>
>
>
> --
> Kind Regard-
> Faiq Ali Sayed
>
>

