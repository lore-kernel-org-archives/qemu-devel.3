Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176DEC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 20:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVzo0-0005tb-Vp; Mon, 22 Jul 2024 16:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVzny-0005sy-QO
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVznv-0008D7-SO
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 16:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721680722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHUVeWk20YcEgOmAqHlb135jt536U3NdxkdqYwG4Sa0=;
 b=KChj+NmKZPue7EdDoEhE9FI60DBQOcKEmcuN94oL0GG6n1lkdWE3p/Of0kfOpp3dqbWpL6
 nIsx4m1CZWQzqFJuSYgrB0ebjIvyiDghcatsVRk7ikWqv7WJUEs0SKs73N/N6dUidwx96V
 iGi5zKkVdMFj8oj6oZa1stHQnWc0Hic=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-qVG51b95OtmWrpaF4qEJCg-1; Mon, 22 Jul 2024 16:38:40 -0400
X-MC-Unique: qVG51b95OtmWrpaF4qEJCg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-44945f42a7fso1851861cf.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721680720; x=1722285520;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHUVeWk20YcEgOmAqHlb135jt536U3NdxkdqYwG4Sa0=;
 b=PioIPvvFnOM06sws16jejGaeotevgRQipYnw4xErDJaUKCkk8bdZ2KA7dL4BbESVc9
 bbLjzjH0yaVpMkvviulEkg2PO9KUWuoiNegwzHNMFpvlOTWUn+aYzfIg8IrzI7VofKFs
 r5mN19thWlPFb3EvfJ0Zj2pA8E7xFar8IZPh52iZtyTyHsYNZs/b8MUjiSRuT8x873OQ
 R6Cw9Ob9+AUlbFwV/r3m/96OQJmpeEmkt+yTamnsC/qo20QPaCJcKcBCYTXMsgIGT5OT
 GCpBMjh37xQkY1LURFRLvROLnX26sUMT1DI2GqyqjA4RfP2h7qJ7CddlwZk2DqxvMjWt
 N2gw==
X-Gm-Message-State: AOJu0YwtXvwqM+JOeBbPQsfUuUVnHyBcLYKTZEITR3aF3Ar/zVEJUTpt
 fIR4zgkgoPtOmSFvtQCotc+dWiBd1aBYBUyULU3M930sWmIuqHLReXDflpB6taUFXNhQvOj3+8T
 sKQTvUJ7pDZBBSgutFpS45XzHsVnuz+eTgBqBo3TzS6qzVj32XcEkVuadH0df
X-Received: by 2002:a05:622a:1a13:b0:446:64c9:df73 with SMTP id
 d75a77b69052e-44fa5240962mr65707361cf.1.1721680719865; 
 Mon, 22 Jul 2024 13:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpk2Q9wHueBT7SwYUHc5AKDpQQ7BhnpE72wCZcGcCF+8m1cu1P0AHy3WCZd0yhSYTUb7Tn1g==
X-Received: by 2002:a05:622a:1a13:b0:446:64c9:df73 with SMTP id
 d75a77b69052e-44fa5240962mr65707241cf.1.1721680719415; 
 Mon, 22 Jul 2024 13:38:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cd4da6dsm37102401cf.57.2024.07.22.13.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 13:38:38 -0700 (PDT)
Date: Mon, 22 Jul 2024 16:38:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 6/9] migration/multifd: Move pages accounting into
 multifd_send_zero_page_detect()
Message-ID: <Zp7DTIM15kmvrQ4z@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-7-farosas@suse.de> <Zp6zF2oOHJMixISu@x1n>
 <87plr5yyua.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plr5yyua.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 22, 2024 at 05:07:57PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jul 22, 2024 at 02:59:11PM -0300, Fabiano Rosas wrote:
> >> All references to pages are being removed from the multifd worker
> >> threads in order to allow multifd to deal with different payload
> >> types.
> >> 
> >> multifd_send_zero_page_detect() is called by all multifd migration
> >> paths that deal with pages and is the last spot where zero pages and
> >> normal page amounts are adjusted. Move the pages accounting into that
> >> function.
> >
> > True, but it's a bit hackish to update (especially, normal) page counters
> > in a zero page detect function.
> 
> Hm, that's the one place in the code that actually sets
> normal_num. Seems adequate to me.

Fair point.

> 
> > I understand you want to move pages out of the thread function, that's
> > fair. How about put it in your new multifd_ram_fill_packet()?
> >
> 
> That one is skipped when mapped-ram is in use. I could move it to
> nocomp_send_prepare() after the zero_page_detect. It seems we're moving
> towards changing nocomp -> ram at some point anyway. Would that be
> better? It would duplicate the call due to the compression code.

Maybe it's simply that the helper itself (multifd_send_zero_page_detect)
needs a better name (perhaps multifd_send_ram_setup()?). I'm ok we leave
this one as-is:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


