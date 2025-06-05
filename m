Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519B2C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 11:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN8vU-0006Sm-GM; Thu, 05 Jun 2025 07:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uN8vR-0006SZ-F8
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:38:25 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uN8vP-0000Hu-Sw
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:38:25 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-710f39f5cb9so676357b3.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 04:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749123501; x=1749728301; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LLMim8Dm3/2RszCHofQnDp5uTAz8hZYooBll09GpQI8=;
 b=ped+lFUZh2W73SYC9Q2M2jwBLMlryABDTrOIXd2QH9ph7Bk2smN/b8MatZ1vAtibKr
 6LVyfqfTLcC6mZ+JRCef1FOJ8vHbCsG9ZgE1/ueL65c6HJ80k79+AMK2Dm6VlNyZbl8I
 h+tkk0m0a/kCMPzqF0BQKpuuJXWnNpQBxYnIuItW5Fj9K2uqtTm7kbuIyi1ugTbegFya
 1WbVb9DkpyFCi4C7bzGvo6DvSQ4/+7OKiQdXHkN5r9IFexqTieaNVTEhZpudIPYck2dP
 cBKaMbJxUBRr/CNv8fAqA4YG+dE3BxXVqf5S5OO5xw+GkLYz2WyJVUa5YboXZNlo27mp
 4IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749123501; x=1749728301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LLMim8Dm3/2RszCHofQnDp5uTAz8hZYooBll09GpQI8=;
 b=cxdf57+2czwbdZSijK1Fg4XyKGRRvPb/mBgGFEYEjFg7egOevFUozJqHzcvdEDjp6X
 AWs/YZ3Szhrtl5r0E7za5tLeQtvzloctNNuRuMcGGjqc7D3lzy3jIeQJbvAJQ+Z00biE
 Fth+s73j7cTw6U3BCiayvZQ2PvsiPlax2TTQDAVMlps1nCd8ZRoYJ+kuOhLmhHFnzsbZ
 zOMe/kYYJqed92pWlTZF+OW7RVmo8Is0p0T2K2IwwWNl/6bS04EAOfQwDkS2RrFyur4T
 r72JH4jqYqnibkS77RD5Hqc0wSktCmt/XBNXU3ikq41Mx22kPiilmLcwMDp+axNBbxrl
 C8BA==
X-Gm-Message-State: AOJu0YyeUHa+8zX4dBwg1oMj+TsTAmjLgvtS4w/DWtAkLAGpcKLQ+NHe
 emcf+aCnjhRhM3LAd33ND2nP3D2Qtil+r4kBJo6pM9T3R7aLDpaD0sunD94wheWsfl65nO9NquB
 sAducFkwG5dZ+RFCnAP6UXnkU1DjlZuK64nv2pq33BQ==
X-Gm-Gg: ASbGncugGjj+nz+VxhnIgr8fudcanIotn7VViAkxjQ9AMe9oY/4DFgRCEAg/A0m3ZJ+
 H1z3J9cc+klpsMfZNhydu9Oybqb8QjPq8KXNU6uVugsCav08tnYnLt3tOczmvZvrakbIyQtnEIB
 ztqvLd8McAccu1afLnm8QiCdHk/CXJRx89mw==
X-Google-Smtp-Source: AGHT+IHmtONFkVGC0ZBJosABOGG6pyctDDI7u3UTRIBY2jZD7A7zRyGDIt7pH69EQeKHMWN7y6O9F4bk7yQIQJZZMcY=
X-Received: by 2002:a05:690c:3345:b0:70e:73ce:80de with SMTP id
 00721157ae682-710da25e564mr81664467b3.25.1749123501194; Thu, 05 Jun 2025
 04:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250605105219.261925-1-armbru@redhat.com>
 <20250605105219.261925-3-armbru@redhat.com>
In-Reply-To: <20250605105219.261925-3-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jun 2025 12:38:09 +0100
X-Gm-Features: AX0GCFvM9KpwK4LM-Dwe9HjVn1IhLpYszhVDn3NBFt5ywcW1574UtNFzQ7JCf5I
Message-ID: <CAFEAcA-QPO4jPEs9ZbS3ed0LARe4caFnNC54zi=+XsFdS0Wz7g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] docs: define policy limiting the inclusion of
 generated files
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Thu, 5 Jun 2025 at 11:52, Markus Armbruster <armbru@redhat.com> wrote:
> +At times contributors may use or create scripts/tools to generate an initial
> +boilerplate code template which is then filled in to produce the final patch.
> +The output of such a tool would still be considered the "preferred format",
> +since it is intended to be a foundation for further human authored changes.
> +Such tools are acceptable to use, provided they follow a deterministic process
> +and there is clearly defined copyright and licensing for their output.

For the case where there's a one-off generation step and then the
intent is purely human-authored changes from there onwards, why
do we care whether the tool followed a deterministic process or
not? As long as the copyright/licensing situation is clear and
the submitter has checked tha the generation is what they want,
what does determinism get us?

As a trivial example, this rules out a hacky one-off python
script that produces output by iterating through a hashtable
if you forgot to add a "sort" to that ordering to make it
deterministic.

-- PMM

