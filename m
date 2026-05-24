Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63CFCD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 20:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRFAU-0005LY-Fg; Sun, 24 May 2026 16:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRFAS-0005LM-Ln
 for qemu-devel@nongnu.org; Sun, 24 May 2026 16:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRFAQ-00083N-A9
 for qemu-devel@nongnu.org; Sun, 24 May 2026 16:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779653480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBgXzQZdaSXad8KsI6BsXYkemImOjNEa2mOec1yyZ9o=;
 b=OfmDwjNRBesi1OYqzzLTm8Hv+TBSbIeXj7W4CF90LSj9foLagE8IaINqi9WwEGyt3tKFMu
 PEuRkY2niLOxoJl55a/YL+y5CZdaQVrMA/OWoI33uXblsT6NVl8eEZU8Qd/x4OcLt85Vei
 yQAhfFD1GTCHnYe40vcnfhjHhHD/M5E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-nArU3099Mb-_9bt90QF3Lw-1; Sun, 24 May 2026 16:11:17 -0400
X-MC-Unique: nArU3099Mb-_9bt90QF3Lw-1
X-Mimecast-MFC-AGG-ID: nArU3099Mb-_9bt90QF3Lw_1779653476
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43fe791a398so6944432f8f.0
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779653476; x=1780258276; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oBgXzQZdaSXad8KsI6BsXYkemImOjNEa2mOec1yyZ9o=;
 b=sSlJHHmf16yttP4BDyCIVbStV4ELZp9ZWDkblpJGkgQJBDgdVqGsXhxC9bxmYsFaJs
 4PWFvN1Fpux3V55JXtFRj8yGbgS44DJbMLgbY98k/KqiCzSA/c3fCNjR4bFZxYO446LZ
 IrtSSEAmvxbP9efzILYtw5YsSKUSy5diV8JxZPpF6s2iFLier/gnR6DqQAW3iyoXGdq9
 mcYrPKQV7/TdbDnlSbLxluyv0NdTUe0d+V2gcJj0QbQ7iSOcOYW2UgmTBa+5FAV/c1qt
 4E1NZmnFbUHd+lc6rH3xoG7bhLYI4X956tSg7GOGruy0okGehvhVwG84S4wmSFwlfWzg
 ICNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779653476; x=1780258276;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oBgXzQZdaSXad8KsI6BsXYkemImOjNEa2mOec1yyZ9o=;
 b=sVKr4C8y39DUVyBmoXFP3rZ0LcZtjK3O2Ru4gMxUxaT3J0fMcBmNrnj9X8P6ljS8/Y
 Ib2si9qnGo2Y0x6HDINtuj/INoHelvqOWr7rJ9ybl+HQFkFXff4vpqEe+LOlH0VjUz1F
 27klVH8ArWqCgCvy6Ygq2Igt+i0qR+UdefDeeQZ/MLlz21rQcoIbj/IEYPRPkv6OaGrb
 +hZhWaoamEp+rqFbf+MJlHgAmpRWF8Lay6BRuaxP92y4jDcAMxQuvwr/4vaou0xKuDIf
 S/GibNC0T4oi88bLG6Hagf/w3Dekzk0RwYKAJRhFXR3i3nzvXXFoCEkGweJTBFXaSFgB
 cLoQ==
X-Gm-Message-State: AOJu0YzIqT2Mix7f1zliu68PBrOvpnnT0Zub1YFns8Tl5lFeLKaLfvaK
 /0S4BSXFmgbJ+sN8EUH/u3TO0F2L9bE1xEbgCyanNhkStn7mlf2MG52wc4DcsfXm4Jg/QdOT/8y
 /kQYr/bASr0Th7QAOfAYpkOpDIUi6Cy75rpIyMPnM4BAaSL4ZHSI/1uXc
X-Gm-Gg: Acq92OGBbdGEWGurBbuT25/ByS4iV6UBSfdq8xew8cbH1WguCybQjIG1dugyqLC4hfg
 FKHNe6R+D/oekY/1kK1ekqv41UZoO61Kwdn8ZMSZc9dKVn9qRN9kKXWZwEUEhuNYJQC2YrPY2bS
 963LTj3Gnei84bcJAd3QmB0nxhw4dM6qjTzD399uPoLTbr8YL2k0+V5y3GfX7oBXsIFa5JJz/7f
 0sdtcFo0cImyTVZqb/KSP75BijVsQg/aCgTUc9lSsgNe4jtO2K/Kn2ChbpOiBrwvYcxozr0z9d8
 8KYTwoOjk+26uSeSoDNqMquY8cPgNOvBInb/RhRvulASa2y6uei+rymWJ3VH7aOAO0VU3nrSj8L
 mMrOPeFCaYa+bKNUjxm8w57pgcPrfC0y5Q8u67/mOiyw=
X-Received: by 2002:a05:600c:1393:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-490428e5b31mr197316555e9.27.1779653476022; 
 Sun, 24 May 2026 13:11:16 -0700 (PDT)
X-Received: by 2002:a05:600c:1393:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-490428e5b31mr197316295e9.27.1779653475478; 
 Sun, 24 May 2026 13:11:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5cb76sm18553912f8f.25.2026.05.24.13.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 13:11:14 -0700 (PDT)
Date: Sun, 24 May 2026 16:11:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260524161048-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <87v7ccd9eh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7ccd9eh.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, May 24, 2026 at 06:06:46PM +0100, Alex Bennée wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > So, I had to reject a perfectly reasonable patch:
> > https://lore.kernel.org/qemu-devel/20260320193746.242704-1-jinpu.wang@ionos.com/
> > just because of a tool used to make it.
> >
> >
> > 	How contributors could comply with DCO terms (b) or (c) for the output of AI
> > 	content generators commonly available today is unclear.  The QEMU project is
> > 	not willing or able to accept the legal risks of non-compliance.
> 
> In the linked case the LLM is basically doing a glorified search and
> replace. There seems to be no danger of accidentally regurgitating any
> training data which is where the worry about inadvertent copyright
> infringement comes from.

Does this mean I can merge it, in your view?

-- 
MST


