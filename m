Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721B9C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 11:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgjdG-0000Ds-An; Wed, 21 Aug 2024 07:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sgjdD-0008UM-Qe
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 07:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sgjdB-0000S3-Fz
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 07:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724240160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jCLIHRuyWWYsLZrb4lpZV22sutMGxNh+NMlxu1xhu8Y=;
 b=TaHNhRUuB+ewMZa/d2UrQGV6lfYNvGXu+NK2FU/dMYQfOfEIr+9YT3xkCZagtSL1HBSjeK
 ln4qkviIF9zZw/0yoJZnVa6nBZM2OGLTf/oCMWknDz0guyDjrCu3ZJkBgUmCy4wtJvZe1P
 UAM8dQmJ8HccJLyB8esXUYrx/TLZoWI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-1_WHwuZXOGGxBLfX3wmcZQ-1; Wed,
 21 Aug 2024 07:34:19 -0400
X-MC-Unique: 1_WHwuZXOGGxBLfX3wmcZQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1AE11955F43; Wed, 21 Aug 2024 11:34:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.20])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 873CE300019C; Wed, 21 Aug 2024 11:34:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 691EA18011E8; Wed, 21 Aug 2024 13:34:10 +0200 (CEST)
Date: Wed, 21 Aug 2024 13:34:10 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 ajones@ventanamicro.com
Subject: Re: [PATCH for-9.2 v6 04/12] pci-ids.rst: add Red Hat pci-id for
 RISC-V IOMMU device
Message-ID: <p5vzcg5upugvchrkryji66u52olcpoajaldu5pcv2hbh5s3b7k@lveutpsuoqdw>
References: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
 <20240801154334.1009852-5-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801154334.1009852-5-dbarboza@ventanamicro.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Aug 01, 2024 at 12:43:25PM GMT, Daniel Henrique Barboza wrote:
> The RISC-V IOMMU PCI device we're going to add next is a reference
> implementation of the riscv-iommu spec [1], which predicts that the
> IOMMU can be implemented as a PCIe device.
> 
> However, RISC-V International (RVI), the entity that ratified the
> riscv-iommu spec, didn't bother assigning a PCI ID for this IOMMU PCIe
> implementation that the spec predicts. This puts us in an uncommon
> situation because we want to add the reference IOMMU PCIe implementation
> but we don't have a PCI ID for it.
> 
> Given that RVI doesn't provide a PCI ID for it we reached out to Red Hat
> and Gerd Hoffman, and they were kind enough to give us a PCI ID for the
> RISC-V IOMMU PCI reference device.
> 
> Thanks Red Hat and Gerd for this RISC-V IOMMU PCIe device ID.
> 
> [1] https://github.com/riscv-non-isa/riscv-iommu/releases/tag/v1.0.0
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>


