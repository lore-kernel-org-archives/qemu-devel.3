Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30362C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM5J1-0007Y5-S1; Tue, 25 Jun 2024 08:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM5Iz-0007XA-No
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:29:49 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sM5Ix-0000Lb-Kc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:29:49 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5b9706c84e5so3026760eaf.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719318586; x=1719923386; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kOOOZrv8Wn5GwQsvG+CnPXkGyMtJ3HGlzcbEvGRFSfY=;
 b=EF8YJoV5iRR5rIL0PFOefVvy0TXeBNMVWzTY27JNTmeCjHWMMdYmZA3pScSjckiB1Z
 F8hof3vnjYOfb+vDvv/LezGFuw8oOdyNqUG9GVUjGICe03021TIsdBm5azNk+MmZg0qb
 +HMJ2GMZBZLyosH3I+iurwozHQxSbQfY2bMGZR28qvCB8wKoq1idnyS8RtN5G3EJKJ/O
 5x5gR6KyOPAW9ztTQLvDnMoGCW00SKjOQxHCJ626MR6pFwNtfIelCHSiebuOPg4977Er
 RwJnCgVzm/EwqTrETRWWcHiFiSqVp0Pn8eHRe8xtSy02nTExxSEN8nNi5tEeIwpAcQV4
 LZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719318586; x=1719923386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOOOZrv8Wn5GwQsvG+CnPXkGyMtJ3HGlzcbEvGRFSfY=;
 b=itRkMk8aG7yXh9nqjamdhEAxt7RZndYRoCBvClLNj1DELW/4zAtOMPHin8jQzo5z8v
 GxYzC4ukDP7AonzfivaHKH5RZxgBejHDU5Un2qIFvDE6/9CoFQxXV5XFnu+LXMx6eEc3
 brPAzuUkT01lRFR7hEIk5Ut/JN+B05Q0N9aWN/swMb0zoojL1RJKql20Su/5KV5CQWPw
 uw1ay5XTDTxcnFGo9Uc1+YyXZ3ddi94WQYPDiIbzCluso6674KofWyQmjq4cNIkEUO+d
 7Du2EJ3lCzGraDkNsLP54Se4xw9wMHkplPkZuonfVssqWrM+O3sA8x15OvTn6Ua95+F4
 NS3w==
X-Gm-Message-State: AOJu0YzPW7C/tBrvYLOAhJqpp/wz4gzLyVWNsBRQlZ+U+bFLQ/lt0wwu
 q42QBCmttC2A3XvQH7etwNVtICJXrjaFQs+Eyi72i7bjWQ5YHdPJ+3wlvtrvr3s=
X-Google-Smtp-Source: AGHT+IEffkaoJ3dtBGUW4mGMJrkhLs/uVEndm5N+1WuaGFTeOLzUZsKdOFdvUQluokdI4fVP6lnV9w==
X-Received: by 2002:a4a:3515:0:b0:5bb:218e:3436 with SMTP id
 006d021491bc7-5c1eb9de604mr8329919eaf.1.1719318585804; 
 Tue, 25 Jun 2024 05:29:45 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c1d58ff7e1sm1755337eaf.39.2024.06.25.05.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 05:29:45 -0700 (PDT)
Date: Tue, 25 Jun 2024 17:59:33 +0530
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
Message-ID: <Znq4LZCLbpT5zXbA@sunil-laptop>
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
 <20240621115906.1049832-15-sunilvl@ventanamicro.com>
 <20240625131959.67c2fc74@imammedo.users.ipa.redhat.com>
 <20240625140558.168d1a9e@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625140558.168d1a9e@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oo1-xc2b.google.com
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

On Tue, Jun 25, 2024 at 02:05:58PM +0200, Igor Mammedov wrote:
> On Tue, 25 Jun 2024 13:19:59 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Fri, 21 Jun 2024 17:29:05 +0530
> > Sunil V L <sunilvl@ventanamicro.com> wrote:
> > 
> > > Add basic ACPI table test case for RISC-V.
> > > 
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>  
> > 
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> I take ack back for now, since patch most likely to cause failures on weaker test host (CI infra)
> 
> test case never finishes and timeouts on my x86 host while consuming 100%,
> 
Hi Igor,

Many thanks for your kind review!. I think you are missing the patch [1]
(which I mentioned in cover letter as well). This patch became a
dependency since your suggestion to use -cdrom option needed this fix.

gitlab CI tests also passed for me with that patch included.

[1] - https://mail.gnu.org/archive/html/qemu-devel/2024-06/msg03683.html
 
Thanks,
Sunil

