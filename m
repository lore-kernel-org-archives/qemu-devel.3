Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644A1C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 12:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUP9R-0008M8-6l; Wed, 25 Jun 2025 08:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUP9J-0008JO-R8
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 08:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUP9B-0000QR-II
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 08:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750854149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gzhc+ykbcoGfadoL3swMsFkwx81vkmzwVLTpy0BIgn0=;
 b=H57bvAK0ox5SioHNzPkVJsEAvWTKKPk0w7FwTrFcXTFxacexQ63BdrmlNvCt3e0qjWL75Q
 W/S7hvHNqxctMYRwadQLBpIUIcUxfWnKwPi/uPq7N8kPTsO/CjfrFDFDRR/+DfiAmLlFj5
 j0GRJnIANXXUmlWtKUVFVfrkMAGa9tA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-5UY4uAXmNuaMWluyuCB_5A-1; Wed,
 25 Jun 2025 08:22:28 -0400
X-MC-Unique: 5UY4uAXmNuaMWluyuCB_5A-1
X-Mimecast-MFC-AGG-ID: 5UY4uAXmNuaMWluyuCB_5A_1750854147
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7610718011DF; Wed, 25 Jun 2025 12:22:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A21430001A1; Wed, 25 Jun 2025 12:22:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 690BC21E6A27; Wed, 25 Jun 2025 14:22:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 03/21] qapi/migration: Don't document MigrationParameter
In-Reply-To: <87ikkk58p4.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 25 Jun 2025 14:04:07 +0200")
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-4-farosas@suse.de> <87ikkk58p4.fsf@pond.sub.org>
Date: Wed, 25 Jun 2025 14:22:24 +0200
Message-ID: <874iw457un.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> The MigrationParameter (singular) enumeration is not part of the
>> migration QMP API, it's only used for nicely converting HMP strings
>> into MigrationParameters (plural) members and for providing readline
>> completion.
>
>
>
>> Documenting this enum only serves to duplicate documentation between
>> MigrationParameter and MigrationParameters.
>>
>> Add an exception to QAPIs pragma.json and stop documenting it.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  qapi/migration.json | 152 +-------------------------------------------
>>  qapi/pragma.json    |   3 +-
>>  2 files changed, 3 insertions(+), 152 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 080968993a..452e6dedaa 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -734,157 +734,7 @@
>>  ##
>>  # @MigrationParameter:
>>  #
>> -# Migration parameters enumeration
>> -#
>> -# @announce-initial: Initial delay (in milliseconds) before sending
>> -#     the first announce (Since 4.0)
>
> [...]
>
>> -# @direct-io: Open migration files with O_DIRECT when possible.  This
>> -#     only has effect if the @mapped-ram capability is enabled.
>> -#     (Since 9.1)
>> +# Migration parameters enumeration. See @MigrationParameters for more info.
>
> Suggest something like
>
>    # The enumeration values mirror the members of MigrationParameters,
>    # which see.
>
> I could compare the deleted docs with MigrationParameters docs, but I
> doubt it's worthwhile: the type is only ever used internally.  That it
> appears in the QEMU QMP Reference Manual anyway is a defect.  There are
> quite a few more like it (list appended).
>
> If I remember correctly, John Snow's doc generator work will fix this
> defect.

Until then, this patch has a drawback: the manual now shows all the
members as "Not documented" .  Ugly and a bit embarrassing.  Maybe even
confusing.

[...]


