Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DCBC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 11:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSZeo-0003vz-KH; Fri, 20 Jun 2025 07:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSZen-0003tp-10
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSZel-0005Wb-Jn
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750417898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IIQfgc0Qf4BikpcAmB9hT/f87Ts1KJhpaM1f5a4GqnU=;
 b=CHcxLK+MrVuExkNhZ+wS/yuv1DQ6mKdjIVNuiyyWMASCpJSTRRfmKC7jlzxuNLfbyYuoUX
 NMnXQ25NLfEL0la5yoWLVtCbXjSQ1QU1TtnuySK1qMkx/aXgrrknKR1jdeE2BBuJFEX5mj
 MwG9zvnLJ++7VwrHK2dJWQS2C83eEQE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-SNFo9f21PCC_2euSXVKhrA-1; Fri, 20 Jun 2025 07:11:36 -0400
X-MC-Unique: SNFo9f21PCC_2euSXVKhrA-1
X-Mimecast-MFC-AGG-ID: SNFo9f21PCC_2euSXVKhrA_1750417896
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450d6768d4dso12070835e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 04:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750417896; x=1751022696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IIQfgc0Qf4BikpcAmB9hT/f87Ts1KJhpaM1f5a4GqnU=;
 b=vGfp+lEMud1l8zplosONk16uK83V5WewRUNI0W2eclMvqFuleenAPtpbbodsRf8kOJ
 hIGlgJAO1+Cr5puK73y/hosGlsAsybl8Q/u9NvIjybyPDYniuZe9HkWVdl6PJ1E/MZPl
 ZbsV6g4DVqzcyhXqSqgQqQpf0I/EwnARZcil8nb9QrxMdJpptz/laXpZnIZIn7+wu5B4
 GeFKbhQZLYxZJ4ED/FBoYXi5+fnBysge1mesU1EICFSDNbfY3rxovdZzSU5+KBkgF8mq
 oXD+tpL0/7S1CLxML3pjgxFk9ynX7IcnQcTi4h6vR+D6byDdjbBVgmBbBZWIyGbcZPsu
 2o9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlOyLy/U1e9wNh+ZqS8kG1QE78A/uWKvfZJc4DdcZG06yGsF3IqE5cv/kZlq7lKso6oRozcUANjDJZ@nongnu.org
X-Gm-Message-State: AOJu0Yw2fAycB4HC+7zH2FurNbJnwuitDFZePC78qIufOXKMyTs40lSR
 PKe4HHRkTIbd7Z0R0tZHzrP5o0QqRb8IbQKVNw6mAZKiHx3qVbroxu2Wixp17IqCd82CrU2JD/G
 jz0rKke4G7haov6mEx3pzaX1Q5nX7iBN34aUJbsNm4FkBblY+kV1KHn/L
X-Gm-Gg: ASbGncvD5jnf706rGEW9WI9h3/T7w+q7frp8Z22bShva/gSwpfMhrUJtX67Aq6Gkmb4
 55cemKpP8EnBNTFbYr1r5ce+/rsIpQtzyRxUOE186gHd2zPgFmFCcGov8KQ+74atn/HY5apHICU
 uxCegZD7W781C7Z5Cb2jl8uzJ8HTVfM1IEozK/WmSBwR2nt/UY0+FhmKGZC+oW6/Fa3jdT/zyaP
 5kQYjPAzk87DJnyO5DCXYM5tlQb889yGwMDRVK/vp0+TAty8o3J5RD2fglp3SmJg3+eTyWWmNyS
 G2cmw2coJtVJ
X-Received: by 2002:a05:600c:4443:b0:450:d012:df85 with SMTP id
 5b1f17b1804b1-453659ec19emr22278545e9.18.1750417895655; 
 Fri, 20 Jun 2025 04:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSlFNBxaSUyX3GfHVQVw+JBcAN3z3MPYqn0FoiUwvdL9kr3/eidLghkoVDg89L3cJL0VwGOg==
X-Received: by 2002:a05:600c:4443:b0:450:d012:df85 with SMTP id
 5b1f17b1804b1-453659ec19emr22278165e9.18.1750417895213; 
 Fri, 20 Jun 2025 04:11:35 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646cb692sm22246935e9.2.2025.06.20.04.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 04:11:34 -0700 (PDT)
Date: Fri, 20 Jun 2025 13:11:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 05/29] tests/qtest/bios-tables-test: Prepare for
 changes in the DSDT table
Message-ID: <20250620131133.55afcb5b@fedora>
In-Reply-To: <20250616094903.885753-6-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-6-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 16 Jun 2025 11:46:34 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> This commit adds DSDT blobs to the whilelist in the prospect to
> allow changes in the GPEX _OSC method.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> 
> v2 -> v3:
> - fox for microvm
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..75f057767e 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,7 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/DSDT",
> +"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
> +"tests/data/acpi/aarch64/virt/DSDT.memhp",
> +"tests/data/acpi/aarch64/virt/DSDT.pxb",
> +"tests/data/acpi/aarch64/virt/DSDT.topology",
> +"tests/data/acpi/x86/microvm/DSDT.pcie",


