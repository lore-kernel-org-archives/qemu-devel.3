Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E4FC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txMy6-0003eN-H3; Wed, 26 Mar 2025 05:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txMxy-0003d1-2T
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txMxv-00028S-7M
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742980945;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qdqljVMQXTwG4flLDGUH9vTVfQiEjvsG0BNUDJyHj5w=;
 b=CKZIhDpmi5h8tT2B7WrCozGujeVExg38XInx6jqseyS7EqzeWpr9USoGtROfw1nhhtLYfC
 XsNORiYzQBe5n8fJXoefRAb64PMs7btaI3xTJyQVN6yYd+3Pn2i62mckp0y6R2pv1xQm/p
 LP62i0kgvrcVoWNEkDoImv3PT/frN9E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-DK_IWoKlPsel9EDgM1PdNA-1; Wed,
 26 Mar 2025 05:22:20 -0400
X-MC-Unique: DK_IWoKlPsel9EDgM1PdNA-1
X-Mimecast-MFC-AGG-ID: DK_IWoKlPsel9EDgM1PdNA_1742980938
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ADF21933B4F; Wed, 26 Mar 2025 09:22:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.107])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46F8E1801751; Wed, 26 Mar 2025 09:22:12 +0000 (UTC)
Date: Wed, 26 Mar 2025 09:22:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v7 52/52] docs: Add TDX documentation
Message-ID: <Z-PHQW9lVao-DY1F@redhat.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-53-xiaoyao.li@intel.com>
 <Z-L6CSajU284qAJ4@redhat.com>
 <81e9d055-377c-4521-9588-a6bad60b3a6d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81e9d055-377c-4521-9588-a6bad60b3a6d@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 26, 2025 at 11:36:09AM +0800, Xiaoyao Li wrote:
> On 3/26/2025 2:46 AM, Daniel P. Berrangé wrote:
> > On Fri, Jan 24, 2025 at 08:20:48AM -0500, Xiaoyao Li wrote:
> > > Add docs/system/i386/tdx.rst for TDX support, and add tdx in
> > > confidential-guest-support.rst
> > > 
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > ---
> > 
> > > ---
> > >   docs/system/confidential-guest-support.rst |   1 +
> > >   docs/system/i386/tdx.rst                   | 156 +++++++++++++++++++++
> > >   docs/system/target-i386.rst                |   1 +
> > >   3 files changed, 158 insertions(+)
> > >   create mode 100644 docs/system/i386/tdx.rst
> > 
> > 
> > > +Launching a TD (TDX VM)
> > > +-----------------------
> > > +
> > > +To launch a TD, the necessary command line options are tdx-guest object and
> > > +split kernel-irqchip, as below:
> > > +
> > > +.. parsed-literal::
> > > +
> > > +    |qemu_system_x86| \\
> > > +        -object tdx-guest,id=tdx0 \\
> > > +        -machine ...,kernel-irqchip=split,confidential-guest-support=tdx0 \\
> > > +        -bios OVMF.fd \\
> > > +
> > > +Restrictions
> > > +------------
> > > +
> > > + - kernel-irqchip must be split;
> > 
> > Is there a reason why we don't make QEMU set kernel-irqchip=split
> > automatically when tdx-guest is enabled ?
> > 
> > It feels silly to default to a configuration that is known to be
> > broken with TDX. I thought about making libvirt automatically
> > set kernel-irqchip=split, or even above that making virt-install
> > automatically set it. Addressing it in QEMU would seem the most
> > appropriate place though.
> 
> For x86, if not with machine older than machine-4.0, the default
> kernel_irqchip is set to split when users don't set a value explicitly:

I think you may have mis-read the code. *ONLY* pc-q35-4.0 uses
the split IRQ chip. Everything both older and newer than that
uses kernel IRQ chip by default. So our default machine type
settings are incompatible with TDX, except for pc-q35-4.0

We initially tried to use the split IRQ chip by default for 4.0:

  commit b2fc91db84470a78f8e93f5b5f913c17188792c8
  Author: Peter Xu <peterx@redhat.com>
  Date:   Thu Dec 20 13:40:35 2018 +0800

    q35: set split kernel irqchip as default
    
    Starting from QEMU 4.0, let's specify "split" as the default value for
    kernel-irqchip.

but had to revert this in the very next release

  commit c87759ce876a7a0b17c2bf4f0b964bd51f0ee871
  Author: Alex Williamson <alex.williamson@redhat.com>
  Date:   Tue May 14 14:14:41 2019 -0600

    q35: Revert to kernel irqchip
    
    Commit b2fc91db8447 ("q35: set split kernel irqchip as default") changed
    the default for the pc-q35-4.0 machine type to use split irqchip, which
    turned out to have disasterous effects on vfio-pci INTx support.

> 
>  if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
>         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ?
> ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>     }
> 
> 
> I think QEMU should only set it to split automatically for TDX guest when
> users don't provide a explicit value. And current code just works as
> expected.
>
> Further, I think we can at least add the check in tdx_kvm_init() like this
> 
> if (kvm_state->kernel_irqchip_split != ON_OFF_AUTO_ON) {
> 	error_setg(errp, "TDX VM requires kernel_irqchip to be split");
> 	return -EINVAL;
> }
> 
> Are you OK with it?

IMHO we need to modify the current check for

  "kernel_irqchip_split == ON_OFF_AUTO_AUTO"

so that it sets to 'ON_OFF_AUTO_ON', if  TDX is enabled.

ie something more like

  if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
       if (...tdx...) {
          s->kernel_irqchip_split = ON_OFF_AUTO_ON;
       } else {
         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ?
> ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
       }
  }


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


