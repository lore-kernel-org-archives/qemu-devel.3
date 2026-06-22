Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918F3CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbebq-0002cK-2m; Mon, 22 Jun 2026 09:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbebn-0002bx-OA
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbebl-0002ts-6d
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782134555;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZDvv7nmkXCOqI7S6gkSfvqqbYUMqBzzFLzqVC0yLQh4=;
 b=i+8uYhZTflymLCXYs5VHv183mrjoFzgPi8ImR3gjtjauleeL9xdHoZLLsGAu1gf4fJplZf
 u69jSSCX97N6NCghOAbYiv9fKZW4PD84AqOsa8QTQ5G11hxmPIOgXw+Ki6XEZkNykOTgAX
 xelT1RUl8HuZxNqawpDeIvk8rjZ1zBo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-kC1Z9aQnMFGyOKmpnnwuhA-1; Mon,
 22 Jun 2026 09:22:31 -0400
X-MC-Unique: kC1Z9aQnMFGyOKmpnnwuhA-1
X-Mimecast-MFC-AGG-ID: kC1Z9aQnMFGyOKmpnnwuhA_1782134550
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67AF1180048E; Mon, 22 Jun 2026 13:22:30 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.119])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83461180065F; Mon, 22 Jun 2026 13:22:26 +0000 (UTC)
Date: Mon, 22 Jun 2026 14:22:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: fanhuang <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org,
 david@kernel.org, mst@redhat.com, gourry@gourry.net,
 philmd@mailo.com, peterx@redhat.com, Zhigang.Luo@amd.com,
 Lianjie.Shi@amd.com
Subject: Re: [PATCH v13 02/10] qapi, hmp: introspection for the sp-mem device
Message-ID: <ajk3DhhIoP0Ku5YP@redhat.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
 <20260619111136.3481329-3-FangSheng.Huang@amd.com>
 <ajkwrj9DncqDzWoN@redhat.com> <20260622150754.2fa1e457@imammedo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260622150754.2fa1e457@imammedo>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 22, 2026 at 03:07:54PM +0200, Igor Mammedov wrote:
> On Mon, 22 Jun 2026 13:55:10 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Fri, Jun 19, 2026 at 07:11:28PM +0800, fanhuang wrote:
> > > Add a SpMemDeviceInfo variant to MemoryDeviceInfo so `query-memory-devices`
> > > reports each sp-mem instance (id, addr, size, node, memdev), and print it
> > > from HMP `info memory-devices`.
> > > 
> > > Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
> > > ---
> > >  qapi/machine.json          | 43 ++++++++++++++++++++++++++++++++++++--
> > >  hw/core/machine-hmp-cmds.c | 11 ++++++++++
> > >  hw/mem/sp-mem.c            | 19 +++++++++++++++++
> > >  3 files changed, 71 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/qapi/machine.json b/qapi/machine.json
> > > index 685e4e29b8..777cfc81e1 100644
> > > --- a/qapi/machine.json
> > > +++ b/qapi/machine.json
> > > @@ -1413,6 +1413,32 @@
> > >            }
> > >  }
> > >  
> > > +##
> > > +# @SpMemDeviceInfo:
> > > +#
> > > +# sp-mem device state information
> > > +#
> > > +# @id: device's ID
> > > +#
> > > +# @addr: physical address, where device is mapped
> > > +#
> > > +# @size: size of memory that the device provides  
> > 
> > Is this bytes ? Please include the units in the comment.
> 
> we don't do that with any of memory devices,
> given it's QAPI - I guess bytes are implied for 'size' type
> (i.e. no suffix massaging)

The trouble with "implied" is that it relies on the reader being
familiar with QEMU's normal practice. Perhaps passable for regular
QEMU maintainers, but not good for app developers/users consuming
QEMU. It doesn't take much to add "in bytes" to these comments to
make it clear.

Although we don't do it universally/consistently, we do have
quite a few examples:

  $ git grep 'in bytes'  | wc -l
  95

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


