Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423A8C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 12:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKG5A-0000Ae-EQ; Wed, 28 May 2025 08:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKG52-0008UJ-B8
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKG4w-0007ci-Ff
 for qemu-devel@nongnu.org; Wed, 28 May 2025 08:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748436014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HVKa90uanqAVkDdacyqXOzLnAkw27XkOhxLqmIjY+H4=;
 b=asyKSXqEhNhj2TFyM+oOmCfRdHxv2jGVarr+zxLdeiRo0OfT1425qnxTJAAcEcSwmkhoKG
 n0F1Xtg3s/c2iO/cI92+KintNb6M7YL8vUveNkfET3LE9UTeZQQItCs5XF34qJ9ruDGxTb
 oIQakNm4S6PBRYzlPbb3d82KxF9VxbQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-yskPjEfTPWW10nsdWp7Aiw-1; Wed,
 28 May 2025 08:40:11 -0400
X-MC-Unique: yskPjEfTPWW10nsdWp7Aiw-1
X-Mimecast-MFC-AGG-ID: yskPjEfTPWW10nsdWp7Aiw_1748436010
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38C041800368; Wed, 28 May 2025 12:40:10 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7903719560B3; Wed, 28 May 2025 12:40:07 +0000 (UTC)
Date: Wed, 28 May 2025 07:40:04 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PULL 13/14] tests: Add iotest mirror-sparse for recent patches
Message-ID: <4s2evawxpxqfsub7gxqv6kv5pmfd7khxsna4bz7ai72oqpiadu@yvnvovvipauh>
References: <20250515022904.575509-16-eblake@redhat.com>
 <20250515022904.575509-29-eblake@redhat.com>
 <874ix5ezgy.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ix5ezgy.fsf@pond.sub.org>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 28, 2025 at 01:39:25PM +0200, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > Prove that blockdev-mirror can now result in sparse raw destination
> > files, regardless of whether the source is raw or qcow2.  By making
> > this a separate test, it was possible to test effects of individual
> > patches for the various pieces that all have to work together for a
> > sparse mirror to be successful.
> >
> > Note that ./check -file produces different job lengths than ./check
> > -qcow2 (the test uses a filter to normalize); that's because when
> > deciding how much of the image to be mirrored, the code looks at how
> > much of the source image was allocated (for qcow2, this is only the
> > written clusters; for raw, it is the entire file).  But the important
> > part is that the destination file ends up smaller than 3M, rather than
> > the 20M it used to be before this patch series.
> >
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > Message-ID: <20250509204341.3553601-28-eblake@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Fails for me:
> 

>     @@ -184,7 +184,7 @@
>      {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
>      {"return": {}}
>      Images are identical.
>     -Destination is sparse; expected sparse
>     +Destination is unknown; expected sparse

Looks like the same failure Fiona reported; does this fix it?

https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg05567.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


