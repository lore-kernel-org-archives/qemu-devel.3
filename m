Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647FECD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 08:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waUnX-0006YQ-5g; Fri, 19 Jun 2026 04:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waUnV-0006Y4-A4
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 04:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waUnT-0004TP-BM
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 04:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781858512;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r2jAeN18AvGoQBmw1ipI4EklKL1O8f+01qh+REghTKw=;
 b=O+Ymt6PRxCiQu1Njg8YUG3LYWdYAr2Huv8KqziUv7kXk0q+q4XS35XhQSgHgrAyDj6Vn3Z
 NA8MEUTMfeDv7R7ZzDkGfCFdGHlLi0LEns5KSseyo7CqBv7GkDqVsTA1hSzRBLMtInyZO7
 16JLtfRXUjq1v60S0nCaI8McmdjloHY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-NNyssTf-Ney-vxK-CEDJVg-1; Fri,
 19 Jun 2026 04:41:51 -0400
X-MC-Unique: NNyssTf-Ney-vxK-CEDJVg-1
X-Mimecast-MFC-AGG-ID: NNyssTf-Ney-vxK-CEDJVg_1781858510
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 492131956055
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 08:41:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.122])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4961E1772; Fri, 19 Jun 2026 08:41:48 +0000 (UTC)
Date: Fri, 19 Jun 2026 09:41:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [qemu-web PATCH] security: rework guideline about issue URL /
 CVE references
Message-ID: <ajUAyOd7mYaeiAlD@redhat.com>
References: <20260619082236.1175764-1-berrange@redhat.com>
 <ff565264-cabf-45d7-81e2-a35a23c79638@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff565264-cabf-45d7-81e2-a35a23c79638@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 19, 2026 at 10:27:33AM +0200, Thomas Huth wrote:
> On 19/06/2026 10.22, Daniel P. Berrangé wrote:
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> > 
> > This incorporates the feedback that Michael provided on the
> > just merged security process changes.
> > 
> >   contribute/security-process.md | 23 ++++++++++++++++-------
> >   1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/contribute/security-process.md b/contribute/security-process.md
> > index c091fa1..146e9cd 100644
> > --- a/contribute/security-process.md
> > +++ b/contribute/security-process.md
> > @@ -92,19 +92,28 @@ be scrubbed before disclosure.
> >    * The maintainer(s) will develop and/or review patch(es)
> >      for the issue privately, optionally attaching work in
> > -   progress fixes to the GitLab issues. All patches must
> > -   include the issue URL in the commit message(s). The
> > -   **"Workflow::In Progress"** label should be assigned when
> > +   progress fixes to the GitLab issues. The
> > +   **"Workflow::In Progress"** label can be assigned when
> >      a maintainer starts working on a fix.
> >    * When a CVE is allocated, it must be recorded as a comment on
> >      the GitLab issue, and the **"CVE::Required"** label replaced by
> >      the **"CVE::Assigned"** label.
> > - * The maintainer(s) will update the commit message(s) to include
> > -   the assigned CVE and issue URL. If multiple commits are required
> > -   to fix an issue the CVE must be included in the final commit in
> > -   the series, and may optionally be included in all prior commits.
> > + * The maintainer(s) will update the commit message(s) before
> > +   sending a pull request to include the assigned CVE and issue
> > +   URL in the following format:
> > +
> > +     ```
> > +     Fixes: CVE-1980-12345
> 
> So far we used "Fixes:" to indicate the commit ID of the patch that
> contained the bug. So maybe it's better to use something like "CVE:"
> instead?

We've used it alot for CVEs too:

  $ git log | grep 'Fixes: CVE'  | wc -l
  116


> > +     Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/75
> 
> Maybe best to use a number here that does not exist, e.g. "42".

Oh yes, good idea.

> 
>  Thomas
> 
> 
> > +     Reviewed-by: Not Me <notme@elsewhere.com>
> > +     Signed-off-by: Some One <someone@somewhere.com>
> > +     ```
> > +
> > +   If multiple commits are required to fix an issue the CVE must
> > +   be included in the final commit in the series, and may optionally
> > +   be included in all prior commits.
> >    * When the maintainer(s) are satisfied that the patch(es) are
> >      suitable to propose for merge, they must be submitted to
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


