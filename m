Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58FBC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrpL-0008Co-CM; Tue, 25 Aug 2026 10:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wyrpJ-0008CZ-Pp
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wyrpI-0000gQ-5i
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787666910;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWZ36ssQuMggl10NX4pB67A6/gc4A8ViF4utTFslLtk=;
 b=Eouqqe9jqLRRntTeMu3WP2o0mJ5evn5Qqo5cWUKUUYG3z7tQTlB26hCbj0weGV78ZXh8XE
 F+lnodPwD2+pwuscodCpmVHgHl+gL0JJznbNCvDn0y+8ER17HtXoDdVeWdA3nieTj9queq
 CvKAyhRpqJfz8GXHMOa1RD7SA7873Lc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-wbX-c2vsMT26Eou5cFGe7w-1; Tue, 25 Aug 2026 10:08:28 -0400
X-MC-Unique: wbX-c2vsMT26Eou5cFGe7w-1
X-Mimecast-MFC-AGG-ID: wbX-c2vsMT26Eou5cFGe7w_1787666908
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c20e5890680so240824166b.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787666908; x=1788271708;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RWZ36ssQuMggl10NX4pB67A6/gc4A8ViF4utTFslLtk=;
 b=KWKZDdytv/SLa2XP1hCMLd0/ZG5GtzJCJWqWbMa/mQVTQ0FDh46JCA3AlbN9rqyiJI
 iDbbsLmoPL5mojnWUQvx54JyBM2k48h8GPOCy+xYEKmXj0TXwNyo2ChAcy9/9tE4nkPr
 Exxf/cIsDLRHsHVywcZccNz1QM271eqjfuxMsbnOj4Ms3zPAfvNd+RR37bKNZziTcOd5
 JdyyGbmySOM+qGxdKSQoyNvgivQYzGW5m/Opv8WBH5jCQyAZSPoI5+B/2r/PctU3opWR
 cWF1AZS3TSjWf3iM+IaD23kr1wo7njZGcj6Bs5bOPGw5Fy6OejCfFwdf/NLEpEywY6ZK
 8o7g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rprqv8NpN3hsF6hZwPTXGugNmQEBtONiMxpV2Pmjzkhn9D32dPErl86WM7mwAIfNwykkEWuUuxsbJPG@nongnu.org
X-Gm-Message-State: AFuF++mtAeVX2hyc+/Ph8gCQNF5N8OonspTX/NA6wweRr2ZPN+C3ZPOC
 pyQgDTLcSlKb+kdVc5mJxpFPZTrC2TD7B5/g+E/3cu1xWGiQJmBl2kCVx/8faPCSqVpAX7unIbz
 S4ost3oZc204sFY8rYcgX2AAeZvPtSNxfY4AJEvecaDzD/ugbAuobsITU
X-Gm-Gg: AR+sD10R6mklwhC3+d5Xdc5b3zpnNidCPbwLvdFxcFdIdrz2pou01cDiKXEwQxJ9YRJ
 VGNkn0yc4Il3n40KMvHPulDYnBs50fSuI3tTPV7USsUXEhOlqyrp8cd4K3He/cHWNDdaBFVE223
 bUMZ4FDsfxFlLQxE/O1bqYckJXRZDZuEhMZf0MHcuXiVI0htOaJpL9Us52bTwW5sLUFIs+a7cxs
 o3SErLBpo/M9O8ky2oKeJ396jmALW4Sacbktg0wqX8+DG68IEzZoNPW/5/oppkFt6nkS8dSbuhf
 kYqcpRjfrwDMA5Fq+z/3S3TR6Ttke8xERsqgO3S716Jr1BmosiP5XjFu6uat4uTIirLHMu9coM9
 o3cZ1Cc/Ibbnrt16U177EABK7doFtS9k9TORWKZ9GzVkaU0s7
X-Received: by 2002:a17:907:8990:b0:c20:3679:a2e6 with SMTP id
 a640c23a62f3a-c24925eb3ffmr3225005966b.10.1787666907613; 
 Tue, 25 Aug 2026 07:08:27 -0700 (PDT)
X-Received: by 2002:a17:907:8990:b0:c20:3679:a2e6 with SMTP id
 a640c23a62f3a-c24925eb3ffmr3224991966b.10.1787666906874; 
 Tue, 25 Aug 2026 07:08:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b161sm1933953266b.11.2026.08.25.07.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 07:08:25 -0700 (PDT)
Message-ID: <09b39de5-b0ae-40ec-9977-00fefa59561f@redhat.com>
Date: Tue, 25 Aug 2026 16:08:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 04/18] arm/cpu: Add infra to handle generated ID
 register definitions
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260726153221.24773-1-eric.auger@redhat.com>
 <20260726153221.24773-5-eric.auger@redhat.com>
 <557850AC-880C-4A6D-AA7A-7A0F38B3C9CD@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <557850AC-880C-4A6D-AA7A-7A0F38B3C9CD@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,

On 8/20/26 8:35 AM, Khushit Shah wrote:
>
>> On 26 Jul 2026, at 8:59 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> Introduce an infrastructure to store the definition of all ID regs:
>> This include their name, index and array of named fields.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Co-authored-by: Khushit Shah <khushit.shah@nutanix.com>
>>
>> ---
>>
>> v5 -> v6:
>> - add ArmIdRegArchVal
>> ---
>> target/arm/cpu-idregs.h | 41 +++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 41 insertions(+)
>> create mode 100644 target/arm/cpu-idregs.h
>>
>> diff --git a/target/arm/cpu-idregs.h b/target/arm/cpu-idregs.h
>> new file mode 100644
>> index 0000000000..245f1c8103
>> --- /dev/null
>> +++ b/target/arm/cpu-idregs.h
>> @@ -0,0 +1,41 @@
>> +/*
>> + * handle ID registers and their fields
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#ifndef TARGET_ARM_CPU_IDREGS_H
>> +#define TARGET_ARM_CPU_IDREGS_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "cpu.h"
>> +#include "cpu-sysregs.h"
>> +
>> +typedef struct ArmIdRegArchVal {
>> +    uint64_t value;
>> +    const char *name;
> I guess the name is not required, right?

indeed, this is not required. Removed and used uint64_t in place of 

typedef struct ArmIdRegArchVal in subsequent patches.

Thanks!

Eric

>
>> +} ArmIdRegArchVal;
>> +
>> +typedef struct ARM64SysRegField {
>> +    const char *name; /* name of the field, for instance CTR_EL0_IDC */
>> +    ARMIDRegisterIdx index; /* parent register, e.g. CTR_EL0_IDX */
>> +    int shift; /* lsb of the field in the register */
>> +    int length; /* highest bit number */
>> +    ArmIdRegArchVal *arch_vals;
>> +    uint32_t arch_vals_count;
>> +} ARM64SysRegField;
>> +
>> +typedef struct ARM64SysReg {
>> +    const char *name;   /* name of the sysreg, for instance CTR_EL0 */
>> +    ARMIDRegisterIdx index; /* register index, e.g. CTR_EL0_IDX */
>> +    struct ARM64SysRegField *fields;
>> +    uint32_t fields_count;
>> +    uint64_t writable_mask;
>> +} ARM64SysReg;
>> +
>> +/*
>> + * List of exposed ID regs (automatically populated from AARCHMRS Registers.json)
>> + */
>> +extern ARM64SysReg arm64_id_regs[NUM_ID_IDX];
>> +
>> +#endif
>> -- 
>> 2.53.0
>>


