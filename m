Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25CAC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 12:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxRGh-00013Q-Lj; Thu, 18 Apr 2024 08:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marex@denx.de>) id 1rxRGU-0000zg-DI
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 08:53:23 -0400
Received: from phobos.denx.de ([85.214.62.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marex@denx.de>) id 1rxRGS-0000r5-2d
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 08:53:21 -0400
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DFC0C8863F;
 Thu, 18 Apr 2024 14:53:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713444796;
 bh=qiauDGd5nvpF0uqMxoHBcAQllVXTs/3t5gRKxCiSPsw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QjIaOZK4WVMwTBiMJYC7kfxxKho2FLGrqBFbV0jDftN3+6vQsTv8JrvlTIJyTbuPX
 bNxdJp6r8dCsXTmnJlxVArJP3IfE16mpYu577obEBMWSc+xWDhB0d70XmnU+OhjGBK
 PMJoyWmbSGhq1o/gda61JxidMk5wRtc0izYiH5Vw6V8EOjMY7YWhQoxUtHAiT3Pt5G
 E5MKiUM4ZXfSz3+MAVxazFoEbsQLek8wnOI5vWFMiJyWwORUXyE/8JSYAXF5QwOCNO
 2nQRFr+KiqZQDxVVW6QczSnbXfqcHBnt+H14E9CnDR5D78URLjDwlmcDJ4ULhji9yW
 lgqJWA3SrOkVQ==
Message-ID: <65d43669-d4d1-44eb-870e-7a20af64e14a@denx.de>
Date: Thu, 18 Apr 2024 14:49:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Deprecation/removal of nios2 target support
To: Thomas Huth <thuth@redhat.com>, Sandra Loosemore
 <sloosemore@baylibre.com>, gcc@gcc.gnu.org, binutils@sourceware.org,
 gdb-patches@sourceware.org, libc-alpha@sourceware.org,
 Chung-Lin Tang <cltang@baylibre.com>, andrew@reenigne.org,
 Yao Qi <qiyaoltc@gmail.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, qemu-devel@nongnu.org,
 newlib@sourceware.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <f4bug@amsat.org>, Chris Wulff <crwulff@gmail.com>
References: <55a1bc52-b435-463e-8be1-4b23e44393a0@baylibre.com>
 <6b7e61bb-edd3-42ee-a39c-f77fd43aa7df@redhat.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <6b7e61bb-edd3-42ee-a39c-f77fd43aa7df@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Received-SPF: pass client-ip=85.214.62.61; envelope-from=marex@denx.de;
 helo=phobos.denx.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 4/18/24 7:53 AM, Thomas Huth wrote:
> On 18/04/2024 05.27, Sandra Loosemore wrote:
>> Tomorrow I plan to push patches to mark the nios2 target as obsolete 
>> in GCC 14.
>>
>> Background: Intel has EOL'ed the Nios II processor IP and is now 
>> directing their FPGA customers to a RISC-V platform instead.
>>
>> https://www.intel.com/content/www/us/en/content-details/781327/intel-is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip.html
>>
>> The Nios II hardware on loan from Intel that we were using for testing 
>> at Mentor Graphics/Siemens was returned around the first of the year. 
>> For some time we had been using QEMU to test the nios2-elf target, but 
>> we never had a QEMU test harness set up that would boot the Linux 
>> kernel, and user-mode QEMU on this target is too buggy/unmaintained to 
>> use for primary testing. So the current situation is that none of the 
>> listed maintainers for any of the GNU toolchain components have access 
>> to a fully working test configuration any more, we have all moved on 
>> to new jobs and different projects, Intel has also moved on to a 
>> different platform, and our former contacts on Intel's Nios II team 
>> have moved on as well.  It seems like it's time to pull the plug.
>>
>> Therefore I'd like to mark Nios II as obsolete in GCC 14 now, and 
>> remove support from all toolchain components after the release is 
>> made.  I'm not sure there is an established process for 
>> obsoleting/removing support in other components; besides binutils, 
>> GDB, and GLIBC, there's QEMU, newlib/libgloss, and the Linux kernel.  
>> But, we need to get the ball rolling somewhere.
> 
> Thanks for the heads-up, Sandra! FWIW: QEMU already marked the nios2 
> target as deprecated, too, and plans to remove it in version 9.1 (in 
> autumn this year).

Thank you and sorry for being inactive for so long around nios2.

