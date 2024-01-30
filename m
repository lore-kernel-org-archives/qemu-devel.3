Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B48C48285
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 12:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUnZc-0004xZ-KB; Tue, 30 Jan 2024 07:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rUnZZ-0004xB-Gh
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:50:41 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rUnZX-0005Lx-EW
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:50:41 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a26f73732c5so465781566b.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 04:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706619037; x=1707223837; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FErAMGRMo5n3bVgxQ4ZhDOcJETw4leepzAnCBEurNTU=;
 b=gH7Lt52H6Ryl1gKj5m/52nhBG/L3miSW0bHQvM//FEDH3nUCyRQfQAD+kjZOOI7BoJ
 1egP+RclC9bf0gssMB9eoYfTTigpyuDuOIL2LcpECPO4KRovLFEmtpBG3lXZLx08Tyc8
 y+2/vgj0nNK9kS5p+2SI/ZprwNeCHkuTOiEXXkXbh4nROTa8RIs4mH4CCFbWHOOZVATh
 Ge7rXGTSDJB4boALOUInENKEL7HzYsMyK1RHPqJfbNOlm76HBsrdpqmv/Cj21Xr4Co+9
 jda69Nx3SPPeeY0MB5oYuBwIOOnwElCEi+YNd5o096Jch0Pe11BtwdgKj9IE8SRYS+EE
 s25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706619037; x=1707223837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FErAMGRMo5n3bVgxQ4ZhDOcJETw4leepzAnCBEurNTU=;
 b=GaKAS5ZoCBoUkOJSUlpiubcDPBRipjzuXwhZgoQJhXuo2v2pBdqh4++dCgC2nLEr4y
 j/uIzTGVkByV3CqpoiZwyzUEKbqN7b0uMGSyODJgVMsy8IcxgQyhefHziNj3u8I5Yq3S
 G9P/lhLGmq1eE8kgFx/wlXYRbOMd8p9KuDewePMLk9/9WYUtwFCOhpe+Qj7Y1Lb6m55Z
 vA+7svjJTANRzZGNUMPUeOYXSYL4Dk1L351Cvu26M+yh6GgXUPj8srI6Rvgkd1NsP3lq
 s6HlEZaT7FXfRjbwA/q0C1cOABPhpdOCeVh96k68ocscy/6fccE/IqMYoHxQ9UllpaqF
 l9uQ==
X-Gm-Message-State: AOJu0YzjmPaQCWLBWjsrnD1mh2nt1N2uPWcO+C3r5LQpS8OYOrJq7WZm
 MwtC5cSIZwHUXaz3jTlyPyjFiFiXFm+cs4aOQRyUT4l68FQmQ+1Ff9byuE0I8wo=
X-Google-Smtp-Source: AGHT+IHprd1Zesz0HZSZLQhTWjiY6//T9U6Y9L8Sy0YEKD448UqmkEqiyPXlGz7Z3RWWWtEZCnIbEQ==
X-Received: by 2002:a17:906:4c56:b0:a35:9414:f46f with SMTP id
 d22-20020a1709064c5600b00a359414f46fmr4731786ejw.13.1706619037398; 
 Tue, 30 Jan 2024 04:50:37 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a1709061b1200b00a2e7d1b6042sm5047658ejg.196.2024.01.30.04.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 04:50:36 -0800 (PST)
Date: Tue, 30 Jan 2024 13:50:36 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>, 
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>, 
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: RE: [RESEND v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR
 creation to common location
Message-ID: <20240130-48cfb21fac247f0d535f87c9@orel>
References: <20240129021440.17640-1-jeeheng.sia@starfivetech.com>
 <20240129021440.17640-2-jeeheng.sia@starfivetech.com>
 <20240129-e51095f37656f4ba5262ec68@orel>
 <BJSPR01MB0561D2F722BBC446017856709C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BJSPR01MB0561D2F722BBC446017856709C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62f.google.com
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

On Tue, Jan 30, 2024 at 03:30:13AM +0000, JeeHeng Sia wrote:
...
> > Sharing code is good, but if we have to parametrize the entire table, then
> > we might as well keep Arm and RISCV separate. Building the table first
> > with this struct, just to have it built again with the build_append API,
> > doesn't make much sense to me. Do Arm and riscv really diverge on all
> > these parameters? If not, then just add the parameters which do diverge
> > build_scpr's arguments.
> It is kind of chicken and egg thing, I would suggest let the arch code to
> fill in the value. It doesn't make sense to change again in the future when
> both riscv and arm realized the parameters were different.
> Can arm confirm that these values wouldn't change in the future?
> > 

We can't be sure that arm nor riscv will change in the future, but we
(arm/riscv/etc. QEMU developers) control the code for both, so I don't see
a problem with only parametrizing what's necessary today and then
extending that, or completely separating, later if necessary. In any case,
I'd rather see the two completely separate from the start, than to see
the structure with all the parameters get added. There's no difference to
me when reading a list of 's->param_name = value' or a list of
build_append_int(table, value, size) /* param_name */. And, given we need
the later eventually anyway, then there's no reason for the former at all.

Thanks,
drew

