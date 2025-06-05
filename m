Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8F0C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 06:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN3sm-0002AS-2W; Thu, 05 Jun 2025 02:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uN3sc-000271-S1
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 02:15:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uN3sW-0006bt-M1
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 02:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749104102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tvDqb7b+GASIgWQw0Bv2dNLd5laAlpyt2nE6+HcEUZE=;
 b=al8RSCqiVRycTbBq1sKDRuw5cEAx7WMzDPIl15TJs8dBKKkMQEUkMgNdTsaWNTy4iuhcHQ
 SrqrcQTOm+rZqO2ycHH3d6I+zs0CtCCzhXWEeb8ZnBsPPbQgP4d5Y7WFDAlLvaNL/fVntf
 EosvFUg88yfVWQs+M6wx8v+Fk5O9HAU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-fo1DTLRpNmCW-r0ckVIM7A-1; Thu,
 05 Jun 2025 02:15:01 -0400
X-MC-Unique: fo1DTLRpNmCW-r0ckVIM7A-1
X-Mimecast-MFC-AGG-ID: fo1DTLRpNmCW-r0ckVIM7A_1749104100
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8C6C19560B7; Thu,  5 Jun 2025 06:14:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0958B30002C0; Thu,  5 Jun 2025 06:14:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 55C6A21E6757; Thu, 05 Jun 2025 08:14:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,  qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [PATCH 06/14] rust: qemu-api: add bindings to Error
In-Reply-To: <97b16175-8d2f-41f9-b305-a532acbad095@redhat.com> (Paolo
 Bonzini's message of "Wed, 4 Jun 2025 21:19:32 +0200")
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <20250530080307.2055502-7-pbonzini@redhat.com>
 <877c1uffj3.fsf@pond.sub.org> <aD7AbxghCc5VYDhu@intel.com>
 <8734ch5d5c.fsf@pond.sub.org>
 <2b7be73c-d91f-4820-a8ad-6964a8331150@redhat.com>
 <871ps02j8u.fsf@pond.sub.org>
 <97b16175-8d2f-41f9-b305-a532acbad095@redhat.com>
Date: Thu, 05 Jun 2025 08:14:56 +0200
Message-ID: <875xhaogtb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 6/4/25 07:01, Markus Armbruster wrote:
>> This is what your FOO_or_propagate() functions are for.
>> 
>> The rule glosses over a subtle detail: the difference between
>> error_setg() and error_propagate() isn't just create a new error vs. use
>> an existing one, namely error_setg() makes the precondition violation
>> mentioned above a programming error, whereas error_propagate() does not,
>> it instead *ignores* the error it's supposed to propagate.
>> 
>> I consider this difference a design mistake.  Note that GError avoids
>> this mistake: g_error_propagate() requieres the destination to NULL or
>> point to NULL.  We deviated from GError, because we thought we were
>> smarter.  We weren't.
>> 
>> Mostly harmless in practice, as behavior is identical for callers that
>> satisfy the preconditions.
>> 
>> [...]
>> 
>> So here's the bottom line.  We want a Rust function to use C Error
>> according to its written rules.  Due to a design mistake, C functions
>> can behave in two different ways when their caller violates a certain
>> precondition, depending on how the function transmits the error to the
>> caller.  For Rust functions, we can
>> 
>> * Always behave the more common way, i.e. like a C function using
>>   error_setg() to transmit.
>> 
>> * Always behave the less common way, i.e. like a C function using
>>   error_propagate() to transmit.
>> 
>> * Sometimes one way, sometimes the other way.
>> 
>> This is actually in order of decreasing personal preference.  But what
>> do *you* think?
>>
> I agree that there are arguments for both.  The reason to use 
> error_setg() is that, even though these functions "propagate" a 
> qemu_api::Error into a C Error**, the error is born in the Rust callback 
> and therefore there is no error_setg() anywhere that could check for 
> non-NULL abort().  There is a bigger risk of triggering 
> error_propagate()'s weird behavior.

Yes.

> The reason to use error_propagate() is that these functions do look a 
> lot more like error_propagate() than error_setg().

True.

>                                                     I'm undecided.  I 
> think I'll keep the error_setg() semantics, which is essentially
>
>      assert_eq!(unsafe { *errp }, ptr::null_mut());
>
> followed by calling bindings::error_propagate().

Works for me.

The error_propagate() then does nothing but call error_handle().
However, error_handle() is static, and making it available for Rust
just to cut out a harmless middleman seems hardly worth the bother.


