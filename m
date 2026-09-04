Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41839C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Pie-0007i8-Dq; Fri, 04 Sep 2026 04:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2Pic-0007hb-Hy
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2Pib-0007v1-1a
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788512176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MQCXbWd/zqlulyBo0tQVR5Z4BjsuzdsGVVJ1mKzCz8k=;
 b=CMNPXxDXIyugxX1afxdT0/+VBLN27U7w2377Flksn9VfNMMKvPvdmP+QUUcakwtIM7JAHD
 eaA1KKm2Moot2J9gti2iDbNT4ApoBpUlTVuMrAhqkqGjaVDD72IYoMRVowTyiM6YKqWczG
 0YA6x4lZgEItmc4u7bk0hpf+6lgV1M8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-iTd7stNIP2aQio8y3hWkIQ-1; Fri,
 04 Sep 2026 04:56:13 -0400
X-MC-Unique: iTd7stNIP2aQio8y3hWkIQ-1
X-Mimecast-MFC-AGG-ID: iTd7stNIP2aQio8y3hWkIQ_1788512172
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F182B1802173; Fri,  4 Sep 2026 08:56:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DDDB3000223; Fri,  4 Sep 2026 08:56:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DC3F821E6A04; Fri, 04 Sep 2026 10:56:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Chao Liu
 <chao.liu@processmission.com>
Subject: Re: [PATCH 01/18] checkpatch: Fix checking of newlines in error
 messages
In-Reply-To: <apm10EPO4vYlZLQZ@x1.local> (Peter Xu's message of "Thu, 3 Sep
 2026 14:00:48 -0400")
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-2-farosas@suse.de> <apmwZbSLZ46yvGmT@x1.local>
 <87bjae8bya.fsf@suse.de> <apm10EPO4vYlZLQZ@x1.local>
Date: Fri, 04 Sep 2026 10:56:08 +0200
Message-ID: <87fqzp9yzb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Sep 03, 2026 at 02:46:37PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Wed, Sep 02, 2026 at 07:15:29PM -0300, Fabiano Rosas wrote:
>> >> Using newlines in the g_test_message is fine. It automatically adds
>> >> the '#' required by the TAP protocol to the start of each line.
>> >
>> > IIUC we have such check not because TAP, but because all these functions
>> > will append one newline at the end, hence it's not needed.  IOW, if it
>> > applies to g_test_message(), I don't see why it doesn't apply to the rest.
>> > But maybe there're other reasons?
>> >
>> > To make it simpler, maybe we just call a few times g_test_message()?
>> >
>> 
>> Not sure I understand your point, Peter. I want to be able to print nice
>> messages in patch 9:
>> 
>>  g_test_message("expected vs. found:\n\n%s\n---\n%s:%s", str, t2[match], t2[match + 1]);
>> 
>>  # HMP output mismatch for entry at line 55:
>>  # expected vs. found:
>>  #
>>  # max-bandwidth: 10356305952768 bytes/hour
>>  # ---
>>  # max-bandwidth: 10356305952768 bytes/second
>> 
>> What would be the issue of having newlines here?
>
> No issue here that I can see.  My question was, why you moved
> g_test_message() out only, but not all?
>
> My gut feeling is we check this because people forget that all these
> functions includes a newline.
>
> So if your point stands here that "newlines can be in the middle", they
> should apply to all, not one.

I'm not sure I understand you correctly.  If you suggest to permit
newlines in the middle of error_setg(), error_report() & friends, I
disagree.  qapi/error.h:

 * The resulting message should be a single phrase, with no newline or
 * trailing punctuation.

If you want to provide additional information, use error_append_hint() /
error_printf().

> But still, I also don't see why we can't invoke g_test_message() a few
> times here too, if we want to avoid any global touch like this to land the
> whole thing faster..


