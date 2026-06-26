Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6155DCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3SI-0001rZ-0w; Fri, 26 Jun 2026 06:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wd3S3-0001jn-VE
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wd3S2-0002O2-6D
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782468380;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Avt2j9OQeXog2CA7bB/N0uPf7j65xGeB3rqeJIWcDFU=;
 b=dUcKMochPNrmuWPv2sjOzeyNDfc/ZGq1yA9qUQOM6wLP4P1IS+vDVBIJAI2owqriYKTAEB
 yBYwqfYA5FAoWuRjJdGdU/SL5f2CwXCLqOirL6VGH2sM4N8BDdVcTA74qXK76ChxFrr16L
 q4/s9ps1VZF06GTitwlkeqQ8ta7Nh5s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-fH82hHUgPHKR32GvCsddqQ-1; Fri,
 26 Jun 2026 06:06:16 -0400
X-MC-Unique: fH82hHUgPHKR32GvCsddqQ-1
X-Mimecast-MFC-AGG-ID: fH82hHUgPHKR32GvCsddqQ_1782468375
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3754819560AA; Fri, 26 Jun 2026 10:06:15 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 619F13000203; Fri, 26 Jun 2026 10:06:13 +0000 (UTC)
Date: Fri, 26 Jun 2026 11:06:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 2/2] get_maintainer: add ability to report Git Lab
 handle
Message-ID: <aj5PEZkz-V6BEnmQ@redhat.com>
References: <20260624122936.2706393-1-berrange@redhat.com>
 <20260624122936.2706393-3-berrange@redhat.com>
 <87ik78krjq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ik78krjq.fsf@draig.linaro.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 24, 2026 at 02:15:53PM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > With the GitLab mapping files from the previous commit, the
> > get_manitainer.pl script is now able to report the gitlab
> > handle for each maintainer/reviewer when displaying output.
> >
> > For example:
> >
> >   $ ./scripts/get_maintainer.pl -f hw/scsi/lsi53c895a.c
> >   Paolo Bonzini <pbonzini@redhat.com> (supporter:SCSI, gitlab:@bonzini)
> >   Fam Zheng <fam@euphon.net> (reviewer:SCSI, gitlab:@famzheng)
> >   qemu-devel@nongnu.org (open list:All patches CC here)
> 
> I suspect it gets tripped up by utf-8 stuff:
> 
>   ➜  ./scripts/get_maintainer.pl -f contrib/gitdm/aliases 
>   "Alex Bennée" <alex.bennee@linaro.org> (odd fixer:GIT Data Mining C...)
>   qemu-devel@nongnu.org (open list:All patches CC here)
> 
> misses my tag.

The problem turned out to be that we failed to strip the double quotes
from the name before doing a lookup.

> 
> However I think this approach is much cleaner. The other option would be
> embedding @refs in the M: line:
> 
>   M: Alex Bennée <alex.bennee@linaro.org> @stsquad

My previous version did

  G: @stsquad

but it results in considerable duplication and made automated updates
harder. So based on Philippe's suggestion I split it into the map
files.

> 
> and letting the script handle it. But I didn't want to hack on
> get_maintainer.pl which is why I started playing with a python version.
> However I need to add some features to it to reach usable parity with
> the perl script.



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


