Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547DDCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 14:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGeNv-0006Zi-68; Wed, 05 Nov 2025 09:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGeNs-0006Z8-LF
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 09:21:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGeNp-0008NT-EU
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 09:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762352466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a1Jy3+k+Kd5ypp14V64iXgMB/LOQaF5zjP7Ondaeqjw=;
 b=XS14KTAaU4XEHJt1iD2v13xZePSvAMqJicQgV7DRRk8BGBd5xNsPxAC7vlB2vuoR90pZEB
 a8ISePtGBlaMm0rpzB/2+9psTrzcHVatp/zVIG1x8QYObsP4Nb9b6P0hezGMvPiqqnryXW
 NmrIqLRqucThQhdNzuc0DyJkg//qBy4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-GuhnOvW9M2-GkL78QL4pnQ-1; Wed,
 05 Nov 2025 09:21:03 -0500
X-MC-Unique: GuhnOvW9M2-GkL78QL4pnQ-1
X-Mimecast-MFC-AGG-ID: GuhnOvW9M2-GkL78QL4pnQ_1762352462
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E73F195609F; Wed,  5 Nov 2025 14:21:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3CCE30001A4; Wed,  5 Nov 2025 14:21:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3989421E6A27; Wed, 05 Nov 2025 15:20:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com
Subject: Re: [PATCH] qapi/migration: Rewrap to 70 columns
In-Reply-To: <20251105134553.354886-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 5 Nov 2025 14:45:53 +0100")
References: <20251105134553.354886-1-richard.henderson@linaro.org>
Date: Wed, 05 Nov 2025 15:20:59 +0100
Message-ID: <87y0oklfw4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Avoid
>
> In file included from ../publish/qapi/qapi-schema.json:53:
> .../qapi/migration.json:1750:1: documentation line longer than 70 characters
>
> Fixes: ae00f0088ff ("migration/qmp: Update "resume" flag doc in "migrate" command")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Commit ae00f0088ff was actually fine when it went in.  However, it
produced a semantic conflict with my PR (merge commit d752763d0b9).

> Applied directly to master as a build fix.

Thanks!


