Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8265CD98FE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 18:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smHQu-0003zy-Dd; Thu, 05 Sep 2024 14:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smHQo-0003yG-57
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smHQm-0004U7-4I
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 14:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725561726;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gN6fCe6L4FARQ2MSXXVhC5BzIkTJf78xxsfYBwi9L4Y=;
 b=KV1+ZcHDlly84Bg2DAmBokjY0GxTmfraw960dHe0mB7YShjeSn9/oove+7eL/bPM1+trUT
 0lmaKw1MYnOmLL+KGerw0xaqPouVaLtn6mfD8dPKv1jmIwPZYkK9OI4JTPUvf8+PdU1q4s
 2NF0M1fK9D+xuAchq4warvPo8vLGTu4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-dZH23qfiNMa50GmyKrBZgA-1; Thu,
 05 Sep 2024 14:22:34 -0400
X-MC-Unique: dZH23qfiNMa50GmyKrBZgA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 071DD1955D4E; Thu,  5 Sep 2024 18:22:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FFE61955F45; Thu,  5 Sep 2024 18:22:18 +0000 (UTC)
Date: Thu, 5 Sep 2024 19:22:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH for-9.2] hw: add compat machines for 9.2
Message-ID: <Ztn21z0ZR3_MiVQJ@redhat.com>
References: <20240816103723.2325982-1-cohuck@redhat.com>
 <Zr8uNB8gaJTroMBU@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zr8uNB8gaJTroMBU@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Aug 16, 2024 at 11:47:16AM +0100, Daniel P. Berrangé wrote:
> On Fri, Aug 16, 2024 at 12:37:23PM +0200, Cornelia Huck wrote:
> > Add 9.2 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/arm/virt.c              |  9 ++++++++-
> >  hw/core/machine.c          |  3 +++
> >  hw/i386/pc.c               |  3 +++
> >  hw/i386/pc_piix.c          | 15 ++++++++++++---
> >  hw/i386/pc_q35.c           | 13 +++++++++++--
> >  hw/m68k/virt.c             |  9 ++++++++-
> >  hw/ppc/spapr.c             | 15 +++++++++++++--
> >  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
> >  include/hw/boards.h        |  3 +++
> >  include/hw/i386/pc.h       |  3 +++
> >  10 files changed, 77 insertions(+), 10 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index d9e69243b4a7..746bfe05d386 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -479,13 +479,24 @@ static void pc_i440fx_machine_options(MachineClass *m)
> >                                       "Use a different south bridge than PIIX3");
> >  }
> >  
> > -static void pc_i440fx_machine_9_1_options(MachineClass *m)
> > +static void pc_i440fx_machine_9_2_options(MachineClass *m)
> >  {
> >      pc_i440fx_machine_options(m);
> >      m->alias = "pc";
> >      m->is_default = true;
> >  }
> >  
> > +DEFINE_I440FX_MACHINE(9, 2);
> > +
> > +static void pc_i440fx_machine_9_1_options(MachineClass *m)
> > +{
> > +    pc_i440fx_machine_9_2_options(m);
> > +    m->alias = NULL;
> > +    m->is_default = false;
> > +    compat_props_add(m->compat_props, hw_compat_9_1, hw_compat_9_1_len);
> > +    compat_props_add(m->compat_props, pc_compat_9_1, pc_compat_9_1_len);
> > +}
> > +
> >  DEFINE_I440FX_MACHINE(9, 1);
> >  
> >  static void pc_i440fx_machine_9_0_options(MachineClass *m)
> > @@ -493,8 +504,6 @@ static void pc_i440fx_machine_9_0_options(MachineClass *m)
> >      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> >  
> >      pc_i440fx_machine_9_1_options(m);
> > -    m->alias = NULL;
> > -    m->is_default = false;
> >      m->smbios_memory_device_size = 16 * GiB;
> 
> Feels like we should be adding an "_AS_LATEST" macro
> variant for piix/q35 too, so it matches the pattern
> in other targets for handling alias & is_default.
> 
> Not a thing your patch needs todo though.

I've just a patch that does that now. If it looks good & you want to include
it as a pre-requisite for your patch here feel free to grab, otherwise I can
rebase it after your patch merges.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


