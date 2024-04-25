Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF801C19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzvtV-0003sx-Tq; Thu, 25 Apr 2024 05:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzvtU-0003sX-T5
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzvtS-0006ME-Qd
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714039192;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nfFr/gVbtQU8O2uQ+mFSZqE8YRVt90FBM6wXyLtb2wA=;
 b=XQDXa+pu8WLDZYoOiDwLAV3D1h3VZdHCqZuyJTDAVXxcoizV+8m+2Nh8bgivdvemyHGhRp
 IYX6yq8ON6apMtL6SA4mUNlx0BRnaWlU6MZLXD+xxBO4+E01jQlqnbv7lmgRJ9KynMF6ZK
 hdezsHytWYliCD+36aFK4GmX9PXFqEc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-TGiYTGd7NOmvVa4CeVEBJQ-1; Thu,
 25 Apr 2024 05:59:50 -0400
X-MC-Unique: TGiYTGd7NOmvVa4CeVEBJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D993B3830089;
 Thu, 25 Apr 2024 09:59:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 491201121306;
 Thu, 25 Apr 2024 09:59:49 +0000 (UTC)
Date: Thu, 25 Apr 2024 10:59:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 01/29] include: move include/qapi/qmp/ to include/qobject/
Message-ID: <Ziopk0fu5vfosVvc@redhat.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
 <20240108182405.1135436-2-berrange@redhat.com>
 <ZZxDDmv1YsqlMMCT@redhat.com> <87edat945l.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87edat945l.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 25, 2024 at 11:34:46AM +0200, Markus Armbruster wrote:
> I just realized I dropped this on the floor.  I apologize for the delay.
> 
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Mon, Jan 08, 2024 at 06:23:37PM +0000, Daniel P. Berrangé wrote:
> >> The general expectation is that header files should follow the same
> >> file/path naming scheme as the corresponding source file. There are
> >> various historical exceptions to this practice in QEMU, with one of
> >> the most notable being the include/qapi/qmp/ directory. Most of the
> >> headers there correspond to source files in qobject/.
> >> 
> >> This patch corrects that inconsistency by creating include/qobject/.
> 
> Yes, there's inconsistency, but is it worth cleaning up?  Since you did
> the work already, and sunk cost doesn't count, ...

The motivation is my own inability to remaember that the qboject/*.c
header files are in include/qapi/qmp/. I only need to find them
every 6-12 months or so, and thus I've always forgotten their wierd
location by that point !

> >> To allow the code to continue to build, symlinks are temporarily
> >> added in $QEMU/qapi/qmp/ to point to the new location. They will
> >> be removed in a later commit.
> 
> Only necessary to let you split the patch updating #include directives.
> The update is entirely mechanical, isn't it?  I doubt splitting is worth
> the trouble then.

Yes, it was to allow succesfully building at each patch.
Changes were basically a sed/perl command IIRC.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


