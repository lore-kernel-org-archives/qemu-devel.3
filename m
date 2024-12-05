Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A38CE77171
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 08:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ6mZ-0003RC-Df; Thu, 05 Dec 2024 03:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJ6mU-0003OG-ID; Thu, 05 Dec 2024 03:00:14 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJ6mS-00069t-Ii; Thu, 05 Dec 2024 03:00:14 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id E9EF5A41384;
 Thu,  5 Dec 2024 07:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820FBC4CED1;
 Thu,  5 Dec 2024 08:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733385605;
 bh=q7ysq63iGMnUWGArTOv4L3H5qVOaDhKU0OUZpTni/Xg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jVlXlbqH6PR+Y396UgJAD97rcUiSCOmuBQtf1jEZvS3SAIn00BDsYr88FpVpPIZHt
 7mmi0arZ61XfJVSxN9nPdsGuztCxaS9OvLcDEG0ddlTNxf50eNfexvTbBGrvG1QvmM
 lvi3rO2j0X3iCPj0+Gpbl9iz2wokXZcOD8rg3IL6Im0MgbJdbYgQ5m92RHGwBgNI+E
 TyJMqg/SlcodLQCcpUziYZB9cYaqNBltsr0SVpunycEDlchCIZLF0WddiMxKcFAV7+
 oDB5Jmqm6mYDMq7odpIghOm31cR/8XBkh9bhdYXfKvD7/ftn43aQFS2gDNB5C8JJTG
 IuG6/oD8ktDjQ==
Date: Thu, 5 Dec 2024 08:59:59 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 13/16] acpi/ghes: better name the offset of the
 hardware error firmware
Message-ID: <20241205085959.2223d079@foz.lan>
In-Reply-To: <20241204173759.6f02561a@imammedo.users.ipa.redhat.com>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
 <20b003136d8c008fd54e8d40c806f13867336e13.1733297707.git.mchehab+huawei@kernel.org>
 <20241204173759.6f02561a@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Wed, 4 Dec 2024 17:37:59 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Wed,  4 Dec 2024 08:41:21 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The hardware error firmware is where HEST error structures are  
>       ^^^^^^^^^^^^^^^^^^^^^^^ I can't parse this, suspect you've meant something else here
> 
> > stored. Those can be GHESv2, but they can also be other types.
> > 
> > Better name the location of the hardware error.
> > 
> > No functional changes.

I meant this fw_cfg file:
#define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
#define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"

What about changing description to:

	The etc/hardware_errors fw_cfg file is where the HEST error
	source structures are stored. Those can be GHESv2, but they can also
	be other types.

	For more details about error source structure, see:
	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#acpi-error-source

	Better name the address variable from ghes_error_le to hw_error_le
	to better reflect that.

	No functional changes.

> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/acpi/generic_event_device.c | 4 ++--
> >  hw/acpi/ghes.c                 | 4 ++--
> >  include/hw/acpi/ghes.h         | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index 663d9cb09380..17baf36132a8 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -364,7 +364,7 @@ static const VMStateDescription vmstate_ghes = {
> >      .version_id = 1,
> >      .minimum_version_id = 1,
> >      .fields = (const VMStateField[]) {
> > -        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> > +        VMSTATE_UINT64(hw_error_le, AcpiGhesState),
> >          VMSTATE_END_OF_LIST()
> >      },
> >  };
> > @@ -372,7 +372,7 @@ static const VMStateDescription vmstate_ghes = {
> >  static bool ghes_needed(void *opaque)
> >  {
> >      AcpiGedState *s = opaque;
> > -    return s->ghes_state.ghes_addr_le;
> > +    return s->ghes_state.hw_error_le;
> >  }
> >  
> >  static const VMStateDescription vmstate_ghes_state = {
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index 52c2b69d3664..90d76b9c2d8c 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -359,7 +359,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> >  
> >      /* Create a read-write fw_cfg file for Address */
> >      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> > -        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
> > +        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> >  
> >      ags->present = true;
> >  }
> > @@ -385,7 +385,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> >      }
> >      ags = &acpi_ged_state->ghes_state;
> >  
> > -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> > +    start_addr = le64_to_cpu(ags->hw_error_le);
> >  
> >      start_addr += source_id * sizeof(uint64_t);
> >  
> > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > index 21666a4bcc8b..39619a2457cb 100644
> > --- a/include/hw/acpi/ghes.h
> > +++ b/include/hw/acpi/ghes.h
> > @@ -65,7 +65,7 @@ enum {
> >  };
> >  
> >  typedef struct AcpiGhesState {
> > -    uint64_t ghes_addr_le;
> > +    uint64_t hw_error_le;
> >      bool present; /* True if GHES is present at all on this board */
> >  } AcpiGhesState;
> >    
> 



Thanks,
Mauro

