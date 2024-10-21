Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18D5D0E6D8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 09:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2pBX-0002UK-PP; Mon, 21 Oct 2024 05:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1t2pBV-0002Ty-RU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 05:58:46 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1t2pBU-0005ed-7u
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 05:58:45 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4XX9k02nM8z8PbP;
 Mon, 21 Oct 2024 05:58:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=N+ltw9XaNv6FeQV8uAKQMs//uY0vm9qmX5B1J6yVm6Q=; b=n2GTWGnRA+0W
 MoA0WrczYatZv0wHNVWwHsAESRgLb7SRPYvUTlrxXM3Y3JrXa0zl6lOguFCDrbSp
 Lctt7GRL68lkvehOXP/XEzPg7ECzUFsvxH5lbffezvgA84DtNIsEJ2EucQbANz8k
 6ljRWLw+8S/R0yJPKqFs8sLt5qaxb0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=hOb
 dlmiehApXySy6MPDBM8VTx/oJnSgaO7Iwx1LuhFZx2B15kRXrd+46HGsbSEopG3M
 /KL2WwvZy3JMdpViKpAv7TgkKA6qgSXoRfW3C9P9qRErRlhdRRL9aQDRWThuhUPr
 6hPRktaUtTkBmqu71LRGyoJdPvlEhqbQDjidQSco=
Received: from [192.168.180.2]
 (ipagstaticip-fb0cb5d9-e423-dda2-c442-adc5999de965.sdsl.bell.ca
 [76.65.209.165])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4XX9jz6bbXz8PbN;
 Mon, 21 Oct 2024 05:58:30 -0400 (EDT)
Message-ID: <c086dbe4-bcd9-4a90-99ef-8c2cda37471d@comstyle.com>
Date: Mon, 21 Oct 2024 05:58:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/vm: update openbsd image to 7.6
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Alex Benn_e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud_ <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <ZwtmfVlWgFRF9G8W@humpty.home.comstyle.com>
 <ZxYee2xa-VJjOQSV@redhat.com>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <ZxYee2xa-VJjOQSV@redhat.com>
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

On 2024-10-21 5:27 a.m., Daniel P. Berrang=C3=A9 wrote:
> On Sun, Oct 13, 2024 at 02:19:41AM -0400, Brad Smith wrote:
>> tests/vm: update openbsd image to 7.6
>>
>> Remove tomli as Python has been updated to 3.11.
>>
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>> ---
>>   tests/vm/openbsd | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>> index 49cab08782..dfd11c93f0 100755
>> --- a/tests/vm/openbsd
>> +++ b/tests/vm/openbsd
>> @@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
>>       name =3D "openbsd"
>>       arch =3D "x86_64"
>>  =20
>> -    link =3D "https://cdn.openbsd.org/pub/OpenBSD/7.5/amd64/install75=
.iso"
>> -    csum =3D "034435c6e27405d5a7fafb058162943c194eb793dafdc412c08d49b=
b56b3892a"
>> +    link =3D "https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/install76=
.iso"
>> +    csum =3D "60cba8cb391b50bba8fa10fc768bd0529636f5345d82133c93e22c7=
98d8e5269"
>>       size =3D "20G"
>>       pkgs =3D [
>>           # tools
>> @@ -32,7 +32,6 @@ class OpenBSDVM(basevm.BaseVM):
>>           "pkgconf",
>>           "bzip2", "xz",
>>           "ninja",
>> -        "py3-tomli",
>>  =20
>>           # gnu tools
>>           "bash",
>> @@ -160,6 +159,7 @@ class OpenBSDVM(basevm.BaseVM):
>>  =20
>>           self.print_step("Installation started now, this will take a =
while")
>>           self.console_wait_send("Location of sets",        "done\n")
>> +        self.console_wait_send("Time appears wrong.  Set to", "\n")
> Have you any idea why this line has suddenly become neccessary ?
Thomas provided that piece.
> Without your patch, I'm seeing OpenBSD VM installs fail with the existi=
ng
> 'install75.iso' image, with the error matching this line
>
>    con recv: Time appears wrong.  Set to 'Mon Oct 21 04:07:03 UTC 2024'=
? [yes]
>
> The OpenBSD installer can't have changed behind our back, because we've
> recorded the original ISO image checksum.
>
> So I'm wondering what other thing has changed to suddenly make this
> "Time appears wrong" message appear ?  Have we accidentally broken
> something in QEMU ?
>
> With regards,
> Daniel


This is not new in the installer as far as I can see. But I have never=20
seen this until now.

https://github.com/openbsd/src/blob/ad7ea506c1758b3b614d7becde019d9bf8d29=
459/distrib/miniroot/install.sub#L3315

 =C2=A0=C2=A0=C2=A0 # If we got a timestamp from the cgi server, and that=
 time diffs by=20
more
 =C2=A0=C2=A0=C2=A0 # than 120 seconds, ask if the user wants to adjust t=
he time.
 =C2=A0=C2=A0=C2=A0 if _time=3D$(http_time) && _now=3D$(date +%s) &&
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (( _now - _time > 120 || _tim=
e - _now > 120 )); then
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ln -sf /mnt/usr/share/zoneinf=
o/$TZ /etc/localtime
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ask_yn "Time appears wrong=
.=C2=A0 Set to '$(date -r=20
"$(http_time)")'?" yes; then
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 date =
$(date -r "$(http_time)" "+%Y%m%d%H%M.%S") >/dev/null
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # N.B=
. This will screw up SECONDS.
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm -f /etc/localtime
 =C2=A0=C2=A0=C2=A0 fi


