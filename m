Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AE6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 04:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scHbb-0006pm-Gj; Fri, 09 Aug 2024 00:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1scHbZ-0006on-Hq
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 00:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1scHbX-0007yL-UF
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 00:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723179114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2C19lKZf4KOA7jbEj7sA1XL/IfJ18kwxq4MdWsCpaYA=;
 b=Y6ori0L4o2c++dFi6O9H2K6st+LwsQHANZcX8IcS6uDhPlnPfFyLQRshs1rjXkA+8ci8ZR
 SS8uiYTN4KG4RJfugOKGGmjNwXKu+vtTNo0JCYrBXxkS03HB4FVV1DbWm4a59CZHSJmyEj
 pa0TbrncKsWrfpvKr7UIOrYM/J5bTTQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-3M2MK7CQMCGYsh7RapcqWQ-1; Fri,
 09 Aug 2024 00:51:52 -0400
X-MC-Unique: 3M2MK7CQMCGYsh7RapcqWQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71AAB1944A8A; Fri,  9 Aug 2024 04:51:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2C7719560A3; Fri,  9 Aug 2024 04:51:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BC90B21E668F; Fri,  9 Aug 2024 06:51:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  eblake@redhat.com,  marcandre.lureau@redhat.com,
 pbonzini@redhat.com,  berrange@redhat.com,  mst@redhat.com,
 marcel.apfelbaum@gmail.com,  jiri@resnulli.us
Subject: Re: [PATCH 1/6] qapi/char: Supply missing member documentation
In-Reply-To: <CAFn=p-Yk1J2UUFDULdoF-kbpYN61NB7dDFtA5wsY9h1BSzfLvw@mail.gmail.com>
 (John Snow's message of "Thu, 8 Aug 2024 16:48:08 -0400")
References: <20240808182636.3657537-1-armbru@redhat.com>
 <20240808182636.3657537-2-armbru@redhat.com>
 <CAFn=p-Yk1J2UUFDULdoF-kbpYN61NB7dDFtA5wsY9h1BSzfLvw@mail.gmail.com>
Date: Fri, 09 Aug 2024 06:51:48 +0200
Message-ID: <87bk22nvrv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Thu, Aug 8, 2024 at 2:26=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> Since we neglect to document several members of ChardevBackendKind,
>> their description in the QEMU QMP Reference manual is "Not
>> documented".  Fix that, and improve the existing member documentation.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi/char.json   | 44 ++++++++++++++++++++++++++++----------------
>>  qapi/pragma.json |  1 -
>>  2 files changed, 28 insertions(+), 17 deletions(-)
>>
>> diff --git a/qapi/char.json b/qapi/char.json
>> index ef58445cee..8a4a87c95c 100644
>> --- a/qapi/char.json
>> +++ b/qapi/char.json
>> @@ -434,37 +434,49 @@
>>  ##
>>  # @ChardevBackendKind:
>>  #
>> -# @pipe: Since 1.5
>> +# @file: regular files
>>  #
>> -# @udp: Since 1.5
>> +# @serial: serial host device
>>  #
>> -# @mux: Since 1.5
>> +# @parallel: parallel host device
>>  #
>> -# @msmouse: Since 1.5
>> +# @pipe: pipes (since 1.5)
>>  #
>> -# @wctablet: Since 2.9
>> +# @socket: stream socket
>>  #
>> -# @braille: Since 1.5
>> +# @udp: datagram socket (since 1.5)
>>  #
>> -# @testdev: Since 2.2
>> +# @pty: pseudo-terminal
>>  #
>> -# @stdio: Since 1.5
>> +# @null: provides no input, throws away output
>>  #
>> -# @console: Since 1.5
>> +# @mux: (since 1.5)
>>  #
>> -# @spicevmc: Since 1.5
>> +# @msmouse: emulated Microsoft serial mouse (since 1.5)
>>  #
>> -# @spiceport: Since 1.5
>> +# @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
>>  #
>> -# @qemu-vdagent: Since 6.1
>> +# @braille: Baum Braille device (since 1.5)
>>  #
>> -# @dbus: Since 7.0
>> +# @testdev: device for test-suite control (since 2.2)
>>  #
>> -# @vc: v1.5
>> +# @stdio: standard I/O (since 1.5)
>>  #
>> -# @ringbuf: Since 1.6
>> +# @console: Windows console (since 1.5)
>>  #
>> -# @memory: Since 1.5
>> +# @spicevmc: spice vm channel (since 1.5)
>> +#
>> +# @spiceport: Spice port channel (since 1.5)
>> +#
>> +# @qemu-vdagent: Spice vdagent (since 6.1)
>> +#
>> +# @dbus: D-Bus channel (since 7.0)
>> +#
>> +# @vc: virtual console (since v1.5)
>>
>
> Remove the "v"?

Yes.  Good catch!

>> +#
>> +# @ringbuf: memory ring buffer (since 1.6)
>> +#
>> +# @memory: synonym for @ringbuf (since 1.5)
>>  #
>>  # Features:
>>  #
>> diff --git a/qapi/pragma.json b/qapi/pragma.json
>> index 59fbe74b8c..39a424303b 100644
>> --- a/qapi/pragma.json
>> +++ b/qapi/pragma.json
>> @@ -46,7 +46,6 @@
>>          'BlockdevSnapshotSyncWrapper',
>>          'BlockdevSnapshotWrapper',
>>          'BlockdevVmdkAdapterType',
>> -        'ChardevBackendKind',
>>          'CpuS390Entitlement',
>>          'CpuS390Polarization',
>>          'CpuS390State',
>> --
>> 2.45.0
>>
>
> It'd be nice if these included some kind of cross-reference to
> documentation for the backends in question, but this is better than "(Not
> documented)", so it's not time to be picky.

Same for any enum that's used as union tag?

> ACK

Thank you!


