Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98112C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 15:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9bS-0006kt-3Z; Wed, 29 Jan 2025 10:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td9bO-0006jY-Tr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 10:03:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td9bN-0003ym-0j
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 10:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738163014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8F6UbpWhrTY3p6ggRWQvHPuy1L909m587AZHbSYcNM=;
 b=FISRbHO7GzliY87rHd56m2KPafTEjkm3igUu0t4peljRvJp5UCCJp3xd7EyIoiGqd6Izrl
 FZAYMXxiA9/v23jjlvWdUTbX7/5fOLoEgDhTvkNaVkXr92fSkvP+0fDkW5v1lQXiZtj/UP
 n7pMwFmmul/3qQVjwLACXoc51fmAJr0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-P6Gr5X5gOISvCy5q-ivsww-1; Wed, 29 Jan 2025 10:03:33 -0500
X-MC-Unique: P6Gr5X5gOISvCy5q-ivsww-1
X-Mimecast-MFC-AGG-ID: P6Gr5X5gOISvCy5q-ivsww
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38c24cd6823so485656f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 07:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738163012; x=1738767812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8F6UbpWhrTY3p6ggRWQvHPuy1L909m587AZHbSYcNM=;
 b=Wm24zouBPnb8IHzuD8f3gsN3A9nnkqgAFoEqYu5QrColf+/Gx67GZwG71NCU4TdgjG
 bOylQoXlhH4711fW6GE9QUDRV8FjlPkG8HDBXowPnf0qRobd7Aqmn2CEgAmWg8t3fO1j
 i9FN759uk5yY2ZhqW8+aecpb3cnXj6+FeX+OprDJy2Tk8xmPpKuLZpfbZ8ZSAwoULt09
 K/KsL2jrkAHWy0VnjLmdPEOPfzy5T9V4sWno2RsXRRtDjz3c6KzxboEMCKf0vhAPb7cP
 I2naQym4PghsTfGKLqoGt0ra6PPmOrR6XSxWNoTsl0brVrcc1eZhIR38Z4264YFH6CXp
 EccQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+iaoJ2yZ7BoU23MF6l/KEgcoY7OkJR3Ba5zH1LdlBshSGw7md8lPrmUb7zpuI1OjErOq5qx3GKM2n@nongnu.org
X-Gm-Message-State: AOJu0Yw0dOn1NFmnDjNBkmmOrf0iRpE+GXF5d0iNCyO4ACrsf2h3caaS
 A2OR9/IQX3ueiozchYgKOLPlEqiariFKtOzezYxSYkeMnyroNDHB7qqiQwceeRbD7AHdsX+W5k3
 4KhoUGOg0eWf/qCSd9IJ21b+htDonfBUGllkAzbwA11r9xHwrCku/
X-Gm-Gg: ASbGncs4TDd5BV9Qre23tgi3rWKqe1CSaJ/+n9Kzj59WYxeyYchuT9gOg7OgIF+bD7n
 VL4b+nBzWByb+QkAoCTSd9oCYFzK/LSKtAVtVDLFc9i5XxXWq++QTaJqVlyhNdwGoiMC5hx1m6b
 vLs0ZpQZjRlQiFpGGM6gixkYJ24RzOiOsuHWSCjSoSBL3QPPUfKjiSIpJgPwYB+pAObDVsmdc+G
 Z+G89OwGhrtFnaHOH+cXrcp8tiqd5pL5FpcJtkKCNiH75hCIcZMYYLQO3tZMddjtuAVxa88krIm
 9+xnUqQRJaaOfxo4y0GXuXdCicV747pcwd2H/WMNrv8bRg1c4XHP
X-Received: by 2002:a05:6000:2a5:b0:386:4332:cc99 with SMTP id
 ffacd0b85a97d-38c49a6335amr6485421f8f.17.1738163011632; 
 Wed, 29 Jan 2025 07:03:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7ZzJe84vfDLJX6W23LFIn5/IVGIm+TrLQGcCZzakkT/tzzgYkjahh1MPfMPn6O+qLJeDQ1A==
X-Received: by 2002:a05:6000:2a5:b0:386:4332:cc99 with SMTP id
 ffacd0b85a97d-38c49a6335amr6485337f8f.17.1738163010931; 
 Wed, 29 Jan 2025 07:03:30 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a18867esm17008159f8f.43.2025.01.29.07.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 07:03:30 -0800 (PST)
Date: Wed, 29 Jan 2025 16:03:28 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/13] tests/acpi: virt: allow acpi table changes for
 a new table: HEST
Message-ID: <20250129160328.2f66584c@imammedo.users.ipa.redhat.com>
In-Reply-To: <1390b46682f2bac3587239d03a0ba22d18a9a044.1738137123.git.mchehab+huawei@kernel.org>
References: <cover.1738137123.git.mchehab+huawei@kernel.org>
 <1390b46682f2bac3587239d03a0ba22d18a9a044.1738137123.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, 29 Jan 2025 09:04:08 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The DSDT table will also be affected by such change.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

move it right before the patch that would actually make changes to tables (10/13)


> ---
>  tests/data/acpi/aarch64/virt/HEST           | 0
>  tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
>  2 files changed, 2 insertions(+)
>  create mode 100644 tests/data/acpi/aarch64/virt/HEST
> 
> diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8bf4..46298e38e7b8 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,3 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/HEST",
> +"tests/data/acpi/aarch64/virt/DSDT",

the list in not complete so 'make check-qtest' still fails
[12/13] has complete list of changed files


