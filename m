Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E394CC54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 12:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLhs9-0004C3-90; Sun, 01 Jun 2025 08:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLhs7-0004Bb-GH
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 08:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLhs5-0004FU-FE
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 08:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748781179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kGkc5/H5rP3Fw2YD6zqyIcr/t3XjduTK7nEOcLxDx+w=;
 b=Iuh19hIYsCTAIrQd/G5fLMN/d19Qzbuv9Aqn33EGxie+EpevFyFe+4rbjDN9ELgb3BSFtI
 oucXppXO496a2S2GDLZLaGy25nYYCG5+fWvFQhiLFPY7hW8L1uyoQnAnTUoXiDzL/ll3g1
 eKvd64hxUL0YpMAylp7ve8MLqlZbT20=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-JE80hAhdNway-q-hcIm5ww-1; Sun, 01 Jun 2025 08:32:58 -0400
X-MC-Unique: JE80hAhdNway-q-hcIm5ww-1
X-Mimecast-MFC-AGG-ID: JE80hAhdNway-q-hcIm5ww_1748781177
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so398536f8f.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 05:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748781177; x=1749385977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kGkc5/H5rP3Fw2YD6zqyIcr/t3XjduTK7nEOcLxDx+w=;
 b=kJu/oOnOQQaK29ZWBkm4A88eQQdZO3MzNu4Gc1LoHBUzdbFv8t+P0g+TT+UXmbabDu
 lA2ykHW9gfkUUW/d+5v/88YH9Xbfo0pp6a65w0Uq2OpEfH1tENEYCvUPmbaGs8mw9oo6
 R9NZVeiEuQuGmVfyr/wAEPSMVgFukeq7UwGifCzqkLVJsuCAkpInGQ6Gq7kfB/nxXFue
 e1T6IhLEip5w4EqEutWXJIwPQs2ohz6GjMK9D/6Mcf+j/OvLJYO31uQPNW+Zo87nLmlv
 WARHPbK6gPElKDNer038y99fbDcjMAipeIs2bY9XXWnstp2OkE+ItLZGN5TRiTBqu5P5
 Vz9Q==
X-Gm-Message-State: AOJu0YwRyYj/aB1vy689KyozXlpADMjYJKEHUCAK2y1QcQaSrGHen+Wp
 mm1RHlEUAh3lCDt2YZWfXE9mLL5m+E3x36s/NWNwNWCUO9RMeCeXAUsNymTmaqCG7Q5WoYXqhd1
 6g2w5VVIgEz8wgMi3NWenYYkQ2gFtNzGOANXJZMIFtPy+pfRyEAXKnyTR
X-Gm-Gg: ASbGncumBxAoYSOkwivc8Jdxu4e4JWx8iOuj34ruS/mpIWuGFsXwCUyqpiZZiEZDSSj
 horJAbF0jeSyv72p8hwEvfCN0z4PwUjgzxkek5No9oFPwu9xF1IJ98/U7bpsdgkr2Jn6Wv+V9pn
 NjB8bPZnx4lL1bYxvhdmB/vEtzYY+kk/mRzCuxDEgIRkcHPc/69V6tY3/4xOx6bi0KD0bJ62h7O
 jlLLBcDxhc2/9aIE5GPhatdcjazwztyxtqRb2omYJxwcrUNtJO68xoEWdJvbXcxI+9+UO/4xbyH
 jfNaPQ==
X-Received: by 2002:a05:6000:18a2:b0:3a3:70ab:b274 with SMTP id
 ffacd0b85a97d-3a4eed99115mr11648319f8f.12.1748781176777; 
 Sun, 01 Jun 2025 05:32:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLww/9qXeLPuKNXWzhAfkOWXd8ej0zPf3muEZEQR3Sa5MSnrsSHoKim18mUXWRyR8XWv+2Gg==
X-Received: by 2002:a05:6000:18a2:b0:3a3:70ab:b274 with SMTP id
 ffacd0b85a97d-3a4eed99115mr11648295f8f.12.1748781176414; 
 Sun, 01 Jun 2025 05:32:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009fd9bsm11219791f8f.82.2025.06.01.05.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 05:32:55 -0700 (PDT)
Date: Sun, 1 Jun 2025 08:32:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, anisinha@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com,
 peter.maydell@linaro.org, prime.zeng@hisilicon.com,
 shameerali.kolothum.thodi@huawei.com, wangyanan55@huawei.com,
 yangyicong@hisilicon.com, Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH v5 0/4] Building PPTT with root node and identical
 implementation flag
Message-ID: <20250601082826-mutt-send-email-mst@kernel.org>
References: <20250523102654.1719-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523102654.1719-1-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 23, 2025 at 11:26:50AM +0100, Alireza Sanaee wrote:
> OS like Linux is using PPTT processor node's identical implementation
> flag [1] to infer whether the whole system or a certain CPU cluster is
> homogeneous or not [2]. QEMU currently only support building homogeneous
> system, set the flag to indicate the fact. Build a root node in PPTT for
> indicates the identical implementation which is needed for a
> multi-socket system. Update the related PPTT tables as well.
> 
> [1] ACPI 6.5 Table 5.158: Processor Structure Flags
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/pptt.c?h=v6.11-rc1#n810
> 
> History:
>     * v4->v5: fixed a typo
> 
>     * v3->v4: PPTT rev to 2
> 
>     * v2->v3: rebase to 10
> 
> Alireza Sanaee (2):
>   hw/acpi/aml-build: Build a root node in the PPTT table
>   tests: virt: Update expected ACPI tables for virt test
> 
> Yicong Yang (2):
>   tests: virt: Allow changes to PPTT test table
>   hw/acpi/aml-build: Set identical implementation flag for PPTT
>     processor nodes
> 
>  hw/acpi/aml-build.c                           |  24 +++++++++++++++---
>  tests/data/acpi/aarch64/virt/PPTT             | Bin 76 -> 96 bytes
>  .../data/acpi/aarch64/virt/PPTT.acpihmatvirt  | Bin 156 -> 176 bytes
>  tests/data/acpi/aarch64/virt/PPTT.topology    | Bin 336 -> 356 bytes
>  4 files changed, 20 insertions(+), 4 deletions(-)


This interacts weirdly with loongarch. I tried applying patches
on top of that, and on loongarch, I see:

-[0F0h 0240 004h]       Flags (decoded below) : 00000000
+[0F0h 0240 004h]       Flags (decoded below) : 0000000E
                             Physical package : 0
-                     ACPI Processor ID valid : 0
-                       Processor is a thread : 0
-                              Node is a leaf : 0
+                     ACPI Processor ID valid : 1
+                       Processor is a thread : 1
+                              Node is a leaf : 1
                     Identical Implementation : 0


I'm sending a pull request later today. Once merged, pls
rebase on top of that, updating loongarch as appropriate
and repost copying relevant people.

Cc Bibo Mao for more insight.


> -- 
> 2.34.1


