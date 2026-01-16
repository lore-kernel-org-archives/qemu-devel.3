Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861D2D4A5FF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 05:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgc4B-0000wA-SK; Fri, 16 Jan 2026 00:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgc49-0000ut-Q5
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 00:08:09 -0500
Received: from 1.mo552.mail-out.ovh.net ([178.32.96.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgc47-0006U0-CE
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 00:08:09 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.75])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dsntB4bg0z5wCb;
 Fri, 16 Jan 2026 05:08:02 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 16 Jan
 2026 06:08:02 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G00145caa022-23f6-4a57-ace2-8976056a36a0,
 356448E47ECF6FF3573990070D4D23F6C14CAFA2) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <14e4bfb8-9458-4f75-a479-878ef8d286c0@kaod.org>
Date: Fri, 16 Jan 2026 06:08:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] pc-bios: Update vbootrom image to commit
 1c8e9510b22c
To: Jamin Lin <jamin_lin@aspeedtech.com>, Nabih Estefan
 <nabihestefan@google.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Troy Lee
 <troy_lee@aspeedtech.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "komlodi@google.com" <komlodi@google.com>, Kane Chen
 <kane_chen@aspeedtech.com>
References: <20260115023758.3600447-1-jamin_lin@aspeedtech.com>
 <20260115023758.3600447-2-jamin_lin@aspeedtech.com>
 <CA+QoejUkn14qq49A5RF5iVUCrcdBN077Ce0FZSw8sWAQ+vU3EA@mail.gmail.com>
 <157bdec0-64f9-43b8-b42c-cf29a34d083b@kaod.org>
 <TYPPR06MB820664D78B0B4F5A780822B8FC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB820664D78B0B4F5A780822B8FC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: c2186ff6-6b9b-41cb-bf67-7e24d6aec17f
X-Ovh-Tracer-Id: 14389563759583071084
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE06g46XlLcUHTI9G4MiA1LOUXKV82j82/gtXnoEigDFjWM/rht/6wlOCc8GEtCer6F6KOPPPr4Nu2FGtcehrMEXGL0+7CfG5Os5IpH3dgMIaOPg3tgtabbOH+GQXIA3mNRGpdIqXu1OPRSPwAMw3UBRQTPBN/VisOIBVhywilxOCHYgYgFc6NyMLCLyBeSBQfI34aASLi4YTdmJ2jbXIidr37KZSqTA9wZzVzXcvC9hq/JEH0wOPH8Mdt8Owcyh6/Z5uxnE5aHbpoDH7lBVagasQx9AGtIsXzPNnBiTXA4oj/A+h6u3CbpyniYznuZdh4wMMxxp2JT2LHfuxWDxHmOPPgE8rMa601SpvP0K7xPg4FRTaC94p+MbQDOAk+Ok5IfK7ekim7JE1yDAQRYwuFlQo98YeVoL0eddBrLvNLYLuIH9IgwUoAGih1lDuaQlhnaUuWz9ENoS7Gu5hF2ZoRLHG5ngVnkq12B9WvQaok4X47/+JpeLSH9aMpBT+QaMKPRHRPxTMHGrKe7L95EMBeVztvabp61AIESFYNyf129Lbr7MpYQ9IQOZYM9ms8DoFjE8PSdcFSawx45MwMVD2Ojqse3YGI8IwP6RaQrmxL3WViuewCeCjGxQK0QmypJAPosXTWUiHVIOkkK+fn/vUS05yST3Zl4xwNObz0aW5iA3Q
DKIM-Signature: a=rsa-sha256; bh=6xEp1dEIP6X0WpIwQnavRvua8F5kd/4PSp18vaGo6B8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768540083; v=1;
 b=KnVxqz7BzVv0RR/6t8poukCC8M996G3vMnjvrzEv4tcF6j7LtSwGer1tA0W5pAgorq2PMvrB
 dclK+0vl44TKRBsia1x7tGziqHmUqP1djnGz5EnQLU1SWXIWTZhKHZ8BpKiLrrPeko/KRdBtXir
 Mo59YG5X0+r70+DZPu/jAs+w5mTu0yJL/xNVaPTDeAj7RmtK/r3r/Zmkisa6hJC++lG2t/EffPM
 rk7DdsfwX62n7DWAJGH8OjQZ51UecDd3XUmV7j5fagKg8nvYF/sUlvhv1QWTyqh3zwvlU4AxO3u
 bu8dMJnI4jZPF5as4XRFBgscRsANQlRHvWsaRLCxZH0Lw==
Received-SPF: pass client-ip=178.32.96.117; envelope-from=clg@kaod.org;
 helo=1.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Jamin,

On 1/16/26 02:20, Jamin Lin wrote:
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Friday, January 16, 2026 12:21 AM
>> To: Nabih Estefan <nabihestefan@google.com>; Jamin Lin
>> <jamin_lin@aspeedtech.com>
>> Cc: qemu-devel@nongnu.org; peter.maydell@linaro.org; Troy Lee
>> <troy_lee@aspeedtech.com>; wuhaotsh@google.com; komlodi@google.com
>> Subject: Re: [PATCH v1 1/1] pc-bios: Update vbootrom image to commit
>> 1c8e9510b22c
>>
>> hmm, I didn't receive the initial email.
>>
> 
> Cédric,
> 
> I used the following command to generate a patch to update the pre-built vbootrom images:
> 
> git format-patch -o ../v1-patch HEAD~1
> 
> However, when I ran get_maintainer.pl, it could not find any maintainers and printed the following message:
> 
> ./scripts/get_maintainer.pl -f ../v1-patch/v1-0001-pc-bios-Update-vbootrom-image-to-commit-1c8e9510b.patch
> get_maintainer.pl: No maintainers found, printing recent contributors.
> get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

Weird. MAINTAINERS has :

   Nuvoton NPCM7xx
   ...
   F: pc-bios/npcm7xx_bootrom.bin
   F: pc-bios/npcm8xx_bootrom.bin
   F: roms/vbootrom

We do lack a MAINTAINERS entry for Aspeed :

   F: pc-bios/ast27x0_bootrom.bin

Can you please send an update ?


> 
> fatal: ../v1-patch/v1-0001-pc-bios-Update-vbootrom-image-to-commit-1c8e9510b.patch: '../v1-patch/v1-0001-pc-bios-Update-vbootrom-image-to-commit-1c8e9510b.patch' is outside repository at '/home/jamin_lin/upstream/qemu/vbootrom/qemu'
> qemu-devel@nongnu.org (open list:All patches CC here)
> 
> As a result, only the mailing list was suggested:
> Eventually, I sent the patch using the following command
> 
> git send-email -cc jamin_lin@aspeedtech.com -cc troy_lee@aspeedtech.com -cc --to qemu-devel@nongnu.org --to peter.maydell@linaro.org --to clg@kaod.org ../v1-patch/*.patch --no-smtp-auth --smtp-domain=mail.aspeedtech.com

Looks correct.

I hope my provider OVH is not silently dropping email :/ The same thing
happened with an email from Kane. Was any email returned to you ?
  
> It seems that I included you in the --to list. Do I need to resend the patch?

You do need to resend for another reason : roms/vbootrom needs an update too.

Also, for updates with large binaries, for FW updates typically,
we prefer subsystem PRs :

See an example for a SLOF update from Thomas :

   https://lore.kernel.org/qemu-devel/20251027074404.25758-1-thuth@redhat.com/

Some docs here :

   https://www.qemu.org/docs/master/devel/submitting-a-pull-request.html

Ping me if you need help setting up your environment,

Thanks,

C.



