Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969ABEEEC0E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 05:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soz6s-0004Pq-Dr; Fri, 13 Sep 2024 01:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1soz6p-0004Ls-R9; Fri, 13 Sep 2024 01:44:43 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1soz6o-0003d0-96; Fri, 13 Sep 2024 01:44:43 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 01B095C060A;
 Fri, 13 Sep 2024 05:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B3CC4CEC0;
 Fri, 13 Sep 2024 05:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726206280;
 bh=iKzgzGmY8jMu1CwEhb0AyXIHtqm8tqncg+1CM1dtqwg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Hf/KJz4j4hKC4Ja9D5/QgWhMDl+fvOcuTW8qYX2IvPuOdV3iWrWsawOr8ieUV8Om8
 ZKVjyr8PRMhjrlBWfM9nTkh/nFK+30c4ImxN6q6K/nDO0pNMdBp1dUalkvbAqczSRr
 2l20CCMxapyaSBMd0OkstE+RNnTWnFnCYp0RiAJZ3VsMLZ4cYIGV15yWOg2m8OzRXS
 EH6GP57tA5xXrNc5CnCDqf/Qp3rjbyFHH2oLaF9IZRUYlkJDAHR5GUFK8B1o1u38q0
 ha5jFXHG5MrODCBqPH7vpMDR7xbXrO6QpVo7HpRS3xhX7fnfO5Q/VPB12eHhrWF6S5
 +3wAQ4ymJLUxQ==
Date: Fri, 13 Sep 2024 07:44:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 01/12] acpi/ghes: add a firmware file with HEST address
Message-ID: <20240913074435.0eea2552@foz.lan>
In-Reply-To: <20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
 <34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
 <20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

Em Wed, 11 Sep 2024 15:51:08 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Sun, 25 Aug 2024 05:45:56 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Store HEST table address at GPA, placing its content at
> > hest_addr_le variable.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> This looks good to me.
> 
> in addition to this, it needs a patch on top to make sure
> that we migrate hest_addr_le.
> See a08a64627b6b 'ACPI: Record the Generic Error Status Block address'
> and fixes on top of that for an example.

Hmm... If I understood such change well, vmstate_ghes_state() will
use this structure as basis to do migration:

	/* ghes.h */
	typedef struct AcpiGhesState {
	    uint64_t hest_addr_le;
	    uint64_t ghes_addr_le;
	    bool present; /* True if GHES is present at all on this board */
	} AcpiGhesState;

	/* generic_event_device.c */
	static const VMStateDescription vmstate_ghes_state = {
	    .name = "acpi-ged/ghes",
	    .version_id = 1,
	    .minimum_version_id = 1,
	    .needed = ghes_needed,
	    .fields      = (VMStateField[]) {
	        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
	                       vmstate_ghes_state, AcpiGhesState),
	        VMSTATE_END_OF_LIST()
	    }
	};

	/* hw/arm/virt-acpi-build.c */
	void virt_acpi_setup(VirtMachineState *vms)
	{
	    ...
	    if (vms->ras) {
	        assert(vms->acpi_dev);
	        acpi_ged_state = ACPI_GED(vms->acpi_dev);
	        acpi_ghes_add_fw_cfg(&acpi_ged_state->ghes_state,
	                             vms->fw_cfg, tables.hardware_errors);
	    }

Which relies on acpi_ghes_add_fw_cfg() function to setup callbacks for
the migration:

	/* ghes.c */
	void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
	                          GArray *hardware_error)
	{
	    /* Create a read-only fw_cfg file for GHES */
	    fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
	                    hardware_error->len);

	    /* Create a read-write fw_cfg file for Address */
	    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
	        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);

	    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
	        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);

	    ags->present = true;
	}

It sounds to me that both ghes_addr_le and hest_addr_le will be migrated
altogether.

Did I miss something?

Thanks,
Mauro

