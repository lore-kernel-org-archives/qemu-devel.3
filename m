Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AA8C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 20:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhxRI-0005TF-QZ; Wed, 06 Mar 2024 15:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhxRH-0005Sr-Ab
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:00:31 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhxRF-00066A-Vh
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:00:31 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dc0d11d1b7so1073495ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 12:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709755228; x=1710360028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uE/+d8za9FOme6hIEIVOXrHDo/Jr6T++1vzl/Rw5YTs=;
 b=a3UNQ2371erCuSTED/m74bEKu40OEwahwMeVbMoodTsueKzonESP1srAPA5zamCVJi
 /GG+Xyugvyik0fC3hWTJPeRDALvDtp8N9Ml6SvCnTSTlIazOi3c/VPW6LFTQ422ZerQc
 KfgWsXZxjGCTpuLNpOLlMgwCSwTYcv5Vb6es7/zfC7nYca5/5Gh68NqB6W7WS26+CRNy
 icFsR6By88fVA6dgA+63cIzrVyTPQ58zAkNVvnjh+1Da3deFlimTVvDcO1gsVn8ttCYi
 41JV03mc+NEeE1f826R+5466efH+cOBXbYVimaOww5bhFqMJj6goIujBPS+YARiQ3pnx
 DLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709755228; x=1710360028;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uE/+d8za9FOme6hIEIVOXrHDo/Jr6T++1vzl/Rw5YTs=;
 b=SrzKLr44dwp/OQhfyW6WnqD4nQfmvtT6ggOF9zzvE+oIxWtQy2sPofoFDHNuL3Fo8j
 Zbl8kbqMJF/C9kg1sp/2B2DXi0r5X4AmwAccvoqLTuUKuvPMeNJi4Jzsj8bRP1+DNoBn
 KYL24cbeZd0t6l+9/KCUZqOMxEaV7wxarbKkveGn9jvIDwXY4r6nu4hsbc63B1m8iYkA
 tUmgdjdWnxIFgWTKQK5ylO5nEGBv+uUn0SjuCTlRpnjOX/Lfd7lwWZemjedSbvdEL7Ry
 0aP5s0hhbwyVlGRExGQqjga05fCiWFY1szRiKELji6RR+KvbIppHjwZ0XM1cLqAVPnJB
 6pdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX10rEYRcFb1SHcJsjAmxH208OcCn5ILJs8d5PYrik594usuI2l+tIXlj0OaSX70kQ44Mv4SUDpRVqMuKTjMbKjXsfmHb8=
X-Gm-Message-State: AOJu0YwTnKgNeKX9ZKtwbix0KOsnWv/ZvwApAOCrxUU8Lhw9oQOKOj4b
 NI2osoC2aeSJTRZNg/PyPk/JIBn3V4FKnY/CxPLznn/M1EDaVm3l9kKZMQuW/gY=
X-Google-Smtp-Source: AGHT+IF/7kV2NMp4Pu35I12HiLF09XWdrflhcKgqEX6cVvv1FuNEc3D9caY+iJxdd0C3K085MZqa2w==
X-Received: by 2002:a17:902:f682:b0:1dc:afd1:9c37 with SMTP id
 l2-20020a170902f68200b001dcafd19c37mr6684943plg.24.1709755228142; 
 Wed, 06 Mar 2024 12:00:28 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a170902b08600b001dc30f13e6asm12953234plr.137.2024.03.06.12.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 12:00:27 -0800 (PST)
Message-ID: <3d377b25-bbab-4401-b5e7-98f6efa81ca7@ventanamicro.com>
Date: Wed, 6 Mar 2024 17:00:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation to
 common location
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 sunilvl@ventanamicro.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
References: <20240116010930.43433-1-jeeheng.sia@starfivetech.com>
 <20240116010930.43433-2-jeeheng.sia@starfivetech.com>
 <49d0d8d3-c7fd-4039-aeed-6c31ba16557a@ventanamicro.com>
In-Reply-To: <49d0d8d3-c7fd-4039-aeed-6c31ba16557a@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 3/6/24 15:57, Daniel Henrique Barboza wrote:
> As a side note, it seems like 'bios-table-test' isn't being run for RISC-V. Not sure if this
> is intentional or a foresight.

s/foresight/hindsight

There's no 'make check' for what we want to say in the ML but hopefully there's
a way to enable 'bios-table-test' for RISC-V :D


Daniel




