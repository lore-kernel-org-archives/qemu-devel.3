Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DB7C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBeg-0007Ky-Fn; Mon, 03 Jun 2024 13:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEBed-0007JJ-Ua
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEBec-0002vz-7w
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717436368;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3mmBXxRD3sAijr/TQMRqGzv+b4qbrBxDC/fQXXPUak=;
 b=LOcMGnKII3fTbzUfiOS0J+rftE/sfb+eNxfQVXowlIjAcsj1JCAc4n7lwkYASDLaqAQ6sA
 HJ6ObbwoEqfIDuOx9lKOivI5/UXnJ2quZ4bjU5Xdz4M7NBmN7JlPT/2z7YDNXb6PsL1X2M
 dhSTrazcXjNptgrxD/x1TpYKfG3G2Mk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-zqGgBa_sP_62897_2Cqi1A-1; Mon,
 03 Jun 2024 13:39:24 -0400
X-MC-Unique: zqGgBa_sP_62897_2Cqi1A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4F853C025A1;
 Mon,  3 Jun 2024 17:39:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B2B11C0D105;
 Mon,  3 Jun 2024 17:39:20 +0000 (UTC)
Date: Mon, 3 Jun 2024 18:39:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers for
 PC Q35
Message-ID: <Zl3_x-HIuzcTwXlw@redhat.com>
References: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
 <305d659b-d4d6-4681-bdad-cd869e552333@linaro.org>
 <20240602092857-mutt-send-email-mst@kernel.org>
 <77840065-1ad4-42bc-a19c-181ac7d63cf1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77840065-1ad4-42bc-a19c-181ac7d63cf1@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

On Mon, Jun 03, 2024 at 07:31:47PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Michael,
> 
> On 2/6/24 15:30, Michael S. Tsirkin wrote:
> > On Fri, Apr 12, 2024 at 11:57:35AM +0200, Philippe Mathieu-Daudé wrote:
> > > Hi Zhao,
> > > 
> > > On 12/4/24 10:53, Zhao Liu wrote:
> > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > 
> > > > Commit e4e98c7eebfa ("pc: q35: Bump max_cpus to 4096 vcpus") increases
> > > > the supported CPUs for PC Q35 machine.
> > > > 
> > > > Update maximum CPU numbers for PC Q35 in the document.
> > > > 
> > > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > > ---
> > > >    docs/system/target-i386-desc.rst.inc | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
> > > > index 5ebbcda9db4c..319e540573d3 100644
> > > > --- a/docs/system/target-i386-desc.rst.inc
> > > > +++ b/docs/system/target-i386-desc.rst.inc
> > > > @@ -36,7 +36,7 @@ The QEMU PC System emulator simulates the following peripherals:
> > > >    -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
> > > >       hub.
> > > > -SMP is supported with up to 255 CPUs.
> > > > +SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).
> > > 
> > > This comment is not accurate since a while, IIUC:
> > > 
> > > Up to q35-2.7: 255
> > > q35-2.8: 288
> > > q35-8.0+: 1024
> > > q35-9.0: 4096
> > 
> > 
> > What are you saying here, Philippe? I don't think compat
> > machine types matter enough to bother with more detail.
> 
> My point is I find this description confusing w.r.t. how QEMU behaves:

  snip

I think the docs should simply avoid mentioning any limit at all. ie

   -SMP is supported with up to 255 CPUs.
   +SMP is supported with a large number of virtual CPUs (upper limit is
    configuration dependent)


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


