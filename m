Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A508C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 03:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1zQ5-00038I-9n; Mon, 07 Apr 2025 23:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u1zQ1-00037y-UR
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 23:14:34 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u1zPy-0006Qf-0U
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 23:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744082070; x=1775618070;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=sz3KL2i0SIeXCiohw3CNml72EzW6rxLT91YWoTm3c6o=;
 b=BG6CNFQxzu3K8goBFoEj/BENyZAMNJfZAN9DJTF6B+wPgFCOAZNAJ0dy
 r/r2lZuz964nxCLrgJ157fiTlOaPsE1ct/RsgugHCkCsjkhaqSXoqbnnP
 ozjXJhlplsf6V3PFLYcyRXB1+If08tLQH3FMB0tqErauxiMP0Iip0RcNd
 mrEuZ+jP6+vL0hhkjd6mEACbsNjQ2YW3bFHPxeQ4g7nkqUnPztIKEPQEI
 r9lLzv0eiDPXADuhdi204pFpYtIW6zCypdoiojE1zq2gRN8fjWKB7N8Zt
 YzAyUjOJuSaA6YdcNGT/T2vkEfNX510W79EYydpMLLCfCyqvoVr6qla7x w==;
X-CSE-ConnectionGUID: 2cmWQMBZRouycaxPjhDxQA==
X-CSE-MsgGUID: EYjHheluSOyHC2B6c1V1YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45381762"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; d="scan'208";a="45381762"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 20:14:26 -0700
X-CSE-ConnectionGUID: 6WSpcOiETriatvPdh3UqDg==
X-CSE-MsgGUID: k/MR7H9HTcuHJPxjijvJ/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; d="scan'208";a="128114426"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 20:14:22 -0700
Message-ID: <2bb3dfa4-6587-4054-8491-5eab5606d596@intel.com>
Date: Tue, 8 Apr 2025 11:14:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/55] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-14-xiaoyao.li@intel.com>
 <Z-0kzoSrlkohaA8A@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z-0kzoSrlkohaA8A@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 4/2/2025 7:51 PM, Daniel P. Berrangé wrote:
> On Tue, Apr 01, 2025 at 09:01:23AM -0400, Xiaoyao Li wrote:
>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>
>> Three sha384 hash values, mrconfigid, mrowner and mrownerconfig, of a TD
>> can be provided for TDX attestation. Detailed meaning of them can be
>> found: https://lore.kernel.org/qemu-devel/31d6dbc1-f453-4cef-ab08-4813f4e0ff92@intel.com/
>>
>> Allow user to specify those values via property mrconfigid, mrowner and
>> mrownerconfig. They are all in base64 format.
>>
>> example
>> -object tdx-guest, \
>>    mrconfigid=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>>    mrowner=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>>    mrownerconfig=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v
>>
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> Changes in v8:
>>   - it gets squashed into previous patch in v7. So split it out in v8;
>>
>> Changes in v6:
>>   - refine the doc comment of QAPI properties;
>>
>> Changes in v5:
>>   - refine the description of QAPI properties and add description of
>>     default value when not specified;
>>
>> Changes in v4:
>>   - describe more of there fields in qom.json
>>   - free the old value before set new value to avoid memory leak in
>>     _setter(); (Daniel)
>>
>> Changes in v3:
>>   - use base64 encoding instread of hex-string;
>> ---
>>   qapi/qom.json         | 16 +++++++-
>>   target/i386/kvm/tdx.c | 86 +++++++++++++++++++++++++++++++++++++++++++
>>   target/i386/kvm/tdx.h |  3 ++
>>   3 files changed, 104 insertions(+), 1 deletion(-)
> 
> 
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index aa043acb1a88..77ddb2655c53 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> @@ -11,8 +11,10 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qemu/error-report.h"
>> +#include "qemu/base64.h"
>>   #include "qapi/error.h"
>>   #include "qom/object_interfaces.h"
>> +#include "crypto/hash.h"
>>   
>>   #include "hw/i386/x86.h"
>>   #include "kvm_i386.h"
>> @@ -239,6 +241,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>       CPUX86State *env = &x86cpu->env;
>>       g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
>>       Error *local_err = NULL;
>> +    size_t data_len;
>>       int retry = 10000;
>>       int r = 0;
>>   
>> @@ -250,6 +253,36 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>       init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>>                           sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>>   
>> +    if (tdx_guest->mrconfigid) {
>> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
>> +                              strlen(tdx_guest->mrconfigid), &data_len, errp);
>> +        if (!data || data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
>> +            error_setg(errp, "TDX: failed to decode mrconfigid");
>> +            return -1;
>> +        }
> 
> When '!data',  qbase64_decode will have already filled 'errp' with
> details, so we must immediately 'return -1', as a repeated error_setg
> call is an programming error.
> 
> The error_setg call should only be done in response to failing
> the 'data_len' check and the message should specify the lengths
> eg more like this
> 
>    if (!data) {
>        return -1;
>    }
> 
>    if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
>        error_setg(errp, "TDX mrconfigid len %d must match SHA384 digest len %d",
>                   data_len, QCRYPTO_HASH_DIGEST_LEN_SHA384)
>        return -1;
>    }

Nice catch!

> 
>> +        memcpy(init_vm->mrconfigid, data, data_len);
>> +    }
>> +
>> +    if (tdx_guest->mrowner) {
>> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrowner,
>> +                              strlen(tdx_guest->mrowner), &data_len, errp);
>> +        if (!data || data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
>> +            error_setg(errp, "TDX: failed to decode mrowner");
>> +            return -1;
>> +        }
>> +        memcpy(init_vm->mrowner, data, data_len);
>> +    }
>> +
>> +    if (tdx_guest->mrownerconfig) {
>> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrownerconfig,
>> +                            strlen(tdx_guest->mrownerconfig), &data_len, errp);
>> +        if (!data || data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
>> +            error_setg(errp, "TDX: failed to decode mrownerconfig");
>> +            return -1;
>> +        }
>> +        memcpy(init_vm->mrownerconfig, data, data_len);
>> +    }
>> +
>>       r = setup_td_guest_attributes(x86cpu, errp);
>>       if (r) {
>>           return r;
> 
> With regards,
> Daniel


