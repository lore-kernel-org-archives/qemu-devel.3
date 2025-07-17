Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228CEC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLTr-0002XQ-BK; Thu, 17 Jul 2025 06:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucLTo-0002IH-Aw
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucLTl-0005go-6w
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752746678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KpKvPUOPJzeK0RYyhaYtz/Zt9bRWzjzVaa0I11VTKA0=;
 b=chSAS3evpPZsjRt+wNDB69y867n4frPSTbW1mWptXv1eYYDnIyk+Lf5UtvivI279EktAbe
 sRaetuXS9A5GYgmJE86zBZSfw0qkSAIXNRnJQ5x2k26rXF8tKwnOlg0ZqL1lRp1NI/5/je
 XRPbembOIWrvwvUNfNTGFhIyrurdax8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-Qi9t1MP2Oqm9ViLVbrCv2Q-1; Thu,
 17 Jul 2025 06:04:35 -0400
X-MC-Unique: Qi9t1MP2Oqm9ViLVbrCv2Q-1
X-Mimecast-MFC-AGG-ID: Qi9t1MP2Oqm9ViLVbrCv2Q_1752746674
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A32C19560B0; Thu, 17 Jul 2025 10:04:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1653B18003FC; Thu, 17 Jul 2025 10:04:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 85D5521E6A27; Thu, 17 Jul 2025 12:04:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  eblake@redhat.com,  michael.roth@amd.com,
 kkostiuk@redhat.com,  jsnow@redhat.com
Subject: Re: [PATCH 4/4] qga: Add cross-references
In-Reply-To: <aHi053WApxOX3XkY@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 17 Jul 2025 09:31:35 +0100")
References: <20250717082117.3767754-1-armbru@redhat.com>
 <20250717082117.3767754-5-armbru@redhat.com>
 <aHi053WApxOX3XkY@redhat.com>
Date: Thu, 17 Jul 2025 12:04:31 +0200
Message-ID: <87ikjrkua8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jul 17, 2025 at 10:21:17AM +0200, Markus Armbruster wrote:
>> Enclose command and type names in `backquotes`, so they become links
>> in generated HTML.
>>=20
>> We did this for qapi/ in merge commit 504632dcc631.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qga/qapi-schema.json | 50 ++++++++++++++++++++++----------------------
>>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
>> @@ -585,7 +585,7 @@
>>  # - pm-utils (via pm-hibernate)
>>  # - manual write into sysfs
>>  #
>> -# IMPORTANT: guest-suspend-ram requires working wakeup support in
>> +# IMPORTANT: `guest-suspend-ram` requires working wakeup support in
>>  # QEMU. You should check QMP command query-current-machine returns
>>  # wakeup-suspend-support: true before issuing this command.  Failure
>
> I presume you're not updating 'query-current-machine' and
> 'wakeup-suspend-support' due to an inability do cross references
> across the two QAPI schemas ?

I'm not updating them because I missed them!

Putting query-current-machine in backquotes just works.  There are a few
more.  I'll respin.

I don't know how to reference a member of a type from outside the type.
Left for later.

Thanks!


