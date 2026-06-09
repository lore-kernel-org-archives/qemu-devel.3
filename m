Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BF7CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWw4K-0006oT-Ki; Tue, 09 Jun 2026 09:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWw4I-0006nf-TS
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWw4H-0003My-4k
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781010031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qa3kg6Qn0oP2NKEwoI/RqLUviu1BICLhF65C5fCi0ug=;
 b=iBCkfoFeU+pjNbhbF4KrAQnDbGlynVRsZPC6xTr04KbZA1qsybgv/6kG8o6UGhVpEGOqe4
 wkRET7Y7FPvUwW24gjsP5k5YcwZIVZ/gAPEBpSOvNE59GgTxxWq/wEKjcCuNotFAzHbNNN
 WL+cIuL6ansFGyDxUVymauivNukoJi4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-jK3l5NxtMpCMKejnqahM9g-1; Tue,
 09 Jun 2026 09:00:26 -0400
X-MC-Unique: jK3l5NxtMpCMKejnqahM9g-1
X-Mimecast-MFC-AGG-ID: jK3l5NxtMpCMKejnqahM9g_1781010024
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 649C7195E90D; Tue,  9 Jun 2026 13:00:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99E0A1624; Tue,  9 Jun 2026 13:00:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3331921E6A01; Tue, 09 Jun 2026 15:00:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>,  amit@kernel.org,
 berrange@redhat.com,  eblake@redhat.com,  eduardo@habkost.net,
 lvivier@redhat.com,  marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com,  maxbr@linux.ibm.com,  noh4hss@gmail.com,
 pbonzini@redhat.com,  philmd@linaro.org,  qemu-devel@nongnu.org,
 wangyanan55@huawei.com,  zhao1.liu@intel.com
Subject: Re: [PATCH] qapi: drop "must exist" from ID descriptions for
 consistency
In-Reply-To: <20260609063539-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Tue, 9 Jun 2026 06:36:02 -0400")
References: <924c52d6089b3c0cfd3a235887579ae0322cffba.camel@gmail.com>
 <20260120081821.884342-1-filip.hejsek@gmail.com>
 <877bo8q9yc.fsf@pond.sub.org>
 <20260609063539-mutt-send-email-mst@kernel.org>
Date: Tue, 09 Jun 2026 15:00:21 +0200
Message-ID: <87ik7rq36i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, Jun 09, 2026 at 12:34:03PM +0200, Markus Armbruster wrote:
>> Uh, this fell through the cracks, possibly because it was buried within
>> a thread.
>> 
>> Filip Hejsek <filip.hejsek@gmail.com> writes:
>> 
>> > Make chardev ID param descriptions more consistend with ID descriptions
>> 
>> Typo: consistent
>> 
>> Not worth a respin.
>> 
>> > elsewhere.
>> > ---
>> >  qapi/char.json | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/qapi/char.json b/qapi/char.json
>> > index 140614f82c..fbac5a1cb7 100644
>> > --- a/qapi/char.json
>> > +++ b/qapi/char.json
>> > @@ -791,7 +791,7 @@
>> >  #
>> >  # Change a character device backend
>> >  #
>> > -# @id: the chardev's ID, must exist
>> > +# @id: the chardev's ID
>> >  #
>> >  # @backend: new backend type and parameters
>> >  #
>> > @@ -832,7 +832,7 @@
>> >  #
>> >  # Remove a character device backend
>> >  #
>> > -# @id: the chardev's ID, must exist and not be in use
>> > +# @id: the chardev's ID, must not be in use
>> >  #
>> >  # Since: 1.4
>> >  #
>> > @@ -849,7 +849,7 @@
>> >  #
>> >  # Send a break to a character device
>> >  #
>> > -# @id: the chardev's ID, must exist
>> > +# @id: the chardev's ID
>> >  #
>> >  # Since: 2.10
>> >  #
>> 
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> 
>> I can take this.
>
> maybe after it gets a signed off by tag from the author.

Oops, missed that!  Can't take it without.

Filip?


