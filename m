Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06560CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1Sm-0002vH-Og; Thu, 21 May 2026 07:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ1Sk-0002v1-Uo
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ1Si-0001XC-Lc
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779362470;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wjc2B2hoE47u6nAwiaqiUZUqedqQIfR1vMl/KWhTFPk=;
 b=IFlKjH35aNSfXVaM7X0CjkgI0JPauPaNd3kZyv0AFU/40L9pxp3rPa2KoOX73uEksml1x6
 63S3Y6+c3oTg4zK5iRd304+A43ZUkA4/aABNW/0cSmgxeAqtRJInEdOec8sdvMeuVYhnj+
 HBLsFFX6q1vg1KZlxtBf5yQMWJl+t6c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-KvyGfWTANoqytqvx-cy09A-1; Thu,
 21 May 2026 07:21:08 -0400
X-MC-Unique: KvyGfWTANoqytqvx-cy09A-1
X-Mimecast-MFC-AGG-ID: KvyGfWTANoqytqvx-cy09A_1779362467
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAB0A180056E; Thu, 21 May 2026 11:21:06 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.98])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C57C19560A3; Thu, 21 May 2026 11:21:04 +0000 (UTC)
Date: Thu, 21 May 2026 12:21:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: RFC: GitLab issues for security disclosures
Message-ID: <ag7qndP7ifyiX-BT@redhat.com>
References: <agxzKzzDOJm1EU_v@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agxzKzzDOJm1EU_v@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 19, 2026 at 03:26:51PM +0100, Daniel P. Berrangé wrote:
> This needs an issue tracker to cope with & email is not an issue tracker.
> We faked an issue tracker with a shared spreadsheet to prevent us drowning
> these past few months, but this is still not sustainable & probably won't
> ever be.

snip

> We have some options IMHO
> 
>  1. Move all security disclosure to GitLab confidential issues
>     no disclosures via email
> 
>  2. Move AI/fuzzer assisted disclosures to GitLab confidential
>     issues, keep human discovered issues on qemu-security list
> 
>  3. Move AI/fuzzer assisted disclosures to GitLab public
>     issues, keep human discovered issues on qemu-security list

snip

> Some downsides/implications
> 
>  * Every disclosure in a confidential issue will be visible to every
>    maintainer who has joined the qemu-project repo on GitLab. IOW
>    that is treating every maintainer as equally trusted.
> 
>    We do have qemu-security though we could be mailed if someone
>    considered their disclosure to be severely impactful but the triage
>    team can't make that decision.
> 
>  * We must NOT grant membership to qemu-project at a Reporter level
>    for anyone whom is not an active maintainer. They must be limited
>    to the "Guest" role at most.

I did a query

  $ glab api --paginate /projects/11167699/members/all | jq '.[].name' | sort > members.txt
  $ IFS="                   
  " ;  for line in $(cat members.txt | sed -e 's/"//g' ) ; do echo -n "$line: " ; grep $line MAINTAINERS | wc -l ; done | grep ': 0'

Of the results without a match as a maintainer I see

 * Qemu Janitor
 * stsquad-gitlab-api-access

   Bot accounts


 * dgibson
 * Hanna Czenczek
 * MST

   False negatives - just name mismatches between gitlab account
   and MAINTAINERS files


 * Eduardo Habkost
 * Juan Quintela

   Former maintainers, no longer active in QEMU AFAIK


 * Peter Krempa
 * Peter Krempa (work)

   Libvirt maintainer, added to enable to move bugs between projects


 * Anthony Roberts
 * Bastian Koppelmann
 * Emilio Cota
 * Jim MacArthur
 * Joaquin de Andres
 * Paul Zimmerman

   At least 1 code commit, but not maintainers


 * Eldon

   Provided us some CI hardware for a period of time

 * Aihua Liang
 * Lars D

   Unclear


The former maintainers can probably be removed at this point, given
the length of time that's passed.

If we want to use "Confidential" issues in any way, the question is
whether the rest of the non-maintainers / non-bot accounts should
retain "Reporter" role or be moved to "Guest" role ?

Some contributors may be active enough that they're effectively
maintainers, even if not listed in MAINTAINERS.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


