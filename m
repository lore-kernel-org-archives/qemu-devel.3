Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BE4CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzMK-0006xO-85; Fri, 30 Aug 2024 07:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjzMI-0006wj-0U
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:00:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjzME-0004mR-NC
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:00:01 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwFS10mYbz6K6WT;
 Fri, 30 Aug 2024 18:55:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id A2BB1140CF4;
 Fri, 30 Aug 2024 18:59:52 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 11:59:52 +0100
Date: Fri, 30 Aug 2024 11:59:51 +0100
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <ardb+tianocore@kernel.org>, <quic_llindhol@quicinc.com>,
 <peter.maydell@linaro.org>, <devel@edk2.groups.io>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <chenbaozi@phytium.com.cn>,
 <wangyinfeng@phytium.com.cn>, <shuyiqi@phytium.com.cn>
Subject: Re: [RFC PATCH edk2-platforms 1/2] SbsaQemu: Add acpi0016 &
 acpi0017 objects into DSDT
Message-ID: <20240830115951.0000783b@Huawei.com>
In-Reply-To: <20240830031545.548789-2-wangyuquan1236@phytium.com.cn>
References: <20240830031545.548789-1-wangyuquan1236@phytium.com.cn>
 <20240830031545.548789-2-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 30 Aug 2024 11:15:44 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> This adds relevant definitions and descriptions of acpi0016 and
> acpi0017 to support CXL.
> 
> With the implementation of pxb-cxl on the original pcie host bridge,
> the previous space layout of mmio32 & mmio64 have to be divided to
> provide the mmio space for cxl host bridge.
> 
> I'm not sure if the new space layout would bring a series of bad
> influence, but it seems that the base address and size of cxl host
> bridge is ok.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

I'll go as far as saying this looks about right to me, but needs
some more eyes to be more certain. 
Trivial comments inline.

Jonathan

> diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl b/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl
> index c134fb66e860..94d0b2cbb118 100644
> --- a/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl
> +++ b/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl

> @@ -483,5 +849,45 @@ DefinitionBlock ("DsdtTable.aml", "DSDT",
>          }
>        } // End _OSC
>      }
> +
> +    Scope (\_SB)
> +    {
> +        // CXL Root for OS Driver
> +        Device (CXLM)
> +        {
> +            Name (_HID, "ACPI0017")  // _HID: Hardware ID
> +            Method (_STA, 0, NotSerialized)  // _STA: Status
> +            {
> +                Return (0x0B)
> +            }
> +
> +            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
> +            {
> +                If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52") /* Unknown UUID */))
Name that UUID in the comment.  I was thinking you didn't have QTG querying supported
because oddly I can't remember the uuid :)

> +                {
> +                    If ((Arg2 == Zero))
> +                    {
> +                        Return (Buffer (One)
> +                        {
> +                         0x01                                             // .
> +                        })
> +                    }
> +
> +                    If ((Arg2 == One))
> +                    {
> +                        Return (Package (0x02)
> +                        {
> +                            One,
> +                            Package (0x02)
> +                            {
> +                                Zero,
> +                                One
Hmm. I probably have this wrong in the qemu code, but it should be safe.
This is saying QTG 0 default with fallback to 1.  We don't have anything
in group 1.
Ah well never mind.  
> +                            }
> +                        })
> +                    }
> +                }
> +            }
> +        }
> +    }
>    } // Scope (_SB)
>  }




