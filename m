Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692FAC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 18:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnND2-0000QN-80; Thu, 21 Mar 2024 14:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rnND0-0000QD-LP
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 14:32:10 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rnNCy-0004Zs-NB
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 14:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711045923; x=1711650723; i=deller@gmx.de;
 bh=HM68tCejQ1XydybTN+wteNZtPSHOQ+ipT7KfDFhN6Xs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=LeTfLARiKoYC2hTgWK5qkL0MtaSDgOAv27UzeMqxevg8l9flpO448t+ovXxfQXGb
 /qwwh92M/GcMqPFR8JQQpWg0+vjpKZqm/3szoJyq0iqdUASlXMe6IYsDuFQ7DV9h0
 sNrhQy9E/srjKcdRt13Rewcpx4psAfmUPehUlpb2OZUrXddb9t8H+hH6kAa+nIpiG
 YhiXLwUlLJAVCLj4aLRniFLD/u3jf0/0e2t2yLv8Tuzh5tIS8lYUZFNm8KkxGKsIO
 1RMIQ/X+hftj54r8rOLbEZ6WSRNSSnFaNCIZlsnTZRzAff2joCjEBhJeiTXBJvxuz
 hCPO+76wDeSKt+9PnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.183.166]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNJq-1rJ0Vs3R4c-00VSgF; Thu, 21
 Mar 2024 19:32:02 +0100
Message-ID: <ebd05b86-ba9c-4d66-8a4a-f28dc03d15a8@gmx.de>
Date: Thu, 21 Mar 2024 19:32:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] target/hppa fixes for 9.0
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>, Michael Tokarev <mjt@tls.msk.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240320003223.554145-1-richard.henderson@linaro.org>
 <812ed94a-1231-492c-bcbb-60a72c059eb4@tls.msk.ru>
 <87cyrnmoha.fsf@t14.stackframe.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <87cyrnmoha.fsf@t14.stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+/bNcRjfzgC73zvyD0H7QQy0TVigLfQLacthi5m/E+RoKC4ILLY
 +fY5AqnewEYV0s0RUBx8OGKvnjBNo9dq/TZ7k5dK1w0RXChFdoCOg/JQveob0B/CfAFpHNz
 bcH/4QSFEstG1uxPai4OLmNr7mYclZVY31Ojuky8FPp9/7mzA9GS1WhSgyJLWiiRZ8EN+zF
 GPfu54CBJLOWbu6EK2euA==
UI-OutboundReport: notjunk:1;M01:P0:63xM739lqes=;lqTzubR5rvTurncOP2k2r8Wcufd
 rYIvgFdMX3kjFZQHb59efUqp1bICHob8Ras79yIrcX6bi9oMgfG5Yx8vxHZM1LGr0KLgy5APv
 ibW6SfZmN8aJcu9XoX7uvw7ylQgzs4SEk8Wj0Ri5NnsWwa+h5lapAE472BpgpQM3ikUwgpkzj
 4tCy3f6Gk89G/h/vvFBqCmNh2weFQbGL+H06/cqmgtZEZWFtVlILIe/SUuJ3KVxLOyk3pMe3Z
 E1Kcq6DNqf0JgTdwEt5a8Ya2OMCN/F2R0DfhYDdqZHQ5wpfJ7POtKGmrH3nGfRZCmg/elCUp0
 IGkcUiqwcvy7f7NghDqbioqE4c44X6zNXm7rId4TsUnlZHRBpIsfn+JO/dNgappzG+WLkFrJ4
 vOhSv7+qjccHEg7iLvgwZzWxoGdCLSdFwI3lSbmxlZ4vpSVkBEN6P8e+6Q6+tRXY9w/gDsf8B
 JVcE4fLFlErfNybenKTij4S2obdsn/VLGoMn55fQ2qcVkKEC6FqwqkptLrp4EQlUGx/H8kD3+
 QFl/zfl9NAhlRquNaAGBNsJY2sz4Qw0Ko0c49QV12VhhGHhY9+iDGkLQlCkzujIiKIlflnanr
 aNs6OmmoyXYwn1/OZDZQjhBPT2L6u+V3gwxYw3l1mVc6C1t0u+iZ5fwqAuClLzrmG3mvrxKwp
 pm/6uiHmnnTLSaiw2JeW6yT0OtJRToiyOay3/lDc2c/e2HiGbxcWp4/+OVrzpAcRq40aPC3+z
 Py93CJ2TGHu0xY5tFc+lNdR9IGzFQTOcx1SzuMnS2PdWgv0EhA9vvS20QytwZD+SqlR+WiHqE
 63rzYx4Pns135ZzIf1vBYtk+CZYChJScmV71Ta+mx84Q4=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/21/24 19:25, Sven Schnelle wrote:
> Michael Tokarev <mjt@tls.msk.ru> writes:
>
>> 20.03.2024 03:32, Richard Henderson :
>>
>>> Richard Henderson (3):
>>>         target/hppa: Fix assemble_16 insns for wide mode
>>>         target/hppa: Fix assemble_11a insns for wide mode
>>>         target/hppa: Fix assemble_12a insns for wide mode
>>> Sven Schnelle (6):
>>>         target/hppa: ldcw,s uses static shift of 3
>>>         target/hppa: fix shrp for wide mode
>>>         target/hppa: fix access_id check
>>>         target/hppa: exit tb on flush cache instructions
>>>         target/hppa: mask privilege bits in mfia
>>>         target/hppa: fix do_stdby_e()
>>
>> Is it all -stable material (when appropriate)?
>
> I'd say yes.

Yes.

Helge

