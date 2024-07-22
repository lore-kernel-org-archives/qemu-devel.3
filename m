Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EB2C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0F7-0003JO-DJ; Mon, 22 Jul 2024 17:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sW0Es-0002Nr-E5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sW0Ep-00058g-1u
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721682389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=brluLAieoSdueMdK0HNd3adXTAIhhnRa0mqPjxkAap8=;
 b=iI7xVWjWW/bm/q+G7tb5r9hgzYveijsBY4ld/sH+DQ3TBIRuDgijjd5l+2ByEr0GM/wgQd
 1GOTlikRbo1MJdGGvZj29FrGeYCIaqTWwcNt678LujJGqW0xJS+DRe8OyQJnZNTRmipybF
 yQse4RQjILLNRDDp/EMyaJ5HE7WiL3E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-kjHZw2CkNFWdngADp5Ykng-1; Mon, 22 Jul 2024 17:06:27 -0400
X-MC-Unique: kjHZw2CkNFWdngADp5Ykng-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b792d6fe5bso15846216d6.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682386; x=1722287186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brluLAieoSdueMdK0HNd3adXTAIhhnRa0mqPjxkAap8=;
 b=L8MKWPveb/6kFg5JdpWOR6G8dd5KbJ1kH6zCkPsvD6H0BT5sUGmXd0agQfVXKfELtj
 rSKLKWYiVT5R7V6JuScdL/DSUdZnbk8+fkxyXpo4l/DMGafNmwg+/JF1jVOz9efhcUTF
 ek74gPtHSKDzK3xWml5bQF6ekaHpRSJXs8uCNU75/MLHD9IP2swek4T4Hij29gN0kb/F
 t/9CtUH4jfRYTsk7/iXTaXTGJ28QtWy/cHUC5aNtje6KMijZmtf1Uv6P5PymcwHSKFg4
 G2O+rkQu7cS5G5jJreIXcWdXNKL83jydFnNGViMRlgEIL41Bmx4MIoYIKoNRHnDpnx8W
 g8Qw==
X-Gm-Message-State: AOJu0Yxg3lYm1od/WLL5QRxhbIXLXOdp6U4ueyGvA4D9cGhbE9OzefIg
 7QWgFakBFL2TGXp5g/KacdgqiN1jkUUPJmj3QUvQW+m0p7pLjuFVpcA8J01Mg0K7meW5+AxPhkc
 LDso8q6lWH3rvkkAHV8g5jYT6QbhF4DFLS8jzatH9QHp8hkwH88lpOkwGXMGp
X-Received: by 2002:a05:6214:3907:b0:6b5:600:acc8 with SMTP id
 6a1803df08f44-6b94f0117a2mr64225346d6.1.1721682386603; 
 Mon, 22 Jul 2024 14:06:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWTjY/PtNh+vVa8VVB7UxtZNk4+JDRfxHKGZRF7SksEQOMdFeFfoTRaBJBxNOql4JUvY9hZQ==
X-Received: by 2002:a05:6214:3907:b0:6b5:600:acc8 with SMTP id
 6a1803df08f44-6b94f0117a2mr64225136d6.1.1721682386145; 
 Mon, 22 Jul 2024 14:06:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7acb07fd0sm39129216d6.130.2024.07.22.14.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 14:06:25 -0700 (PDT)
Date: Mon, 22 Jul 2024 17:06:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 7/9] migration/multifd: Isolate ram pages packet
 data
Message-ID: <Zp7Jz9I3jVlrg8uK@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-8-farosas@suse.de> <Zp6089I1ozCg1Eaq@x1n>
 <87h6chyxln.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6chyxln.fsf@suse.de>
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

On Mon, Jul 22, 2024 at 05:34:44PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jul 22, 2024 at 02:59:12PM -0300, Fabiano Rosas wrote:
> >> While we cannot yet disentangle the multifd packet from page data, we
> >> can make the code a bit cleaner by setting the page-related fields in
> >> a separate function.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  migration/multifd.c | 97 ++++++++++++++++++++++++++++-----------------
> >>  1 file changed, 61 insertions(+), 36 deletions(-)
> >> 
> >> diff --git a/migration/multifd.c b/migration/multifd.c
> >> index fcdb12e04f..d25b8658b2 100644
> >> --- a/migration/multifd.c
> >> +++ b/migration/multifd.c
> >> @@ -409,65 +409,62 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
> >>      return msg.id;
> >>  }
> >>  
> >> -void multifd_send_fill_packet(MultiFDSendParams *p)
> >> +static void multifd_ram_fill_packet(MultiFDSendParams *p)
> >>  {
> >>      MultiFDPacket_t *packet = p->packet;
> >>      MultiFDPages_t *pages = &p->data->u.ram;
> >> -    uint64_t packet_num;
> >>      uint32_t zero_num = pages->num - pages->normal_num;
> >> -    int i;
> >>  
> >> -    packet->flags = cpu_to_be32(p->flags);
> >>      packet->pages_alloc = cpu_to_be32(pages->allocated);
> >>      packet->normal_pages = cpu_to_be32(pages->normal_num);
> >>      packet->zero_pages = cpu_to_be32(zero_num);
> >> -    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
> >
> > Definitely good intention, but I had a feeling that this will need to be
> > reorganized again when Maciej reworks on top, due to the fact that
> > next_packet_size will be ram-private field, simply because it's defined
> > after pages_alloc and normal_pages...
> >
> > E.g., see:
> >
> > https://lore.kernel.org/r/41dedaf2c9abebb5e45f88c052daa26320715a92.1718717584.git.maciej.szmigiero@oracle.com
> >
> > Where the new MultiFDPacketHdr_t cannot include next_packet_size (even if
> > VFIO will need that too..).
> 
> Isn't it just a matter of setting next_packet_size in the other path as
> well?
> 
> @Maciej, can you comment?
> 
> >
> > typedef struct {
> >     uint32_t magic;
> >     uint32_t version;
> >     uint32_t flags;
> > } __attribute__((packed)) MultiFDPacketHdr_t;
> >
> > So _maybe_ it's easier we drop this patch and leave that part to Maciej to
> > identify which is common and which is arm/vfio specific.  No strong
> > opinions here.
> >
> 
> I could drop it if that's preferrable. However, patch 8/9 is absolutely
> necessary so we can remove this madness of having to clear
> MultiFDPages_t fields at the multifd_send_thread() top level. It took me
> a whole day to figure that one out and that bug has been manifesting
> ever since I started working on multifd.
> 
> I'm not sure how we'll do that without this patch. Maybe it's better I
> fix in this one whatever you guys think needs fixing.

You can set next_packet_size only in ram path, or you can keep this patch
as is and let Maciej rework it on top.

I'm fine either way.

-- 
Peter Xu


