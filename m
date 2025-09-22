Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE7BCAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0fg7-0006ew-UP; Mon, 22 Sep 2025 08:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0fg2-0006eA-Ku
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0ffo-0004GB-DX
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758544176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHPzJPE4Aviny2rqeaKA0TEulZt6obVx0LxJ0NJJa7c=;
 b=clhbz5ZIgMmwJFgBl6rMhme+mIciKKRWOQSogNHzXKRurefOaSxAhoauxQeZizyJO6iks7
 iFYB9zpUwZMZcW5wVsr68TnBCIBY4HXc+EYKe2jyn3Y781FjnN23N1rrxucS2pX6Y7obCN
 KkkJkjjdcwWjc2j6f++so8rkND2v3aA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-9Pn8zsYDOXWroGC2HCh_hQ-1; Mon,
 22 Sep 2025 08:29:35 -0400
X-MC-Unique: 9Pn8zsYDOXWroGC2HCh_hQ-1
X-Mimecast-MFC-AGG-ID: 9Pn8zsYDOXWroGC2HCh_hQ_1758544174
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E52D71800357; Mon, 22 Sep 2025 12:29:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 745F21800452; Mon, 22 Sep 2025 12:29:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6798721E6A27; Mon, 22 Sep 2025 14:29:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alessandro
 Ratti
 <alessandro@0x65c.net>,  alessandro.ratti@gmail.com,  philmd@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] virtio: Add function name to error messages
In-Reply-To: <87wm5qoig7.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Mon, 22 Sep 2025 12:06:00 +0100")
References: <87a52wqa03.fsf@draig.linaro.org>
 <20250915162643.44716-1-alessandro@0x65c.net>
 <20250915162643.44716-2-alessandro@0x65c.net>
 <87h5wulqm2.fsf@pond.sub.org> <aNEpVhkZ2r5e2Z9X@redhat.com>
 <87wm5qoig7.fsf@draig.linaro.org>
Date: Mon, 22 Sep 2025 14:29:30 +0200
Message-ID: <877bxqk6vp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>> On Mon, Sep 22, 2025 at 12:37:57PM +0200, Markus Armbruster wrote:
>>> Alessandro Ratti <alessandro@0x65c.net> writes:
>>>=20
>>> > Replace virtio_error() with a macro that automatically prepends the
>>> > calling function name to error messages. This provides better context
>>> > for debugging virtio issues by showing exactly which function
>>> > encountered the error.
>>> >
>>> > Before: "Invalid queue size: 1024"
>>> > After:  "virtio_queue_set_num: Invalid queue size: 1024"
>>> >
>>> > The implementation uses a macro to insert __func__ at compile time,
>>> > avoiding any runtime overhead while providing more specific error
>>> > context than a generic "virtio:" prefix.
>>>=20
>>> A need for function names and such in error messages suggests the error
>>> messages are crap.
>>
>> I pretty much agree. If we take that view forwards, then I think our
>> coding guidelines should explicitly state something like
>>
>>  "Function names must never be included in error messages.
>>
>>   The messages need to be sufficiently descriptive in their
>>   text, such that including function names is redundant"

I'm in favor.

> Ahh I missed the fact this ends up as an error_report. I think having
> function names in debug output is fine.

No argument!

> It does however miss important information like which VirtIO device is
> actually failing, despite having vdev passed down to the function.

Yes, which device failed should definitely be reported.

[...]


