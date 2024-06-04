Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005D3C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPrJ-0006WO-Ud; Tue, 04 Jun 2024 04:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEPrG-0006WF-PM
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEPrE-000262-Uu
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717490968;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHZlcEEH9p0Ye3Yot3VfA1JqbgDHS42DV68ZkPD6Wuo=;
 b=ZYeV0YIWDIWyM7bDywOt6utBgPJzxQzzyeIXOP0LYyvVcpCZHyXwXzkIWjuwUhkDV44w4W
 C4IKQZbxcdAPrqw1jBEXQfMLh5l+u12o8z8EdR2pQHSEVazoUB5MdVDLuyLLtVmq/JD0ya
 dRx5X/uvtQXAR7aYm/9yMBgzv9STVrc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-id1TJ6eENEqN1ZxyvpTPog-1; Tue, 04 Jun 2024 04:49:23 -0400
X-MC-Unique: id1TJ6eENEqN1ZxyvpTPog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 933B8811E8D;
 Tue,  4 Jun 2024 08:49:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F35BC2875;
 Tue,  4 Jun 2024 08:49:21 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:49:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers for
 PC Q35
Message-ID: <Zl7VD795Izsp55mp@redhat.com>
References: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
 <305d659b-d4d6-4681-bdad-cd869e552333@linaro.org>
 <20240602092857-mutt-send-email-mst@kernel.org>
 <77840065-1ad4-42bc-a19c-181ac7d63cf1@linaro.org>
 <Zl3_x-HIuzcTwXlw@redhat.com> <Zl7XhRvpxQNy+vna@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl7XhRvpxQNy+vna@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 04, 2024 at 04:59:49PM +0800, Zhao Liu wrote:
> Hi Michael, Daniel, and Philippe,
> 
> On Mon, Jun 03, 2024 at 06:39:19PM +0100, Daniel P. Berrangé wrote:
> > Date: Mon, 3 Jun 2024 18:39:19 +0100
> > From: "Daniel P. Berrangé" <berrange@redhat.com>
> > Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers
> >  for PC Q35
> > 
> > On Mon, Jun 03, 2024 at 07:31:47PM +0200, Philippe Mathieu-Daudé wrote:
> > > Hi Michael,
> > > 
> > > On 2/6/24 15:30, Michael S. Tsirkin wrote:
> > > > On Fri, Apr 12, 2024 at 11:57:35AM +0200, Philippe Mathieu-Daudé wrote:
> > > > > Hi Zhao,
> > > > > 
> > > > > On 12/4/24 10:53, Zhao Liu wrote:
> > > > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > > > 
> > > > > > Commit e4e98c7eebfa ("pc: q35: Bump max_cpus to 4096 vcpus") increases
> > > > > > the supported CPUs for PC Q35 machine.
> > > > > > 
> > > > > > Update maximum CPU numbers for PC Q35 in the document.
> > > > > > 
> > > > > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > > > > ---
> > > > > >    docs/system/target-i386-desc.rst.inc | 2 +-
> > > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
> > > > > > index 5ebbcda9db4c..319e540573d3 100644
> > > > > > --- a/docs/system/target-i386-desc.rst.inc
> > > > > > +++ b/docs/system/target-i386-desc.rst.inc
> > > > > > @@ -36,7 +36,7 @@ The QEMU PC System emulator simulates the following peripherals:
> > > > > >    -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
> > > > > >       hub.
> > > > > > -SMP is supported with up to 255 CPUs.
> > > > > > +SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).
> > > > > 
> > > > > This comment is not accurate since a while, IIUC:
> > > > > 
> > > > > Up to q35-2.7: 255
> > > > > q35-2.8: 288
> > > > > q35-8.0+: 1024
> > > > > q35-9.0: 4096
> > > > 
> > > > 
> > > > What are you saying here, Philippe? I don't think compat
> > > > machine types matter enough to bother with more detail.
> > > 
> > > My point is I find this description confusing w.r.t. how QEMU behaves:
> > 
> >   snip
> > 
> > I think the docs should simply avoid mentioning any limit at all. ie
> > 
> >    -SMP is supported with up to 255 CPUs.
> >    +SMP is supported with a large number of virtual CPUs (upper limit is
> >     configuration dependent)
> 
> I agree, the limit may also be different for different scenarios, and it
> is not appropriate to describe it in detail.
> 
> Sorry I forgot that this patch has been merged in by Thomas for me
> (838f82468a12), and I can modify it with a new patch based on Daniel's
> suggestion.

That's no problem at all. A followup patch is fine.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


