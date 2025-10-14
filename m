Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECE5CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ak3-0003BP-77; Tue, 14 Oct 2025 04:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8ak1-0003Ay-Gm
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v8ajy-0006vT-MF
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760431840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+e/SeXfU8NTu+t3APwhmKN0eU8LIn7SLAO3Bm8EMZIw=;
 b=TKiCK+SCcOuu6Gkp+f/51p9UWeFQG/xf7eTcCK9TRBj1r/G/IzltJgbLmoM081pNQHpx3Z
 Uc2LWwaf/K1qh9RQQ5KPGs5EpGoqsAqDmWoyYj8XNjU+YD9LFhDh9zLIEjRgzZFyvj6+gO
 CJFz8lQecEk2nTnVmm+Gmiks71tOEDY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-YkI6jBoMOQWY-yqUAAgRiQ-1; Tue,
 14 Oct 2025 04:50:36 -0400
X-MC-Unique: YkI6jBoMOQWY-yqUAAgRiQ-1
X-Mimecast-MFC-AGG-ID: YkI6jBoMOQWY-yqUAAgRiQ_1760431835
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C64121800371; Tue, 14 Oct 2025 08:50:35 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.78])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79FEA300018D; Tue, 14 Oct 2025 08:50:33 +0000 (UTC)
Date: Tue, 14 Oct 2025 10:50:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 3/4] tests: add nbd and luks to the I/O test suites
Message-ID: <aO4O1-Xy43SBSv4T@redhat.com>
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-4-berrange@redhat.com>
 <bc904027-5b58-4057-8ef5-15e4ebcca767@redhat.com>
 <aOZfLYcJZ-6dslcK@redhat.com>
 <omyc6f77hbrpm6mh7bagqjsz7kbyxuuslmx4lvaaximrbmlgu5@joh5vp5obobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <omyc6f77hbrpm6mh7bagqjsz7kbyxuuslmx4lvaaximrbmlgu5@joh5vp5obobo>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 08.10.2025 um 17:55 hat Eric Blake geschrieben:
> > > Also not sure whether we should add "nbd" to the "formats" list - it's a
> > > protocol, and not a format, isn't it?
> > 
> > Yes, technically there are two distinct axis  formats vs protocols, but
> > from the POV of running the 'check' script the boundary is rather blurred.
> > 
> > You can run './check -nbd' and './check -qcow2', or both combined. The main
> > limit that you can only pick a single format and single protocol at a time.
> 
> In fact, I've seen times where './check -nbd -raw' passes but './check
> -nbd -qcow2' fails, because that combination enables different sets of
> tests.  So we probably STILL aren't giving CI everything possible to
> test by having just one dimension of easy-to-name test subsets, but it
> is still better than no CI nbd tests at all.

How valid is -nbd -qcow2 even? Wasn't there the fundamental problem that
NBD devices can't grow?

Running various image formats may be useful for other protocols, but I'm
not sure that NBD is one of them.

> > IMHO for test suites it is preferrable to keep a flat namespace, rather
> > than creating a matrix of suites for protocol vs format combniations.
> > 
> > Perhaps the meson.build variable should just be renamed from _formats
> > to something else.
> 
> Renaming makes sense to me; would _bds be a reasonable name (since
> both protocols and formats are a BDS)?  I'm open to other naming
> ideas, as well.

Well, bdrv if anything (block driver rather than BlockDriverState).

But we also have -fuse, which isn't really a block driver, but it just
means that we're using the file protocol on top of a FUSE export...

Probably not worth renaming from one imperfect name to another imperfect
one.

Kevin


