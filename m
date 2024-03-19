Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB926CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmatk-000830-2Z; Tue, 19 Mar 2024 10:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmath-00080y-Uc
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:57:01 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmatg-0004h5-8w
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:57:01 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56a2bb1d84eso3661626a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710860219; x=1711465019; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iaTZ++j805zk6Q/hr9DapTyXuNBg4mtGR3kodOW/BhU=;
 b=dRfWKREgqG3TCs1UBKeZ6TbIPh3QYGSXMwNsol+MUygyaxqMI846ba94daj9AgydEW
 T9vkyyjewyPsFB5dSFrmKbNGdberiM3gsJFSGAVV3AHMhHKdt7rO0/NjRngb+lhpX34E
 7WsM6EdxZQAY8yomfciWtpHOuNrrxt/Ws/7qRagLMWGcoc/sPRIbGatteVo1u3O1zc4+
 JJha918gzytbO1EqOw7wG0U3Nk7j9f7+eeaaUTqoY0FIsVMom26hAZRaVrkcFxNiAq1g
 B6L2uz8HCdTfX7YnVaGxTn/TqC9SHgKtGQWFq33CQWiAr0rEpcwlG4ZQaHQApcltidxf
 nqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710860219; x=1711465019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iaTZ++j805zk6Q/hr9DapTyXuNBg4mtGR3kodOW/BhU=;
 b=gGD5Zplo42UDxh7AZauAYTN0RcMdAhdeyVoq4tjIXl2IR6V1/ZsDnZdal3TqArEvBy
 r0YQv8ksrUVT6F6yvgvFxpiNZyhUZ3rICe+SHQvyWLt3J+kkp+xj/WkcjQE58ugnkxlD
 wCiSfG11jbly12sdFeUodruHM6u98dbuBtN27xq9rSdZn6dZ/oUd1l2zr6P6llliGLqM
 AIJNHG0OEQwziv0f1u1jYaQ32K9TyzyrNP6SSUoO3MetHR8C+G+GStqrDkQpmvF7xSSD
 kZJAw7rP4O44bWxMvyxiDowSQ4mh75YLJPB+S/y2ssvtfLYO5Nqlb44zh5J/ni5H5sMb
 0CKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtoi1Hq5uhAt9BaSQ/T+srCa1FwAnGhg/jEoRxhESAWDCKGnqqbWypPlg8b/wD352yLMj3kh8QiUWUeD9AT6FATF/E3rM=
X-Gm-Message-State: AOJu0YzSGgY/xaFIG+TJnQsCQ5+1KLnYop12S6U0bYfZm+tzOIyveYn9
 CvoLouMXkyuAmc7xGDkHH6XjBByHhKZJ1WhD22a4zisswqMAilAwHiGCJW6B1oqQ+lgyFL9I3i8
 alvY5HVVz8AfDflhvdM58ZKK0JlNxa+qCNpjpvIQl5dt5uPat
X-Google-Smtp-Source: AGHT+IHFg0Go6GStGBoVnw0MFJjlJlIOObqbckTgW4m2AsHq4E/C85Xri+r9YvQtJbp19Qhzn4dUO8ZQfUFCmWBBQ/E=
X-Received: by 2002:a05:6402:e83:b0:565:6b76:3140 with SMTP id
 h3-20020a0564020e8300b005656b763140mr2904555eda.18.1710860218758; Tue, 19 Mar
 2024 07:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240317083704.23244-1-zhukeqian1@huawei.com>
 <20240317083704.23244-2-zhukeqian1@huawei.com>
 <4d7795bb-1dfa-40e7-a98e-4c0bafdf3db0@redhat.com>
 <7387988008764735b2f1dd5f2c83a45a@huawei.com>
 <7cc3c19c-00f0-4ad2-b0de-ba42e9b20c2a@redhat.com>
 <CAFEAcA9iBPBvZ-9cFVRdAJaFPZmPK3adn10v2LiS90+1iUzwXA@mail.gmail.com>
 <319276f5-5f29-43df-a36f-c2264b3a6021@redhat.com>
In-Reply-To: <319276f5-5f29-43df-a36f-c2264b3a6021@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 14:56:47 +0000
Message-ID: <CAFEAcA89ow_R0U2Jwska6_BCdSXAQjifimg5OpWga6QcUWkrvg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYxIDEvMl0gc3lzdGVtL2NwdXM6IEZpeCBwYXVzZV9hbA==?=
 =?UTF-8?B?bF92Y3B1cygpIHVuZGVyIGNvbmN1cnJlbnQgZW52aXJvbm1lbnQ=?=
To: David Hildenbrand <david@redhat.com>
Cc: zhukeqian <zhukeqian1@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Wanghaibin (D)" <wanghaibin.wang@huawei.com>, yuzenghui <yuzenghui@huawei.com>,
 jiangkunkun <jiangkunkun@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "Zengtao (B)" <prime.zeng@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 19 Mar 2024 at 14:46, David Hildenbrand <david@redhat.com> wrote:
>
> On 19.03.24 15:23, Peter Maydell wrote:
> > On Tue, 19 Mar 2024 at 09:24, David Hildenbrand <david@redhat.com> wrote:
> >> I spotted new pause_all_vcpus() / resume_all_vcpus() calls in hw/intc/arm_gicv3_kvm.c and
> >> thought they would be the problematic bit.
> >>
> >> Yeah, that's going to be problematic. Further note that a lot of code does not expect
> >> that the BQL is suddenly dropped.
> >
> > Agreed; we already have one nasty set of bugs in the framebuffer
> > devices because a function drops the BQL briefly:
> > https://lore.kernel.org/qemu-devel/CAFEAcA9odnPo2LPip295Uztri7JfoVnQbkJ=Wn+k8dQneB_ynQ@mail.gmail.com/T/#u
> > so let's avoid introducing any more of a similar kind.
> >
> > Side note, the pause_all_vcpus()/resume_all_vcpus() calls in
> > hw/i386/vapic.c are probably a bit suspect for similar reasons.
>
> Exactly my thoughts. But there, it was less clear "why" it is even
> required. It's only performed for KVM.
>
> Do we also just want to stop KVM threads from executing instructions?,
> so blocking KVM ioctls might be a reasonable "replacement"? Really not sure.

I think the vapic code wants to stop other threads from executing
instructions while it's patching them, yes.

-- PMM

