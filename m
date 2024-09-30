Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6B7CE8351
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 14:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svHgK-0003zo-30; Mon, 30 Sep 2024 10:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svHfz-0003mN-Vw
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 10:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1svHfw-0001Zy-U6
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 10:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727707618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=gYx1twiezc7BfiTK/utNYV0es8LDOUkB138p1q1rShw=;
 b=YedTixJ/MJwl6lRMZVMYnWnzg4LhJoCfqORJWYy0kyBSzc7aVfBJ5Y4bjsivgu8ACoPEmT
 8PacU1vcxui0N2dVzzyGs8fGlWQ72wZQG1TtT5VJYYYJi9OtNuAkqIB0Mt3RYCt/QJ4MN6
 oP0J2u4tgoTi/eU6hai3v08x0+MuOHU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-7O0trldlNAWVdO8pVP5mTw-1; Mon,
 30 Sep 2024 10:46:57 -0400
X-MC-Unique: 7O0trldlNAWVdO8pVP5mTw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CDE7193C538; Mon, 30 Sep 2024 14:46:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 617441955DC7; Mon, 30 Sep 2024 14:46:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8508F21E6A28; Mon, 30 Sep 2024 16:46:49 +0200 (CEST)
Resent-To: integration@gluster.org, devel@lists.libvirt.org,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 30 Sep 2024 16:46:49 +0200
Resent-Message-ID: <875xqdgpwm.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-block@nongnu.org,
 qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,
 devel@lists.libvirt.org,  integration@gluster.org,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2] docs: Mark "gluster" support in QEMU as deprecated
In-Reply-To: <Zvqe-Dyu8ma58Tef@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 30 Sep 2024 13:52:08 +0100")
References: <20240925071514.13728-1-thuth@redhat.com>
 <Zvqe-Dyu8ma58Tef@redhat.com>
Date: Mon, 30 Sep 2024 16:08:19 +0200
Message-ID: <87h69xi698.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Sep 25, 2024 at 09:15:14AM +0200, Thomas Huth wrote:
>> According to https://marc.info/?l=3Dfedora-devel-list&m=3D171934833215726
>> the GlusterFS development effectively ended. Thus mark it as deprecated
>> in QEMU, so we can remove it in a future release if the project does
>> not gain momentum again.
>>=20
>> Acked-by: Niels de Vos <ndevos@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2: Mark it as deprecated in the QAPI and print a warning once, too
>>=20
>>  docs/about/deprecated.rst | 9 +++++++++
>>  qapi/block-core.json      | 7 ++++++-
>>  block/gluster.c           | 2 ++
>>  3 files changed, 17 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index ed31d4b0b2..b231aa3948 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -395,6 +395,15 @@ Specifying the iSCSI password in plain text on the =
command line using the
>>  used instead, to refer to a ``--object secret...`` instance that provid=
es
>>  a password via a file, or encrypted.
>>=20=20
>> +``gluster`` backend (since 9.2)
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +According to https://marc.info/?l=3Dfedora-devel-list&m=3D1719348332157=
26
>> +the GlusterFS development effectively ended. Unless the development
>> +gains momentum again, the QEMU project might remove the gluster backend
>> +in a future release.
>
> I'd suggest the second half of the sentance can be simplified:
>
>    ", the QEMU project will remove the gluster backend/"
>
> since marking something as deprecated is a stronger than "might".
> We /will/ remove it, unless new informaton comes to light that
> makes us re-evaluate the plans.

Good point.


