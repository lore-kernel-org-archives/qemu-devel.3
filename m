Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C754ECA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 19:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utWmM-0000jr-3t; Tue, 02 Sep 2025 15:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1utWmJ-0000j4-MX
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 15:34:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1utWmI-0006hb-5W
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 15:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756841689;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aMr7FBrtDcvEjR7ORb04MKoAOn2Cfp6uXvsNBLNFU4k=;
 b=BED3LH6uIc8mBDTbuM8wpdcW7xG0qMvslPdbkzbDtDHiSKTN1opJidRDBVgXzfcUcgLt91
 iFk5hVl9Ue3Pr5Lk0bbpm2tPqP6R7H8/clJa1QOFAEXMr8RGhp+poLtnI3ZVDsba+1bjOw
 YZaIsSWFZLBRPcR3eQKkr7STQRAqwH8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-rDKOabo5NXa558D4o3drIA-1; Tue,
 02 Sep 2025 15:34:46 -0400
X-MC-Unique: rDKOabo5NXa558D4o3drIA-1
X-Mimecast-MFC-AGG-ID: rDKOabo5NXa558D4o3drIA_1756841685
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21FF41800561; Tue,  2 Sep 2025 19:34:45 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.48])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 550F21956086; Tue,  2 Sep 2025 19:34:42 +0000 (UTC)
Date: Tue, 2 Sep 2025 21:34:38 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 00/19] python: 3.14 compatibility and python-qemu-qmp
 synchronization
Message-ID: <aLdGgmFMs76A_wJi@redhat.com>
References: <20250901202702.2971212-1-jsnow@redhat.com>
 <aLchMLLyGb0GAZHJ@redhat.com>
 <CAFn=p-bq42-CGHfNe=WENHQFTsCbD0iKNywYYqXkAM_Aq_aamA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-bq42-CGHfNe=WENHQFTsCbD0iKNywYYqXkAM_Aq_aamA@mail.gmail.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 02, 2025 at 12:58:24PM -0400, John Snow wrote:
> On Tue, Sep 2, 2025, 12:54 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Mon, Sep 01, 2025 at 04:26:42PM -0400, John Snow wrote:
> > > RFC: Should I squash the last two backport patches? One technically
> > > introduces a regression which breaks our "no regressions in series"
> > > rule, but makes the per-patch relationship murkier. Please let me know.
> >
> > What is the effect of the regression ?
> >
> > If someone is running 'make check' (or a variant thereof), through
> > a "git bisect" will this regression be significant enough to break
> > their git bisect ?
> >
> 
> It could, yes. To avoid it I need to squash the latest get_event_loop
> change in to the second-to-last one.
> 
> I guess I'll just notate that it's cherry-picked from two commits and
> include both commit messages.
> 
> Does that sound OK? (I've never really "cherry picked" across repositories
> like this where the file paths do not actually match, so it's been a bit of
> a manual affair.)

Yeah, just noting that its a combo of two commits sounds good to me.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


