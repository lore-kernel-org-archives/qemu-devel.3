Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ECCEDF16E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vquOT-0006Fh-J3; Fri, 13 Feb 2026 09:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1vquOR-0006Ey-Ko
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:43:40 -0500
Received: from esa16.hc2706-39.iphmx.com ([216.71.140.205])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1vquON-0008A6-8h
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:43:39 -0500
X-CSE-ConnectionGUID: PSMFr80ZTAeM/xRCN9DEdg==
X-CSE-MsgGUID: P8zuKbNtTvmidxIwcB92nQ==
Authentication-Results: ob1.hc2706-39.iphmx.com;
 dkim=pass (signature verified) header.i=@bu.edu;
 spf=SoftFail smtp.mailfrom=alxndr@bu.edu;
 dmarc=pass (p=quarantine dis=none) d=bu.edu
X-IronPort-RemoteIP: 209.85.222.69
X-IronPort-MID: 110790868
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:yDqBlq6ND8NGjdP6QUtxvAxRtG/GchMFZxGqfqrLsTDasY5as4F+v
 mJOXGGGa/+IM2ajet10bo6xpxxQu5Hcxt9nTwZorXw3Eysa+MHIO4+lIxarNUt+DCFioGGLT
 Sk6QoOdRCzhZiaE/n9BCpC48z8kk/3OHuOiYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbCROsspvlDs15K6s4GlB5QRnDRx2lAS2e0c9Xcp3yZ6ZciOQrrl8RoaSW
 +vFxbelyWLVlz9FIs+liLvybnoRSbfUOwWU4lIOM0R1qkEfzsCa+v9T2Ms0MC+7uR3Q9zxC4
 IwlWaiLdOscFvakdNLx8fVvO3oW0aVuoNcrKJUk2CCZ5xSun3DEmp2CAKyqVGGxFyke7Wxmr
 JQlxD4xgh+rv9mT7qjrEttQr8kGa9nRF6VOllxswmSMZRomacirr6Ti4NZZ2HItj5kLE6iPI
 cUebjVrYVLLZBgn1lU/Uspv2rf1wCOlKXsG+Tp5poJui4TX5AV1wL7hKvLfZ5qHSdg9ckOw/
 zueoDWhUk9KXDCZ4QLV4G+PjMnToT3+WY4CNaKz3K8whmTGkwT/DzVTDzNXu8KRk0O7RpdTJ
 lIZ/gIoqq498lHtScPyNyBUu1aBtx8YHsdZSqg0tlDLxa3T7AKUQGMDS1atdeAbiSP/fhRzv
 nehlc6vCDBy2IB5g1rBnltIhVte4RQoEFI=
IronPort-HdrOrdr: A9a23:nmPMpqhelGh4wNXG/6sjtRuw0XBQXtkji2hC6mlwRA09TyX4ra
 CTdZEguCMc5wxxZJhNo6HmBED4ewK5yXct2/hyAV7AZniEhILLFu9fBOLZqlWNJ8SZzJ866U
 4JScND4bbLfD1HZKjBjzVQQ+xL/OW6
X-Talos-CUID: 9a23:yqx4tGCuOKs3/3z6ExFc0WAOSpgXTlTQ6TDAGWSeWEpERLLAHA==
X-Talos-MUID: 9a23:E3H1IAljoakg14lkCBRAdnpaZNV1wK6IFHwTlJQKq+ibPgYhYTGk2WE=
Received: from mail-ua1-f69.google.com ([209.85.222.69])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 13 Feb 2026 09:43:29 -0500
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-94ac387f2f7so5916562241.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 06:43:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770993808; cv=none;
 d=google.com; s=arc-20240605;
 b=GokUblYHP1p2TgNEmRhJWuofwknglIZKkR2fysuNyaqrRsyJEK5qAEjZGORjSoLo4s
 KHPAs+s+oePU7z1elMF7AzuLBcxuuvDPnnE5l/Mv+lh8NDPg9BIiiIWpUm9P/dcv7Npz
 uuWtmiHVY/05CeLWwm5xEZu6/lRyrebrWrZYM/gG2tjQjckb9EN67LWX/ynwT7IAv2o1
 IKaazBmfitKPKttl7TFFIDUSvWgZqJynZ2s8zPL+G0DnFbnci1TQhvn1RygxUDiz1hmp
 ZWUbxZ7m9jRZVu9GtydcQyMLEVm8ODOA6jcOOdtbh2vNspdZWiO3qlCAfsC/HZ/Z8vnW
 fQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:dkim-signature;
 bh=tqR3WBcbY2vKrgGkPQ+0BOV5WgCQfupO7zAPofXrdJE=;
 fh=8Cczb83X8JMJP/WaFei4HwemATeKsczlaGX9mrfU4T4=;
 b=AinTIz7ECF43sA8b8yf0B/SYNtqYSbVih2dZq5qhaFq4PAkB7ifIeGjv65eULPZJps
 ArGKcN9dG5XH6HpWDYfvG4z9muQ520Y0TmnZBFvqgRnIhOQ0UOjXtqrbtXWpMFem4io5
 GUlx4YQ34swSRNdWtNaqZDgRyaLV4QIJuPk0aTaeO6Fg3MqZYr6VxptzQh2tft6HEAcW
 +UHMbRcUKFbrnobqkC0LZ01EDfCX1L0m5Y/IgnCUXMxvAq9Mh2jfsHMr8CY7Du80rA/1
 wpCnjllrmInNs85OpyVtQziGa50sbXvsk3u0MF1eCDR70/ivp8INAMr9ULiHJI7IxnGN
 iVJQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1770993808; x=1771598608; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tqR3WBcbY2vKrgGkPQ+0BOV5WgCQfupO7zAPofXrdJE=;
 b=iA56ovsGGAEz1mkx/rS1PaC2Qu2yNNKhEN2yt9miX9cgebowoIKkApNOnMiNBqdrrF
 bAah5T2MsDlJvJ3ODYwmHTpruGUySfy7W8tMMrREK6F9VVtSDqo+CgjFJkHeVejMKABu
 uYebcOAucgsCqIBJ41J36OE3Tzz/Dfyd3jZBTTUcnwAl793X3oIZqQaYzGnIfmYdcWwQ
 EDK2suxu6NzxFIdB+ZAqcfElR+zNXycRL5+/1x2JdZFN9D7/2vbe9J/EAfXpDMb/O9Q1
 7rEdzbQSqKOMqbQRCkXhIq+kLhDJ07SGP4ARxLlWNSYysBOoh3ZvTb/+p7rFaVmvCbVc
 9Vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770993808; x=1771598608;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqR3WBcbY2vKrgGkPQ+0BOV5WgCQfupO7zAPofXrdJE=;
 b=iDQxfI+3h5r0Gw7OnsDw40MkdHGoudARsuVLzW5STYwXifiBHw0u6zdsOX4z1poAl0
 0E9wtR1FhxASUGC3EFQUfgZwFdfEi65doYT79BQH792BMvKetH2xmMZHwuoh7UPu540q
 EBE1aEnzCWDWSDvhKyHZ4lB0j2nXAc0VsWB/2zmuNbxTjlCP0o4JRo+4ChgS4v/tCGM8
 1pYONI5+IUB23mHDzzvGehZcZKmy2Kb3LBB4+OnMYuNQsnC+aPWHIVibDtPciteje9VC
 eBb9CaJdgzo/tk8uirR6a/vtO/rJx6laGaWoZKWbciSaA+fUv2YRL3PPKxTZCY7UqD2N
 TsoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVPb0BEwE0xff9jEMHYH2UFZkohU6MCw5CU8aoE8QDMksZeCFm9EYFyYsl/4xG7Tyt0kLZJlIg8ajS@nongnu.org
X-Gm-Message-State: AOJu0YyHPPkKnFecF9t1Wx4fRqula+HfDertd3JAQUXHhIPW+u3uoQgy
 0NlbGtSZ4A5ifGLjRS0cCWFNc1IMant9SMvbgN/1b0Y34hlvz8POf8P9xU7CgFKKQBy1XpRwu8x
 Ed1TRKx3Ity2dmssNFZAf9aCKWz7AO4Jf5nGnj5zCxf7tuXwbWurG9SKYYEZla3Xu9h0L2YxuXX
 gQwKr5eAiUg98Be73xxzg/px39Gv5Ewe+X9M3+LqCq3nME
X-Gm-Gg: AZuq6aJsueqiLPh9DGEb9WgaeJBZBqxZ2nv/kRqibIbv/tE0p5TRzH91TqCvl9h/iwF
 swJwwaebYZFMKuilv4O+4+pHgRtXqTCClpPn1KdqZ0aKkV/+0Q1oesYDTNf3n6/UW5PYo0rHHyX
 Uxi4wAxdhgimDCKGO0XXWI0WD4mS5dRqgbnIJqUqCULa2DtEKcRUN39NTZcY5IasQGox2rQ6f9i
 CAQTLVFIe/ikhrVbu2h0xYymXaXEr0WJLZdDQ0CPgyDle9NMggY+3NKr/Jo7uL0UIw=
X-Received: by 2002:a05:6102:26ce:b0:5db:fddb:3155 with SMTP id
 ada2fe7eead31-5fe1ace40fcmr738749137.17.1770993808692; 
 Fri, 13 Feb 2026 06:43:28 -0800 (PST)
X-Received: by 2002:a05:6102:26ce:b0:5db:fddb:3155 with SMTP id
 ada2fe7eead31-5fe1ace40fcmr738731137.17.1770993808264; Fri, 13 Feb 2026
 06:43:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Feb 2026 08:43:26 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Feb 2026 08:43:26 -0600
From: Alexander Bulekov <alxndr@bu.edu>
References: <20221107221236.47841-1-philmd@linaro.org>
 <20221107221236.47841-2-philmd@linaro.org>
 <7d7bc83f-d14b-43b5-a637-517a51266a19@tls.msk.ru>
MIME-Version: 1.0
In-Reply-To: <7d7bc83f-d14b-43b5-a637-517a51266a19@tls.msk.ru>
Date: Fri, 13 Feb 2026 08:43:26 -0600
X-Gm-Features: AZwV_Qia8-XHU12EgzlW9FHWr9itz5y3BxNwYR-tXg99znIatiXu9Wpecue6P84
Message-ID: <CAHUE=o_fL=Ni2xGgWbBs-ucamRSubHavLX928C7TRMPi=N94ag@mail.gmail.com>
Subject: Re: [PATCH-for-7.2 1/2] hw/sd/sdhci: Do not set Buf Wr Ena before
 writing block (CVE-2022-3872)
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Sai Pavan Boddu <saipava@xilinx.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, 
 Bin Meng <bin.meng@windriver.com>, Mauro Matteo Cascella <mcascell@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, RivenDell <XRivenDell@outlook.com>, 
 Siqi Chen <coc.cyqh@gmail.com>, ningqiang <ningqiang1@huawei.com>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.71.140.205; envelope-from=alxndr@bu.edu;
 helo=esa16.hc2706-39.iphmx.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 260213 1205, Michael Tokarev wrote:
> Ping once again?
>

FWIW, none of the reproducers in the thread work for me anymore and
OSS-Fuzz claims the issue was fixed sometime in April 2024:
https://issues.oss-fuzz.com/issues/42524205#comment5
-Alex

> Thanks,
>
> /mjt
>
> On 11/8/22 01:12, Philippe Mathieu-Daud=C3=A9 wrote:
> > When sdhci_write_block_to_card() is called to transfer data from
> > the FIFO to the SD bus, the data is already present in the buffer
> > and we have to consume it directly.
> >
> > See the description of the 'Buffer Write Enable' bit from the
> > 'Present State' register (prnsts::SDHC_SPACE_AVAILABLE) in Table
> > 2.14 from the SDHCI spec v2:
> >
> >    Buffer Write Enable
> >
> >    This status is used for non-DMA write transfers.
> >
> >    The Host Controller can implement multiple buffers to transfer
> >    data efficiently. This read only flag indicates if space is
> >    available for write data. If this bit is 1, data can be written
> >    to the buffer. A change of this bit from 1 to 0 occurs when all
> >    the block data is written to the buffer. A change of this bit
> >    from 0 to 1 occurs when top of block data can be written to the
> >    buffer and generates the Buffer Write Ready interrupt.
> >
> > In our case, we do not want to overwrite the buffer, so we want
> > this bit to be 0, then set it to 1 once the data is written onto
> > the bus.
> >
> > This is probably a copy/paste error from commit d7dfca0807
> > ("hw/sdhci: introduce standard SD host controller").
> >
> > Reproducer:
> > https://lore.kernel.org/qemu-devel/CAA8xKjXrmS0fkr28AKvNNpyAtM0y0B+5Fic=
hpsrhD+mUgnuyKg@mail.gmail.com/
> >
> > Fixes: CVE-2022-3872
> > Reported-by: RivenDell <XRivenDell@outlook.com>
> > Reported-by: Siqi Chen <coc.cyqh@gmail.com>
> > Reported-by: ningqiang <ningqiang1@huawei.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Tested-by: Mauro Matteo Cascella <mcascell@redhat.com>
> > ---
> >   hw/sd/sdhci.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> > index 306070c872..f230e7475f 100644
> > --- a/hw/sd/sdhci.c
> > +++ b/hw/sd/sdhci.c
> > @@ -954,7 +954,7 @@ static void sdhci_data_transfer(void *opaque)
> >               sdhci_read_block_from_card(s);
> >           } else {
> >               s->prnsts |=3D SDHC_DOING_WRITE | SDHC_DAT_LINE_ACTIVE |
> > -                    SDHC_SPACE_AVAILABLE | SDHC_DATA_INHIBIT;
> > +                                           SDHC_DATA_INHIBIT;
> >               sdhci_write_block_to_card(s);
> >           }
> >       }
>

