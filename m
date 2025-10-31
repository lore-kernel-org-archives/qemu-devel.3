Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0951FCCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnbP-0004Yt-M2; Fri, 31 Oct 2025 07:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEnbK-0004Rg-Ai
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEnb5-00052Q-DA
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761911217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5BitX2VwYZW8bnJ43kgA0NdqfYJ59+wwkuTDaPgyvo=;
 b=ML7YsiVRgbVvtpxCO2/To6JU09qRJVx5QQkypIXkfHAgGwq3RT2OjtKUOzhVYf56zzqs/Z
 5teCWkKZvlmp7Ow2EnAU6yCaWRDt2qHIBiOHID7zRKMA2MwUxSLtz0Opy/HHwz3u/N2U68
 pBhEH1HTfcie15NahvxUR6S4OM9TD5s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-fCWRxk8qPj-sLexkBXxrqw-1; Fri,
 31 Oct 2025 07:46:56 -0400
X-MC-Unique: fCWRxk8qPj-sLexkBXxrqw-1
X-Mimecast-MFC-AGG-ID: fCWRxk8qPj-sLexkBXxrqw_1761911215
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C29DB180899E; Fri, 31 Oct 2025 11:46:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4983A1955BE3; Fri, 31 Oct 2025 11:46:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9ED9021E6A27; Fri, 31 Oct 2025 12:46:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 jsnow@redhat.com,  eblake@redhat.com,  thuth@redhat.com,
 berrange@redhat.com,  philmd@linaro.org,  kchamart@redhat.com,
 mst@redhat.com,  sgarzare@redhat.com
Subject: Re: [PATCH 1/8] qapi/audio: Fix description markup of
 AudiodevDBusOptions @nsamples
In-Reply-To: <1313b150-57dc-4bd2-a593-63529e0026b0@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 31 Oct 2025 12:53:31 +0300")
References: <20251031094751.2817932-1-armbru@redhat.com>
 <20251031094751.2817932-2-armbru@redhat.com>
 <1313b150-57dc-4bd2-a593-63529e0026b0@yandex-team.ru>
Date: Fri, 31 Oct 2025 12:46:52 +0100
Message-ID: <87tszf8f9v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
>> The description of Member @nsamples is indented incorrectly.  Comes
>> out like
>>
>>      Members:
>>              [...]
>> 	         nsamples (int, optional) =E2=80=93 set the number of samples p=
er read/write calls (default to 480,
>>      10ms at 48kHz).
>>
>> Fixing the indentation makes it come out like
>>
>>      Members:
>>              [...]
>> 	        nsamples (int, optional) =E2=80=93 set the number of samples pe=
r read/write calls (default to 480, 10ms at 48kHz).
>>=20
>
> I'm not sure this example worth breaking recommendation to
> " not use lines that are longer than 76 characters in your commit message=
" :)

Accident, will tidy up.

>> Fixes: 19c628f2f579 (dbus: add -audio dbus nsamples option)
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks!


