Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C340ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnbq-0005GX-4d; Fri, 31 Oct 2025 07:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEnbl-0005FT-Ue
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:47:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEnbh-0005C3-Uv
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761911267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cbcbvyOxwj5hZ9NCbsoYCQjxopoz3miKOB2DKeQlLAQ=;
 b=TO3f1qkRdwTD+Yae2b8pYV1VGFS5ZLo4hAWNkPBulJBxUv5nXWsJ1QVfGcs5ZDtTarFPqb
 G76nBY2sGxSwRjNbOiAdAUuuFoUM0PUhqmojvfDgOLXv26+VscAoPygqxzOZiBgTI2Gd4l
 KqF5T2XoGU6CegOsL4G2OLjj7yOHEtE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-S6HQBNxSP9akk-6cQvXLLw-1; Fri,
 31 Oct 2025 07:47:43 -0400
X-MC-Unique: S6HQBNxSP9akk-6cQvXLLw-1
X-Mimecast-MFC-AGG-ID: S6HQBNxSP9akk-6cQvXLLw_1761911263
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFA8018001E9; Fri, 31 Oct 2025 11:47:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89DED30001A6; Fri, 31 Oct 2025 11:47:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 01C0D21E6A27; Fri, 31 Oct 2025 12:47:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  jsnow@redhat.com,  eblake@redhat.com,
 thuth@redhat.com,  berrange@redhat.com,  philmd@linaro.org,
 kchamart@redhat.com,  mst@redhat.com,  sgarzare@redhat.com
Subject: Re: [PATCH 2/8] qapi: Refill doc comments to conform to conventions
In-Reply-To: <51280808-c3aa-4922-addc-ccd0b8e8a33b@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 31 Oct 2025 13:25:55 +0300")
References: <20251031094751.2817932-1-armbru@redhat.com>
 <20251031094751.2817932-3-armbru@redhat.com>
 <51280808-c3aa-4922-addc-ccd0b8e8a33b@yandex-team.ru>
Date: Fri, 31 Oct 2025 12:47:39 +0100
Message-ID: <87pla38f8k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 31.10.25 12:47, Markus Armbruster wrote:
>> Sweep the entire documentation again.  Last done in commit
>> 01bed0ff14b (qapi: Refill doc comments to conform to conventions).
>>
>> To check the generated documentation does not change, I compared the
>> generated HTML before and after this commit with "wdiff -3".  Finds no
>> differences.  Comparing with diff is not useful, as the reflown
>> paragraphs are visible there.
>>
>> Signed-off-by: Markus Armbruster<armbru@redhat.com>
>
> git show --color-words='[^#[:space:]]+'
>
> shows no difference, except for around postcopy-vcpy-latency, were it
> breaks for some reason.

Yes, diff gets a bit confused around there.

> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks!


