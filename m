Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF245CAC5BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 09:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3AIu-0002Km-4U; Mon, 29 Sep 2025 05:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v3AIn-0002K4-Q8
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v3AIe-000564-OR
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759138552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7E1h/u7CsOt2Bv3Cdl/QJ7Ib3zQc9Nw4tpo3WbroroA=;
 b=NQ70IF6NrbkePBCcC/GEYHmNhxrCAIoi+zDSl5V4Jw6L+jHieMIhHR0KE5u3qVMU5KqowJ
 ojrwsXLpei3N/dYzvcqGYzGbiCNLiJhJVbM6uBy8axDqNHMF3P5w5gBeKbzh4WE3O2W3b4
 B4c7I1vEbhzzbA48ayR8W4fAq+kemW8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-P10CHTskNEmq_uOhLCDAgQ-1; Mon,
 29 Sep 2025 05:35:50 -0400
X-MC-Unique: P10CHTskNEmq_uOhLCDAgQ-1
X-Mimecast-MFC-AGG-ID: P10CHTskNEmq_uOhLCDAgQ_1759138549
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 401E518004D4; Mon, 29 Sep 2025 09:35:49 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.153])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 891F0180057A; Mon, 29 Sep 2025 09:35:46 +0000 (UTC)
Date: Mon, 29 Sep 2025 11:35:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 3/3] docs/code-provenance: AI exceptions are in addition
 to DCO
Message-ID: <aNpS8C5o44kLjspU@redhat.com>
References: <20250922154843.60233-1-pbonzini@redhat.com>
 <20250922154843.60233-4-pbonzini@redhat.com>
 <aNo7RaEOKJ5GFjNQ@redhat.com>
 <2eec6166-f426-41f8-bb79-18ac7d5497cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eec6166-f426-41f8-bb79-18ac7d5497cd@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 29.09.2025 um 11:19 hat Paolo Bonzini geschrieben:
> On 9/29/25 09:54, Kevin Wolf wrote:
> > Am 22.09.2025 um 17:48 hat Paolo Bonzini geschrieben:
> > > Using phrasing from https://openinfra.org/legal/ai-policy (with just
> > > "commit" replaced by "submission", because we do not submit changes
> > > as commits but rather emails), clarify that the contributor remains
> > > responsible for its copyright or license status.
> > 
> > I feel here the commit message is clearer than...
> > 
> > > +Exceptions do not remove the need for authors to comply with all other
> > > +requirements for contribution.  In particular, the "Signed-off-by"
> > > +label in a patch submissions is a statement that the author takes
> > > +responsibility for the entire contents of the patch, including any parts
> > > +that were generated or assisted by AI tools or other tools.
> > 
> > ...the actually committed text. We should probably mention "copyright or
> > license status" explicitly here in some way instead of just a more
> > generic "responsibility for the entire contents" without referring to
> > copyright.
> 
> It's mentioned earlier, since the responsibility is not limited to
> exceptions: "To satisfy the DCO, the patch contributor has to fully
> understand the copyright and license status of content they are contributing
> to QEMU".  I find this sentence to be already a bit heavy, and would prefer
> not to make it longer.

Isn't the whole paragraph meant to say that exceptions don't make any of
earlier mentioned requirements go away? So I don't think it would be
redundant in this context, even though of course it would repeat the
requirement just to tell more specifically what it's referring to.

If you don't want to say "copyright or license status" here, referring
to "DCO requirements" would have the same effect (because we do have
the explanation you quoted).

Kevin


