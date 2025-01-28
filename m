Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA67C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tciOu-0003oH-G8; Tue, 28 Jan 2025 05:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tciOs-0003nH-34; Tue, 28 Jan 2025 05:00:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tciOp-0002Wt-DO; Tue, 28 Jan 2025 05:00:53 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0DC985C58A0;
 Tue, 28 Jan 2025 10:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BF2C4CEE7;
 Tue, 28 Jan 2025 10:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738058441;
 bh=kZ5N8tHCHo1PrNZqE9WlUMEB8RGu5iVv5hQ4/VAaUpc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=G6vtGOYgV8ruY7AF1SWwVYIpaG4+lPlu6Fkv24SvdbRutxSMsJW2GOgelXXeXHj9K
 XKgnKAamkuOpz34TgqYxcsJpPMfLV5NG62q9KQHMZExlr0iA66S3G35TfiZIWm5Znq
 JxxmXCl5fBxZsiB3BQXH7iCy4x1Q68HWSU+5tdxum/g3iHnB9J9gWrxU1uhl5yIZ1U
 +a0gED1Y4Ja2J4wBTqgE6H56TKmSBF7MlKxtsF7o1r/Zo3uRFunaDpxktlHv4oA6fa
 nEgtP1dxeW1ip/Ey9MYsC8ybPdtbf6f3M+S5/2Vhh3CWhrlzLnv2F6eJdMvFpsbHMw
 nwG3dIhbGJ8wA==
Date: Tue, 28 Jan 2025 11:00:34 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/11] acpi/ghes: add a firmware file with HEST address
Message-ID: <20250128110034.650445fc@foz.lan>
In-Reply-To: <20250123100217.00007373@huawei.com>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <a3579f6c2c24e764e544f83b6e1b2dbef730e3e3.1737560101.git.mchehab+huawei@kernel.org>
 <20250123100217.00007373@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Em Thu, 23 Jan 2025 10:02:17 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Wed, 22 Jan 2025 16:46:19 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Store HEST table address at GPA, placing its content at
> > hest_addr_le variable.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> A few trivial things inline.
> 
> Jonathan
> 
> > ---
> > 
> > Change from v8:
> > - hest_addr_lr is now pointing to the error source size and data.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> Bonus.  I guess you really like this patch :)
> > ---
> >  hw/acpi/ghes.c         | 17 ++++++++++++++++-
> >  include/hw/acpi/ghes.h |  1 +
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index 3f519ccab90d..34e3364d3fd8 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -30,6 +30,7 @@
> >  
> >  #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
> >  #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> > +#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
> >  
> >  /* The max size in bytes for one error block */
> >  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> > @@ -261,7 +262,7 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
> >      }
> >  
> >      /*
> > -     * tell firmware to write hardware_errors GPA into
> > +     * Tell firmware to write hardware_errors GPA into  
> 
> Sneaky tidy up.  No problem with it in general but adding noise here, so if there
> are others in the series maybe gather them up in a cleanup patch.

There are no other cleanups pending. Besides, as you noticed, this
aligns with the comment below. So, I'm opting to add a note at the
patch's description.

> 
> >       * hardware_errors_addr fw_cfg, once the former has been initialized.
> >       */
> >      bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
> > @@ -355,6 +356,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> >  
> >      acpi_table_begin(&table, table_data);
> >  
> > +    int hest_offset = table_data->len;  
> 
> Local style looks to be traditional C with definitions at top.  Maybe define
> hest_offset up a few lines and just set it here?

Ok. I'll follow Igor's suggestion of using uint32_t.

> > +
> >      /* Error Source Count */
> >      build_append_int_noprefix(table_data, num_sources, 4);
> >      for (i = 0; i < num_sources; i++) {
> > @@ -362,6 +365,15 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> >      }
> >  
> >      acpi_table_end(linker, &table);
> > +
> > +    /*
> > +     * tell firmware to write into GPA the address of HEST via fw_cfg,  
> 
> Given the tidy up above, fix this one to have a capital T, or was this
> where you meant to change it?

OK.

> > +     * once initialized.
> > +     */
> > +    bios_linker_loader_write_pointer(linker,
> > +                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,  
> 
> Could wrap less and stay under 80 chars as both lines above add up to 70 something

Why? This follows QEMU coding style and lines aren't longer than 80
columns. Besides, at least for my eyes and some experience doing maintainership
on other projects over the years, it is a lot quicker to identify function
parameters if they're properly aligned with the parenthesis.

Thanks,
Mauro

