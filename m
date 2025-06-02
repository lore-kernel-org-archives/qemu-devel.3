Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2F0C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 11:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM39h-0002BI-QK; Mon, 02 Jun 2025 07:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uM39e-00029n-5r
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 07:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uM39b-0004Kq-Mt
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 07:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748862989;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=t0dVP5svMA6TsluCrrln94q2lW3aZa57u4V4pO+s5KE=;
 b=fQyVlb9uVL3Lgp/qHpWxka1ipU7xenrhDkO5pF++NXPBg2fsL6ai1+gNNfp8ohueFtoD6l
 7Fn5YfhMbP3KH/uyKTPpqFc4JLWYmyp2dFtxRM25bRFf+oTnkUHHT1Bhv6Ww5sRScrFBoX
 r0wkHKfFOjaRmi5H4KyjUoN+MxxrusQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-NLUSnNC0OMC2QrsxQAvFDw-1; Mon,
 02 Jun 2025 07:16:27 -0400
X-MC-Unique: NLUSnNC0OMC2QrsxQAvFDw-1
X-Mimecast-MFC-AGG-ID: NLUSnNC0OMC2QrsxQAvFDw_1748862986
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E5D1180045B; Mon,  2 Jun 2025 11:16:26 +0000 (UTC)
Received: from redhat.com (dhcp-17-109.lcy.redhat.com [10.42.17.109])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09F8930002C4; Mon,  2 Jun 2025 11:16:24 +0000 (UTC)
Date: Mon, 2 Jun 2025 12:16:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/1] docs/qapi-domain: Improve QAPI indices
Message-ID: <aD2IBR5FTFCSrV8x@redhat.com>
References: <20250523180809.41211-1-jsnow@redhat.com>
 <20250523180809.41211-2-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250523180809.41211-2-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, May 23, 2025 at 02:08:09PM -0400, John Snow wrote:
> This patch changes the "by type" categorization in favor of using
> sub-categories of a literal "By type" category instead. A new "By
> module" categorization is also added that follows a similar pattern.

I'm not much of a fan of this. IMHO unless you are looking at the
module(s) for the subsystem you are the maintainer of, the split
of definitions across modules comes across as somewhat arbitrary
and unpredictable.

Looking at this from the POV of a consumer of QMP, our entrypoint
to research is either a command name or an event name.

The data type names of enums/alternates/objects are an internal
QEMU detail that's not part of the public API.

If we consider the index currently:

  Alternates | Commands | Enums | Events | Modules | Objects | A | .... | Z

The A ... Z bits link to a mix of all type names, which is a bit
overwhealming.

At the same time the page is twice as big as it needs to be
as the same info is repeated under the A-Z index and the
other per-type indexes.

I think what would help would be to make the index dynamic

eg

  A | B | C | D | E | ... | X | Y | Z

  [ ] Show internal types 

The A-Z index would default to showing commands and events.
Selecting the "Types" checkbox would toggle display of the
alternate/enum/object names, which could be done via having
a CSS class on each index entry, and javascript which just
toggles 'display: none' / 'display: block' CSS property on
the elements with the given class. I'm not convinced we need
the modules in the index.


> Alphabetical sorting has been improved and will sort in a case
> insensitive manner for all categories, now.

This is trivial and nice and could be a standalone fix ?

> Lastly, the "main" QAPI Index (qapi-index.html) is altered to index
> *everything* from all namespaces, adding disambiguation where necessary
> to do so.

This looks a bit wierd having the same types and modules repeated
multiple times.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


