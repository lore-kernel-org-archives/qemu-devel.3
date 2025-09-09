Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2567CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 09:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvuPb-0003Lo-Ll; Tue, 09 Sep 2025 05:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvuPX-0003LT-HV
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:13:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvuPK-0007B8-Jn
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757409172;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufpsRLzv03mJKet8cCrbBto1n1l94HCo8mUEx2cfd/I=;
 b=UiQgX8FP0y4V3/bJZdnYGdShTc+KALMzhCwD/OSzN99GGIfF3avm8s40eEbCTy0oeWNvQx
 uo8l3EMcI38dtUaZmAjpsGHUnQ5N9RSYBn6tpaXtXY8V3phbGutiu6M0t7Bbar2TBYOG4T
 u2Lgkjb8D8Qp5XI8TnrZT82RJvwyesw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-XvC_N1pPMQ6EV35gBbG0jg-1; Tue,
 09 Sep 2025 05:12:50 -0400
X-MC-Unique: XvC_N1pPMQ6EV35gBbG0jg-1
X-Mimecast-MFC-AGG-ID: XvC_N1pPMQ6EV35gBbG0jg_1757409166
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 621DC180028C; Tue,  9 Sep 2025 09:12:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCA78300018D; Tue,  9 Sep 2025 09:12:44 +0000 (UTC)
Date: Tue, 9 Sep 2025 10:12:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] scripts/ci: add gitlab-failure-analysis script
Message-ID: <aL_viWUEC6IBFcM6@redhat.com>
References: <20250908211859.2678847-1-alex.bennee@linaro.org>
 <56baeaa6-b274-457c-931d-4ae76535f6dd@redhat.com>
 <87plc06mwi.fsf@draig.linaro.org>
 <CAFEAcA--2G_K-4cjb=Xms3hQoGBAauyn+rJLTsFh1TnfnY6KWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA--2G_K-4cjb=Xms3hQoGBAauyn+rJLTsFh1TnfnY6KWg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, Sep 09, 2025 at 10:00:05AM +0100, Peter Maydell wrote:
> On Tue, 9 Sept 2025 at 09:39, Alex Bennée <alex.bennee@linaro.org> wrote:
> >
> > Thomas Huth <thuth@redhat.com> writes:
> >
> > > On 08/09/2025 23.18, Alex Bennée wrote:
> > >> This is a script designed to collect data from multiple pipelines and
> > >> analyse the failure modes they have.
> > >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> > >> ---
> > >>   scripts/ci/gitlab-failure-analysis | 65 ++++++++++++++++++++++++++++++
> > >>   1 file changed, 65 insertions(+)
> > >>   create mode 100755 scripts/ci/gitlab-failure-analysis
> > >
> > > You already get a nice overview by visiting a page like
> > > https://gitlab.com/qemu-project/qemu/-/pipelines/2019002986 ... what's
> > > the advantage of this script?
> >
> > Not having to click every link when I want to see what the pattern of
> > failures is and what might be a candidate for making flaky.
> 
> What I would like for finding flaky tests is to find every
> case where:
>  * a job failed on commit hash X
>  * we also have the same job succeeding on the same commit X
> 
> Those are the flaky tests, where we hit retry and it just
> passed the second time, and it rules out the cases where
> we had a genuine "job failed because the code being tested
> for merge had a problem".
> 
> When we find those jobs that only failed because of a flaky
> test then we can analyse their logs to identify what the
> exact failures were.
> 
> Can we find those with this script ?  (You can't do it with
> the gitlab web UI, whose search and filter capabilities
> are extremely limited.)

Downloading data from gitlab API is painfully slow so not something
you want to do regularly/repeatedly.

If we can have the script to download the data and save it locally,
we could then do something like populate a sqllite DB with pipeline
results which can we efficiently query to extract failure patterns.
I guess this script at least starts us moving in that direction by
giving us the framework to fetch data, and build on that...

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


