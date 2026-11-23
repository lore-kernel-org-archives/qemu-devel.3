Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC72B606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=J4dt8k8m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWFt-0000Od-Ab; Mon, 23 Nov 2026 10:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVWFr-0000OM-5l
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:46:55 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVWFp-0008W7-I4
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:46:54 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b51871c5c4so26522997b3.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:46:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795448812; cv=none;
 d=google.com; s=arc-20260327;
 b=Iv0LH+0y0WL47IR5AiLivGnbvky3oiQ3BQ4s84iC6HMluHVQ2TKqZZTpSo3ANhPaMc
 r7dLhSSzUP4GpGpAi3N6oZPN1bgmeWj+mSyB1QoE5ZObz2Gw7GVTX4TATPo6//+OVs1L
 O/zNJyAh9Wopbccb2ubyFOjfzzjt7LTxjr9YN4rF+yFxGuHFEStBfK7XvU+MA8QJ0y29
 2eSCyJTP2ZHQebrAffoWkWWmhmj7wM/D4P9swKs3yI2liYpa7lw6adO7bHRJ2FM9puBI
 lg+i2K8IrQtOJ5CZnxTjbNDVEhfEA9KEX+VEZRHcyiHfhLOEJOx5/y60x2sS/tMX7Lnc
 /SiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UOSu7KD0HH2mzvdhHWJXOAdom4d++WN8J+M8V+lFMsw=;
 fh=jV4Ofs9liFwm0KKBEZ60RGpL+cXko3Iuo/RG/roXUZY=;
 b=AqJdTpYb/zPYZzMrdcCyPDP8jl4ReWQdRZFz/BsXqOfm0hFJwUqo/IgZ7cWtyf41ZB
 KHvJCwpcjJwzfUIy5AxmDIL62Ror6wwxH/q731V9Rh1c8VGytBWoYr/vHDaSAnfm6PnP
 2CBGxzZU8MsqGJCaa84Lm45IpiEtg6XJVzeu9T856qKcGeYc01JuT0vCTueb/iP+paEl
 PzAQoZWfAn1rVn6IQSc7a5rDa+iGZ3fxeeLWPqEuGiAs4z0qmGtXzeWBtAXsmrvaX95b
 osN2WjkKJQDhbj/giq67GC8PSurWUk39VOhEp0XjQ+yKRgIm4ymTdic1J2A1pE+VIpeQ
 1tug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795448812; x=1796053612; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UOSu7KD0HH2mzvdhHWJXOAdom4d++WN8J+M8V+lFMsw=;
 b=J4dt8k8m+rjBkUd42A2vIiLIDXCTizA3qGKdNNAlzJUwd+l2hn/9uWHvxU30/02IRG
 UzhB+q0CcgfV2J+CaeakEpFM2m3Hkwu6dIUoGn75jn64Y0oyxvcAL6TxIx7fiUCyVAT3
 Vbk0vRybMu9H/0y7xZvboT6ATMaJIAtKnxZdy4Be32B9U0rFrXQI6ov9GUFUuLW/VfMK
 9yezBdEbg2MJy5K6TZoaEECCP0gRMcoTbJMFiPzUVCy3b3EuuzHNmZFaMY9VV41iDMll
 StF+2oEQRyxF78ZnIbSBF1fslUFrvUR+NwL6fmaogkJgNLqfZTww9H/UoN3pySGHIe/6
 JhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795448812; x=1796053612;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UOSu7KD0HH2mzvdhHWJXOAdom4d++WN8J+M8V+lFMsw=;
 b=Ovi2fM3vmCu4T3wbFbR57U8EOXeaaPLJqj0LLK77jnTpEW4bz8Fawm7SISz1DoB99x
 b70+5W5wi31x178zFjGc9MQoCsoqZ2GZ/PaiFF6aNl7FVOO82/vskgGoWRHysG11KD4o
 WIaDlRfmXM0pJF1qYDlSZUqqLkQExU+w1tO/uGWhzgSTxV5FXneO9M5PT3UrUWpmmMxX
 2VqBw1kIjy3FAmEVnh52c6nxSCS+2I2CIaqI8KqXHE4JNZpyaGFVbu0K2RcdVFzyuoJy
 EBKxjFoFWb7pudLyhcPzgqTAxA5HRVgRxm6TcFx8PYd3bcYJpVMeVkrXDi6Pwp+C8M7w
 ZDRw==
X-Gm-Message-State: APuU4Z9HoPG0Mgv7VMVbPm/yKDLRC0fvMMb5rz55R5pV1E09N7mROLGG
 ogiYIiom31N0kOyALrGxG4g911pCnBwXifeBM3HDKovQ7LYyEwr9emR0m207x79ag5PD3p65y9L
 salK+u4/JYU9q3iDBz/NZyQ7M4U3c7b6GJRySbxGd1Q==
X-Gm-Gg: AZFdTZdG9gBwmpv6GF78eElmNMCsF0iaLISsvjYdkr5t6+KVKC5eTRN+yZP2mEKg/pg
 gcBwQ1GBpZsbFcl8An++jBmWgfw/t5pLFP92QAUSvwltC0AIet+aBlADhMpAWm1955pMY6CAlWC
 7xAXu2GVEi0t63TN+Ev1r+u6b+TirCE/QUd2+fzT1oUk8kjXimGraWY9nljyvlkmecuKxiqnu8H
 /z7Y55sLSYHCIefIQgDxV8L8cPukj+A/KwZTWYwxHc75uWEfXWiZ/UwblULJ9Gmq2wYr8AR7yFN
 MPTZHqAW4XDGZhuopiou+eZQNY+yzxJRqPDj5gR+ODXDaFCkgO3q0XyG//ud3Vx7RbHswNw0L1u
 QB7hzqayvnwTwOIs4n9xGLwXy4cREOR1iu7tsuvKjQvBBPS3ZTamCSESBg3UnoUhSZ1jqP+Artz
 m5pXkyZulphvigKvJrZA+t
X-Received: by 2002:a05:690e:b8e:b0:67d:a102:b8f4 with SMTP id
 956f58d0204a3-67dec16b427mr4527090d50.0.1795448811765; Mon, 23 Nov 2026
 07:46:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120124923.1656220-1-peterx@redhat.com>
 <20261120124923.1656220-4-peterx@redhat.com>
In-Reply-To: <20261120124923.1656220-4-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 15:46:40 +0000
X-Gm-Features: Aa3M54qavoWmvzXQx8t5qH9lV2iW-XJd4oOFG2sXyYZC4EMRZxmSFXWvsYIaTWY
Message-ID: <CAFEAcA8NenDCC2Tvv5Z8pU8MiA=QSXf2xwfbZfMYv96y68Vc9A@mail.gmail.com>
Subject: Re: [PATCH for-12.0 3/6] hpet: Move VMSTATE_VALIDATE() check into
 post_load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 at 12:49, Peter Xu <peterx@redhat.com> wrote:
>
> To pave way for removing VMSTATE_VALIDATE(), move the usage of hpet into
> post_load.  To make it safer, loading the timers with the num_timers, then
> only check against the wire number at last.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/timer/hpet.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 42285cff76..85cd26a454 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -254,25 +254,28 @@ static int hpet_pre_save(void *opaque)
>      return 0;
>  }
>
> -static bool hpet_validate_num_timers(void *opaque, int version_id)
> +static bool hpet_validate_num_timers(HPETState *s)
>  {
> -    HPETState *s = opaque;
> -
>      return s->num_timers == s->num_timers_save;
>  }
>
> -static int hpet_post_load(void *opaque, int version_id)
> +static bool hpet_post_load(void *opaque, int version_id, Error **errp)
>  {
>      HPETState *s = opaque;
>      int i;
>
> +    if (!hpet_validate_num_timers(s)) {
> +        error_setg(errp, "num_timers must match");
> +        return false;
> +    }
> +
>      for (i = 0; i < s->num_timers; i++) {
>          HPETTimer *t = &s->timer[i];
>          t->cmp64 = hpet_calculate_cmp64(t, s->hpet_counter, t->cmp);
>          t->last = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - NANOSECONDS_PER_SECOND;
>      }
>
> -    return 0;
> +    return true;
>  }
>
>  static bool hpet_offset_needed(void *opaque)
> @@ -332,14 +335,13 @@ static const VMStateDescription vmstate_hpet = {
>      .version_id = 2,
>      .minimum_version_id = 2,
>      .pre_save = hpet_pre_save,
> -    .post_load = hpet_post_load,
> +    .post_load_errp = hpet_post_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT64(config, HPETState),
>          VMSTATE_UINT64(isr, HPETState),
>          VMSTATE_UINT64(hpet_counter, HPETState),
>          VMSTATE_UINT8(num_timers_save, HPETState),
> -        VMSTATE_VALIDATE("num_timers must match", hpet_validate_num_timers),
> -        VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers_save, 0,
> +        VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers, 0,
>                                      vmstate_hpet_timer, HPETTimer),

What's the failure mode of VMSTATE_STRUCT_VARRAY if the destination
tries to send us the wrong size of data for what we're expecting?
Hopefully it gives a useful clear error message.

>          VMSTATE_END_OF_LIST()
>      },

We need to keep sending out the num_timers_save value on the wire
so we can send to a destination QEMU that honours the inbound value,
but it's tempting to suggest that on input we should just ignore
the inbound value, as we would do for any other QOM property or
command line parameter that needs to match on source and dest
for a successful migration. If they don't match then it's very
likely that the migration already failed on the STRUCT_VARRAY
field before it even got to the post_load hook.

thanks
-- PMM

