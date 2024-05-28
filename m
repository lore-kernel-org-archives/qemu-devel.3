Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FC4C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByaY-0006Bs-FY; Tue, 28 May 2024 11:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sByaV-0006AV-T9
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:18:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sByaQ-0001OH-9t
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716909480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EdT2d+RRjtzKt0J6GRKfnsJpys3bFNVVWzGeKhOF5/k=;
 b=hDI3/qgvz7a1yBzuXbXre9a4LibohJwv09RDjJM2uYA30ZGqnK2hOnapg9fU5U0J6sLyx8
 KCMM2VgDQ3RGfPhTLYMDbBlZNo5cjPPiKjvriiQbLUUHebtqgpNaYHlNPpCioK370+hV8S
 42OFKRvRisyij5qkA8jQIx7ah1PBORY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-xeLmQaImPwmaCQk2_W-kQw-1; Tue, 28 May 2024 11:17:57 -0400
X-MC-Unique: xeLmQaImPwmaCQk2_W-kQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0C3F800169;
 Tue, 28 May 2024 15:17:56 +0000 (UTC)
Received: from redhat.com (unknown [10.39.195.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2BD810004F6;
 Tue, 28 May 2024 15:17:55 +0000 (UTC)
Date: Tue, 28 May 2024 17:17:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 jsnow@redhat.com, f.ebner@proxmox.com
Subject: Re: [PATCH] iotests/pylintrc: allow up to 10 similar lines
Message-ID: <ZlX1ovj3v5YsL7Al@redhat.com>
References: <20240430091329.2365053-1-vsementsov@yandex-team.ru>
 <10070ee3-2ef7-45e6-bd27-5ac74559f192@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10070ee3-2ef7-45e6-bd27-5ac74559f192@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 28.05.2024 um 14:49 hat Vladimir Sementsov-Ogievskiy geschrieben:
> On 30.04.24 12:13, Vladimir Sementsov-Ogievskiy wrote:
> > We want to have similar QMP objects in different tests. Reworking these
> > objects to make common parts by calling some helper functions doesn't
> > seem good. It's a lot more comfortable to see the whole QAPI request in
> > one place.
> > 
> > So, let's increase the limit, to unblock further commit
> > "iotests: add backup-discard-source"
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > ---
> > 
> > Hi all! That's a patch to unblock my PR
> > "[PULL 0/6] Block jobs patches for 2024-04-29"
> >    <20240429115157.2260885-1-vsementsov@yandex-team.ru>
> >    https://patchew.org/QEMU/20240429115157.2260885-1-vsementsov@yandex-team.ru/
> > 
> > 
> >   tests/qemu-iotests/pylintrc | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
> > index de2e0c2781..05b75ee59b 100644
> > --- a/tests/qemu-iotests/pylintrc
> > +++ b/tests/qemu-iotests/pylintrc
> > @@ -55,4 +55,4 @@ max-line-length=79
> >   [SIMILARITIES]
> > -min-similarity-lines=6
> > +min-similarity-lines=10
> 
> 
> Hi! I hope it's OK, if I just apply this to my block branch, and
> resend "[PULL 0/6] Block jobs patches for 2024-04-29" which is blocked
> on this problem.

Sorry, I only just returned from PTO and now have to catch up with
things.

But yes, if John doesn't have any objections, it's fine with me, too.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


