Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D076CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 12:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOxe6-0005g2-GG; Fri, 28 Nov 2025 07:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1vOxe4-0005fI-6n
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:32:16 -0500
Received: from 6.mo548.mail-out.ovh.net ([188.165.58.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1vOxe1-00024C-C2
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:32:15 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.86])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dHt352wdKz5ybs;
 Fri, 28 Nov 2025 12:32:00 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 28 Nov
 2025 13:31:59 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002a5c11985-a51a-410f-a2d1-5c25975cb940,
 29BF13B6EDCC8D8EF27D98D9A979CEAD397ABB69) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Fri, 28 Nov 2025 13:31:58 +0100
From: Greg Kurz <groug@kaod.org>
To: Joel Stanley <joel@jms.id.au>
CC: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, <aik@ozlabs.ru>,
 <andrew@aj.id.au>, <benh@kernel.crashing.org>, <clg@kaod.org>,
 <danielhb413@gmail.com>, <sjitindarsingh@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] gitdm: Update IBM map
Message-ID: <20251128133158.77e41286@bahia>
In-Reply-To: <20251128012151.711182-1-joel@jms.id.au>
References: <20251128012151.711182-1-joel@jms.id.au>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 31412654-7a55-40b2-bce1-7f19f57def3b
X-Ovh-Tracer-Id: 10826653506102270316
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF5I/tzPri0UQpwTWhhiP37LGdbWhqB0cokCth0vCNkuuzms060Mq1NdlP5rWuNoa2OzL8IomRxFj1h8YvAl5eCT0xI4IwuYtR8adCTchqFlL2UsV7MSrZKizNq76YngNUgtBrpMIZ3n+eSLsITig2jIbbsG7JbAg1a/pE5FP9gpsRxG0+8yG6XITwa3IoteUlG3+U3RPNcEu2yvL49o5SM40uSW9Iw6kxBoBHnU+fY4d0ga6g4W2xit2/BAKSAvF9tlbh0rhMYlC+NoFVTdbbSIbqEwxYSKKnM5c2/9+4RiLORWnt5nIh/vZ8Ugrq4wxJPnWXi+njQ+wCnA3cvFSZAn1LX0lJ2at07WykP82b6H5MzD/LRZfzuSECbttPhMAAlBr/Yz5s0WOBTzO3OwGyGgXP4/NOaKesvuYLCVonWkPwhrzuSsi+1b/yZx//lgsaticsN6s6kzbZLLin6eQTD4pNuKLJfpDyRnNt6CtKC7IEcPIwvvT+n5hHb66tbcqIbw6SJwPatuNTvmUrH84OdGXoLJqzXfgAaufM8A2L8apVQkwVELI9Ei0bUlc1ZVHXJpoY+KzNPrRxnv4S+a4fpFBhoA0z9jcGIni6HW/+ojrcYgPp/v+w1T5rnoC9jBbb4/PYd1o+r9nMWFtIKUuqfQiY0rHvL1/lfhAzpoMYoyQ
DKIM-Signature: a=rsa-sha256; bh=mdxE41igJD3nO0tu+v4uimryoPCWUk7Rgfupfx2bEes=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1764333122; v=1;
 b=CY1/5m2H6ZvC8QTRFizWlRxf6EwrGtz8hlri6uGJWG9AlSRKbfJzfhHfAzvpM3vfucgqe1y2
 ARZN9XMMxBiGSOQc7sKTZEVDZPaxQRmN3psu0DJTHLDjiWkCkAOopOi+Y0XK0PCC+0ivoGyhyB8
 vQtz92ENq/GFHyOrfZ4QeDEmT1uYudfTMT2boQhO0VkJ4D6zVJNXlpT3Meu8kua9ecbrcQLskaE
 mVo9albFtRMKVCJTmPPlU3rQ0nf2VDZH8y8BpDZEyqY4DHL380fFU+zp1xPqKFj6R797dWSIWRv
 sYwULyHf0CPQzUJTEAdZK9AepRk1DsPwIAf+lSHeTXJFQ==
Received-SPF: pass client-ip=188.165.58.48; envelope-from=groug@kaod.org;
 helo=6.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 28 Nov 2025 11:51:50 +1030
Joel Stanley <joel@jms.id.au> wrote:

> A number of us have moved on from IBM.
> 
>  * Alexey moved to AMD in 2022.
>  * Andrew moved to Code Construct in 2023.
>  * Ben moved to Amazon in 2019.
>  * Cedric moved to Redhat.
>  * Daniel moved to Ventana in 2024.
>  * Greg moved to Redhat.

So still in IBM then... just kidding ;)

>  * Joel moved to Tenstorrent in 2025.
>  * Suraj moved to Amazon in 2019
> 
> Most have either stopped working on QEMU or swtiched to corp addresses.
> 

Acked-by: Greg Kurz <groug@kaod.org>

> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  contrib/gitdm/group-map-ibm | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
> index 24d8dc1b8657..39c53a42ca1b 100644
> --- a/contrib/gitdm/group-map-ibm
> +++ b/contrib/gitdm/group-map-ibm
> @@ -2,14 +2,6 @@
>  # Some IBM contributors submit via another domain
>  #
>  
> -aik@ozlabs.ru
> -andrew@aj.id.au
> -benh@kernel.crashing.org
> -clg@kaod.org
> -danielhb413@gmail.com
> -groug@kaod.org
>  jcfaracco@gmail.com
> -joel@jms.id.au
> -sjitindarsingh@gmail.com
>  tommusta@gmail.com
>  idan.horowitz@gmail.com



-- 
Greg

