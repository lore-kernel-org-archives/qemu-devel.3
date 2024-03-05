Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4871AC54E55
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQXV-0000ZI-MW; Tue, 05 Mar 2024 03:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhQXP-0000Yc-Jq
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:52:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rhQXN-0002jQ-SJ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709628755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07IVPU6wz2+V0/g2ygcubdpzOKOf/F7xzxtbdOEsN6w=;
 b=MNCiB9MzrHK134yZwkXzmXZ7pd7K15IahIM0FmHm25QiYWJKXuy8vwSzU2b8VDnB8HbrTV
 +20fpr1r6E4ryPTMeXaGRATwQt1RanSgHsJmhCL1kl58WRX+227C7RcEyWsu1Liaancbzt
 TxrxbygnS5wAf5v/m81sra0PYK2BP6U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-3epUIOgTPV-QSs34AHYpJQ-1; Tue, 05 Mar 2024 03:52:34 -0500
X-MC-Unique: 3epUIOgTPV-QSs34AHYpJQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-78825e5e374so376820485a.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709628753; x=1710233553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=07IVPU6wz2+V0/g2ygcubdpzOKOf/F7xzxtbdOEsN6w=;
 b=rvz/aO2ikEHNNCAYRFWhPf6r8+3ba2dOWEs2xNOddpxW3f18SBZ6xhqAOHLdsAF8gy
 JTgnvKUyQZK5KpDTY3DbOMI/lA2Nf0USwGX0I14UoT9RM23Q2ES0BA7QOZEU4H24372J
 roT66tBnQ6pdksUg+VZLgVKZjtOa2E6IxX5B4Sk9NvPxPj+UnyWGVzVgYsxidtMNBPDA
 619WsCsSLhwRj0YuBI4EtGzMWw340FFaiOGbrkaWsn7PbZm6z4mbh1cPtOWo88CI1gHP
 xBsb+Lxit1uUl3h8ylR9Vg7zrj6l8o1co8YdoKZapVUj1udKbvx9XjagBGNwTg3KUEbT
 T/fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLCTNvKxRa8MOO9VVhQKtTsgTFm0GD15E/3wrg8eOQWWzzCzSAGEAgGoO8GjHqvwX7eqrbxOJqxVJIRKlLfeK6z2YEBZE=
X-Gm-Message-State: AOJu0Yz4mmwVx7lD/yGQAPjVVwHiOs9WVT2D08eIhQ+Ejv+Et1+WfF1Z
 t5grXklBvbaHkwS5dKqYY76ApO6/BE96k0d9SK+6OMnQ2USkDU9UA1q7IoVu3/DM1CFpZcu4WJD
 jxflbiuIcGO21/Vd7Lz6VmJdiqRLr41AUKqHwf/YKubqt9N7/tVp8
X-Received: by 2002:a05:620a:298a:b0:787:f452:4d2 with SMTP id
 r10-20020a05620a298a00b00787f45204d2mr2034783qkp.3.1709628753075; 
 Tue, 05 Mar 2024 00:52:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwTKGuE/mLDdzFJefDdsIr/xMZ0aMTWZ+4dMC6wQsjNUDHvCIIO3C+G+vaEWfRA5Fgbsb99Q==
X-Received: by 2002:a05:620a:298a:b0:787:f452:4d2 with SMTP id
 r10-20020a05620a298a00b00787f45204d2mr2034773qkp.3.1709628752769; 
 Tue, 05 Mar 2024 00:52:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 f13-20020ac86ecd000000b0042e2eb24b42sm5211564qtv.22.2024.03.05.00.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 00:52:32 -0800 (PST)
Message-ID: <32df2a30-dc72-4cbd-8515-7800cb922adb@redhat.com>
Date: Tue, 5 Mar 2024 09:52:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/26] migration: Always report an error in
 ram_save_setup()
Content-Language: en-US, fr
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-5-clg@redhat.com> <87msrdheh2.fsf@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87msrdheh2.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/4/24 22:30, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> This will prepare ground for futur changes adding an Error** argument
>> to the save_setup() handler. We need to make sure that on failure,
>> ram_save_setup() sets a new error.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   migration/ram.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 45a00b45edd429ef0568adce09b7459883e00167..dbd04d8ee2167881007c836a6bbc79c1aced72d0 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2937,12 +2937,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>       int ret;
>>   
>>       if (compress_threads_save_setup()) {
>> +        error_report("%s: failed to start compress threads", __func__);
>>           return -1;
>>       }
>>   
>>       /* migration has already setup the bitmap, reuse it. */
>>       if (!migration_in_colo_state()) {
>>           if (ram_init_all(rsp) != 0) {
>> +            error_report("%s: failed to setup RAM for migration", __func__);
>>               compress_threads_save_cleanup();
>>               return -1;
>>           }
>> @@ -2969,12 +2971,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>   
>>       ret = rdma_registration_start(f, RAM_CONTROL_SETUP);
>>       if (ret < 0) {
>> +        error_report("%s: failed to start RDMA registration", __func__);
>>           qemu_file_set_error(f, ret);
>>           return ret;
>>       }
>>   
>>       ret = rdma_registration_stop(f, RAM_CONTROL_SETUP);
>>       if (ret < 0) {
>> +        error_report("%s: failed to stop RDMA registration", __func__);
>>           qemu_file_set_error(f, ret);
>>           return ret;
>>       }
>> @@ -2986,6 +2990,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>       ret = multifd_send_sync_main();
>>       bql_lock();
>>       if (ret < 0) {
>> +        error_report("%s: multifd synchronization failed", __func__);
>>           return ret;
>>       }
>>   
>> @@ -2994,7 +2999,11 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>       }
>>   
>>       qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>> -    return qemu_fflush(f);
>> +    ret = qemu_fflush(f);
>> +    if (ret) {
>> +        error_report("%s failed : %s", __func__, strerror(ret));
> 
> Here it should be -ret
> 
> The qemu_fflush function returns the QEMUFile error (f->last_error) and
> that is expected to be a -errno value.

oh yes. I should have know that since qemu_file_set_error() takes a -errno.

  
> I started making sure all callers of qemu_file_set_error() use a
> negative value, but got lost in the vmstate code and never finished:
> 
> https://lore.kernel.org/r/20230706195201.18595-1-farosas@suse.de

Thanks for the pointer.

Thanks,

C.


