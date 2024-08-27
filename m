Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEAAC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sisgZ-0002N7-9Q; Tue, 27 Aug 2024 05:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sisgR-00026j-4K
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:40:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sisgN-0007Cy-Ax
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724751609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s9Lq4ikGCegT8NOsdXqemaWvNtboKtB4g1LhSNDwjVU=;
 b=FTL0Y75WZeODNrmhvfb3a6gGkgt07qotk8jDMumexSyfvVujbRuQ+oFdW+lqWE2zCY/zwj
 e0YKeRt9LGpSxKrILEhW5HR6BflOMkbYRSjMoE7Rl5lfk4FEYdYU3Pudw/iykd1qUy9/T+
 6bExnZdvykt7vhUaU6DYOsMgLmcN7r4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-ole_Y7tEN36WFsSt2HKIBA-1; Tue,
 27 Aug 2024 05:40:05 -0400
X-MC-Unique: ole_Y7tEN36WFsSt2HKIBA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5974B1955BEE; Tue, 27 Aug 2024 09:40:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAE6A1955F1B; Tue, 27 Aug 2024 09:40:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B466121E6A28; Tue, 27 Aug 2024 11:40:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH] docs/sphinx: fix extra stuff in TOC after freeform QMP
 sections
In-Reply-To: <20240822204803.1649762-1-jsnow@redhat.com> (John Snow's message
 of "Thu, 22 Aug 2024 16:48:03 -0400")
References: <20240822204803.1649762-1-jsnow@redhat.com>
Date: Tue, 27 Aug 2024 11:40:01 +0200
Message-ID: <87o75el2xa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Freeform sections with titles are currently generating a TOC entry for
> the first paragraph in the section after the header, which is not what
> we want.
>
> (Easiest to observe directly in the QMP reference manual's
> "Introduction" section.)
>
> When freeform sections are parsed, we create both a section header *and*
> an empty, title-less section. This causes some problems with sphinx's
> post-parse tree transforms, see also 2664f317 - this is a similar issue:
> Sphinx doesn't like section-less titles and it also doesn't like
> title-less sections.
>
> Modify qapidoc.py to parse text directly into the preceding section
> title as child nodes, eliminating the section duplication. This removes
> the extra text from the TOC.
>
> Only very, very lightly tested: "it looks right at a glance" :tm:. I am
> still in the process of rewriting qapidoc, so I didn't give it much
> deeper thought.
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>

Tested-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>

Queued, thanks!


