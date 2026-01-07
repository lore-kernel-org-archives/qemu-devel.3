Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765EFCF6C1D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 09:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdQ9H-0002Rw-Bc; Wed, 07 Jan 2026 04:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vdQ8z-0002Qz-L7; Wed, 07 Jan 2026 04:47:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vdQ8u-0005dE-9t; Wed, 07 Jan 2026 04:47:54 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dmNW05jMHzHnGk2;
 Wed,  7 Jan 2026 17:47:40 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id AFE4740086;
 Wed,  7 Jan 2026 17:47:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 7 Jan
 2026 09:47:45 +0000
Date: Wed, 7 Jan 2026 09:47:44 +0000
To: Alano Song <alanosong@163.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <cminyard@mvista.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>, <ani@anisinha.ca>,
 <pbonzini@redhat.com>, <shannon.zhaosl@gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/virt: Add DesignWare I2C controller
Message-ID: <20260107094744.00005e57@huawei.com>
In-Reply-To: <619b5c6f.5d81.19b9747e84d.Coremail.alanosong@163.com>
References: <20260106131253.16192-1-AlanoSong@163.com>
 <20260106131253.16192-3-AlanoSong@163.com>
 <20260106154522.000046a6@huawei.com>
 <619b5c6f.5d81.19b9747e84d.Coremail.alanosong@163.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 7 Jan 2026 15:07:10 +0800 (CST)
"Alano Song" <alanosong@163.com> wrote:

> At 2026-01-06 23:45:22, "Jonathan Cameron via" <qemu-devel@nongnu.org> wrote:
> >On Tue,  6 Jan 2026 21:12:53 +0800
> >AlanoSong@163.com wrote:
> >  
> >> From: Alano Song <AlanoSong@163.com>
> >> 
> >> Add DesignWare I2C controller onto virt board,
> >> and also an at24c eeprom for r/w operation.
> >> 
> >> Add these two devices into arm virt acpi table.
> >> 
> >> Confirmed with i2c-tools under v6.18 linux driver.
> >>   
> >Hi Alano,
> >  
> >> Signed-off-by: Alano Song <AlanoSong@163.com>  
> >
> >Perhaps a silly question but why do you want this on arm/virt?
> >
> >I've been carrying a backed up version of the aspeed i2c but for
> >that we are using it with MCTP (I'm guessing this one isn't capable
> >enough) and devices on that are inherently discoverable unlike
> >normal I2C devices.  Even so I don't plan to upstream that as for
> >the CXL fabric stuff I can use MCTP over USB instead and don't
> >need to change arm/virt at all.
> >  
> 
> 
> Cause we are emulating our soc chip on qemu, and our first choice of
> machine board is arm/virt.
Are you planning to ultimately upstream support for emulating your SoC?
If you do, is a new emulated board perhaps appropriate?

> But we unfortunately found there is no DesignWare I2C model and no
> I2C device in arm/virt.
> 
> Someone else may encounter this problem as well, so I decide to solve it.

It's definitely good to have emulation of this fairly common IP.

> 
> 
> >I'm not sure how useful an eeprom is beyond verifying your control emulation,
> >but perhaps that's all that is intended?
> >  
> 
> >  
> 
> 
> Yes you are right, single I2C controller cannot be verified, so I
> add an eeprom to work with it.

Within arm virt one concern is that this unconditionally enabled
so attacks on emulation code are a real possibility (in VM usecases)

> 
> 
> >> ---

> >> +static void acpi_dsdt_add_i2c(Aml *scope, const MemMapEntry *i2c_memmap,
> >> +                               uint32_t i2c_irq)
> >> +{
> >> +    Aml *i2c_dev, *eprm_dev, *crs;
> >> +
> >> +    i2c_dev = aml_device("I2C0");
> >> +    aml_append(i2c_dev, aml_name_decl("_HID", aml_string("INT3433")));  
> >
> >That seems to be a valid intel PNP ID, but please add a reference to where it
> >came from (I'll guess the kernel driver rather than some document?)  
> 
> >  
> 
> 
> Yes, you are right, this PNP ID comes from kernel
> driver(i2c-designware-platdrv.c/dw_i2c_acpi_match)
> it's just for testing convenience under linux kernel.

If you are ultimately emulating a real SoC I'd suggest using
an ID issued by they vendor of the board or the SoC.  They will need
to have a suitable ACPI or PNP ID though (and so be a member of
UEFI.org)  That will allow for any quirks in the kernel driver
(and you'd need to emulate them as well).  Who knows what slight
differences there might be with the Intel version of the IP.



> 
> 
> >> +    aml_append(eprm_dev, aml_name_decl("_UID", aml_int(0)));
> >> +
> >> +    crs = aml_resource_template();
> >> +    aml_append(crs, aml_i2c_serial_bus_device(0x50, "^"));  
> >
> >This is the bit that made me ask for a blob in the patch description.
> >I have very little idea what that actually does in AML :( (the "^"
> >in particular)  
> 
> >  
> 
> 
> Here, "^" represents the father device of eeprom ("EPRM"),
> just the I2C controller device ("I2C0").
> I will add description for it in patch v2.

Ah. Ok.  I didn't know about that and couldn't find it in the ACPI
spec :(  A more specific reference like you suggest is fine.


Jonathan

