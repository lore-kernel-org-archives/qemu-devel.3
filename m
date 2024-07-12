Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B930C3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFkW-0000ZI-Oo; Fri, 12 Jul 2024 08:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSFkE-0008TE-3F
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSFk8-0002IG-7c
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720788678;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+fMXABX8IQTooeTgWrg+I2pCs1k0fwLsAX5r4YC1le4=;
 b=Q/u7FmGMHbIYLR4vj+4vUEJNcaWOGjPD9CbBB5M6CDf6Wzq/aYvgl04PCLGZdhwmz69yvq
 N9vNb7Ibd3iEELbkjl9FM/piERL1Z9z4WiS6SfjIm1d4bXlgPVWoxDf9GqTT3GMZ1IML4Z
 03uKlItcZDpryzc+z8hFv25j1NJWvNc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-vuD0kHE1PV2CtE0wUGFyxw-1; Fri,
 12 Jul 2024 08:51:15 -0400
X-MC-Unique: vuD0kHE1PV2CtE0wUGFyxw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8983319560B5; Fri, 12 Jul 2024 12:51:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8063A195606C; Fri, 12 Jul 2024 12:51:08 +0000 (UTC)
Date: Fri, 12 Jul 2024 13:51:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 0/9] RISC-V: ACPI: Namespace updates
Message-ID: <ZpEmuB6xyh2K77Ic@redhat.com>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240712144319.233c19a7@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240712144319.233c19a7@imammedo.users.ipa.redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 12, 2024 at 02:43:19PM +0200, Igor Mammedov wrote:
> On Mon,  8 Jul 2024 17:17:32 +0530
> Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> > This series adds few updates to RISC-V ACPI namespace for virt platform.
> > Additionally, it has patches to enable ACPI table testing for RISC-V.
> > 
> > 1) PCI Link devices need to be created outside the scope of the PCI root
> > complex to ensure correct probe ordering by the OS. This matches the
> > example given in ACPI spec as well.
> > 
> > 2) Add PLIC and APLIC as platform devices as well to ensure probing
> > order as per BRS spec [1] requirement.
> > 
> > 3) BRS spec requires RISC-V to use new ACPI ID for the generic UART. So,
> > update the HID of the UART.
> > 
> > 4) Enabled ACPI tables tests for RISC-V which were originally part of
> > [2] but couldn't get merged due to updates required in the expected AML
> > files. I think combining those patches with this series makes it easier
> > to merge since expected AML files are updated.
> > 
> > [1] - https://github.com/riscv-non-isa/riscv-brs
> > [2] - https://lists.gnu.org/archive/html/qemu-devel/2024-06/msg04734.html
> 
> btw: CI is not happy about series, see:
>  https://gitlab.com/imammedo/qemu/-/pipelines/1371119552
> also 'cross-i686-tci' job routinely timeouts on bios-tables-test
> but we still keep adding more tests to it.
> We should either bump timeout to account for slowness or
> disable bios-tables-test for that job.

Asumming the test is functionally correct, and not hanging, then bumping
the timeout is the right answer. You can do this in the meson.build
file

We should never disable tests only in CI, because non-CI users
are just as likely to hit timeouts.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


