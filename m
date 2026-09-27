Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E90C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 16:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xArjb-0005dM-Ij; Sun, 27 Sep 2026 12:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xArjZ-0005dC-HI
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 12:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xArjX-0006ib-Sc
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 12:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790526490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Jy3UWO1UKKUd4vPgPKIPh6krp8JuMKjfhMZTzgf8yg=;
 b=J1Z6GiccxI2EnzTJkrSw5UI4WF8eRFyhQtIPX5t/FRbvYxXXqQOuK7jmVtLpELlAxrmUKX
 j2oy7udbsspPwwphVSXR25EbVq0ae4L+KWrAg9jdsRznPD9iDLGHKA1If4rgQ4OorNSxRz
 KGLXbxBG4dvQ4w+MdFdWlVnaEGk8AgQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-LNkSlFEdOFaAqIERwUgN6Q-1; Sun, 27 Sep 2026 12:28:08 -0400
X-MC-Unique: LNkSlFEdOFaAqIERwUgN6Q-1
X-Mimecast-MFC-AGG-ID: LNkSlFEdOFaAqIERwUgN6Q_1790526487
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e635a6002so27988065e9.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790526487; x=1791131287; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Jy3UWO1UKKUd4vPgPKIPh6krp8JuMKjfhMZTzgf8yg=;
 b=SZ/WzSMPdGZTdjIRvfPG3GdZxn4SLrLvVxR75B1a435I0rx5k0QfLtHr0K3Auk91lg
 ty0npQE5MwH1rPR6QdIjfuobv/eu/3IrYNc6n0iYUofZ+UL6TmiAaanJpeq2H8a2QbJI
 cUyPXx2W7J8nvxMv91pnEUO1m5ktlC3guaH+HmCKBVpbMC3pEl0wDcqxEMEpYFQg0b4F
 u8kt7V37b5+09LeXD+W2fpl+ph/ExzYgEsHQHLb8890iXY8Qk5I/BMq6nylJ3IPjuMWy
 RRYgbkk6w6GlUEdQeuIX8P8ypPeAQOR76MuOf+NX/oPMmsCHFLqMCRijwUrNtXfSMHTV
 S6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790526487; x=1791131287;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Jy3UWO1UKKUd4vPgPKIPh6krp8JuMKjfhMZTzgf8yg=;
 b=B4PCtTDl/O6Vu5M+yRO4VcE9/f61TxOGOql0t5mAwHWRJhnHE2Xq76h7GM/38Uoe/H
 lpIcdw4iEd37oBVusXOUnElnOvAOvGEnbplxUqrl0P2AeSUZgbnGrSVqjQYpfyeBtIOA
 lpGtr+iuCEhJAHWoA6VjEHJPuJ7rOOkS8szO0LOJAwIvnDgViLTbhS331DxEBZ0wdJyQ
 f+ArHPMt5FT3L7WS4liLtvJUMAoA28ubRuxx4UmnpXL0ivBdrNLRWPe1IJE3LweoTmyW
 087BCft3/bOErqpdGcLFWHI0n7Z/sheu3HJ0z8wstCat77GG87JDk3KVQCfN3muEVJFg
 fziA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyzPXp8xSjwhfMj4qkQDBghCu+O2qMz28gqg2WN6WsHhXXEFcsXtlxujQWLXRfCPxScOMsmunNifYt@nongnu.org
X-Gm-Message-State: AFuF++l+CReiXeImU9U6EdmX8LykF2Nl2opIP7u0JqmGmg1ItY7pIkx3
 0Rio+XC1tAlMnr/0LnTqJyozR6AKVhRLspFKr6d90zmr4FhnlmKpSThkaLS2APNgjQATAv3KbLR
 1WCiLbSXIANNXxXWMOEkema/Q9b1L0wOuP7yxC8SUCL3LYyoNDwo9oTqM
X-Gm-Gg: AYBFou2j/tGvBbXs1kcI9DRw/2fK6xJBdTIIn/46kXtb1+3OqAdGuRccODJ6JlJMMg4
 OwUVlXcZGR6YSKCJwoGVzL8N/Xi3B7jBOf+P9TDT8gPZlFkmItlyhCvPRaAaQvpdGT4OOHr3EQV
 Eyffx2a4ujxTmtXWEBbp8YIcf/gLFq1PVD3bVTgIO21oQsblWIGhfwZtkekJ4g3Q7sXUYy7rstp
 L7k+B6zRyyjJUoOxyM1u0mIX34tNkJg6XKo+NOG9O8CmiJ1xahKVyEo3pBEkgW2vJdMeh+qpf9g
 SxDYtoiFeCEJqpi01ZL2S77Z/x7awXFKmUeNX4GGf4ZOeQ4qZscs2u+ukpX+BlZlepJiA1npEGS
 QLphLP/xv6JwS5EQozXA6XolWuGHhPcmsOI2Tbb3M/JBffjUVV/ra6y1+vScpUVcwrQ==
X-Received: by 2002:a05:600c:a416:b0:49c:fc6c:be0d with SMTP id
 5b1f17b1804b1-49fe67bc287mr189654075e9.19.1790526487016; 
 Sun, 27 Sep 2026 09:28:07 -0700 (PDT)
X-Received: by 2002:a05:600c:a416:b0:49c:fc6c:be0d with SMTP id
 5b1f17b1804b1-49fe67bc287mr189653825e9.19.1790526486497; 
 Sun, 27 Sep 2026 09:28:06 -0700 (PDT)
Received: from redhat.com
 (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk.
 [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a6470b7sm21535772f8f.27.2026.09.27.09.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 09:28:05 -0700 (PDT)
Date: Sun, 27 Sep 2026 12:28:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260927122519-mutt-send-email-mst@kernel.org>
References: <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
 <87ik3vyp3i.fsf@draig.linaro.org> <arT_kefzEhqg8-FB@redhat.com>
 <arUJxE0F7Q3Cw5sk@redhat.com> <arZHWKAgr-GYvoeX@redhat.com>
 <arZZhpR5_nPybOUo@redhat.com>
 <e030a85d-a5d5-8fc6-5d1a-41167f7a95bf@eik.bme.hu>
 <20260927052335-mutt-send-email-mst@kernel.org>
 <81d65154-74ce-c6c0-ab40-fb2156d53fba@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81d65154-74ce-c6c0-ab40-fb2156d53fba@eik.bme.hu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Sep 27, 2026 at 12:03:39PM +0200, BALATON Zoltan wrote:
> On Sun, 27 Sep 2026, Michael S. Tsirkin wrote:
> > On Fri, Sep 25, 2026 at 02:20:49PM +0200, BALATON Zoltan wrote:
> > > Not directly related to this patch but as an input to this discussion I'd
> > > like to bring to your attention how some people use AI now. With LLMs being
> > > able to do more, some users who have no idea about coding or QEMU internals
> > > but want to use QEMU for things that we could not deliver, now just maintain
> > > a fork and let the AI add features and fix bugs they find without ever
> > > contacting us or reporting these back.
> > 
> > More power to them I say. There's no way to find gold in this sand. Let
> > them be.
> 
> Sure they are free to do whatever they want and I don't want to stop this
> but I'd like to see that effort eventually improving QEMU and not lost for
> us or need to be redone from scratch.

No one has the time and energy to wade through mountains of slop. 


> So some kind of AI policy is needed
> and a strict no-AI policy does not help to get these efforts defragmented.

There's no effort here.

> While goal oriented use of AI tools without caring for code quality leads to
> non-upstreamable patches maybe we could encourage these people to learn and
> even use an AI to redo their patches in a way that can at some point be
> upstreamed after some human review but since we don't have enough
> maintainers who could do that for them this should be done by the
> contributors. With the current no-AI policy they are locked out from
> contributing so they won't even try. By now they have implemented features
> we wanted for years but still could not get them due to not enough people
> being able to write code and while the AI generated patches can be mostly
> sand there are some gold in them that actually fixes issues or add features
> that could be useful if there was a way to upstream them. With current
> policy I can't even use the AI patches to look at them and clean them up for
> upstreaming (not that I want to do that due to the lot of nonsense to sift
> through but for some simpler patches this could be an option or if the
> patches would be made higher quality by better guarding what the AI does).
> Currently all I can say to these people is that QEMU does not accept AI
> generated patches but maube it would be better to say that while they cannot
> just submit their AI slop they should try to tell their AIs to do these
> again cleaning up all the nonsense and distill the gold from it and then
> there should be some way to let that improve QEMU without drowning the
> maintainers and putting all this effort on them.
> 
> Regards,
> BALATON Zoltan

AI's can not do this, at this juncture.

-- 
MST


