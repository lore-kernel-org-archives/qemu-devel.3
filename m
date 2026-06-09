Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E405FCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtmi-00047s-Qj; Tue, 09 Jun 2026 06:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWtmh-00047U-3T
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWtmf-0003a2-Ky
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781001252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wd/tHBpsTRyukU2a88KnPkGzpe/JcllZG7fVvS1ZRAo=;
 b=M0KOwHAqMHcM6JVPYRSQlDE8xTt53LS7tM+6E84OBp0N6l9BELeEUO3R2KhmyzPeL+2hZL
 71MJy16EsYIPV+Krv23QcMX/42Dpb9AAYR1Hm81WSOkWeI3iHw+xWX94ONRTt4F6uYd8sa
 KLfXm83Koc+0YgwroUD3Mf9Rrip1A50=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-V1SmHb23O9WDrJWkw6VgJw-1; Tue,
 09 Jun 2026 06:34:08 -0400
X-MC-Unique: V1SmHb23O9WDrJWkw6VgJw-1
X-Mimecast-MFC-AGG-ID: V1SmHb23O9WDrJWkw6VgJw_1781001247
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FD81195609F; Tue,  9 Jun 2026 10:34:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE16D3008B37; Tue,  9 Jun 2026 10:34:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 56FCA21E6A01; Tue, 09 Jun 2026 12:34:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: amit@kernel.org,  berrange@redhat.com,  eblake@redhat.com,
 eduardo@habkost.net,  lvivier@redhat.com,  marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com,  maxbr@linux.ibm.com,  mst@redhat.com,
 noh4hss@gmail.com,  pbonzini@redhat.com,  philmd@linaro.org,
 qemu-devel@nongnu.org,  wangyanan55@huawei.com,  zhao1.liu@intel.com
Subject: Re: [PATCH] qapi: drop "must exist" from ID descriptions for
 consistency
In-Reply-To: <20260120081821.884342-1-filip.hejsek@gmail.com> (Filip Hejsek's
 message of "Tue, 20 Jan 2026 09:18:21 +0100")
References: <924c52d6089b3c0cfd3a235887579ae0322cffba.camel@gmail.com>
 <20260120081821.884342-1-filip.hejsek@gmail.com>
Date: Tue, 09 Jun 2026 12:34:03 +0200
Message-ID: <877bo8q9yc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Uh, this fell through the cracks, possibly because it was buried within
a thread.

Filip Hejsek <filip.hejsek@gmail.com> writes:

> Make chardev ID param descriptions more consistend with ID descriptions

Typo: consistent

Not worth a respin.

> elsewhere.
> ---
>  qapi/char.json | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/char.json b/qapi/char.json
> index 140614f82c..fbac5a1cb7 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -791,7 +791,7 @@
>  #
>  # Change a character device backend
>  #
> -# @id: the chardev's ID, must exist
> +# @id: the chardev's ID
>  #
>  # @backend: new backend type and parameters
>  #
> @@ -832,7 +832,7 @@
>  #
>  # Remove a character device backend
>  #
> -# @id: the chardev's ID, must exist and not be in use
> +# @id: the chardev's ID, must not be in use
>  #
>  # Since: 1.4
>  #
> @@ -849,7 +849,7 @@
>  #
>  # Send a break to a character device
>  #
> -# @id: the chardev's ID, must exist
> +# @id: the chardev's ID
>  #
>  # Since: 2.10
>  #

Reviewed-by: Markus Armbruster <armbru@redhat.com>

I can take this.


