Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29F8C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7w7-0000RT-I7; Tue, 25 Jun 2024 11:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7w5-0000RG-24
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:18:21 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM7w1-0000OA-PH
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:18:20 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7178ba1c24bso2812021a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719328696; x=1719933496; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1eNQSJ1Cg3sKjP9f8CuJfSvHMNCcOvb284xbwUn5uzg=;
 b=Aws4o3IB/1D1dmcPBA1jlMbKSdY11MZCPqHrnucYCZUeF0Zel6PmqLB5Xuwirtwevt
 I+Bjqv6q8boKweXe363NrN33xFch1TFMAtim3dooUWYbNaTu4OrfldA61cdkeB8K0KR3
 FpppgB2Gf1mkB/QqPjqiaXrcBaUc3lGe4chQs4S2ZRImogJoEqtUoAxkqj/TX0FWDJEw
 PLx2S+v6GKfL08I34kzPqSyfmLTAwnqrcMr7gby64H79w/vzHIBb6ec1JJNEh4pVKbVF
 ICVGidog2+ZUL5KJhWEXC91Z94IBlOX+dZvh6vtVXpo0/1GOCxaipa/BBn3tpMO2G1g7
 fB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719328696; x=1719933496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eNQSJ1Cg3sKjP9f8CuJfSvHMNCcOvb284xbwUn5uzg=;
 b=fmtS61FSNb96HwNtKWvTumPXCJEjtB24lIrFAUsPQw5wK6SnNogCVjWp8+Xjv15eAh
 JO96HIkCQesNOjKz7hac47kVW0Z7Egq6XtQcD4wGIEBSDleSVXlR8Htn43zIUutJ10yw
 2PXTiW1r2xF0OqBfkpD+bKX/IL0NQZVbUo7GZ6duo6KUEKHPz9ULAT1fepxEBcHKryRY
 5XQWCI8HWzV8iajvd1Ep93gFzx/q0Sl12WIV7fQLQZcuOYIZJslvfFLUSsBL3T1HWgKo
 6qetMDx3AOGCt79Y0k4hjYyhu4bydPIWHW/jb+ecSwoUoyLsW9e/pg9byh2qXA5EGTSE
 aViQ==
X-Gm-Message-State: AOJu0Ywv35/a3hd0q6ejA4GrcG3qF+V/2t7vyudPCDoS2cdCU+vUrIgW
 eXFt/8kjQNKPsrdJooyC1SqrPL9xPFK/hdUkarrLeKUNgAcYV8BOa4lW3zyP+Ww=
X-Google-Smtp-Source: AGHT+IEpC1sCSPHyJPPrrf0VkqVEQwjaFBEsciWL3Lz4dSX8rBJfHw+J+epIsZlszoJ3kFNjtduE2g==
X-Received: by 2002:a05:6a20:4925:b0:1b2:be25:b5b0 with SMTP id
 adf61e73a8af0-1bcf7e7ee16mr8159745637.20.1719328696079; 
 Tue, 25 Jun 2024 08:18:16 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7068ca5a67esm3309744b3a.108.2024.06.25.08.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 08:18:15 -0700 (PDT)
Date: Tue, 25 Jun 2024 20:48:07 +0530
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
Subject: Re: [PATCH v3 14/15] tests/qtest/bios-tables-test.c: Enable basic
 testing for RISC-V
Message-ID: <Znrfr7SsKPE56CDP@sunil-laptop>
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
 <20240621115906.1049832-15-sunilvl@ventanamicro.com>
 <20240625131959.67c2fc74@imammedo.users.ipa.redhat.com>
 <20240625140558.168d1a9e@imammedo.users.ipa.redhat.com>
 <Znq4LZCLbpT5zXbA@sunil-laptop>
 <20240625160658.6781a17d@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625160658.6781a17d@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pg1-x535.google.com
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

On Tue, Jun 25, 2024 at 04:06:58PM +0200, Igor Mammedov wrote:
> On Tue, 25 Jun 2024 17:59:33 +0530
> Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> > On Tue, Jun 25, 2024 at 02:05:58PM +0200, Igor Mammedov wrote:
> > > On Tue, 25 Jun 2024 13:19:59 +0200
> > > Igor Mammedov <imammedo@redhat.com> wrote:
> > >   
> > > > On Fri, 21 Jun 2024 17:29:05 +0530
> > > > Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > >   
> > > > > Add basic ACPI table test case for RISC-V.
> > > > > 
> > > > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>    
> > > > 
> > > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>  
> > > 
> > > I take ack back for now, since patch most likely to cause failures on weaker test host (CI infra)
> > > 
> > > test case never finishes and timeouts on my x86 host while consuming 100%,
> > >   
> > Hi Igor,
> > 
> > Many thanks for your kind review!. I think you are missing the patch [1]
> > (which I mentioned in cover letter as well). This patch became a
> > dependency since your suggestion to use -cdrom option needed this fix.
> > 
> > gitlab CI tests also passed for me with that patch included.
> > 
> > [1] - https://mail.gnu.org/archive/html/qemu-devel/2024-06/msg03683.html
> 
> ok, keep my RB but respin series with that patch included to make it complete.
> (there is no harm if it gets merged 1st through another tree. but it makes 
> life of reviewers/maintainers easier)
> 
Fair enough. Sorry about that. I have sent v4 as per your recommendation.
It looks like the series has got sufficient reviews. May be it would be
better if it goes via Alistair's tree since the dependent patch is
already merged in his next branch but I will leave it to the
maintainers.

Thanks!
Sunil

