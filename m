Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A54C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 18:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJzcF-0007gO-94; Wed, 19 Jun 2024 14:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sJzc4-0007ex-BR
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 14:00:53 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sJzc1-00019v-UZ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 14:00:51 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70633f0812dso111104b3a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718820048; x=1719424848; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=suWG7OInWA/FXp2HXBeEnprq+0zC+QBXlPUz212nYjY=;
 b=mBBLY7i7gzkODA20+zHZPxK9OhKn6LBWSen4Pv0rLlgTvlf11vG2lcVVJvYQzZDfLS
 T9QeZqKbeCbdg3NpPBve4PYEBxfFIw3M4azdXQTSEilx/ek4Rpt/4Zvw+S/30USDE6vm
 x+aVEr52DAu6PKHq3K3J6DISLGZxVuyAX+rC4BHpIOT3N1ZXdJXbKBAJXIYVMGV12Rcu
 R6A/vT1qTkYZ2pYzZch9tLzAyIskxEE2Gpl3WwYxjif+oYxIEiAWpBMO7zzdQgGxNIMJ
 uZmdYouJ9WMDlFvglQLxVNj275hfU8JfZI5h730JK5yVH18QfMm6iqHVz/ZIQr3/O9kZ
 hTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718820048; x=1719424848;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=suWG7OInWA/FXp2HXBeEnprq+0zC+QBXlPUz212nYjY=;
 b=P2KsK4GQsAwnLIGhizIn2/sydECUeGVD4uCK6aQ3AFn5CVQ1kPYBQvqkbp1ELRg2IQ
 Lnh0xezlguF+jABorhPj3tV1pnqYA7v6LVIcImyfkjWqY0eOpjDysyBclr2YpeIOakiV
 0NOzt+SzY9kwTpP5CmKolQweT/ROU2o23kvVUSn2DExI00I26GsYUToFBlDRCeWHEjcb
 cbeIJsYFAYqpJ0mEcbA8NfTpoqUHIj2xclpRnd02ktqtZOJ1AYpTXLhqKPIu8Uk+c07I
 4oLObzf8YmPu9JLy9K78SzXgjFtVMjD1wfiMM9u3+WI+Fe3RIEqjRhB749NJNLRMHgW0
 c9aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg5WVhsIq5tAwvWaheoNIOnKiC7gEzO0mSTwK21CRR5ejkXzgf6MeEb+8DrSlTxyd2PWky92E+6OQGj4wf1xKalJa7Sgs=
X-Gm-Message-State: AOJu0YwzXV9IqSsw2afAfmS8tegnXgQ+quTzAigT6BGaekzlAY34VnN+
 LRmYa0FmfSoeTEjBY7hAK3p9TIB24fyZ0fQ9Z96UYtxQF6YxsuJq3+fmFHwjlg4=
X-Google-Smtp-Source: AGHT+IHaFZ+UalIX4rTQwAS6VjeGqTC/jG9rqA9pISeIp9cCsbziGGKzpkY/aQa7qfLNEeTCus+bTg==
X-Received: by 2002:a05:6a20:3d8b:b0:1b6:a7c5:4fbe with SMTP id
 adf61e73a8af0-1bcbb3eed25mr4064219637.14.1718820047594; 
 Wed, 19 Jun 2024 11:00:47 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc91f6a4sm11380845b3a.13.2024.06.19.11.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 11:00:47 -0700 (PDT)
Date: Wed, 19 Jun 2024 23:30:35 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Haibo1 Xu <haibo1.xu@intel.com>, Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 06/12] tests/data/acpi/virt: Move ACPI tables under
 aarch64
Message-ID: <ZnMcw2E83Voo1HBT@sunil-laptop>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-7-sunilvl@ventanamicro.com>
 <27cef750-262a-402a-97fe-c4a55700a376@linaro.org>
 <ZlSjzfSj8MwDcJk6@sunil-laptop>
 <20240619111743.58930119@imammedo.users.ipa.redhat.com>
 <20240619052043-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619052043-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 19, 2024 at 05:20:50AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jun 19, 2024 at 11:17:43AM +0200, Igor Mammedov wrote:
> > On Mon, 27 May 2024 20:46:29 +0530
> > Sunil V L <sunilvl@ventanamicro.com> wrote:
> > 
> > > On Mon, May 27, 2024 at 12:12:10PM +0200, Philippe Mathieu-Daudé wrote:
> > > > Hi Sunil,
> > > > 
> > > > On 24/5/24 08:14, Sunil V L wrote:  
> > > > > Since virt is a common machine name across architectures like ARM64 and
> > > > > RISC-V, move existing ARM64 ACPI tables under aarch64 folder so that
> > > > > RISC-V tables can be added under riscv64 folder in future.
> > > > > 
> > > > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > ---
> > > > >   tests/data/acpi/virt/{ => aarch64}/APIC             | Bin  
> > > > 
> > > > The usual pattern is {target}/{machine}, so instead of:
> > > > 
> > > >   microvm/
> > > >   pc/
> > > >   q35/
> > > >   virt/aarch64/
> > > >   virt/riscv64/
> > > > 
> > > > (which is odd because q35 is the x86 'virt'), I'd rather see:
> > > > 
> > > >   x86/microvm/
> > > >   x86/pc/
> > > >   x86/q35/
> > > >   aarch64/virt/
> > > >   riscv64/virt/
> > > > 
> > > > Anyhow just my 2 cents, up to the ACPI maintainers :)
> > > >   
> > > Hi Phil,
> > > 
> > > Your suggestion does make sense to me. Let me wait for feedback from
> > > ARM/ACPI maintainers.
> > 
> > I'd prefer  {target}/{machine} hierarchy like Philippe suggests
> 
> Agreed.
> 
Thanks for the confirmation!. Let me send the updated version soon.

Moving pc/q35/microvm also under new x86 would need many changes in
bios-table-test.c. So, the question is, are you ok to combine x86
changes as well in this series or prefer to it later in separate series?

Thanks,
Sunil

