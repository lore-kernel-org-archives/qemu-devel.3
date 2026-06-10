Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B205CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGmf-0006UQ-5J; Wed, 10 Jun 2026 07:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXGmd-0006Po-Fw
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXGmb-0000eg-SD
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089660;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDSuVgz/zUbV0bkUG9Bp8Y8NSoXob5ehx4lF8HD1Bs0=;
 b=Bu0wix0lK/FqaGbmoeC/VSNEWJ7RIGZHmvDXeLdvsUNjS9nNVoD4XdkMJlg80xJaMqvl0U
 Idx3I+JAhkObVE7R2KGb70UgzQTijb0ZRm71lLPKy2UziCykjMhx09tpWBl7fGs0CqwUfW
 zUINix2aO6WPh3DC6Vzmq2O9Vd/FVvw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-O62FkcSQMZi9bPbdrEI0VQ-1; Wed,
 10 Jun 2026 07:07:38 -0400
X-MC-Unique: O62FkcSQMZi9bPbdrEI0VQ-1
X-Mimecast-MFC-AGG-ID: O62FkcSQMZi9bPbdrEI0VQ_1781089657
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7ED41955E92; Wed, 10 Jun 2026 11:07:37 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.112])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17B7D180059C; Wed, 10 Jun 2026 11:07:34 +0000 (UTC)
Date: Wed, 10 Jun 2026 12:07:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web RFC 0/3] switch to GitLab confidential issues for
 security disclosure
Message-ID: <ailFcly_pt6Job5Q@redhat.com>
References: <20260604165048.457860-1-berrange@redhat.com>
 <20260610062358-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610062358-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 10, 2026 at 06:28:34AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 04, 2026 at 05:50:45PM +0100, Daniel P. Berrangé wrote:
> > I previously raised the idea of using GitLab issues for security
> > disclosures:
> > 
> >   https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04582.html
> 
> 
> Thanks a lot for posting this!
> 
> Do we want a special
> 
> .gitlab/issue_templates/security_bug.md
> 
> For this?
> 
> It can include guidance in a friendly way.

I'm on the fence about that. I was coming at this from the POV
that security issue disclosure and triage is effectively identical
to normal bug disclosure & triage. The only difference is that
a security issue is initially "confidential" until a maintainer
has sanity checked its severity. I don't think we need to prompt
for different types of information from the user, and even if we
did, it seems like we'll probably just get the  structured markdown
doc the LLM spits out that people have been emailing us.

Maybe it is sufficient to just link to the security.html page
from the existing issue template.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


