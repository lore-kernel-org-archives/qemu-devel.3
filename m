Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35C3C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5Zk-00022N-NZ; Mon, 04 Mar 2024 05:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rh5Zj-00020p-HQ
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:29:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rh5Zh-0001TL-4T
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709548176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BvFzoqRS6hcA6JSl8E1hjD9XSMMgfoHw5tRUqmhwpdA=;
 b=OuXZCDKkvG69QvFWnnPYQqq63esGw1csDUGwk8u44MkGBautgpBvodiWjR6FDbWBkcTuiA
 y1u1j4bQBfhoKwyT5evh8GeLr6DC1NERDEUs0TQsbY64Ugt7EJLeplbhlO6AdgyH7YYFsz
 CiP2Q9ZT70VdE4iAqADlVu5BVExNZao=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-z-dAJDW1M-Cbe5Wj_plgBQ-1; Mon, 04 Mar 2024 05:29:34 -0500
X-MC-Unique: z-dAJDW1M-Cbe5Wj_plgBQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-42ef69e3758so3964831cf.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 02:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709548174; x=1710152974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BvFzoqRS6hcA6JSl8E1hjD9XSMMgfoHw5tRUqmhwpdA=;
 b=Q4V8q9GWIWYkRUs/EA1C/Otio38ORo6nIFy7ixpABhDTr2m6V3UKCLdso60VJ3tGa2
 xQkN/5ty8jV1j87zuQZZRISKbRtzWce10tonP/MohPfilLPue6BE2+A5W7P0Kg+uwSls
 opH6x84GbZJIOS3U+D3QSEb3a+MkrDWLtezu0I693c0Ujh2Th4WDi03+Bda3QZxr5WGH
 0PrmMh+9YelRmOa3VxwgZ+QhT3HZUgjJMgd8RN1lfod24aMNTOVDD7m3H7NDA0zIj+AV
 +7/TLUtG3qtCJQKPbYWBpGEknLbVIMjxMdigj4+eDTSPu1aQxWix0Euu4yiHpXywgC6w
 J6wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9AyYJDGYZBooF79ZH//VzcokBdzemaAQYGx7LqSefmZQYDFH3NdNisAnsgjzZM2y4bcFbEYphbG1DL/1Ue2bTwUEfNMs=
X-Gm-Message-State: AOJu0YyhVnUk4KFS9aCKrQiw5On9lOrr0/3Uv/LvbDlAJG/e5Y3tTB16
 84tQ5U0UPUGYqrZpaegvybym8V3a8FodEsR35Xd8x7fhciORxcuhKIJJWAydtpcetf//NwYs/EG
 91tktSPzvdqmDLVVZg+Pil3W0mtFIJapl+6mbuiWaL5HWkKkaG6sY
X-Received: by 2002:a05:622a:308:b0:42e:ebc5:dc95 with SMTP id
 q8-20020a05622a030800b0042eebc5dc95mr5442697qtw.59.1709548173794; 
 Mon, 04 Mar 2024 02:29:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVZn8iMpsajPXUfGmBt+9z8H3TwUAu3gePBEFIZhrh/bmry2Voaeq5RLpT970uhnPIjbnXlQ==
X-Received: by 2002:a05:622a:308:b0:42e:ebc5:dc95 with SMTP id
 q8-20020a05622a030800b0042eebc5dc95mr5442684qtw.59.1709548173445; 
 Mon, 04 Mar 2024 02:29:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 a17-20020ac84d91000000b0042c805767acsm4258074qtw.23.2024.03.04.02.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 02:29:32 -0800 (PST)
Message-ID: <fef6c0bd-b8c5-4715-96a6-092b46d75fbe@redhat.com>
Date: Mon, 4 Mar 2024 11:29:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/21] migration: Add documentation for SaveVMHandlers
Content-Language: en-US, fr
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-4-clg@redhat.com>
 <9dcfbafd-407f-4b23-a4ff-049c5bfcde65@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <9dcfbafd-407f-4b23-a4ff-049c5bfcde65@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/4/24 10:05, Avihai Horon wrote:
> Hi Cedric,
> 
> A few nits below.

Just in time for v3 I was about to send ! I will include these
suggestions.

Thanks,

C.




> 
> On 27/02/2024 20:03, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> The SaveVMHandlers structure is still in use for complex subsystems
>> and devices. Document the handlers since we are going to modify a few
>> later.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/migration/register.h | 257 +++++++++++++++++++++++++++++++----
>>   1 file changed, 231 insertions(+), 26 deletions(-)
>>
>> diff --git a/include/migration/register.h b/include/migration/register.h
>> index 2e6a7d766e62f64940086b7b511249c9ff21fa62..2cc71ec45f65bf2884c9e7a823d2968752f15c20 100644
>> --- a/include/migration/register.h
>> +++ b/include/migration/register.h
>> @@ -16,30 +16,129 @@
>>
>>   #include "hw/vmstate-if.h"
>>
>> +/**
>> + * struct SaveVMHandlers: handler structure to finely control
>> + * migration of complex subsystems and devices, such as RAM, block and
>> + * VFIO.
>> + */
>>   typedef struct SaveVMHandlers {
>> -    /* This runs inside the BQL.  */
>> +
>> +    /* The following handlers runs inside the BQL. */
> 
> s/runs/run
> 
>> +
>> +    /**
>> +     * @save_state
>> +     *
>> +     * Saves state section on the source using the latest state format
>> +     * version.
>> +     *
>> +     * Legacy method. Should be deprecated when all users are ported
>> +     * to VMState.
>> +     *
>> +     * @f: QEMUFile where to send the data
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     */
>>       void (*save_state)(QEMUFile *f, void *opaque);
>>
>> -    /*
>> -     * save_prepare is called early, even before migration starts, and can be
>> -     * used to perform early checks.
>> +    /**
>> +     * @save_prepare
>> +     *
>> +     * Called early, even before migration starts, and can be used to
>> +     * perform early checks.
>> +     *
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     * @errp: pointer to Error*, to store an error if it happens.
>> +     *
>> +     * Returns zero to indicate success and negative for error
>>        */
>>       int (*save_prepare)(void *opaque, Error **errp);
>> +
>> +    /**
>> +     * @save_setup
>> +     *
>> +     * Initializes the data structures on the source and transmits
>> +     * first section containing information on the device
>> +     *
>> +     * @f: QEMUFile where to send the data
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>>       int (*save_setup)(QEMUFile *f, void *opaque);
>> +
>> +    /**
>> +     * @save_cleanup
>> +     *
>> +     * Performs save related cleanup
> 
> Use save_setup phrasing?
> Uninitializes the data structures on the source.
> 
>> +     *
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     *
>> +     * Returns zero to indicate success and negative for error
> 
> This can be dropped as it's a void function.
> 
>> +     */
>>       void (*save_cleanup)(void *opaque);
>> +
>> +    /**
>> +     * @save_live_complete_postcopy
>> +     *
>> +     * Called at the end of postcopy for all postcopyiable devices.
> 
> s/postcopyiable/postcopyable> 
>> +     *
>> +     * @f: QEMUFile where to send the data
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>>       int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
>> +
>> +    /**
>> +     * @save_live_complete_precopy
>> +     *
>> +     * Transmits the last section for the device containing any
>> +     * remaining data.
>> +     *
>> +     * @f: QEMUFile where to send the data
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>>       int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
>>
>>       /* This runs both outside and inside the BQL.  */
>> +
>> +    /**
>> +     * @is_active
>> +     *
>> +     * Will skip a state section if not active
>> +     *
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     *
>> +     * Returns true if state section is active else false
>> +     */
>>       bool (*is_active)(void *opaque);
>> +
>> +    /**
>> +     * @has_postcopy
>> +     *
>> +     * checks if a device supports postcopy
> 
> s/checks/Checks
> 
>> +     *
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     *
>> +     * Returns true for postcopy support else false
>> +     */
>>       bool (*has_postcopy)(void *opaque);
>>
>> -    /* is_active_iterate
>> -     * If it is not NULL then qemu_savevm_state_iterate will skip iteration if
>> -     * it returns false. For example, it is needed for only-postcopy-states,
>> -     * which needs to be handled by qemu_savevm_state_setup and
>> -     * qemu_savevm_state_pending, but do not need iterations until not in
>> -     * postcopy stage.
>> +    /**
>> +     * @is_active_iterate
>> +     *
>> +     * As #SaveVMHandlers.is_active(), will skip an inactive state
>> +     * section in qemu_savevm_state_iterate.
>> +     *
>> +     * For example, it is needed for only-postcopy-states, which needs
>> +     * to be handled by qemu_savevm_state_setup() and
>> +     * qemu_savevm_state_pending(), but do not need iterations until
>> +     * not in postcopy stage.
>> +     *
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     *
>> +     * Returns true if state section is active else false
>>        */
>>       bool (*is_active_iterate)(void *opaque);
>>
>> @@ -48,44 +147,150 @@ typedef struct SaveVMHandlers {
>>        * use data that is local to the migration thread or protected
>>        * by other locks.
>>        */
>> +
>> +    /**
>> +     * @save_live_iterate
>> +     *
>> +     * Should send a chunk of data until the point that stream
>> +     * bandwidth limits tell it to stop. Each call generates one
>> +     * section.
>> +     *
>> +     * @f: QEMUFile where to send the data
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     *
>> +     * Returns zero to indicate success and negative for error
> 
> 0 indicates that there is still more data to send, 1 indicates that there is no more data to send and negative indicates error.
> 
>> +     */
>>       int (*save_live_iterate)(QEMUFile *f, void *opaque);
>>
>>       /* This runs outside the BQL!  */
>> -    /* Note for save_live_pending:
>> -     * must_precopy:
>> -     * - must be migrated in precopy or in stopped state
>> -     * - i.e. must be migrated before target start
>> -     *
>> -     * can_postcopy:
>> -     * - can migrate in postcopy or in stopped state
>> -     * - i.e. can migrate after target start
>> -     * - some can also be migrated during precopy (RAM)
>> -     * - some must be migrated after source stops (block-dirty-bitmap)
>> -     *
>> -     * Sum of can_postcopy and must_postcopy is the whole amount of
>> +
>> +    /**
>> +     * @state_pending_estimate
>> +     *
>> +     * This estimates the remaining data to transfer
>> +     *
>> +     * Sum of @can_postcopy and @must_postcopy is the whole amount of
>>        * pending data.
>> +     *
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     * @must_precopy: amount of data that must be migrated in precopy
>> +     *                or in stopped state, i.e. that must be migrated
>> +     *                before target start.
>> +     * @can_postcopy: amount of data that can be migrated in postcopy
>> +     *                or in stopped state, i.e. after target start.
>> +     *                Some can also be migrated during precopy (RAM).
>> +     *                Some must be migrated after source stops
>> +     *                (block-dirty-bitmap)
>>        */
>> -    /* This estimates the remaining data to transfer */
>>       void (*state_pending_estimate)(void *opaque, uint64_t *must_precopy,
>>                                      uint64_t *can_postcopy);
>> -    /* This calculate the exact remaining data to transfer */
>> +
>> +    /**
>> +     * @state_pending_exact
>> +     *
>> +     * This calculate the exact remaining data to transfer
> 
> s/calculate/calculates
> 
>> +     *
>> +     * Sum of @can_postcopy and @must_postcopy is the whole amount of
>> +     * pending data.
>> +     *
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     * @must_precopy: amount of data that must be migrated in precopy
>> +     *                or in stopped state, i.e. that must be migrated
>> +     *                before target start.
>> +     * @can_postcopy: amount of data that can be migrated in postcopy
>> +     *                or in stopped state, i.e. after target start.
>> +     *                Some can also be migrated during precopy (RAM).
>> +     *                Some must be migrated after source stops
>> +     *                (block-dirty-bitmap)
>> +     */
>>       void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
>>                                   uint64_t *can_postcopy);
>> +
>> +    /**
>> +     * @load_state
>> +     *
>> +     * Load sections generated by any of the save functions that
>> +     * generate sections.
>> +     *
>> +     * Legacy method. Should be deprecated when all users are ported
>> +     * to VMState.
>> +     *
>> +     * @f: QEMUFile where to receive the data
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     * @version_id: the maximum version_id supported
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>>       int (*load_state)(QEMUFile *f, void *opaque, int version_id);
>> +
>> +    /**
>> +     * @load_setup
>> +     *
>> +     * Initializes the data structures on the destination.
>> +     *
>> +     * @f: QEMUFile where to receive the data
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>>       int (*load_setup)(QEMUFile *f, void *opaque);
>> +
>> +    /**
>> +     * @load_cleanup
>> +     *
>> +     * Performs cleanup of load data structures
> 
> Use load_setup phrasing?
> Uninitializes the data structures on the destination.
> 
>> +     *
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>>       int (*load_cleanup)(void *opaque);
>> -    /* Called when postcopy migration wants to resume from failure */
>> +
>> +    /**
>> +     * @resume_prepare
>> +     *
>> +     * Called when postcopy migration wants to resume from failure
>> +     *
>> +     * @s: Current migration state
>> +     * @opaque: data pointer passed to register_savevm_live()
>> +     *
>> +     * Returns zero to indicate success and negative for error
>> +     */
>>       int (*resume_prepare)(MigrationState *s, void *opaque);
>> -    /* Checks if switchover ack should be used. Called only in dest */
>> +
>> +    /**
>> +     * @switchover_ack_needed
>> +     *
>> +     * Checks if switchover ack should be used. Called only on
>> +     * destination.
>> +     *
>> +     * @opaque: data pointer passed to register_savevm_live()
> 
> Add:
> Returns true if switchover ack should be used and false otherwise
> 
>> +     */
>>       bool (*switchover_ack_needed)(void *opaque);
>>   } SaveVMHandlers;
>>
>> +/**
>> + * register_savevm_live: Register a set of custom migration handlers
>> + *
>> + * @idstr: state section identifier
>> + * @instance_id: instance id
>> + * @version_id: version id supported
>> + * @ops: SaveVMHandlers structurex
> 
> s/structurex/structure
> 
>> + * @opaque: data pointer passed SaveVMHandlers handlers
> 
> s/passed SaveVMHandlers/passed to SaveVMHandlers
> 
> Thanks.
> 
>> + */
>>   int register_savevm_live(const char *idstr,
>>                            uint32_t instance_id,
>>                            int version_id,
>>                            const SaveVMHandlers *ops,
>>                            void *opaque);
>>
>> +/**
>> + * unregister_savevm: Unregister custom migration handlers
>> + *
>> + * @obj: object associated with state section
>> + * @idstr:  state section identifier
>> + * @opaque: data pointer passed to register_savevm_live()
>> + */
>>   void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque);
>>
>>   #endif
>> -- 
>> 2.43.2
>>
> 


