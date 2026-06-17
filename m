Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0BACD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrWB-0007NV-Lv; Wed, 17 Jun 2026 10:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wZrW1-0007EA-0w
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wZrVw-0005Qw-Vx
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781707507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4gF3bJRIhO+0ZTbUwO1neYFBiuuivMGdJ/0Gbdduf5Q=;
 b=Pwl6jd4f4B06siYtygzTaPWNZrYG5VyRZcKSOtRZQ2d60rOhRCwHlUJ3ptju+6YHFReDGD
 tGqTH5js2WTc1O/hY7KaD2LEGz6SdXjnsZePEa+TSXWWD2DZa+X/ohR+h4CDQi0d913G1g
 bjfMqpniWa3sYlvM+LwROPl2AmvL1So=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-zKaQhLR_N0ux-HVKzBl1Kg-1; Wed,
 17 Jun 2026 10:45:03 -0400
X-MC-Unique: zKaQhLR_N0ux-HVKzBl1Kg-1
X-Mimecast-MFC-AGG-ID: zKaQhLR_N0ux-HVKzBl1Kg_1781707502
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE03818005AE; Wed, 17 Jun 2026 14:45:01 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 440463008B3D; Wed, 17 Jun 2026 14:44:56 +0000 (UTC)
Date: Wed, 17 Jun 2026 16:44:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <ajKy5g3EfdaDicly@redhat.com>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <9ad69343-38b5-449c-8d7b-5cbde9d3b72f@linux.ibm.com>
 <ajJdH8XMmfd8RinN@redhat.com> <ajJftnDx2L7PGNuK@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajJftnDx2L7PGNuK@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 17.06.2026 um 10:49 hat Daniel P. Berrangé geschrieben:
> On Wed, Jun 17, 2026 at 10:38:55AM +0200, Kevin Wolf wrote:
> > Am 16.06.2026 um 19:06 hat Christian Borntraeger geschrieben:
> > > Am 29.05.26 um 11:46 schrieb Paolo Bonzini:
> > > > -Exceptions do not remove the need for authors to comply with all other
> > > > -requirements for contribution.  In particular, the "Signed-off-by"
> > > > -label in a patch submission is a statement that the author takes
> > > > -responsibility for the entire contents of the patch, including any parts
> > > > -that were generated or assisted by AI tools or other tools.
> > > > +.. code-block:: none
> > > > +
> > > > +     AI-used-for: tests, docs
> > > > +     AI-used-for: code
> > > > +     AI-used-for: code (refactoring)
> > > > +     AI-used-for: code (prototype)
> > > > +     AI-used-for: research
> > > > +
> > > > +``AI-used-for`` should not be included for "background" usage such as
> > > > +autocomplete or obtaining a pre-review of the patch.
> > > 
> > > So what about using AI for security scanning? So how do we want to treat
> > > a patch from a human that is based on an AI report.
> > > And if ok, would we then add something like
> > > 
> > > Reported-by: Claude, chatgpt whatever?
> > 
> > I think it's effectively the same as Coverity, which we don't
> > acknowledge with a Reported-by tag, though we often mention it in the
> > commit message text. The same practice would make sense to me here.
> > 
> > (Though of course for Coverity, we have the CID, which obviously doesn't
> > exist for things found with a one-off LLM run, so there is some
> > difference there.)
> 
> Incidentally does any ever find the CID to be useful in the commit
> message ?

I've occasionally looked it up during review, but not sure if I ever
made use of the permanent record in the git history.

Kevin


