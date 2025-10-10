Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DF2CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 12:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Byz-0007Fj-N2; Fri, 10 Oct 2025 08:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v7Byw-0007DJ-91
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v7Byo-0002W7-Vl
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760098328;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvEkDcS6t/0bVaT3tyrJKiNVB+cBYj8UOiEzRtoswOg=;
 b=MehcgFgkDYsg59rOmIntGjwkFXUb/N5C5MyDybYaWLXT4NJW/T6W726dSLSJHx+5974oVa
 zp38NGMyxqCkDV2hzaPO8UGcKOGVy3OynyQBz/VZ85ONH3o078pBdu9r4Q1A2y8xhGarqi
 DvzPUEL6m2O/7JDs8kVwSU4nfUNPld0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-5VAG2eTmOsiAvRIjO7A1Ww-1; Fri,
 10 Oct 2025 08:12:05 -0400
X-MC-Unique: 5VAG2eTmOsiAvRIjO7A1Ww-1
X-Mimecast-MFC-AGG-ID: 5VAG2eTmOsiAvRIjO7A1Ww_1760098322
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F7671956096; Fri, 10 Oct 2025 12:12:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2B1B1953947; Fri, 10 Oct 2025 12:11:59 +0000 (UTC)
Date: Fri, 10 Oct 2025 13:11:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH RFC/WIP 4/4] gitlab: add jobs for thorough block tests
Message-ID: <aOj4BUeUP_PgDLFG@redhat.com>
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-5-berrange@redhat.com>
 <996a6f93-9abd-46a1-9647-296983101f00@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <996a6f93-9abd-46a1-9647-296983101f00@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 10, 2025 at 01:55:28PM +0200, Thomas Huth wrote:
> On 08/10/2025 13.35, Daniel P. Berrangé wrote:
> > CI is only exercising the qcow2 'auto' tests currently. As a result we
> > get no exposure of changes which cause regressions in other block format
> > drivers.
> > 
> > This adds new CI jobs for each block format, that will run the target
> > 'make check-block-$FORMAT'. The jobs are separate so that we have the
> > ability to make each formats gating or not, depending on their level
> > of reliability.
> 
> Some of the jobs seem to be quite quick, though, only 5 minutes and less:
> 
>  https://gitlab.com/berrange/qemu/-/jobs/11633680698
>  https://gitlab.com/berrange/qemu/-/jobs/11633680704
>  https://gitlab.com/berrange/qemu/-/jobs/11633680694
> 
> I think I'd prefer to see them rather merged into one job, to avoid that we
> waste too much time with setting up the container each time. We can still
> sort out flaky parts into separate jobs later if necessary.

The container setup / job prep is not a significant time sink  - just
at the 1 minute mark. I wanted to have separate jobs per backend so
that the pipeline dashboard gives an informative summary of which
block backends are impacted by the change, rather than having to
search the logs to discover it.

Flaky parts shouldn't be separate jobs  - the tests should either be
fixed or removed, because unreliable tests just end up being ignored,
leading to regressions being missed. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


