Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5AFC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribNV-0005fU-Iy; Fri, 08 Mar 2024 09:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ribNP-0005dc-Vz
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:39:13 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ribNM-0000Qc-6T
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:39:10 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso2321011a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709908746; x=1710513546; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qMVKlEr3AOsH0dOtTLBTyhI5D3rhpugca35QaWQ0bdc=;
 b=awnPMZoOdHTAt8KkpnAOX7WngWC8y4VaCE133Dp5sAlP2Mf3d8QmHJvORhLkucpIjN
 G4T6opcrSWBgILO9eaMI3ud8+gZTXqGF5PDwQ8SooqjFm1qCO9YuP/RWiCtoQlYhuAqw
 Lyat9DZG+DCi6OotbEGH5hToAWnW6ho/uib6/uyJ6hXGYhSu/WIrxQWBkRfGJ9lSsAPg
 GAbuBaz+pEEQnAsRR6W9LkiQ/BTu8En64Be+o1mch3lXQOOpPIcK2/Ox92huY0vmTTbP
 CmaFot6Ln9uE/sdws+BaqCQgji+K1aYRHGnx+6iqF3clSQNoXINUaL6WHq56VclUY7dK
 PtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709908746; x=1710513546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qMVKlEr3AOsH0dOtTLBTyhI5D3rhpugca35QaWQ0bdc=;
 b=aXP2I4TonKKaJTSiFPDFDO5qtxwxCetrPziLOfn8bjjxTdMo+2cX/mL6IbZR3nHGph
 EGN1tTsJfmMvndKGC/FebGICzXGBRBn+IKRNXBd7ay8ST9TjIHNsbpycaBfC+YLD5cfI
 kN7tpeqDvQ2GjSGl26Pc4qc7kv3UpK6sXWczLiSv3SVi3Ox6GqodOQJVME8zor1wxDtN
 AZvGjaGaO8pADs5iLaY7xI6ldk5nyAyIrx3K9oAtfSuLQsEAh2s3Gz2y4a/Ro/bm50JS
 3a+9s+4U/P6tvmIW5YtvKmvLaT04UrSROobr3av4gOS044cxy8+9lGTLfuQl4X0gya6x
 4dxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb5uTRJm4QhLrdwyRrBMnzopQ7cOGsGjjDtOT9Xo0ebIJjtQkMg+gDIR2DyLH9AHaswZOcTZUx8wbPjcBtwrhBI0V943M=
X-Gm-Message-State: AOJu0YzaSgdh8lDjtajQXLMFNmOBlDzkb0vJR86aIfS1fhxoBf9tW0M7
 6XoBxRTcviVHMODet249q1QDX7jnOjxrN1oNw/v3uLV3EupqjU7N0YpoNIev4ls7qFLZZwPcRDn
 q6hYpZpQ9HkTOGBzh3x9HvOHIbzcq0KpzNoa05w==
X-Google-Smtp-Source: AGHT+IEvDnRKG/xwQryTcoepREXID56U46EWMx0212WbcpD35r2TikGP4ixCby/UbSL0qI5/+NX3t3bXJppQfFfSjxs=
X-Received: by 2002:a50:c04e:0:b0:567:56a4:3940 with SMTP id
 u14-20020a50c04e000000b0056756a43940mr2043500edd.19.1709908746579; Fri, 08
 Mar 2024 06:39:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1707909001.git.mst@redhat.com>
 <8700ee15de465a55e5c7281f87618ca4b4827441.1707909001.git.mst@redhat.com>
 <CAFEAcA_W8BxG6rpcao2hCYntfU9aQfAzHQiy6RJQ-v3ZB4sNZg@mail.gmail.com>
 <20240308143420.0000536e@Huawei.com>
In-Reply-To: <20240308143420.0000536e@Huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 14:38:55 +0000
Message-ID: <CAFEAcA9jN7zO_tR3xmcDjSY3cuKimsdPwZtkE1JVhjAcpSreLg@mail.gmail.com>
Subject: Re: [PULL 53/60] hw/cxl: Standardize all references on CXL r3.1 and
 minor updates
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 8 Mar 2024 at 14:34, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 8 Mar 2024 13:47:47 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > Is there a way we could write this that would catch this error?
> > I'm thinking maybe something like
> >
> > #define CXL_CREATE_DVSEC(CXL, DEVTYPE, TYPE, DATA) do { \
> >      assert(sizeof(*DATA) == TYPE##_LENGTH); \
> >      cxl_component_create_dvsec(CXL, DEVTYPE, TYPE##_LENGTH, \
> >                                 TYPE, TYPE##_REVID, (uint8_t*)DATA); \
> >      } while (0)
>
> We should be able to use the length definitions in the original assert.
> I'm not sure why that wasn't done before.  I think there were some cases
> where we supported multiple versions and so the length can be shorter
> than the structure defintion but that doesn't matter on this one.
>
> So I think minimal fix is u16 of padding and update the assert.
> Can circle back to tidy up the multiple places the value is defined.
> Any mismatch in which the wrong length define is used should be easy
> enough to spot so not sure we need the macro you suggest.

Well, I mean, you didn't in fact spot the mismatch between
the struct type you were passing and the length value you
were using. That's why I think it would be helpful to
assert() that the size of the struct really does match
the length value you're passing in. At the moment the
code completely throws away the type information the compiler
has by casting the pointer to the struct to a uint8_t*.

thanks
-- PMM

