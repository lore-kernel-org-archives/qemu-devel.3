Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88B1C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 13:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQI1-0002xM-6v; Thu, 16 Jan 2025 08:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tYQHz-0002xD-FR
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 08:52:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tYQHx-0005R0-L4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 08:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737035519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HMunkvTO89VB7Bvhrswi7o7unEHaMY+89+Ho3fof3Jk=;
 b=K5BRlv9VQPBDskMp5d9R0eeXD0PI4WCLbMD0EP1IJFrLAzjFQ1wfJdSU3sLNFGWEhnYyRe
 DoR5+mbAonHOvQwFbcDpiXy8cp2H6GI4xKeOQcRoho3CdAXH7EoSFlhzAOdGXFBn0xrKp+
 hsRyl8DQeiCSaSmRm8GnEtG8RAoLYFA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-zp7gypMwOoOeSWweuYcAow-1; Thu,
 16 Jan 2025 08:51:57 -0500
X-MC-Unique: zp7gypMwOoOeSWweuYcAow-1
X-Mimecast-MFC-AGG-ID: zp7gypMwOoOeSWweuYcAow
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D25F41955F36; Thu, 16 Jan 2025 13:51:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94C56195E3E0; Thu, 16 Jan 2025 13:51:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 72EE821E6924; Thu, 16 Jan 2025 14:51:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Boyang <zhangboyang.id@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] qapi/ui: Fix documentation of upper bound value in
 InputMoveEvent
In-Reply-To: <c4f521f8-f29b-4634-9216-e8d922a521b0@gmail.com> (Zhang Boyang's
 message of "Thu, 16 Jan 2025 20:43:18 +0800")
References: <20250116104433.12114-1-zhangboyang.id@gmail.com>
 <87ed136ifc.fsf@pond.sub.org>
 <c4f521f8-f29b-4634-9216-e8d922a521b0@gmail.com>
Date: Thu, 16 Jan 2025 14:51:49 +0100
Message-ID: <87tt9yzx1m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Zhang Boyang <zhangboyang.id@gmail.com> writes:

> On 2025/1/16 20:40, Markus Armbruster wrote:
>> Zhang Boyang <zhangboyang.id@gmail.com> writes:
>> 
>>> The upper bound of pointer position in InputMoveEvent should be 0x7fff,
>>> according to INPUT_EVENT_ABS_MAX.
>>>
>>> Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
>>> ---
>>>   qapi/ui.json | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/ui.json b/qapi/ui.json
>>> index 460a26b981..7b18662018 100644
>>> --- a/qapi/ui.json
>>> +++ b/qapi/ui.json
>>> @@ -1133,7 +1133,7 @@
>>>   # @axis: Which axis is referenced by @value.
>>>   #
>>>   # @value: Pointer position.  For absolute coordinates the valid range
>>> -#     is 0 -> 0x7ffff
>>> +#     is 0 -> 0x7fff
>>
>> Opportunity to replace "->" by "to" or "..".  If you agree, I'll squash
>> that into your patch in my tree.
>> 
>
> OK, Thank you :)
>
> Zhang Boyang

Queued.  Thanks!

[...]


