Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2798ECCFA06
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGHvw-0005ZE-4h; Tue, 04 Nov 2025 09:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vGHve-0005WE-46
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:22:35 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vGHvc-0006h9-6b
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762266147; x=1762870947; i=deller@gmx.de;
 bh=jbrl/9LmRv+QM/m6f6cj4xCJw22MrneKUkfduPAjqrg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RaORzsDIt6VQR1j9VgDWq6wYTbrVCkU6yKSOmQT3f2Ao1Zc0jWD6GRVQFtBWDrg2
 0B/kM8GiqxXebL38IWNZlu7aMGQub9jhuFpgRs1Ztk1uLVLI9+g9zHMQRHak119M3
 LA6FVzsGEMU6QwOEJN+LDZznfOdT9LDiNJOk3amPqxKr9rCYxOQbDiYVnZdf5/Qx5
 L5ghX9Yh/St2ypdJo1EfeD9iGpHIZ0Fkv3ctgCLPxModspawl1ZOpybhrHsZCcmnC
 c56Mwx66OoARBLsdhkp+yA2hoXJnKxJvEXkbNn1NrwdUIurcFMPKePbctct+n2dD+
 T/iIAadw+SkMb7ECjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.211]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdvmY-1vqAi51rBG-00iGuE; Tue, 04
 Nov 2025 15:22:27 +0100
Message-ID: <ab953a28-d44f-4de1-9f9f-4cf92d46cc43@gmx.de>
Date: Tue, 4 Nov 2025 15:22:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/3] i82596: Implement enhanced TX/RX with packet queuing
 and filtering
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Jason Wang <jasowang@redhat.com>
References: <20251103132029.6725-1-deller@kernel.org>
 <20251103132029.6725-4-deller@kernel.org>
 <8374b2ef-6edf-4a22-8c4b-8c1ccb56851c@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <8374b2ef-6edf-4a22-8c4b-8c1ccb56851c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DIkI1UbcpU534u3QGfwizqveXjd8dw3+OCLbZmMlt6zQFLQUEk5
 XW8tetlAqkVFRDt2rKDq4FVEdShEazeD4ML1bVQAlukOrHrri2UTUKSPcHYxfJmxLpVuCxV
 wZJ95+R/GDLnicV/WZwgLbszBwBCVul+sLdNl3gGytVgVrnTHG1/m1OFwEWIW/LBLETptuV
 iu27Q4xHTYTG8l/IGnXOQ==
UI-OutboundReport: notjunk:1;M01:P0:VzOzCAuKJHo=;amhHgjhn3LdLQV6MK7HhMA5rV7h
 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
 8LRQ2hukzyuoar/us=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/4/25 15:11, Richard Henderson wrote:
> On 11/3/25 14:20, deller@kernel.org wrote:
>> +static void i82596_init_dump_area(I82596State *s, uint8_t *buffer)
>> +{
>> +=C2=A0=C2=A0=C2=A0 memset(buffer, 0, DUMP_BUF_SZ);
>> +
>> +=C2=A0=C2=A0=C2=A0 printf("This is the dump area function for i82596 Q=
EMU side\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "If=
 you are seeing this message, pleasecontact:\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "So=
umyajyotii Sarkar<soumyajyotisarkar23@gmail.com>\n"
>> +"With the process in which you encountered this issue:\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Th=
is still needs developement so,\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "I =
will be more than delighted to help you out!\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 );
>> +
>> +=C2=A0=C2=A0=C2=A0 auto void write_uint16(int offset, uint16_t value)
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buffer[offset] =3D value >>=
 8;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buffer[offset + 1] =3D valu=
e & 0xFF;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 auto void write_uint32(int offset, uint32_t value)
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_uint16(offset, value =
>> 16);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_uint16(offset + 2, va=
lue & 0xFFFF);
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> Doesn't build with macos clang.
>=20
> https://gitlab.com/qemu-project/qemu/-/jobs/11967951995
>=20
> ../hw/net/i82596.c:1468:5: error: function definition is not allowed her=
e
>  =C2=A01468 |=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ^
> ../hw/net/i82596.c:1473:5: error: function definition is not allowed her=
e
>  =C2=A01473 |=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ^
> ../hw/net/i82596.c:1478:5: error: call to undeclared function 'write_uin=
t16'; ISO C99 and later do not support implicit function declarations [-Wi=
mplicit-function-declaration]
>  =C2=A01478 |=C2=A0=C2=A0=C2=A0=C2=A0 write_uint16(0x00, (s->config[5] <=
< 8) | s->config[4]);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ^
> ../hw/net/i82596.c:1503:5: error: call to undeclared function 'write_uin=
t32'; ISO C99 and later do not support implicit function declarations [-Wi=
mplicit-function-declaration]
>  =C2=A01503 |=C2=A0=C2=A0=C2=A0=C2=A0 write_uint32(0xB4, s->crc_err);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ^
> 4 errors generated.
>=20
>=20
> Anyway, nested functions doesn't seem like a great idea.

True.
I'll clean that up, add the Tested-by from Guenter Roeck and
resend during the next 1-2 hours..

Thanks!
Helge

