Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889F1CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENZW-0005k1-18; Wed, 07 Oct 2026 05:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xELEL-0001PB-MU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xELEG-0003mq-Cv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791354855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y5l6Kzz1LZc0Cvm+ifQAVuzVKkRoqBfsRmYLK4cfhMQ=;
 b=C8q0l4YxBn8bPwRF30VBe9aX2reNSnPLXz0CB9GGf5wZlJ2XMixXL+rn+uCwGaH2XHn0D+
 K222Nj/G+fCRKLI0iNwG6EIAuDyXzRGuC+QCbkf4f8KDog+AbK3USWwnPXui0tcWr9ONWF
 m0eFBJjC7giLz1NhtwXcc9LufYqWtUM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-F-ssqME0OkmQUORY-Xeepg-1; Tue,
 06 Oct 2026 01:58:36 -0400
X-MC-Unique: F-ssqME0OkmQUORY-Xeepg-1
X-Mimecast-MFC-AGG-ID: F-ssqME0OkmQUORY-Xeepg_1791266315
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0B641802668; Tue,  6 Oct 2026 05:58:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E7D341D; Tue,  6 Oct 2026 05:58:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1DC7F21E6A04; Tue, 06 Oct 2026 07:58:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 01/11] docs/qapi-code-gen: change "x.y.z" to "x.y" for
 Since: documentation
In-Reply-To: <20261001172239.2825745-2-jsnow@redhat.com> (John Snow's message
 of "Thu, 1 Oct 2026 13:22:28 -0400")
References: <20261001172239.2825745-1-jsnow@redhat.com>
 <20261001172239.2825745-2-jsnow@redhat.com>
Date: Tue, 06 Oct 2026 07:58:32 +0200
Message-ID: <871pa3fjzr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> We prefer using only x.y for Since: tags, not x.y.z.

True:

    $ git-grep -Ei '\(since [0-9]+\.[0-9]+\.' qapi
    qapi/block-core.json:#     Not set if the job completed successfully.  (since 2.12.1)
    qapi/crypto.json:# @sm3: SM3.  (since 9.2.0)

The latter could be shortened to 9.2 for consistency.

The former was merged into master as commit ab9ba614556 on 2018-05-15,
released in v3.0.0 on 2018-08-14.  It was picked into stable as commit
0779afdc897 on 2018-07-18, released in 2.12.1 on 2018-08-02.  We do such
things all the time, but this is the only time we recorded a stable
release.  I think we could replace it by 3.0 for consistency.

>                                                      Adjust docs
> accordingly.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


