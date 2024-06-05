Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A1DC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 12:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEq3F-0000Jh-NH; Wed, 05 Jun 2024 08:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEq3D-0000JS-5m
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 08:47:36 -0400
Received: from fhigh6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEq3B-0006wC-0N
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 08:47:34 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 7EF6111401B4;
 Wed,  5 Jun 2024 08:47:30 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 05 Jun 2024 08:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717591650;
 x=1717678050; bh=Bghc2ZVam4PpydRyfm3VG04KuMplJFBqBWRRLlOos5s=; b=
 owLQIcaKmbp8WLWprGrvZj0AD69G/gL9ajXFxgg8L2J7PohjtPDesQePjbT1KDZt
 sAXRJOqphxwdg4mxCxZPD5MxJOK81ahR8MhjTg5XiUJHHgzfcLEB9h+TM2SIoZ6F
 a3rKBJQ/tj6UpVb09AgUFnpnABhsKjzDDRF7crW2t3Kp9Hn6abAe0XFWwZFIVwsA
 WxxYQX8M/Koo50J4Gc7+dlXesyByyb9eZ6qYVY1eYsKfBrJMeVaNqyjLOnO2/Qcu
 JlV5jvKAWnZkybZm67GD37iWzvTVxNRj2nsY+aWsS9PP2l6dTG8xqFm+M6MJmmbC
 9yzVja1CtFfWmqnYKw3wCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717591650; x=
 1717678050; bh=Bghc2ZVam4PpydRyfm3VG04KuMplJFBqBWRRLlOos5s=; b=N
 IPRKoXpQn6T4chSUg8TwznQCSYN0+CTtNpLTg4wF0VedfupCCt/9+M1+ckArpIw3
 3nrsGe4uXRtXdfyHdBtoZHScRhT3ol3fUsAIqCufkPw765jlJ/s0gdwru1kLS7VA
 OP2TQ4T87BgoZeQC0ibedS2dUvHtbHAY1EAwV2+REmSI17Ta8TS/HOUJARjM7E9P
 IUZZ63U5CrYk8nGSDw3d7HT7LtNfDr5T3XfMhjNYkCtNvWY//reOeKYgYEGrfzzr
 fxfQGI7J/9F+2szFJpGm+Rq5nHYaDyLUd1y3KFZPURsF61Gn1zT4jHa0dvFCtoxq
 stsbDSVkb0Z6/RVtBNG+w==
X-ME-Sender: <xms:Yl5gZhEGyLyTbD1og7QBVXBK28T-b23OVaSa6YO60G_6RLb7AgalPQ>
 <xme:Yl5gZmX3P7Tr63DIBx5gTgQjRbeiF0FCI3RybpnlaU9SANM35njjzNno42W5426l5
 iGk12z1Q2dN9yPswbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeliedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:Yl5gZjJs_dU9Xs3vnbFtYle3uEXIyf3ukLuP5lLtUBKpSEkgzWDIlw>
 <xmx:Yl5gZnFpFysXS6YtGQ6qY7hYRu22PI4Nkom7nout89i_ASF3cBc_pg>
 <xmx:Yl5gZnUvI9CDXP3kFuJx_S6ryh93LX5Zidja_PRvAqZShTwsiIknvw>
 <xmx:Yl5gZiPvYPKn44HkUqVnYehS8gK-f51krzmihTNGucOic6ioHFU7ew>
 <xmx:Yl5gZkjWtvI795VqMTznjUXYIGhgse7kVhv0N2mTMkbQKX0hOMLwtncU>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 30A0936A0074; Wed,  5 Jun 2024 08:47:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
MIME-Version: 1.0
Message-Id: <cbc243e6-b77e-4f52-88c5-04b94dad1d20@app.fastmail.com>
In-Reply-To: <87h6e8g9p3.fsf@draig.linaro.org>
References: <20240511-mips_mttcg-v1-1-1b71d9b85234@flygoat.com>
 <87h6e8g9p3.fsf@draig.linaro.org>
Date: Wed, 05 Jun 2024 13:47:10 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "QEMU devel" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] mips64el-softmmu: Enable MTTCG
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



=E5=9C=A82024=E5=B9=B46=E6=9C=884=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=881:43=EF=BC=8CAlex Benn=C3=A9e=E5=86=99=E9=81=93=EF=BC=9A
[...]
>
> I'm a little uncomfortable about making the success of MTTCG depend on
> the user options passed to the kernel.

Yes, I agree, it sounds awkward.

>
> How come a non-icount run depends on how many instructions are being r=
un
> on each core? Why is time not based on the wallclock time and by
> definition synced between all cores?

That's the problem of Guest Kernel, the synchronisation mechanism is poo=
rly
written that relies on instruction latency too much. I have patch pendin=
g to
improve it at guest side, but we can't fix it in existing binary.

This clock, CP0_Counter, as per ISA spec, is independent between cores a=
nd
needs to be synchronized by software. We can emulate it as a monotonic c=
lock
source and Linux should be happy with it, but that is violating ISA spec.

>
>> In non-MTTCG build, the execution is slow enough so kernel won't
>> observe back drifts.
>>
>> Test results:
>>
>> With clocksource=3DMIPS
>> ```
>>  ~/tmp/retry/retry.py -n 100 -c -- ./qemu-system-mips64el \
>>     -display none -vga none -serial mon:stdio \
>>     -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
>>     -cpu I6400 -smp 8 -vga std \
>>     -append "printk.time=3D0 clocksource=3DMIPS console=3Dtty0 consol=
e=3DttyS0 panic=3D-1" \
>>     --no-reboot
>>
>> 100, 0, PASS, 5.258126, 100, 100, -
>> Results summary:
>> 0: 100 times (100.00%), avg time 6.508 (55.53 varience/7.45 deviation)
>> Ran command 100 times, 100 passes
>> ```
>>
>> With linux-next:
>> ```
>>  ~/tmp/retry/retry.py -n 100 -c -- ./qemu-system-mips64el \
>>     -display none -vga none -serial mon:stdio \
>>     -machine malta -kernel ~/linux-next/vmlinux \
>>     -cpu I6400 -smp 8 -vga std \
>>     -append "printk.time=3D0 console=3Dtty0 console=3DttyS0 panic=3D-=
1" \
>>     --no-reboot
>>
>> 100, 0, PASS, 4.507921, 100, 100, -
>> Results summary:
>> 0: 100 times (100.00%), avg time 4.233 (0.04 varience/0.21 deviation)
>> Ran command 100 times, 100 passes
>> ```
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> I'll leave the test case alone as it's already marked as
>> QEMU_TEST_FLAKY_TESTS
>
> We should ensure we have some testing enabled if we switch this on. Was
> the FLAKY test marked for MTTCG issues or something else?

Tracking history, I think it was because this issue is still popping up =
after
disabling MTTCG.

I'll try to upgrade kernel used in this test.

Thanks
- Jiaxun
>
>> ---
>>  configs/targets/mips64el-softmmu.mak | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/m=
ips64el-softmmu.mak
>> index 8d9ab3ddc4b1..199b1d909a7d 100644
>> --- a/configs/targets/mips64el-softmmu.mak
>> +++ b/configs/targets/mips64el-softmmu.mak
>> @@ -1,3 +1,4 @@
>>  TARGET_ARCH=3Dmips64
>>  TARGET_BASE_ARCH=3Dmips
>> +TARGET_SUPPORTS_MTTCG=3Dy
>>  TARGET_NEED_FDT=3Dy
>>
>> ---
>> base-commit: 248f6f62df073a3b4158fd0093863ab885feabb5
>> change-id: 20240511-mips_mttcg-47a6b19074b3
>>
>> Best regards,
>
> --=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

--=20
- Jiaxun

