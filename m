Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A807CEACEA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 17:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svgF1-00056K-GP; Tue, 01 Oct 2024 13:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svgF0-00056C-5N
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 13:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1svgEt-0000Er-Ql
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 13:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727802042;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xhN6KC0l5N9ILSalYFIArgIpYZwzG4RRIkeshKs1GSE=;
 b=bG+vEmDz/M1apG3BPA7b5h+7JNt5VEzanSGeGg6dj6K6lP87bv9aO3wH+vyv0V7pIlU4KQ
 JLTQJaLW/WP8e3XerU29FbGgS/2WuPetAMUC95m9sG8YDnI3R9fheymbBTCe1iCl2aZGrw
 iHj+YqHFTZL5j9BOMMzhgblF8OIG+QU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-l-uA_5X1NU6fngPfLOc9oQ-1; Tue,
 01 Oct 2024 13:00:38 -0400
X-MC-Unique: l-uA_5X1NU6fngPfLOc9oQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9A1F191962C; Tue,  1 Oct 2024 17:00:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.186])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 225BA195605A; Tue,  1 Oct 2024 17:00:35 +0000 (UTC)
Date: Tue, 1 Oct 2024 18:00:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 "open list:ARM SMMU <qemu-arm@nongnu.org>, " <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe Mathieu-Daud =?utf-8?B?w6k=?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/functional: Switch back to the gitlab URLs for the
 advent calendar tests
Message-ID: <ZvwqsX_g5IhVTNkG@redhat.com>
References: <20240930171834.51701-1-thuth@redhat.com>
 <ko5yn.bgayz532vi6@linaro.org>
 <23f7bf52-af7d-4186-b773-28b15e872064@redhat.com>
 <CAAjaMXZ0ixQoWroJeoVVo+fmC-hVhG9Dx_+F8PrPEMTid07hyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAjaMXZ0ixQoWroJeoVVo+fmC-hVhG9Dx_+F8PrPEMTid07hyg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Oct 01, 2024 at 03:09:29PM +0300, Manos Pitsidianakis wrote:
> On Tue, Oct 1, 2024, 12:14 PM Thomas Huth <thuth@redhat.com> wrote:
> 
> > On 01/10/2024 10.50, Manos Pitsidianakis wrote:
> > > Hello Thomas,
> > >
> > > On Mon, 30 Sep 2024 20:18, Thomas Huth <thuth@redhat.com> wrote:
> > >> Shortly after we switched to the original URLs on
> > qemu-advent-calendar.org,
> > >> the server went offline - looks like we are better off using the gitlab
> > >> URLs again instead.
> > >>
> > >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > >> ---
> > > [snip]
> > >> diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/
> > >> functional/test_microblazeel_s3adsp1800.py
> > >> index faa3927f2e..47c941d487 100755
> > >> --- a/tests/functional/test_microblazeel_s3adsp1800.py
> > >> +++ b/tests/functional/test_microblazeel_s3adsp1800.py
> > >> @@ -18,8 +18,8 @@ class MicroblazeelMachine(QemuSystemTest):
> > >>     timeout = 90
> > >>
> > >>     ASSET_IMAGE = Asset(
> > >> -        ('
> > http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
> > >> -
> > 'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
> > >> +        ('
> > https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/
> > >> day13.tar.xz'),
> > >> +
> > '67e4c502651f8801e724ecc26403f1d0cdbc00549b033166e2e8cd14e9d49fef')
> > >>
> > >>     def test_microblazeel_s3adsp1800(self):
> > >>         self.require_netdev('user')
> > >
> > > I downloaded both day13.tar.gz and day13.tar.xz and these archives have
> > > different file contents, is that on purpose?
> >
> > Oh, drat! That's a different package, indeed - it's the one from 2018, not
> > the one from 2023! I didn't really notice since I did not remove my
> > tests/functional/ folder before re-running the tests, so this test was
> > silently re-using the old binary from the previous test runs :-/
> > (note to myself: we should maybe remove the binaries after each test run).
> >
> > Thanks for spotting it!
> >
> > Meanwhile, the www.qemu-advent-calendar.org website seems to be back, so
> > maybe we don't need this patch here anymore... let's wait and see whether
> > it
> > remains stable now...
> 
> 
> Suggestion: Add a list of source URLs in Asset() so that it has a fallback
> if the first host cannot be reached, maybe you can respin the patch to do
> this?

If the first host URL isn't reliable then we shouldn't use it at all, just
point directly to the 2nd reliable URL. If neither of the URLs are considered
reliable then we shouldn't have the test enabled at all IMHO. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


