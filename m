Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83918E64A83
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIRW8-00061j-OP; Tue, 03 Dec 2024 06:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIRW1-00060y-Q4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:56:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIRW0-0003CI-7m
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733226987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+O57SI+41dnb6fLcPWqR/WRjF0vrSeymdRk0UogJ2tY=;
 b=OTlO9k+eUW2HipfJ+Xkr0UaygxebxfsllW8nm0W1iW0PZ8B0obdmyTSZ6HTHgigiAKo04L
 zB5FidkJkeT9BPod7jWhbS2tC3is2t17qQQqhAeuvbc1vJASOBrxvj24ZO2KBgfxbPw5/6
 +DVPxL2nKrFeBr6SlWl+4NbDIK716sM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-dgahyPKeNMit3H3Ffmo5DQ-1; Tue, 03 Dec 2024 06:56:26 -0500
X-MC-Unique: dgahyPKeNMit3H3Ffmo5DQ-1
X-Mimecast-MFC-AGG-ID: dgahyPKeNMit3H3Ffmo5DQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385ed79291eso1323733f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733226985; x=1733831785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+O57SI+41dnb6fLcPWqR/WRjF0vrSeymdRk0UogJ2tY=;
 b=qtXkAUa5j76vqjOyWgh9wYXJq/cyXraBSWAYZgSY3CWLPNxnKLGgj7Gla+gECb0PNz
 1S/ajpqFiB71vHIN5STV6Zl4QFUvqhpI5vy3VmWAjMd3MptjqfDXi0bj4ffFlJfWxvYz
 w+XfUKRhVpFmctQ9tHfm16NTy2UnGmN8uZH+F6xrWHDXJsT85OeNAIT2kPZbRzyq+Myc
 3W6ul5q6FAifw8fG/u73H7mXaXf699352DRqSaQ8OXjybSHK5MgjQujN9O8rQjmHHXb6
 q1f8fUlGeLj6zKbJR7e/RhNT2WRfSHapeiZok/QQlWAZ0hPbTaSpXF4f5ClmEmz8XZa0
 rhEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLcmDDDsvWpjqw4HsJTa1SXqEVp/HJfZKWOjmuOVl+yP69hjIWEGQLFgSqS1RsgZqe6vgQXGrXJ3UT@nongnu.org
X-Gm-Message-State: AOJu0Yz0irXXrowNaDO+MJNlZh1hHf7DIbbGE9RxOLeBNd+zH1UjrwRV
 kS10Vw2Xq9BHVhKAi4ssGwbJY6v3KaOKe8EW8QmJfgDE0xAz9XXkItZ4/8eehsKHBYJ+/SC8RwF
 olAQFiCErdGI9ebS62DQBt14CaQfijGehdfM0ynS5a5s6NVpF+EC1
X-Gm-Gg: ASbGncuER0/OqfaRpt7emifEYWwSG8lV0OFMIbAhrfg6Vmm6u6ev2x9/ChuFNoGZ3Ro
 UWKjZQpjKoWz99TwX0D3/JL9JSc3NPYw3scj7oRd0Tu1ANmuEp1B9QZy3elwglCOPzTjzynFsKr
 pMwGt+XnvB7L1hJoE/oCgk3AFse4iVl2Lm1NYx7CEeIuNhNUDUt++c/IgDqKmBJGkjtzyRPGZk7
 egXdRLc88+7OJ3mOlRQXkOnLcQC0K8pm/N+tNfMx55jJH/JyHil4l8PEBiXA02KuoPwmAzyw4fr
 svh81tgE75ACzeg77kUXhw==
X-Received: by 2002:a05:600c:5593:b0:434:a33d:ba44 with SMTP id
 5b1f17b1804b1-434afc44167mr193433625e9.15.1733226984778; 
 Tue, 03 Dec 2024 03:56:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgDggl5MAwTUpW3kCdC3q1u7zjc9Y2cOyItvruE8+s588/kDJ2UNEYXraijxQzZaWdRgVSsA==
X-Received: by 2002:a05:600c:5593:b0:434:a33d:ba44 with SMTP id
 5b1f17b1804b1-434afc44167mr193433395e9.15.1733226984491; 
 Tue, 03 Dec 2024 03:56:24 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dc6352sm186849345e9.21.2024.12.03.03.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 03:56:24 -0800 (PST)
Date: Tue, 3 Dec 2024 12:56:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 15/15] docs: acpi_hest_ghes: fix documentation for
 CPER size
Message-ID: <20241203125623.3b47103e@imammedo.users.ipa.redhat.com>
In-Reply-To: <3bfe6c991d187f48b9c34500be106296b9480059.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
 <3bfe6c991d187f48b9c34500be106296b9480059.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 22 Nov 2024 10:11:32 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> While the spec defines a CPER size of 4KiB for each record,
> currently it is set to 1KiB. Fix the documentation and add
> a pointer to the macro name there, as this may help to keep
> it updated.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

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


