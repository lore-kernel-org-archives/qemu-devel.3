Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A88606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V9m5k4+l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRY75-0003jA-QU; Thu, 12 Nov 2026 11:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRY6k-0003gz-7R
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:57:08 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRY6h-0007sH-IK
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:57:04 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-67bf3c6654fso5414112d50.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 08:56:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794502618; cv=none;
 d=google.com; s=arc-20260327;
 b=YBogYuof8bcgazJc1T2jj/ia7IhNBvBBTzUKWleyyMQeD9WwaiZaLlAN/BlWHGreVd
 O1tWh4i4BvcfMn5iY2YrGW2jnZqGusG31sAAFFBj7wNhRH/ewt7xhIuCHslB9uDt5H7u
 BCQ8qwu6Q48UOelz3y+TZP7Bef04UHsrYexZhEX74Jlx7ORI4wNG5JXbpKkadFpK9aA9
 Acv0glqb/6GmUBYU3TJoIirJxoIMTZOWZVHd2efPcPoAxXEGXfxceu4eQW91+yF5fAoC
 sKhQUiHH/IMmEZUU+I2qp+6/zMNAh7AS4oL+HwuGTp/gVv6HuXsDDIlQxq+r5h5xzW6o
 GStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B7Z8EmkExZ7lbGW2T4pH0RXgFzwbiI1ownej/XCibt0=;
 fh=52JM4fKn1w8g4fHRE48dqEgKJr2B9YY4zVgAtBHCZBo=;
 b=QNStq8tAZKzLtJvmN+LEedpYfmg1lY8027Ag2mnmYxrDgvdA/OKYIEs/dr/w0mUr1t
 dMyryqJzg578q3lvoW2tJjTfJAkgiSbZ1cyUy26SeS+jFdHqoKp8f4VF8+z3mWFLhTCT
 KKpYZ6e9rcX1/PpDemGfucUdWFBtL8Yy1s4wCIHCb0Bi8Xx7U8S+Ecw72/s35vj+6MbC
 OQx7eSNU9tyK64czkYo1B4RFP/Dg3/deZo5Q/H2d4Mg1mJWNgJyEzeLTG7txmx6jewqr
 njMb/AWWgmFGhjZrQZg/fnXjh4taevV3BU3+aoDZ2JE/DRfAIdsz8eUfu59betBW2b5/
 P2Vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794502618; x=1795107418; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B7Z8EmkExZ7lbGW2T4pH0RXgFzwbiI1ownej/XCibt0=;
 b=V9m5k4+l9E0k1fNHhy+elPb96aLDfdAtBgB1WW9Xf6hrQu0hh9p+VrY6olZ90Hg0Ly
 PHlohzbOe1HO1c9MVEy3rKMZJCmXQIUT8V31WtfBCn12bFRhNsXMgG1DH8z2dtzNfa/M
 89OQC84gxu3Ba9IldCAR6YBPGr5xKq8Et1qMHPietxUBz5V3Th3Vz/QRZqNI1wAQhT/p
 N7Y5vWc1n+Gqwsj3hgUNI1Id+qgHaM1C+qoqkWal6CLHReEQ93OoxJ2fzqotG/6HWBJ9
 2JBkZdbWBCWZl5i9e1VUpxafbC6ym16iTpib1jVeXm/R/lXrYli3kKJD/rEdn5to8EXt
 sncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794502618; x=1795107418;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B7Z8EmkExZ7lbGW2T4pH0RXgFzwbiI1ownej/XCibt0=;
 b=FVjpjcQGy+4X0pV6dBb4WS1H+WlCzcBWerFws3qCJMCqCH4iH97xStD2Iv7fO6TSwg
 VUuEvCjDzuwHnUB55TsbAb7o2l2QMmCQsSzL22k3/ncwbVqTjlPVcCU6kEo2oudpNpoR
 vQAKxLwHIUjg7h8tFGmDf8YFwhzPCE/N0nqqY7xsS1BTZt5n5EjrvVgxjnW4b2eAll6s
 LVEOmbqjzE7VP/LQ96kg3s2VMor+oypXgfg5kzY7qfPlhrxQml1D8dPVsNgdflQP4DjD
 X8I9MGcTtYjBfKY0QkeoAkPjXIkHvBv0+fIuywPL8NgnO7xkTfonjimx8lmFXcOwBXYs
 ZKjw==
X-Gm-Message-State: APuU4Z9jowdzrBGxlSh2ZvwI0hRX5fuNMSq7L5oT8XNGL5EIOmDw+Uz0
 hvHVRR8GXlYrzRZaplOfVgVaX4Dy3EpMV+xeOaoNuVCMfnN6jWGGKb7T05nJrdkXNSlJ3ENu9wa
 SSC1XtHPjZlfdjSb7QtvftbEgezjv40XRHHuVJCOePg==
X-Gm-Gg: AYBFou1f3SC/biTlr6vG/fwCTWlr+Hc0kcq/Ox3IWJCsoLF+l0NI59ulVCpU/lXh76w
 uu3YN3UYFYVhCaqNll0rq05UdGQL5bPKJ0msXOKr5JsstytIQUo16zGg3eZs98friGe4LJkPWLq
 4avfkFs4naJDpfjP1JqJnKounu80tGoMpgJ6OB1ACGGHF7KuJOvy46j9YGHPTGnGpgGrjCDkbT8
 nqNg0Y5N2I6f7Pr/KzFgoyq4RvsJUIwA3k0ouvZpkJaxj//VEPKgBspoLhL1P/9FZ9Obe2bHUmE
 P+zJOjtWW/XvGviNvhMAv1tg5t1/ycVjIu/Bbt7rMm04FnQFyzDoUBmiW0v+i5EHdl+eyWyI/r8
 jtKXiYTnlHSyjvWO2I3E8BAy2tge6mhoHLVHUcMRgLIILrY2bYRyI5bITb0d2vxMt1ULN+3Bk41
 Sks6TgcSe3H3QkrLKjqxVF
X-Received: by 2002:a05:690e:4847:b0:677:af43:e258 with SMTP id
 956f58d0204a3-67d8971f45bmr3748d50.117.1794502617787; Thu, 12 Nov 2026
 08:56:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112075407.602371-1-kevinren114514@163.com>
In-Reply-To: <20261112075407.602371-1-kevinren114514@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Nov 2026 16:56:45 +0000
X-Gm-Features: AclHuK-_D9VtxgY6OgSHKjd9Oh0s2oumBJOdHbyNd1xaAKJMvsnMSBneixHSI48
Message-ID: <CAFEAcA_P=vMgxMJ=pzKO05yvaTcDuiop-pUmPXRiei1mef=Xsw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt-acpi-build: test vms->acpi_dev before
 building HEST
To: Ren Yanyi <kevinren114514@163.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, shannon.zhaosl@gmail.com, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 07:54, Ren Yanyi <kevinren114514@163.com> wrote:
>
> virt_acpi_build() gates HEST table construction on:
>
>     acpi_ged_state = ACPI_GED(vms->acpi_dev);
>     ags = &acpi_ged_state->ghes_state;
>     if (ags) {
>
> ags is the address of the ghes_state member of AcpiGedState and can
> never be NULL, so the check always passes.  Whether the GED device
> exists is a separate condition (has_ged also depends on firmware
> being loaded and on ACPI being enabled), so a machine started with
> ras=on but without a GED device reaches this code with a NULL
> acpi_ged_state; ags then holds a bogus non-NULL pointer and
> acpi_build_hest() dereferences it.
>
> Test vms->acpi_dev, the device the block actually depends on, so the
> HEST table is only built when the GED device exists.
>
> Fixes: 2e9c5c5bc85a ("acpi/ghes: prepare to change the way HEST offsets are calculated")
> Signed-off-by: Ren Yanyi <kevinren114514@163.com>
> ---
>  hw/arm/virt-acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index d368913..45bdabd 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -1414,7 +1414,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>
>          acpi_ged_state = ACPI_GED(vms->acpi_dev);
>          ags = &acpi_ged_state->ghes_state;
> -        if (ags) {
> +        if (vms->acpi_dev) {

Now we're not trying to check anything to do with the local variables
we just set up, we can move this check up, so that we say
"if (vms->ras && vms->acpi_dev) {".

thanks
-- PMM

