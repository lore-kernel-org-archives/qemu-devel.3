Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18BCC3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 14:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM6pB-0005G9-CL; Tue, 25 Jun 2024 10:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM6p9-0005Db-HQ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM6p7-00022x-8W
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719324424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVFv9QKTSgwqt050oMupztT8tboU7QEqc1Nba0hesYo=;
 b=ZQDEogruVAlVtVRoW3p4vI153LZoI76kPHkzscFM+AR4hrC2ANkYR3MsS64LtfRR6fKGfc
 8XIbIIbQmZYh6IBHCZnK87oCoxsDQTvtrjv96uSQEpEtMEXhTcY7N3cba99FDvP2Y03Wgy
 1JD7+rtFOYp1mScgbLYoI3spDOjlIAw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-oL3evAYdMne3Q1fC5kqdcA-1; Tue, 25 Jun 2024 10:07:01 -0400
X-MC-Unique: oL3evAYdMne3Q1fC5kqdcA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ec61a87db0so18260821fa.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719324420; x=1719929220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVFv9QKTSgwqt050oMupztT8tboU7QEqc1Nba0hesYo=;
 b=S2E2XPU+TPheLz8VgbMkUW9BSKDyplLi0CtWYFjJihGERm/LpqfGDgc1KJ3c9dSqjX
 kd3QcRgk8OecS8xuna6m1J7mzqNvcauoAV4wFBAFvACWyK8rSop+pli/eQhPPqOxmEmn
 bmv6U/NLaQke8uYL5SC8NSaPaIvCYB8mLa263c+YFmDujiZTsxUELNoisKhUCAybZEcH
 BkaWaUjDNNFWr66WgVtYauQupR34Bv7x5N/pt/TEi2wcV1WQaMg0GWusjthbL3pzXpL/
 bVziErB9eBqn9UNTLNZX1zkuHsKaGrmPfTI9rehO97rgtcrklMcxOWjJAXLpmOOJ3c43
 1aRg==
X-Gm-Message-State: AOJu0Ywl07mv/8fjnhKr3uAsTcSOKdX6yDt1nWGpmbJb5j7zfCJV99Qu
 NPmdc2cUkOAphofp1lSmvcsLQx8JiWLoyvLaFUSczehuGmy+XuQrxS/QA1/zcCmDe/O1NHbfJdJ
 zP9nxDnTTao407K6VlCuAzTyyqEYyFQR9LrmUCA8oj9kwFI5sEBEt
X-Received: by 2002:ac2:43ce:0:b0:52c:da39:e40d with SMTP id
 2adb3069b0e04-52cdf7f1581mr5006378e87.26.1719324419963; 
 Tue, 25 Jun 2024 07:06:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlNTkoOwDsNk8YmtuD3Nvyd9g5FaRKUztDsceS0CShraNueXU/jK4k7VQBWVuwrdb1eTsbuA==
X-Received: by 2002:ac2:43ce:0:b0:52c:da39:e40d with SMTP id
 2adb3069b0e04-52cdf7f1581mr5006364e87.26.1719324419536; 
 Tue, 25 Jun 2024 07:06:59 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424a49d6112sm20251975e9.6.2024.06.25.07.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:06:59 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:06:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Alistair
 Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 14/15] tests/qtest/bios-tables-test.c: Enable basic
 testing for RISC-V
Message-ID: <20240625160658.6781a17d@imammedo.users.ipa.redhat.com>
In-Reply-To: <Znq4LZCLbpT5zXbA@sunil-laptop>
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
 <20240621115906.1049832-15-sunilvl@ventanamicro.com>
 <20240625131959.67c2fc74@imammedo.users.ipa.redhat.com>
 <20240625140558.168d1a9e@imammedo.users.ipa.redhat.com>
 <Znq4LZCLbpT5zXbA@sunil-laptop>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 25 Jun 2024 17:59:33 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> On Tue, Jun 25, 2024 at 02:05:58PM +0200, Igor Mammedov wrote:
> > On Tue, 25 Jun 2024 13:19:59 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> > > On Fri, 21 Jun 2024 17:29:05 +0530
> > > Sunil V L <sunilvl@ventanamicro.com> wrote:
> > >   
> > > > Add basic ACPI table test case for RISC-V.
> > > > 
> > > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>    
> > > 
> > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>  
> > 
> > I take ack back for now, since patch most likely to cause failures on weaker test host (CI infra)
> > 
> > test case never finishes and timeouts on my x86 host while consuming 100%,
> >   
> Hi Igor,
> 
> Many thanks for your kind review!. I think you are missing the patch [1]
> (which I mentioned in cover letter as well). This patch became a
> dependency since your suggestion to use -cdrom option needed this fix.
> 
> gitlab CI tests also passed for me with that patch included.
> 
> [1] - https://mail.gnu.org/archive/html/qemu-devel/2024-06/msg03683.html

ok, keep my RB but respin series with that patch included to make it complete.
(there is no harm if it gets merged 1st through another tree. but it makes 
life of reviewers/maintainers easier)

>  
> Thanks,
> Sunil
> 


