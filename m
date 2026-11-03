Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32253606A33D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EGrPJCpw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO91H-00050I-OD; Tue, 03 Nov 2026 02:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xO919-0004yI-H4
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 02:33:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xO917-0006Ke-FU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 02:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793691191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8t/PhT0TmrjrX3x8ebaDA0mi4m7J5NbpCBRY65EK9I=;
 b=EGrPJCpwkpCLIzuPX3ui59tWHZ1xVb5ZNWUWxQ1Vb3Ztqyc19xz9egU29Rh6o+eQ4yJJpi
 PJm6eZmNAky7LcgL899zHcPOFRKqkV1yFoUBjweL/I5LFuTYLugeBFixxn80e1eWpNvH4N
 grdXlaZN1IEG7EVFiPUiP3/zHJc2r70=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-0CkPoyG9NlWkBTUCe6rp9Q-1; Tue,
 03 Nov 2026 02:33:09 -0500
X-MC-Unique: 0CkPoyG9NlWkBTUCe6rp9Q-1
X-Mimecast-MFC-AGG-ID: 0CkPoyG9NlWkBTUCe6rp9Q_1793691189
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E20941956062
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 07:33:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1F4F7E2
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 07:33:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 42FA821E6A04; Tue, 03 Nov 2026 08:33:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  eblake@redhat.com,  jsnow@redhat.com
Subject: Re: [PATCH] qapi: Consistently use x.y with since
In-Reply-To: <auirCeOoztlMvglH@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 2 Nov 2026 15:23:53 +0000")
References: <20261102145627.3224952-1-armbru@redhat.com>
 <auirCeOoztlMvglH@redhat.com>
Date: Tue, 03 Nov 2026 08:33:06 +0100
Message-ID: <87jymujrnx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Nov 02, 2026 at 03:56:27PM +0100, Markus Armbruster wrote:
>> docs/devel/qapi-code-gen.rst documents "Since: x.y.z" and "(since
>> x.y.z)", but we almost always use just x.y.  Adjust the doc and the
>> exceptions to the ruling practice.
>
> Shortening to 2 digits is sensible given our current version
> numbering scheme. The 3rd digit is exclusively for stable
> branches that should not be forking qapi schemas.
>
> This only applies since our switch to this versioning scheme,
> which was in 3.0.0, so anything earlier than this should not
> be changed IMHO.

Makes sense.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  docs/devel/qapi-code-gen.rst |  4 ++--
>>  docs/interop/firmware.json   |  4 ++--
>>  qapi/accelerator.json        |  6 +++---
>>  qapi/crypto.json             |  2 +-
>>  qga/qapi-schema.json         | 38 ++++++++++++++++++------------------
>>  5 files changed, 27 insertions(+), 27 deletions(-)
>>=20
>
>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> index 7b937713e6..531fb8f8e0 100644
>> --- a/qga/qapi-schema.json
>> +++ b/qga/qapi-schema.json
>> @@ -110,7 +110,7 @@
>>  #
>>  # Returns: The unique integer id passed in by the client
>>  #
>> -# Since: 0.15.0
>> +# Since: 0.15
>>  ##
>>  { 'command': 'guest-sync',
>>    'data':    { 'id': 'int' },

[...]

>> @@ -464,7 +464,7 @@
>>  #    filesystems were unfrozen before this call, and that the
>>  #    filesystem state may have changed before issuing this command.
>>  #
>> -# Since: 0.15.0
>> +# Since: 0.15
>>  ##
>>  { 'command': 'guest-fsfreeze-thaw',
>>    'returns': 'int',
>
> Don't change any of these, since at that vintage, the 3rd digit
> was significant.

Done in v2.

Thank you!


