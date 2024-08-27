Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76957C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 19:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj1Vj-00059Z-QV; Tue, 27 Aug 2024 15:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj1Va-00057x-Rv
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj1VX-00014y-5X
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724785533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GrjW9Q8Fhiki6dxLjlLiKQPNBBS0rn1XQvPKMlvqMU8=;
 b=FzCrLedrmzfDG8WfmQR2heW6MceumhKmFdJZnXLd/SrQndnLdm7u6akEALkaomW3ODRxt9
 nV+Py2624hbtxC+TRe1YB1zE+ZPFnnjT2Iz7FUNtgEajrmF9GVTizqxvg7jAWMK+46FMGF
 EMdGkw+aOomEDBG+7aMs2PJIa+RraGw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-tVc-IQ0ZMzu1YL0Jreckpw-1; Tue, 27 Aug 2024 15:05:32 -0400
X-MC-Unique: tVc-IQ0ZMzu1YL0Jreckpw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4501f17051eso88331961cf.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 12:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724785531; x=1725390331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GrjW9Q8Fhiki6dxLjlLiKQPNBBS0rn1XQvPKMlvqMU8=;
 b=Vyl1/lc2NmGmOlq0Qku61L84igQ7Sb6fnUfMgO35y53sRDGiok122FuCTq0U28F45k
 bunv/RNdY+b39UFExnjdAz0q9sFBlmywKuKXkA7rVO6n/hT/82ihhUW4IrPvXPW5w4KT
 d40OQ5LdPzmri/3LXqgIpTCZhYSSRf4vEEWYFkm7bZpRCdnEczhLb4yhvMN9zCAgLpfi
 d4mMIfdNPJY//E8R/EoAVvjNzwTA65hYX7e0y9cTkbSFl8iSn5gALx/4buKzmycjfUcb
 0f47yTU+1MBaykfBrmLdhKbKX9vhjuYgqXF2jdS2mmJIU87JolEPlG5lxhOslYpyXZkl
 SITQ==
X-Gm-Message-State: AOJu0Yy23jckPZpDdjqFz031upI8Eft+ddp+JoDMAMrBnk06I+LyxBGW
 /HdfKRv+fJQmVlvBX42pxaxXPLov3TX9oFp/BwxGW3Y0MbERw03zk5YX16nzI60AV2bP9iT6TkD
 fA0l5jFw2aVJ56VvQlVeBFYzLsf8uZ3uAYXUjfHiXOf3/OVPhIXFl
X-Received: by 2002:a05:622a:618c:b0:453:7533:1962 with SMTP id
 d75a77b69052e-45509c5352amr137274921cf.9.1724785531608; 
 Tue, 27 Aug 2024 12:05:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdglS2KebsTj995bf1yy28c+FrfbixAYMgoMgdaQndHE7Kw9C/VSTkCshR1Hl+1BwsbHXDqQ==
X-Received: by 2002:a05:622a:618c:b0:453:7533:1962 with SMTP id
 d75a77b69052e-45509c5352amr137274731cf.9.1724785531218; 
 Tue, 27 Aug 2024 12:05:31 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe196845sm55506671cf.72.2024.08.27.12.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 12:05:30 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:05:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 18/19] migration/multifd: Stop changing the packet on
 recv side
Message-ID: <Zs4jeFpSgp1osMn3@x1n>
References: <20240827174606.10352-1-farosas@suse.de>
 <20240827174606.10352-19-farosas@suse.de> <Zs4V8HajCAzNS3ZZ@x1n>
 <87plptx0so.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plptx0so.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 27, 2024 at 03:45:11PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Aug 27, 2024 at 02:46:05PM -0300, Fabiano Rosas wrote:
> >> @@ -254,12 +250,10 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
> >>          return 0;
> >>      }
> >>  
> >> -    /* make sure that ramblock is 0 terminated */
> >> -    packet->ramblock[255] = 0;
> >> -    p->block = qemu_ram_block_by_name(packet->ramblock);
> >> +    ramblock_name = g_strndup(packet->ramblock, 255);
> >
> > I understand we want to move to a const*, however this introduces a 256B
> > allocation per multifd packet, which we definitely want to avoid.. I wonder
> > whether that's worthwhile just to make it const. :-(
> >
> > I don't worry too much on the const* and vars pointed being abused /
> > updated when without it - the packet struct is pretty much limited only to
> > be referenced in this unfill function, and then we will do the load based
> > on MultiFDRecvParams* later anyway.  So personally I'd rather lose the
> > const* v.s. one allocation.
> >
> > Or we could also sanity check byte 255 to be '\0' (which, AFAIU, should
> > always be the case..), then we can get both benefits.
> 
> We can't because it breaks compat. Previous QEMUs didn't zero the
> packet.

Ouch!

Then.. shall we still try to avoid the allocation?

-- 
Peter Xu


