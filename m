Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB77FC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 13:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXAj-000093-Ue; Thu, 01 Feb 2024 08:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXAh-00008b-Rk
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:32:04 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXAg-0007Df-5L
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:32:03 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so1270568a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 05:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706794319; x=1707399119; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VuhFH2l8wOsR9O+l3jGKybuHjpYO9eKRhIyGx1sDsFY=;
 b=EgHAEnDchXgJEtv+62/jr/AcAjwspABaK5EYPIYi+woHfCPal7vC+0lzscEFzriKdS
 U4dWkPf9AMh/YX9rXRH5SNDj36fd0PIJejPEphfmI2lIMTP+8xWXwMvZfJut0rx4SHOx
 LPKBKlr1NRfDUgBJHwttntJtzpTWuJcz1OJLELiOG0b6rhN/JP4EjGN1ljPjC7dQfyLx
 SvmB7Y+4RD/KnEe0R5ueYcgjLqqFwhP0PU9hnUxZrpAU6nykP8RcJ1x6kjviooW7jLG9
 33NVMbc+yxgRhipWfOTHpPwG6vlhE/BeOZI2Js3wV59YX9nvn6I+Pe8KBAvVo5MOg5B5
 sukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706794319; x=1707399119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VuhFH2l8wOsR9O+l3jGKybuHjpYO9eKRhIyGx1sDsFY=;
 b=dDEJkKaWkn+7DFiXzJVGih6hE6H1wP54hRiUsLQ61CWCIimtpVQvYe4PuUYhWHGvtu
 cvYEarALjSMOA5v0bqUIVMj67hLLdeoZaP96kBss5doMNA+cjRZj1hVW3cm/cFkwSfb8
 84Paqo9NlFm9fxCavCCyNXeiI1WxDlzxV5RYA0YEDKmKxDZRXTwOIglni23EsXdfOIhm
 gfcLhym5fOZjvJHxkoSiNJnyV4/CFaf/WanCG+sEA0HCLV89iK7t9+YxDZi1VNsbHr/T
 Mmpl/BYiw5cUj2aFUpNH34L8rrbec3glC5wSKkskhMpeONij0U0M487hnbarfwV5lfm1
 +hpA==
X-Gm-Message-State: AOJu0YzYI0yKtWm6I5wLX2CVXfvAX6ocJDtSOkqOcLXmSyVVa5h1aBeT
 1KDU6XcEJKxfaOrsXsyfx7MQqyT0HldB10TUhVGf0s6kVRhEOKMTB9Qm48TMW/GF/IXMmzGxQJ/
 0MaYUADykRroAuYbOClLophSpcxZEIOvaimVfeQ==
X-Google-Smtp-Source: AGHT+IEI4FYymGturWwN6iZKWvEgA5HNjZYUXaNZwlHw3QkL1nbmWG33HehdMbljCabjsiHdXUlmoVL+Xw+qf/lII3A=
X-Received: by 2002:a05:6402:1219:b0:55f:d90a:e68b with SMTP id
 c25-20020a056402121900b0055fd90ae68bmr14462edw.20.1706794319275; Thu, 01 Feb
 2024 05:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
 <20240119163512.3810301-6-peter.maydell@linaro.org>
 <ZbnFWB1vJjW0CmzX@intel.com>
In-Reply-To: <ZbnFWB1vJjW0CmzX@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 13:31:48 +0000
Message-ID: <CAFEAcA_2LSsziLxigvkLcTPzwhn-7s8sCWsraFZr2BQRv0Vz=w@mail.gmail.com>
Subject: Re: [PATCH 5/5] hw/core: Remove transitional infrastructure from
 BusClass
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Wed, 31 Jan 2024 at 03:44, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> On Fri, Jan 19, 2024 at 04:35:12PM +0000, Peter Maydell wrote:
> > Date: Fri, 19 Jan 2024 16:35:12 +0000
> > From: Peter Maydell <peter.maydell@linaro.org>
> > Subject: [PATCH 5/5] hw/core: Remove transitional infrastructure from
> >  BusClass
> > X-Mailer: git-send-email 2.34.1
> >
> > BusClass currently has transitional infrastructure to support
> > subclasses which implement the legacy BusClass::reset method rather
> > than the Resettable interface.  We have now removed all the users of
> > BusClass::reset in the tree, so we can remove the transitional
> > infrastructure.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  include/hw/qdev-core.h |  2 --
> >  hw/core/bus.c          | 67 ------------------------------------------
> >  2 files changed, 69 deletions(-)
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>
> It seems the similar cleanup for DeviceClass needs a lot of effort.

Yes and no. It's true that there are a lot of DeviceClass
subclasses that implement the legacy reset method still.
However, they are all "leaf" classes which provide a single
reset method, and don't need to either chain up to a parent
class reset implementation or allow a child class to
inherit from them. So they don't affect any other classes
in the system or block any other classes from being able
to use a full three-phase reset. So I'm not too worried
if we continue to have a lot of these leaf classes: the
old reset method is then just a different way of having
a device with a reset 'hold' method and no others.

I did an earlier round of refactoring back in 2022 that did
the cleanup of the non-leaf classes and the classes that
need to chain up to their parent class reset, which mostly
updated all of that kind of class to 3-phase. The one
exception is that we still have a single user of
device_class_set_parent_reset() in the s390 CPU, which
is awkward to deal with because it interacts with an
s390-specific handling of different levels of reset.

I also want to look at providing a 3-phase equivalent
of the qdev_register_reset() API at some point: that one
is definitely blocking some useful improvements, including
dealing with the vfio ordering issue, and also would let
me clean up some M-profile ARM CPU reset hacks.

thanks
-- PMM

