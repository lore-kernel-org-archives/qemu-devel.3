Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818E9C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLfT-00012Y-5O; Fri, 09 Aug 2024 05:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1scLfR-00011O-BM
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1scLfN-000673-Gc
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723194728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cMGAcYY/89TIjOunvUazpcO0Gp2KLGoOIb7IWuT+5I=;
 b=LTwhHMd1ivWaAwQ6TQuUiAZq/s+75vG2skOBkHV6s1gd4BLHHn61OOEuCA/sMTSPf4BQ9C
 Zgqn0bj6Zy+ZO9U12FbGasI12elpZJXRIekQ5ED+7oWdP4LX83VJJC75NoUvrsUj0XYGgb
 MWVO2g5V1KCMRkKsKoQQn3kEQ9+adD8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-gStaRIFnNqGpX_rNDXXFxg-1; Fri,
 09 Aug 2024 05:12:04 -0400
X-MC-Unique: gStaRIFnNqGpX_rNDXXFxg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 256331956080; Fri,  9 Aug 2024 09:12:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 856DE19560A3; Fri,  9 Aug 2024 09:12:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 59BA721E668B; Fri,  9 Aug 2024 11:11:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 eblake@redhat.com,  marcandre.lureau@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  mst@redhat.com,  marcel.apfelbaum@gmail.com,
 jiri@resnulli.us,  jsnow@redhat.com
Subject: Re: [PATCH 1/6] qapi/char: Supply missing member documentation
In-Reply-To: <ec33abcb-409f-4609-9007-3337f3f647ab@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 9 Aug 2024 10:44:24
 +0200")
References: <20240808182636.3657537-1-armbru@redhat.com>
 <20240808182636.3657537-2-armbru@redhat.com>
 <ec33abcb-409f-4609-9007-3337f3f647ab@linaro.org>
Date: Fri, 09 Aug 2024 11:11:59 +0200
Message-ID: <875xsakqlc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Markus,
>
> On 8/8/24 20:26, Markus Armbruster wrote:
>> Since we neglect to document several members of ChardevBackendKind,
>> their description in the QEMU QMP Reference manual is "Not
>> documented".  Fix that, and improve the existing member documentation.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qapi/char.json   | 44 ++++++++++++++++++++++++++++----------------
>>   qapi/pragma.json |  1 -
>>   2 files changed, 28 insertions(+), 17 deletions(-)
>>=20
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
>> +#
>> +# @ringbuf: memory ring buffer (since 1.6)
>> +#
>> +# @memory: synonym for @ringbuf (since 1.5)
>
> What is the rule to sort the members?

I like to keep the member descriptions in the same order as their
definitions in 'data'.

As to the order in 'data': sometimes there's a "natural" order or
grouping, and sometimes alphabetical is best.  However, we too often add
members without giving order a thought, commonly at the end.

Hope this helps!


