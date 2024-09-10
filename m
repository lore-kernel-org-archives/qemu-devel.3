Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50443EDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so5Um-0006un-Cj; Tue, 10 Sep 2024 14:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so5Uk-0006no-1U
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:21:42 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so5Uh-0000dy-3M
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:21:41 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53658f30749so5253238e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 11:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725992497; x=1726597297; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HW7Z70h68alb0ZlYfRuig3E1yX1hmuw7MmHA3n9PApg=;
 b=vNN9htBVeDDrWKi/t0LVtyAsLa47YBzcZKkjy44UF6c7lTvvnIhsqmiJMK6ZU0AAM6
 rw1DEpjdBYAiKlpgj0uqogFBVcrGIlG+9Qr+n8lGJnbdrJTDIRXlgmi3WHYtE9mL4ZJ9
 RXzrGb2T8KbYSdp2OdFBQMlFC2uPtu25E7r2uHyDu5Bf4ZCrEVxqrJ7+03G3JTV24oX0
 WkZTWexw3mHXKwFFkR/GUQz6HLOQiFaqhviCB6avN0TL9zlDGvg05FZKAOz0xavtJ46p
 llviCuri9WVlCMnJoucKmGxw+M0V+MVPaoArwR7Lw+4jhP7R31V6Z+1LK6mDOL55LIju
 1DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725992497; x=1726597297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HW7Z70h68alb0ZlYfRuig3E1yX1hmuw7MmHA3n9PApg=;
 b=E9LIsADDSFnLmcgrOXVWUAe7WXjDyacy3FojXrPOFfhhWefTqRXYrvAVGKCvWJItzS
 xasYLGHubh3eyonIk1sWc+2ub6kBnpreUNBSjRycMZRAMgVSpt4J5mLSduaPh8fBpMKU
 q2cyp6Q+FZqY5QFgURwZ70kJz+KaXCf+zi8d93gF5p3VkxpYjaAuMNzpwTyX7VQ/HObZ
 68y0kPyAvCFiwFTeQgnmb7rN0qExl6USbgVvBndTF3lbTcZDa/rXZk1mxaKjRUB9c4yK
 hJiodT9O9ZngGaU7k6pf5JFzoXAKQsZQONWT760YsZPCbixSVBc4IzrUgxzdMCbjZano
 AePw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1kfcDfcYcd2UT2kbjOOPkKbEHqSRthpKWTvX0TGaIltesvrmqT52NkTupAjO3b+iLsursARkXiC3g@nongnu.org
X-Gm-Message-State: AOJu0Yy0LAuraJOGeUyrlqgjV504cRc8KRgtdYEe7sVqH9C31Yv8Q4Wb
 ZWNrpy3RXkiWvtzycwJaRUJkiLc7xNyhKkzY6Fyt49GYZNxmbZYFOae1PFb7G24hLdkx3ZTYdFb
 3/0abB5L489Y7KYz6u+yRg1E63CfIiGSEG2wHWQ==
X-Google-Smtp-Source: AGHT+IE4QJzHst9tW9qFWQx1rRqistYL0P62BLg85j9ePCM2fsJGyGSgOTEDE+iIi0SelbfxttpyUbYYVl/I5kT3IF4=
X-Received: by 2002:a05:6512:694:b0:52c:9383:4c16 with SMTP id
 2adb3069b0e04-536587ac1abmr9552780e87.22.1725992496686; Tue, 10 Sep 2024
 11:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240829-memory-v1-1-ac07af2f4fa5@daynix.com>
 <20240910132635-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910132635-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2024 19:21:25 +0100
Message-ID: <CAFEAcA9AoDKbekaXUkUD=R+Voy9Om0oQmHMgDiLB5cUJqtW+WA@mail.gmail.com>
Subject: Re: [PATCH] docs/devel: Prohibit calling object_unparent() for memory
 region
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 10 Sept 2024 at 18:27, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Aug 29, 2024 at 02:46:48PM +0900, Akihiko Odaki wrote:
> > Previously it was allowed to call object_unparent() for a memory region
> > in instance_finalize() of its parent. However, such a call typically
> > has no effect because child objects get unparented before
> > instance_finalize().
> >
> > Worse, memory regions typically gets finalized when they get unparented
> > before instance_finalize(). This means calling object_unparent() for
> > them in instance_finalize() is to call the function for an object
> > already finalized, which should be avoided.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> who's applying this? Paolo?

It's a docs change to clarify a complex point that's
under active discussion in a different patch thread,
so it needs review before anybody applies it...

-- PMM

