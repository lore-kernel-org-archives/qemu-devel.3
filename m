Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED44CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKsw2-0007zf-UY; Thu, 07 May 2026 03:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKsvx-0007zQ-Oc
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:14:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKsvw-0001mX-9n
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778138047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2b3wuMOxv7vtCAws0AOM88GEwUXuYD8/HprU4NQ3u4g=;
 b=dUWllCxK4QlO6xYcRNOS1VrPds6tQw9N95oYKIxjiGEeyrnBolAhnz7BK/EOWLUPewUTeO
 ysVjMHVLwzQ3IVuIc+05yUxQpx7uiJWdue1LSUdjfjHEDfRGXU68DhooFz0ymecey+O0uF
 ywyXMakKlWShma7n6EGOopaz22jJ7Lo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-gOVJFhYIOpyny545t9zMOA-1; Thu,
 07 May 2026 03:14:06 -0400
X-MC-Unique: gOVJFhYIOpyny545t9zMOA-1
X-Mimecast-MFC-AGG-ID: gOVJFhYIOpyny545t9zMOA_1778138045
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2A7B1956094; Thu,  7 May 2026 07:14:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EA7C19560A2; Thu,  7 May 2026 07:14:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EAF3521E6A01; Thu, 07 May 2026 09:14:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  jasowang@redhat.com,  lvivier@redhat.com,
 sbrivio@redhat.com,  samuel.thibault@ens-lyon.org
Subject: Re: [PATCH 2/4] qapi/net: Wean passt off QAPI type String to
 improve documentation
In-Reply-To: <177813267024.2413233.14832448496963067376.b4-review@b4>
 (marcandre lureau's message of "Thu, 07 May 2026 09:44:30 +0400")
References: <20260506105421.2461117-1-armbru@redhat.com>
 <20260506105421.2461117-3-armbru@redhat.com>
 <177813267024.2413233.14832448496963067376.b4-review@b4>
Date: Thu, 07 May 2026 09:14:01 +0200
Message-ID: <87pl37elom.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

marcandre.lureau@redhat.com writes:

> On Wed, 06 May 2026 12:54:19 +0200, Markus Armbruster <armbru@redhat.com> wrote:
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 8ed51b665cd..45ee7ac7ffc 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -114,6 +114,41 @@
>>    'data': {
>>      'str': 'str' } }
>>  
>> +##
>> +# @PasstSearch:
>> +#
>> +# @str: DNS domain name suffix for host name lookup, or "none".  See
>> +#     passt(1) option --search.
>> +#
>> +# Since: 1.2
>
> Since 10.1

Yes.  I score 2 of 3 points.

Thank you!


