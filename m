Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF12E6B243
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 11:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6pZZ-0000qA-DT; Fri, 01 Nov 2024 07:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6pZX-0000pG-AP
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6pZU-0004GR-NF
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730459522;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Gtm1428ZtE7gz2G7O8ZNPwp4jKabj1snTJwVM1QWMdo=;
 b=jOlkz8qE5chSDfEgrfYGlNuoPHSsWrtF9Dq8Nhlvp7tv/yYx0VcPvSDgQQMS+P5RjFxp6A
 MYU4+56UvIqz7BIxGtL1I7ub0cPWQ43Dnxvw9/zIYXTtCfxLMdWpRRcbUXHV4PpBmsXRk1
 Fo+bhySepDWZsq/1cCQ19TJ+uboCj7M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-pCljbPhrN9GQ68r6rSfaGQ-1; Fri,
 01 Nov 2024 07:11:55 -0400
X-MC-Unique: pCljbPhrN9GQ68r6rSfaGQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5633C195609E; Fri,  1 Nov 2024 11:11:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D7F91956052; Fri,  1 Nov 2024 11:11:51 +0000 (UTC)
Date: Fri, 1 Nov 2024 11:11:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: QEMU Summit Minutes 2024
Message-ID: <ZyS3YoySC8oY-Wrf@redhat.com>
References: <CAFEAcA8pqjY-VKXPOe9W7J6upVhMeX8jJ=9Gmb8e64EtqHMQ_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8pqjY-VKXPOe9W7J6upVhMeX8jJ=9Gmb8e64EtqHMQ_g@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 31, 2024 at 01:32:09PM +0000, Peter Maydell wrote:
> Infrastructure and Funding
> --------------------------
> 
> Up until now we have been running our CI and infrastructure based on
> donations of services/credits from various hosting providers (first
> Rackspace, then Azure, and now DigitalOcean).  But because each of
> these infrastructure sponsors has their own differing idea of what
> infra to offer OSS projects for free, we end up with awkward
> migrations of our systems each time we switch to a different infra
> sponsor.
> 
> Paolo proposed, going forward, to instead seek monetary sponsorships,
> potentially multi-year, that give us a recurring funding stream long
> term.  We can then use this to fund CI and similar requirements.

On that theme, we also already accept adhoc donations from individuals
but have never made this very obvious, instead hiding the paypal link.

Now that we have a clear desire to try to fund our own project services
more directly, we should be more open to receiving adhoc donations from
individuals too.

We don't need to aggressively nag people, but there's little harm in
having a link to donations more prominently featured IMHO. Thus I
created a qemu-web proposal to put a donations link in the nav bar of
the front page:

   https://gitlab.com/qemu-project/qemu-web/-/merge_requests/7

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


