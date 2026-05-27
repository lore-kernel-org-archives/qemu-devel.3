Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F35CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 14:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSFbt-0002GV-Ms; Wed, 27 May 2026 10:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSFbs-0002GN-K3
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSFbq-0006Ap-Fs
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779893507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2maupsA9S2anYdZJeBwNJKKk/y+rfJtjwiK5GIfzQQ=;
 b=hMqktBToVi0m3ai1GgKObZUbuSTHm2wn0BIrN/MJpdrLyf9x4ynqgLMDch/OH91i4luE1Q
 Zm4ugiUFDoAbL/GPT2q46KAmp5xcCzDMZua5LCILgaT7bFO6kcoH6nEi2wZlkA5YplC0fm
 qmrEtfFSqeT3kAufDuh9CFerKrVQDA0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-86R3NFNuMDe6QUOgJiEO1A-1; Wed,
 27 May 2026 10:51:44 -0400
X-MC-Unique: 86R3NFNuMDe6QUOgJiEO1A-1
X-Mimecast-MFC-AGG-ID: 86R3NFNuMDe6QUOgJiEO1A_1779893503
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CC80180044D; Wed, 27 May 2026 14:51:43 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.98])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CE9B30001BB; Wed, 27 May 2026 14:51:40 +0000 (UTC)
Date: Wed, 27 May 2026 16:51:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <ahcE-pDc_7tTrsz3@redhat.com>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CANCZdfrZFwq3Rq8xifJtvz2o8_3_z=4OTxvknv3x9b719bZK4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCZdfrZFwq3Rq8xifJtvz2o8_3_z=4OTxvknv3x9b719bZK4Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 27.05.2026 um 16:14 hat Warner Losh geschrieben:
> On Wed, May 27, 2026 at 4:01 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > Commit messages for AI-assisted changes
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > When AI/LLM tools produce or substantively shape your patch, add an
> > ``AI-used-for:`` trailer.  The text of the trailer could be one or more
> > of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> > explanation in parentheses::
> >
> >      AI-used-for: tests, docs
> >      AI-used-for: code
> >      AI-used-for: code (refactoring)
> >      AI-used-for: code (prototype)
> >      AI-used-for: research
> >
> > The trailer is intended as a clarification of your DCO obligations as
> > well as to guide reviewers.  It is not intended for minimal presence
> > such as autocomplete or asking for a pre-review of the patch, and it
> > does not remove your responsibility to understand the changes that you
> > are submitting.
> 
> Why invent something new here when Assisted-by: is used elsewhere
> and is likely more familiar to other users.

Because Assisted-by: gives different information, which at least to me
isn't really interesting at all. It's much more interesting to me if the
code I'm looking at is generated, or if you only generated the tests.

Kevin


