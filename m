Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5570C71135
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Jun 2025 13:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQQU8-0007cN-I4; Sat, 14 Jun 2025 08:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uQQTy-0007by-6s; Sat, 14 Jun 2025 08:59:38 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uQQTv-0006Py-O9; Sat, 14 Jun 2025 08:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749905971;
 bh=d4cYSZfaPzfHe8s9eJDdGllyY2pTNhhcb47WbT7nNZk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=9/+o/iwmwXs2JSd7ZDEcquxr+EKXijIJChlknQIC75Ca5JMNPjrrAfoRMF7NwKivj
 rIce6mJTbWO7VUPZIAlnAfj91cKrX23zdYUdhWNHGHtXwvBwYFaOGvGCv5xWj34o0t
 S8LHmHCPuMlKFW7WzVxtDLSCyZ63CAmAH9SKK5FcOUzCapLiFBN+19Hb7pYX51ydv0
 JjLuxGYYzi+x4iVdb8KpOBfz5c8s6JgGLwr7LeIvWtYbtGr8ORLdl/nt/FfFI0DiVy
 JhKB4VVkVtoUE/i2cKHFOJ1qWIb8TKf5WoN2RC3eOr+XQ9+K3yC8N+BekFO8lNAM14
 xbkVLgN4AaPWg==
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id D13CB6355;
 Sat, 14 Jun 2025 20:59:31 +0800 (CST)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-711756ae8c9so5850167b3.3; 
 Sat, 14 Jun 2025 05:59:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW3EKBMrEgw7hMo7ZkQpb9TX8Fx7tkAcUsb6EWSBLEogy1L/5FUwY0HH1CiF+71AI/lSESAh1nhNg==@nongnu.org
X-Gm-Message-State: AOJu0YyezuMSEqTXRZxVmXYGl52VYdV18WLmH6iJNAtnKx/+vgdn8OH0
 L6IVvgEsXGAi/suzLK3zcEK/OUVQL8DU03tSDDKyvPYLoa2azhrFo6mZV56CZWAtY6ou1pCzO6X
 mtL4ODgAknTyfNwSN+yXnG15j0UCUM2I=
X-Google-Smtp-Source: AGHT+IEUjp++agcqzyNwU65nGazOJ+NSWYrepEqc5f979rgGw6Lo/+qZ3mCEXwYgJZo6gYtbmJVbJu2vFh2bXiqkZBw=
X-Received: by 2002:a05:690c:630a:b0:70d:f420:7ab4 with SMTP id
 00721157ae682-7117545758bmr40382367b3.29.1749905966846; Sat, 14 Jun 2025
 05:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250613.qemu.patch@sean.taipei>
 <20250613.qemu.patch.05@sean.taipei>
 <3aa8de03-911e-4906-a0c5-5b8ea269ad28@kaod.org>
In-Reply-To: <3aa8de03-911e-4906-a0c5-5b8ea269ad28@kaod.org>
From: Sean Wei <me@sean.taipei>
Date: Sat, 14 Jun 2025 08:58:50 -0400
X-Gmail-Original-Message-ID: <CAGvOXg_VK0+DA_OHy0oWGC4QuL6icFd7yabLKeRzQMc8OpU-rA@mail.gmail.com>
X-Gm-Features: AX0GCFvnZBRVh2FkSeAuh9DH9hIL6J0bW_SXB6nBB0mjrV595eA0Cg3I5V_OBho
Message-ID: <CAGvOXg_VK0+DA_OHy0oWGC4QuL6icFd7yabLKeRzQMc8OpU-rA@mail.gmail.com>
Subject: Re: [PATCH 05/12] include/hw: replace FSF postal address with
 licenses URL
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi C=C3=A9dric,

Thank you for the quick review and for suggesting the SPDX approach.

On Sat, Jun 14, 2025 at 1:36=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> Instead,  I would remove the license boiler plate and add :
>
>    SPDX-License-Identifier: GPL-2.0-or-later
>

Before we respin the patch, could you please confirm the scope below?


1. For the two headers currently under review
   (aspeed_i2c.h and aspeed_timer.h)

   I will drop the multi-line GPL boiler-plate and replace it
   with SPDX line, while keeping the copyright statements.


2. For the other ASPEED-maintained files

       hw/*/*aspeed*
       include/hw/*/*aspeed*
       tests/*/*aspeed*

   Would you prefer to convert them as well? If so, I'd prefer to
   send a dedicated patch series after this one.


3. Replacement rule:

   * multi-line GPL boiler-plate
     -> replace with SPDX

   * existing short two-line notice
       This code is licensed under the GPL version 2 or later.
       See the COPYING file in the top-level directory.
     -> leave unchanged

   Is that correct?


4. If we do the wider sweep,
   should MIT-licensed ASPEED files also be updated by replacing
   their boiler-plate with SPDX identifier in the same patch series?


Please let me know what works best for you and I will send v2 accordingly.

Thanks again for the guidance,
Sean Wei

