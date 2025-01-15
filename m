Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E867C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 14:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY45V-0000MC-0y; Wed, 15 Jan 2025 09:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tY45M-0000Kl-CO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:09:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tY45K-0002Lv-BS
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 09:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736950168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ke609aWK2vFg3JmHGilestAfWBKgGdOp7VW0p6BaeHQ=;
 b=gZyUB7+V5y2BwkMQxU2if4zwj4BnnStrjr7SUohI1fcVhUvKM0VgmWdwRXWVN2c8e17zqq
 bWIb6+HMLIyEq6F3e4yDRNYMScBTsaW5xZvTI4bOBJBcRsPqyJlcucDbHQ2o2JlSNG9Qg3
 oxKlByipe8JXiNfspdCmhy+e2S2UqWo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-hTABSVO9OeKoRYQPn_F1gg-1; Wed, 15 Jan 2025 09:09:27 -0500
X-MC-Unique: hTABSVO9OeKoRYQPn_F1gg-1
X-Mimecast-MFC-AGG-ID: hTABSVO9OeKoRYQPn_F1gg
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa63b02c69cso96597966b.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 06:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736950165; x=1737554965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ke609aWK2vFg3JmHGilestAfWBKgGdOp7VW0p6BaeHQ=;
 b=g7rFyIFeglaQsv01SvPJllSvSIIPDKnKZl/As6Y6poiOMXY/5GkWWlXWKSaRZHuNYT
 U7xuVC5Xs80UaaYisYhlTEcr8j2GH9u2F9asef7hJxajg9NUhsoAI0wGj3LCMl3f7498
 4VVLXQrPV07f9u2+WRD7dAkaQMYVc4j9lr5r4hF2Fj9rxs2CrCAtwVeRumvlKhtmG0Zb
 /mzL9x5Lbcoe4HZ9vXVPClRl4bVlWrzgQnsWlZU9wipabuh0CUTdvEOd4ldLNOxp/HWt
 7rrO2dyIUZzL2ywc8lMrtbydzb36MUXSsMIDtIJsxiLOEJT9qjV/GuukMJ7Z+Mgxd2st
 92wA==
X-Gm-Message-State: AOJu0YzdHBPhy+Qls5SbnpOFMa88lrAj2kOd7kx4XpbXNaBj2pW4xbae
 Nz3wjzrr6ekm9lDPaJrw/xs9eISZl7M+7FNysTuOOwNDTV8Xe3dhbXXTkk7r+dsSi5Gv/WZmpPy
 85cOn15M3xpU3B+9koxR5ZR7gTEQJ0wqGt5iP3FCBG1iDF0XszVIlVj74QDmpoIurVsFPcngYle
 m9kesUIfIwj/V2VXSFNCLAe0LNBQD6ZAZl/o8=
X-Gm-Gg: ASbGncvNkVIignH2+gjjcwYaVZ+pq7bdFxb5BlgrtCnhmnp2M/m4in3BM7Sv2GKRUGh
 S6Z0W9wm7wH2EcgstCqDwZHfRA2oqE+nvgWMsxHxx
X-Received: by 2002:a17:907:1b05:b0:aab:a02c:764e with SMTP id
 a640c23a62f3a-ab2c3c7a0c6mr2421076466b.14.1736950165570; 
 Wed, 15 Jan 2025 06:09:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrg9tg2ZWhKCQxZLiW2IXXbWPx7VDHsdtZ2gfz8Fd1QxxdC0iQFrtU4Hd4+PAZRQo4Tt9JL9Q9wpXzCj/E1z4=
X-Received: by 2002:a17:907:1b05:b0:aab:a02c:764e with SMTP id
 a640c23a62f3a-ab2c3c7a0c6mr2421070866b.14.1736950165035; Wed, 15 Jan 2025
 06:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20250115125342.3883374-1-imammedo@redhat.com>
 <20250115125342.3883374-2-imammedo@redhat.com>
In-Reply-To: <20250115125342.3883374-2-imammedo@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Wed, 15 Jan 2025 19:39:14 +0530
X-Gm-Features: AbW1kvYLiTgrta6pslgdebOyVPghUUWLtURMr22qccBYgNtlYA4MsJUl8LouJ4c
Message-ID: <CAK3XEhPROPEoMfym93-Oc7xLkRFrs_4u7FW=e8uzUUPAd9-37Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] tests: acpi: whitelist expected blobs
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

On Wed, Jan 15, 2025 at 6:23=E2=80=AFPM Igor Mammedov <imammedo@redhat.com>=
 wrote:
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: Ani Sinha <anisinha@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 40 +++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..085dfa9ff4 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,41 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/x86/pc/DSDT",
> +"tests/data/acpi/x86/pc/DSDT.acpierst",
> +"tests/data/acpi/x86/pc/DSDT.acpihmat",
> +"tests/data/acpi/x86/pc/DSDT.bridge",
> +"tests/data/acpi/x86/pc/DSDT.cphp",
> +"tests/data/acpi/x86/pc/DSDT.dimmpxm",
> +"tests/data/acpi/x86/pc/DSDT.hpbridge",
> +"tests/data/acpi/x86/pc/DSDT.ipmikcs",
> +"tests/data/acpi/x86/pc/DSDT.memhp",
> +"tests/data/acpi/x86/pc/DSDT.nohpet",
> +"tests/data/acpi/x86/pc/DSDT.numamem",
> +"tests/data/acpi/x86/pc/DSDT.roothp",
> +"tests/data/acpi/x86/q35/DSDT",
> +"tests/data/acpi/x86/q35/DSDT.acpierst",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
> +"tests/data/acpi/x86/q35/DSDT.applesmc",
> +"tests/data/acpi/x86/q35/DSDT.bridge",
> +"tests/data/acpi/x86/q35/DSDT.core-count",
> +"tests/data/acpi/x86/q35/DSDT.core-count2",
> +"tests/data/acpi/x86/q35/DSDT.cphp",
> +"tests/data/acpi/x86/q35/DSDT.cxl",
> +"tests/data/acpi/x86/q35/DSDT.dimmpxm",
> +"tests/data/acpi/x86/q35/DSDT.ipmibt",
> +"tests/data/acpi/x86/q35/DSDT.ipmismbus",
> +"tests/data/acpi/x86/q35/DSDT.ivrs",
> +"tests/data/acpi/x86/q35/DSDT.memhp",
> +"tests/data/acpi/x86/q35/DSDT.mmio64",
> +"tests/data/acpi/x86/q35/DSDT.multi-bridge",
> +"tests/data/acpi/x86/q35/DSDT.nohpet",
> +"tests/data/acpi/x86/q35/DSDT.numamem",
> +"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
> +"tests/data/acpi/x86/q35/DSDT.thread-count",
> +"tests/data/acpi/x86/q35/DSDT.thread-count2",
> +"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
> +"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
> +"tests/data/acpi/x86/q35/DSDT.type4-count",
> +"tests/data/acpi/x86/q35/DSDT.viot",
> +"tests/data/acpi/x86/q35/DSDT.xapic",
> --
> 2.43.0
>


