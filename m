Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3285AC02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 10:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXeVk-0003hG-Gc; Tue, 14 Jan 2025 05:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXeVh-0003T7-Qt
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:51:01 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXeVf-0006tz-Vz
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:51:01 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e3983f8ff40so7705205276.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 02:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736851858; x=1737456658; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=itglZr80LmqISpxSz190t/fkOURj1W6fq9VmZoJSMxI=;
 b=nwXCqhfPaATksN6kHNBBSHW0QVIWw8a93jlupOYhvbUWtihzpfDbRYfmqrLsXeiyt1
 IvzoHo/+S2z2fMLenvwgrgzIjkKO3AFy3EioZ1BQWvTcYwJvOi5Bgw5XBF87BmeagNJc
 IWPzg7RnjqnMiQ6MqmdTMHnHjWw6hvYIiyJUeLv9KVCrE+XfDRUrHKCuKBkbSSC1EN+H
 p6SlYJvDJNoJ8SUuCypP6fbLN+yOrHV4PzroIFK49LW7ejXDpVbmOIUHOE9Pj+lz/45i
 Yb9MBIr/bJsoOYvpg8nFSAUbCD9CgR5w8/sgJDu9ba0emPTS28LfzOmEDv196FFetQoR
 ujzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736851858; x=1737456658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=itglZr80LmqISpxSz190t/fkOURj1W6fq9VmZoJSMxI=;
 b=GunxjvdIiJhpSF42UoaYvikPZuTh2gMXGpU/HTY5VBpwFB46cTIs+qUe7phgpmuHG3
 Tq0i1PfyingMhkhpIO3Ck6E+0UduviyqscwZkvO4Vt0WfWjRhju4RUrjpj3DPSAT/2lA
 m77Ygg7ADMe0znskVU+pb/vC59OAUR1w2J8po+O/gNGegio6zFzaj0OLWqatbJ9TH+8P
 99ezY5AJjSoKK9W29WRq27oUUEr74NGEdDqTyciJvMHGWdejCu/BCngLJYIPOOCN/j2o
 2APphQ/V5o8CjNaRY8rQTwGgXj/T73czd14I9stuByrB77k+CTFDUnFFiz1eQTosEZ8r
 nAQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxmaAM9nXcArc2VoQhThvSHI26R+T8uooygnloB3rpqhv2i8yBmP0Pjs4SQJNd22BfCpItGywNs4Qm@nongnu.org
X-Gm-Message-State: AOJu0YyQsf12+u5FkcwuipcWWi4NlC8roJlsgb2PjPggd4M+0u9uhZLk
 fNGQ1S4G/3Ixdpg9GttwA/e7VryJCGo0qhbNqExrUtiTl/8bgb8+SvyeivMztFFlu2Yw0HIJbCr
 2lJlshIK79JHDh0c62CU9wv9QzwTr9GAkkfOqjg==
X-Gm-Gg: ASbGncvOoqBRua8Ch8REaz/InAhTVWATnoclnM3lUoHLA/28eZz3CdgNhQwy/4vTLLb
 BUpEkwJSaFeuqQ0MQ7TySW8ryOKERn46nFd0eHeM=
X-Google-Smtp-Source: AGHT+IG6NpI0ayQ/3BB/pElmhTynHnmy1h/d32gnipm4gRWPmMd/WYj8Ol6hK+pa6/CEYr6GXZg8D0x0NV1a7priPHk=
X-Received: by 2002:a05:690c:688e:b0:6ef:91a0:dd30 with SMTP id
 00721157ae682-6f53123e372mr197569207b3.12.1736851857135; Tue, 14 Jan 2025
 02:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20241106104041.624806-2-frolov@swemel.ru>
 <CAFEAcA-b+XcYEm1MASzedYchmy0TOpv2djqssJtQdu2CTw_jTw@mail.gmail.com>
 <7dd7787e-4eb3-47f9-bca6-2bfab69caf4a@swemel.ru>
 <CAFEAcA9gBph_CXnBBmrf=WfAuiLAhz=JF1ux0SZK2RGJwnK+Ug@mail.gmail.com>
 <4895cc5c-32cd-4b1c-93d1-1980cece90bb@redhat.com>
In-Reply-To: <4895cc5c-32cd-4b1c-93d1-1980cece90bb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jan 2025 10:50:45 +0000
X-Gm-Features: AbW1kvY6mewvOAjo8wkUQpoqAaNCay1clNGTOToblG_sSts3SIMio7SIqu2q5ag
Message-ID: <CAFEAcA953g82_0+7ZejKL0_j-X7ohqc1Wvr01tFt9M+iNNJX-g@mail.gmail.com>
Subject: Re: [PATCH] hw/timer: fix int underflow
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>, 
 sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Tue, 14 Jan 2025 at 10:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 1/14/25 11:14, Peter Maydell wrote:
> >> So, to my opinion, explicit cast to "long long" is necessary
> >> here to get the expected behavior.
> >
> > I wasn't saying the existing code was necessarily correct,
> > or that your proposed change was necessarily wrong.
> > I was saying your patch didn't come with any analysis of
> > what the actual hardware behaviour is, which is
> > how you would determine whether the fix you propose
> > is the correct one, or if it should be some other
> > change instead. (Some of my response was trying to
> > provide some of that analysis.)
> I would say that the patch is more or less obvious in the sense that the
> intent of the code is to model a counter (which counts up by 1 and
> cannot miss a step) with a timer within a process that could be
> preempted.  You probably will not find an answer in the datasheet, other
> than by analyzing the signal diagrams, because this scenario simply
> cannot exist with a hardware counter.

Well, for a start, you want to look at the datasheet
to check that this really is modelling a counter and
how wide the counter is (32 bits in this case).

thanks
-- PMM

