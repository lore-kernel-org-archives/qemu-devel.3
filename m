Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1086CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHwJ-0006K4-UT; Wed, 10 Jun 2026 08:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wXHwI-0006Jc-6J
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wXHwG-0005Zh-2b
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781094103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwN0/1nK2kDBPwldWHk4XGeggj5eDpbUUPH0UOdkauM=;
 b=WV6IhtfqiHdRS+6rraU2ITURRuY+GGU75gQd6HPLcFoI/FWkiuNLchMDnq5C7A45FitWt8
 F1IiyzG+Gb7ge+SL+wPSLYHHoB19AyyxGrCxAsEGAA1JZyCtCuKgGy2kVziROKxlfliPQr
 s8KMvNpxUF+Hpu82t2vdHXqGvwfuGh8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-AvljUsKJPT2NZ40kQf4QYA-1; Wed,
 10 Jun 2026 08:21:40 -0400
X-MC-Unique: AvljUsKJPT2NZ40kQf4QYA-1
X-Mimecast-MFC-AGG-ID: AvljUsKJPT2NZ40kQf4QYA_1781094099
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 852961845446; Wed, 10 Jun 2026 12:21:38 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.216])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 161F718005B3; Wed, 10 Jun 2026 12:21:35 +0000 (UTC)
Date: Wed, 10 Jun 2026 14:21:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 0/8] Block layer patches
Message-ID: <ailWzRwN2AfIZjjF@redhat.com>
References: <20260608165207.307488-1-kwolf@redhat.com>
 <CAJSP0QXjj32djLOFPNg2jKjNN6eB7VvRXVfz3XiNkWYjR0-S2A@mail.gmail.com>
 <aik5Ox9cX_5FQbO4@redhat.com>
 <3982600a-61a1-406a-b1b9-246ae6d9a606@proxmox.com>
 <ailHvv4_bSZDQfUD@redhat.com> <ailM5OtknbaXuDOn@redhat.com>
 <ailPBVrN32VFpR6y@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ailPBVrN32VFpR6y@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 10.06.2026 um 13:48 hat Daniel P. Berrangé geschrieben:
> On Wed, Jun 10, 2026 at 01:39:16PM +0200, Kevin Wolf wrote:
> > Am 10.06.2026 um 13:17 hat Daniel P. Berrangé geschrieben:
> > > You just got unlucky with the new expanded CI testing introduced when
> > > my pull request was merged a few days ago.  Previously gitlab CI only
> > > tested qcow2 and raw, and so compat with other drivers was "best effort"
> > > after the fact.
> > > 
> > > Now the gitlab CI runs I/O tests across 10 drivers, so it needs to
> > > work before merge, which is something contributors didn't need to
> > > think about before now.
> > > 
> > > If you push a branch to your gitlab fork and trigger CI, you'll see
> > > the results in the "block" job in the pipeline results. 
> > 
> > Technically true, but who has the CI minutes to actually do this?
> 
> Pretty much everyone IMHO.
> 
> > I don't think we've figured out a solution yet how people (or at least
> > maintainers) can use QEMU's minutes from the open source program prior
> > to sending a patch series or pull request. Or have we?
> 
> GitLab user accounts get 400 minutes of CI credits.
> 
> Forks of QEMU though are only charged at a cost fact or 0.008 since
> we are a member of the OSS program
> 
>   https://docs.gitlab.com/ci/pipelines/compute_minutes/#cost-factors-of-hosted-runners-for-gitlabcom
> 
> IOW, you're charged 1 minute per 125 minutes of job time.
> 
> A single QEMU pipline run in my fork today cost 4.5 credits. That's
> enough for 87 pipeline runs per month, if I was not contributing to
> anything outside QEMU on gitlab.com.
> 
> If you run a pipeline to sanity check before sending a patch series
> I don't think most people will ever run out of credits.
> 
> If you run multiple pipelines a day during development then you might
> be pushing your luck. Better to use the local "make docker-...."
> targets for day-to-day testing during dev, and just use gitlab
> pipelines before submission.

Did this change at some point? Because I'm quite sure I stopped doing
full CI runs only after running out of minutes with very moderate use.
Ever since then, I've only manually started individual jobs when I had
reason to suspect there could be a problem with them.

Kevin


