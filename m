Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A6CCD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slWhS-0003tm-9o; Tue, 03 Sep 2024 12:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slWhP-0003gX-20
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:48:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slWhN-0008LZ-2q
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:48:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42bbd16fca8so36885085e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725382087; x=1725986887; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mr4Yf1vWkZ9yUBQH3dh/+PMfWjtZZryeltnKyq6cx94=;
 b=p3LlPlvAgMpi95FbEUKPY1IU4zhp5zQsg0UzmEMYCcVcv4TiDQ5ydQWaVusioiVPtQ
 poib5MLew3pBRbd+5bQlrkCcmgeEIbjtQne184HLj0wCu7DK6AIKt1YF6DMGxN5vl6Ce
 jb37vBXaC+unle1NdX0kEaknXIJfFdevPf6EDQ1s+oTTzqT2mSzrm+skJHRw632d8MQr
 Hr1F4HLAzkZvWq5Q+74LkutEZ/qvhnLQwh3EGUMUUncKCU5yeGLo0/9zLxL5FXA83x6V
 ssKtvfmirnVdUetC2k/ggJdVeml/M2/K3fLdkp6yvo5oP79KeNJICoFoMh89vinC5Fee
 iDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725382087; x=1725986887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mr4Yf1vWkZ9yUBQH3dh/+PMfWjtZZryeltnKyq6cx94=;
 b=Ef6Jd3d+dvnHzaHZyYwdIYPMeABOZIUkld/Ih2AVa9tF8knToRaP6TOR2GpiFjTq6l
 miujdvINBpn10ATIGkZPhZQLyQHEvL0Bebl8D1rESrJrqjnCLJoIjxdzekBd0NuVpC4w
 edX2Dx2IbsSf++O6oKbg6gwjMxUEWAJxPzEZ/vf5+0mBKjKHR15huePtCRY/b2vY3d8U
 Q6ZMuCNvVHtNvrk99AlN1Ja+m2vJWCssCl2N7mRxtqy+IcB3CGySKCLE9vYsTKtsQY9W
 rzHx/02RrOrg77v0ckx/jRLue0VBSH46yUHHDnerAOPo8bFk5EavdN3n3j1FjeU0p/Vf
 /6bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOIzyDq4Z04rLKzTBZS07XDBR2DN7D0jPbzdw6Q1mIeDrWqYrLXg4yPlCnVYyIjf5qvcZKM9Y2uCKd@nongnu.org
X-Gm-Message-State: AOJu0YyCpGuTUleW74H2aYmXLHQACq6v+K+DNe3Zl2k5JG5LK+NrqLsq
 a2y1Om9oTy9oQRpkTAgs2XvnaZS53BsfSkVzraBfiWzkVXFuZvK6pfDUut8wnydzEMZiJ+dQ3Yo
 Qig57KekaksjKOrQBf6YxomMPhY6+R3qaSdWMbnMPYhzrddBl
X-Google-Smtp-Source: AGHT+IGK9isTkliJ7hKTMMOKrUiwf79c75cQkaAH01bnrM+XO2QNBCl4PXj1S8YDH6srjGROQalov/dlBdUfijFK7IU=
X-Received: by 2002:adf:e60e:0:b0:367:8a2f:a6dc with SMTP id
 ffacd0b85a97d-374f9e39a3amr2906213f8f.44.1725382086955; Tue, 03 Sep 2024
 09:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240829131005.9196-1-gaoshiyuan@baidu.com>
 <OSZPR01MB6453339D5F1BB3283E08B7328D972@OSZPR01MB6453.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB6453339D5F1BB3283E08B7328D972@OSZPR01MB6453.jpnprd01.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2024 17:47:42 +0100
Message-ID: <CAFEAcA_FQFRVwUFYEuv58ty+59AVE0JtaNQYLyAb1OTu_TTy5w@mail.gmail.com>
Subject: Re: [PATCH 1/1] platform-bus: fix refcount leak
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Cc: Gao Shiyuan <gaoshiyuan@baidu.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

On Fri, 30 Aug 2024 at 11:47, Xingtao Yao (Fujitsu) via
<qemu-devel@nongnu.org> wrote:
>
>
>
> > -----Original Message-----
> > From: qemu-devel-bounces+yaoxt.fnst=fujitsu.com@nongnu.org
> > <qemu-devel-bounces+yaoxt.fnst=fujitsu.com@nongnu.org> On Behalf Of Gao
> > Shiyuan via
> > Sent: Thursday, August 29, 2024 9:10 PM
> > To: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: qemu-devel@nongnu.org; gaoshiyuan@baidu.com
> > Subject: [PATCH 1/1] platform-bus: fix refcount leak
> >
> > Temporary object causes reference count leakage.
> >
> > Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> > ---
> >  hw/core/platform-bus.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
> > index b8487b26b6..dc58bf505a 100644
> > --- a/hw/core/platform-bus.c
> > +++ b/hw/core/platform-bus.c
> > @@ -145,9 +145,12 @@ static void platform_bus_map_mmio(PlatformBusDevice
> > *pbus, SysBusDevice *sbdev,
> >       * the target device's memory region
> >       */
> >      for (off = 0; off < pbus->mmio_size; off += alignment) {
> > -        if (!memory_region_find(&pbus->mmio, off, size).mr) {
> > +        MemoryRegion *mr = memory_region_find(&pbus->mmio, off, size).mr;
> > +        if (!mr) {
> >              found_region = true;
> >              break;
> > +        } else {
> > +            memory_region_unref(mr);
> >          }
> LGTM, but if the empty region is not found, the process will stop running, so I think this bug may be not
> serious.

It's not a major leak, but in the case where the region we're
scanning already has some MRs at the start followed by a big enough
empty region, we will first find and leak those initial MRs
before we find and use the empty space. So there are some usage
patterns where we'll leak something and not immediately exit QEMU.

Applied to target-arm.next, thanks (with the commit message tweaked).

-- PMM

