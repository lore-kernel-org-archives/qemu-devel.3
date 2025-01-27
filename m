Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F675C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcOpQ-0004Lh-1g; Mon, 27 Jan 2025 08:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcOpO-0004LJ-DW
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:06:58 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcOpM-0001Xf-Su
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:06:58 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso7630591276.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737983215; x=1738588015; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RZ9N9l/esadIiCaTU1q421TEhhr0KPFf7kRDq2xl3eA=;
 b=Tsqhzun2Rh6gUE1KWvU17qCwqJnnnAFpYrEuS4iNNdxWjY6B/K1ul6y3oeJX5rEPeJ
 IkuWfqCeDdQkEdwD6cwrBDn0pomRm4aymc1fA6lz+WpIQ4HTsLrvvinQLVnKkcSFya5p
 7EBBZk71FcsNetkgi3JDsG9+QFUiAnJBDLhgVQQkg8VSG0U9vNflKhF3TYJngnUYwEPr
 monLIuqyoG9ilcf/kHtAGwTopux/9riDU6JwFbB7Fq4rYIPQbMPleL0QZVR2kOdZ0uFF
 ReHCXnjG70sK0jcDZZ3ZIXIBGaFO3Zd1SiD/gYJLA8P8kPNRSNOiJylM1BYMwerRpaRB
 lZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737983215; x=1738588015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RZ9N9l/esadIiCaTU1q421TEhhr0KPFf7kRDq2xl3eA=;
 b=t6bt8A8QaHqhTdmOfQREMV58h6CQYE9lxEQ0u8cyQwkbwKrSuMyjxtE1gGeRngYbZ4
 sAYOTFWxjrLR6Q52ZfQIwjbv8S4WXnaF2GJaQg72vG69qva/EwcjYHPBWupO6//FbSWR
 XSY3XX9BCTKOfFYgyGCkVF2Np6TcsvrJE2O3o6a1VStphAy13E57sQYuqm3wM3OFgHaS
 rS0TfWEBM8m0ZDU3Ei1K+H2/+kGZxahNrS9g/OKYXSMBje+vhE+X/zsxI9I9VEnBseEN
 LTbdTFFAprLwXHjPMxO5M5TwGRlpIWjuulADypfNcbCyH8U5Js91HaRCkkLhTKDguwZa
 ObRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKnMNf1rlclV8o8mcWsEAPiBvaHJp/fjU3DNQPhMS/08fLCYaGKmogpfjOl4C+pujZwzVaihqyhnJj@nongnu.org
X-Gm-Message-State: AOJu0YxMQMpGRe8IgLYZC2pv/7+y7oEvuW1T0yAMEs5eV5Q2Fv3m6LUt
 WK5NQRbFx6jYr2WaDXQaIIBJhJmG/FqG6nCPYUlJZIWgWlz4vVOstCKX9HmgB97QjMpTtUnDmw0
 z13mYyhnBesD1f1rwRZw6NREW15oGwqfsCIA8ZQ==
X-Gm-Gg: ASbGnctGEl2i3fE9ywzy8jB9Tjc2BJM8Dt8HfufR5fP5JHVvUOMobrTyqzmymGT8lZv
 i6wXKu3U6u0kDmKXapd3Ct6mXoZCXpDI27m2AXznPp3T3qp8HX1EyUs7pCOvZkNg=
X-Google-Smtp-Source: AGHT+IH8vFmMXfwvtx0keTCHSSXal4n3PQbMIlS8e++HRvMWGquGqbLko3IQ5U2/nC2Ad74ztRgqc6+AF2VrvaxtP0U=
X-Received: by 2002:a05:6902:128a:b0:e57:d3c8:554b with SMTP id
 3f1490d57ef6-e5883d164b8mr774846276.22.1737983215711; Mon, 27 Jan 2025
 05:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20250117191106.322363-1-kchamart@redhat.com>
 <20250117191106.322363-3-kchamart@redhat.com>
 <87sepgtp3e.wl-maz@kernel.org> <Z44R-cUz9CWMp5Gi@gezellig>
In-Reply-To: <Z44R-cUz9CWMp5Gi@gezellig>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 13:06:44 +0000
X-Gm-Features: AWEUYZlKJbJXWDufCAfjJFp8g110L43kb4AROtU-4_YVGFeafwo5GoGPkZA8JZc
Message-ID: <CAFEAcA9arxn3FLRYS4ObD=iRkX-idgCosZkoqknqTkQwYn0uTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs/cpu-features: Update "PAuth" (Pointer
 Authentication) details
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 sebott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 20 Jan 2025 at 09:06, Kashyap Chamarthy <kchamart@redhat.com> wrote:
>
> On Sat, Jan 18, 2025 at 10:04:37AM +0000, Marc Zyngier wrote:
> > On Fri, 17 Jan 2025 19:11:06 +0000,
> > Kashyap Chamarthy <kchamart@redhat.com> wrote:
> > > +PAuth (Pointer Authentication) is a security feature in software that
> > > +was introduced in Armv8.3-A and Armv9.0-A.  It aims to protect against
> >
> > nit: given that ARMv9.0 is congruent to ARMv8.5 and therefore has all
> > the ARMv8.5 features, mentioning ARMv8.3 should be enough (but I don't
> > feel strongly about this). I feel much strongly about the use of
> > capital letters, but I live in a distant past... ;-)
>
> Sure, I can keep it to just v8.3.
>
> On capitalization, I don't feel strongly about it, I just followed this
> commit[1], which explained that the rebranding changed "ARM" to "Arm":
>
>     6fe6d6c9a95 (docs: Be consistent about capitalization of 'Arm',
>     2020-03-09)
>
> That's why I went with it.  I see you know this by your "distant past"
> remark :)  To match the above, I'll keep the capitalization to "Arm".

We should probably do another fix-capitalization pass on docs/,
because a bunch more "ARM" uses have crept in since 6fe6d6c9a95.
(6fe6d6c9a95's commit message says that architecture names like
"ARMv8" retain all-caps, but I think that was my personal taste
creeping in -- at any rate the current Arm ARM uses "Armv8",
"Armv9", etc. It was right that "ARM926" etc should stay all-caps,
though.)

thanks
-- PMM

