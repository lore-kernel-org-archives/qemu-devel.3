Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAF3E77197
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 01:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUcA6-0002n5-Bd; Sun, 05 Jan 2025 20:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1tUcA4-0002mt-ME
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 20:44:08 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1tUcA2-0004AW-G8
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 20:44:08 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21644aca3a0so11815975ad.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 17:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736127844; x=1736732644; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXVlqQhQ0djXOrZiaxtukDYqq5HUZ79r1z+DFItEenU=;
 b=I0xrxhQhOWcJ+s5IBRIkz5Ur4Jfz3MuBzyS8R+M5Wvg0vG/pjmm7msDPD+xtmw/wYl
 9wy8S8wt28vx4IuIUB4rbVa4qdRJ/RtJQoXGU16JC6SdC7IBQKeC6gwC/1UFXZ+AN251
 heuNgU+HK0S81B2v+DZxghKIq8JxrGyoZ5JdXrr4pD2y/Mr6gf/d7K5bQ02IbhKNwpgF
 +gJt47qAzA4pmJzYn8ItsRsRYpWaMxpuzEBeEClIQCZTM7MlEFhHLsFFxfM46zkDiLUL
 s4xBqI0ujgX6+pnC19ag7zlfyoakhr+rxCbs4/uMZzx7iKqApcrUDRpPWuHM93qympx8
 rpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736127844; x=1736732644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXVlqQhQ0djXOrZiaxtukDYqq5HUZ79r1z+DFItEenU=;
 b=Rsx+jPvPdVRLDBtMwVhExYFXFQud4yBId8k740/ERYcBHuyFgtvuoYNZ6VWvfyEbkW
 DxoMKx4S4RGjI2BPp12wX9ajcx+yYcsIg1togrFgoJC+w9zLgCwNY2SbbW7rCf1eHTpR
 xnZhKYKcdcKFFUmfjJnRUW9SBnIXhsGvx0CdIm4hlH6IarPxuPuXK37cu/dyyfEhc9DO
 6ecVGAVH9BjbaqoDnsicEiumGQnIxeHXrC8fTJiS1FyUsb0hHtX5knr5firfCJk94Elc
 ZYb9Nvm6MCDvSXOxEDsLcVJkmS+gRttsgIZqUbVk643/u+YSXDbgM0Rxf4n8cO08Aa84
 lAdw==
X-Gm-Message-State: AOJu0YxUXBc8jquI5hk3RF6kKoZfwjFTKB4pvjfiFr2yLKYKUhVrRJS+
 disW+DYnQs1PLRBpd7by8yU1ZEL52mjtXIIYJn2oYJmvX8i9tDkTtL26xTyrPiBoq/otF8BmNvA
 fvfwuk4gpgApjj/3pozFujZm6BxQbXee2
X-Gm-Gg: ASbGnctpEezwpWTkPOJUptXV2gy8yEsUaNCz4fPSl0kATsKuRc1TCjsycPDHYadNfTJ
 +ZHFyKymk/TZkUkNuGVRayJQcJQ7UTkuVcfumNH8=
X-Google-Smtp-Source: AGHT+IHiDTHd1N0vv9FhCYfmMr17cHkfUtHi/1oD96qO9NZ4q0MHb5iwVu0KAZwjkuU8tSG/M+YMAGg9ntaKooVGR3s=
X-Received: by 2002:a05:6a21:e8d:b0:1e1:adcd:eae5 with SMTP id
 adf61e73a8af0-1e5e0846948mr83497969637.42.1736127844109; Sun, 05 Jan 2025
 17:44:04 -0800 (PST)
MIME-Version: 1.0
References: <CAEekfLYJqvMDf5A_Yj=N6jMGQ4oj3rC+fv3xcCCfSBy8TDaY-Q@mail.gmail.com>
 <CAEekfLaeMQ-5pZw9+edU8E6jdvz6nCHE0WVZe7-Myg1NBKVLng@mail.gmail.com>
In-Reply-To: <CAEekfLaeMQ-5pZw9+edU8E6jdvz6nCHE0WVZe7-Myg1NBKVLng@mail.gmail.com>
From: Sam Price <thesamprice@gmail.com>
Date: Sun, 5 Jan 2025 20:43:52 -0500
Message-ID: <CAEekfLZsGpjWR07n5qf+z365N93+9-=ia6YhSLJuZQU8mxvmTA@mail.gmail.com>
Subject: Re: Subject: [PATCH] loader: Add register setting support via cli
To: qemu-devel@nongnu.org
Cc: alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=thesamprice@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Bump / Ping

On Thu, Dec 19, 2024 at 6:11=E2=80=AFPM Sam Price <thesamprice@gmail.com> w=
rote:
>
> Bump / ping
>
> Sincerely,
>
> Sam Price
>
>
>
> On Thu, Dec 5, 2024 at 10:29=E2=80=AFPM Sam Price <thesamprice@gmail.com>=
 wrote:
>>
>> I needed to set the registers prior to boot up to mimic what uboot
>> would do prior to loading a binary.  This adds a generic option of reg
>> to the loader command, it uses the existing gcc commands for setting
>> register values.
>>
>> I'm sorry I couldn't figure out how to work the git send-email
>> properly.  Configuring it with my gmail became too cumbersome, and my
>> work email was also challenging to configure.
>>
>> I have the file staged here.
>> https://gitlab.com/thesamprice/qemu/-/tree/loader?ref_type=3Dheads
>> I am unsure of how to add tests for this.
>> I could continue working too polish this off with instructions from
>> others if it is desired for the main line.
>>
>> Signed-off-by: Sam Price <thesamprice@gmail.com>
>> ---
>>
>> ---
>>  hw/core/generic-loader.c         | 28 ++++++++++++++++++++++++++++
>>  include/hw/core/generic-loader.h |  6 +++++-
>>  roms/SLOF                        |  2 +-
>>  roms/edk2                        |  2 +-
>>  roms/openbios                    |  2 +-
>>  roms/opensbi                     |  2 +-
>>  roms/seabios                     |  2 +-
>>  roms/seabios-hppa                |  2 +-
>>  tests/lcitool/libvirt-ci         |  2 +-
>>  9 files changed, 40 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
>> index ea8628b892..ebda8ac43f 100644
>> --- a/hw/core/generic-loader.c
>> +++ b/hw/core/generic-loader.c
>> @@ -55,6 +55,19 @@ static void generic_loader_reset(void *opaque)
>>          }
>>      }
>>
>> +    for (int i =3D 0; i < 31; i++) {
>> +        if (s->has_register_defaults[i]) {
>> +            CPUClass *cc =3D CPU_GET_CLASS(s->cpu);
>> +            uint8_t buf[sizeof(uint64_t)];
>> +            memcpy(buf, &s->register_defaults[i], sizeof(uint64_t));
>> +            if (cc && cc->gdb_write_register) {
>> +                cc->gdb_write_register(s->cpu, buf, i);
>> +            }
>> +        }
>> +    }
>> +
>> +
>> +
>>      if (s->data_len) {
>>          assert(s->data_len <=3D sizeof(s->data));
>>          dma_memory_write(s->cpu->as, s->addr, &s->data, s->data_len,
>> @@ -172,6 +185,20 @@ static void generic_loader_realize(DeviceState
>> *dev, Error **errp)
>>      } else {
>>          s->data =3D cpu_to_le64(s->data);
>>      }
>> +
>> +    /* Store the CPU register default if specified */
>> +    if (s->reg) {
>> +        int reg_num;
>> +        if (sscanf(s->reg, "r%d", &reg_num) =3D=3D 1 &&
>> +                    reg_num >=3D 0 && reg_num < 31) {
>> +            s->register_defaults[reg_num] =3D s->data;
>> +            s->has_register_defaults[reg_num] =3D true;
>> +        } else {
>> +            error_setg(errp, "Unsupported register: %s", s->reg);
>> +            return;
>> +        }
>> +    }
>> +
>>  }
>>
>>  static void generic_loader_unrealize(DeviceState *dev)
>> @@ -186,6 +213,7 @@ static Property generic_loader_props[] =3D {
>>      DEFINE_PROP_BOOL("data-be", GenericLoaderState, data_be, false),
>>      DEFINE_PROP_UINT32("cpu-num", GenericLoaderState, cpu_num, CPU_NONE=
),
>>      DEFINE_PROP_BOOL("force-raw", GenericLoaderState, force_raw, false)=
,
>> +    DEFINE_PROP_STRING("reg", GenericLoaderState, reg),
>>      DEFINE_PROP_STRING("file", GenericLoaderState, file),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>> diff --git a/include/hw/core/generic-loader.h b/include/hw/core/generic-=
loader.h
>> index 19d87b39c8..d81e1632fd 100644
>> --- a/include/hw/core/generic-loader.h
>> +++ b/include/hw/core/generic-loader.h
>> @@ -35,10 +35,14 @@ struct GenericLoaderState {
>>      uint32_t cpu_num;
>>
>>      char *file;
>> -
>> +    char *reg;
>>      bool force_raw;
>>      bool data_be;
>>      bool set_pc;
>> +
>> +    /* Add an array for storing default register values */
>> +    bool has_register_defaults[31];  /* Track if a default value is pro=
vided */
>> +    uint64_t register_defaults[31];  /* Default values for registers r0=
-r30 */
>>  };
>>
>>  #define TYPE_GENERIC_LOADER "loader"
>> diff --git a/roms/SLOF b/roms/SLOF
>> index 3a259df244..6b6c16b4b4 160000
>> --- a/roms/SLOF
>> +++ b/roms/SLOF
>> @@ -1 +1 @@
>> -Subproject commit 3a259df2449fc4a4e43ab5f33f0b2c66484b4bc3
>> +Subproject commit 6b6c16b4b40763507cf1f518096f3c3883c5cf2d
>> diff --git a/roms/edk2 b/roms/edk2
>> index 4dfdca63a9..f80f052277 160000
>> --- a/roms/edk2
>> +++ b/roms/edk2
>> @@ -1 +1 @@
>> -Subproject commit 4dfdca63a93497203f197ec98ba20e2327e4afe4
>> +Subproject commit f80f052277c88a67c55e107b550f504eeea947d3
>> diff --git a/roms/openbios b/roms/openbios
>> index c3a19c1e54..af97fd7af5 160000
>> --- a/roms/openbios
>> +++ b/roms/openbios
>> @@ -1 +1 @@
>> -Subproject commit c3a19c1e54977a53027d6232050e1e3e39a98a1b
>> +Subproject commit af97fd7af5e7c18f591a7b987291d3db4ffb28b5
>> diff --git a/roms/opensbi b/roms/opensbi
>> index 43cace6c36..057eb10b6d 160000
>> --- a/roms/opensbi
>> +++ b/roms/opensbi
>> @@ -1 +1 @@
>> -Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20
>> +Subproject commit 057eb10b6d523540012e6947d5c9f63e95244e94
>> diff --git a/roms/seabios b/roms/seabios
>> index a6ed6b701f..ea1b7a0733 160000
>> --- a/roms/seabios
>> +++ b/roms/seabios
>> @@ -1 +1 @@
>> -Subproject commit a6ed6b701f0a57db0569ab98b0661c12a6ec3ff8
>> +Subproject commit ea1b7a0733906b8425d948ae94fba63c32b1d425
>> diff --git a/roms/seabios-hppa b/roms/seabios-hppa
>> index a528f01d7a..673d2595d4 160000
>> --- a/roms/seabios-hppa
>> +++ b/roms/seabios-hppa
>> @@ -1 +1 @@
>> -Subproject commit a528f01d7abd511d3cc71b7acaab6e036ee524bd
>> +Subproject commit 673d2595d4f773cc266cbf8dbaf2f475a6adb949
>> diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
>> index 9ad3f70bde..9bff3b763b 160000
>> --- a/tests/lcitool/libvirt-ci
>> +++ b/tests/lcitool/libvirt-ci
>> @@ -1 +1 @@
>> -Subproject commit 9ad3f70bde9865d5ad18f36d256d472e72b5cbf3
>> +Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb
>> --
>> 2.45.2



--=20
Sincerely,

Sam Price

