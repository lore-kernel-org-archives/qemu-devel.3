Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C0606A6A5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=UNuYWFaU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUXol-0007fV-Uv; Fri, 20 Nov 2026 18:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xUXof-0007f9-4F
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 18:14:50 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xUXod-00074c-34
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 18:14:48 -0500
DKIM2-Signature: i=1; m=1; t=1795216484; mf=PGRlbGxlckBnbXguZGU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=; d=gmx.de;
 s=s31663417:rsa-sha256:F6YcCDJC1kmllsTBChYtJuoOY8ND
 PNm7wk7aVXyPH/WQ4uO6a9TxEbJqv8u5TzE5ri9/3M4piqH3UDMEMxhxN79x3vfp6htZzrw6d32
 FT2QScUwUBJr2JeVcNv6suabux5MxSO/sTq5DPhJfjamkq+bgKAlosEQ+4HFN1bSDqSljLq53+S
 jge1QJHQjTdZUHj+X/HmdIaLRuTHWd1JDsb6bAcg0yj3qplzuCKSoN6zYQi3qaqIhNc+rHR+pzQ
 yMs0acDraolCmwm10cargDRt7xufXR6IlZYxCPKOXAG/84UNP5BmYjCl8KmfdGUtrDyo6/eLp1M
 AU3muslyQTX+RA==;
Message-Instance: m=1; h=sha256: spc/GY7QJcfDPX1qCG4U6DWX6blMkT5n6ej42rxIMb0=:
 W50iyg1SPpO1VvskbwrgNLh2gYBS2LUxXSjOGYt2/QM=, sha512:
 4meGm6L3WU4mAeifx4Q80immCEz18rgkmu4SK96HNV9vF7aC9/+XxhkZnvC+dlg6qnGQ7A6Yn/21VGnRm/TfCw==:
 UtWO8757E279NBisfikiUmUxYUuEuabHOeJr7ombHCS7NEvE8tJS1/TTNqrXLLO5IhX3ECZdQZ6lUCprvQ6AYQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795216475; x=1795821275; i=deller@gmx.de;
 bh=W50iyg1SPpO1VvskbwrgNLh2gYBS2LUxXSjOGYt2/QM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UNuYWFaUq4PPqEeQ2LmZ1Cfxh8zTfyijhKMFIFWAPmfDDPwx2fSthOidHoWI0kc9
 FKTV4AIJMYJ6dY+QD7BRPqBu1MWT4SbGdpWDHtx4OEBBxqZYBrZFC/qS6RH5QMkYl
 onVqQLXiVlJ1hAJoXkXKLn4dJ6GHA0EaB+CVeEvdkZk5tfKS+5g18gFIY1J9g3cwM
 chVFrhHNjO08zEFekDHp5YVM/KZZjP6z/wbsPH1AiT7oj8dS/u++f8cpBHTlm1bNq
 8n7/5J9I8x+/1ZHNtiXUmRRhrFlf8g9XY8c5r2970nMlWgikWM8dTFXHuiCb3SvHz
 a27uUikAnZys/17lrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzfG-1xvSbA3PTG-00Sa3q; Sat, 21
 Nov 2026 00:14:34 +0100
Message-ID: <a1a3427f-799c-4e35-b4aa-7b19a0e57953@gmx.de>
Date: Sat, 21 Nov 2026 00:14:32 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-11.2 v4 00/14] nc53c710 rewrite
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Fam Zheng
 <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
 <dfbbba97-a182-4f5e-acd1-c962285ff463@oss.qualcomm.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <dfbbba97-a182-4f5e-acd1-c962285ff463@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:on1cLy/JCOn4AZ33zGMbh+1S2PInWEVz25rQz5WRRql61Rg0vnZ
 CfbrF1ekre9VKLy/R04jrsNKUjHr9eZstGiZXM48cCwVM1zRzJbXv/EpbL1Y2fg9w+Y9BOq
 DDo5nsScZZ+BsilL/LhI4wV74lMmAiAY/NIYroEpL4W0us3fNWvA9Kl4qLpF8aqVIBizqHw
 bMvdOih54NLLut2E6n/Lg==
UI-OutboundReport: notjunk:1;M01:P0:VNjocFql/AE=;n/Cm2SkS5mZh78gqWkXfGpXtek5
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 18:20, Philippe Mathieu-Daud=C3=A9 wrote:
> On 20/11/26 18:12, Philippe Mathieu-Daud=C3=83=C2=A9 wrote:
>> Fourth attempt to replace the existing 53c710 driver by
>> a new driver based on the code of the lsi53c895a.c :)
>>
>> Used LLM to decompose v3 as logical / atomic changes when
>> possible (didn't work well with the rewrite patch).
>>
>> Fixes extracted first so could be merged for v11.2 (patches
>> 1 to 5). The rest is the rewrite, so up to the maintainers
>> (Helge, Mark) and is probably OK as hobbyist-only code.
>>
>> Since v3:
>> - header split, Suggested-by tag (Zoltan)
>> - I couldn't figure the "hw/misc/lasi.c" change so dropped
>> =C2=A0=C2=A0 the comment about it.
>> - Dropped "move to COMMAND on CLEAR ACK after MESSAGE REJECT"
>> - Split rewrite patch as separated commits:
>> =C2=A0=C2=A0=C2=A0 - base engine
>> =C2=A0=C2=A0=C2=A0 - asynchronous completions
>> =C2=A0=C2=A0=C2=A0 - synchronous drain
>> =C2=A0=C2=A0=C2=A0 - HP-UX MESSAGE REJECT quirk
>> =C2=A0=C2=A0=C2=A0 - reentrancy guard and reset-time request cancel
>>
>> hw/scsi/ncr53c710.c is derived from hw/scsi/lsi53c895a.c which
>> is LGPL, the rewrite is now declared GPL-2.0-or-later.
>> hw/scsi/lsi_scsi.h, which is moved verbatim from lsi53c895a.c,
>> keeps the original terms: its header says "This code is licensed
>> under the LGPL." with SPDX-License-Identifier: LGPL-2.1-or-later.
>>
>> Series reviewed against the NCR 53C710 data manual but totally
>> untested (I don't have guest code to run), thus compile-checked
>> only. I haven't tested whether the series is bisectable.
>=20
> This is only a split experiment if Helge/Keith/Mark/Zoltan want
> to pursue, I'm not going to respin.

Thank you Philippe!
That was very good work.
The result is pretty much the original (and yours is actually a little bit=
 nicer though).
I just gave it a runtime spin, and it booted Linux nicely up to a prompt.

>> Keith Monahan (9):
>> =C2=A0=C2=A0 hw/scsi/scsi-disk: Add quirk_mode_page_no_flexible_disk, u=
se it on the
>> =C2=A0=C2=A0=C2=A0=C2=A0 715
>> =C2=A0=C2=A0 hw/scsi: Move shared LSI/NCR definitions to lsi_scsi.h
>> =C2=A0=C2=A0 hw/scsi/ncr53c710: Rewrite the 53C710 SCRIPTS engine
>> =C2=A0=C2=A0 hw/scsi/ncr53c710: Deliver completions from bottom halves
>> =C2=A0=C2=A0 hw/scsi/ncr53c710: Drain asynchronous transfers in the reg=
ister write
>> =C2=A0=C2=A0 hw/scsi/ncr53c710: Append SAVE DATA POINTERS after MESSAGE=
 REJECT for
>> =C2=A0=C2=A0=C2=A0=C2=A0 HP-UX
>> =C2=A0=C2=A0 hw/scsi/ncr53c710: Guard SCRIPTS reentrancy and cancel req=
uests on
>> =C2=A0=C2=A0=C2=A0=C2=A0 soft reset
>> =C2=A0=C2=A0 hw/scsi/lasi_ncr710: Map the full LASI SCSI module page
>> =C2=A0=C2=A0 hw/scsi/ncr53c710: Bump the migration version
>>
>> Philippe Mathieu-Daud=C3=A9 (5):
>=20
> Oops here author should be Keith Monahan?

That's easy to fix for me.

Thank you!
Helge
 =20
>> =C2=A0=C2=A0 hw/scsi/ncr53c710: Cancel the in-flight request on soft re=
set
>> =C2=A0=C2=A0 hw/scsi/ncr53c710: Do not load SBCL from DBC after a SCRIP=
TS phase
>> =C2=A0=C2=A0=C2=A0=C2=A0 move
>> =C2=A0=C2=A0 hw/scsi/lasi_ncr710: Limit max_target and max_lun to 7
>> =C2=A0=C2=A0 hw/scsi/ncr53c710: Keep DCNTL.EA and DMODE.FC1 across an I=
STAT.RST
>> =C2=A0=C2=A0=C2=A0=C2=A0 reset
>> =C2=A0=C2=A0 hw/scsi/ncr53c710: Document the SIGP latch deviation
>=20


