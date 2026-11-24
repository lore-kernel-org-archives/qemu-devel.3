Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD59606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=Qn7DxiIJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVxic-0002ZG-J7; Tue, 24 Nov 2026 16:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xVxib-0002XO-Ji
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:06:25 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xVxiV-0003fI-1g
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:06:25 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-67da69e7c31so5400525d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 13:06:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795554376; cv=none;
 d=google.com; s=arc-20260327;
 b=C+MLl90swrDfWOr7vcMFdJVe2jfMMXW2IWSMs4mt00OWcVJUlMe75iTk1FvgNTV73G
 qkfo7aEWS6ySWkVc1veLBEYBkVBF0z1kn4MfplWCGP/67VtfeVRnVelGvwAhmuFmKM+k
 Q/zskcikuWyR5i7CKaFOKRsRq/Ul6TZMENdoH2lIiHqTzDEKm7//I/j6+it1HMFqbofK
 0hr/9Kqp6rMfdIovu1RvIox9lVn3zmlMsHIOEOjec+mC1+QuPH5jhQXjlb4D162f1gv6
 1QwDvrl+iRe//lPEFMAzKgmvkmxEIfPj+/6w3DH8jjZ217G2zWT9Tg3UhF9YRnLaYG/i
 2nKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=td/IQBqnnauSbmvoT5oUK4P6m4eh4rfRhcVntXiDzt4=;
 fh=cYN5BOjTpWeKYAuOEtvf+Ll+RfcsXKG2rddGVks+4Ic=;
 b=Ns5jukhOJtBGqrH5mtPhx78IyFFMWfbacY4SI4IC2NfulgWi9RbG/MaGQY5zRU0xwJ
 02VyptApC92YPhbONSmuelIrBh3wdJMOpG8KtF6PFaxrnWFH0j26GKkG8Xi3v7p5quAx
 ss0jikWSNHLJnkFB6tbJD+O41uqb7tgRcfAcuc9l7idOXKeoAOSeprqSfea4orPICmk4
 Hj2aAOZ+5fTM5ywGERjtEH0ROOxn+mDFnAxShlRFKkXBPbFiyDtrQ5hcjbehLkrYrSXj
 9OOd1y8D2e5wZ35F1IE3LTQ/h/1PF5/UsLRLsRpOctU9ERWD5drquW7VrEBc2JZs0zJI
 cWSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795554376; x=1796159176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=td/IQBqnnauSbmvoT5oUK4P6m4eh4rfRhcVntXiDzt4=;
 b=Qn7DxiIJvljtjdpRvzw1yxG31ivzO41cXAWy0pOK6s2+7QWoLTUMcXcIM2o0xRYeH0
 IlYFe1BxVpeTQ7dCm7vRnqreG00p99gokmIUPLKtTj3Bl9Zby4fm5SwPBcJnmTCcyNi2
 z4n3q4yQP8eo2VAbkCd30sQxtewUzUc0+tbb44yCoQw4HVuKB7zhWcBjpjrnDen21oss
 kdg0DFAdO5QDiATEz3jhgOCEckWKBxMrc5IMRRe2exh80nZvCr80CxYp1qpw6pc7aXyt
 iRB0IUDdKrn00ixKXyLaDKc+AS0L6Qe9Z4JWlpRtyXYYErqqpLSZvWQiFfSOGx6c2ls8
 Il6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795554376; x=1796159176;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=td/IQBqnnauSbmvoT5oUK4P6m4eh4rfRhcVntXiDzt4=;
 b=NkfBRirP3vRH+fq7vpIn2Noj3nUeefKnRIl5TxteuNOxvkQoOfKlhhvvMVM1pyDvC5
 l1eDO2EAuIauVt03rWm/9SzPIX4H7lOY1DKeL+gyXg6/n12ogPp1Ew0YG/QumxnMfeHq
 L9DzLO8UXAZaHdpwjFtuaaIqMjIXbrtbz4frw17ZCXGfTy9F/L++0drKJm4Ozb/4BYeA
 ms5P1CsLcFurY2+6WTZkkd/2TfuH/QCOkXNuLqdltoYlzPJY3cR4mBGPhhW5Mo+n3u01
 aDhrlh5HwTbhoUSNRJXgocQnCM58KMhPecsCvw85VQQCZ44mAnWYUvLzSnTkgOgcuKSX
 leTQ==
X-Gm-Message-State: APuU4Z/ICl6ZSoaBN4ZxEpRLz6DVD7kLSP3BDpCXYUcca0EQ0stj+scJ
 iaPWFc3D1z+17lDYoecz6Qy3MFjCKvqZ2Tn+t/xUEGYmv5NziKeg88YEeDTwHRWs93/nbTWMCz2
 7myqYrvBovczSeh4AY7jIJxf39w4EIsWKG6BO8HP3sw==
X-Gm-Gg: AZFdTZfinK2/ZFvAKY9G2a9/gvgldP/VboXphCqeihpoXM8XYzQmJTFtAbL7hTekN0r
 1WabRUrYmLEvOW+KRRp/KFVV34pxzTjTyyz5N+wMKZk25vZpBh8DeV+fb0kGxjsyeDqDQlRuHpk
 aTADMeQ0x1R86XG3qy/Le1sSWMDgNGTZgvqE3cpszxv/Xw9Nhhwpr3NnU1kd4eYAclMrzAAfI0I
 R8AWyHGF3OOjGkftyfKSI60ycbE2CUA94CVSFPJ+cn9pje9EEgAXGhsYfJkHWIJiUB4NYORhiVe
 tXjNCWffsLZhQykJq+XtnTpMgxV+2C9g5VaY4oHjekZjtSGdxhRLVCnVPwkgHhrXPKCS2VcXS9j
 GQYyNQ+kVzn1Bkt3G6DvQQQHZdXfFWbpcLCgyOKSzGIjhGSW2nWF9OtKGplhO3QqsAh+7gCg9B9
 J+gQasL9S+1NiSp4wFnx+2MmnrZQ==
X-Received: by 2002:a53:b4cf:0:b0:67d:adb1:f165 with SMTP id
 956f58d0204a3-67df4456419mr5273132d50.47.1795554376524; Tue, 24 Nov 2026
 13:06:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123-m25p80_write_enable_fix-v2-0-0ac94f99e91f@oss.tenstorrent.com>
 <20261123-m25p80_write_enable_fix-v2-1-0ac94f99e91f@oss.tenstorrent.com>
 <766971bd-722c-4c25-bea0-dd2040a8c862@kaod.org>
In-Reply-To: <766971bd-722c-4c25-bea0-dd2040a8c862@kaod.org>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 24 Nov 2026 15:06:05 -0600
X-Gm-Features: Aa3M54rC6IpE0TSvegTRIA0Pv4FdA-_Rs-8XdgYlU8WW40UR2lNJXWqjYSrCS4k
Message-ID: <CAEev2e-9knDkdFf2fee13-38VECzEwBu1R5F4=5xfdpdGd+9eA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] test/qtest/aspeed_smc-test: Send write enable
 before each page program command
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi C=C3=A9dric,

On Tue, Nov 24, 2026 at 9:02=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 11/23/26 16:21, Anirudh Srinivasan wrote:
> > The M25P80 specification [1] dictates that a write enable (WREN) must
> > be sent before a page program (PP), and that the write enable latch
> > (WEL) is reset at some point before the PP command has finished.
> >
> > The current tests that make use of page program send WREN only once at
> > the beginning, before issuing multiple PP commands. The m25p80
> > implementation in QEMU doesn't deassert WEL at the end of each PP
> > operation (so this isn't an issue currently), but real hardware would
> > unset WEL at the end of the first PP command the second PP command woul=
d
> > fail. Update the tests to send WREN before each PP command.
> >
> > The current m25p80 model does not reset the WEL at the end of each PP
> > command. This is a bug, and a subsequent commit will fix this.
> >
> > [1] https://www.alldatasheet.com/datasheet-pdf/download/22807/STMICROEL=
ECTRONICS/M25P80.html
> >
> > Fixes: 3e62a32ddb89 ("test/qtest: Introduce a new aspeed-smc-utils.c to=
 place common testcases")
> > Cc: qemu-stable@nongnu.org
> > Acked-by: Alistair Francis <alistair.francis@wdc.com>
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > ---
> >   tests/qtest/aspeed-smc-utils.c | 24 +++++++++++++++++++-----
> >   1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-ut=
ils.c
> > index 146332240d..85e883d0b8 100644
> > --- a/tests/qtest/aspeed-smc-utils.c
> > +++ b/tests/qtest/aspeed-smc-utils.c
> > @@ -218,12 +218,23 @@ static void read_page_mem(const AspeedSMCTestData=
 *data, uint32_t addr,
> >   typedef void (*read_page_mem_fn)(const AspeedSMCTestData *data,
> >                                    uint32_t addr, uint32_t *page);
> >
> > +static void flash_write_enable(const AspeedSMCTestData *data)
> > +{
> > +    spi_ctrl_start_user(data);
> > +    flash_writeb(data, 0, WREN);
> > +    spi_ctrl_stop_user(data);
> > +}
> > +
> >   static void write_page_mem(const AspeedSMCTestData *data, uint32_t ad=
dr,
> >                              uint32_t write_value)
> >   {
> > -    spi_ctrl_setmode(data, CTRL_WRITEMODE, PP);
> > -
> >       for (int i =3D 0; i < FLASH_PAGE_SIZE / 4; i++) {
> > +        /* Send write enable before each Page Program */
> > +        flash_write_enable(data);
>
> aspeed_smc_test_write_page_mem() calls :
>
>        flash_writeb(test_data, 0, WREN);
>
>
> Should we keep it ?

Yes, this can be dropped.

>
> > +
> > +        /* move out USER mode to use direct writes to the AHB bus */
>
> why ?

aspeed_smc_test_write_page_mem had this comment on it and I copied it
over here. This function is very similar to that (we're sending WREN
in user mode and switch to AHB/direct mode for the PP). I can remove
this comment if you think it is unnecessary.

>
> > +        spi_ctrl_setmode(data, CTRL_WRITEMODE, PP);
> > +
> >           flash_writel(data, addr + i * 4, write_value);
> >       }
> >   }
> > @@ -468,10 +479,13 @@ void aspeed_smc_test_write_page_mem(const void *d=
ata)
> >       flash_writeb(test_data, 0, WREN);
> >       spi_ctrl_stop_user(test_data);
> >
> > -    /* move out USER mode to use direct writes to the AHB bus */
> > -    spi_ctrl_setmode(test_data, CTRL_WRITEMODE, PP);
> > -
> >       for (i =3D 0; i < FLASH_PAGE_SIZE / 4; i++) {
> > +        /* Send write enable before each Page Program */
> > +        flash_write_enable(test_data);
> > +
> > +        /* move out USER mode to use direct writes to the AHB bus */
> > +        spi_ctrl_setmode(test_data, CTRL_WRITEMODE, PP);
> > +
> >           flash_writel(test_data, my_page_addr + i * 4,
> >                  make_be32(my_page_addr + i * 4));
>
> Can't we call write_page_mem() instead ? If possible, the helper
> flash_write_enable() becomes useless then.

write_page_mem() writes the same value to every word in the page,
whereas this test is writing a different value for each offset.
write_page_mem() will need to be refactored a bit to use here (which
I'd like to avoid unless really necessary).

>
> Anyhow why isn't flash_write_enable() used elsewhere ?
>
> Also, all these routines  :
>
>         aspeed_smc_test_erase_sector()
>         aspeed_smc_test_erase_all()
>         test_write_page()
>         test_read_page_mem()
>         aspeed_smc_test_write_page_qpi()
>         aspeed_smc_test_write_page_datafifo()
>         aspeed_smc_test_read_page_datafifo()
>
> call the page program OP. Probably PP is called only once and the
> routines are immune to the WEL clear in patch 2. Are we sure of that ?

Yes, all these tests send a single PP only and operate in user mode.
The test this patch touches switches to AHB direct write mode to do
multiple PPs. In this mode, CS is de-asserted after each write, which
results in WEL being cleared and WREN needing to be sent again.

Maybe what I can do is that I can inline the flash_write_enable()
helper in these 2 instances, and add a comment as to why it is needed
only in those locations. That might help clarify some things.

>
> Thanks,
>
> C.

