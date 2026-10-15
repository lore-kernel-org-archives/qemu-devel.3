Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8BACC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIaL-0008Td-AS; Thu, 15 Oct 2026 06:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1xHIaJ-0008TR-4l
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1xHIaH-0002uj-KD
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792059671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMvarRM6vFnM2kMNNLS1QFCJePwpsRIbQWrYdpVj36Q=;
 b=E3eqBrlxA23XWmiH9LNDs0BnFLaaEZ399szCvXx9VB9OyMKYPPFl7u325cggUX3KnY5mxD
 SgcPxRrRaUHj4xKa879DPl6IPRmHKWMorx/7e761PiCWiDHSVnJqAnacHIylg8nYfIwtlt
 eMmguM34eE3Yrnap6C1auw+7NyJgM6w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-a8Jjjy56ORem-yPU4dnaPw-1; Thu,
 15 Oct 2026 10:21:03 +0000
X-MC-Unique: a8Jjjy56ORem-yPU4dnaPw-1
X-Mimecast-MFC-AGG-ID: a8Jjjy56ORem-yPU4dnaPw_1792059662
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 654FD1956089; Thu, 15 Oct 2026 10:21:02 +0000 (UTC)
Received: from nucbdw.ghoffman.csb.home.kraxel.org
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E70C77D5; Thu, 15 Oct 2026 10:21:01 +0000 (UTC)
Received: by nucbdw.ghoffman.csb.home.kraxel.org (Postfix, from userid 11758)
 id 8BF4C4077B24; Thu, 15 Oct 2026 12:20:59 +0200 (CEST)
Date: Thu, 15 Oct 2026 12:20:59 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] pci id: clarify pci subsystem id usage
Message-ID: <atCmDyLUrH6D0JaS@nucbdw.ghoffman.csb.home.kraxel.org>
References: <20261015081544.40310-1-kraxel@redhat.com>
 <20261015081544.40310-2-kraxel@redhat.com>
 <atCSufyPp8vdreSI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atCSufyPp8vdreSI@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ghoffman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Thu, Oct 15, 2026 at 09:45:45AM +0100, Daniel P. Berrangé wrote:
> >  1af4:1100
> > -  Used as PCI Subsystem ID for existing hardware devices emulated
> > -  by QEMU.
> > +  Used as PCI Subsystem ID for existing hardware devices emulated by
> > +  QEMU, such as the intel chipset devices.  Also used for virtio
> > +  devices and generic pci class devices (1b36:00xx, see below).
> 
> When talking virtio devices, does that include virtio devices
> implemented outside QEMU via vhostuser, or only in-QEMU virtio
> devices ?

For vhost devices the pci config space emulation is still handled by
qemu.  On a quick check I don't see anything special done for vhost,
so I expect the same subsystem ID being used.

Maybe we should extend the vhost protocol to allow overriding the
subsystem id, so linux kernel / rust-vmm  / ... can have their own
subsystem ids?

take care,
  Gerd


