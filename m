Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1E8D74EF8
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 16:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjJeC-0006wY-2R; Fri, 23 Jan 2026 11:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vjJdo-0006qC-Nh
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 11:04:10 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vjJdl-0006G4-6P
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 11:04:07 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8c5349ba802so253508385a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 08:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1769184242; x=1769789042; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1kQmBSg+tA8MLRBzDeZG0ZWkb9fuamq1qYDJiutcxtM=;
 b=XZ3nXKd28JhBW1PXnQLAEl2Fqe3J3q2HaOO9IWdWK3LiJmw/qjeJe5xZCBzcZQQjDy
 kimE1hs6S1+hYhPfUkO2l4tMsg1VZXRnbMJsf2/8NdcongAad+Xrio+lV8r0zbS7XNAb
 JvM4catDRyw9ZWKFCrmYUZS462uCv0IMxsKk8I9kJikB+s8R0Kh0B7Fia5v1L8wWcsCz
 Obe4W9NkwALiB0mHi6DvnKNTQkKGk7AIL1PjXjX5qLpMbIoB/DQkUyL4wzXOcHAuNX6e
 KEx3WK7s6wT1f+qn9D4Dwl1PPyaRLEnY1W726kipNA9eE1IK+svnUI3lTEUCoqZDb9iS
 pslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769184242; x=1769789042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1kQmBSg+tA8MLRBzDeZG0ZWkb9fuamq1qYDJiutcxtM=;
 b=O7LIK46f06KotaEMQslhNrjaTJef7YNUMju+ost/m9dvKMNLZ8YgXN9NWRUCdrrTaE
 SrsoIwwS8bPwCcTScBBBoxXLvA5U3QV0bgA5lVn7M4b3qhtNutlYbsF+9X4AqqrRS2uP
 gDNAQJC+VZWaR9rhT5VLAeJZmgeiXa4Ccip0pBwQ4Oo0SJx0l7uytdiyn6Jg/4UQyits
 xmLrtWbjRPDVw5acqYF1TKuGXUxhWuB+ttZ+wlN42lOCIDrhwcTHmjqZfjMojFK97O7A
 UoHeDRr4UFUfzLotJLF6Ndh1oX3cTCSpWasn7JrGViivEQfghYiUMUbGwO8ToCywOixJ
 SLHQ==
X-Gm-Message-State: AOJu0YyKgVU2baghA21AY1jZhJ7kGqCg7ntLBWPTnn2W4fKohLm0xisT
 Sh3aQocFBzKwCUwHzfjcS/6RW0tMz3G7PKmwjigBi5ci4WHeldsA8bxGUKh2p6qRok0=
X-Gm-Gg: AZuq6aKUzhe8MFQPHR/enAz1pnbTDJOOo5wjECj2gUtIB609LfCTJUbJ0whyesLRTkT
 HAk//IkH2paaprSqa1G4q8QM7SI3zKWzjy19FwCcg6bK2LoT0A/lUbYnhfmiPhenUcyoTaJbsGh
 /wzjDb9fXcplpWDXcbbXx0xUqM8wdRqVFZL/rVj5QlKeWEjRx+turMchFmzjNYtsjZ+ZnUtiHd1
 HPbU4hYddcf7PbdXdnFCoe5hmog8hjzkZEmqmrAXmADbnXN50s4g687r5cFYXBDuNXxlh1Mpe1k
 CVMzV6Dnt6DmmphKM+o+8B19dUdwD/cMTmedvMyb59G2gxDWYvJzhsvhWxWvDo0LofJQ2/r9+0H
 M5UbEtZtFjFPiikhkD7SoI0ZcQXLHee3jgMXWvIPrgkuxpoQrmyDBhZ7ATXNRONDT0siUeop4Hx
 cYJAPqtii59RoMQ2l8F0zc0fFDVDv+GvLcOu7ihXq58BtoaOOVkkZalaAJGax5Yr2O4+dw6w==
X-Received: by 2002:a05:620a:468f:b0:8c5:38ff:d4e1 with SMTP id
 af79cd13be357-8c6e91224f2mr173041585a.23.1769184242169; 
 Fri, 23 Jan 2026 08:04:02 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e383a95fsm202381485a.31.2026.01.23.08.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 08:04:01 -0800 (PST)
Date: Fri, 23 Jan 2026 11:03:59 -0500
From: Gregory Price <gourry@gourry.net>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, apopple@nvidia.com,
 dan.j.williams@intel.com, Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
Subject: Re: [PATCH v5 1/1] numa: add 'memmap-type' option for memory type
 configuration
Message-ID: <aXOb7xOKNR62d7oy@gourry-fedora-PF4VCD3F>
References: <20260123024312.1601732-1-FangSheng.Huang@amd.com>
 <20260123024312.1601732-2-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123024312.1601732-2-FangSheng.Huang@amd.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=gourry@gourry.net; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 23, 2026 at 10:43:12AM +0800, fanhuang wrote:
> +bool e820_update_entry_type(uint64_t start, uint64_t length, uint32_t new_type)
> +{
> +    uint64_t end = start + length;
> +    assert(!e820_done);
> +
> +    /* For E820_SOFT_RESERVED, validate range is within E820_RAM */
> +    if (new_type == E820_SOFT_RESERVED) {
> +        bool range_in_ram = false;
> +
> +        for (size_t j = 0; j < e820_entries; j++) {
> +            uint64_t ram_start = le64_to_cpu(e820_table[j].address);
> +            uint64_t ram_end = ram_start + le64_to_cpu(e820_table[j].length);
> +            uint32_t ram_type = le32_to_cpu(e820_table[j].type);
> +
> +            if (ram_type == E820_RAM && ram_start <= start && ram_end >= end) {
> +                range_in_ram = true;
> +                break;
> +            }
> +        }
> +        if (!range_in_ram) {
> +            return false;
> +        }
> +    }

------- nit --------
this can be shortened: (j == e820_entries) implies not found.

    if (new_type == E820_SOFT_RESERVED) {
        for (size_t j = 0; j < e820_entries; j++) {
            uint64_t ram_start = le64_to_cpu(e820_table[j].address);
            uint64_t ram_end = ram_start + le64_to_cpu(e820_table[j].length);
            uint32_t ram_type = le32_to_cpu(e820_table[j].type);

            if (ram_type == E820_RAM && ram_start <= start && ram_end >= end)
                break;
        }
        if j == e820_entries: /* Not found */
            return false;
    }

Haven't looked at the surrounding code, this seems like you might define

   static bool e820_has_ram_region(start, end) { /* above code */ }

then the 820_update_entry_type lines can just be

    if (new_type == E820_SOFT_RESERVED &&
        !e820_has_ram_region(start, end))
        return false;

only worth it if e820_has_ram_region() deduplicates other stuff.
-------------------

I don't see anything else immediately concerning and the above is more
of a nit than anything.  

I haven't tested this, you might at least add the OS-facing results to
the changelog so someone can replicate your setup.

For example the early-boot print showing E820 and ACPI SRAT data.

   [reasonable memdev definitions]
   -numa node,nodeid=0,memdev=m0
   -numa node,nodeid=1,memdev=m1,memmap-type=spm
   -numa node,nodeid=2,memdev=m2,memmap-type=reserved

resulting in:
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000afffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000c04fffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000c050000000-0x000001004fffffff] soft reserved
[    0.000000] BIOS-e820: [mem 0x0000010050000000-0x000001006fffffff] reserved

[    0.003409] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0xafffffff]
[    0.003410] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xc04fffffff]
[    0.003411] ACPI: SRAT: Node 1 PXM 1 [mem 0xc050000000-0x1004fffffff] hotplug
[    0.003411] ACPI: SRAT: Node 2 PXM 2 [mem 0x10050000000-0x1006fffffff] hotplug

  (fake entries above)
  (i don't actually know if RESERVED gets added to SRAT)

This would at least show the node-association and the types are correct.

Thanks,
~Gregory

