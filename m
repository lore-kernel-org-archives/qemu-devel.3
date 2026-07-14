Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB5BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbJT-00009p-JI; Tue, 14 Jul 2026 07:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wjbJR-00008o-9S
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 07:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wjbJP-0001nZ-Ew
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 07:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784028509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LL16fgoYNLEyhPlYPEzfPwmkqACoMWtCoWA1cvA7omY=;
 b=Ml/F34IyV/KcKR713lXg5/GPjC3hxDXADc/1dyvUhWWkS+l7DCljZRBV+3y3fiklD5WKYQ
 jloqTjTwsbJ8q/44xg4dC68UKtc/VtoyIGDQ8A6Vct+sTLRtF/LIn98B1NCNscK7TZ26Ip
 R1NxYoLF+PT84gwiIa4kX64AANHd5Ps=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-rhdM311uNU-tCmCxR1tKQw-1; Tue,
 14 Jul 2026 07:28:25 -0400
X-MC-Unique: rhdM311uNU-tCmCxR1tKQw-1
X-Mimecast-MFC-AGG-ID: rhdM311uNU-tCmCxR1tKQw_1784028504
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BED3518001F9; Tue, 14 Jul 2026 11:28:23 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.162])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBA541956087; Tue, 14 Jul 2026 11:28:21 +0000 (UTC)
Date: Tue, 14 Jul 2026 13:28:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, vsementsov@yandex-team.ru
Subject: Re: [PATCH 3/3] iotests/migrate-bitmaps-postcopy-test: drop the
 postcopy timing assertion
Message-ID: <alYdU5b2l9N-WZPe@redhat.com>
References: <20260710161309.1104712-1-den@openvz.org>
 <20260710161309.1104712-4-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710161309.1104712-4-den@openvz.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=kwolf@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Am 10.07.2026 um 18:13 hat Denis V. Lunev geschrieben:
> test_postcopy_success asserted `downtime * 10 < postcopy_time` to
> confirm the run spent meaningful time in postcopy. This is an
> unnormalized wall-clock heuristic tuned to old hardware (commit
> e80a4150a5), and fails on fast hosts where the bitmap payload now
> transfers in under a second while switch-over downtime stays fixed
> (e.g. downtime=0.6s, postcopy_time=0.8s).
> 
> It is also a weak proxy for the regression it guards against
> (postcopy degenerating to precopy): that is already covered by the
> bitmap sha256, mid-migration update and persistence checks, none of
> which depend on this timing.
> 
> Drop the assertion; keep printing the timings under debug.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>

I agree that this assertion failure doesn't mean that the test failed.
What it might mean is that maybe we didn't test the code as well as we
would have liked to.

Should we try to slow down/throttle the migration artificially to
trigger the cases we want to test here more reliably?

Kevin

>  tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
> index c519e6db8c..f9c55b6395 100755
> --- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
> +++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
> @@ -186,7 +186,6 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>          downtime = event_dist(event_stop, event_resume)
>          postcopy_time = event_dist(event_resume, event_complete)
>  
> -        assert downtime * 10 < postcopy_time
>          if debug:
>              print('downtime:', downtime)
>              print('postcopy_time:', postcopy_time)
> -- 
> 2.53.0
> 


