Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB83EC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 12:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tncb9-0007yj-8E; Thu, 27 Feb 2025 07:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tncb6-0007xu-Rc
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tncb5-0002IX-C2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740657754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DRugfuFghPEgI0qvuOa5TFgOLvAsHNbtLdSfrep5L8M=;
 b=MW0+GmDzusyc0HSM7z9UcBwcR3X7ohQnuw64HU2pFDKiZrp58WRMZrjmviB1BU0iljyuZu
 LBG88Q63AHjEKR0lyQUioeuFr6DjkgsYcFyf2kvLf1nw+t69n/zslanAfXk8x3MKvZwWUP
 y9oxnjt2RR6ZUMLG6SkiSFUVnQ/I1xo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282--iRLYh65OzqcPsFyrNhRUw-1; Thu, 27 Feb 2025 07:02:32 -0500
X-MC-Unique: -iRLYh65OzqcPsFyrNhRUw-1
X-Mimecast-MFC-AGG-ID: -iRLYh65OzqcPsFyrNhRUw_1740657751
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so6808065e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 04:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740657751; x=1741262551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRugfuFghPEgI0qvuOa5TFgOLvAsHNbtLdSfrep5L8M=;
 b=XIIbNQ0GGhl4fPBUZEcD7M2aOeLubyoUfgS5InGfcG6MVTKxqXlG/xMicJ6OlJX7RL
 3so9zqvyb+uS7GrALjszqn2C+Y99w4G14JLofukgiLPEyj7qHUteD6Ra//TTBT41aHaa
 Tu/S7e/PtxxyIe1W2y3tN/NQgx55eGvrVfsoN4fpYorp/Ul4NL7OpUrHDcuwGs/u77VL
 EPv+6f4Wo2dM1LjCab2Tknbv/M4TRsJFKHGrf7ZC3ZU48DYFNvv2q8a/CUAYU8M/G2ry
 u8GzcMUNAAEQ0qISJCfEy+BV7Pum6rDu7kgV3LG/RSQoCmeWnS+s//KHAdfNRzK6M95s
 Unyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfgxL2crUHO8JQeXiSHOioEpnE70epKwqZfG6P2LafPw4+f4pJwHy/UtsQc8FdC0dsj/OpU9KHE3PF@nongnu.org
X-Gm-Message-State: AOJu0Yx0pmndNwixU+238IFlgs68MFuYJh1jgO7s5OHSPBQlJVJkonBk
 c6qgEhDyu8Jlpu+Vyg5N+G5WFtexooHL4p6bgdwXMTKdrx7Uj/0G6nuoCZ6Kc97I3KqSoHR1E+8
 ubgdlvlyAg75xhE1FEvjrzh9puQskG9tVMJhyE4A0M+i11a2xfgmV
X-Gm-Gg: ASbGncuJRaxiBq81Y1x5BtG4g65MgQbVQ+pV3sjW+gU3LQZ5dV6xTXAQp9ca0Sh4nB1
 +BtT/mTH4Vw0cYXgBRV0HZdvgE3JNCdGEbe1+5NT2FWERk3gIo9iBO0MllfLVokKffO5g+aCant
 yx5hUevHQWkkHZmM9eWk6VGA81Mvflwp8JhFCh6flW/4Jw19eMnjlBLKfYXBcORbVYEo10+W5Kn
 ANxvoDr4djjrYdD7yeedQB+Aja1WgTlA8LKM3wohvfUfgk7SGPsjBdFlTkurDibDDduHnLlhVEL
 e8mLxAFtTXhLm2bhsoHFtiIX51daTghUa0s09O6bkdi83kX3sQdQzl+XtB//YYY=
X-Received: by 2002:a05:600c:3b13:b0:439:8bc3:a697 with SMTP id
 5b1f17b1804b1-43ab8fd1f46mr63821705e9.4.1740657750924; 
 Thu, 27 Feb 2025 04:02:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVj831tgv3cAm8RnxFYJohIJajXsS4joOm+ny7cS7e39sJEvV3VKtNW1GtmtP6yTlAOfg1JA==
X-Received: by 2002:a05:600c:3b13:b0:439:8bc3:a697 with SMTP id
 5b1f17b1804b1-43ab8fd1f46mr63821235e9.4.1740657750568; 
 Thu, 27 Feb 2025 04:02:30 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b7a27b1c6sm21022525e9.27.2025.02.27.04.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:02:29 -0800 (PST)
Date: Thu, 27 Feb 2025 13:02:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/21] tests/acpi: virt: add an empty HEST file
Message-ID: <20250227130229.2a0251f0@imammedo.users.ipa.redhat.com>
In-Reply-To: <3da2d197610ada25dacaee54d113fb87c5448b04.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
 <3da2d197610ada25dacaee54d113fb87c5448b04.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, 27 Feb 2025 12:03:31 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Such file will be used to track HEST table changes.
> 
> For now, disallow HEST table check until we update it to the
> current data.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/data/acpi/aarch64/virt/HEST           | 0
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  2 files changed, 1 insertion(+)
>  create mode 100644 tests/data/acpi/aarch64/virt/HEST
> 
> diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8bf4..39901c58d647 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/HEST",


