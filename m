Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986CACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 15:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6WVl-00078i-3L; Wed, 08 Oct 2025 11:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v6WVk-00078W-4T
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v6WVd-00014U-Ow
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759938914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqGom5y9uuz3+2sfT2Uq0Smg3hrepJgwTDf0Gx5W3/k=;
 b=gT22ixDfs54QxXSken89J80w//IFo6PociZimg1VEYmbZHav572Y1pJ+DEtjATsloAip28
 /NYkjdjJvRq+uxz1XTuRXhHM1RMnrdPmgmWPSMNHrO1gG5Ci3flUOwCHznI7/TNpeyA/RL
 dHMAP9zHINnN4HmyqDdU7OMzQYnltWQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-DqOzhISKOjKGVWN92xhyqg-1; Wed,
 08 Oct 2025 11:55:11 -0400
X-MC-Unique: DqOzhISKOjKGVWN92xhyqg-1
X-Mimecast-MFC-AGG-ID: DqOzhISKOjKGVWN92xhyqg_1759938910
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E75D61800291; Wed,  8 Oct 2025 15:55:09 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B97530001BD; Wed,  8 Oct 2025 15:55:07 +0000 (UTC)
Date: Wed, 8 Oct 2025 10:55:04 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 3/4] tests: add nbd and luks to the I/O test suites
Message-ID: <omyc6f77hbrpm6mh7bagqjsz7kbyxuuslmx4lvaaximrbmlgu5@joh5vp5obobo>
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-4-berrange@redhat.com>
 <bc904027-5b58-4057-8ef5-15e4ebcca767@redhat.com>
 <aOZfLYcJZ-6dslcK@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOZfLYcJZ-6dslcK@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 08, 2025 at 01:55:09PM +0100, Daniel P. Berrangé wrote:
> > Before we do that, I'd first see a solution for the problem that I described
> > in my series here:
> > 
> > https://lore.kernel.org/qemu-devel/20250910153727.226217-1-thuth@redhat.com/
> > 
> > which, by the way, contains a patch that is very similar to yours here.
> 
> IIUC, the problem you're concerned with is that 'make check SPEED=thorough'
> is running too much, and you want to stop running skipped tests directly.

Or at least reduce the output (easier to focus on the success/failures
if less effort is spent on telling us about skips).

> 
> My view is that running "make check SPEED=thorough" is undesirable in
> general, even before either of our patch series. I'd say it is almost
> never what people actually want to use, and is only picked because of
> the lack of a better option. That's why I thought 'make check-block-qed'
> (and equiva for other formats) was a better option, as it gives a make
> target that matches a specific testing use case. With that in mind, IMHO
> it is less important if 'make check SPEED=thorough' waste a bit of time
> launched irrelevant tests.

The two ideas (adding more test targets, reducing output on skipped
tests) seem orthogonal and independently useful, but it does create
the question on how to resolve the conflicts on what lands first ;)

> 
> > Also not sure whether we should add "nbd" to the "formats" list - it's a
> > protocol, and not a format, isn't it?
> 
> Yes, technically there are two distinct axis  formats vs protocols, but
> from the POV of running the 'check' script the boundary is rather blurred.
> 
> You can run './check -nbd' and './check -qcow2', or both combined. The main
> limit that you can only pick a single format and single protocol at a time.

In fact, I've seen times where './check -nbd -raw' passes but './check
-nbd -qcow2' fails, because that combination enables different sets of
tests.  So we probably STILL aren't giving CI everything possible to
test by having just one dimension of easy-to-name test subsets, but it
is still better than no CI nbd tests at all.

> 
> IMHO for test suites it is preferrable to keep a flat namespace, rather
> than creating a matrix of suites for protocol vs format combniations.
> 
> Perhaps the meson.build variable should just be renamed from _formats
> to something else.

Renaming makes sense to me; would _bds be a reasonable name (since
both protocols and formats are a BDS)?  I'm open to other naming
ideas, as well.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


