Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E437EC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRuEl-00055G-Ma; Thu, 11 Jul 2024 09:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRuEk-00052C-UA
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:53:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRuEU-0003U3-3f
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720705992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lxk5YZf7FVMgsc3glhDTzLAvcLoX3al/3jsWvTicxYg=;
 b=Cv5/OGb9yuF/br9Ra6LWrns7vXdGRDuJg+bqTghkcGYSWlrsRLbKiXEl07vKa3T6RsKIp0
 m50793Ny3+vUKvPX5R9jC6Z5PA6c/J0CmfrfvsHQt3pbbnRHrS/6L1CY9VrSCc7SJrNmRK
 kCTZ8oTXj7EY5RgQomh8t8BZNngK0GM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-3bfgep3zN6u8ZK9kkDQTvg-1; Thu, 11 Jul 2024 09:53:10 -0400
X-MC-Unique: 3bfgep3zN6u8ZK9kkDQTvg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-367a3052cfaso633811f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720705989; x=1721310789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lxk5YZf7FVMgsc3glhDTzLAvcLoX3al/3jsWvTicxYg=;
 b=d6yRmWGS81DMk0Hgk3l6piLNeaMzL0h4lOaEQgBOv6hWDrBkbdfzZ1Fc8lbopim4wh
 n6wcBgnIi88mBexdJVzRoX9kmTjZB49cax9hH9tHl09OXsa+FyD8dB2qArFmtgkgg+6B
 n20b0WAnw7KQzvFj5ISvHoQQzflqi1RSXM4FRFDeY+l0eGyHHQqW3HboJv7lv+iJFuo3
 X6Xw7ao0p85Co0TJVfyNfu4vLi3NyilRDomURTEpC3jtDyO81MvZ6lpHNNXYf285wZg5
 yLORJG0MVkq131C3VO/c02dWwPiNoM2kgjkNmF6qj2xNISJIdsyK5rJFlXh/RHwLM4m6
 4XeA==
X-Gm-Message-State: AOJu0YxFIT2oTQexiZ99tAzVJqklcIVNpG4q7Bn4Y+eC6xqgkpoXhirF
 ybKbW1TEhlKjCxpN0nHvXomOkfUi27NiDHHhsgidbX29twD2DSpE3i2DGKKARFOplgSe5j5q5B5
 6W201jQqYfx8tUMTxr381hxWH56BgqvZZwMllmpdp9hn5BPYtn2CM
X-Received: by 2002:a05:6000:884:b0:367:9049:da36 with SMTP id
 ffacd0b85a97d-367cead121dmr7746944f8f.44.1720705989648; 
 Thu, 11 Jul 2024 06:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEZtoYfdsctch1MmTh/P4kIFNu2VCKbrAzsmkeegIwLxi7k8IuVKqSB0x1hbqgOuwkOUCkgA==
X-Received: by 2002:a05:6000:884:b0:367:9049:da36 with SMTP id
 ffacd0b85a97d-367cead121dmr7746928f8f.44.1720705989318; 
 Thu, 11 Jul 2024 06:53:09 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde7e32asm7823914f8f.10.2024.07.11.06.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:53:08 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:53:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 3/9] tests/acpi: Allow DSDT acpi table changes for
 aarch64
Message-ID: <20240711155308.61adccfe@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240708114741.3499585-4-sunilvl@ventanamicro.com>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240708114741.3499585-4-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon,  8 Jul 2024 17:17:35 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> so that CI tests don't fail when those ACPI tables are updated in the
> next patch. This is as per the documentation in bios-tables-tests.c.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..9282ea0fb2 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,7 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/DSDT",
> +"tests/data/acpi/aarch64/virt/DSDT.memhp",
> +"tests/data/acpi/aarch64/virt/DSDT.topology",
> +"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
> +"tests/data/acpi/aarch64/virt/DSDT.pxb",
> +"tests/data/acpi/x86/microvm/DSDT.pcie",


