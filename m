Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EE5CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 22:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsVz9-00081G-Lj; Thu, 04 Apr 2024 18:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rsVz4-00080O-RB
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 18:55:03 -0400
Received: from fout6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rsVz2-00033I-A4
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 18:55:02 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id E2C6113800E8;
 Thu,  4 Apr 2024 18:54:58 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
 by compute5.internal (MEProxy); Thu, 04 Apr 2024 18:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buhman.org; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1712271298;
 x=1712357698; bh=pT76X/wuaqKvZqcEP13F6ZAWedTvcY4I8TmCQdQdzdU=; b=
 tJm5lx0BZpLLUXb6XGbFmJC7VvSQ86hHC7k+3jO2nb3irunUApFX+iHNK714c1Lx
 iuFlV8huHIzG/zF9xOhiZ1FVAFCy28gACgsUmDe+w4Mv+o8pUrLpZ3dlrPGRWt0A
 yE25xsg7mz/d6QUkR3mRN8H/4pHb4/pN7yyqIVNZFaKaxlT+opRXOMZgiQJn9Nwy
 rW+a1zigUXa6cNl8L+/fhOLzg3kcP2t6XiCkriWfKyg3MKemlAjK8TQcQqYvMeg5
 3QSKe+YPHi8/GFQlUQbHA1VfDtVivTIWjonC5vD8H8dvYFFAanxWDphrzWjPIHd0
 wFvJ6kpUWfcbyDsZuSgbDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712271298; x=
 1712357698; bh=pT76X/wuaqKvZqcEP13F6ZAWedTvcY4I8TmCQdQdzdU=; b=X
 vdh4AK+I4eFSzu0G7K9YiIl0f3Whn/rTNcArNZ+0I7HV9LD0C+t8z4t16cmaAcsi
 njMz7EY6IrP73OG1uE9GgXoYIooOCRUxo2c0uOfvJgZU7s3tUPv7mcECFrC8OE4l
 1lEqeLSe+siH+Rmgjzxnf8m2x7y7JisR0qZSresHl4RBcFBAhRUj+86DMPFtbwFR
 Ym/3+D8ik/laoJTEgo5wpZLlQovjs/UbGLTU6rYURkkUWJSGqsQdgqarjVUy2tce
 IHgeiTvGO1HGVNlx+FAElL6/VMyEUrWfwoDt7vzRDm0MoBgC8qDATjjHLCMSzgZS
 U3+rXG3BeppA/b1EmOaeA==
X-ME-Sender: <xms:wi8PZhSOn-8wYEMNAGG-5bvDeX-IB03i98qCeqlbQRlhW1YT-3dpcw>
 <xme:wi8PZqyS-_qgfNNnGWl7U8YtrOOi8WvI-AqeymaOZ30PY3_oWb4k-RylIZ9OgEOPz
 fQWDUJJmwNfpIlQIUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefledgudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdgk
 rggtkhcuuehuhhhmrghnfdcuoeiirggtkhessghuhhhmrghnrdhorhhgqeenucggtffrrg
 htthgvrhhnpeehfeejieeuteefueevhfdvieejieevtdejtdetueejieetgeekuedvgffg
 iedugeenucffohhmrghinhepqhgvmhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepiigrtghksegsuhhhmhgrnhdrohhrgh
X-ME-Proxy: <xmx:wi8PZm1T1DjRTaV862xx_Xcrqqnv7sqU_8SXvK3AYY3Mj7VqC6r0Mg>
 <xmx:wi8PZpDfuqj0hJTTtpqNimzHqqa-3IDZFhYb_m-MtfkNQ4V3ZeWPag>
 <xmx:wi8PZqhUcPG7I8FVu1fpdrdeb-u3GVLbxJxTCl1-1mHIV4v6f1-j2A>
 <xmx:wi8PZtqXqfSfcfwLZZ-e46WOkGR8vQ0jyCjJ1GZeTIxNi_4kHS4DQw>
 <xmx:wi8PZif3RlQaQmCKJ1QFv3m9aFP5InZ933DZvAqlLVKWTe0Z1nd8l0_c>
Feedback-ID: i1541475f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 3B6F0A60078; Thu,  4 Apr 2024 18:54:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
MIME-Version: 1.0
Message-Id: <0650e674-c730-428a-932e-c330e06a6923@app.fastmail.com>
In-Reply-To: <dc5a8b5f-9251-477f-893e-53cd4a320a07@linaro.org>
References: <CAFEAcA-VQ0yZMoFEuYWD2twe129OZHaer+-_49inW1exANKV2w@mail.gmail.com>
 <20240404162641.27528-2-zack@buhman.org>
 <CAFEAcA_duQyCLGyu4f4KwOCEhnEeELDHGqCM9cQtC4d6rF4piQ@mail.gmail.com>
 <dc5a8b5f-9251-477f-893e-53cd4a320a07@linaro.org>
Date: Fri, 05 Apr 2024 06:55:06 +0800
From: "Zack Buhman" <zack@buhman.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Peter Maydell" <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Yoshinori Sato" <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v2] sh4: mac.l: implement saturation arithmetic logic
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.149; envelope-from=zack@buhman.org;
 helo=fout6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Zack Buhman <zack@buhman.org>

----- Original message -----
From: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>, Zack Buhman <zack@buhman.o=
rg>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v2] sh4: mac.l: implement saturation arithmetic logic
Date: Friday, April 05, 2024 1:26 AM

Hi Zack,

Cc'ing the maintainer of this file, Yoshinori:

$ ./scripts/get_maintainer.pl -f target/sh4/op_helper.c
Yoshinori Sato <ysato@users.sourceforge.jp> (reviewer:SH4 TCG CPUs)
(https://www.qemu.org/docs/master/devel/submitting-a-patch.html#cc-the-r=
elevant-maintainer)

On 4/4/24 18:39, Peter Maydell wrote:
> On Thu, 4 Apr 2024 at 17:26, Zack Buhman <zack@buhman.org> wrote:
>>
>> The saturation arithmetic logic in helper_macl is not correct.
>>
>> I tested and verified this behavior on a SH7091, the general pattern
>> is a code sequence such as:
>>
>>          sets
>>
>>          mov.l _mach,r2
>>          lds r2,mach
>>          mov.l _macl,r2
>>          lds r2,macl
>>
>>          mova _n,r0
>>          mov r0,r1
>>          mova _m,r0
>>          mac.l @r0+,@r1+
>>
>>      _mach: .long 0x00007fff
>>      _macl: .long 0x12345678
>>      _m:    .long 0x7fffffff
>>      _n:    .long 0x7fffffff
>>
>> Test case 0: (no int64_t overflow)
>>    given; prior to saturation mac.l:
>>      mach =3D 0x00007fff macl =3D 0x12345678
>>      @r0  =3D 0x7fffffff @r1  =3D 0x7fffffff
>>
>>    expected saturation mac.l result:
>>      mach =3D 0x00007fff macl =3D 0xffffffff
>>
>>    qemu saturation mac.l result (prior to this commit):
>>      mach =3D 0x00007ffe macl =3D 0x12345678
>>
>> Test case 1: (no int64_t overflow)
>>    given; prior to saturation mac.l:
>>      mach =3D 0xffff8000 macl =3D 0x00000000
>>      @r0  =3D 0xffffffff @r1  =3D 0x00000001
>>
>>    expected saturation mac.l result:
>>      mach =3D 0xffff8000 macl =3D 0x00000000
>>
>>    qemu saturation mac.l result (prior to this commit):
>>      mach =3D 0xffff7fff macl =3D 0xffffffff
>>
>> Test case 2: (int64_t addition overflow)
>>    given; prior to saturation mac.l:
>>      mach =3D 0x80000000 macl =3D 0x00000000
>>      @r0  =3D 0xffffffff @r1  =3D 0x00000001
>>
>>    expected saturation mac.l result:
>>      mach =3D 0xffff8000 macl =3D 0x00000000
>>
>>    qemu saturation mac.l result (prior to this commit):
>>      mach =3D 0xffff7fff macl =3D 0xffffffff
>>
>> Test case 3: (int64_t addition overflow)
>>    given; prior to saturation mac.l:
>>      mach =3D 0x7fffffff macl =3D 0x00000000
>>      @r0 =3D 0x7fffffff @r1 =3D 0x7fffffff
>>
>>    expected saturation mac.l result:
>>      mach =3D 0x00007fff macl =3D 0xffffffff
>>
>>    qemu saturation mac.l result (prior to this commit):
>>      mach =3D 0xfffffffe macl =3D 0x00000001
>>
>> All of the above also matches the description of MAC.L as documented
>> in cd00147165-sh-4-32-bit-cpu-core-architecture-stmicroelectronics.pdf
>=20
> Hi. I just noticed that you didn't include a signed-off-by line
> in your commit message. We need these as they're how you say
> that you're legally OK to contribute this code to QEMU and
> you're happy for it to go into the project:
>=20
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-e=
mails-must-include-a-signed-off-by-line
> has links to what exactly this means, but basically the
> requirement is that the last line of your commit message should be
> "Signed-off-by: Your Name <your@email>"
>=20
> In this case, if you just reply to this email with that, we
> can pick it up and fix up the commit message when we apply the
> patch.
>=20
>> ---
>>   target/sh4/op_helper.c | 31 +++++++++++++++++++++----------
>>   1 file changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
>> index 4559d0d376..ee16524083 100644
>> --- a/target/sh4/op_helper.c
>> +++ b/target/sh4/op_helper.c
>> @@ -160,18 +160,29 @@ void helper_ocbi(CPUSH4State *env, uint32_t add=
ress)
>>
>>   void helper_macl(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
>>   {
>> -    int64_t res;
>> -
>> -    res =3D ((uint64_t) env->mach << 32) | env->macl;
>> -    res +=3D (int64_t) (int32_t) arg0 *(int64_t) (int32_t) arg1;
>> -    env->mach =3D (res >> 32) & 0xffffffff;
>> -    env->macl =3D res & 0xffffffff;
>> +    int32_t value0 =3D (int32_t)arg0;
>> +    int32_t value1 =3D (int32_t)arg1;
>> +    int64_t mul =3D ((int64_t)value0) * ((int64_t)value1);
>> +    int64_t mac =3D (((uint64_t)env->mach) << 32) | env->macl;
>> +    int64_t result;
>> +    bool overflow =3D sadd64_overflow(mac, mul, &result);
>> +    /* Perform 48-bit saturation arithmetic if the S flag is set */
>>       if (env->sr & (1u << SR_S)) {
>> -        if (res < 0)
>> -            env->mach |=3D 0xffff0000;
>> -        else
>> -            env->mach &=3D 0x00007fff;
>> +        /*
>> +         * The sign bit of `mac + mul` may overflow. The MAC unit on
>> +         * real SH-4 hardware has equivalent carry/saturation logic:
>> +         */
>> +        const int64_t upper_bound =3D  ((1ull << 47) - 1);
>> +        const int64_t lower_bound =3D -((1ull << 47) - 0);
>> +
>> +        if (overflow) {
>> +            result =3D (mac < 0) ? lower_bound : upper_bound;
>> +        } else {
>> +            result =3D MIN(MAX(result, lower_bound), upper_bound);
>> +        }
>>       }
>> +    env->macl =3D result;
>> +    env->mach =3D result >> 32;
>>   }
>=20
> I haven't checked the sh4 docs but the change looks right, so
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> thanks
> -- PMM
>=20


