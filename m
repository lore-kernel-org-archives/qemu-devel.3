Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EFCC3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrjU-0003M9-DZ; Mon, 19 May 2025 00:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uGrjO-0003Lg-UU
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:04:03 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1uGrjL-0003fb-PP
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:04:02 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b1396171fb1so2234101a12.2
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747627437; x=1748232237; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=02NqxBW3qQdmYXTr1KkhoGNaQoa1PsgXXqCCGD+KoUg=;
 b=eK+6yZUZ88ISyGlLp9PiEypTnO0AGoyABY+ol9jN9SBbCeCL0/4Um3NdyMeeuHHcce
 HR8dWQxQgauaf2On8flUediWmxez4qIMPscB7UenEvhC9MJkVxnAxCIlZYvEzOu2rGMX
 MN85Fq18PsuG9S6AGkf98MNUCX4tlDy1sEQWVJjbZQuR6+QMLfH/a56N3scqAUEXi2jr
 aM+4WrzSboGP9RxRYRhOvo/u6k80yQ/C1mqIVR6/X9RSfOeKnmM1hp0tFq+hT3fqScfS
 9mj/SrgEmcHGMMkoZKH+p9mgs+Nrs+RJ2JBTLFb15JG3ko5UZqlfRG3BOichXCv7ITAI
 Bk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627437; x=1748232237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02NqxBW3qQdmYXTr1KkhoGNaQoa1PsgXXqCCGD+KoUg=;
 b=sSvNndU0zrF2kR3D41wsscGtfiqs1p8T93AYiqfajg6ZAzUXMavj53NfCG/94/TsgU
 DqY8YgZ+QCmPOAN58ovMBZa/DiJhm4+b236TS73W+y3qnC0Tk1o8NPRFCQN2sxrjO4Bl
 V1r6QtNcj7+LhZCZQMkcTbjcB1loQa0ZMmwiexoVfTUpIFfWnc14owY6G+/HIh0YLBDn
 x4/cwqFMsbduk7uDUB1KZFRUk9m4jddJQqfunS/XcVCk7YQBAuLlUNY6YDML2lAzsfox
 FcaT6K8wdH2NmtYoxgpyyzYGhCwSehjdXTYgyPhFGuI+DIm68M00iqWtqx3sktBfT1VN
 D9LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1eVGDZPCYrBc800xWf5Kkf/lUbMNt73b0zzgAQ6CKO2baNqGKSsegr/lusuvXeY2fqcSKQ5AsA/5X@nongnu.org
X-Gm-Message-State: AOJu0YxFrovLyutWxdrNcHoda2N4sN2dYQEg/nf5NAuPY3xm5ZFqcfnB
 R+D1YohAaWBiAyAgJXvdftVmEmciKweaeC2qAkc/LBM/OoCS578vRhO6xt9ch+etSOY=
X-Gm-Gg: ASbGncsimDiTvqXNQnftM7JR8sBhhCZfEzmztou4vwjWAjEQRxfy1lbQfdfyLVQG+w+
 5WO8augE6aIrzYsk7N2MBj3u89yz+p72b7SjTiIuTY2TdVZW+nD58lfHmvUYSKCSaaHHxrpPgeG
 aQj9F/t9iPd3hC2ZHGe5oHA3pQ6ta9Q1RyZ7f1ryYxH/ksDjB6+cWbaOPBhGmOGi2LtGisWsyq3
 mZmxTjSMhov/kmxQ87ZM8OapujkKbePmsc7DbipMMs4SyFdgNMLHi3Pyp5TYpxe9CtA9r72D775
 3ysBqVPUcgt67w+rlWZjBjPpXJ+IkB4dDME0AHrv28b7ccz4jTIqyAYwCYE=
X-Google-Smtp-Source: AGHT+IFtzBUirzOOsBz7D+ouMbSTc/hyVnclkhndAVDkubanaRBQPwqJF0zLVFRd/AhHbO5UMmjnrA==
X-Received: by 2002:a17:903:24e:b0:22e:4a6c:fef2 with SMTP id
 d9443c01a7336-231d45ae355mr183382195ad.53.1747627437632; 
 Sun, 18 May 2025 21:03:57 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ed546fsm50138045ad.231.2025.05.18.21.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:03:55 -0700 (PDT)
Date: Mon, 19 May 2025 09:33:45 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Li Chen <me@linux.beauty>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>
Subject: Re: [PATCH V3 3/4] tests/qtest/bios-tables-test: Add test for
 disabling SPCR on RISC-V
Message-ID: <aCqtob_S5FKsG-1r@sunil-laptop>
References: <87msberqzi.wl-me@linux.beauty>
 <87ikm2rqn8.wl-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikm2rqn8.wl-me@linux.beauty>
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 15, 2025 at 08:43:07PM +0800, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
>  
> Add ACPI SPCR table test case for RISC-V when SPCR was off.
> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>  tests/qtest/bios-tables-test.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index d2a1aa7fb3..44de152a36 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1807,6 +1807,26 @@ static void test_acpi_aarch64_virt_tcg_acpi_spcr(void)
>                    " -machine spcr=off", &data);
>      free_test_data(&data);
>  }
> +
> +static void test_acpi_riscv_virt_tcg_acpi_spcr(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .arch = "riscv64",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2",
> +        .ram_start = 0x80000000ULL,
> +        .scan_len = 128ULL * 1024 * 1024,
> +        .variant = ".acpispcr",
> +    };
> +
> +    test_acpi_one("-cpu rva22s64 "
> +                  "-machine spcr=off", &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_tcg_acpi_hmat(const char *machine, const char *arch)
>  {
>      test_data data = {};
> @@ -2612,6 +2632,8 @@ int main(int argc, char *argv[])
>              qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
>              qtest_add_func("acpi/virt/numamem",
>                             test_acpi_riscv64_virt_tcg_numamem);
> +            qtest_add_func("acpi/virt/acpispcr",
> +                           test_acpi_riscv_virt_tcg_acpi_spcr);
>          }
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

