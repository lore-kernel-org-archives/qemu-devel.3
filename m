Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C695CC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 14:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl8Zx-0008QD-Qn; Fri, 15 Mar 2024 10:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rl8Zv-0008Q3-Lz
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rl8Zq-0000Om-M1
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710513029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D3rd/vfmpZJwv/k9eXfVSDx9/0yA+++LEfWKMNUrKtY=;
 b=T27qzEirMrf45sv1WciZBajKQxIQ8TWIsU5QYdoLLrlvpNELhwbGRvPX9mofytTAZNvUGa
 vy4fLAbsTJunW5qEMCYeA7uJ+L5wIjCbIvMR9r9YkyIz5Sx8Evz5hVw/wsgMkPJum2epdi
 4sehBKRg1hkZf0JTg3ttezPSV8gSibc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-SKn99HsLO_WpX2fSui4lOA-1; Fri, 15 Mar 2024 10:30:28 -0400
X-MC-Unique: SKn99HsLO_WpX2fSui4lOA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-787dea68f58so199350285a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 07:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710513027; x=1711117827;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D3rd/vfmpZJwv/k9eXfVSDx9/0yA+++LEfWKMNUrKtY=;
 b=RSU09he4xtVzULjOLO9X/ugpmEEb6KFMt02Nk0tkuQ1FaOw6Q9Vnw7JmwR3LFo3F8y
 lnsxBx/+KSQsYMrHDJiIkniKJL3TxeqWrxqaGctCpfKkMOqWXqQccEJ2CwG/OJKftpfd
 tK5JVt+qNLTdJCt0kIsXLyiyAweKV3hj3BqDL8mjtLJbRoLYBuCE0c2wW21S6lydD/dw
 un8gxVgJO4BhuHciQ3gITCASjKLiBSg9ReJMgBNmQs/2+x+6HYWcH1lQdoS9+wHMC+Iz
 8/s7wUrDHkOuPXpRQn+cjVPV9jyWPAXbpOun7oCV+EKc/MyWLRCmPwWRnquGIEkRoxn0
 gyUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH1D2wZV3Wn5/TrREkR89UKBSOaRQRnrjz4TPhIro96mJjOrRyl1RPFY4gYdxSgNkyHUBaDklmMUdJxjVfO2pHj5auitI=
X-Gm-Message-State: AOJu0YyRQFaMbYRwRcS1BKOEAeS9LDwmqr9h9KvTGb6rzpBPRvJoo3cf
 g8kE/ijcBECZihpdDvbzG53cx9BjokNLfFyawxg1E0sjnjTZ51whcEw9z0MnXCnOtpoMqqsJY92
 LeUrkKjWB25pyRBh/w0abE3HXPlleio7yGo6qeQ3RFK/UUsu0lCLv
X-Received: by 2002:a05:620a:4415:b0:789:e247:1d7e with SMTP id
 v21-20020a05620a441500b00789e2471d7emr3862871qkp.43.1710513027394; 
 Fri, 15 Mar 2024 07:30:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUpioS3Pf1LdM+osfgI387qK55fZ1LdejtuTN3pnfI6if0p+2b7L6wEMN65cr7BcK1IBjs1Q==
X-Received: by 2002:a05:620a:4415:b0:789:e247:1d7e with SMTP id
 v21-20020a05620a441500b00789e2471d7emr3862842qkp.43.1710513027083; 
 Fri, 15 Mar 2024 07:30:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 dc33-20020a05620a522100b007885cd1c058sm2106481qkb.103.2024.03.15.07.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 07:30:26 -0700 (PDT)
Message-ID: <0f6f0a06-7ec7-4ad9-a47e-2466a18dbf50@redhat.com>
Date: Fri, 15 Mar 2024 15:30:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <87le6omw0d.fsf@suse.de>
 <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
 <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com> <874jdbmst4.fsf@suse.de>
 <ZfByYiL3Gl9d9u7h@x1n> <87wmq7l2xx.fsf@suse.de>
 <b9cb5c16-59a4-4cdc-9d12-6d7c2306b4ff@redhat.com> <ZfQqpK0xCwygYYho@x1n>
 <c946ae1f-3315-496e-b316-33343e43830f@redhat.com> <ZfRIc1l_PElCVNtL@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZfRIc1l_PElCVNtL@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/15/24 14:09, Peter Xu wrote:
> On Fri, Mar 15, 2024 at 01:20:49PM +0100, Cédric Le Goater wrote:
>> On 3/15/24 12:01, Peter Xu wrote:
>>> On Fri, Mar 15, 2024 at 11:17:45AM +0100, Cédric Le Goater wrote:
>>>>> migrate_set_state is also unintuitive because it ignores invalid state
>>>>> transitions and we've been using that property to deal with special
>>>>> states such as POSTCOPY_PAUSED and FAILED:
>>>>>
>>>>> - After the migration goes into POSTCOPY_PAUSED, the resumed migration's
>>>>>      migrate_init() will try to set the state NONE->SETUP, which is not
>>>>>      valid.
>>>>>
>>>>> - After save_setup fails, the migration goes into FAILED, but wait_unplug
>>>>>      will try to transition SETUP->ACTIVE, which is also not valid.
>>>>>
>>>>
>>>> I am not sure I understand what the plan is. Both solutions are problematic
>>>> regarding the state transitions.
>>>>
>>>> Should we consider that waiting for failover devices to unplug is an internal
>>>> step of the SETUP phase not transitioning to ACTIVE ?
>>>
>>> If to unblock this series, IIUC the simplest solution is to do what Fabiano
>>> suggested, that we move qemu_savevm_wait_unplug() to be before the check of
>>> setup() ret.
>>
>> The simplest is IMHO moving qemu_savevm_wait_unplug() before
>> qemu_savevm_state_setup() and leave patch 10 is unchanged. See
>> below the extra patch. It looks much cleaner than what we have
>> today.
> 
> Yes it looks cleaner indeed, it's just that then we'll have one more
> possible state conversions like SETUP->UNPLUG->SETUP.  I'd say it's fine,
> but let's also copy Laruent and Laine if it's going to be posted formally.

OK. I just sent the alternative implementation. The code looks a little
ugly  :

     bql_lock();                                                           |
     qemu_savevm_state_header(s->to_dst_file);                             |
     ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);            | in SETUP state
     bql_unlock();                                                         |
                                                                           |
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,                    | SETUP -> ACTIVE transition
                                MIGRATION_STATUS_ACTIVE);                  |
                                                                           |
     /*                                                                    |
      * Handle SETUP failures after waiting for virtio-net-failover        |
      * devices to unplug. This to preserve migration state transitions.   |
      */                                                                   |
     if (ret) {                                                            |
         migrate_set_error(s, local_err);                                  | handling SETUP errors in ACTIVE
         error_free(local_err);                                            |
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,             |
                           MIGRATION_STATUS_FAILED);                       |
         goto fail_setup;                                                  |
     }                                                                     |
                                                                           |
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;     | SETUP duration
                                                                           |
     trace_migration_thread_setup_complete();                              | SETUP trace event



Thanks,

C.


