Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8052DD767E1
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 16:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Y2n-0001j3-St; Thu, 31 Oct 2024 12:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6Y2m-0001iO-MP
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 12:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6Y2k-0002ty-KR
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 12:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730392145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfeeMAMU4m+uL/At8yEFn9cCeFJ7ktwzowe9PnW2klc=;
 b=Xw4KxGmCAewJ3LTRKzyX8InItEq9UnfKHVvTMOZMNJAdDkihecZYeaiNV4xCAPU8zOeo8g
 Eh/Bfy7Lh7wiCQVmIOEij4xpxx+c6Rl5XUwHJDMPgHsHfDBv5QLHqcQkUTYP2VWjRLL1CN
 7/xOxWlRuqAm45jfZEbEoIJ3AN+MwJs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-55Ta9gKUOSKs1xCTIv2ApA-1; Thu, 31 Oct 2024 12:29:03 -0400
X-MC-Unique: 55Ta9gKUOSKs1xCTIv2ApA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315e8e9b1cso6390245e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 09:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730392142; x=1730996942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SfeeMAMU4m+uL/At8yEFn9cCeFJ7ktwzowe9PnW2klc=;
 b=ijm/zDYxOgmybLyGh8XzVbI1JNVgLVoz2pjA1QU7nWt0uVOJ0plA6ZQVGofZzwBZPE
 EKrt/8VWEvpvL8cFuqeJYgtMFcxhoLHXtXmnsl43bVKRdGP3+oAHjUvWJOIDesIcPoXP
 Q7MAFs9YGDRKuxRVo5OuOREz++GZCDsD/VtHPSkvMYWIXuITqeGqzeK9y4iyW/sp3N/+
 aLFWDsolqFvQW6rjkZQbJPF4PERroDNJR+vUK4pfn9IWUkXEDHB6291/+15okiOmele5
 m1lktS2xWcF6OUvsxanLPFYaddURO+6mc0Es+gVYZDK4CsoPlFLRlaZPJ64/NcXfetZa
 tIbw==
X-Gm-Message-State: AOJu0YzSTqd7qKvi6+XmrG/ZfcqAeiWAP8/zomyj2Wh84CewVGEmRbDk
 ib18JV3CRiKOFdk/m0WQBblcT5qHlVpwuj5gySOlPVA5K1hAzZ/EO3ODju6aOOR+XIw8YrJhFmU
 Pf860HirTI3yBmFZoI1zyJyQXjz/pKGRGyvmTgnNKhksIIjLHeD2vXYL2fwbAO2C5pPw3csuOCv
 1JWY/Trm/Ovxk8i9ZoWG2nGyu4Cxs=
X-Received: by 2002:a05:600c:1c26:b0:42c:b603:422 with SMTP id
 5b1f17b1804b1-4327daa3649mr26995275e9.8.1730392142256; 
 Thu, 31 Oct 2024 09:29:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWg1Jmwmu2WT/3cHPsbmle5nBbF8i/zC+2xGeqHEMsg4x6dYM5450nuZHh6jpshPW866pvHJJqh3sOtAFC+BM=
X-Received: by 2002:a05:600c:1c26:b0:42c:b603:422 with SMTP id
 5b1f17b1804b1-4327daa3649mr26994985e9.8.1730392141901; Thu, 31 Oct 2024
 09:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <CAAjaMXa+fyKHyufwmEQG5dqvFWW+uHtu9PDMkznD=3iViV6L1g@mail.gmail.com>
In-Reply-To: <CAAjaMXa+fyKHyufwmEQG5dqvFWW+uHtu9PDMkznD=3iViV6L1g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 Oct 2024 17:28:49 +0100
Message-ID: <CABgObfb7=ZxgiasgB=dE8yV+bhd5-pd51n4qGpP8OFNBS3iMXQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] rust: fix CI + allow older versions of rustc and
 bindgen
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, zhao1.liu@intel.com, junjie.mao@hotmail.com, 
 berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Manos,

I apologize for extracting these parts of your code without making my
intention fully clear with you first. My intention was to move the CI
integration forward while you focused on the procedural macros,
because right now the partial CI is limiting other potential
contributors.

In order to fix this in the 9.2 release, I would like to include the
extracted patches in a pull request before soft freeze. They implement
the core functionality required by the tests, and they have been
tested already.

During the freeze we can evaluate how to best structure the remaining
changes, including improved QOM bindings and your procedural macro
work.

Thanks,

Paolo


On Fri, Oct 25, 2024 at 6:24=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Paolo, you picked up my patches without us first talking about it.
> This is not how things should work.
>


