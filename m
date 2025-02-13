Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B3DC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 19:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tieV6-0006Fz-PE; Thu, 13 Feb 2025 14:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=724e=VF=miszr.win=git@fe-bounces.miszr.win>)
 id 1tieV5-0006Fa-O0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 14:03:51 -0500
Received: from smtp.forwardemail.net ([121.127.44.59])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <SRS0=724e=VF=miszr.win=git@fe-bounces.miszr.win>)
 id 1tieV3-0004i3-RS
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 14:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miszr.win;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID:
 References: In-Reply-To: Subject: CC: To: From: Date; q=dns/txt;
 s=fe-257304d8b2; t=1739473427;
 bh=djqcvGH7aFpQGd4pHWzsXzQ/UvTugac9iqlZKLlckTE=;
 b=BAGqqmcVv6p7kr1fLsf+NbQJEhp/S1f2iMTSZJCIpIN9mrkQcYgMJ6Xkq9k/evw2ZgvgTPaO+
 iq4LD+lKI1JDL0cOEcY9Z5FM59IgRlzzSztAUdMeoq42e00PODFtdZdXalCkFvRaLTDhKDVH8jt
 VeNmngZRyVj+X0hbsKIswUc=
X-Forward-Email-ID: 67ae420e67be845a3bc78d28
X-Forward-Email-Sender: rfc822; git@miszr.win, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Date: Thu, 13 Feb 2025 20:03:41 +0100
From: Mikael Szreder <git@miszr.win>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_target/sparc=3A_Fix_gdbstub_?=
 =?US-ASCII?Q?incorrectly_handling_registers_f32-f62?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ddc4ca31-22ab-4818-88d9-08f299559945@linaro.org>
References: <20250203145056.83567-1-git@miszr.win>
 <ddc4ca31-22ab-4818-88d9-08f299559945@linaro.org>
Message-ID: <C0AA2E55-2126-4399-8667-672ADD86B698@miszr.win>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=121.127.44.59;
 envelope-from=SRS0=724e=VF=miszr.win=git@fe-bounces.miszr.win;
 helo=smtp.forwardemail.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_FMBLA_NEWDOM14=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Sorry=2E As you correctly pointed out there is no f33 register=2E I wrote f=
33, when I really meant f34=2E

I believe the index of f32 is 64 and f34 is 65=2E This is confirmed when l=
ooking at the XML description of the registers in GDB: <https://sourceware=
=2Eorg/git/?p=3Dbinutils-gdb=2Egit;a=3Dblob;f=3Dgdb/features/sparc/sparc64-=
fpu=2Exml;h=3D8710585774d821c660af5e76f92707637633daf7;hb=3DHEAD>


Thanks in advance=20
Mikael Szreder

On February 13, 2025 5:57:59 PM GMT+01:00, Richard Henderson <richard=2Ehe=
nderson@linaro=2Eorg> wrote:
>On 2/3/25 06:50, Mikael Szreder wrote:
>> The gdbstub implementation for the Sparc architecture would incorectly
>>   calculate the the floating point register offset=2E
>> This would cause register pairs(eg f32,f33) to point to the same value=
=2E
>>=20
>> Fixes: 30038fd81808 ("target-sparc: Change fpr representation to double=
s=2E")
>> Signed-off-by: Mikael Szreder <git@miszr=2Ewin>
>> ---
>>   target/sparc/gdbstub=2Ec | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/target/sparc/gdbstub=2Ec b/target/sparc/gdbstub=2Ec
>> index ec0036e9ef=2E=2E5578fa9813 100644
>> --- a/target/sparc/gdbstub=2Ec
>> +++ b/target/sparc/gdbstub=2Ec
>> @@ -80,7 +80,7 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteAr=
ray *mem_buf, int n)
>>       }
>>       if (n < 80) {
>>           /* f32-f62 (double width, even numbers only) */
>> -        return gdb_get_reg64(mem_buf, env->fpr[(n - 32) / 2]=2Ell);
>> +        return gdb_get_reg64(mem_buf, env->fpr[(n - 64) + 16]=2Ell);
>
>I don't understand your issue with f33, since there is no such thing=2E  =
Sparc v9 has f0, f1, =2E=2E=2E f31, then f32, f34, =2E=2E=2E f62=2E  The od=
d numbers above 32 do not exist=2E
>
>Certainly the indexing is incorrect afterward=2E
>
>Originally,
>
>  f32 =3D 64 -> (64 - 32) / 2 =3D 16
>  f34 =3D 66 -> (66 - 32) / 2 =3D 17
>
>whereas your replacement gives
>
>  f34 =3D 66 -> (66 - 64) + 16 =3D 18=2E
>
>One could rewrite this as
>
>  (n - 64) / 2 + 16
>
>but that's algebraically identical to what we have now, so I don't see th=
e point=2E
>
>One plausible adjustment in this area would be to reject odd numbers from=
 this block and let them fall through to 'return 0' at the end=2E
>
>
>r~

