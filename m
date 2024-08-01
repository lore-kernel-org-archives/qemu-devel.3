Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48195C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 11:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZU5L-00054K-8w; Thu, 01 Aug 2024 07:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZU5J-0004zv-OK
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZU5I-0005wV-95
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722512103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2prQn4AvlqAirrxQEn7Tka3iAQtocsNfPVTXFt2kT4=;
 b=RHv2+irFxEURieDKAJ/K50ldWY6LeVF9yQ0GyWpKlUDgxlqr0c2I90ha6kFgUx02/d/0Az
 St5aSpRxJXC/qZjynv3tKCqEJsPyNG4+TTxAXwPNbIXxnXuqYTUVHrct8Jhb9kWSkvKKvo
 +lcNg5hYgumvAeYQ3cOscvbhG6RR8ns=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-zrCYipwaOo-uNmkE0krr6A-1; Thu,
 01 Aug 2024 07:35:00 -0400
X-MC-Unique: zrCYipwaOo-uNmkE0krr6A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A5491955D47; Thu,  1 Aug 2024 11:34:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA28519560AE; Thu,  1 Aug 2024 11:34:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7796621E668A; Thu,  1 Aug 2024 13:34:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-trivial@nongnu.org
Subject: Re: [PATCH] include: Fix typo in name of MAKE_IDENTFIER macro
In-Reply-To: <20240801102516.3843780-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 1 Aug 2024 11:25:16 +0100")
References: <20240801102516.3843780-1-peter.maydell@linaro.org>
Date: Thu, 01 Aug 2024 13:34:56 +0200
Message-ID: <87zfpwcw7z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In commit bb71846325e23 we added some macro magic to avoid
> variable-shadowing when using some of our more complicated
> macros. One of the internal components of this is a macro
> named MAKE_IDENTFIER. Fix the typo in its name: it should
> be MAKE_IDENTIFIER.
>
> Commit created with
>  sed -i -e 's/MAKE_IDENTFIER/MAKE_IDENTIFIER/g' include/qemu/*.h include/qapi/qmp/qobject.h
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Can't believe I messed this up, but git proves I did %-}

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!


