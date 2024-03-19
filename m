Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432F2C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 12:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmYGX-0005ej-SG; Tue, 19 Mar 2024 08:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmYGW-0005eU-7h
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 08:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmYGU-0002iH-Cv
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 08:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710850100;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=I+seqP7htWcr7P+3ch2Tud5/YY/oMtH8XCR5vYBJSlQ=;
 b=heRElnmvGOhhUTxFfA7BKhbI7eSr7eYefPW2ju6Dk/5qXF7/iiLAo5hScrJm/Jn02jsWZN
 NOY74/wUUANVdRaOgmrAW8XkZAgVLJWeGFjlfQcLntZWQBJgo6h8CN/ZxDV+ONB8oIedEN
 awy2z7seckie5QO2fRL1OQ95Yn4fBDM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-qKueccycNBChTiml85oL2g-1; Tue, 19 Mar 2024 08:08:17 -0400
X-MC-Unique: qKueccycNBChTiml85oL2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3C02101A526;
 Tue, 19 Mar 2024 12:08:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D7F03C54;
 Tue, 19 Mar 2024 12:08:14 +0000 (UTC)
Date: Tue, 19 Mar 2024 12:07:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Maxim Cournoyer <maxim.cournoyer@gmail.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] build: Re-introduce an 'info' target to build a Texinfo
 manual.
Message-ID: <ZfmAHbtfJNn-mrEN@redhat.com>
References: <20240318030437.17503-1-maxim.cournoyer@gmail.com>
 <CAFEAcA9FefR6a48ZO5SgvjOGGYT3t4hxt9OqsybV2e-15HNzTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9FefR6a48ZO5SgvjOGGYT3t4hxt9OqsybV2e-15HNzTQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On Tue, Mar 19, 2024 at 11:47:59AM +0000, Peter Maydell wrote:
> On Mon, 18 Mar 2024 at 03:05, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:
> >
> > This reinstates
> > <https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg09228.html>,
> > which was committed at some point but reverted many years later in
> > cleanups that followed the migration from Texinfo sources to the
> > ReStructuredText (RST) format.  It's still nice to leave the option for
> > users to easily generate a QEMU manual in the Texinfo format, taking
> > advantage of the Sphinx texinfo backend.
> 
> As far as I can tell, we never committed that patch, because
> (as noted in the discussion there) we don't particularly want
> to generate texinfo output (and also because it was missing a
> signed-off-by line). So this isn't a regression: we've never
> generated info docs since we switched away from texinfo to
> rst as our source format.
> 
> I don't think my position personally has changed on this one
> since your previous patch submission. Other QEMU developers
> are welcome to weigh in and disagree with me.

I tend to agree with your point in that thread above. It is already
a big enough burden for maintainers to ensure that the HTML output
for their docs is rendered effectively. Adding an 'info' docs output
increases that burden for negligible benefit. HTML is the most
broadly consumable docs format, so it makes sense to focus our effort
on that.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


