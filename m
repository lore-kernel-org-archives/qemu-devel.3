Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBC0C02190
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 16:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdtek-0006rg-39; Fri, 31 Jan 2025 11:14:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tdtee-0006qM-Ed; Fri, 31 Jan 2025 11:14:04 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tdtec-0008AN-MI; Fri, 31 Jan 2025 11:14:04 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 39F7A5C5DCD;
 Fri, 31 Jan 2025 16:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8DAC4CEDF;
 Fri, 31 Jan 2025 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738340039;
 bh=4jipEBrnBk0sRaw7d+8DvwEvKyP+4wnYazk96RKoz1E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OjKzNgUAesKydg1HFCVNNmt70nfppJDyKSgAWVIljHZqVeNSAYrEYDqX3mIgYSUMZ
 i5XB3O14Hoc1FFmX5/v6kVeh4J6b1er95H1N3H8nFA+H/dxdALv2iKS1cD3s+q2Ktu
 uiA/ksCcAyffHL5472uXkb7iRDkPmsMAOeRAOipuCBhIhEC7UvefRbpAxwYQc0Utm/
 o5rebXPnjMMVV1eEBUc0eHplgbkVvjlgWKU9UlYBAFvTpnkK1aVNJ/4UGfHy6fiw8k
 CHJQ7/d1e+e8sNIfKMFVbO33lEAeSYj0Ae9XvYV4jvW23NdS6MXtcw44OspMcVRl9y
 CsajEfYHQ8exg==
Date: Fri, 31 Jan 2025 17:13:54 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] acpi/ghes: add a firmware file with HEST address
Message-ID: <20250131171354.36fc5844@foz.lan>
In-Reply-To: <20250129162328.17680ee7@imammedo.users.ipa.redhat.com>
References: <cover.1738137123.git.mchehab+huawei@kernel.org>
 <294577300217e4f7a606f3cb17382fd108c8c021.1738137123.git.mchehab+huawei@kernel.org>
 <20250129162328.17680ee7@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

Em Wed, 29 Jan 2025 16:23:28 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> > +
> > +    /*
> > +     * Tell firmware to write into GPA the address of HEST via fw_cfg,
> > +     * once initialized.
> > +     */
> > +    bios_linker_loader_write_pointer(linker,
> > +                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> > +                                     sizeof(uint64_t),
> > +                                     ACPI_BUILD_TABLE_FILE, hest_offset);  
> 
> it's not safe to add this without compat logic, as it changes size of linker
> table and possibly layout.
> 
> I'd suggest to  partially combine this with use_hest_addr patch.
> One way to do it cleanly would be to move part introducing
> use_hest_addr here and set it to false to start with,
> and flip default to true one all hest_addr_le code in place.
> see related comment 6/13 

Ok. It also means I need to temporarily get ags there, e. g.:


+    AcpiGedState *acpi_ged_state;
+    AcpiGhesState *ags = NULL;
+
+    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
+                                                       NULL));
+    if (acpi_ged_state) {
+        ags = &acpi_ged_state->ghes_state;
+    }
...
+    if (ags->use_hest_addr) {
+        bios_linker_loader_write_pointer(linker,
+                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
+                                         sizeof(uint64_t),
+                                         ACPI_BUILD_TABLE_FILE, hest_offset);
+    }


The part which gets ags will be dropped on this patch:

	ad2dc8716d1f acpi/generic_event_device: add logic to detect if HEST addr is available

which will set use_hest_addr to false, until we have everything in
place.

Thanks,
Mauro

