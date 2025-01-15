Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444A9C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY2sN-0008Vq-TM; Wed, 15 Jan 2025 07:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tY2sJ-0008SC-2c; Wed, 15 Jan 2025 07:51:59 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tY2sG-0006zD-K1; Wed, 15 Jan 2025 07:51:58 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 92013A41F36;
 Wed, 15 Jan 2025 12:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D80CC4CEDF;
 Wed, 15 Jan 2025 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736945515;
 bh=xVlIA1ZBfx9UjaShX5trBrkyVh5DWAz9sUCHbHTMPHk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ez+TasmlorDLtiE3xHdMvQyNqBQ9bEUBPw1D/lPvwZ6i9hMavx+dCQeD4k/+gQZ/0
 /EdF/Q/QhFP+3N/E7HNmevCo7xS0bU+CkX7TYNrp0gp0zsdubMHegpwofloNSyJW7i
 HtA6UpPisawcHNGfTi2jw0LlnLrGgpg6+cMOokpQSzt/KhzKpVUhckyLZvcsS5dZGV
 AmQv3V2lgM2lXy4WyqwTnIM6E1Yc2i+Pz4X5R3j+qEgYv2Lerq64/r1E50mnbMWFMj
 VqQ76DTvDBQ57y5xAhdZGWEPG42AJsoUJ6+0kGJ5SqofK6j2ThIRHZupxOtpbLEoT1
 i7sIA06EoxhYA==
Date: Wed, 15 Jan 2025 13:51:49 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 00/16] Prepare GHES driver to support error injection
Message-ID: <20250115135149.24d1f53f@foz.lan>
In-Reply-To: <20250115060854-mutt-send-email-mst@kernel.org>
References: <cover.1733561462.git.mchehab+huawei@kernel.org>
 <20250115060854-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

Em Wed, 15 Jan 2025 06:09:12 -0500
"Michael S. Tsirkin" <mst@redhat.com> escreveu:

> On Sat, Dec 07, 2024 at 09:54:06AM +0100, Mauro Carvalho Chehab wrote:
> > Hi Michael,
> > 
> > Please ignore the patch series I sent yesterday:
> > 	https://lore.kernel.org/qemu-devel/20241207093922.1efa02ec@foz.lan/T/#t
> > 
> > The git range was wrong, and it was supposed to be v6. This is the right one.
> > It is based on the top of v9.2.0-rc3.
> > 
> > Could you please merge this series for ACPI stuff? All patches were already
> > reviewed by Igor. The changes against v4 are just on some patch descriptions,
> > plus the addition of Reviewed-by. No Code changes.
> > 
> > Thanks,
> > Mauro  
> 
> 
> Still waiting for a version with minor nits fixed.

Just sent v7 addressing the minor nits on patch 9.

> > -
> > 
> > During the development of a patch series meant to allow GHESv2 error injections,
> > it was requested a change on how CPER offsets are calculated, by adding a new
> > BIOS pointer and reworking the GHES logic. See:
> > 
> > https://lore.kernel.org/qemu-devel/cover.1726293808.git.mchehab+huawei@kernel.org/
> > 
> > Such change ended being a big patch, so several intermediate steps are needed,
> > together with several cleanups and renames.
> > 
> > As agreed duing v10 review, I'll be splitting the big patch series into separate pull 
> > requests, starting with the cleanup series. This is the first patch set, containing
> > only such preparation patches.
> > 
> > The next series will contain the shift to use offsets from the location of the
> > HEST table, together with a migration logic to make it compatible with 9.1.
> > 
> > ---
> > 
> > v5:
> > - some changes at patches description and added some R-B;
> > - no changes at the code.
> > 
> > v4:
> > - merged a patch renaming the function which calculate offsets to:
> >   get_hw_error_offsets(), to avoid the need of such change at the next
> >   patch series;
> > - removed a functional change at the logic which makes
> >   the GHES record generation more generic;
> > - a couple of trivial changes on patch descriptions and line break cleanups.
> > 
> > v3:
> > - improved some patch descriptions;
> > - some patches got reordered to better reflect the changes;
> > - patch v2 08/15: acpi/ghes: Prepare to support multiple sources on ghes
> >   was split on two patches. The first one is in this cleanup series:
> >       acpi/ghes: Change ghes fill logic to work with only one source
> >   contains just the simplification logic. The actual preparation will
> >   be moved to this series:
> >      https://lore.kernel.org/qemu-devel/cover.1727782588.git.mchehab+huawei@kernel.org/
> > 
> > v2: 
> > - some indentation fixes;
> > - some description improvements;
> > - fixed a badly-solved merge conflict that ended renaming a parameter.
> > 
> > Mauro Carvalho Chehab (16):
> >   acpi/ghes: get rid of ACPI_HEST_SRC_ID_RESERVED
> >   acpi/ghes: simplify acpi_ghes_record_errors() code
> >   acpi/ghes: simplify the per-arch caller to build HEST table
> >   acpi/ghes: better handle source_id and notification
> >   acpi/ghes: Fix acpi_ghes_record_errors() argument
> >   acpi/ghes: Remove a duplicated out of bounds check
> >   acpi/ghes: Change the type for source_id
> >   acpi/ghes: don't check if physical_address is not zero
> >   acpi/ghes: make the GHES record generation more generic
> >   acpi/ghes: better name GHES memory error function
> >   acpi/ghes: don't crash QEMU if ghes GED is not found
> >   acpi/ghes: rename etc/hardware_error file macros
> >   acpi/ghes: better name the offset of the hardware error firmware
> >   acpi/ghes: move offset calculus to a separate function
> >   acpi/ghes: Change ghes fill logic to work with only one source
> >   docs: acpi_hest_ghes: fix documentation for CPER size
> > 
> >  docs/specs/acpi_hest_ghes.rst  |   6 +-
> >  hw/acpi/generic_event_device.c |   4 +-
> >  hw/acpi/ghes-stub.c            |   2 +-
> >  hw/acpi/ghes.c                 | 259 +++++++++++++++++++--------------
> >  hw/arm/virt-acpi-build.c       |   5 +-
> >  include/hw/acpi/ghes.h         |  16 +-
> >  target/arm/kvm.c               |   2 +-
> >  7 files changed, 169 insertions(+), 125 deletions(-)
> > 
> > -- 
> > 2.47.1
> >   
> 



Thanks,
Mauro

