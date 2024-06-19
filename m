Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FC6C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 09:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJrVE-0000TV-Nv; Wed, 19 Jun 2024 05:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJrV5-0000Qi-3D
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJrV1-0004Zd-73
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718788862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Suhj2379smWVBTU/BGDAtu/5KXCfWIK/YZcDffkBmEA=;
 b=N7Y02uT9Ims+Wl8PEanUnD8TrFd1nhzqVAgmUx240bUYBlYXzEAGO5HzMcGVoJZMnCv8q9
 DIswsLKmuezjDrnNoyqLZGkHVLAdbJWBGZdnD0GM8M7ZVSemDYnBSYLI7pW7/9Ed0++TsF
 Ce399zxPvT9xWV9cnnBi0Z4AK4qrjjI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-h0gXb7-jNm2J2hvJ_zDyIQ-1; Wed, 19 Jun 2024 05:21:00 -0400
X-MC-Unique: h0gXb7-jNm2J2hvJ_zDyIQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35f271c5b17so2884914f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 02:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718788859; x=1719393659;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Suhj2379smWVBTU/BGDAtu/5KXCfWIK/YZcDffkBmEA=;
 b=lRuYqJxG11pJHzmI3OveleJ7dxjOvg2n/24lvdYaQkE8BwJ2VCzeJGrQhlnxrS9s1N
 zCjGSCDWSZh7uVuNixZ+CztIQZd5XiEJgj7X9JIHHqjEQZwkplIMAGmM6zXhmR0VMN9l
 10VCIGoLvUwwZyIGLgTbWB1Fb73sCKX3jbvWbwZwb5dd+6CZ+W+z5sHEdafTr4JMIBRO
 pCRZ60Fj1BSmKzE3Pi7nZrOLSmJC64qKrvdewwJYPY8WB3rJIYg+LC3AX8tgCxgXFv7E
 drvtZOEFjlYsdHBIbWY4Qa34MjLNwdwZa1tIIw5yq99XYk52ZIEfSjF+V0dJYkKcyJTJ
 DQBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb3FTaVK8ZCQkMs70220AiuYjlEd8/8SswdrCpsmmVPPFjdAA1laibp66CPW1mbsxVJBHJYPIZyOhNeNxlRytNzdmtgvc=
X-Gm-Message-State: AOJu0YzVTJKBvYmQwcKycOL49eVRIEu+zt6sdv6aU4DnyBQO+DdnvTRf
 srMy8lFPlLdRLX3iT+qloLWZmd0vNYEUi/LO1cxEETzBP+0dH4uGEBI/vgVBbknC+CYdYDePI9c
 Tv5bFtf9AfWqrELYcRyX6KR2itMv6FyKt2rnJeMM+uG/xGj6N0jRR
X-Received: by 2002:adf:a415:0:b0:362:3730:8762 with SMTP id
 ffacd0b85a97d-363177a200emr1358770f8f.24.1718788859498; 
 Wed, 19 Jun 2024 02:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH/3FsI5bKIrpUuTgwaPZ6k8ig5H9goYiLkUbZcoEGcgZcpMmje6ttxCzTp//cg5zUqKTIfA==
X-Received: by 2002:adf:a415:0:b0:362:3730:8762 with SMTP id
 ffacd0b85a97d-363177a200emr1358723f8f.24.1718788858852; 
 Wed, 19 Jun 2024 02:20:58 -0700 (PDT)
Received: from redhat.com ([2.52.146.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-362f03ac73dsm2504997f8f.55.2024.06.19.02.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 02:20:58 -0700 (PDT)
Date: Wed, 19 Jun 2024 05:20:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
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
Message-ID: <20240619052043-mutt-send-email-mst@kernel.org>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-7-sunilvl@ventanamicro.com>
 <27cef750-262a-402a-97fe-c4a55700a376@linaro.org>
 <ZlSjzfSj8MwDcJk6@sunil-laptop>
 <20240619111743.58930119@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619111743.58930119@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 19, 2024 at 11:17:43AM +0200, Igor Mammedov wrote:
> On Mon, 27 May 2024 20:46:29 +0530
> Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> > On Mon, May 27, 2024 at 12:12:10PM +0200, Philippe Mathieu-Daudé wrote:
> > > Hi Sunil,
> > > 
> > > On 24/5/24 08:14, Sunil V L wrote:  
> > > > Since virt is a common machine name across architectures like ARM64 and
> > > > RISC-V, move existing ARM64 ACPI tables under aarch64 folder so that
> > > > RISC-V tables can be added under riscv64 folder in future.
> > > > 
> > > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > > ---
> > > >   tests/data/acpi/virt/{ => aarch64}/APIC             | Bin  
> > > 
> > > The usual pattern is {target}/{machine}, so instead of:
> > > 
> > >   microvm/
> > >   pc/
> > >   q35/
> > >   virt/aarch64/
> > >   virt/riscv64/
> > > 
> > > (which is odd because q35 is the x86 'virt'), I'd rather see:
> > > 
> > >   x86/microvm/
> > >   x86/pc/
> > >   x86/q35/
> > >   aarch64/virt/
> > >   riscv64/virt/
> > > 
> > > Anyhow just my 2 cents, up to the ACPI maintainers :)
> > >   
> > Hi Phil,
> > 
> > Your suggestion does make sense to me. Let me wait for feedback from
> > ARM/ACPI maintainers.
> 
> I'd prefer  {target}/{machine} hierarchy like Philippe suggests

Agreed.

> > Thanks,
> > Sunil
> > 


