Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D59CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzDn-000111-DO; Thu, 21 May 2026 04:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPzDl-000100-Lo
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPzDd-0008Rn-U6
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779353804;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3gfAuTKn2aKWFJn6oubF0ZD5wEfpUTYVxNz1ug6n4I=;
 b=FfUxQOy9jd0TQBOw4SO2wkQJ5s5XElJSaOj/AlDkcIg2jcKQXvva0u3OIWwd+9p6XiImpr
 rJnGp91owP+baKLSMYW/qdPR9CEdhj5gcP4glx8JY4d1GFEwEeXPJ3ydNMbnu3B0HJ2yzY
 /uOt31ypm8zSiatFTKE84S3LpdZbej0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-WrHOdeEUObqrRfLRQY8p2A-1; Thu,
 21 May 2026 04:56:40 -0400
X-MC-Unique: WrHOdeEUObqrRfLRQY8p2A-1
X-Mimecast-MFC-AGG-ID: WrHOdeEUObqrRfLRQY8p2A_1779353799
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCA5C180061A; Thu, 21 May 2026 08:56:38 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.98])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EE2E1800352; Thu, 21 May 2026 08:56:34 +0000 (UTC)
Date: Thu, 21 May 2026 09:56:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 John Snow <jsnow@redhat.com>, John Levon <john.levon@nutanix.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [PULL 00/29] Misc next patches
Message-ID: <ag7Ivp45DjSmG431@redhat.com>
References: <20260520091351.1160442-1-berrange@redhat.com>
 <CAJSP0QWmfyiNYm0YXQysywq9Ry4Rt+xRCEC_d8PSJJxv9LPcug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QWmfyiNYm0YXQysywq9Ry4Rt+xRCEC_d8PSJJxv9LPcug@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 20, 2026 at 04:51:46PM -0400, Stefan Hajnoczi wrote:
> On Wed, May 20, 2026 at 5:14 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The following changes since commit e89049b3ba5f1f0468bc0d294173345597514a1b:
> >
> >   Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2026-05-19 15:23:10 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/berrange/qemu tags/misc-next-pull-request
> >
> > for you to fetch changes up to 5236113844128157c68ea9230cbb56f2ab485f31:
> >
> >   qom: drop user_creatable_add_type method (2026-05-20 10:12:38 +0100)
> >
> > ----------------------------------------------------------------
> > Misc patches for iotests, qom, crypt & io
> >
> >  * Fix client side anoymous TLS credentials
> >  * Fix return value semantics for qio_channel_flush
> >  * Add ID validation of internal QOM constructor
> >  * Fix ability to create internal QOM objects
> >    without a parent
> >  * Merge user creatable object constructor into
> >    main QOM file
> >  * Print reason for skipping I/O tests
> >  * Remove redundant meson suits for I/O tests
> >  * Add optional suites for many block drivers I/O tests
> >  * Run I/O tests for 10 block drivers in GitLab CI
> 
> Hi Dan,
> The following image format tests are failing:
> https://gitlab.com/qemu-project/qemu/-/jobs/14470148602
> https://gitlab.com/qemu-project/qemu/-/jobs/14470148603
> 
> Please resend either together with fixes or with changes to the test
> set to keep the failing tests disabled for now.

Interestingly these image format tests all passed on your previous
attempt to merge this pull requests.

The difference is that this time the jobs appear to get run by QEMU
private AWS runners, while the previous posting got run on GitLab
shared runners.

I've filed bugs for the three failing tests and marked them all
to be skipped, and will re-post once reviewed.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


