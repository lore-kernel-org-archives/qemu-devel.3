Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FF9CA0EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 13:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqAyv-0001yv-3M; Sun, 24 Aug 2025 09:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1uqAyt-0001yX-Dc
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 09:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1uqAyq-0000d1-Sl
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 09:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756042914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K6NoufUsZ3lLPga0ywLpLDt2LTBe+XBzJJmEkkjedeM=;
 b=fTo477b1RIyEAHN42riT+LI2l5C1TrAMxQrRuXc6NPXlO3LJz3OPA8wDe2UrvkEbQx7cH6
 v2S0/rF79fCuC4uKvVQqIHMELzY0bWF3a6zFcVNDS9rehAFj3S+p0mQJg5Hgg19ovuY2Ka
 hWWVtNiPCVGO1NAY7RngCJnAl+ADIxY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-K0ykFb5GNHqlKuZz7fPoQg-1; Sun, 24 Aug 2025 09:41:53 -0400
X-MC-Unique: K0ykFb5GNHqlKuZz7fPoQg-1
X-Mimecast-MFC-AGG-ID: K0ykFb5GNHqlKuZz7fPoQg_1756042912
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24696a89d6dso16836875ad.3
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 06:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756042912; x=1756647712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6NoufUsZ3lLPga0ywLpLDt2LTBe+XBzJJmEkkjedeM=;
 b=f0hVV76wvI+OKm6a2lHbD2+pmocTQ1TUI3+kE04c/37wnbJaxI4YZAbjlwhed2CpOD
 1+P+ojN+omzY0kOsepir6QVRu5XN4RKkMvHfHPkTI5hgQXagRGfsJ0n0POobaeuIQiKi
 ZBEk6q6k4XjRd3hokZ5XmATQh7VXTz+a7ox20OeaI9OeoZI88tj7BKsDv7XBERy5TiRp
 fqKM1JD6Q9hoELyub//bjDnuHLro7a1yg36kVf+G3H8EfjLcvpSfShGqOPHwhSV2VmRM
 9WmyL/93nZ2TG+NEaRNI2sAvO/9PpWaFpNSBLS8g6bgm/29QJ48k+V9SFYo6CuAERLi0
 03QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4wgmpbhxOO3LATlbWOxuw2b+hn/jsRMML6imt89dzRG6YBOivQO6erj755eu8/5Qb77BuY2p1/rv7@nongnu.org
X-Gm-Message-State: AOJu0Yyg4DZF4BsHlm39Oo5XwmZlDVhIH5MmEf/tg9XdbXJESwvv2lc9
 pPNBTcRK6UjtZ4yHISVoIJXvknUhN6ai/66X5S0wma4SHpHHJJknP/gLJ83b3ErW1MmSineNVl+
 1v4IJgGIVKyc5hFMNucbI2GCqRy67BZXlfjkGhvNeAgvsPvztGR6kvWb8IYzB9x6NFCDbiJ9UcT
 eie6mVDnYROlxwyOHnMlpo0c3EtRRHbRU=
X-Gm-Gg: ASbGncv/MUmRHBoStu+HpuA0uUQcaZjqtu3nNhWJznmhcPZdbFdoRg+mrdAfVMVcHe6
 WymG4aBdykRKDSFF/FlCi8zM8PkEx2lYImVOo7jpXn5JHhmi+Zh9Y5DV9zeQ2xxf9/BWxXz/FDd
 AAvyYcU2luGjDHI166bg==
X-Received: by 2002:a17:903:41cc:b0:246:b351:36a3 with SMTP id
 d9443c01a7336-246b3513841mr20371535ad.48.1756042911969; 
 Sun, 24 Aug 2025 06:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtOwnM0zUvK6bibgzn81RLTEZQ3jEiK+fk57Unk7a4gacChzgKnKqPnvcXorUn+asigXzoxNlhmThgsbf/uyw=
X-Received: by 2002:a17:903:41cc:b0:246:b351:36a3 with SMTP id
 d9443c01a7336-246b3513841mr20371225ad.48.1756042911586; Sun, 24 Aug 2025
 06:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221107221236.47841-1-philmd@linaro.org>
 <20221107221236.47841-2-philmd@linaro.org>
 <234f5633-0b90-448b-84a1-12338ae159c6@tls.msk.ru>
In-Reply-To: <234f5633-0b90-448b-84a1-12338ae159c6@tls.msk.ru>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Sun, 24 Aug 2025 15:41:40 +0200
X-Gm-Features: Ac12FXypZNQqS9HFWja8uDRNapzyp12791EIAl-TzexNxpwUyZRWGFv8HZ4J8_s
Message-ID: <CAA8xKjVaXnA0cX3UWK5B2FrZN7sp=bSMPVzPbrkynW6tMTU_8Q@mail.gmail.com>
Subject: Re: [PATCH-for-7.2 1/2] hw/sd/sdhci: Do not set Buf Wr Ena before
 writing block (CVE-2022-3872)
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Sai Pavan Boddu <saipava@xilinx.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Bin Meng <bin.meng@windriver.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, RivenDell <XRivenDell@outlook.com>, 
 Siqi Chen <coc.cyqh@gmail.com>, ningqiang <ningqiang1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Aug 11, 2025 at 11:38=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
>
> On 08.11.2022 01:12, Philippe Mathieu-Daud=C3=A9 wrote:
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
>
> Hi!
>
> It's been almost 3 years since this patch.
> Is it still relevant?
> Or maybe the prob has been fixed by later changes in this area?

SDHC_SPACE_AVAILABLE is still set in the write path:
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/sd/sdhci.c?ref_type=
=3Dheads#L988

If that is a bug, this patch should be applied regardless of its
security implications (if any).

> Thanks,
>
> /mjt
>
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

--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


