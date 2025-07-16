Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC84AC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzjh-00046M-J8; Wed, 16 Jul 2025 06:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubzhG-0007bo-4a
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubzhB-0001GU-BA
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSutu/xdnwXZKXQYz8tfD7LlPU/g8isicfSZg2E2jVc=;
 b=AJfqW1izPazhWVGnawJh62jOJZyD+9M5g3J3y0sNASBYBx9oXTJVv6hirJhiskVWdPcs0R
 kJmz13SXDxtjaeB3/kzNO87TGvgfNpb1abofSZ38Ft4EYOaNLzhDeo7R45bzHvSVYuv0JM
 k7eY4X5h+NtA7KHHgPYkvdWPVQOiZFQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-N2LAGAMrOZi_FflyNVVsbg-1; Wed,
 16 Jul 2025 06:49:00 -0400
X-MC-Unique: N2LAGAMrOZi_FflyNVVsbg-1
X-Mimecast-MFC-AGG-ID: N2LAGAMrOZi_FflyNVVsbg_1752662939
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 846961800359; Wed, 16 Jul 2025 10:48:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5D7818016F9; Wed, 16 Jul 2025 10:48:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 620B221E6A27; Wed, 16 Jul 2025 12:48:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,  Fam
 Zheng <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Stefan
 Weil <sw@weilnetz.de>,  qemu-block@nongnu.org
Subject: Re: [RFC PATCH 2/2] system/os-win32: Remove unused Error** argument
 in qemu_socket_select
In-Reply-To: <aHYXqRUPOVbyw0mN@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 15 Jul 2025 09:56:09 +0100")
References: <20250715083517.47556-1-philmd@linaro.org>
 <20250715083517.47556-3-philmd@linaro.org>
 <aHYXqRUPOVbyw0mN@redhat.com>
Date: Wed, 16 Jul 2025 12:48:55 +0200
Message-ID: <87o6tktnqg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jul 15, 2025 at 10:35:17AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> @errp is always NULL. Remove it, as unused.
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>  include/system/os-win32.h |  2 +-
>>  util/aio-win32.c          |  2 +-
>>  util/oslib-win32.c        | 13 +++++--------
>>  3 files changed, 7 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
>> index 40712a948c3..47882bc2f49 100644
>> --- a/include/system/os-win32.h
>> +++ b/include/system/os-win32.h
>> @@ -170,7 +170,7 @@ static inline void qemu_funlockfile(FILE *f)
>>=20=20
>>  /* Helper for WSAEventSelect, to report errors */
>>  bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
>> -                        long lNetworkEvents, Error **errp);
>> +                        long lNetworkEvents);
>>=20=20
>>  bool qemu_socket_unselect(int sockfd);
>>=20=20
>> diff --git a/util/aio-win32.c b/util/aio-win32.c
>> index 6583d5c5f31..9c2f0fb86e7 100644
>> --- a/util/aio-win32.c
>> +++ b/util/aio-win32.c
>> @@ -121,7 +121,7 @@ void aio_set_fd_handler(AioContext *ctx,
>>=20=20
>>          QLIST_INSERT_HEAD_RCU(&ctx->aio_handlers, node, node);
>>          event =3D event_notifier_get_handle(&ctx->notifier);
>> -        qemu_socket_select(fd, event, bitmask, NULL);
>> +        qemu_socket_select(fd, event, bitmask);
>
> This should likely be &error_abort, as we never expect this
> to fail AFAICT.
>
>
>> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
>> index 7ac3482d449..fed5ab14efb 100644
>> --- a/util/oslib-win32.c
>> +++ b/util/oslib-win32.c
>> @@ -292,21 +292,18 @@ char *qemu_get_pid_name(pid_t pid)
>>=20=20
>>=20=20
>>  bool qemu_socket_select(int sockfd, WSAEVENT hEventObject,
>> -                        long lNetworkEvents, Error **errp)
>> +                        long lNetworkEvents)
>>  {
>>      SOCKET s =3D _get_osfhandle(sockfd);
>>=20=20
>> -    if (errp =3D=3D NULL) {
>> -        errp =3D &error_warn;
>> -    }
>
> This pre-existing code should never have existed - the caller should
> have decided this reporting policy by passing in &error_warn.

Yes.

A function that uses an Error **errp parameter to return errors leaves
handling the error to the caller.  The code you remove violates this
principle.

>
>> -
>>      if (s =3D=3D INVALID_SOCKET) {
>> -        error_setg(errp, "invalid socket fd=3D%d", sockfd);
>> +        error_setg(&error_warn, "invalid socket fd=3D%d", sockfd);

From error_setg()'s contract:

 * Please don't error_setg(&error_fatal, ...), use error_report() and
 * exit(), because that's more obvious.
 * Likewise, don't error_setg(&error_abort, ...), use assert().

Not said: use warn_report() instead of error_set(&error_warn).
Should've been added in commit 3ffef1a55ca (error: add global
&error_warn destination).

I consider &error_warn a mistake.

>>          return false;
>>      }
>>=20=20
>>      if (WSAEventSelect(s, hEventObject, lNetworkEvents) !=3D 0) {
>> -        error_setg_win32(errp, WSAGetLastError(), "failed to WSAEventSe=
lect()");
>> +        error_setg_win32(&error_warn, WSAGetLastError(),
>> +                         "failed to WSAEventSelect()");
>>          return false;
>>      }
>>=20=20
>> @@ -315,7 +312,7 @@ bool qemu_socket_select(int sockfd, WSAEVENT hEventO=
bject,
>
>
> With regards,
> Daniel


