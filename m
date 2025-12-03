Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60327D12696
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 10:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjvb-0003zE-Fr; Wed, 03 Dec 2025 05:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vQjvZ-0003yj-B7
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:17:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vQjvX-0003it-Fg
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764757054;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=H1hvGvrZPpjO+kLcdZVVecvAO/iytpwWaODr8rbCKIw=;
 b=DKcnRfYrDX4hKal7vq/sYQC2N5/75+7tRRw5iLEU6bYanZPmq4FOAfTShuzkBi+zcbfQA/
 wCBe2yaZjRqcisdrOaXNvT0Ev4DPNRvZ2HLoyvn49L6ETHJW2k9F96X5d8Z7FOCQVOYfqv
 lq8QKF7+tOty7AGlRxBYwdZkugvWkbI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-o_PZuTaCOfaYr_DH6e-snw-1; Wed,
 03 Dec 2025 05:17:30 -0500
X-MC-Unique: o_PZuTaCOfaYr_DH6e-snw-1
X-Mimecast-MFC-AGG-ID: o_PZuTaCOfaYr_DH6e-snw_1764757050
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C46A219560AD; Wed,  3 Dec 2025 10:17:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24FA31800352; Wed,  3 Dec 2025 10:17:25 +0000 (UTC)
Date: Wed, 3 Dec 2025 10:17:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [ANNOUNCE] QEMU 10.2.0-rc1 is now available
Message-ID: <aTAOLP0m8HN_Iw84@redhat.com>
References: <176359557511.1845377.6752982148248088074@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <176359557511.1845377.6752982148248088074@amd.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Nov 19, 2025 at 05:39:35PM -0600, Michael Roth wrote:
> Hello,
> 
> On behalf of the QEMU Team, I'd like to announce the availability of the
> first+second release candidate for the QEMU 10.2 release (there was no
> rc0 published this time around). This release is meant for testing purposes
> and should not be used in a production environment.
> 
>   http://download.qemu.org/qemu-10.2.0-rc1.tar.xz
>   http://download.qemu.org/qemu-10.2.0-rc1.tar.xz.sig
> 
> You can help improve the quality of the QEMU 10.2 release by testing this
> release and reporting bugs using our GitLab issue tracker:
> 
>   https://gitlab.com/qemu-project/qemu/-/milestones/17
> 
> The release plan, as well a documented known issues for release
> candidates, are available at:
> 
>   http://wiki.qemu.org/Planning/10.2

Is our release schedule still accurate ?

rc2 was targetted at Nov 25th, but in git I see rc2 tagged yesterday
which is when rc3 was scheduled for tagging.

Are we going to go for another -rc next Tuesday, or straight from
rc2 to the release ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


