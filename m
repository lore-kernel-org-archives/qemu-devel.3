Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35E9CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 22:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrmSf-0003hH-W2; Tue, 02 Apr 2024 18:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rrmSe-0003fi-4O
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 18:18:32 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rrmSZ-0003T2-BS
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 18:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712096301; x=1712701101; i=deller@gmx.de;
 bh=IAcOAzt4DGk0YqkzlvEZhVJ6erA+CKyRopjgbOvfDfI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Q0fBe/1slrNb60KbZu4SHRSFXf7++Oy8eIN4kURbKrtecPjPhjQv/WmE7tx+VYUq
 TW7Rd7MIXx7pFzk1inpEzapnMgKLa5v3Cs6Q4iIEWx0HVAjdAtatzwB2AYADjJKFC
 2eJXBaGzs4cuYK6VwPqQmtCs8Bt/V6v/yy6kbe1qXa0Th7QHps4eO8eVl2aiXarbB
 uyL0MmrUtmgq09z43MbVGk+VckQA2dpiC2MhSFEH6fcs4EpyTYF/QIiOO88QJXD6S
 hUEltzKqxl0ngkapYkBN6Fldw07NaRbDiP/+gNZCmE9P6yAiIZ10D52Aasulyh+n2
 qsnE8bd00yixpC9P1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf078-1sTcRy3BdK-00gYYz; Wed, 03
 Apr 2024 00:18:21 +0200
Message-ID: <757a3716-67ac-4305-b268-a5b053edecdb@gmx.de>
Date: Wed, 3 Apr 2024 00:18:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hppa: mask offset bits in gva
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-3-svens@stackframe.org>
 <ec050630-a866-4a51-8878-d35844fb66a6@linaro.org>
 <87jzlm1334.fsf@t14.stackframe.org> <87sf04xpzi.fsf@t14.stackframe.org>
 <a8130b3e-c80b-481d-970c-880353d22e23@linaro.org>
 <87o7asxooa.fsf@t14.stackframe.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <87o7asxooa.fsf@t14.stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bq7L25s57wg8DEjktk9EReZqbfIdaq+vAFD1F+D7fhBcXv3iQ6r
 mxme/cHMDFOE0SbvxTeKvgVbt2P/KLCsKwuyz7fOfp1dLQfMma8/I2PaE9Om4V5C9G9g0+M
 boOAhD6/eJr+pkEhS+B0zHUnFwgGQ01OeGMCgwILqUoVmtq2l37a96BsZn25r5F3bQCFCgA
 Il8Vdt1tKS8oKlt2QKKjA==
UI-OutboundReport: notjunk:1;M01:P0:Dd9M9ach+bw=;Uq/jDObnp4llRrcslaBYwwalF9/
 O/ZPa3JR1EP5iTfwf7P9kheU7AzkxLsmpnpjwCSjAyWOqqm6qMvH0B9OYNPDgNeb/04XcEodr
 FhVUZSfmxIkvY+Y6j7K1bc8WFz0HamhcPlikr1Zz/kKf6ITZ4E52RUraZ2CaU5ep3zkoCPlKd
 ZpYIMDJ7Mg4zDEQ17fbuk/A70fFFGPCNXSRBlRGm/I4hAdlO6HidLrzU0gAtsn8lT/w/lQjFs
 aZirnHtW595wfOmOQshgyjYRLw3haS+7F+iw95PCrxVfZIzNitR8LvH//AI/eIW1W0DjZ/AIH
 /vsJ5c5+50OVBqZX/jLmV4kQrMNXG94oASoADQQduSWf9n3Ni9knbV1S1p+dhT1tStJU+RYtA
 FCbQ1PzTHh5/5RO1Q/h02sU75jynl4oJ7Md9cTKZogBROf5vkKGiyZjQIgH4j91zy6ws1sOZm
 wjzXCJBXQHV6uogzI0FLhX/5kzQPChRAXhhUMWrfoqn74FemjInBWpalsYeLng0X8tGKbFHJT
 kvrVJeqXuozwPzi6TG6sfG/Tdvgx9YlPWlxTN76vQTX+3Kl8nO89Z3asVvtM0wWv4mzWLnCE8
 Fk2KR275QFksN1cC8ZYkCb5NP/skUXa0YVhYml89G2iQcaUi7drCdT+JZsVm11rR7RSSL5YlJ
 0y7MDupUHB9tA4rWZVkejsLV7JpArnhtNEe75YT+KKRhnFrU0vJfPkjfqtAdPNmBwuiQkCpKN
 aWtGmO+P3KqNnlx2ySPITutYcHnKB2TDPqMgTP22O2Xx6YbU1Jn/YEoF4QzFy2sQObMAnnuIu
 7OFAN+9idTjSjBG/PX0q0rLcIf9lylDnHoL/bHTzH4I2k=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 4/2/24 08:29, Sven Schnelle wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> On 4/1/24 20:01, Sven Schnelle wrote:
>>> Implement dr2 and the mfdiag/mtdiag instructions. dr2 contains a bit
>>> which enables/disables space id hashing. Seabios would then set
>>> this bit when booting. Linux would disable it again during boot (this
>>> would be the same like on real hardware), while HP-UX would leave it
>>> enabled.

This is how it works on real physical hardware, and since qemu should mimi=
c
real hardware as best as it can, IMHO we should implement it exactly like =
this.

Helge

>> Pointer to documentation?
>
> There's no documentation about that in the public. There's this code sin=
ce the
> beginning of linux on hppa in the linux kernel (arch/parisc/kernel/pacac=
he.S):
>
> /* Disable Space Register Hashing for PCXL */
>
> .word         0x141c0600      /* mfdiag %dr0, %r28 */
> depwi           0,28,2, %r28  /* Clear DHASH_EN & IHASH_EN */
> .word         0x141c0240      /* mtdiag %r28, %dr0 */
> b,n           srdis_done
>
> srdis_pa20:
>
> /* Disable Space Register Hashing for PCXU,PCXU+,PCXW,PCXW+,PCXW2 */
>
> .word         0x144008bc            /* mfdiag %dr2, %r28 */
> depdi         0, 54,1, %r28         /* clear DIAG_SPHASH_ENAB (bit 54) *=
/
> .word         0x145c1840            /* mtdiag %r28, %dr2 */
>
> So PCXL (32 bit) uses dr0, while 64 bit uses dr2. This still is the same
> on my C8000 - i see firmware still contains code reading dr2 to figure
> out whether space id hashing is enabled. The mfdiag/mtdiag instructions
> are described in the PCXL/PCXL2 ERS.
>
> https://parisc.wiki.kernel.org/index.php/File:PCXL_ers.pdf
> https://parisc.wiki.kernel.org/index.php/File:Pcxl2_ers.pdf
>
> There was a discussion mentioning disabling Space ID hashing in Linux:
>
> https://yhbt.net/lore/linux-parisc/199912161642.IAA11478@lucy.cup.hp.com=
/
>


