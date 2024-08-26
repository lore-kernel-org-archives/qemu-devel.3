Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76F8C5472D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 07:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siTvS-00035g-ID; Mon, 26 Aug 2024 03:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1siTvQ-00033P-Gg
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 03:14:04 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1siTvO-0004s2-Of
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 03:14:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42819654737so34131895e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 00:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724656441; x=1725261241; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qORsi9Nht/pObnlnY1pqrTC+d0QjjOs3FipKFGQYNWM=;
 b=AlZMagYhvyUsNZfNPy81+SsE1FPnbwR1Hl9YXPggdxhkyx1G4plp+wZcWaOtJdgv2y
 QaPl7KBKabart4wPGESHDIZB8WMO3i/q8C1nCdE8mq9tvrMEax/MTRDIxKAwXhaAPCOf
 6nCWXiY1aWo4s8LZ1Za0nrT40N7tl5rk5tNb3Dk6LMhipgkGdnWKUS05MxaSE2sooUUR
 9MIOusG4St6WPpxNzMERsjRf5HzOrYWQaNF6QzbItrAfexhaXT9P7WtYI3aMRcicjB2+
 8MI7c11GQVEuqHxX9MZemNJ9UGfaB9Ni3o+BpGrsVm08jzh/wg1ljzBNeO8uIKt0OMS1
 Rf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724656441; x=1725261241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qORsi9Nht/pObnlnY1pqrTC+d0QjjOs3FipKFGQYNWM=;
 b=t0GcIY2KY7PnmalcDTVXGS5IPJVWEYiJlLPwD7LrVlqvtiuJg4IhRIz0UrpfPyzIMu
 7Or4hZlix4hYhfCpPu3fpgGNWo12Qo3tB0zmmflxijSx5v/+23o1zgQ41a72NBWQBmtt
 gMS1apD8KKAOxaUfQ8XFNFY/XmZa8cwP7rQSrrRWHzQPTf0EX5qI70r09xwg60zJLLoi
 Q9FXzcX/GErS5voM/xzZsQd+uIcq2fow6Wlhza/PBxmxL5iD4pIwVnxxen7mQLz1ZzoL
 +BzZLdo41VD49WC+B8+oAZm8FsVGn/t1foe2Vr6PS505O62hJ+Lx5rAGHAIUX5bVVJDK
 jPFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaNMyzysJ2N6vWBbyXjiZkhGYZralIm1/NRkSClYyPi3yi+wFMFCb7+Dn39km+s38/7QdvEOd5NE3Q@nongnu.org
X-Gm-Message-State: AOJu0Yye3gfI0MqccorQVhW9Zay7tlNrYMYJpPcrV6+Fdn4aIMtTXbkY
 m6fEF2gb8EGNLcKhuwH1iZdSPLxLAJ2fv+BkwD/9Sz6dXhedcQFajYlcyES/aOPX4Ko1RqKfXx4
 ePII=
X-Google-Smtp-Source: AGHT+IFd13ExWH45lqvLabZOG173IJQpJY59+JvyssqddAtm7n5vCl1ojmbrWLXVM5B1aaYRzXSP5w==
X-Received: by 2002:a05:600c:4e94:b0:429:c771:f32f with SMTP id
 5b1f17b1804b1-42acd5e41d9mr48346415e9.36.1724656440438; 
 Mon, 26 Aug 2024 00:14:00 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abed8b6a8sm183192545e9.2.2024.08.26.00.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 00:14:00 -0700 (PDT)
Date: Mon, 26 Aug 2024 12:43:48 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH RESEND v4 0/3] Upgrade ACPI SPCR table to support SPCR
 table revision 4 format
Message-ID: <ZswrLDbIFpPpZDAW@sunil-laptop>
References: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
 <ZsicubCBw2YAjq9c@sunil-laptop>
 <NT0PR01MB1278D6E5A7CD617D9783C7259C8B2@NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NT0PR01MB1278D6E5A7CD617D9783C7259C8B2@NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-wm1-x335.google.com
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

Hi Jee Heng,

On Mon, Aug 26, 2024 at 07:04:11AM +0000, JeeHeng Sia wrote:
> 
> 
> > -----Original Message-----
> > From: Sunil V L <sunilvl@ventanamicro.com>
> > Sent: Friday, August 23, 2024 10:29 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org; qemu-riscv@nongnu.org; mst@redhat.com; imammedo@redhat.com;
> > anisinha@redhat.com; peter.maydell@linaro.org; shannon.zhaosl@gmail.com; palmer@dabbelt.com; alistair.francis@wdc.com;
> > bin.meng@windriver.com; liwei1518@gmail.com; dbarboza@ventanamicro.com; zhiwei_liu@linux.alibaba.com
> > Subject: Re: [PATCH RESEND v4 0/3] Upgrade ACPI SPCR table to support SPCR table revision 4 format
> > 
> > Hi Jee Heng,
> > On Fri, Aug 23, 2024 at 04:31:39AM -0700, Sia Jee Heng wrote:
> > > Update the SPCR table to accommodate the SPCR Table revision 4 [1].
> > > The SPCR table has been modified to adhere to the revision 4 format [2].
> > >
> > > Meanwhile, the virt SPCR golden reference file for RISC-V have been updated to
> > > accommodate the SPCR Table revision 4.
> > >
> > > [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
> > > [2]: https://github.com/acpica/acpica/pull/931
> > >
> > Just curious - whether this needs changes in linux side as well? Does
> > current linux code work fine with version 4 of SPCR table on RISC-V?
> The current Linux ACPI Table has not yet been updated to support SPCR v4.
> However, Linux RISC-V will be able to use the information in the QEMU's
> SPCR table to boot with behaviour similar to ARM. 
> > 
So, it means even if qemu risc-v SPCR is upgraded to version 4,
current linux continues to work. It may be just able to decode SPCR v2
fields only until enhanced to understand v4 but but doesn't break
anything or crash. Is that correct?

Just wanted to confirm qemu changes can get merged without any
dependency.

Thanks!
Sunil


