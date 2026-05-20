Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBAACD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 05:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPZs2-0002rr-NN; Wed, 20 May 2026 01:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPZs1-0002rI-EQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 01:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPZrz-0003JI-V9
 for qemu-devel@nongnu.org; Wed, 20 May 2026 01:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779256407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SPHpvrQ4cv6UTnto2ldyo7kxCoK8YYRp6sYg+R8VQtw=;
 b=RPy2jDV2mkB26LmenejCtoAAv3Q7nOnl9XS7X4oBGwFUq3EEXQtgzM1LmaNHjQB9acZn/V
 DdjQ7Bl+yUIlMMenrOaslvWdftW+9psclpupCXeSxWdatBcTuJFwD0mZis12/8pY6qE++Y
 OeLBlAjcALMxYWgUs2YbVGvT+uotyak=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-vEYEilb3MomLPXSt0d7j1g-1; Wed,
 20 May 2026 01:53:25 -0400
X-MC-Unique: vEYEilb3MomLPXSt0d7j1g-1
X-Mimecast-MFC-AGG-ID: vEYEilb3MomLPXSt0d7j1g_1779256405
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D519E18002D6
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 05:53:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9482A30002DC
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 05:53:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3531D21E6A01; Wed, 20 May 2026 07:53:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: ybendito@redhat.com
Cc: qemu-devel@nongnu.org,  yvugenfi@redhat.com
Subject: Re: [PATCH] MAINTAINERS: update ebpf reviewers
In-Reply-To: <87pl8ph7bz.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 08 Dec 2025 06:26:56 +0100")
References: <20251206093345.71031-1-ybendito@redhat.com>
 <87pl8ph7bz.fsf@pond.sub.org>
Date: Wed, 20 May 2026 07:53:22 +0200
Message-ID: <87o6ia1val.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Looks like this fell through the cracks.  I'm picking it up.

Markus Armbruster <armbru@redhat.com> writes:

> ybendito@redhat.com writes:
>
>> From: Yuri Benditovich <ybendito@redhat.com>
>>
>> Signed-off-by: Yuri Benditovich <ybendito@redhat.com>
>> ---
>>  MAINTAINERS | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 63e9ba521b..1a4a698d78 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4385,8 +4385,7 @@ F: tests/functional/x86_64/test_vfio_user_client.py
>>  
>>  EBPF:
>>  M: Jason Wang <jasowang@redhat.com>
>> -R: Andrew Melnychenko <andrew@daynix.com>
>
> Not at Daynix anymore (e-mail bounces).
>
>> -R: Yuri Benditovich <yuri.benditovich@daynix.com>
>> +R: Yuri Benditovich <ybendito@redhat.com>
>>  S: Maintained
>>  F: docs/devel/ebpf_rss.rst
>>  F: ebpf/*
>
> Acked-by: Markus Armbruster <armbru@redhat.com>


