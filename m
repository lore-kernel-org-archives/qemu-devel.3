Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF24ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfQL-00027n-8s; Mon, 09 Sep 2024 10:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfQF-0001nS-KA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfQC-000537-FO
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725892273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MoTUoucHa/qs8OISzbnX2OOpmk7SY6a1I9QCtsgouZk=;
 b=Fyv/QBgiLtrQZFvGsi4YgGzsvnilnIujq5nbmvbepVDNjzxys+oemp92BPRdoxJfu5e62d
 4ST+oD43Ryg4pa1EgJXkk/RxGfpD9lUYYqapsCqKMKRGmGt7pTH6qjAKxJ3CyUFngE4IYY
 dwLkqaSX5X4J6K3oNYR2oBy/2Zc2KEQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-mtBf5OswMLyJIzhYDjcslg-1; Mon, 09 Sep 2024 10:31:12 -0400
X-MC-Unique: mtBf5OswMLyJIzhYDjcslg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c35d6feed7so60869496d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725892271; x=1726497071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MoTUoucHa/qs8OISzbnX2OOpmk7SY6a1I9QCtsgouZk=;
 b=jFYcgYBobBXdLKaKuZ/tNf7rtC10gikH/HmokgIIPw/cwY762YIjpwpXHoB6tZ0RqC
 M7idiWQeqT0Wn4r8+k0XsFOyEycSZnCyN96E/OKnV6yR5YZG0K4zUgQnitUIdZB4Wq6H
 4u76BDDo0Cd7sEYDV3N4EP7QPTNFYH0KIa2qbD5ewvvntIp+0o78Jwxfngj2GA2alotC
 38241h9spdDspQY1lPt8Y9hD6PKB3dbyh9SV7iG4D06rICQmiSUNUaoVzOdJmWaN4Rvn
 n6jwdpd34Yn6+dg0S+jHgqpjV+m53mf5T+MNBevZaRikHMTNj/0nzrzkPSdO0mgWnEQ7
 TuNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDtqb6xnG0NQtwE0UtsZY0qMSTPfNeAKWYFrb96QDqdRG7QZ3n+9Z1xWqI36kwcJHInSmxWQVH6G/z@nongnu.org
X-Gm-Message-State: AOJu0YxvikpIlKbIX4FpxjZ4eDZAxl/cWSUZ/NV2rNDMG0FuAv4DKECB
 XLN6S8kMFIok4ENN/tzwqZK94qMktYoxKTz5E/ZXqMFqWUP7sRGL+7/EZE5g2mk8oNUoOIWNW2h
 JZRyOxXooA7YUcar9CHJTQg2KZ/EVkaXyUkaeV6aFyt1PMyeI3dS8
X-Received: by 2002:a05:6214:398a:b0:6c3:5760:d769 with SMTP id
 6a1803df08f44-6c5284f59cemr112906496d6.27.1725892271397; 
 Mon, 09 Sep 2024 07:31:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo/Glo6dMJYyFmdxuq+DueZPeXM+8xZalcOoIr1i3LApStdDRV7pYw5u1pUNV00uub71xmpg==
X-Received: by 2002:a05:6214:398a:b0:6c3:5760:d769 with SMTP id
 6a1803df08f44-6c5284f59cemr112906206d6.27.1725892270948; 
 Mon, 09 Sep 2024 07:31:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53474d6d7sm21044626d6.102.2024.09.09.07.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:31:10 -0700 (PDT)
Date: Mon, 9 Sep 2024 10:31:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 27/34] migration/multifd: Move nocomp code into
 multifd-nocomp.c
Message-ID: <Zt8GpnGWDYJE-dqg@x1n>
References: <20240904124417.14565-1-farosas@suse.de>
 <20240904124417.14565-28-farosas@suse.de>
 <CAFEAcA_F2qrSAacY=V5Hez1qFGuNW0-XqL2LQ=Y_UKYuHEJWhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_F2qrSAacY=V5Hez1qFGuNW0-XqL2LQ=Y_UKYuHEJWhw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 09, 2024 at 11:28:14AM +0100, Peter Maydell wrote:
> On Wed, 4 Sept 2024 at 13:48, Fabiano Rosas <farosas@suse.de> wrote:
> >
> > In preparation for adding new payload types to multifd, move most of
> > the no-compression code into multifd-nocomp.c. Let's try to keep a
> > semblance of layering by not mixing general multifd control flow with
> > the details of transmitting pages of ram.
> >
> > There are still some pieces leftover, namely the p->normal, p->zero,
> > etc variables that we use for zero page tracking and the packet
> > allocation which is heavily dependent on the ram code.
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
> I know Coverity has only flagged this up because the
> code has moved, but it seems like a good place to ask
> the question:
> 
> > +void multifd_ram_fill_packet(MultiFDSendParams *p)
> > +{
> > +    MultiFDPacket_t *packet = p->packet;
> > +    MultiFDPages_t *pages = &p->data->u.ram;
> > +    uint32_t zero_num = pages->num - pages->normal_num;
> > +
> > +    packet->pages_alloc = cpu_to_be32(multifd_ram_page_count());
> > +    packet->normal_pages = cpu_to_be32(pages->normal_num);
> > +    packet->zero_pages = cpu_to_be32(zero_num);
> > +
> > +    if (pages->block) {
> > +        strncpy(packet->ramblock, pages->block->idstr, 256);
> 
> Coverity points out that when we fill in the RAMBlock::idstr
> here, if packet->ramblock is not NUL terminated then we won't
> NUL-terminate idstr either (CID 1560071).
> 
> Is this really what is intended?
> 
> Perhaps
>          pstrncpy(packet->ramblock, sizeof(packet->ramblock),
>                   pages->block->idstr);
> 
> would be better?
> 
> (pstrncpy will always NUL-terminate, and won't pointlessly
> zero-fill the space after the string in the destination.)

In reality only the "zero-fill" change would affect us, as ramblock->idstr
always has the same size and always null-terminated, or we're in bigger
trouble.. So I assume there's no security concern, however indeed still
nice to use pstrcpy() to at least avoid zero-fills.

Thanks,

-- 
Peter Xu


