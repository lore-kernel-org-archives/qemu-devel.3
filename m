Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54C7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 03:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sftPk-0006QA-GX; Sun, 18 Aug 2024 23:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sftPi-0006Iv-8E
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 23:50:38 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sftPg-0000Xb-MC
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 23:50:38 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-494556dfa3aso1124522137.0
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 20:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724039435; x=1724644235; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SicM7UTIsAj/YUdtIhCThfbjAL812jzP/t75/asEoWo=;
 b=OOX/C/GaHrE+W+gl8KdWstmJMCGlvtqHVJHLv3Mtiuz/xzHDA8mtgfbLXlQm5+pXx3
 MUR0zM0GT5OuJde9dJRTrgCzIorztsFWPMqkzSevVykxJp7Dik/j86OkO1n7YSIHChcS
 OBKy1pP5rJmL8zI9KEYMLE8evbne3BKJTRiMBpsUutmNwDIrjv2TiARj6eUerL8GRay7
 6k2SMlKckpOq11HmlulyU7WeA1EuDJWudz+k2WEDQV7otuxuB0eJrsTiTUf45esXvgu4
 7inhjVQpPlyh1fwLkohi8H9W4RhRQv1IvQI9lsuKLFTl5XxAnf2xThRPMhJ735ynlWE9
 idRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724039435; x=1724644235;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SicM7UTIsAj/YUdtIhCThfbjAL812jzP/t75/asEoWo=;
 b=LkRJkERS9u3MgD7QyMFYODpD00xvpya8YkWAOdK3uPQozoES16vNODAtH7UMyswWpz
 zoTMtaRYjCHTPoJ6nvqaYmp6Pve1jWrhhCEuf1MIA/BTtdUR9aPXwYJPumbxWA+furZZ
 rR5wMNHR0MahpDBcg8lWjtaX4OObXAHzuVK85NFPvsOuGox+wXkxu/wsdpCFCDYWVJsD
 I5a4fBPcqF6xPHargFFVb3xjqLMGl0QMVfdcc+zQ36wL7dn9p+uYhLTBiq7FTOW2zTKU
 GOt0Qbo9fC6/Hrpj4UOr99UKh0ftC1di1OrlLoOg2O4eKo8ZnK520dRjqB3FfBNyWZaC
 3I9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4DMWLaucz2o0H6/Y87AqXGQjhttXvz4HkQ99lr+kf69SUXXS0aQxnhWxbmEdgVJSZ8hHNq4rZNHZS9D9MpMRRInK+cYA=
X-Gm-Message-State: AOJu0Yx96pnwJOrMVpO0rGupN4Beo+dXV6uB3+Xpkws8OdOmKrY1AhEy
 VnXcWrJVNbl+SxkC+tvFyDPJ3k4HY484dcnBbpqQGBxL2jH6GNKlQoCVQYbxfXOuuI4vbGlO7jj
 I0F3zCkKjmtj893hKntnxLM4N0l4=
X-Google-Smtp-Source: AGHT+IEzxJPy4pg0QuHilephczqxdC42FEwXG/fHfGq8jyq75CWFI+ioWdbDYOet3b3JnRp7GU6ji9t36LY2DTYE3vE=
X-Received: by 2002:a05:6102:1626:b0:497:70db:ffc5 with SMTP id
 ada2fe7eead31-49779930599mr7486021137.8.1724039435499; Sun, 18 Aug 2024
 20:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
In-Reply-To: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2024 13:50:09 +1000
Message-ID: <CAKmqyKNnUWL4MgvfzUgkZaxuA63A9rAv85b_DNrE8OBTcAhd5w@mail.gmail.com>
Subject: Re: [PATCH 1/3] tests/acpi: Add empty ACPI SRAT data file for RISC-V
To: Haibo Xu <haibo1.xu@intel.com>
Cc: sunilvl@ventanamicro.com, alistair.francis@wdc.com, xiaobo55x@gmail.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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
> As per process documented (steps 1-3) in bios-tables-test.c, add
> empty AML data file for RISC-V ACPI SRAT table and add the entry
> in bios-tables-test-allowed-diff.h.
>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/data/acpi/riscv64/virt/SRAT.numamem   | 0
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  2 files changed, 1 insertion(+)
>  create mode 100644 tests/data/acpi/riscv64/virt/SRAT.numamem
>
> diff --git a/tests/data/acpi/riscv64/virt/SRAT.numamem b/tests/data/acpi/=
riscv64/virt/SRAT.numamem
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..a3e01d2eb7 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/riscv64/virt/SRAT.numamem",
> --
> 2.34.1
>
>

