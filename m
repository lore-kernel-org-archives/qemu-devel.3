Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF43F54ADF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w55KN-0003I7-N4; Tue, 24 Mar 2026 13:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w55KJ-0003HP-4E
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w55KG-00038i-DD
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774372435;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sj9CvwQhStEW/EWj8oEYuJ49nZPiTxQJh0LwrRwHvhY=;
 b=SSMMc30TIg9QCjUCODyQ+aseddsrK2aqx24FcgAHULe5gYAJkhVje4Yan2/YKiVlRUXBTH
 Id+pFSVntTWRQOgDwF9dsIg2gynHwCfBiEU+Z/abs7zLSMDaGIvf1aN2TCyf1+ag6e01SH
 KgI81Z5fs/zXbBUf4diDPv7zOEmZ+jE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466--IPO9RMoN0etPEqMqRD-qQ-1; Tue,
 24 Mar 2026 13:13:53 -0400
X-MC-Unique: -IPO9RMoN0etPEqMqRD-qQ-1
X-Mimecast-MFC-AGG-ID: -IPO9RMoN0etPEqMqRD-qQ_1774372433
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0ECA18005B9
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 17:13:52 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BA741955D71; Tue, 24 Mar 2026 17:13:51 +0000 (UTC)
Date: Tue, 24 Mar 2026 17:13:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] treewide: replace qemu_hw_version() with QEMU_HW_VERSION
Message-ID: <acLGTGwGaFp92iM9@redhat.com>
References: <20260324165705.785605-1-pbonzini@redhat.com>
 <acLDpimgjedofUgE@redhat.com>
 <CABgObfbwXU5gtpKcq85LNeGce+7tkJGeUwSqTRQ06AXgvadE7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfbwXU5gtpKcq85LNeGce+7tkJGeUwSqTRQ06AXgvadE7g@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 24, 2026 at 06:11:04PM +0100, Paolo Bonzini wrote:
> On Tue, Mar 24, 2026 at 6:02 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Mar 24, 2026 at 05:57:05PM +0100, Paolo Bonzini wrote:
> > > The version is never set on 2.5+ machine types, so qemu_hw_version() and
> > > qemu_set_hw_version() are not needed anymore.
> > >
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  include/hw/core/boards.h  |  6 ------
> > >  include/qemu/hw-version.h | 15 ---------------
> > >  hw/ide/core.c             |  2 +-
> > >  hw/scsi/megasas.c         |  2 +-
> > >  hw/scsi/scsi-bus.c        |  2 +-
> > >  hw/scsi/scsi-disk.c       |  2 +-
> > >  system/vl.c               |  4 ----
> > >  target/s390x/cpu_models.c |  2 +-
> > >  util/osdep.c              | 12 ------------
> > >  9 files changed, 5 insertions(+), 42 deletions(-)
> > >
> > > diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> > > index f85f31bd90d..b8dad0a1074 100644
> > > --- a/include/hw/core/boards.h
> > > +++ b/include/hw/core/boards.h
> > > @@ -197,11 +197,6 @@ typedef struct {
> > >   *    used to provide @cpu_index to socket number mapping, allowing
> > >   *    a machine to group CPU threads belonging to the same socket/package
> > >   *    Returns: socket number given cpu_index belongs to.
> > > - * @hw_version:
> > > - *    Value of QEMU_VERSION when the machine was added to QEMU.
> > > - *    Set only by old machines because they need to keep
> > > - *    compatibility on code that exposed QEMU_VERSION to guests in
> > > - *    the past (and now use qemu_hw_version()).
> > >   * @possible_cpu_arch_ids:
> > >   *    Returns an array of @CPUArchId architecture-dependent CPU IDs
> > >   *    which includes CPU IDs for present and possible to hotplug CPUs.
> > > @@ -297,7 +292,6 @@ struct MachineClass {
> > >      const char *default_display;
> > >      const char *default_nic;
> > >      GPtrArray *compat_props;
> > > -    const char *hw_version;
> > >      ram_addr_t default_ram_size;
> > >      const char *default_cpu_type;
> > >      bool default_kernel_irqchip_split;
> > > diff --git a/include/qemu/hw-version.h b/include/qemu/hw-version.h
> > > index 730a8c904d9..a40a6c204a6 100644
> > > --- a/include/qemu/hw-version.h
> > > +++ b/include/qemu/hw-version.h
> > > @@ -7,21 +7,6 @@
> > >  #ifndef QEMU_HW_VERSION_H
> > >  #define QEMU_HW_VERSION_H
> > >
> > > -/*
> > > - * Starting on QEMU 2.5, qemu_hw_version() returns "2.5+" by default
> > > - * instead of QEMU_VERSION, so setting hw_version on MachineClass
> > > - * is no longer mandatory.
> > > - *
> > > - * Do NOT change this string, or it will break compatibility on all
> > > - * machine classes that don't set hw_version.
> > > - */
> >
> > I feel like we should be keeping a comment statement that
> > this must never be changed due to ABI compat.
> >
> > >  #define QEMU_HW_VERSION "2.5+"
> 
> Ok, what about this:
> 
>  * Starting on QEMU 2.5, devices with a version string in their
>  * identification data return "2.5+" instead of QEMU_VERSION.  Do
>  * NOT change this string as it is visible to guests.

Yep, with that comment

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> > Also, is there any better place this can live now that this
> > header file has a single #define and nothing else ?
> 
> I could put it in a random qdev header that everyone includes already
> - but I agree with Peter that it's better that it stays isolated, so
> that it does not grow more uses.

Yep, ok.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


