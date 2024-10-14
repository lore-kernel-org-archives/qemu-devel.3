Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B004D16273
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Lag-0001il-7t; Mon, 14 Oct 2024 09:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0LaY-0001af-Ar
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:58:26 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0LaU-0006Pd-Vr
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:58:20 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb3ce15172so20093341fa.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728914297; x=1729519097; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qS0ietNQqfeiIChhKIrK0X2O7VvPdhcYbfFtiPLNbFE=;
 b=BMxZEdgTSeFMSILNOyufsPcqC9Yvg/wDq97WsjtvXAEEtthWD4ZN4MZQk2X0Cym26W
 WTL7QGELRKAnoAfCBMcxyZrPbynAFKwaiLX+bZyKw9qrDHwDr0u0Prwimj/GiFeu+q0g
 1Hzp3tTYUlyzhXMSm+avxkZfu92CROt5vaMgrlniwQJP+1gmuGWMonSRNIg33bfAiJVc
 HxU58VZ3z52NWH4s6EdvpdNj1LKyvW76/EP1E6MXDFudkMTV0V20O2UybhdQmLP0qy6w
 jqvqx1/mjzS6+chvYF8k7UVNzyWrNQv/kDhfXBFrBZPPqCFkdEYJPqBw4r/wZyZ7JWiE
 mAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728914297; x=1729519097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qS0ietNQqfeiIChhKIrK0X2O7VvPdhcYbfFtiPLNbFE=;
 b=DR23EoV49MCujcSheI5VR3Mc3ieHbptVos8qezM27P+RkTMZNvOQ34GEKxQ0kF1bYP
 uKCd0S20gXeW3FZAtyi4i4mCA2G6EniYZ5BvRWBvW/7QjxlFzWIjSw7/JWfT96bDICpX
 ZHL35V+YdKXhZAKz2pkO3fWxodfxGKKSMYbXt4t2KCCK4CRXNrtuKxVmZPnZHC4TTNBx
 S+mnTiMlz7vfdypEpxDvuh7hA9h38EXW+w0yK2GuTGrrqq56F/H+smLK+Gt//wZRQoXa
 BHIIyPGi+MI13fmndjbHeZ1shWy/cZL3Jv1YEUoFR6t9+uGrSvbcnzsD1xxtSeyza4VZ
 pa5g==
X-Gm-Message-State: AOJu0YyzE3C2xdG1ZE9c7nD/I8ZMCxbMXRspUb59HQpLLzWEWmdHvj/D
 hkoWp6nIGQXFM+zqJEVksjrHsouEIB5eAM0zpfrWXkNrNN+EaE7aMNknSt8fXM8XQ4DM10r7uhN
 vMnZmoqJOYyA+Zc0Xw+FyPw2n5aU=
X-Google-Smtp-Source: AGHT+IES7c3e/oHPC80synhDYscz/HEXCIki5ycMv3b6NuWOsfRP7d6u6Xjlw0sXBgfMASj1iHKFdwJsR9w0FlOnIpw=
X-Received: by 2002:a05:6512:689:b0:539:fc9a:12e1 with SMTP id
 2adb3069b0e04-539fc9a1473mr351282e87.27.1728914296726; Mon, 14 Oct 2024
 06:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241014114135.389766-1-r.peniaev@gmail.com>
 <20241014114135.389766-7-r.peniaev@gmail.com>
 <CAJ+F1CLwNjxT=OogC=4ujzrSHVZRA8mGqK21khUUKe-OxMoTGA@mail.gmail.com>
In-Reply-To: <CAJ+F1CLwNjxT=OogC=4ujzrSHVZRA8mGqK21khUUKe-OxMoTGA@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Mon, 14 Oct 2024 15:56:12 +0200
Message-ID: <CACZ9PQV+-ZjKZUxJOb2g80zTMKXMizWMwzW3bsi16BPs1YnMBQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] chardev/mux: switch mux frontends management to bitset
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x22c.google.com
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

On Mon, Oct 14, 2024 at 3:20=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
>
>
> On Mon, Oct 14, 2024 at 3:45=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
>>
>> Frontends can be attached and detached during run-time (although detach
>> is not implemented, but will follow). Counter variable of muxes is not
>> enough for proper attach/detach management, so this patch implements
>> bitset: if bit is set for the `mux_bitset` variable, then frontend
>> device can be found in the `backend` array (yes, huge confusion with
>> backend and frontends names).
>>
>> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
>> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
>> Cc: qemu-devel@nongnu.org
>> ---
>>  chardev/char-mux.c         | 41 +++++++++++++++++++++++++-------------
>>  chardev/char.c             |  2 +-
>>  chardev/chardev-internal.h |  2 +-
>>  3 files changed, 29 insertions(+), 16 deletions(-)
>>
>> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
>> index 9294f955462e..9c3cacb2fecd 100644
>> --- a/chardev/char-mux.c
>> +++ b/chardev/char-mux.c
>> @@ -26,6 +26,7 @@
>>  #include "qapi/error.h"
>>  #include "qemu/module.h"
>>  #include "qemu/option.h"
>> +#include "qemu/bitops.h"
>>  #include "chardev/char.h"
>>  #include "sysemu/block-backend.h"
>>  #include "qapi/qapi-commands-control.h"
>> @@ -168,12 +169,19 @@ static int mux_proc_byte(Chardev *chr, MuxChardev =
*d, int ch)
>>          case 'b':
>>              qemu_chr_be_event(chr, CHR_EVENT_BREAK);
>>              break;
>> -        case 'c':
>> -            assert(d->mux_cnt > 0); /* handler registered with first fe=
 */
>> +        case 'c': {
>> +            unsigned int bit;
>> +
>> +            /* Handler registered with first fe */
>> +            assert(d->mux_bitset !=3D 0);
>>              /* Switch to the next registered device */
>> -            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
>> +            bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, d->focus + 1=
);
>> +            if (bit >=3D MAX_MUX) {
>> +                bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, 0);
>> +            }
>> +            mux_set_focus(chr, bit);
>>              break;
>> -        case 't':
>> +        } case 't':
>>              d->timestamps =3D !d->timestamps;
>>              d->timestamps_start =3D -1;
>>              d->linestart =3D false;
>> @@ -243,15 +250,16 @@ static void mux_chr_read(void *opaque, const uint8=
_t *buf, int size)
>>  void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
>>  {
>>      MuxChardev *d =3D MUX_CHARDEV(chr);
>> -    unsigned int i;
>> +    int bit;
>>
>>      if (!muxes_opened) {
>>          return;
>>      }
>>
>>      /* Send the event to all registered listeners */
>> -    for (i =3D 0; i < d->mux_cnt; i++) {
>> -        mux_chr_send_event(d, i, event);
>> +    bit =3D -1;
>> +    while ((bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) < =
MAX_MUX) {
>> +        mux_chr_send_event(d, bit, event);
>>      }
>>  }
>>
>> @@ -276,10 +284,11 @@ static GSource *mux_chr_add_watch(Chardev *s, GIOC=
ondition cond)
>>  static void char_mux_finalize(Object *obj)
>>  {
>>      MuxChardev *d =3D MUX_CHARDEV(obj);
>> -    unsigned int i;
>> +    int bit;
>>
>> -    for (i =3D 0; i < d->mux_cnt; i++) {
>> -        CharBackend *be =3D d->backends[i];
>> +    bit =3D -1;
>> +    while ((bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) < =
MAX_MUX) {
>> +        CharBackend *be =3D d->backends[bit];
>>          if (be) {
>>              be->chr =3D NULL;
>>          }
>> @@ -304,7 +313,10 @@ static void mux_chr_update_read_handlers(Chardev *c=
hr)
>>  bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
>>                               unsigned int *tag, Error **errp)
>>  {
>> -    if (d->mux_cnt >=3D MAX_MUX) {
>> +    unsigned int bit;
>> +
>> +    bit =3D find_next_zero_bit(&d->mux_bitset, MAX_MUX, 0);
>> +    if (bit >=3D MAX_MUX) {
>>          error_setg(errp,
>>                     "too many uses of multiplexed chardev '%s'"
>>                     " (maximum is " stringify(MAX_MUX) ")",
>> @@ -312,8 +324,9 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBack=
end *b,
>>          return false;
>>      }
>>
>> -    d->backends[d->mux_cnt] =3D b;
>> -    *tag =3D d->mux_cnt++;
>> +    d->mux_bitset |=3D (1 << bit);
>> +    d->backends[bit] =3D b;
>> +    *tag =3D bit;
>>
>>      return true;
>>  }
>> @@ -322,7 +335,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)
>>  {
>>      MuxChardev *d =3D MUX_CHARDEV(chr);
>>
>> -    assert(focus < d->mux_cnt);
>> +    assert(find_next_bit(&d->mux_bitset, MAX_MUX, focus) < MAX_MUX);
>
>
> Wouldn't this be more correct?
>
> +    assert(find_next_bit(&d->mux_bitset, MAX_MUX, focus) =3D=3D focus);
>

Yes, makes sense. Thanks.

Do you want the whole patchset to be resend,
or only changed patches with "v2" prefix in subject?

--
Roman

