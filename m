Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E556FC52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 13:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seDw1-0001sc-No; Wed, 14 Aug 2024 09:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seDvz-0001qg-Fb
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:21:03 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seDvj-0001oA-Vd
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:21:03 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7a91cdcc78so225817766b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723641646; x=1724246446; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+ELusBiHMjBzgMH5qmLDggCJaEIc3n6Pb1CFyeXfGy8=;
 b=L5gV+wRx8pyyEBzn/QnLb33OrCrW9nmzUHEcFntKiCtAJ/yzW6kbriJgmZff7ZTTPY
 srSdO0dkfcoUOJLxxEO4KzG0zLrdvGCvPZeREoEb0NnQVOy3WP7ArDb7bcKR8+NA/8Iv
 HitgbmyKu44Si7if0bSqCA6HJ6Co3h91PLayIDWkfRF++LWlSONemaYXQyZDIBBN6ibx
 BmYWsIhlCWoXxj+2af29xvcyFjkQm7JWGuNZQTtVC6sIS6IYT6fkxt1Rn4aDU9EJseTd
 JL4z4y8m7+GQbtWM1gkilYKl425UpoTtBqvOSa0noaZhiLPJ4qSLaiZKMCZuXH6nYqK5
 c65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723641646; x=1724246446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ELusBiHMjBzgMH5qmLDggCJaEIc3n6Pb1CFyeXfGy8=;
 b=cpsTJtU7eIgbnUE/N8z+fUL3hOR9XXeGPII2BTF+lVObrps7s8+fYH2BFCHppA2VDE
 jZF9CvuhRN2xJN6iFtgyIcZewpb+5Gwm6sCuiQeFCVtwusQlLA+yY7TtxVWPtg6NHKfa
 v4QRtbJsgRjNxrWe0TXNIH0x+r5iVDgxg/jaNpmELiQK5n2G1fjn+OvSDKqSxm+LO3xp
 ga24ypwluPxJ9N/xvRhbUWY4TtfO7rIgEt7ECetdjGM8T+z02Sjrglb4rQPCOg2o2zJG
 ExCA4M8QZXjyyb0WU7fYhu2MKRd60aIpVZVY5fO9g0OLpO2uKrr9Bg03I9IzCK36PgZR
 XleA==
X-Gm-Message-State: AOJu0YzhaS2qhF1JriPk+1/hrVHoXfil0W5u2XwmeVnhdz0lUWw+nMit
 5rSx3HlJaFe8s+C5wS0V1yqz1ZZo9V7XQS+HyZBt61W99DMkVhYyEO0cddgMjyrlYSvhlVRrs+G
 r4f3PF+RO+uf9TEU5VVj63r3iQx5S6gFKRjaQrg==
X-Google-Smtp-Source: AGHT+IEEHKv8zYHUukhAm3+M8SVgx2W29V1BSshsBtDQrn9BV5hJHtCuMNSbNU9jaYkyw1M0Ex7r/Khc+pYsS47mxQo=
X-Received: by 2002:a05:6402:50c6:b0:5a2:65cb:7335 with SMTP id
 4fb4d7f45d1cf-5bea1c7ce61mr2557363a12.19.1723641645596; Wed, 14 Aug 2024
 06:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-11-peter.maydell@linaro.org>
 <d86ab67c-90cf-422f-aefc-1025a7e5a77b@linaro.org>
In-Reply-To: <d86ab67c-90cf-422f-aefc-1025a7e5a77b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Aug 2024 14:20:34 +0100
Message-ID: <CAFEAcA9XD1c517EUNrKXw2zpsMNg_gruBjqcTzQ9tK52KzmSZA@mail.gmail.com>
Subject: Re: [PATCH for-9.2 10/10] hw: Remove device_phases_reset()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 14 Aug 2024 at 01:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/14/24 02:52, Peter Maydell wrote:
> > Currently we have transitional machinery between legacy reset
> > and three phase reset that works in two directions:
> >   * if you invoke three phase reset on a device which has set
> >     theDeviceClass::legacy_reset method, we detect this in
> >     device_get_transitional_reset() and arrange that we call
> >     the legacy_reset method during the hold phase of reset
> >   * if you invoke legacy reset on a device which implements
> >     three phase reset, the default legacy_reset method is
> >     device_phases_reset(), which does a three-phase reset
> >     of the device
> >
> > However, we have now eliminated all the places which could invoke
> > legacy reset on a device, which means that the function
> > device_phases_reset() is never called -- it serves only as the value
> > ofDeviceClass::legacy_reset that indicates that the subclass never
> > overrode the legacy reset method.  So we can delete it, and instead
> > check for legacy_reset != NULL.
> >
> > Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> > ---
> >   hw/core/qdev.c | 51 ++++++++++++--------------------------------------
> >   1 file changed, 12 insertions(+), 39 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> Is the reason we prioritize resettable_get_tr_func over rc->phases to allow for a legacy
> device to be attached to a resettable bus?

It's to handle devices which implement only Device::legacy_reset.
Those devices must have their legacy_reset function called
(and I think it should always be the case that there are
no rc->phases methods in that case). (All buses now are always
3-phase aware, incidentally.)

> I wonder if device_class_set_legacy_reset can simplify that, with
>
> static void do_legacy_reset(...)
> {
>      dc->legacy_reset(...);
> }
>
> void device_class_set_legacy_reset(DeviceClass *dc, DeviceReset dev_reset)
> {
>      dc->legacy_reset = dev_reset;
>
>      /* Parent enter/exit are not invoked with a legacy child. */
>      dc->resettable.enter = NULL;
>      dc->resettable.exit = NULL;
>      dc->resettable.hold = do_legacy_reset;
> }
>
> Which would eliminate resettable_get_tr_func and the supporting layers completely.

I did think about something like this but wasn't sure that there
was much benefit from changing from one workaround to the other.
But this does look like it's less complication than we have now.
I'll come back to this if my idea about using coccinelle to make
a mass conversion of legacy_reset to 3-phase doesn't pan out.

thanks
-- PMM

