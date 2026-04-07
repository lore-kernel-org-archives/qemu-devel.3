Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80B0FF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABTy-0005Ml-Bm; Tue, 07 Apr 2026 14:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wABST-0002LR-8z
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:32 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wA8Sa-0006m0-9L
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775576115; x=1776180915; i=deller@gmx.de;
 bh=opS5xAT3D61OGXF6s/7aJibkFc737nz/H6Gq9pX3/aA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kC3PdTZAdKyA9HkQTqhayFDo4qkB6xWPP8uoNISPKwAlErs7Yc/3FgCK8qt1uOOe
 wQAbeEeB+OPclvyIe2OLRZ6tGkyrP7VDa0L4lV7FViPiO3YEmSYR7ojNKPNEV3FSW
 3+L+DpOVzxfk4lqpmvZtD6YcjVnrTcCcoFReCFdDuZcgOzr7w/vz0VLkAcTwOYpVh
 tQmjwLREiKS79n5TLlJ3J8KicpO9Q2WijJNi9mzQnW40YoOGH57gDV8fK4YSfBIbE
 2r7jeItrDi9hDGXhYtrPAnGd673HLb7mkATstSMTK5bMyKcdPSpnkuYsfAhtJXmNN
 XDuHw51Uz8Hy5VwR1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Udt-1w7ggE2M3N-003waa; Tue, 07
 Apr 2026 17:35:15 +0200
Message-ID: <8cfe0c9d-2acd-43f5-b8e4-acefbd4c0d8e@gmx.de>
Date: Tue, 7 Apr 2026 17:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Allow building qemu tools on 32-bit hosts
To: Michael Tokarev <mjt@tls.msk.ru>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <adGTUNUSckx1KrAk@p100>
 <91aa0c79-8c13-4421-9115-d149f31fbb1f@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <91aa0c79-8c13-4421-9115-d149f31fbb1f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ROqPvAD+y1TlLAoHhq5q7bsWfpJmM12B5K4DSqiktOe/x9a9yTx
 A2R1BBe/tpzzI+6dKA8x4eVGicBvxK5FWKMHsimqpmLSDDXL2UzvKe5FfPImDExCko0KKtg
 DJMhJEV4Sv1UazS6JAgRao5/q5Hipvt+iPGUjQ1tX0X8lw+NtCpjobsL/vR6/oWo09WYwfA
 F36stwg+4ENHhO+Rek+Kw==
UI-OutboundReport: notjunk:1;M01:P0:yogxGRUA6/U=;mElxUWHZ3SF7+i/z98Par5YL928
 ofBN7yCPyTJy48oHNrjuRtdDB3BLx775a3j/4CxICu4eR6PL4flZEFjIMFWRAJ9WV7M3IqTZe
 6Nu8Fmd6OdUhSrr7TidqzrXFks3bBB8hz2PQuksBx8ffJQd8JaeiHj/yaT/anEYFZ4GVHTrxw
 tHQBJi9Yb04Zdb+whTOvpt6JlkXxXYQ5nOYk6tXBTuWgIdsfzsRT6L7vjyeXOOOx6p4XJYemx
 4CWR7oVq5m0VQtrI/2ca2vfCN9xR4brfMKEESRFCsfY01o2/md9dJcB+++PKtlRu4/f1vj/7F
 x8Lt8YjJa32vgVKobphgcxZaFvk2YRQd4iQjfjxJunavZRbwrP9rdudZhRhqvkDOK0xLIw3Fd
 YNN8/AnnYb70QodnGWHyUpdAMcjNa73cUt4d8W326r/rEUyhd0MNceL2lGiyf2UqLY7J1NaAB
 6vrTwz3Me4btP0wX39Vt15cwev8G98jq7J4+hmrb4RvnmaYBnySS0rertZJjkGOALMj5FmP4T
 NwYpOEaUCx3TiJpaodzDEixQBCHQC+hjy4O5eRsMMqJDo5mhL4ZKCU7WTPG0JMYXTFP7z/KqF
 vos0IzZSklfBKOtOeS+M2SUI3pHcWTBfQp5JHpxtg8ULaBb4JZw7gBx7IHHAp4AN1NJJTOAAy
 HR/Oy7/SOeHkBPjXRxahjRW22l9Gx56m4/IZrk3ytQfcYd2U/WK5gq/QdjyolK+EOqqVkgx3I
 Vc1aWcISk9GRu2CUMtlyKbGeIEmzX80OJLoTh+2jQM0m0f4FBt2bxpVFCYLxOHGbCHGQZQbQS
 LlYPdLj8SJmVnn+GPkElzDcR1J2XvcQokporgKKaXKxi6l3XacXgpZEmtASsevlCb2maXNAay
 R7SI4T3EYKp6PS2cMPk5JDK+XL+kwKj/Ur7exk6j1jZbrwjchwFsHiFjAtQTl2IZ9OoZqovf0
 G0II1G+Y9ARPa77srQU67TllXahvNB2J36MR0OhA5Hgxws2zhkS63PAInIqGgan1rDZdoyIMr
 Zap1tFmTtaLHSgl1Gt5PZDzUhTVE0ALT3JV14VapzuuygfRW0O9u3hDHEUqu4rJC2MYck0LNm
 JHd/r1pTvirJ139GCn7clZenHVxOpO49dsY5ztyPkJ0JFbleBvgZoTVUX/riY6OJWX5FenF8o
 /CA14v6Rpb/hCNoboUiEw2icqKOOs2SivwhNENxIHKyt69GWvbGdJAvw/Jy5mDfFmWgZ6JIOB
 vZbXBuq+urGwEXB87LLMtC+DAjOaxb+aOP4vGCVmkv0McjpsYcbR906pP/natV9ODQuS0N3jq
 QnjXyggyQEqNM4W37ApQuEMiVbFMS7JRL+XCO0rDBoy112Ys/s6Tp8I6SrYIK2DBYsZrD6Sg3
 PXRSifcFG25CI7+uIcSJVqVvJ6ak9sGVAw1zojDJk5niq/1y/26nZlPn1NcoVtDjvbsmYfvlv
 25HhEDHPwK/Cm+2A2618BSnRiziYvqTVMr1eB37yCag/d1FNk2qxmrcoYOgMHH5l+GJhiUBbb
 1HtoQMUtMG0i5kJ9BwOi/FhTrzX2F6m9kmw4bFEa1PEP9akvQ35aw8HW6plUWd/oZOIleKwsr
 BreSQ/OE4JHABfeAeodP0GMTGQokAKLIbS2TZVExYOdRDe2rHnd/w4brpUP3F4OPJiTOxrnqm
 8vcKJRcqfIPwRuA/Ka1chT7YUVdJ2edMwcx9hfr0sJDHhE+dbEGzNv57fYzDKHTMXiHJjowee
 z72rEUtgKek8WFiUe+wxlHgyRIs6DuNRoyNh+DVFUJYaopmPSV9/KEgsKBEar0a4LjOHNUg7t
 yl84e4yJuuTLmbzLmG+X+XnUEpzIdLimw4HVBkxxLq0/lTyxYDt4s3pyo0aik3ZatRkwi22pb
 4q7HZ0OIMt05z9Lb3oCuLOs3lP3i9w9ewVeNYgwbkAC/M/6EnwyxLuAmDf6ykLFx0QhCndARV
 1yTJS8CUO5w0Cyh66JH1EXDx11YOjYkqcMl4QwkTjONE8cQ++vLC2Vq3EljKS+TEfYesmqE2j
 yXP02gRb8u3+jriEY+dxcgQpTzLRLCzAidkfm84uIyAIZre6eMhIc1i8cr7gJ/tH6Z6Ru4MFY
 /BfMJeRzmXUC1xFDD1QRC5XSerJU5kTPYRThmZZ4UoYAfuAzdSWCLL3/1WXOVOnkkWekB73+3
 k5eGwUUvIi6ZrsHAl1qJVwtzBmowwqCfccmAJ/4HPOZMzT0/86BulkD+8hsT7VM6a5l2H+UIg
 n5AH0jd1EBYmoBdobyB0sEkG7LjCdU8qqBRczGvQrFP8HyS48r3ePJFs2ikOntYJHlbzJjs04
 udAhKH1HhFZHBaMwPpxsAGe2IPXVlCMOciiKkwbzvmFlLL8Nvg2unSeK3sLCrZuz2HictuJIS
 /X26UFcqDdbyxynEKcNR7LKiq7gnIwn14Qv4GREKvDwzGWu19+vDIG+nWipGt0JEWhLcpe/q/
 vP06F395zqjxA6Cbl/mrZX/yvXMEyE2nonX4AX+H0MEWaLQ/KHIk5KRuZsNsYgqL0WEZ76iP8
 bXcnB9CImBrVwk7j7dG6gMtl/towiKyeRLZPc/6BVl5455cDEkhONXF7COhrr9MUppwCcivHe
 oDykXTvtLXjNbENY+L8y/dkOQkIGuQHILfv64Gi+O0Aq+43XYuLWg0BYrGgYZCoz5gakbqHYc
 gYhOq7WLfLtMoo2goNkeUB0TETlQheRTj3XT807R9JB/leBfyuC1p4YXiRvKnjNG2MFvGpmNE
 SEOYKq7PE7WBnG5c7datoKi7xjTR2qOBmPG35AaLQ+HRMHrVJKjmu6/fHO2uK6FB8sxvXiGYM
 5bHnSJNgMEP0T0SKlT7LHmKrqp6Z6Rv+eqQThOV0zHPAAqEtMERvIKMz4g6q6cw1I4RKyI8wl
 r4efnR96pbKgYfjNKlk3fNSTO9NL10TS9l3lGo69xLTi7laNyasYYmVFlxPEsSx0fGEPdnKFf
 17bQYHEyTzk0j3lnyg9bH//YRgCuQdARqSi77LYTEeSfs/usRNhxYWTBUNsu67CGgwRpkt+NJ
 FLKGkSs0U4ub/yvjuZsc8Ysoens/OZRjUz3k0KeLl5OHd5n7WG6PGFVesxPH2FW7eo+qQdjrE
 ft2jN1b+1DKY/Z395VKMx1ZPthf/MTK5nxXtpqwsPj0RdEPylH92XOemf4Cr9frCyQnACJ5g0
 +aIIQqfBVWXhedkj7FV5x5KDKy+oA6trBkYpVuSep2xQeIRwK9gu74dRr1+9TzUArF1K0S2Er
 3Atqp64PzMm9lUChyE4sUEXblcVxGo+fh7MAKhASS/d7jMZvoRT+If8aYRQUjx0EAeoMwB8ve
 4EuOO/8b+SugoqEhdWhveUDtrk4DymXJWym9WmTCr3TeYN0bb4v5qNxk+odVH1ASHkYHGT1Jc
 eM0EmyorA0nJcjxu6+4JNHhBuKx909rpzr5qNgB7wfJ1dkP4sm611zeAvxzFl+1494VZO1Sqy
 EUTASp2NHId7jKRHAQVDzGM9+04QYGeEElMUM+4siHgJF2XtMqO7RgkliZkwDzmciGJ1DFTSz
 49WhdtFoorvjt2qQhnrHXAb6oKZHfyidPQe7XXc8N2nlXYjDT2PFterqd+VDDKSPJLaPXNA03
 0lEGUXv15pG4XAo6XrUJTBVOAOeClNmy4bOjQNxpMv0U3sHQ0lkAEZWi67N9tPHEf82WsKRY7
 dy9SEIagVPMPbSmCb35JDw/9fgSDV23YjX7CqnroCpKT6yq2SPLwIED4FIGDwHK985eEmELuM
 V2+TfAko62YOz54TvMOyR2AsoEydSQ1WwkosQ8UmVJ6Kf3QNk1fSIBbuktA+mpc+4/fALXPeG
 VQrN6XonmCSeRj921ODS9owm33BeXO5JIFHlJzVxF0snyy/ZGUQY1gdkFsviK1dQ+WobxmbMP
 qvROMn0Nj87Rm91FNNAao+MrduuybW2SU6nAhpIDZ4o/AWrNk5PH371ubPsVZCjLchfZk1hCa
 T1jg2wZZj0/DFZmQwbmEKyU23H62FlNKXZNelrNbr2UryVmuole+Vx41N6WZ+e9/R5G7zeXa5
 +5eOsRdFbHXf03imPak0FkiupMk9kTOEKzF+vkiPN1j2Q45DE3hVs3rX7PSiC8Tn0AucHCDA+
 geaPali6aTIjKNbEfd7ViofQHvME3t7W6Aaam/qeJpbLg4Lr632WYb3YRnw3jZrNy4qM6gLnv
 r7fwhEt4+vN5bkEZ7Cryp4BG5xHA13IoYgJameds92CWrGbke5fo7khCLIYdo2JnSdHCSAW0B
 H+xRdvAtEcROeQ6zWxdNjJgZZ0yBm+5MuG2/LecGwQd1OiSkRjrACxW+oYSMxvIJ0qb+9uRZ/
 1EJffrwRmchohfQ4mS2jXAID9/qRb8EpbXONdoC71p/w+OFs8Ab+LwP3J7r2quQnhWzRrDQ6V
 DF8jXhbm5TbIECwLuT8cVRvsiLJmvDDe3E8q4EEcmHk0TnvIZADwzZ7jOydBqweqEoDzCooGx
 61OR19Ie/4pfKXS3ZG7RoHqZQQ6X9cjYTPojBqyvOfblHi0iOAD3IC2Phl3LjulWoSOhfLq57
 CHir+8viVUHtSAt1Mn9krfwYEu/bvkcwrPSZju+1Ck9rG9TpffqtLuqKtQdOiMJroxwv73zwD
 oOZfjIxF45WtCPynPgZ8rPlfMqcYyPB0yYXH/6LY1SRLMI+phLbE4jGcl6d3/pH/WCOp8yp0O
 FfSXbjnH31dRFxgiIBI3jr8ziqkpnndI+pqbS66GDiDktoOq1nmJWjedt7u7ChdrIJH/ShX1O
 bM7BWWqtkLJ1jrCA+lw0Thn128yygFa7dsQvlNikmCDgXHT+C3I0ohzGW8GACxczxe6N1WhEA
 sA+jCUYoe3Y+UR0dQMSR6jMrooQdZavKdtWpJ25ghxbb6KU9pE3ijLIXRILCpmp97ebZSrnSt
 KEMCCdYy9C0W5/aUWft0+SnK9enTCWP8OYonngEtF/7sXQEF12TWUHPFdjk8uD4yajYarC1kH
 mSV+bDQWp9UG3HHAOeKMdZcrZdzkYfRFKY5jKlw88wvmJAFOQiVddGmkFVyLlCI+vwFZIFmkm
 jbn2K83woEYB3qJ25lCkau8CSSwd3CVgAXynMYP74tXoDzi+E3/Kka1dr4M9sr4Gfok6f2euc
 p8HukZ4qgIk9IWTVE7c3asrOENa2Iueu160y/wJAkDOl6Wr8Ll5dtkQYHFIX7URH4PKaDVsI6
 XS4WBdudl5SLLvCcMj9TNIIod7dW6lVdEi0l8i5UxJ/LcPNuQMi0UJ3kBRhhlZT3diLVBssh2
 iPK/yoI9BV7oWfBvIdfRL6tXXat0xEk3X8bkUAxpdETdcU3k4EbPetV6jiqFjx3miG923+49n
 xJWyMi2waFdFI82p/146Y209G1CDLYepgBFfas1Ex52SbQF/pZoDJI=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 4/7/26 17:12, Michael Tokarev wrote:
> On 05.04.2026 01:40, Helge Deller wrote:
>> Qemu's tools like qemu-img are often needed on 32-bit platforms,
>> although the actual qemu emulators have been discontinued on 32-bit.
>>
>> To allow building the tools on 32-bit this patch implements three small
>> changes:
>>
>> a) The check in meson.build is changed to still error out if the user
>> tries to build qemu-system or qemu-user on a 32-bit platform, but allow=
s
>> building tools (e.g. by "--enable-tools") alone.
>>
>> b) The compile time check in atomic.h now checks against
>> sizeof(uint64_t) so that 32-bit environments can still build
>> successfully, while 128-bit atomic operations are prevented to sneak in=
.
>>
>> c) Allow linking against libatomic as long as we don't build the
>> qemu-system and qemu-user binaries.
>>
>> Sucessfully tested on the 32-bit big-endian powerpc architecture.
>=20
> Hi!
>=20
> Have you used just one additional fix for util/meson.build from me, or
> all other changes from Philippe too?

I used all...
 =20
> I'm trying to verify if I can build qga and tools with just two patches
> on 32bits, or if all of them are needed.

... but I didn't checked if the others were needed.

Helge

