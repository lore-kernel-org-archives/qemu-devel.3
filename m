Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D21606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hUUa+O2A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOOY-0001vl-K5; Thu, 29 Oct 2026 07:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1xMOOW-0001vL-6C
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1xMOOT-0003v2-CX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793273643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f0U6Kxi5pkE+4yjxpkB80G2MMWROtkeuNdwGqYPbfBw=;
 b=hUUa+O2A8nW9ZRjreVlhE1gavs6MvXCbAkPgdewSkEdDD7XPERaO7x4lreXgxroEY9IwNq
 DqHvN5VobN5tAZ9WJsqfF2kssBpK+ONMkbhCPbbpDr8R1rXoKE4h4n5FB7SFofnmHMQ5zy
 n5pdGSb7zp3zKpkQ6FWQAhB/NvRBZsE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-c8G9GhIqNtOAC6rZyzeVHQ-1; Thu,
 29 Oct 2026 07:33:59 -0400
X-MC-Unique: c8G9GhIqNtOAC6rZyzeVHQ-1
X-Mimecast-MFC-AGG-ID: c8G9GhIqNtOAC6rZyzeVHQ_1793273638
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11005195605C; Thu, 29 Oct 2026 11:33:58 +0000 (UTC)
Received: from nucbdw.ghoffman.csb.home.kraxel.org
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 096B31955E7D; Thu, 29 Oct 2026 11:33:57 +0000 (UTC)
Received: by nucbdw.ghoffman.csb.home.kraxel.org (Postfix, from userid 11758)
 id CA8EB405E540; Thu, 29 Oct 2026 12:33:54 +0100 (CET)
Date: Thu, 29 Oct 2026 12:33:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Junjie Cao <junjie.cao@linux.dev>
Cc: jamin_lin@aspeedtech.com, marcandre.lureau@redhat.com, clg@kaod.org, 
 peter.maydell@linaro.org, kane_chen@aspeedtech.com, troy_lee@aspeedtech.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, junjie.cao@intel.com
Subject: Re: [PATCH v7 1/8] hw/usb/bus: Let the controller ask for the
 automatic hub
Message-ID: <auMtC1vX9nRw1YIn@nucbdw.ghoffman.csb.home.kraxel.org>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
 <20261028034140.367393-2-jamin_lin@aspeedtech.com>
 <20261029100942.894066-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029100942.894066-1-junjie.cao@linux.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ghoffman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 05:09:40AM -0500, Junjie Cao wrote:
> Hi Jamin,
> 
> On Wed, Oct 28, 2026 at 03:41:42AM +0000, Jamin Lin wrote:
> > xHCI has up to 15 root ports, so it no longer grows a hub on its own. A
> > user who wants more ports there adds "-device usb-hub".
> 
> qemu-xhci still defaults to 4 ports. With -M pc-q35-11.1, qemu-xhci and
> five HID devices, a build without the series puts a hub on port 4 with
> the last two behind it. On v7 the fifth device fails with "no free
> ports".

Which is a bad idea to begin with.  Just configure xhci to have
more ports if 4 is not enough.

> Migration from an older QEMU breaks too.

That is a problem though.

> So for the xhci and ehci patches in v8 the flag needs to be a
> property that hw_compat_11_1 keeps on for older machine types.

Indeed, auto-hub must be a property so we can have different machine
types different defaults (and then only turn it off for new ones).

So, if we need a property anyway, I guess it is better to have all
usb host adapters behave the same and flip auto-hub to default off
for new machines types.  It's easy enough to turn it back on via
qemu command line if needed.

take care,
  Gerd


