Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99589C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJ6Q-0008J5-Ez; Wed, 12 Mar 2025 06:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsJ6K-0008H4-5l
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tsJ6G-0006ue-W3
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741774447;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=43/FirSpyHdJAIgLS1pGKunJqFZj95JhkeLnbgqOZEc=;
 b=BuofIAewXRj+zLSod9atHvFV143CiwHuGrUwnUSR+meXAvZSzbTpoe0SDz33tr0fnYCdfD
 vTfPXBnKmN84z4lHCJCgBC9Qb8IwMYUwreUMwLf5ybbbVFhP8yVf2jdqdGWc1UJd4KnwmL
 24bcE89Kt/bMmcGDmMlgG5g4hPDEv5g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-wnZp0PNDN52DeW4MIQ0oXQ-1; Wed,
 12 Mar 2025 06:14:02 -0400
X-MC-Unique: wnZp0PNDN52DeW4MIQ0oXQ-1
X-Mimecast-MFC-AGG-ID: wnZp0PNDN52DeW4MIQ0oXQ_1741774441
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7E1C180AF49; Wed, 12 Mar 2025 10:13:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F16E1956094; Wed, 12 Mar 2025 10:13:49 +0000 (UTC)
Date: Wed, 12 Mar 2025 10:13:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Bibo Mao <maobibo@loongson.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: Re: Giving your own patches your Reviewed-by
Message-ID: <Z9FeWG3eRACrisrC@redhat.com>
References: <878qpamvk6.fsf@pond.sub.org>
 <9329310c-bfad-44aa-a53a-87c1f39668a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9329310c-bfad-44aa-a53a-87c1f39668a2@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 12, 2025 at 11:03:04AM +0100, Philippe Mathieu-Daudé wrote:
> Hi Markus,
> 
> (Cc'ing Yi, Clément and Zhenzhong for commit eda4c9b5b3c)
> 
> On 12/3/25 10:45, Markus Armbruster wrote:
> > I stumbled over commits that carry the author's Reviewed-by.
> > 
> > There may be cases where the recorded author isn't the lone author, and
> > the recorded author did some meaningful review of the patch's parts that
> > are not theirs.  Mind that we do need all authors to provide their
> > Signed-off-by.
> > 
> > When the only Signed-off-by is from the recorded author, and there's
> > also their Reviewed-by, the Reviewed-by is almost certainly bogus.
> > 
> > Now, accidents happen, no big deal, etc., etc.  I post this to hopefully
> > help reduce the accident rate :)
> > 
> > Here's my quick & sloppy search for potentially problematic uses of
> > Reviewed-by:
> > 
> > $ git-log --since 'two years ago' | awk -F: '/^commit / { commit=$0 } /^Author: / { guy=$2 } /^    Reviewed-by: / { if ($2 == guy) { print commit; print guy } }'
> 
> 
> Explaining some commits where I'm mentioned:

> I posted a patch with my S-o-b; Richard took it, improved and reposted
> it with his S-o-b; I reviewed Richard's changes (and eventually merged).

That is totally fine, and an example of an expected scenario
that the simple shell 1-liner above can't eliminate.

> Is this workflow making sense and accepted? Otherwise what should
> we change? Maybe clarify along with the tags; or including all
> Message-Id could make this easier to track?

I don't see any problems with the commit messages as already written and
imho don't think we need to change it.

The main scenario that I would say is invalid is a commit containing
/only/ a matching rb/sob pair e.g.

 Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
 Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

as that is clearly either a "marking your own homework" case, or
someone has forgot to update the R-b/SoB tags.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


