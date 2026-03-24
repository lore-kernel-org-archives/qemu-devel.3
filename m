Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B86FE9A74D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4yXv-0004zw-1j; Tue, 24 Mar 2026 05:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w4yXt-0004zV-Bu
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:59:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w4yXr-0002cf-4R
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774346369;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJ1vMBEe8Dsw41A89pk6yrT2C5ogE9dQJMhAO/T+c5w=;
 b=SqTICbrYwereK8+NrlWc0G7dWUNQbYApvjchxqTfOSsiezUhtalY4pD+idoctvOC4xXr19
 DsKI4OPxwL/rhg0zEuA3ZDhjlBCQvMpCfdEP5hxbR5FRbDziRLlflxASKOtE4HhBJ+IrA+
 44k5Dfz296QuIwGSRVo7qZx/kwe5wPk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-7uC1TSxwOT6Xs_9QeCDb0A-1; Tue,
 24 Mar 2026 05:59:23 -0400
X-MC-Unique: 7uC1TSxwOT6Xs_9QeCDb0A-1
X-Mimecast-MFC-AGG-ID: 7uC1TSxwOT6Xs_9QeCDb0A_1774346362
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3313119560AA; Tue, 24 Mar 2026 09:59:22 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26D43180058B; Tue, 24 Mar 2026 09:59:17 +0000 (UTC)
Date: Tue, 24 Mar 2026 09:59:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony PERARD <anthony.perard@vates.tech>
Cc: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, 
 Thierry Escande <thierry.escande@vates.tech>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 0/4] Xen: Add Q35 initial support for HVM guests
Message-ID: <acJgclxJ4_0YbBqT@redhat.com>
References: <20260313164649.794591-1-thierry.escande@vates.tech>
 <abVtsK31t9tWgsaY@mail-itl> <acJZHpw8tcTMPpCn@l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acJZHpw8tcTMPpCn@l14>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Mar 24, 2026 at 09:28:00AM +0000, Anthony PERARD wrote:
> On Sat, Mar 14, 2026 at 03:16:15PM +0100, Marek Marczykowski-Górecki wrote:
> > On Fri, Mar 13, 2026 at 04:46:56PM +0000, Thierry Escande wrote:
> > > This patch series introduces Q35 chipset support for Xen HVM guests. This is
> > > based on the work from Alexey Gerasimenko (See patchset [1] for reference).
> > > 
> > > This series does not implement device passthrough as this will need more work
> > > on the Xen side to support multiple PCI buses. Since Q35 chipset does not
> > > support device hotplugging and with current Xen mechanism for device
> > > passthrough, they have to be plugged to a new PCIe root port, i.e. not the PCI
> > > bus 0.
> > 
> > I always found it weird that Xen does hot-plugging of PCI passthrough
> > devices... Wouldn't it be easier to change this (connect them from the
> > very start, via QEMU cmdline) and declare hotplug as unsupported (at
> > least at this time)? I realize it's more complex change at the toolstack
> > side, but overall may simplify things and maybe even improve
> > reliability.
> 
> Skipping hot-plug on Q35 sounds good to me.
> 
> I though we could keep using QMP to do cold plug, with the experimental
> "--preconfig", but "device_add" isn't allowed :-(. So yes, doing this
> via command line sounds fine.
> 
> In libxl, we might be able to transform the json for `device_add` into
> the command line counterpart for `-device` fairly easily so the argument
> are only generated in a single place. Then we could skip the QMP
> "device_add" in libxl when it's already done via command line.

-device accepts JSON directly, so there's no transformation you
need to do from the QMP JSON. For example:

  -device '{"driver":"pcie-root-port","port":8,"chassis":1,"id":"pci.1","bus":"pcie.0","multifunction":true,"addr":"0x1"}'

Likewise  -object, -audiodev and -netdev accept QMP JSON too

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


