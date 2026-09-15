Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8F0C982C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6XLQ-0005z8-Ep; Tue, 15 Sep 2026 13:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x6XLL-0005y6-KT; Tue, 15 Sep 2026 13:53:20 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x6XLK-0003S6-7X; Tue, 15 Sep 2026 13:53:19 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A85860142;
 Tue, 15 Sep 2026 17:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38E31F000FF;
 Tue, 15 Sep 2026 17:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789494797;
 bh=EDg2lbS9FxueOTc0OmiHtUQtfNsIvgIeTNuEARoespI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=CdhlOSlbpttVGy84O4uFXV4oqNG9WLZTkedirtWQhq/IGhK5rsW/OOoOlK3H7PbT/
 iGkdJSxbjuMrlUxr6GUyUVG9k34URDKZ7KT81+QdLHlsHpk96d6Qfv27jBij2Rhwcn
 bLJRgs9tDAjWT39A31I+TRpfSUGsFjrUSxbIwglwW+aq27PESlJKKBsNh+sjh33m29
 xKSxgk5w+5W4sc8vwj/l0LOSg9mRkfUfyybGEQygoENeHO1Mfn5yLwhLkbofmkgCrC
 15z6jidU/ZJRTtrDrdPKa6wplSGjUCO8N2aIk2/J9iMRyYlP8GqW6vLSHYJTbhGVz5
 38I/aowXoYmhA==
Date: Tue, 15 Sep 2026 18:53:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, pbonzini@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 4/6] tests/qtest: Prepare golden files for the RISC-V
 CXL ACPI test
Message-ID: <20260915185312.3af64924@jic23-hlaptop>
In-Reply-To: <20260907093735.2753-5-cp0613@linux.alibaba.com>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
 <20260907093735.2753-5-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon,  7 Sep 2026 17:37:31 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> Add empty DSDT.cxl and CEDT.cxl golden files and list them in
> bios-tables-test-allowed-diff.h, in preparation for the RISC-V CXL
> bios-tables test added in the following patch.  The populated golden
> master binaries are committed separately in a final patch, following
> the bios-tables-test update process.
> 
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
boilerplate but for completeness
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

