Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D6DC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 04:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfuMa-0001nD-7S; Mon, 19 Aug 2024 00:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sfuMX-0001m1-M7
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:51:25 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sfuMS-00087J-Ne
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:51:25 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-84303532b90so1041201241.3
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 21:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724043079; x=1724647879; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9HFBvsFZbAN9kvq2egRoBgL7Sg0ju2JdUSF1IJTVGs=;
 b=KGa6kb/TszrpqikjQGrQB+QnsZs+2xU7UdUMuiUVQz+Tpab8vICpfjDNMDVx7QTrHb
 zBIBzdqwlusQLyDfrlwCf7W0g1+iA9+CY1bAvKEkvNM+JIp0jEuUzAnZbqi+k/bfMOiy
 NLZoOvzWs5vtIjF5GCh4AEq98zM5Rvs9p/Kos8unFdGZnp5wKnyg/19BfoMV8Kx6gpls
 +fGpSsrmWlO7IdPCZ5fWGNgTC7hi8wEClgiWGjjer73HPOBFgkKw3kGjO1OxjEpyOcUE
 C+YmrWnxjCfuP95U8WVWmnH0ep2MKoqy7azHZKwDFAz6uyFd321yqNAoySjeCR3/nAPT
 XmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724043079; x=1724647879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9HFBvsFZbAN9kvq2egRoBgL7Sg0ju2JdUSF1IJTVGs=;
 b=ih530m3kD8tmZTkMUgeeBFrfdFKTR7U7vUTEMNaPtMR38rN16U0Eay8xB4pF8IvqBn
 Dn2mB08zYPvGBKgLIpP89a+u9nvo/aAtYKtKBaIYaEjtYezhaVeFDYULDzdv+zKGDLTU
 0bdtiGvWQU6mn4UwchAuEcbPVRKxlUEdck11Hu3ty8jFq9WjZdsRXotlzwmPsuUkf36C
 +xEvXRz+YG8YXOZsr882xjgTrByE/kswr5xF4r2lCCw5aNnzuXRJacjul/JuV3N9g6P5
 hxyG3waJUi0C4lPIoCj+7ekmz4Y2n/OdUG81oYJSMyH4ZEoBopzKLYmv7711tJ5OSOdW
 P8yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFbSdBJWdODFAUTYsYntN4+fv1E71nytab9PdEpkvz72VtLNh8PVNlsg2yEbwBI21Tgk3Wx7Fpn25fsUe6s6hZ6FYuZWo=
X-Gm-Message-State: AOJu0Yy/BHNEMf1ubwQboxJZAppkXpq4yFDGT9rx+sOFElpxKvKgaqV4
 WKH6LRu3YYfrqASFb/UuwDTI7VFejECOWc9q+PkJj9oGDPDkopZXdEInH3fymX3iv6u1znZcwCI
 Yy6C5uDo7qUDw1sxS5VaIbPsXmNU=
X-Google-Smtp-Source: AGHT+IHYwlGbtggWaAfibu5cPtHnYKkDxe/Li7rYxHrrmAV6Hht8F9LZGqFQt/DfjWJZxZFQtUN5yBF9ULnqD6f7mRA=
X-Received: by 2002:a05:6102:3e94:b0:492:a5a9:a74 with SMTP id
 ada2fe7eead31-497799b55b9mr13844840137.22.1724043079482; Sun, 18 Aug 2024
 21:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
 <a667480203b35508038176c8ce4722370294cc57.1723172696.git.haibo1.xu@intel.com>
In-Reply-To: <a667480203b35508038176c8ce4722370294cc57.1723172696.git.haibo1.xu@intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2024 14:50:53 +1000
Message-ID: <CAKmqyKNeOVdmeFN4s9yvzHaCiXPLSqrKt=u7CO1NUs9AVro3sw@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/acpi: Add expected ACPI SRAT AML file for RISC-V
To: Haibo Xu <haibo1.xu@intel.com>
Cc: sunilvl@ventanamicro.com, alistair.francis@wdc.com, xiaobo55x@gmail.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 9, 2024 at 12:50=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wrot=
e:
>
> As per the step 5 in the process documented in bios-tables-test.c,
> generate the expected ACPI SRAT AML data file for RISC-V using the
> rebuild-expected-aml.sh script and update the
> bios-tables-test-allowed-diff.h.
>
> This is a new file being added for the first time. Hence, iASL diff
> output is not added.
>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  tests/data/acpi/riscv64/virt/SRAT.numamem   | Bin 0 -> 108 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
>
> diff --git a/tests/data/acpi/riscv64/virt/SRAT.numamem b/tests/data/acpi/=
riscv64/virt/SRAT.numamem
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..2b6467364b7673c366c9abf94=
8142eaf60c9311f 100644
> GIT binary patch
> literal 108
> zcmWFzatz5~U|?XDb@F%i2v%^42yj*a0!E-1hz+7a7zWryU@U|<qXt~80m|Zli6H9*
> E0AFAS0RR91
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index a3e01d2eb7..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/riscv64/virt/SRAT.numamem",
> --
> 2.34.1
>
>

