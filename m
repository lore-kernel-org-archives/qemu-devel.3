Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C2EC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWxk-0003Xt-B6; Fri, 07 Mar 2025 07:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWxg-0003SP-6o
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:37:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqWxX-0000iU-Gm
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741351065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9IUvbmUhZUo87KCkSUQ/TfgAd+nLAB1EeJHIdtywP+U=;
 b=Oea79YOk9uxtblVB9doyW6yOVCk5VhksLZ/L5LlsDV1NVf+Lycq4MYE6HbrrKh5hzZ/dpA
 GWGteSuDNmYBHON6LhpTXWYCIlqaM1DSnZdXOEeIfk+azcaMdUO18dVRpqv2jD7ik1RLgz
 3Qp4UntknwYbuAb05yXsExteiFQNJSg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-k46Ovo19P_O-8AI7wflFPw-1; Fri,
 07 Mar 2025 07:37:40 -0500
X-MC-Unique: k46Ovo19P_O-8AI7wflFPw-1
X-Mimecast-MFC-AGG-ID: k46Ovo19P_O-8AI7wflFPw_1741351059
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89CF819560B2; Fri,  7 Mar 2025 12:37:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D7101955F2D; Fri,  7 Mar 2025 12:37:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C544921E675F; Fri, 07 Mar 2025 13:37:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 57/57] docs/qapidoc: Add "the members of" pointers
In-Reply-To: <20250305034610.960147-58-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:46:06 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-58-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 13:37:36 +0100
Message-ID: <87jz91hv8v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

John Snow <jsnow@redhat.com> writes:

> Add "the members of ..." pointers to Members and Arguments lists where
> appropriate, with clickable cross-references - so it's a slight
> improvement over the old system :)
>
> This patch is meant to be a temporary solution until we can review and
> merge the inliner.
>
> The implementation of this patch is a little bit of a hack: Sphinx is
> not designed to allow you to mix fields of different "type"; i.e. mixing
> member descriptions and free-form text under the same heading. To
> accomplish this with a minimum of hackery, we technically document a
> "dummy field" and then just strip off the documentation for that dummy
> field in a post-processing step. We use the "q_dummy" variable for this
> purpose, then strip it back out before final processing. If this
> processing step should fail, you'll see warnings for a bad
> cross-reference. (So if you don't see any, it must be working!)
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Yes, it's a hack, and possibly fragile, but it'll all go away when the
inliner lands.  I understand the inliner already exists, but you're
holding it back to not balloon the series even more.

I'm on board.


