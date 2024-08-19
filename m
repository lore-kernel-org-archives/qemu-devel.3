Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FE8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 03:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sftUN-0004k8-Ev; Sun, 18 Aug 2024 23:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sftUK-0004Xf-Kj
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 23:55:24 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sftUI-0001AU-UV
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 23:55:24 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-492a01bce97so1447357137.2
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 20:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724039722; x=1724644522; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjMwvLTThfFnh7u7hmE9l5eicqatzBuMTiSGiqfwubw=;
 b=f2peCLn+zicdqAuvbqo2haivoAk11M0QKlIYUNSapTND6Va21iqaGQeo/cveT4mxbT
 G4KICtJTFr4qq9QFIb2+JDvyy8sHJJtTQJbKcecu7uRrBnbhMiPma2uFYfWr0HAjv2sl
 AD8R1UhgfXZIYQ4wiUlaxQo2ks4v1HRisQNIDKIZga/pizL0lc7h3c+kFzu8gJqDUPtz
 WH0RuMxy+yllPsvjappKsNfyclgo1pdkXjJJT/pZChvBh4g5EVuB83GUmDTx0hlXq4Qf
 sE/6CirzXuHFNcFqWYjkMU/XFVxapJzF/2hrTsam8d+GZB4o5evjO3SYdfKMD5y7cMkL
 JEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724039722; x=1724644522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vjMwvLTThfFnh7u7hmE9l5eicqatzBuMTiSGiqfwubw=;
 b=jvLjqcxA+sx2tP9TA7PhzSbSpJohjpTfO6eyz6vcG4bvlIrBpO64U+JF0w3DT1Uz9v
 6jfw412z+etaUmNc05A0CKV2enteRSM7d2BI6aprX9cpgJPSk2dbwPRswd0DC3XcuJAO
 nQ+NQgxODXD7MfL9XBhasGRm2OZ3tLbxUlBeSieBH7zoNqJG5WBtigtbDxnuG0twaDds
 yMNNqKvslWPcRCO27md0s5l1aAuoMbIV9q97GEJYYlh/HD+taXz4eTXHWNC0efVNVymg
 +M6WtYwXZb2nFU+Q79C7jUKeJaQ8fFSDBBcXB68A7DGr750ZSLh3xcITDBZDWL3+mN/Q
 oFPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzRoEzt00T4LVNwm02Pz2JXM2BVl1W7wTKftKWrOMvzRQUooUvVxEVNSrrfB3uNpGHwNVnsQNjF3jJY0PjivK/iJklNJs=
X-Gm-Message-State: AOJu0YwDG4LUOUYhO+PI7c6ZbDMVAutRc976GzohdL99kqumzatFnml1
 KTutSZfSOVSqQGU7DzeaNQzoHN9bSIEn0u2UAd0sUQEDPJkPrI8AZWXgmeqEi0XcIPmEiD+SUuJ
 6bqR1CNV5SH0guPQx3yQ+byT/HZg=
X-Google-Smtp-Source: AGHT+IEsspQw5VsVkBNkdEYrImPbQR9+59zq/U3l9SUawIsASIQ2gXTCDsG7jUcwFZKu+DFoZ6ilWASM1lDQOvstCCQ=
X-Received: by 2002:a05:6102:41aa:b0:493:d41a:1185 with SMTP id
 ada2fe7eead31-497798dc938mr11731667137.17.1724039721780; Sun, 18 Aug 2024
 20:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
 <a667480203b35508038176c8ce4722370294cc57.1723172696.git.haibo1.xu@intel.com>
In-Reply-To: <a667480203b35508038176c8ce4722370294cc57.1723172696.git.haibo1.xu@intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2024 13:54:55 +1000
Message-ID: <CAKmqyKOAXuxRhqREczkVty=1gVmdAvXZ3uXMU1xjDw52GAx9RQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/acpi: Add expected ACPI SRAT AML file for RISC-V
To: Haibo Xu <haibo1.xu@intel.com>
Cc: sunilvl@ventanamicro.com, alistair.francis@wdc.com, xiaobo55x@gmail.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>

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

