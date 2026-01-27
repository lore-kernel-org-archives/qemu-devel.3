Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D814CD2FEF5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 22:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkrXr-0006Xl-PJ; Tue, 27 Jan 2026 17:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vkrXW-0006KK-Da
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 17:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vkrXU-0005Xm-1K
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 17:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769552878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HdbFF6MHOhH8ItasimE02Fiaz9yy2PggHPkdLbRmELo=;
 b=iz4O1KcGK0V5ry6tmz2FivPGPmgnMRO6ZPAC/1uriXp7y/P1CP610np39TRvhuEde3XqsN
 KDePOQEDyuCRN/7oQT1PknF7sAw0aAjJRZPJgE6BsxTq1jzvjbKZ5axys4eymvNYuFyB4y
 fmFpE3O8PwV0aniwgGvL+ynAkdJD7zE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-TAV2P6PcPx-xRJsSdPYRsA-1; Tue, 27 Jan 2026 17:27:56 -0500
X-MC-Unique: TAV2P6PcPx-xRJsSdPYRsA-1
X-Mimecast-MFC-AGG-ID: TAV2P6PcPx-xRJsSdPYRsA_1769552876
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4801d21c280so42115205e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 14:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769552875; x=1770157675; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HdbFF6MHOhH8ItasimE02Fiaz9yy2PggHPkdLbRmELo=;
 b=Fjgst/+TXpo7MYDCCOv7YfJAIE19oxJchrD/MFtUAUsLaXepb2tpFFFuu+fA0VgiYv
 t63L2dhQgh770Wp7fY7s93hjn1ZcewZpcqj1trXX5ZXXo78IynFHEv4BsmWRutCuTN+n
 sMrqQVfmT50/rp/CufHQRqs9waJbDuBD4z9O6zTvANFUohzpB0UtP5G5NI+EhcKN4yCv
 vqmhhzZXGsdsIoL3PgUVztPEsvlPpSVi+8DOrhtuU53mVEY8temSCL7uM7Ddtj+ZrsJ1
 ha89+v5N2kd1L8DgluVXXn2OxGuNd0AEvyM+Q64/nrx0ZTRYQGtk9ECvXqus/SLtUbfP
 0qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769552875; x=1770157675;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HdbFF6MHOhH8ItasimE02Fiaz9yy2PggHPkdLbRmELo=;
 b=MzGkis0E6ZGjVPizW7J2YniBs9iD+g61Pq0s88O8vpw6qbX1oNN/ysL/fFbqcZ8o4G
 n/WOOuvlRgcoygeyGDTQbEhFaEqt2YSGPcTiI42ubIj2AmIbzN/287DXPtLQwi//q3LM
 Eqk7lTFqNcKAwC1DXUonb4bNKpbg1wOFghKUEZcxGWr3qxaoyPIS8eayFCIZrKVd/4Bs
 sBpHu+vMz/xmsSoQs2qbofOAZwAXdGVt/63JVFx4PvGxb/LrcJdggnnVoKlGN2x6OgkX
 tOEjMvvgDvPQ3W1Qx4RWhkecwIvGAJJQNrCpSIUFt8afyBSug0vYsq9hBNBaUTaev6W2
 wasQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK7g/hoQwVmwzegP4YdzMoNkri/NFZntkElVAd3YIEHX03IRZ5+T3MCK1R5Sg445Y6340B7VZgvVEm@nongnu.org
X-Gm-Message-State: AOJu0Yz4ukDCL70BHsIrvD+Ji2wtk0fHFQkva4GAscWz9AHq9Mm6BjSw
 q4Osgf6nasBKMVTqzI5osGoOq5iyxPwFjmJKJ/oUf0Gh3XnyDu06Zb0yGCoi0h+ppVGPJhU1w9a
 5uBU/HHnrKqCcoll1iWTpvz+Zo8DhMYIHws/fRQBKDMD2rYzCJkolGr1H
X-Gm-Gg: AZuq6aINdGHXZrCJe3LBLGEQWa4XapLx4z2XHcJh44tmdJsjujhKAa4yNllPtSTINZu
 rhS9PJgGt3Pkfohb1nDfMhFbWZhERj3NKVAs57szmxe/syThBk1/pI0vkuK6HHy1evj4ZC4pZlb
 Q5aEnADGxUMd6mPIDzf6lORAhqfXE0bN1UnouVI1q49CSyWw34h5zZnyhM+tTQyQ7K7CTC1tx/X
 ZZOdmcLOiovgZBeFV7nfe9mvX7X43sNWOzG1/BZjqgHm1nSHt5U8ekESyqhqwhrwV8d1pa9xT+d
 PZEO17k/97UX0oX5WB/ttITQzEovpMPa9nR2qx2smVurEOKqu/2lbBN/NPDYB5AJ9V7F6MIv2aX
 RHydCkXHFLqUvockfM5IF4jxWt/0hp4B+sA==
X-Received: by 2002:a05:600c:154e:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-48069b8dfe3mr41404255e9.0.1769552875543; 
 Tue, 27 Jan 2026 14:27:55 -0800 (PST)
X-Received: by 2002:a05:600c:154e:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-48069b8dfe3mr41404055e9.0.1769552875073; 
 Tue, 27 Jan 2026 14:27:55 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm1971763f8f.7.2026.01.27.14.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 14:27:54 -0800 (PST)
Date: Tue, 27 Jan 2026 17:27:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 4/4] migration: Pass network packets received during
 switchover to dest VM
Message-ID: <20260127172333-mutt-send-email-mst@kernel.org>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
 <20260127140316.4187221-5-jmarcin@redhat.com>
 <aXjK01KuENw23xtV@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXjK01KuENw23xtV@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jan 27, 2026 at 02:25:23PM +0000, Daniel P. Berrangé wrote:
> On Tue, Jan 27, 2026 at 03:03:10PM +0100, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > During migration switchover both the source and the destination machines
> > are paused (compute downtime). During this period network still routes
> > network packets to the source machine, as this is the last place where
> > the recipient MAC address has been seen. Once the destination side
> > starts and sends network announcement, all subsequent frames are routed
> > correctly. However, frames delivered to the source machine are never
> > processed and lost. This causes also a network downtime with roughly the
> > same duration as compute downtime.
> > 
> > This can cause problems not only for protocols that cannot handle packet
> > loss, but can also introduce delays in protocols that can handle them.
> > 
> > To resolve this, this feature instantiates a network filter for each
> > network backend present during migration setup on both migration sides.
> > On the source side, this filter caches all packets received from the
> > backend during switchover. Once the destination machine starts, all
> > cached packets are sent through the migration channel and the respective
> > filter object on the destination side injects them to the NIC attached
> > to the backend.
> 
> If the dest QEMU has started, I presume this means that the ARP
> announcement has been sent ?

For example, with virtio guest announcements, it's sent by the dest VM.

Besides, arp "announcements" are not necessary to reprogram the network.

But if you want to abolutely avoid reordering, you can wait
until there's an attempt to transfer something, buffer that
something, process everything from the source (pass it to the VM),
then send whatever VM wants to send.

Thinkably, qemu initiated packets can be handled the same way.



>   IOW, the packets being forwarded
> over the migration stream are guaranteed to be delivered "out
> of order" wrt the sender.  Should be safe for TCP, but may have
> an impact on other protocols. Though apps should be aware of
> that risk in general, they may not frequently encounter it, and
> it could still cause service disruption
> 
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index f925e5541b..d637b22c80 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -520,6 +520,11 @@
> >  #     each RAM page.  Requires a migration URI that supports seeking,
> >  #     such as a file.  (since 9.0)
> >  #
> > +# @netpass: Collect packets received by network backedns after source
> > +#     VM is paused and send them to the destination once it resumes.
> > +#     This (almost) completely eliminates packet loss caused by
> > +#     switchover.  (since 11.0)
> 
> Should mention they will be deliver "out of order" 
> 
> > +#
> >  # Features:
> >  #
> >  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> > @@ -536,7 +541,7 @@
> >             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
> >             'validate-uuid', 'background-snapshot',
> >             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> > -           'dirty-limit', 'mapped-ram'] }
> > +           'dirty-limit', 'mapped-ram', 'netpass'] }
> >  
> >  ##
> >  # @MigrationCapabilityStatus:
> > -- 
> > 2.52.0
> > 
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


