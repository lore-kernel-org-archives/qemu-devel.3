Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE17C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rolQy-0001rH-IY; Mon, 25 Mar 2024 10:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rolQx-0001r6-Ex
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rolQu-0001Dh-4B
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711377374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3VGA/bR3aXJHRMJ/nkn5rB8XIdRj/r5BMXxKU5Ytups=;
 b=bpkCzzVthGGqupM6h/udGUcgj2cpqwSfXn4t53o53kKZ4Wr6RxtSXRd81+Z4OUDq/jDaIB
 KMpRWJ6ta+CIWHMjou+XHOhxlG55lnwOJkItOYlWum8gozQ3rJ8dDx2+iNTuDKcVBChhet
 Z0A4VkEyhycs7xNgxHDUCwsM7SxVOZ8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-GuInwoWXNJmf03hnE5MC_w-1; Mon,
 25 Mar 2024 10:36:10 -0400
X-MC-Unique: GuInwoWXNJmf03hnE5MC_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 941C71C02164;
 Mon, 25 Mar 2024 14:36:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11355C017A8;
 Mon, 25 Mar 2024 14:36:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0A83621E6806; Mon, 25 Mar 2024 15:36:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Kevin Wolf <kwolf@redhat.com>,  Hanna
 Czenczek <hreitz@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,
 Paolo Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: Let's close member documentation gaps
In-Reply-To: <1dba9f83-4e2e-451f-8523-c19340b6fdcf@redhat.com> (David
 Hildenbrand's message of "Mon, 25 Mar 2024 15:14:31 +0100")
References: <87il1aodow.fsf@pond.sub.org>
 <f72122ed-1611-445a-a281-1d52587c7eae@redhat.com>
 <1dba9f83-4e2e-451f-8523-c19340b6fdcf@redhat.com>
Date: Mon, 25 Mar 2024 15:36:05 +0100
Message-ID: <87zfumjs4q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

David Hildenbrand <david@redhat.com> writes:

> On 25.03.24 15:13, David Hildenbrand wrote:
>> On 25.03.24 10:36, Markus Armbruster wrote:
>>> If you're cc'ed, I have a bit of doc work for you.  Search for your
>>> name to find it.
>>>
>>> The QAPI generator forces you to document your stuff.  Except for
>>> commands, events, enum and object types listed in pragma
>>> documentation-exceptions, the generator silently defaults missing
>>> documentation to "Not documented".  Right now, we're using this loophole
>>> some 500 times.
>>>
>> What would be the right step to make sure I am resolving these "hidden"
>> issues, and that the QAPI generator would be happy with my changes?
>
> Ah, I assume simply removing the offender from "qapi/pragma.json" and then compiling.

Correct!


