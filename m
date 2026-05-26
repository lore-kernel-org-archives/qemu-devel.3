Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEF1CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRwZ8-00007n-Iw; Tue, 26 May 2026 14:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wRwZ4-000072-Di
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wRwZ1-0004Tz-JB
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779820298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tb/TnAHiKrS1LiqYDTMK+bdE+OEmTdDu++nO92M79Ow=;
 b=PC/HjcXGMtWNnnbcROD8PXI4Cr8VrN25AREtmeCIZ+ZaDo7Qn96D7gZvrLoXCSx3IQoXLa
 hcQNSrCGW9hQbDg0kHPjdlmWLNYOvj+dFUQcUy9B63R+HxMIm6Ipsq8EA2aqTNsGxzmcle
 CGOWaCiEcIOaf+9PdLEog1Oi2Pqdckw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-Di8XfshZPois4TzKGPdUMw-1; Tue,
 26 May 2026 14:31:33 -0400
X-MC-Unique: Di8XfshZPois4TzKGPdUMw-1
X-Mimecast-MFC-AGG-ID: Di8XfshZPois4TzKGPdUMw_1779820291
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BEDC1956055; Tue, 26 May 2026 18:31:31 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.131])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71AA419560AB; Tue, 26 May 2026 18:31:28 +0000 (UTC)
Date: Tue, 26 May 2026 20:31:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [Stable-11.0.1 v2 00/94] Patch Round-up for stable 11.0.1,
 freeze on 2026-05-22 (frozen)
Message-ID: <ahXm_s1Qfmgzkijm@redhat.com>
References: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
 <51204e0c-14e1-41db-8eaf-83bc3734567d@proxmox.com>
 <573968a1-4077-48e8-b14b-a8c8074b9e1b@tls.msk.ru>
 <ahXhRKqcpoVmCAID@redhat.com>
 <1f4c78dc-b2bb-4afd-8b82-0d89897cf230@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f4c78dc-b2bb-4afd-8b82-0d89897cf230@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 26.05.2026 um 20:09 hat Michael Tokarev geschrieben:
> On 26.05.2026 21:07, Kevin Wolf wrote:
> > Am 23.05.2026 um 08:49 hat Michael Tokarev geschrieben:
> 
> > > I'll wait for some reaction.  Kevin?
> > 
> > I was out yesterday and most of today, so I could only take a quick look
> > just now. The patch looks reasonable to me at first sight, I'll try to
> > have a closer look tomorrow.
> 
> Thank you Kevin!
> 
> There's no rush anymore, I tagged stable releases yesterday already,
> should be out once Mike creates and uploads the tarballs.
> 
> I removed the other patches from your pullreq which Fiona pointed
> out previously, to be picked up once we have better time.

Ok, perfect. I wasn't completely sure if I should actually recommend
removing the patches even if we have a follow-up patch because it
addresses a problem that has existed for a long time and people have
only reported it now. So it only makes sense that we're not trying to
rush something into stable that might end up making things worse.

> Maybe the next stable releases will be sooner than usual, due to
> security fixes coming in.

Hard to take this as good news, but it is what it is. :-)

Kevin


