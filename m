Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319E9EF99E1
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 07:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr9qH-000706-Ij; Sat, 14 Feb 2026 02:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vr9qD-0006xD-J9
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 02:13:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vr9qA-0006oC-M2
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 02:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771053196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ow9qdTqZwoVKoKneR4pw+4WOwZI124LavN+svvpxnE=;
 b=FarMFlCIN3i2mQNe2jxWwdBFp1aXmvcDd70ol89+nX6rUEk3tlwZezmCSRPpnMthE1Ohi0
 +tbBGAALiovKryQp/pQTGpMAg9CR4lmuaO10Awm44/Q9XbQvLiv1AdI8TR8qUeX92HjpUX
 FIOEQZpK4U5gyrgWcBpFJidhHV0dyj8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-YE15bMDMNACBiEc1H75CXA-1; Sat,
 14 Feb 2026 02:13:12 -0500
X-MC-Unique: YE15bMDMNACBiEc1H75CXA-1
X-Mimecast-MFC-AGG-ID: YE15bMDMNACBiEc1H75CXA_1771053191
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03EE21956048; Sat, 14 Feb 2026 07:13:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BAC630001B9; Sat, 14 Feb 2026 07:13:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B4B1F21E692D; Sat, 14 Feb 2026 08:13:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eduardo@habkost.net,
 berrange@redhat.com,  pbonzini@redhat.com,  eblake@redhat.com,
 devel@lists.libvirt.org,  hreitz@redhat.com,  kwolf@redhat.com
Subject: Re: [PATCH v11 8/8] deprecate names duplication between qdev,
 block-node and block-export
In-Reply-To: <74b1555d-1e4f-4be2-85e4-902f9670e435@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 5 Feb 2026 10:32:54 +0300")
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
 <20260122160113.1147745-1-vsementsov@yandex-team.ru>
 <87qzr0y990.fsf@pond.sub.org>
 <74b1555d-1e4f-4be2-85e4-902f9670e435@yandex-team.ru>
Date: Sat, 14 Feb 2026 08:13:07 +0100
Message-ID: <877bsf23y4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 04.02.26 15:38, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> Now we have blockdev-replace QMP command, which depend on a possibility
>>> to select any block parent (block node, block export, or qdev) by one
>>> unique name. The command fails, if name is ambiguous (i.e., match
>>> several parents of different types). In future we want to rid of this
>>> ambiguity.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> 
>> We have numerous kinds of IDs, i.e. names chosen by the user than need
>> to be unique, but only among the same kind.  For instance, you can't
>> name two block nodes "foo", but you can name a block node, a block
>> export, a qdev, and a network backend "foo".  Using the same ID for
>> multiple things is of course a bad idea.  Permitting it was also a bad
>> idea.
>> 
>> Your patch rectifies this design mistake, but only partially.  Consider:
>> 
>> * IDs need to be unique with their kind.  This is what we have now.  I
>>   don't like it.
>> 
>> * IDs need to be unique among their kind and possibly some set of
>>    additional kinds.  This is where your patch takes us.  I like it even
>>   less, to be honest.
>> 
>> * IDs need to be unique, period.  This is what I'd like to have.
>
> I like it. Is it enough to write it so simple in deprecation doc? Or should
> we still list all such ids we have in QEMU?
>
> It may be something like:
>
> Any kind of IDs you use to reference objects in QEMU must be unique, any
> used ID must reference exactly one object. This includes, but is not limited
> to qdev full and relative to "/peripheral/" paths, block-node and block-export
> names.

This would serve as a declaration of intent.  Better than nothing, I
guess.

To enforce uniqueness, we'll have to create a single table of IDs.

If we make it a set, we can reject duplicate IDs, but can't point to the
other ID.  Meh.

If we make it map to the kind of ID, we can report the kind.  Something
like "block node name 'foo' clashes with block export ID 'foo'".  Feels
adequate.

If we make it map the the object the ID identifies, we can get rid of
existing means to map from ID to object.  May or may not be worthwhile.

If we create the single table of IDs now rather than later, we can warn.
Something like "duplicate IDs are deprecated: block node name 'foo'
clashes with block export ID 'foo'".  Much more likely to get users'
attention than a note in docs/about/deprecated.rst.

We could even wire it to the "-compat deprecated-input=..." machinery
(I'd assist with that).  This would let people test their software is
ready for enforced unique IDs.

Thoughts?


