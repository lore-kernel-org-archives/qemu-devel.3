Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D93ECCD190
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lUe-0002QF-O7; Tue, 14 Oct 2025 16:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v8lUc-0002OW-TM
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v8lUV-00070m-Jt
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760473161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwJRbyF541s3ZvPDtBiOOAzxeGvew/YtlPwpibl3Cks=;
 b=Gw3QCUXSNLkF+JxpiQSFw7xVjERVA6nZIa/WdQrdOSgj2OzfWZzVDWvw5AVJHx4mhGDeYc
 vMqNAIdlejpc2hNuTpPE5oZM4MmmFQIkrcKmcxLP1vo+19m2nO6DvfH/2nMJ/xT8zgjX8D
 spHjWbzlN+ryxC88EQbmQMQJBQidqhc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-eVxvhXSkP1WEqkllVnIxlQ-1; Tue,
 14 Oct 2025 16:19:18 -0400
X-MC-Unique: eVxvhXSkP1WEqkllVnIxlQ-1
X-Mimecast-MFC-AGG-ID: eVxvhXSkP1WEqkllVnIxlQ_1760473157
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C94AA1956087; Tue, 14 Oct 2025 20:19:16 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DE9919560B4; Tue, 14 Oct 2025 20:19:14 +0000 (UTC)
Date: Tue, 14 Oct 2025 15:19:11 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 3/4] tests: add nbd and luks to the I/O test suites
Message-ID: <scnzlflaj7b63ga5unuwsa4k7oggxdsrp2f4rsn6iugtzohrmh@6heveswvvijb>
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-4-berrange@redhat.com>
 <bc904027-5b58-4057-8ef5-15e4ebcca767@redhat.com>
 <aOZfLYcJZ-6dslcK@redhat.com>
 <omyc6f77hbrpm6mh7bagqjsz7kbyxuuslmx4lvaaximrbmlgu5@joh5vp5obobo>
 <aO4O1-Xy43SBSv4T@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO4O1-Xy43SBSv4T@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Oct 14, 2025 at 10:50:31AM +0200, Kevin Wolf wrote:
> Am 08.10.2025 um 17:55 hat Eric Blake geschrieben:
> > > > Also not sure whether we should add "nbd" to the "formats" list - it's a
> > > > protocol, and not a format, isn't it?
> > > 
> > > Yes, technically there are two distinct axis  formats vs protocols, but
> > > from the POV of running the 'check' script the boundary is rather blurred.
> > > 
> > > You can run './check -nbd' and './check -qcow2', or both combined. The main
> > > limit that you can only pick a single format and single protocol at a time.
> > 
> > In fact, I've seen times where './check -nbd -raw' passes but './check
> > -nbd -qcow2' fails, because that combination enables different sets of
> > tests.  So we probably STILL aren't giving CI everything possible to
> > test by having just one dimension of easy-to-name test subsets, but it
> > is still better than no CI nbd tests at all.
> 
> How valid is -nbd -qcow2 even? Wasn't there the fundamental problem that
> NBD devices can't grow?

There are some tests that run differently under '-nbd -qcow2' than
under '-nbd -file'; but you are also correct that any qcow2 test that
relies on image resizing can't work with nbd.

> 
> Running various image formats may be useful for other protocols, but I'm
> not sure that NBD is one of them.
> 
> > > IMHO for test suites it is preferrable to keep a flat namespace, rather
> > > than creating a matrix of suites for protocol vs format combniations.
> > > 
> > > Perhaps the meson.build variable should just be renamed from _formats
> > > to something else.
> > 
> > Renaming makes sense to me; would _bds be a reasonable name (since
> > both protocols and formats are a BDS)?  I'm open to other naming
> > ideas, as well.
> 
> Well, bdrv if anything (block driver rather than BlockDriverState).

Yeah, that does sound better...

> 
> But we also have -fuse, which isn't really a block driver, but it just
> means that we're using the file protocol on top of a FUSE export...
> 
> Probably not worth renaming from one imperfect name to another imperfect
> one.

...but I'm not opposed to inertia sticking to a slightly inaccurate
name over the pain of churn just to change the name.  It's not
something that Coccinelle can automate.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


