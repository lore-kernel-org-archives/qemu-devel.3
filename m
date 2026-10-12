Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A42CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGCwL-00033z-Mf; Mon, 12 Oct 2026 06:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGCwE-00032w-Em
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGCwC-0002SG-5B
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791799639;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6WtqhaR05DbI1YvXlfeR2V1r2SZD/lOj3QHHrnOA2Y=;
 b=D3z0RM9DBCNKAWvS+OtTzE/gedImARrPdR/2b3FF2G47vxNk3/OYOQO0+DoVTeqOeXUksW
 /AdtfuVvCZ3OsprRjaPQtq5ctNxxPxUH40wxriRPZrBQ5Ngk1Aqn5VqS4unkxHDqxHJgv6
 3EzdbBY+r1dvtVuYwWdzCQVhDw0IC2A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86--6fYG09zMlCRCJbkSpZjsQ-1; Mon,
 12 Oct 2026 10:07:17 +0000
X-MC-Unique: -6fYG09zMlCRCJbkSpZjsQ-1
X-Mimecast-MFC-AGG-ID: -6fYG09zMlCRCJbkSpZjsQ_1791799636
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D140119541A0; Mon, 12 Oct 2026 10:07:15 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3BE81800446; Mon, 12 Oct 2026 10:07:14 +0000 (UTC)
Date: Mon, 12 Oct 2026 11:07:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, QEMU Stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 0/4] Misc fixes patches
Message-ID: <asyxT1fCTbjDEfOD@redhat.com>
References: <20261006083451.956881-1-berrange@redhat.com>
 <113ff524-4789-43a7-8d2f-bde474f3a413@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <113ff524-4789-43a7-8d2f-bde474f3a413@tls.msk.ru>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Oct 10, 2026 at 10:29:34AM +0300, Michael Tokarev wrote:
> On 06.10.2026 11:34, Daniel P. Berrangé wrote:
> > The following changes since commit d7a65d1793d691d356a56833620f7d1e6f5d653b:
> > 
> >    Merge tag 'hppa-a400-updates-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-10-03 14:17:49 +0200)
> > 
> > are available in the Git repository at:
> > 
> >    https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
> > 
> > for you to fetch changes up to f33fb19cab412ffbc19e3b7914a320ae1d73709c:
> > 
> >    seccomp: fix blocking of setns/execveat/unshare (2026-10-06 09:17:43 +0100)
> > 
> > ----------------------------------------------------------------
> > Merge USB, I/O and seccomp fixes
> > 
> > * Fix seccomp to use errno action for setns/execveat/unshare
> >    instead of killing the thread
> > * Improve TLS performance and avoid test suite timeouts by
> >    corking TLS writes to increase packet size
> > * Fix websocket server unbounded read of client data
> >    CVE-2026-101291
> > * Avoid use-after-free in MTP device during object delete
> > 
> > ----------------------------------------------------------------
> > 
> > Daniel P. Berrangé (3):
> >    io: prevent unbounded read of websocket data from client
> >    io: cork TLS writes to avoid small TLS records
> >    seccomp: fix blocking of setns/execveat/unshare
> > 
> > Tommaso Califano (1):
> >    hw/usb: Fix USB MTP Use-After-Free in usb_mtp_deletefn List Iteration
> 
> I'm picking the 3 out of 4 changes here for qemu-stable - omitting
> the "cork" one.  Please let me know if I should not.

NB, the seccomp patch is broken. Please don't release it on stable
without a followup fix arriving shortly...


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


