Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A34C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAD3b-0001VA-FV; Fri, 25 Sep 2026 17:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xAD3X-0001Qw-LV
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xAD3V-0003OG-Gc
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790370122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bXKrjfxVJgIHax1bEi5L+8ykoETCsCSzkhRL9Eg5Rb4=;
 b=LpCUJQQasI+qNwx7vIzRlj/+Tk5Ym6X2AoNi+JAKsVBz/7EXZqVPucwqQvTa6epakE66Ol
 pxkCcjzIHH1vX7ve1v5ZQOanr788zh6lu1lfa5WIRW9O0ORJBbc1wacaFfWJ+2NCdVGtgB
 0GN8xvdO435AdkOO0jFzKTcIW0bKgew=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-rvXCTUweMlaSFkaynmFh9g-1; Fri,
 25 Sep 2026 17:02:01 -0400
X-MC-Unique: rvXCTUweMlaSFkaynmFh9g-1
X-Mimecast-MFC-AGG-ID: rvXCTUweMlaSFkaynmFh9g_1790370120
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5542197702B; Fri, 25 Sep 2026 21:01:59 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0241318002B1; Fri, 25 Sep 2026 21:01:57 +0000 (UTC)
Date: Fri, 25 Sep 2026 16:01:55 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] iotests/nbd-in-qcow2-chain: use default machine
Message-ID: <arbg_YqXp3hi49WK@redhat.com>
References: <20260813183740.3503107-1-farman@linux.ibm.com>
 <20260813183740.3503107-2-farman@linux.ibm.com>
 <arUf7gFJkCuVH0VI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arUf7gFJkCuVH0VI@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Thu, Sep 24, 2026 at 03:04:46PM +0200, Kevin Wolf wrote:
> Am 13.08.2026 um 20:37 hat Eric Farman geschrieben:
> > Some of the NBD tests explicitly specify `-machine q35` which won't work
> > when running against, say, qemu-system-s390x.
> > 
> > The nbd-in-qcow2-chain test runs fine with the default machine on a z16
> > host, so allow it to run in other configurations.
> > 
> > Fixes: 24fd6d75b3 ("iotests: Add coverage of recent NBD qio deadlock fix")
> > Signed-off-by: Eric Farman <farman@linux.ibm.com>
> > ---

> >  
> > -_launch_qemu -machine q35
> > +_launch_qemu
> >  h1=$QEMU_HANDLE
> >  _send_qemu_cmd $QEMU_HANDLE '{"execute": "qmp_capabilities"}' 'return'
> >  _send_qemu_cmd $QEMU_HANDLE '{"execute": "blockdev-add",
> 
> I don't see what the machine type is needed for, so this is probably
> fine.
> 
> Eric (Blake), any specific reason you added the machine type in this
> test case so that removing it might cause a regression?

This would have been copy-and-paste from some other test, and not
something specific to this one.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


