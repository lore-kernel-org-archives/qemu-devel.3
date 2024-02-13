Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6301C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 11:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqaj-00073i-Ty; Tue, 13 Feb 2024 06:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqah-000728-E2
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:04:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqaf-0006xg-JM
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707822281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7N91lAjYUSFlOt3VaYvlm2zqLY+7pJrej0nvLjkSvFA=;
 b=f7m0bVpXSRhR3fovcGMEhSkWJvOqaxk3svCN/OriqFucjLhzkIu1kMAjo9XJ8OexSvMsYs
 CUC3c5wV74cIGlEyflWGRJhmzVvPdFtxQ0XxdQFBxfVNEHj615wQ5KxOBJ43mI6Cs1zG+o
 RPvdRIaf/mIs/lcQSlf/u+2SAsDCLMA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-EEPUcMv_MaWGtpPBKnY0zg-1; Tue, 13 Feb 2024 06:04:39 -0500
X-MC-Unique: EEPUcMv_MaWGtpPBKnY0zg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2f71c83b7eso65760666b.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 03:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707822278; x=1708427078;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7N91lAjYUSFlOt3VaYvlm2zqLY+7pJrej0nvLjkSvFA=;
 b=nJ6hM4IX/dFjx4qWggvHVjH4ymMfcs1lEogcBKhqLCACOJl+HdftrN7/s+jzCa3eU/
 9207g9diqhsD8iYj6D1++Y63A9oSM4kawdVAkIsXfX2m024FeilCuDak17CJwIZp0aRw
 D8gB5arrRJdc2eREd1HWoDAekIgmQh3kP6dVXWiTYfbkyqD14Bxc7KbxRaRA0wZgBXdh
 J0kHPNEYvUtnQIjmvab2szP2x/MxYqzaB3cMZrHdksi8Zf7BUvQYb5ciwqk+1X7Gyn/y
 3dpCp1FFPEla1nM/mtueGmrJ+BPCFscOzgFWRLuu3FE8c6nMk12aXfNn71tVkUI7BYiA
 PFww==
X-Gm-Message-State: AOJu0YzyItlOPQz/qp57j73uSL3dF4sVLH+RfqExYWdMvTENp4u8ztIs
 /ZAJEoeeg4f4Xyp+ykY8ZS4GQtaelmk0jSDMDqqSpV7vF1v4UxrEOtEHe1yue9WsGc+TJMzvcCw
 tuWHiJ0VurpYReCwul9bbee8VaUAax2VEaZodcezc1SRepCDQs0riHqO3jeDb
X-Received: by 2002:a17:906:3e1a:b0:a3b:fbf8:94ca with SMTP id
 k26-20020a1709063e1a00b00a3bfbf894camr6202073eji.62.1707822278188; 
 Tue, 13 Feb 2024 03:04:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJY2qMWOKR53KItPR1Dt0mNipMQfTiUsey+qbw91T5L68rF7CgsGiby2/YcrwxaJemcDB2KA==
X-Received: by 2002:a17:906:3e1a:b0:a3b:fbf8:94ca with SMTP id
 k26-20020a1709063e1a00b00a3bfbf894camr6202055eji.62.1707822277843; 
 Tue, 13 Feb 2024 03:04:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWEY839uy/ih3ICWjt4iu9TPBPeOCERzXX8Wvr4nNAXHn6s/PyCEtqiV63f7L98N8TEZy+bqJ0w5h5tZG3IOz2Di7lGJawIujZjX/aGulCju4D+zJBe3y7Pdsl9j+1YIwjW5rNen42I8Cqs1/0+Gy7wLs0djZtmEfEz9n7LZgip4wIPlFPW13FJK3/GYeXlAQDm7/XBRaM585wOi/bLLMqERXoYlfLCCEE/drvxCbDOn0yfkRMjUlRMYON7cXFaeVHz3tg5TZVyByKliAxcQ0za
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 hb16-20020a170906b89000b00a3c20ceacf1sm1173049ejb.118.2024.02.13.03.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 03:04:37 -0800 (PST)
Date: Tue, 13 Feb 2024 06:04:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 0/9] hw/ide/ahci: Housekeeping
Message-ID: <20240213060343-mutt-send-email-mst@kernel.org>
References: <20240213081201.78951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213081201.78951-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
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

On Tue, Feb 13, 2024 at 09:11:51AM +0100, Philippe Mathieu-Daudé wrote:
> - Split 'ahci.h' as sysbus / pci
> - Inline ahci_get_num_ports()
> - Directly use AHCIState::ports instead of SysbusAHCIState::num_ports


PC part:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge with rest of patches.


> Philippe Mathieu-Daudé (9):
>   hw/i386/q35: Use DEVICE() cast macro with PCIDevice object
>   hw/ide/ahci: Expose AHCIPCIState structure
>   hw/ide/ahci: Rename AHCI PCI function as 'pdev'
>   hw/ide/ahci: Inline ahci_get_num_ports()
>   hw/ide/ahci: Pass AHCI context to ahci_ide_create_devs()
>   hw/ide/ahci: Convert AHCIState::ports to unsigned
>   hw/ide/ahci: Do not pass 'ports' argument to ahci_realize()
>   hw/ide/ahci: Remove SysbusAHCIState::num_ports field
>   hw/ide/ahci: Move SysBus definitions to 'ahci-sysbus.h'
> 
>  hw/ide/ahci_internal.h         | 10 +--------
>  include/hw/arm/allwinner-a10.h |  2 +-
>  include/hw/arm/allwinner-r40.h |  2 +-
>  include/hw/arm/xlnx-zynqmp.h   |  2 +-
>  include/hw/ide/ahci-pci.h      | 22 ++++++++++++++++++++
>  include/hw/ide/ahci-sysbus.h   | 35 +++++++++++++++++++++++++++++++
>  include/hw/ide/ahci.h          | 38 +++-------------------------------
>  hw/arm/highbank.c              |  2 +-
>  hw/arm/sbsa-ref.c              |  1 +
>  hw/i386/pc_q35.c               | 19 ++++++++++-------
>  hw/ide/ahci-allwinner.c        |  3 +--
>  hw/ide/ahci.c                  | 29 +++++++++-----------------
>  hw/ide/ich.c                   |  4 +++-
>  hw/mips/boston.c               | 14 +++++++------
>  14 files changed, 99 insertions(+), 84 deletions(-)
>  create mode 100644 include/hw/ide/ahci-pci.h
>  create mode 100644 include/hw/ide/ahci-sysbus.h
> 
> -- 
> 2.41.0


