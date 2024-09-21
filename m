Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6C4CF9C5B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2024 22:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ss8uA-0002hr-4t; Sat, 21 Sep 2024 18:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1ss8u7-0002hL-Kx
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 18:48:39 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1ss8u6-0007xq-6i
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 18:48:39 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4XB4DN0QKcz8PbP;
 Sat, 21 Sep 2024 18:48:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=V++nPvaTpltyl2ZXSq+LDZVdJ0r60msILi9Qce36m1w=; b=i53u4z0BRXgz
 QbdcjT0CFHMeWGle8MvGztDMaFYDTIxVbyX1+ua01Ef7sZ6WgbZjx5Gk77cKu2g8
 Iz/WqgjaQX+8P2/kCiFxaBlyG+xSw8DTjB6aRsKnrANdp5VaRma5inSCC6YLApQT
 75GRfmoajpTo29/qLKVYYoizPLVLU9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=XcK
 dlrEejfmiF8ErqQboc1XbQ8ay6+Eu8KyqEsUAyQlQh7W/0xDg+I9pf/wl+OE3ytj
 +GJ0bUgMS1CiZyZTkPDCOHh0hBz5NhhqIG0Ksjcn3YehxmVi1P9KQ6ogOSa3bV+A
 eCSxPfX89IVtXE0Wrty++06AiWklBAFClehrjPlg=
Received: from [IPV6:2001:470:b050:6:cc31:46d5:f26a:a82b] (unknown
 [IPv6:2001:470:b050:6:cc31:46d5:f26a:a82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4XB4DM4XzQz8PbN;
 Sat, 21 Sep 2024 18:48:35 -0400 (EDT)
Message-ID: <58b41976-15aa-401d-9935-2ea5bb911e78@comstyle.com>
Date: Sat, 21 Sep 2024 18:48:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins: ensure build does not pick up a system
 copy of plugin header
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <Zu4063fjfHC5hHUl@humpty.home.comstyle.com>
 <87msk1dv45.fsf@draig.linaro.org>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <87msk1dv45.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2024-09-21 8:55 a.m., Alex Benn=C3=A9e wrote:
> Brad Smith <brad@comstyle.com> writes:
>
>> contrib/plugins: ensure build does not pick up a system copy of plugin
>> header
> I'm confused because this changes the ordering of the GLIB inclusion. W=
e
> shouldn't be including the whole QEMU include path.

That's intentional. The GLIB header paths cannot come before the header p=
ath
for the plugin header otherwise it pulls in the older plugin header from =
the
installed copy of QEMU and breaks. The QEMU include path is necessary
for the plugin header.


cc=C2=A0 -O2 -g=C2=A0 -I/usr/local/include/glib-2.0=20
-I/usr/local/lib/glib-2.0/include -I/usr/local/include -fPIC -Wall=20
-I/home/brad/tmp/qemu/contrib/plugins/../../include/qemu -c -o execlog.o=20
/home/brad/tmp/qemu/contrib/plugins/execlog.c
/home/brad/tmp/qemu/contrib/plugins/execlog.c:262:41: error: too many=20
arguments to function call, expected single argument 'insn', have 3=20
arguments
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_=
plugin_insn_data(insn, &insn_opcode, sizeof(insn_opcode));
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~~~~~=
~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/local/include/qemu-plugin.h:407:13: note: 'qemu_plugin_insn_data'=20
declared here
const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
1 error generated.

> How does this fail?
>
>> With the ordering of the header path if a copy of QEMU is installed it
>> will pickup the system copy of the header before the build paths copy
>> and the build will fail.
>>
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>> ---
>>   contrib/plugins/Makefile | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
>> index 05a2a45c5c..52fc390376 100644
>> --- a/contrib/plugins/Makefile
>> +++ b/contrib/plugins/Makefile
>> @@ -41,9 +41,10 @@ SONAMES :=3D $(addsuffix $(SO_SUFFIX),$(addprefix l=
ib,$(NAMES)))
>>  =20
>>   # The main QEMU uses Glib extensively so it is perfectly fine to use=
 it
>>   # in plugins (which many example do).
>> -PLUGIN_CFLAGS :=3D $(shell $(PKG_CONFIG) --cflags glib-2.0)
>> -PLUGIN_CFLAGS +=3D -fPIC -Wall
>> +GLIB_CFLAGS :=3D $(shell $(PKG_CONFIG) --cflags glib-2.0)
>>   PLUGIN_CFLAGS +=3D -I$(TOP_SRC_PATH)/include/qemu
> Not withstanding the fact I've just borrowed bswap.h for a test plugin
> maybe we should actually copy qemu-plugin.h to an entirely new location
> during the build and then include from there to avoid any other
> potential pollutions?

I don't see how that would make any difference, but either way as long=20
as the header
path ordering is corrected so this new path is not passed last on the=20
command line
getting the ordering wrong.

>
>> +PLUGIN_CFLAGS +=3D $(GLIB_CFLAGS)
>> +PLUGIN_CFLAGS +=3D -fPIC -Wall
>>  =20
>>   # Helper that honours V=3D1 so we get some output when compiling
>>   quiet-@ =3D $(if $(V),,@$(if $1,printf "  %-7s %s\n" "$(strip $1)" "=
$(strip $2)" && ))

