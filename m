Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABA6C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 16:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uezDN-00086u-BX; Thu, 24 Jul 2025 12:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1uezDL-000800-RA
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 12:54:39 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1uezDK-0002wD-5d
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 12:54:39 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4ab86a29c98so13471cf.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1753376076; x=1753980876; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/iQMuK281cC7mzmEq7Xw5rOLZKueqkv92FzxVLsmWFI=;
 b=MyIPTyN0lRVZ559nlaxbKSpwu2Edn9tDLVWQnbbuoxLAdn8GKW4yXxrla52blacqqG
 jlyGHab7IgWLBh8HF+Ny8NnjPFjx38RdNdOboJ3nwWKN4vFnhujmmG5RHWE3K+hEUmlV
 3N3q5h1hGdRPJyYWm4r65mX51CmeMv8Tp4nhUgZ4tbj/nHAd7NmBOs0GvwCQvxmd7CAk
 ED6fhM95lPnSzYGj11pPRERoYs3q9XMXFcUSS42RlSTiGR3SNKkPn+7RjWsY2rr9g/7J
 S+g2E15vxEqDFAp53EdNLnq4JABbzYP5uP994i+hztmtQxvHeftWHozLunEssQ29SWV8
 bj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753376076; x=1753980876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/iQMuK281cC7mzmEq7Xw5rOLZKueqkv92FzxVLsmWFI=;
 b=RhG7eqIkpREOoRCiJJzQE2UkkDck0oQBrEZxW/CRetjrkfR21vrNNSXg5ZEM5vm6sA
 B2VLPQgrg+fX7g2y344/CAHxNbuwwQsCYTCq6eYrc7ctK6g9cm/sN3+MR0v3unJ8s92K
 0yAKS6WorKrw/wS7zq4H5MkEV8H0pI5QQ4/3xqtuXunJ+O6qjMdERe7hEWxfJKEpy3Rf
 FBl5W6UBFvUWslaXKVfhzDEnshBKZ/SzGYU6vSu7rvhsZ36afKcB3GRFu7jJWaWD9wYE
 jG++X6wuNehB8fJX8cXZpeSYy8hoYW8KsHHoIRntMmJlIK3OnBMrfTxO7oRZyJgExAHS
 r8vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM80C80aOlnytabrdFEDatRWJkfbBYes3bncH4OXYJ9GnhnuAl0elvkA/DOOnfIBn1JLpxXmllDKdZ@nongnu.org
X-Gm-Message-State: AOJu0YxiyAsQdHBCzTIppSrtrVpmYYa3cjBwwZaieY+qqeTxJWR7mkpx
 OVFKu+8rSTaY2rR9JTqL1/HXE1YrZEHAQ6Bpc7HsoIj5LuZz3xi5wJf4ZRCUUwkoBLNNDGf8BFR
 6m6ZGlvZnUK/9R2zd+55t65B0tduedIgbxRCPvJuP
X-Gm-Gg: ASbGncvmnl/6jzi7E8pnjEZjBc98u/ors0HTD40/8xuFCdbNNqKZfMVeI/OHxT3ZIOS
 Z1iZt4oYIMp29pGg8vEgICEgxAkA+jTRanhDQEkM4PN4GSQZ/QyX/qX2/2WwqfmOeO0XmI3oXho
 9JIguzj7/dnWBcJwv9+8jCSXyVjdY190VjyZjlEEHAKhPnYFfolgUXIJTQN3CsEv0rQZslqDxQf
 6dMntyHtqT2/G2B5iEm75oapiFkCW5SUvrgSg==
X-Google-Smtp-Source: AGHT+IEGH9pS8hhuzYXRIFNJtpoYUEcALbJ3jr+8pzx0K/mT9hj27cEUpegmL7rCuVz+zzYE9MGRFFp9c4kx1MevSXM=
X-Received: by 2002:a05:622a:1443:b0:4ab:3f28:9c7c with SMTP id
 d75a77b69052e-4ae7e1d7535mr3697371cf.5.1753376075955; Thu, 24 Jul 2025
 09:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250214072029.515379-1-jansef.jian@hj-micro.com>
 <bf6df47b-8815-4d84-a01b-010281187d24@linaro.org>
In-Reply-To: <bf6df47b-8815-4d84-a01b-010281187d24@linaro.org>
From: Roman Kiryanov <rkir@google.com>
Date: Thu, 24 Jul 2025 09:54:24 -0700
X-Gm-Features: Ac12FXzOdfG-Un591XVw_O2N7RYoevz2B0da3ctAO2K6MDSfYlcMico_jslhzcw
Message-ID: <CAOGAQepyzkZS-kK-rH=rv_pNRCwLBG1UJJ4q4oWztJfCnA=YXw@mail.gmail.com>
Subject: Re: [PATCH-for-10.1] hw/arm/smmu-common: Avoid using inlined
 functions with external linkage
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: JianChunfu <jansef.jian@hj-micro.com>, eric.auger@redhat.com, 
 peter.maydell@linaro.org, qemu-devel@nongnu.org, 
 Will Hollins <whollins@google.com>, Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=rkir@google.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Philippe, thank you for looking into this.

On Thu, Jul 17, 2025 at 11:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> (sorry for previously missing this patch)
>
> (cc'ing Google folks for
> https://lore.kernel.org/qemu-devel/20250717205735.2345674-1-rkir@google.c=
om/)

Will this patch be included into 10.1?

> On 14/2/25 08:20, JianChunfu wrote:
> > Similarly to commit 9de9fa5c ("hw/arm/smmu-common: Avoid using
> > inlined functions with external linkage"):
> >
> >    None of our code base require / use inlined functions with external
> >    linkage. Some places use internal inlining in the hot path. These
> >    two functions are certainly not in any hot path and don't justify
> >    any inlining, so these are likely oversights rather than intentional=
.
> >
> > Fixes: b8fa4c23 (hw/arm/smmu: Support nesting in the rest of commands)
>
> I suppose b8fa4c233bd was copy/pasted before 0b796f38106 ("hw/arm/smmu:
> Avoid using inlined functions with external linkage again").
>
> > Signed-off-by: JianChunfu <jansef.jian@hj-micro.com>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

