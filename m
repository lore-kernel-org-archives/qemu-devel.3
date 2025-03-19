Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CD5C35FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 19:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuzPf-0002ME-M6; Wed, 19 Mar 2025 15:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuzPe-0002M4-GO
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuzPc-0003iX-Ch
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742413750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/cyJl0P2fc/mgjCN5U/sueuTIaBJ0H9SccPwu+BAhmk=;
 b=WVEHIUn3suKCacve7x3QkI4cTSzf48gL02QiER82cf5n52c2KD4R5cgZOV/GbfZYL5Iot0
 9abB/Pb0cGlEQ4P5rL8AUrRW40Wdz/ZgA03U3ZLpyoq6xiFkV4lLytBnHMNK8KsBE0FNE1
 IjKiYYjd9quqAhvBe3BA3PDyxHzTad4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-LSCc5HrkP_-oOWvTuyN1mA-1; Wed,
 19 Mar 2025 15:49:07 -0400
X-MC-Unique: LSCc5HrkP_-oOWvTuyN1mA-1
X-Mimecast-MFC-AGG-ID: LSCc5HrkP_-oOWvTuyN1mA_1742413746
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FC31180AF53; Wed, 19 Mar 2025 19:49:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C622D19560AD; Wed, 19 Mar 2025 19:49:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E2C7D21E66C4; Wed, 19 Mar 2025 20:49:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Corey Minyard <corey@minyard.net>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] cleanup: Drop pointless label at end of function
In-Reply-To: <Z9seHbw1IepwkppI@mail.minyard.net> (Corey Minyard's message of
 "Wed, 19 Mar 2025 14:42:21 -0500")
References: <20250319152126.3472290-1-armbru@redhat.com>
 <20250319152126.3472290-4-armbru@redhat.com>
 <CAB9gMfrxe7NWk_1GkudEeWby-ZHaH1xTWD5n7WfK7iz4qKsL6g@mail.gmail.com>
 <87o6xwkerz.fsf@pond.sub.org> <Z9seHbw1IepwkppI@mail.minyard.net>
Date: Wed, 19 Mar 2025 20:49:01 +0100
Message-ID: <871puskdhu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Corey Minyard <corey@minyard.net> writes:

> On Wed, Mar 19, 2025 at 08:21:20PM +0100, Markus Armbruster wrote:
>> Corey Minyard <corey@minyard.net> writes:
>> 
>> > Is this official coding style?  I'm not a big fan of having return
>> > statements in the middle of functions, I generally only put them at
>> > the beginning or the end.
>> 
>> There's nothing in docs/devel/style.rst.
>> 
>> I count more than 42,000 return statements with indentation > 4.  These
>> are either within some block, or incorrectly indented.  I'd bet my own
>> money that it's the former for pretty much all of them.
>> 
>> I count less than 130 labels right before a return statement at end of a
>> function.
>> 
>> Based on that, I'd say return in the middle of function is
>> overwhelmingly common in our code.
>> 
>
> Ok.  It's not a huge deal to me.  I think it's more dangerous to
> have returns in the middle; they are easy to miss and an "out:" at the
> end make it more clear there are returns in the middle.  But that's
> just my opinion.  To make wholesale changes like this I would prefer
> it be in the style guide.  But, I don't want to start a holy war,
> either.  Sigh.
>
> I mean, just a "return;" at the end of a function, yes, that's a
> no-brainer, get rid of it.  But that's not what the ones in the IPMI
> device are.

Well, you're the maintainer there.  If you'd like me to drop the five
cases where return is directly after a label (all in hw/ipmi), I can do
that for the low, low price of a "yes, please!"


