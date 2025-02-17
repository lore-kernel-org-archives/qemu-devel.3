Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41D7C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 04:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjt9z-0003h9-HG; Sun, 16 Feb 2025 23:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ae45=VI=miszr.win=git@fe-bounces.miszr.win>)
 id 1tjt9t-0003gm-9p
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 23:55:05 -0500
Received: from smtp.forwardemail.net ([121.127.44.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <SRS0=ae45=VI=miszr.win=git@fe-bounces.miszr.win>)
 id 1tjt9q-0004l0-V9
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 23:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=miszr.win;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID:
 References: In-Reply-To: Subject: CC: To: From: Date; q=dns/txt;
 s=fe-257304d8b2; t=1739768098;
 bh=ugKhaarWZtOlGe1Ks8zorRMcgrLsdI+SxA4cyhH4+5U=;
 b=FUBLR1ppluk8Bny8M5X1xDH0nzOwjKOeN0BAk4KTiFqZ8gTQCVkJ6k9y5KjquhkmSfE+Kfswy
 Fb/Rtxt+0n72PDwpDEKNp270hBTIIprLQYPd9AAq277C4QfFtdz1OJ9eB4IxU1j4r3gDy1cXe6x
 Ki+aVTKeZclQXMLtiPqke9A=
X-Forward-Email-ID: 67b2c11f2860b3d889bd3d18
X-Forward-Email-Sender: rfc822; git@miszr.win, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Date: Mon, 17 Feb 2025 05:54:41 +0100
From: Mikael Szreder <git@miszr.win>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
CC: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_target/sparc=3A_Fix_gdbstu?=
 =?US-ASCII?Q?b_incorrectly_handling_registers_f32-f62?=
User-Agent: K-9 Mail for Android
In-Reply-To: <5e9d9e51-1950-45d5-9580-9f1072e3b1b4@linaro.org>
References: <20250214070343.11501-1-git@miszr.win>
 <5e9d9e51-1950-45d5-9580-9f1072e3b1b4@linaro.org>
Message-ID: <49B12FB6-60E2-49AD-A832-1D8D7B25F9B2@miszr.win>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=121.127.44.73;
 envelope-from=SRS0=ae45=VI=miszr.win=git@fe-bounces.miszr.win;
 helo=smtp.forwardemail.net
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_FMBLA_NEWDOM28=0.8, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch should be applicable to the stable releases as well, as the issu=
e has existed since a while back=2E

Best regards
Mikael Szreder

On February 15, 2025 8:58:09 PM GMT+01:00, Richard Henderson <richard=2Ehe=
nderson@linaro=2Eorg> wrote:
>On 2/13/25 23:03, Mikael Szreder wrote:
>> The gdbstub implementation for the Sparc architecture would
>> incorrectly calculate the the floating point register offset=2E
>> This resulted in, for example, registers f32 and f34 to point to
>> the same value=2E
>>=20
>> The issue was caused by the confusion between even register numbers
>> and even register indexes=2E For example, the register index of f32 is =
64
>> and f34 is 65=2E
>>=20
>> Fixes: 30038fd81808 ("target-sparc: Change fpr representation to double=
s=2E")
>> Signed-off-by: Mikael Szreder <git@miszr=2Ewin>
>> ---
>>   target/sparc/gdbstub=2Ec | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/target/sparc/gdbstub=2Ec b/target/sparc/gdbstub=2Ec
>> index ec0036e9ef=2E=2E134617fb23 100644
>> --- a/target/sparc/gdbstub=2Ec
>> +++ b/target/sparc/gdbstub=2Ec
>> @@ -79,8 +79,13 @@ int sparc_cpu_gdb_read_register(CPUState *cs, GByteA=
rray *mem_buf, int n)
>>           }
>>       }
>>       if (n < 80) {
>> -        /* f32-f62 (double width, even numbers only) */
>> -        return gdb_get_reg64(mem_buf, env->fpr[(n - 32) / 2]=2Ell);
>> +        /* f32-f62 (16 double width registers, even register numbers o=
nly)
>> +         * n =3D=3D 64: f32 : env->fpr[16]
>> +         * n =3D=3D 65: f34 : env->fpr[17]
>> +         * etc=2E=2E=2E
>> +         * n =3D=3D 79: f62 : env->fpr[31]
>> +         */
>> +        return gdb_get_reg64(mem_buf, env->fpr[(n - 64) + 16]=2Ell);
>>       }
>>       switch (n) {
>>       case 80:
>> @@ -173,8 +178,13 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uin=
t8_t *mem_buf, int n)
>>           }
>>           return 4;
>>       } else if (n < 80) {
>> -        /* f32-f62 (double width, even numbers only) */
>> -        env->fpr[(n - 32) / 2]=2Ell =3D tmp;
>> +        /* f32-f62 (16 double width registers, even register numbers o=
nly)
>> +         * n =3D=3D 64: f32 : env->fpr[16]
>> +         * n =3D=3D 65: f34 : env->fpr[17]
>> +         * etc=2E=2E=2E
>> +         * n =3D=3D 79: f62 : env->fpr[31]
>> +         */
>> +        env->fpr[(n - 64) + 16]=2Ell =3D tmp;
>>       } else {
>>           switch (n) {
>>           case 80:
>
>Queued, thanks=2E
>
>
>r~

