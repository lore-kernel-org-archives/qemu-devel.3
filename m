Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3C1C5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhOyZ-0004zL-KT; Tue, 05 Mar 2024 02:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhOyR-0004pf-PJ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:12:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhOyQ-0001qd-3x
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709622744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3rmWrwsYIH8+AVc0Y/VnGI5K+bQgFl3RojjzJO+fFQ=;
 b=AsI6e2WNlt8dRAZhNdVmmLYtEec+LpLaQqch5lYo1jZAMrTKbF5n1iBwqrcccncmaDl1CM
 qB2gcYBriKp5t1pNNmMoXtU46OQJGlzW6d2BtJKN/Y3ZKnZgO0HXR1rr1JVkZRzhVRneFi
 Myza5AqntIB13pUVbhELlEbX7oER1q8=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-kh5ILQfTOmCP-QdgyQUVCw-1; Tue, 05 Mar 2024 02:12:22 -0500
X-MC-Unique: kh5ILQfTOmCP-QdgyQUVCw-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-4727e51f64bso1033824137.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709622741; x=1710227541;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z3rmWrwsYIH8+AVc0Y/VnGI5K+bQgFl3RojjzJO+fFQ=;
 b=tt997GTuAFdapIchZ9zLCOkreW2jQT9smxj9hDz5lGKGP4jVZb0iDb2k16iP7965gd
 7GSvsYCPpevQr33fxq+npJ635ZsplVOH5j1tgjhlRlqZE4583I6nt8fC3auO61wH8xfb
 5w3/aeXdQzsKwD/nm8BBOL9mVHumAS/wdk13gHBbY8g7pvlRV156mh5HQiHLSk0Gkw8F
 6CVrczHfyLWC95RrkUR1R43xKFO+8dsZ76fWojtRv3Nc9703LLM49olXseBcBuyEvvUc
 a/QMy67a5kYZGSV6RxGK5L5dpTNHZ7pMn+oU/Je4mH0u2ZOV+211RC/xcqJPpugHygwG
 twqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1S6thGT+4fXQY7omVYFHKvdiTqCWHUP//vkhtyaEKW4YtFtYkyAXRnBpLZgWLCJB+eG7r9PKB3wFLl9X/z4EBB0zHgfM=
X-Gm-Message-State: AOJu0YzMos+IgYecGOnP2Md4qHf8PL9VjlFxFLVQ/Gu0xCsDy8BwRi4/
 8okmLgykntndoLp2AKYW29EHr1ktSN53ng3ojU11IHAyDX70aBjUSoPTso0zit5cdOr3HuWPHkn
 k2MC7bSV+xijDhbHxrwtWR8BZQ5wKi2fKfQlYqcdUQJPJOmsnT3iN
X-Received: by 2002:a05:6102:dcd:b0:472:5948:3c85 with SMTP id
 e13-20020a0561020dcd00b0047259483c85mr1230556vst.8.1709622740430; 
 Mon, 04 Mar 2024 23:12:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEgr/V8DmpiYcJ5EcXAFQ5q49Kmjo8TaY3NZZrlgTMXeNPmar3At8+5UFuNfQ6gvXZWerzBw==
X-Received: by 2002:a05:6102:dcd:b0:472:5948:3c85 with SMTP id
 e13-20020a0561020dcd00b0047259483c85mr1230492vst.8.1709622738712; 
 Mon, 04 Mar 2024 23:12:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 he29-20020a05622a601d00b0042ee1ff302esm2592910qtb.66.2024.03.04.23.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:12:18 -0800 (PST)
Message-ID: <bf4ff1c0-6d11-4c33-a3be-8d7d06755072@redhat.com>
Date: Tue, 5 Mar 2024 08:12:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/26] s390/stattrib: Add Error** argument to
 set_migrationmode() handler
Content-Language: en-US, fr
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-2-clg@redhat.com> <87v861hgcr.fsf@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87v861hgcr.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
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

On 3/4/24 21:49, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> This will prepare ground for futur changes adding an Error** argument
>> to the save_setup() handler. We need to make sure that on failure,
>> set_migrationmode() always sets a new error. See the Rules section in
>> qapi/error.h.
>>
>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/hw/s390x/storage-attributes.h |  2 +-
>>   hw/s390x/s390-stattrib-kvm.c          | 12 ++++++++++--
>>   hw/s390x/s390-stattrib.c              | 14 +++++++++-----
>>   3 files changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
>> index 5239eb538c1b087797867a247abfc14551af6a4d..8921a04d514bf64a3113255ee10ed33fc598ae06 100644
>> --- a/include/hw/s390x/storage-attributes.h
>> +++ b/include/hw/s390x/storage-attributes.h
>> @@ -39,7 +39,7 @@ struct S390StAttribClass {
>>       int (*set_stattr)(S390StAttribState *sa, uint64_t start_gfn,
>>                         uint32_t count, uint8_t *values);
>>       void (*synchronize)(S390StAttribState *sa);
>> -    int (*set_migrationmode)(S390StAttribState *sa, bool value);
>> +    int (*set_migrationmode)(S390StAttribState *sa, bool value, Error **errp);
>>       int (*get_active)(S390StAttribState *sa);
>>       long long (*get_dirtycount)(S390StAttribState *sa);
>>   };
>> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
>> index 24cd01382e2d74d62c2d7e980eb6aca1077d893d..357cea2c987213b867c81b0e258f7d0c293fe665 100644
>> --- a/hw/s390x/s390-stattrib-kvm.c
>> +++ b/hw/s390x/s390-stattrib-kvm.c
>> @@ -17,6 +17,7 @@
>>   #include "sysemu/kvm.h"
>>   #include "exec/ram_addr.h"
>>   #include "kvm/kvm_s390x.h"
>> +#include "qapi/error.h"
>>   
>>   Object *kvm_s390_stattrib_create(void)
>>   {
>> @@ -137,14 +138,21 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
>>       }
>>   }
>>   
>> -static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val)
>> +static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val,
>> +                                               Error **errp)
>>   {
>>       struct kvm_device_attr attr = {
>>           .group = KVM_S390_VM_MIGRATION,
>>           .attr = val,
>>           .addr = 0,
>>       };
>> -    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>> +    int r;
>> +
>> +    r = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>> +    if (r) {
>> +        error_setg_errno(errp, -r, "KVM_S390_SET_CMMA_BITS failed");
> 
> Did you mean KVM_SET_DEVICE_ATTR?

Drat. Copy paste :)


Thanks,

C.



> 
>> +    }
>> +    return r;
>>   }
>>   
>>   static long long kvm_s390_stattrib_get_dirtycount(S390StAttribState *sa)
>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>> index c483b62a9b5f71772639fc180bdad15ecb6711cb..e99de190332a82363b1388bbc450013149295bc0 100644
>> --- a/hw/s390x/s390-stattrib.c
>> +++ b/hw/s390x/s390-stattrib.c
>> @@ -60,11 +60,12 @@ void hmp_migrationmode(Monitor *mon, const QDict *qdict)
>>       S390StAttribState *sas = s390_get_stattrib_device();
>>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>>       uint64_t what = qdict_get_int(qdict, "mode");
>> +    Error *local_err = NULL;
>>       int r;
>>   
>> -    r = sac->set_migrationmode(sas, what);
>> +    r = sac->set_migrationmode(sas, what, &local_err);
>>       if (r < 0) {
>> -        monitor_printf(mon, "Error: %s", strerror(-r));
>> +        monitor_printf(mon, "Error: %s", error_get_pretty(local_err));
>>       }
>>   }
>>   
>> @@ -170,13 +171,15 @@ static int cmma_save_setup(QEMUFile *f, void *opaque)
>>   {
>>       S390StAttribState *sas = S390_STATTRIB(opaque);
>>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>> +    Error *local_err = NULL;
>>       int res;
>>       /*
>>        * Signal that we want to start a migration, thus needing PGSTE dirty
>>        * tracking.
>>        */
>> -    res = sac->set_migrationmode(sas, 1);
>> +    res = sac->set_migrationmode(sas, true, &local_err);
>>       if (res) {
>> +        error_report_err(local_err);
>>           return res;
>>       }
>>       qemu_put_be64(f, STATTR_FLAG_EOS);
>> @@ -260,7 +263,7 @@ static void cmma_save_cleanup(void *opaque)
>>   {
>>       S390StAttribState *sas = S390_STATTRIB(opaque);
>>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>> -    sac->set_migrationmode(sas, 0);
>> +    sac->set_migrationmode(sas, false, NULL);
>>   }
>>   
>>   static bool cmma_active(void *opaque)
>> @@ -293,7 +296,8 @@ static long long qemu_s390_get_dirtycount_stub(S390StAttribState *sa)
>>   {
>>       return 0;
>>   }
>> -static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool value)
>> +static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool value,
>> +                                            Error **errp)
>>   {
>>       return 0;
>>   }
> 


