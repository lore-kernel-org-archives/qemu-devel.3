Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5033C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgnq-0008WL-FZ; Thu, 29 Feb 2024 08:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfgni-0008Tq-Op
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:50:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfgnW-0004MG-Sg
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709214605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vOJmasSLzJMbvsoQ5lyYlLMhFdV5Pi46mlVYf6fiXgA=;
 b=RwSvd/c2aqL1gfhERCQL1zH1U23KO9L3nRVdrysOXTpD1OVGAmX9DUc5jogwQfqLIC2tHx
 aDe0u4hO6fVWatkMt8o8xzAt8X2GSbh7x1y7a9Q/arGcYS5DIx7kllNGec7p2F+yX4rdIm
 C5Natn/SAMtSubLZkmyYbcf2DMmN6eY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-8qgU99sDNNSRFRo3q2K1UA-1; Thu,
 29 Feb 2024 08:50:04 -0500
X-MC-Unique: 8qgU99sDNNSRFRo3q2K1UA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAE92282D3D6;
 Thu, 29 Feb 2024 13:50:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 764692166B33;
 Thu, 29 Feb 2024 13:50:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A13021E6740; Thu, 29 Feb 2024 14:50:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,  qemu-devel@nongnu.org,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH] qapi: Fix format of the memory-backend-file's @rom
 property doc comment
In-Reply-To: <d4f39fea-bf1c-4177-a41d-afd1236f0a3d@redhat.com> (David
 Hildenbrand's message of "Thu, 29 Feb 2024 12:15:13 +0100")
References: <20240229105826.16354-1-sgarzare@redhat.com>
 <d4f39fea-bf1c-4177-a41d-afd1236f0a3d@redhat.com>
Date: Thu, 29 Feb 2024 14:50:01 +0100
Message-ID: <8734tbwfau.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

David Hildenbrand <david@redhat.com> writes:

> On 29.02.24 11:58, Stefano Garzarella wrote:
>> Reflow paragraph following commit a937b6aa73 ("qapi: Reformat doc
>> comments to conform to current conventions"): use 4 spaces indentation,
>> 70 columns width, and two spaces to separate sentences.
>>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>   qapi/qom.json | 27 ++++++++++++++-------------
>>   1 file changed, 14 insertions(+), 13 deletions(-)
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 2a6e49365a..db1b0fdea2 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -668,19 +668,20 @@
>>  # @readonly: if true, the backing file is opened read-only; if false,
>>  #     it is opened read-write.  (default: false)
>>  #
>> -# @rom: whether to create Read Only Memory (ROM) that cannot be modified
>> -#       by the VM.  Any write attempts to such ROM will be denied.  Most
>> -#       use cases want writable RAM instead of ROM.  However, selected use
>> -#       cases, like R/O NVDIMMs, can benefit from ROM.  If set to 'on',
>> -#       create ROM; if set to 'off', create writable RAM;  if set to
>> -#       'auto', the value of the @readonly property is used.  This
>> -#       property is primarily helpful when we want to have proper RAM in
>> -#       configurations that would traditionally create ROM before this
>> -#       property was introduced: VM templating, where we want to open a
>> -#       file readonly (@readonly set to true) and mark the memory to be
>> -#       private for QEMU (@share set to false).  For this use case, we need
>> -#       writable RAM instead of ROM, and want to set this property to 'off'.
>> -#       (default: auto, since 8.2)
>> +# @rom: whether to create Read Only Memory (ROM) that cannot be
>> +#     modified by the VM.  Any write attempts to such ROM will be
>> +#     denied.  Most use cases want writable RAM instead of ROM.
>> +#     However, selected use cases, like R/O NVDIMMs, can benefit from
>> +#     ROM.  If set to 'on', create ROM; if set to 'off', create
>> +#     writable RAM; if set to 'auto', the value of the @readonly
>> +#     property is used.  This property is primarily helpful when we
>> +#     want to have proper RAM in configurations that would
>> +#     traditionally create ROM before this property was introduced: VM
>> +#     templating, where we want to open a file readonly (@readonly set
>> +#     to true) and mark the memory to be private for QEMU (@share set
>> +#     to false).  For this use case, we need writable RAM instead of
>> +#     ROM, and want to set this property to 'off'.  (default: auto,
>> +#     since 8.2)
>>   #
>>   # Since: 2.1
>>   ##
>
> Ideally, we'd have a format checker that complains like checkpatch usually would.

I agree!

A documentation pretty-printer would be best, but feels too hard.  reST
syntax is baroque, and our own extensions make it more so.

A checker catching common mistakes should be feasible.

Patches welcome :)

> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

Reviewed-by: Markus Armbruster <armbru@redhat.com>


