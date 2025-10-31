Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DEECCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnZi-0003WX-VP; Fri, 31 Oct 2025 07:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEnZe-0003Vx-GK
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEnZX-0004iE-PW
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761911126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pasaoZSIBQW5JTOJTdPkATiFhLGMSAynAffcEhqPWto=;
 b=KwITOxmjqKVadFcUFwCv0/aSAt/yuNPxCR//9dYQS7lwtvyGDEGeJ3+njywpIVhVZtsWS2
 02gtDbt1pu2cNTV7d7yx2CI91MyF1+zLgbWLkSeidnpQDZwsc0q/DCqi5mqc+wzYqRp+Lo
 TLLSsUKuuZfycrxxrnGv7Y5FZEuP/Qk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-QqmBNue_MTO3M-njY8BpBw-1; Fri,
 31 Oct 2025 07:45:23 -0400
X-MC-Unique: QqmBNue_MTO3M-njY8BpBw-1
X-Mimecast-MFC-AGG-ID: QqmBNue_MTO3M-njY8BpBw_1761911122
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 355371805C11; Fri, 31 Oct 2025 11:45:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A567C19560A2; Fri, 31 Oct 2025 11:45:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1B73C21E6A27; Fri, 31 Oct 2025 12:45:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  jsnow@redhat.com,  eblake@redhat.com,
 thuth@redhat.com,  berrange@redhat.com,  philmd@linaro.org,
 kchamart@redhat.com,  mst@redhat.com,  sgarzare@redhat.com
Subject: Re: [PATCH 8/8] docs/interop: Add test to keep vhost-user.json sane
In-Reply-To: <4d7c7507-970b-4eb2-8817-f18fd3693a73@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 31 Oct 2025 13:53:21 +0300")
References: <20251031094751.2817932-1-armbru@redhat.com>
 <20251031094751.2817932-9-armbru@redhat.com>
 <4d7c7507-970b-4eb2-8817-f18fd3693a73@yandex-team.ru>
Date: Fri, 31 Oct 2025 12:45:19 +0100
Message-ID: <87y0or8fcg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 31.10.25 12:47, Markus Armbruster wrote:
>> We did this for firmware.json in commit d4181658dfb (docs: add test
>> for firmware.json QAPI).
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   docs/meson.build | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>> diff --git a/docs/meson.build b/docs/meson.build
>> index 3676f81c4d..7e54b01e6a 100644
>> --- a/docs/meson.build
>> +++ b/docs/meson.build
>> @@ -99,7 +99,12 @@ if build_docs
>>    alias_target('man', sphinxmans)
>>  endif
>> -test('QAPI firmware.json regression tests', qapi_gen,
>> -     args: ['-o', meson.current_build_dir() / 'qapi',
>> +test('QAPI firmware.json regression test', qapi_gen,
>> +     args: ['-o', meson.current_build_dir() / 'qapi-firmware',
>>              meson.current_source_dir() / 'interop/firmware.json'],
>>       suite: ['qapi-schema', 'qapi-interop'])
>> +
>> +test('QAPI vhost-user.json regression test', qapi_gen,
>> +     args: ['-o', meson.current_build_dir() / 'qapi-vhost-user',
>> +            meson.current_source_dir() / 'interop/vhost-user.json'],
>> +     suite: ['qapi-schema', 'qapi-interop'])
>
> Hmm, if we have more .json files in docs, we'll need some more
> convenient and safe way to cover them all.

Yes.  But so far it's just these two, and they're from 2018 and 2019.

> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks!


