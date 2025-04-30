Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34E6C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 12:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA6qM-0008Ar-4F; Wed, 30 Apr 2025 08:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uA6qH-00086M-9O
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:47:14 -0400
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uA6qE-0002G9-8M
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:47:13 -0400
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id 432545A5;
 Wed, 30 Apr 2025 14:47:07 +0200 (CEST)
Message-ID: <8ecb6cb9-1a8a-4feb-a490-032154665ac6@lauterbach.com>
Date: Wed, 30 Apr 2025 14:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] mcd: Introduce Multi-Core Debug (MCD) API
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org,
 armbru@redhat.com, christian.boenig@lauterbach.com
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-2-mario.fleischmann@lauterbach.com>
 <aBHdEz2x_ckyfnF_@redhat.com>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <aBHdEz2x_ckyfnF_@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1746017227282
Received-SPF: pass client-ip=62.154.241.218;
 envelope-from=mario.fleischmann@lauterbach.com; helo=bm.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30.04.2025 10:20, Daniel P. Berrangé wrote:

> On Wed, Apr 30, 2025 at 07:27:22AM +0200, Mario Fleischmann wrote:
>> Formatting changes to mcd_api.h to compily with QEMU's coding style guidelines:
>>
>> * limit line width to 80
>> * convert Doxygen to kernel-doc comments
>> * avoid architecture specific defines
>>
>> The original MCD API version can be found at:
>> https://repo.lauterbach.com/sprint_mcd_api_v1_0.zip
> 
> The commit message needs to call out the license choice of the
> imported file.

Thanks for pointing that out. Will be added in the next version.

>> Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
>> ---
>>  MAINTAINERS            |    6 +
>>  docs/interop/index.rst |    1 +
>>  docs/interop/mcd.rst   |   44 +
>>  mcd/mcd_api.h          | 3963 ++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 4014 insertions(+)
>>  create mode 100644 docs/interop/mcd.rst
>>  create mode 100644 mcd/mcd_api.h
> 
>> diff --git a/mcd/mcd_api.h b/mcd/mcd_api.h
>> new file mode 100644
>> index 0000000..8c89353
>> --- /dev/null
>> +++ b/mcd/mcd_api.h
>> @@ -0,0 +1,3963 @@
>> +/*
>> + * Copyright (c) 2008, ARM Ltd., Infineon Technologies, NXP Semiconductors,
>> + * Lauterbach, STMicroelectronics and TIMA Laboratory.
>> + * All rights reserved.
>> + *
>> + * PREAMBLE
>> + *
>> + * The MCD API (Multi-Core Debug) has been designed as an interface between
>> + * software development tools and simulated or real systems with multi-core
>> + * SoCs. The target is to allow consistent software tooling throughout the
>> + * whole SoC development flow.
>> + * The MCD API (the "SOFTWARE") has been developed jointly by ARM Ltd.,
>> + * Infineon Technologies, NXP Semiconductors, Lauterbach,
>> + * STMicroelectronics and TIMA Laboratory as part of the SPRINT project
>> + * (www.sprint-project.net).
>> + * The SPRINT project has been funded by the European Commission.
>> + *
>> + * LICENSE
>> + *
>> + *  Any redistribution and use of the SOFTWARE in source and binary forms,
>> + *  with or without modification constitutes the full acceptance of the
>> + *  following disclaimer as well as of the license herein and is permitted
>> + *  provided that the following conditions are met:
>> + *  - Redistributions of source code must retain the above copyright notice,
>> + *    this list of conditions and the disclaimer detailed below.
>> + *  - Redistributions in binary form must reproduce the above copyright notice,
>> + *    this list of conditions and the disclaimer detailed below in the
>> + *    documentation and/or other materials provided with the distribution.
>> + *  - Neither the name of its copyright holders nor the names of its
>> + *    contributors may be used to endorse or promote products derived from the
>> + *    Software without specific prior written permission.
>> + *  - Modification of any or all of the source code, documentation and other
>> + *    materials provided under this license are subject to acknowledgement of
>> + *    the modification(s) by including a prominent notice on the modification(s)
>> + *    stating the change(s) to the file(s), identifying the date of such change
>> + *    and stating the name of the publisher of any such modification(s).
> 
> This 4th clause is rather obnoxious and....
> 
>> + * VERSION HISTORY
>> + *
>> + *  1.0 "SPRINT Release"     : SPRINT reference version
>> + *
>> + *  1.1 "Lauterbach Release" :
>> + *  - forces all boolean types to 8-bit on Linux and Mac-OS-X,
>> + *    but 32-bit on all other OS forces 32-bit enumeration types
>> + *  - additional memory spaces MCD_MEM_SPACE_IS_PHYSICAL,
>> + *    MCD_MEM_SPACE_IS_LOGICAL, MCD_MEM_SPACE_IS_AUX
>> + *  - changed type of 2nd argument of mcd_qry_input_handle_f from "int" to
>> + *    "uint32_t"
>> + *  - changed type of element "data" of of mcd_tx_st from "unsigned char" to
>> + *     "uint8_t"
>> + *  - specifying the calling convention for MS Windows (x86) to __cdecl
>> + *
>> + *  1.2 "QEMU Release"       :
>> + *  - changes formatting to accommodate QEMU's coding style guidelines
>> + *  - includes qemu/osdep.h instead of mcd_types.h
> 
> ....this appears to not be compliant with the license since it fails
> to include the dates

We've got the dates of modifications available at our version control.
They will be added in the next version of this patch.

> AFAICT this license is derived from a classic BSD 3 clause, with the
> extra 4th clause added.
> 
> I don't see any SPDX license matching this, which is painful as it
> means it is going to need license approval before it can be included
> by distributions downstream.
> 
> Does this really have to be under a custom license instead of a
> well known standard license ? There's really no good reason for
> inventing new open source licenses.

BSD 3-Clause Modification matches the license of the MCD API and is
listed under the SPDX License List. Is it possible to extend
checkpatch's @valid with "BSD-3-Clause-Modification"? That way, we can
also add the SPDX-License-Identifier to mcd_api.h without an error being
generated by the script.

> With regards,
> Daniel

Thank you very much for taking the time to review the patch! I will add
the changes in the next version of this series but will wait for further
reviews until submitting v3 in order to keep the mailing list less busy.

Best regards,
Mario

