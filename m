Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D31C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 17:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhYO4-0003FQ-Or; Tue, 05 Mar 2024 12:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhYNu-0003EZ-6Z
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:15:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhYNg-0007FX-UC
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 12:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709658907;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+t9SWUakgKcc9CE2hDKAkdV9V4Hj4z8D/qArh4w22Y=;
 b=OQVqErZft+rPvQIZhDI8Qqknhk8UxAmoeQavHdQ4IheCAHVYCJtQyPHQcODpglmvTRsBcm
 TTZGkUT5l0va6rYhaSnjYzNVDmtAoZC9ivHEYk1XEjq3KcRPRB7bgvI6bb9X7ZN/bN7SFQ
 edr/cY8JZn+n5RMJQdXJd0zcwv7Apb0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-VqJV2yHhO9SpmtnlMt76xQ-1; Tue,
 05 Mar 2024 12:15:04 -0500
X-MC-Unique: VqJV2yHhO9SpmtnlMt76xQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 048061C41A03;
 Tue,  5 Mar 2024 17:15:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB8A417A8E;
 Tue,  5 Mar 2024 17:14:59 +0000 (UTC)
Date: Tue, 5 Mar 2024 17:14:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: fan <nifan.cxl@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, gregory.price@memverge.com,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Jorgen.Hansen@wdc.com, wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 13/13] qapi/cxl.json: Add QMP interfaces to print out
 accepted and pending DC extents
Message-ID: <ZedTEa8aktb-kKwt@redhat.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-14-nifan.cxl@gmail.com>
 <20240305160908.000010c5@Huawei.com> <ZedFIp5gK4aXsqD-@redhat.com>
 <ZedRsZee2WhTi_Nd@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZedRsZee2WhTi_Nd@debian>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 05, 2024 at 09:09:05AM -0800, fan wrote:
> On Tue, Mar 05, 2024 at 04:15:30PM +0000, Daniel P. Berrangé wrote:
> > On Tue, Mar 05, 2024 at 04:09:08PM +0000, Jonathan Cameron via wrote:
> > > On Mon,  4 Mar 2024 11:34:08 -0800
> > > nifan.cxl@gmail.com wrote:
> > > 
> > > > From: Fan Ni <fan.ni@samsung.com>
> > > > 
> > > > With the change, we add the following two QMP interfaces to print out
> > > > extents information in the device,
> > > > 1. cxl-display-accepted-dc-extents: print out the accepted DC extents in
> > > >    the device;
> > > > 2. cxl-display-pending-to-add-dc-extents: print out the pending-to-add
> > > >    DC extents in the device;
> > > > The output is appended to a file passed to the command and by default
> > > > it is /tmp/dc-extent.txt.
> > > Hi Fan,
> > > 
> > > Is there precedence for this sort of logging to a file from a qmp
> > > command?  I can see something like this being useful.
> > 
> > This is pretty unusual.
> 
> Yeah. I cannot find anything similar in existing code, my initial plan
> was to print out to the screen directly, however, cannot find out how to
> do it nicely, so decided to go with a file. 
> 
> Is there a reason why we do not want to go with this approach?
> 
> > 
> > For runtime debugging information our strong preference is to integrate
> > 'trace' probes throughout the code:
> > 
> >   https://www.qemu.org/docs/master/devel/tracing.html#tracing
> 
> I am not familiar with the trace mechanism. However, I think the
> approach in this patch may be useful not only for debugging purpose.
> Although not tried yet, maybe we can also use the approach to set
> some parameters at runtime like what procfs does?

Please don't invent something new unless you can show why QEMU's existing
tracing system isn't sufficiently good for the problem. QEMU's tracing
can dump to the terminal directly, or integrate with a variety of other
backends, and data can be turned off/on at runtime per-trace point.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


