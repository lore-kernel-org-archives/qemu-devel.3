Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01FDC282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 13:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp5af-0003sk-Mb; Mon, 03 Mar 2025 08:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tp5ac-0003qH-90
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:12:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tp5aa-0005Kh-6F
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741007526;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=saaddfjOY3lK0BanYsWLPr3Qhd81xRS3eyqxUDyWk28=;
 b=X3Ikn3zkC9Kvls+8ZcuikZDtXkUzyQ4rWBjIqS2X36zWRvV5s8jZHf65bYTriO2asequj5
 Z4ZekmK6G1oKOMOGmQqXuNX3OrPCO85EvOTenhhLTlcGkdNuCLG7Jtr9yoSO+yOA7K2Px+
 YWVtokYIRaGsyIgJpywBNrSIaaKtTFE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-fpDDgINlMKa1IyRLo3H1zA-1; Mon,
 03 Mar 2025 08:11:47 -0500
X-MC-Unique: fpDDgINlMKa1IyRLo3H1zA-1
X-Mimecast-MFC-AGG-ID: fpDDgINlMKa1IyRLo3H1zA_1741007506
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 951AE19540ED; Mon,  3 Mar 2025 13:11:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54C2F1800352; Mon,  3 Mar 2025 13:11:43 +0000 (UTC)
Date: Mon, 3 Mar 2025 13:11:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Camilla Conte <cconte@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Kubernetes gitlab-runner jobs cannot be scheduled
Message-ID: <Z8Wqi3PtQHjQYr-G@redhat.com>
References: <CAJSP0QUk77GViTBgBpfYH-AbAmQ5aUwi0K6UTH9iv=1mVb0Wbw@mail.gmail.com>
 <803732f6-6ab1-4298-a956-660496664f67@redhat.com>
 <CAJSP0QUN_tCSZ=WOk+C9kR3TMqkTaZMNF7qaAsFPiauzN0r_QA@mail.gmail.com>
 <CABgObfYJTPu=sTK5UG2d28tTYrACRaiqU6Wzh_0NhwdnQmg74A@mail.gmail.com>
 <CAJSP0QUt6YK7PCZ92hmNaVfL+nSSNsQg3KKcpP79SCNJtvfajA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QUt6YK7PCZ92hmNaVfL+nSSNsQg3KKcpP79SCNJtvfajA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Mar 03, 2025 at 07:01:16PM +0800, Stefan Hajnoczi wrote:
> On Mon, Mar 3, 2025 at 5:26 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On Mon, Mar 3, 2025 at 8:35 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > GitLab says:
> > > "There has been a timeout failure or the job got stuck. Check your
> > > timeout limits or try again"
> > >
> > > Duration: 77 minutes 13 seconds
> > > Timeout: 1h (from project)
> > >
> > > It ran 17 minutes longer than the job timeout.
> >
> > The job only seems to have run for roughly 15-20 minutes.
> >
> > I am not sure what's going on, but I have opened a ticket with DO to
> > request both larger droplets (16 vCPU / 32 GB) and a higher limit (25
> > droplets). This matches roughly what was available on Azure.
> >
> > Let me know if you prefer to go back to Azure for the time being.
> 
> Yes, please. I'm unable to merge pull requests (with a clear
> conscience at least) because running CI to completion is taking so
> long with many manual retries needed.
> 
> Perhaps the timeouts will go away once the droplet size is increased.
> It makes sense that running the jobs on different hardware might
> require readjusting timeouts.

It is a bit surprising to see timeouts, as we've fine tuned our test
timeouts to cope with GitLab's default shared runners, which is what
contributors use when CI runs in  a fork. These runners only have
2 VCPUs and 8 GB of RAM, so that's a pretty low resource baseline

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


