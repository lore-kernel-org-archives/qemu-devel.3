Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FF8C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 07:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Quo-0004TL-JS; Thu, 02 May 2024 03:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s2Quk-0004RJ-BN
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:31:35 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s2Qui-0006fF-FI
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:31:34 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-572ad86dc8aso1649675a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 00:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714635090; x=1715239890; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6K+vQgBEJa5RBagBtZnrylNM7yhfiFaLALvIlNSgfg=;
 b=KVgaF1vbYugNMmw6jaCD9FfPjQH4Rfko+Y0+pHtAe2PRVfLiDerJBjoOjWj8jVhB/2
 mLhBFQhB2OAjYipP8DS0INg7H1NuyA+k4VHS7SMCkYGNn1qBSS1Rr3BL3h8vKIEBqcfy
 jnAUxhg+6oHuXiXaQYseRDlHYwBPuM9X2WvRSH8P6vgT6ehhWlLbSDH9mW34V30GHpL7
 yuJaOCmxYqRjQc9Q49PHDB95OJ/0rVoFVd0y5IqnNYVKdOzpd78xoin5ID+Wk23004O/
 N7aOA2knH2iSm2T5jwMTE0ZP2TdYW0IH+PjVSu1bI6uVw8KPb2ccDRxs0Tr78KsKp/BK
 fgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714635090; x=1715239890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6K+vQgBEJa5RBagBtZnrylNM7yhfiFaLALvIlNSgfg=;
 b=KoNni+cVVdIz+sm3UBBzOpJhUCYpxEAR2Nb9iVIx/I9sGeuqh8R2LHptJ1LAaN06pn
 P4Gy1wbyep4r5xlFPvC8oJRW5G6L2ztyOZu01aeOCUhScfao3eN7AEwnw0tif4sb/pjn
 D2TkLqZAdtNavDxdtMVMXtGek/HqvfPmpF8ruoCU8P/ffmN25XUT1JK+cC6xnhS22Q5U
 IWW55jCRdq1mdC/IgbRi9CTe/6GphWkd9pIJk13t1kpgX7BptBtu+wkIXAybenFXCDUJ
 nMlWsfFIgWTbxC5mVOmdoiezsS3OMeU9c+gDSc/zYg/w+Z29ElE6zgIwMnZ9q7SGxDTY
 CUfg==
X-Gm-Message-State: AOJu0YwH6mwYDasAR9QlYB8mgG/5rDXtGme6mCKM0SCsMvga7Hhj/m8O
 aousYBOCzOztHPa7dgyVjva24uLAC+HjYXDH0AZeBg2iJHkFRvBb4Phga+Ma1FXaZ0FkO53Dr8c
 E1/1guO3QpzvUPpOzDZJgHZQ+qsk=
X-Google-Smtp-Source: AGHT+IGMHAiiyj/igyCydtEDbXlM1aLJwGa5/OER2+/iX842FcrCPNtsDsqsmkDTMJpWU8WX/JeJCxlIf+/12u8L+4k=
X-Received: by 2002:a50:aade:0:b0:571:c0e6:233c with SMTP id
 r30-20020a50aade000000b00571c0e6233cmr3365370edc.37.1714635089557; Thu, 02
 May 2024 00:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-14-edgar.iglesias@gmail.com>
 <7172c93c-8c25-4934-b1d8-de0658c6f50f@redhat.com>
In-Reply-To: <7172c93c-8c25-4934-b1d8-de0658c6f50f@redhat.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 2 May 2024 09:31:17 +0200
Message-ID: <CAJy5ezrP0OQU7ZOfZUDg2QgVZ+zcicrACk=UoL68BWEhOaQWsQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] softmmu: Pass RAM MemoryRegion and is_write
 xen_map_cache()
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, 
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, May 2, 2024 at 9:24=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 30.04.24 18:49, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> >
> > Propagate MR and is_write to xen_map_cache().
>
> I'm pretty sure the patch subject is missing a "to" :)

Thanks David! I'll fix it in v5!

Cheers,
Edgar


>
> > This is in preparation for adding support for grant mappings.
> >
> > No functional change.
> >
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> --
> Cheers,
>
> David / dhildenb
>

