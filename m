Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A88C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 08:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOYxa-00042t-3i; Tue, 02 Jul 2024 04:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sOYxP-0003ql-B5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:33:49 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sOYxM-0002kI-7f
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:33:47 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-701eea2095eso2303980a34.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 01:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719909221; x=1720514021; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ASyEBjhs6aIZg6Pc8HSkZVb23wpDbzWBIrIdGg+Sm5E=;
 b=NB7WZUEkEsMLbLWjraeN87Ox4fuMIMWW9dMOyeWjI9CbqX2dWDWq5dfjRbKdqhUVsn
 Hcg5gygHmRV/3163z1fyFFk7KpQC3r67sQgDdAoM+aSta4owib7KP1B7e9TBqvEtL8Kf
 O8oXYwOr4p5xvewdBiabPWNsmwZ6meq/5Mhl0dAzNbnls6X5q6ZX+ga7aqUNXR1+lTLj
 PXI3D3bKfUendjo5J0wg9BtjgKd1KT/ukWpuJX3mf6rdmJs//Kq1swRMihGy3zdLfw64
 h5tk87RSWT41kRvXXszL7hIAipq78aBnGzKRuRK+id0i+Tjo8wjWGB8sx3p2XRpB5keg
 tqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719909221; x=1720514021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ASyEBjhs6aIZg6Pc8HSkZVb23wpDbzWBIrIdGg+Sm5E=;
 b=LzVc7qjJCmIyAPKMaRdJ5cMhpsqGTptk6aXzTbXIP+LFlDegkCAjATIBYmOHNKm+1M
 CL56J52xelq6BC8fXUOXWenCHMDYyCeOGiseEQifzXWh4U+9eZSrtnTE/jNhKrpi/FQ5
 tn0G2y1RXj49zjmE2voOhLadgKTe1tlufguHhSkK5gB0xtjmVWWV85OT01BoiDAM7jMo
 KpZCaBpM6pb5rlKOjA66wOweW4POPOlLxbjEzPFcNME9QRjv64boinluKjOG4qqSWL/g
 cKyaSnHon7fnPeSHW+vxBpw+6FjIV8j/Lm4eU+Y9XV9E2/wsRY4rGp6ii4SfDfOSv7p7
 +oLw==
X-Gm-Message-State: AOJu0YyB3Y2j0tyrjXT7vYzuMI8+ckBYnSaPHSLK35ZNiniM9ovdxnfK
 CxW3pWZNBjcahVkcfLCi6NHaD5X2trovSNv1h9ZnOEBAxL0ADsS/zQRM7/+NpkKZ/CG3urqhaHz
 A
X-Google-Smtp-Source: AGHT+IFqQvPkbkxA0MYRtG03MDm2EWYvDmM+Pzt6YQjJP1FkNKy05cW5PetKlQjKT7nyqcpJzXyk8Q==
X-Received: by 2002:a05:6870:23aa:b0:25b:3e23:e5ec with SMTP id
 586e51a60fabf-25db33ed8f4mr6410494fac.20.1719909221571; 
 Tue, 02 Jul 2024 01:33:41 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d8e37ee64sm2117889fac.47.2024.07.02.01.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 01:33:41 -0700 (PDT)
Date: Tue, 2 Jul 2024 14:03:29 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 06/16] tests/qtest/bios-tables-test.c: Add support for
 arch in path
Message-ID: <ZoO7Wb9OqPxIW04P@sunil-laptop>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
 <20240625150839.1358279-7-sunilvl@ventanamicro.com>
 <20240702103002.69a8678d@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702103002.69a8678d@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 02, 2024 at 10:30:02AM +0200, Igor Mammedov wrote:
> On Tue, 25 Jun 2024 20:38:29 +0530
> Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> > Since machine name can be common for multiple architectures (ex: virt),
> > add "arch" in the path to search for expected AML files. Since the AML
> > files are still under old path, add support for searching with and
> > without arch in the path.
> 
> we probably should remove fallback path lookup after series is merged.
> it' fine to do it as a follow up patch.
> 
Agreed. Let me send a follow up patch.

Thanks,
Sunil

