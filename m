Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A70C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 11:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOake-0000ib-HL; Mon, 09 Jun 2025 07:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1uOakT-0000gY-B2; Mon, 09 Jun 2025 07:33:07 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1uOakQ-00020c-17; Mon, 09 Jun 2025 07:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H+ML7P2OroeQRZHfrvy5jUHaTPVVxoUEYAT+t8fn4so=; b=hVxuf00I0fpBitoUqETDsaGSHB
 D7Cv2AdSDFYHwBEuHWHq9LvXVvdUmRo2TpYrGoYyvpHeqDLi+/snealQvN+jWxYcz8XmNPWRcXYGN
 39iuN4BvAHy/9MJK+gWZaOsHtJ317DyDEvBM1ZhnTcLpm5kK5fjyRVRm+5wf1H4IfVglDIV+xHH7f
 nZskvZ3ZrVVdLEzzFU3qJhbgjwtswdB7BfJDQ2gJ1lwchUnnywCV8c13zYS4q7mJ52WGVquMAsoyF
 eifdqeqHj2K/EIS31C1Dty7qIfHsU277Kmaz/kojCdCn7yD1SK4kXVDt6E78rPL/z92dt8O+XhPhY
 CROyzw0Q==;
Received: from [63.135.74.212] (helo=[192.168.1.249])
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uOakH-00FMYO-67; Mon, 09 Jun 2025 12:32:53 +0100
Message-ID: <110336ae-4f0d-4e27-8bd4-5cd336c7fb4c@codethink.co.uk>
Date: Mon, 9 Jun 2025 12:32:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/riscv: add CVA6 machine
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250527112437.291445-1-ben.dooks@codethink.co.uk>
 <20250527112437.291445-2-ben.dooks@codethink.co.uk>
 <ca6cc5a3-029a-4e6c-8dfb-076b910bfbb5@ventanamicro.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <ca6cc5a3-029a-4e6c-8dfb-076b910bfbb5@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap5.colo.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/06/2025 12:24, Daniel Henrique Barboza wrote:
> 
> 
> On 5/27/25 8:24 AM, Ben Dooks wrote:
>> Add a (currently Genesy2 based) CVA6 machine.
>>
>> Has SPI and UART, the GPIO and Ethernet are currently black-holed
>> as there is no hardware model for them (lowRISC ethernet and Xilinx
>> GPIO)
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>> v2:

Apologie,s looks like it this got rebased out of the release

>> +/* plic register interface in corev_apu/rv_plic/rtl/plic_regmap.sv */
>> +
> 
> I believe you've missed my comment in v1:
> 

would this be ok

/*
* plic register interface in corev_apu/rv_plic/rtl/plic_regmap.sv
* https://github.com/pulp-platform/rv_plic/blob/master/rtl/plic_regmap.sv
*/

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

