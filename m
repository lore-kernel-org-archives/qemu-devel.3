Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5814DC52D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 11:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdThv-00053E-V7; Mon, 12 Aug 2024 07:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdThu-0004yW-MF
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 07:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdTht-00014w-4K
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 07:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723463964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IcRpMkf8d+V3G73B4j7uXCdRLIvu4hkKMDZaqMcRk10=;
 b=L28D7MxHV/Vx78nTFr6R4+4kdh67WNyu07Q8TRCDZcnK4MFLyX13Bq5zsAKIVoB7eV2JsF
 GJpV3Y2Zh5Kx/zbamRxNlFw8WZeKCK+TugY1J5ptd8N1fRl/Mae/uY9CFUMn6Q+tn+2N9S
 phLdvD7aKMyHdpvnYc34ELk62Qc21tQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-a_U062dyOdi-1UZUFoW2AA-1; Mon, 12 Aug 2024 07:59:23 -0400
X-MC-Unique: a_U062dyOdi-1UZUFoW2AA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ef244cdd30so40792221fa.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 04:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723463961; x=1724068761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IcRpMkf8d+V3G73B4j7uXCdRLIvu4hkKMDZaqMcRk10=;
 b=gUF9/yOXHBXus/c7y0po/iw+vwtjajxguorwAW+e6UJJZtBYEA3GD1j+dXfj3V5Q7P
 yMj9xGnogTQoXgiLwMp9gFzzQh/iVgpmXaJFhPZfmHRUbjVixw5gRvvL3WKz64xJu9pF
 Tcs2TnILQkcawmWI3d0SVaCbrmv1ipqHuSzF28wdGnEsZ/YvkyM3T55PGwYUYQyxXLXL
 VgYmXtReAQd7o0ESbE3NE09fUYMXk4g+PjUGWctMh2BjALFDHxTmOEV/gk2dsrGjxuYv
 64uP6sT/36wZ+0bAgy7Q00SnyWLnl6lojFurGSzm2V8vNL3MTFQEIP/6fhUhhleL0u84
 bFTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqnUZnlrxEfgr8b0OroB34ut+GQEZ2C0uyn1jSiEt3VNpW3OXcVuK/F43g8ogxR1dnwJduoPy0gXBna0++SXMgwYq0/2Q=
X-Gm-Message-State: AOJu0YzBemWiT97la/GvWQQi9Lhg2H1SZBICOSQmUgZidwBuRj+rYnjZ
 i5mayLL7Y+oyXTRxgXpgTMHvv/9Q1dZQEozwSop4gpRr9RWLUerCNcelffmq9ZCn5BMuYkn5hCP
 GqrwG3Cl8Ah5F357FKtEmifqOI9NB34X9SqmIGP5pV2I305xN/pmT
X-Received: by 2002:a2e:b992:0:b0:2ee:7a3e:4721 with SMTP id
 38308e7fff4ca-2f1a6cf8bb1mr59401531fa.39.1723463961371; 
 Mon, 12 Aug 2024 04:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1gxZ0XOMvUedijgGYCSz6WeLKsQebFG3XNIdyhjrr6urez/nppwLw3pC3YYwsQSeii5ncVg==
X-Received: by 2002:a2e:b992:0:b0:2ee:7a3e:4721 with SMTP id
 38308e7fff4ca-2f1a6cf8bb1mr59401391fa.39.1723463960789; 
 Mon, 12 Aug 2024 04:59:20 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c775fc9csm98520995e9.47.2024.08.12.04.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 04:59:20 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:59:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 07/10] docs: acpi_hest_ghes: fix documentation for
 CPER size
Message-ID: <20240812135919.1b4865c6@imammedo.users.ipa.redhat.com>
In-Reply-To: <93ae03bd89b47731f6703dab5925ed2f7a9fd426.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
 <93ae03bd89b47731f6703dab5925ed2f7a9fd426.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu,  8 Aug 2024 14:26:33 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> While the spec defines a CPER size of 4KiB for each record,
> currently it is set to 1KiB. Fix the documentation and add
> a pointer to the macro name there, as this may help to keep
> it updated.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  docs/specs/acpi_hest_ghes.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
> index 68f1fbe0a4af..c3e9f8d9a702 100644
> --- a/docs/specs/acpi_hest_ghes.rst
> +++ b/docs/specs/acpi_hest_ghes.rst
> @@ -67,8 +67,10 @@ Design Details
>  (3) The address registers table contains N Error Block Address entries
>      and N Read Ack Register entries. The size for each entry is 8-byte.
>      The Error Status Data Block table contains N Error Status Data Block
> -    entries. The size for each entry is 4096(0x1000) bytes. The total size
> -    for the "etc/hardware_errors" fw_cfg blob is (N * 8 * 2 + N * 4096) bytes.
> +    entries. The size for each entry is defined at the source code as
> +    ACPI_GHES_MAX_RAW_DATA_LENGTH (currently 1024 bytes). The total size
> +    for the "etc/hardware_errors" fw_cfg blob is
> +    (N * 8 * 2 + N * ACPI_GHES_MAX_RAW_DATA_LENGTH) bytes.
>      N is the number of the kinds of hardware error sources.
>  
>  (4) QEMU generates the ACPI linker/loader script for the firmware. The


