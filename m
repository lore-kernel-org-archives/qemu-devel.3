Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E17C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sERG7-00007q-LE; Tue, 04 Jun 2024 06:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sERG5-00006w-Tm
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:19:13 -0400
Received: from wfout3-smtp.messagingengine.com ([64.147.123.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sERG3-0003Eq-H7
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:19:13 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id 905F81C00131;
 Tue,  4 Jun 2024 06:19:08 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 04 Jun 2024 06:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717496348;
 x=1717582748; bh=2F8GYSiR19+6U8AQRqQhZDgSqta7Qx5+P3UAbFzWvvM=; b=
 Kx9MBl5Q3AzekLAac5GGzlXLKIbrflRSmDdXiXie23aZLazZYSc4Q5//pJswb7Rv
 4f4tNYx4oR4PxMO26XIxkRztLzJbWiZcjS+vpqOANcR7iLiwJwQ7/B6F8kEM01Zp
 RDiAWauBcWMSLcDJj0tt7tHfhpCrpiUlcqI+vLv1erB8UlogdLVfq0ehNl91wR3f
 ssrfWcn0h5QmLRv/fH/finmHZa8geKTA8b64VVkZEDD9Lpj/Vl2X22l7c/kSK6bQ
 a76Epmwajd0Da5uGH3u5tfbYYQ/P8OA78CzqxZbZSOqN/fdYx5bW8MEjmbZXrsIA
 lLx9v1HhUTMbF8BvqahEbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717496348; x=
 1717582748; bh=2F8GYSiR19+6U8AQRqQhZDgSqta7Qx5+P3UAbFzWvvM=; b=N
 MdeWCJclTaGhup5uTDeAH21K/i/yMdE075pnY6UwCGwZ0lFLiPhNkCGMzDJobygK
 ncASxUM9nfdF3xV+1qT8D4O/+wdYezbS+yTwZc/W86YiHy52tb0E0TBtzjRPc+PA
 +uVUp3dat7M1AvM0hfMydte1WT0Cm1yl2zalGn9eDj6wRqcJ4v0GsuBezPNkJI3n
 w7SuNTyUcK6rIRgq9xbfIiDaXC5Fs6JZ5nYFdt12fheexo9WsyjY1/XIQcK5FBiB
 D3g3nwBAEM+f0WOaoDtac1MaZTl5VYa7NsM/6z6XD3GFk+DgxgJejS5+1DYrvTGs
 n/y1THgTXvk7avBo1iEKg==
X-ME-Sender: <xms:G-peZmaGokXxS-fxzs0RVsAKRt0WbtStDx6JC4JAUaKAc83ibkCU-g>
 <xme:G-peZpb58Ez_eDbe3eL4rOaTt1ufZ4x7oDLmKlaU4-1YamaOdt4cKtNgyl0du9UoQ
 MC195R_8cnOAKiZj1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:HOpeZg9hf2QVldPFbZEH0S3ks0ZR751C1oOgkbO4Yn0uPtfTmWFUwQ>
 <xmx:HOpeZoo5J_zYfUxqgMpH0zjxxB6fNcbsyA3hmQ1mvu1hN-UzKjDzQQ>
 <xmx:HOpeZhpA4Y0aITbUY8nn3_eN4_G4Es_x0838O9Amk8x-ypNx3ZiIzw>
 <xmx:HOpeZmRDXu0TGRbDBikrcV1vcBN7RO9KYwXAvp7dQ77SRiZIvtaLFw>
 <xmx:HOpeZo12ZlfBBUb9TJKh54PS0aeQlRCtbZAUshFoQ3DUPT5UbTJgoh9Q>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D43BF36A0074; Tue,  4 Jun 2024 06:19:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
MIME-Version: 1.0
Message-Id: <20434032-e5a7-4f3f-a029-3dba9e4400ee@app.fastmail.com>
In-Reply-To: <f1e66166-0e06-4a02-8d88-9faad1f0274b@linaro.org>
References: <20240511-mips_mttcg-v1-1-1b71d9b85234@flygoat.com>
 <f1e66166-0e06-4a02-8d88-9faad1f0274b@linaro.org>
Date: Tue, 04 Jun 2024 11:18:49 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] mips64el-softmmu: Enable MTTCG
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.146;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfout3-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B46=E6=9C=883=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=887:15=EF=BC=8CPierrick Bouvier=E5=86=99=E9=81=93=EF=BC=9A
> On 5/11/24 13:26, Jiaxun Yang wrote:
>> MTTCG was disabled in a092a9554771 ("configure: disable MTTCG
>> for MIPS guests") due to test case instability.
>>=20
>> I was able to reproduce this issue with in latest QEMU and look
>> into reason behind that.
>>=20
>> What actually happend is kernel's CP0 timer synchronisation
>> mechanism assumed a consistent latency in memory access between
>> cores, which TCG can't guarantee. Thus there is a huge drift in
>> count value between cores, and in early kernel versions CP0 timer
>> is always used as sched_clock.
>>=20
>> sched_clock drift back on some cores triggered RCU watchdog in
>> some extreme cases.
>>=20
>> This can be resolved by setting clocksource to MIPS, which allows
>> clocksource to drift together with sched_clock. However this will
>> leed to other problems after boot.
>>=20
>> Another option would beupdating kernel to later version, which
>> will use GIC as sched_clock.
>>=20
>> In non-MTTCG build, the execution is slow enough so kernel won't
>> observe back drifts.
>>=20
>> Test results:
>>=20
>> With clocksource=3DMIPS
>> ```
>>   ~/tmp/retry/retry.py -n 100 -c -- ./qemu-system-mips64el \
>>      -display none -vga none -serial mon:stdio \
>>      -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
>>      -cpu I6400 -smp 8 -vga std \
>>      -append "printk.time=3D0 clocksource=3DMIPS console=3Dtty0 conso=
le=3DttyS0 panic=3D-1" \
>>      --no-reboot
>>=20
>> 100, 0, PASS, 5.258126, 100, 100, -
>> Results summary:
>> 0: 100 times (100.00%), avg time 6.508 (55.53 varience/7.45 deviation)
>> Ran command 100 times, 100 passes
>> ```
>>=20
>> With linux-next:
>> ```
>>   ~/tmp/retry/retry.py -n 100 -c -- ./qemu-system-mips64el \
>>      -display none -vga none -serial mon:stdio \
>>      -machine malta -kernel ~/linux-next/vmlinux \
>>      -cpu I6400 -smp 8 -vga std \
>>      -append "printk.time=3D0 console=3Dtty0 console=3DttyS0 panic=3D=
-1" \
>>      --no-reboot
>>=20
>> 100, 0, PASS, 4.507921, 100, 100, -
>> Results summary:
>> 0: 100 times (100.00%), avg time 4.233 (0.04 varience/0.21 deviation)
>> Ran command 100 times, 100 passes
>> ```
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> I'll leave the test case alone as it's already marked as QEMU_TEST_FL=
AKY_TESTS
>> ---
>>   configs/targets/mips64el-softmmu.mak | 1 +
>>   1 file changed, 1 insertion(+)
>>=20
>> diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/m=
ips64el-softmmu.mak
>> index 8d9ab3ddc4b1..199b1d909a7d 100644
>> --- a/configs/targets/mips64el-softmmu.mak
>> +++ b/configs/targets/mips64el-softmmu.mak
>> @@ -1,3 +1,4 @@
>>   TARGET_ARCH=3Dmips64
>>   TARGET_BASE_ARCH=3Dmips
>> +TARGET_SUPPORTS_MTTCG=3Dy
>>   TARGET_NEED_FDT=3Dy
>>=20
>> ---
>> base-commit: 248f6f62df073a3b4158fd0093863ab885feabb5
>> change-id: 20240511-mips_mttcg-47a6b19074b3
>>=20
>> Best regards,
>
> Hi Jiaxun,
> Thanks for your analysis!
>
> We should see to update concerned test in another series.
> I'm not sure which way is preferred between updating kernel used or=20
> changing current command line.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I think updating kernel can prevent further problems.
Will test with latest Debian kernel.

Thanks!
--=20
- Jiaxun

