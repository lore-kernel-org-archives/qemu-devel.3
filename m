Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CB8EED609
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 14:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sokW7-0007kT-1h; Thu, 12 Sep 2024 10:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sokW5-0007jx-G2
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:09:49 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sokW3-0003UD-Se
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:09:49 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c255e3c327so1166436a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726150186; x=1726754986; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ehrtznHt6VRuS2YoltjDDU9wfhY6nQY50SsyL1RAWyU=;
 b=P/Z0NI2KSAEqlMUNG0jUlv7UGa9EaJZZZbg/bKSiolh3kSAxPIZC4BCYilNcbZhCoA
 AJpYUdXANl0SMzcyZA0QRHcrCq8YSIvEHGrW67DSCzsOR4tmY68C7A7Xib/QsnxUEAzD
 HjE32pRfho80IjxAhLOVeF7QwM/2p1l6ZjzqE9MdL0Ku+DO8x+p6XyjhGFh6xbe85AQy
 ysxx4sjsCg1nNi+aYN65i6CKQFO1nCAv3BWs4dYRbelxQsTh69QYJ/N90IoguC0vbC2E
 /4lxWqiWdUwMz6gdoG61cCtzobomVedwFxkwfYq/LAyqyAd9I6qS8SGo1piGelEsuUs1
 PhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726150186; x=1726754986;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ehrtznHt6VRuS2YoltjDDU9wfhY6nQY50SsyL1RAWyU=;
 b=ryV0YubGv7yfnZ2cnbxE9gNk2VY13+XBszTxWBwE67kB8dVNQlwuo/JaAIX0QMaVQN
 ewH2Il9T2rWoGjJaA147Mw5nconhDjiSv5y8bWStJpTL5n4JVBcJEcAfHst4jpPZa+A4
 i//6Mp7ga9PhnMk8ozF2DBl+P+clgxAdUbrRDsEWKi7AcnBmV7gEN0IkeL4CXdIF+WOQ
 Bej9zkajRRO/MEcCxKTee2DYQ4OnKCtDqVV+o43gANrBxOAgpwRGzgHdmBQjXcTZf0ew
 xrCCykUBMYwcWpI9qTfCk/CSLzvD1iaU891eRs+Hk70vxfA+DmS/dh4qp6gYv+VEf1eh
 c5Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNZdS2/Vj8aWBKLxMZatVxA8/tICi+KcDf9HFNmcVeglCTeSSeCgk/VcwpbM17RkNPLwo5GFT9iffY@nongnu.org
X-Gm-Message-State: AOJu0Yx9acGgHhikYd5w8kyjIKdhIp4G09lCX55ws+78ovrZBYrLQU4Y
 P8q2hkwBlrTPxf4A6yokoNnOQQ+j/6fE7ZU+6vG8bFxSfxFYAy0/ItGBxGARrN9uwlhqyRahXjw
 ujbTLQaOrta8e1YRXgpYv6EJSV7NvxJHjDdv/Xl63kINIyDww
X-Google-Smtp-Source: AGHT+IFHg7UtuedxvLJsO3mGgfadsC/fsZ95XQ/YPOOWjjiK5r20oS+shhBzseSG/2YUsHon2BazNOUz60mt3dildIQ=
X-Received: by 2002:a05:6402:500c:b0:5c0:bba5:60d2 with SMTP id
 4fb4d7f45d1cf-5c413e2cf48mr2413924a12.21.1726150185751; Thu, 12 Sep 2024
 07:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725889277.git.yong.huang@smartx.com>
 <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
 <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
 <Zt8H6pC2yQ2DD7DV@x1n> <87frq8lcgp.fsf@suse.de> <ZuC4pYT-atQwWePv@x1n>
 <87seu7qhao.fsf@suse.de> <ZuG-SijLg8Q27boE@x1n> <87ed5qq8e2.fsf@suse.de>
 <ZuH_pvnTCumKuXTh@x1n> <87bk0trifq.fsf@suse.de>
 <CAFEAcA9YkZiSSOAj0zH2OwF9AcziJT-zpnNVQn8BXizhSXHVOA@mail.gmail.com>
 <87wmjhvv7e.fsf@suse.de>
In-Reply-To: <87wmjhvv7e.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2024 15:09:34 +0100
Message-ID: <CAFEAcA8Xrgf3nYYaOjaV_2+rtnLahMOdcBGReXpLKxyPm4u_pQ@mail.gmail.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 qemu-devel@nongnu.org, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 12 Sept 2024 at 14:48, Fabiano Rosas <farosas@suse.de> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > For some examples from this week:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/7802183144
> > https://gitlab.com/qemu-project/qemu/-/jobs/7799842373
> > https://gitlab.com/qemu-project/qemu/-/jobs/7786579152
> > https://gitlab.com/qemu-project/qemu/-/jobs/7786579155
>
> About these:
>
> There are 2 instances of plain-old-SIGSEGV here. Both happen in
> non-x86_64 runs and on the /multifd/tcp/plain/cancel test, which means
> they're either races or memory ordering issues. Having i386 crashing
> points to the former. So having the CI loaded and causing timeouts is
> probably what exposed the issue.

They're also both TCI. Would these tests be relying on
specific atomic-access behaviour in the guest code that's
running, or is all the avoidance-of-races in the migration
code in QEMU itself?

(I don't know of any particular problems with TCI's
implementation of atomic accesses, so this is just a stab
in the dark.)

thanks
-- PMM

