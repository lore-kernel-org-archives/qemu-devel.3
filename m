Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7BFC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcial-0001fM-Nb; Tue, 28 Jan 2025 05:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tciai-0001ex-RI; Tue, 28 Jan 2025 05:13:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tciag-0005Fz-E5; Tue, 28 Jan 2025 05:13:08 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C7E8D5C59A7;
 Tue, 28 Jan 2025 10:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B47AC4CED3;
 Tue, 28 Jan 2025 10:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738059182;
 bh=q2tkXJnQuqRVsRPzbW4+BGtAR/MbKeqkStZKGVjjDhg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FZx6s1eUpPWZoplYHOrkhr/qzvpXtRJHTMEvibGRaE0I35+GfokYOCsT0x2PD4EmP
 6GBEGzM3UWML6T60t+x/hivCNb0dFQ5v1D+Bjgw5H4usRPF+0/9LtwFD7apwSeyWhR
 tYcw0RY9HcHBS3JMeoboiyQuKa5nY2fNhEJCkjZhG0iAzlCxKbenZsC5Ael8dsyU/8
 clAz7s7/zjU24aKkQpAe/dWFIpN1ygJ/CI63+ENnBPcsMIL+H4OI3emXrWdDTJbyV3
 DNlf4WiH9vldzYWOvk4KVeHuwyrqURR3owwGhRbNjiumftrCI1zsV10PyyB+onqfdE
 6mTNCTFsgZqQw==
Date: Tue, 28 Jan 2025 11:12:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/11] acpi/ghes: add a firmware file with HEST address
Message-ID: <20250128111257.74766c82@foz.lan>
In-Reply-To: <20250123180135.4f86483f@imammedo.users.ipa.redhat.com>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <a3579f6c2c24e764e544f83b6e1b2dbef730e3e3.1737560101.git.mchehab+huawei@kernel.org>
 <20250123100217.00007373@huawei.com>
 <20250123180135.4f86483f@imammedo.users.ipa.redhat.com>
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

Em Thu, 23 Jan 2025 18:01:35 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Thu, 23 Jan 2025 10:02:17 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Wed, 22 Jan 2025 16:46:19 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Store HEST table address at GPA, placing its content at
> > > hest_addr_le variable.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >     
> > A few trivial things inline.
> > 
> > Jonathan
> >   
> > > ---
> > > 
> > > Change from v8:
> > > - hest_addr_lr is now pointing to the error source size and data.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>    
> > Bonus.  I guess you really like this patch :)  
> > > ---
> > >  hw/acpi/ghes.c         | 17 ++++++++++++++++-
> > >  include/hw/acpi/ghes.h |  1 +
> > >  2 files changed, 17 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > index 3f519ccab90d..34e3364d3fd8 100644
> > > --- a/hw/acpi/ghes.c
> > > +++ b/hw/acpi/ghes.c
> > > @@ -30,6 +30,7 @@
> > >  
> > >  #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
> > >  #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> > > +#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
> > >  
> > >  /* The max size in bytes for one error block */
> > >  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> > > @@ -261,7 +262,7 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
> > >      }
> > >  
> > >      /*
> > > -     * tell firmware to write hardware_errors GPA into
> > > +     * Tell firmware to write hardware_errors GPA into    
> > 
> > Sneaky tidy up.  No problem with it in general but adding noise here, so if there
> > are others in the series maybe gather them up in a cleanup patch.  
> 
> +1

If Ok, I would prefer to keep this here, as there's no other cleanups
anymore, and writing a patch just for this seems overkill. Besides,
it replicates a comment with a similar content on this patch.

So, instead, if OK to you, I would prefer to add a comment about it at
the patch description.

> >   
> > >       * hardware_errors_addr fw_cfg, once the former has been initialized.
> > >       */
> > >      bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
> > > @@ -355,6 +356,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> > >  
> > >      acpi_table_begin(&table, table_data);
> > >  
> > > +    int hest_offset = table_data->len;    
> should be unsigned, and better uint32_t
> but we have a zoo wrt type here all over the place.

Changed this one to uint32_t. 

> > Local style looks to be traditional C with definitions at top.  Maybe define
> > hest_offset up a few lines and just set it here?  
> 
> yep, it applies to whole QEMU (i.e. definitions only at the start of the block)

Good to know. That's my personal style too. Yet, I guess I saw somewhere
other places declaring variables in the middle of the code. 

> > > +
> > >      /* Error Source Count */
> > >      build_append_int_noprefix(table_data, num_sources, 4);
> > >      for (i = 0; i < num_sources; i++) {
> > > @@ -362,6 +365,15 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> > >      }
> > >  
> > >      acpi_table_end(linker, &table);
> > > +
> > > +    /*
> > > +     * tell firmware to write into GPA the address of HEST via fw_cfg,    
> > 
> > Given the tidy up above, fix this one to have a capital T, or was this
> > where you meant to change it?
> >   
> > > +     * once initialized.
> > > +     */
> > > +    bios_linker_loader_write_pointer(linker,
> > > +                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,    
> > 
> > Could wrap less and stay under 80 chars as both lines above add up to 70 something
> >   
> > > +                                     sizeof(uint64_t),
> > > +                                     ACPI_BUILD_TABLE_FILE, hest_offset);
> > >  }    
> >   
> 



Thanks,
Mauro

