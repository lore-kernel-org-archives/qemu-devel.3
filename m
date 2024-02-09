Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CD3C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYNI5-0002Or-VG; Fri, 09 Feb 2024 04:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rYNI4-0002Oi-49
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:35:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rYNHo-000762-NY
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707471307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CI9wnUlSYwl907bEUNI4LFnRb5QRLE5EzgZRZcfKM+o=;
 b=U7BIBDU/Xe0wcrWC1DnC6sr9Znj10Si3bQMFC6QyESVLaz0ZpDzQ9Y/qDM6CcCMnmCX2PB
 qrhnA77nsNKjs5lM2YCI/zcq69aKqr88M8MMbLbAdB8RJvsawOz8kW0CI5Px33K9R0k2Tq
 QttbO7xmS4uLOAh+C90UFeGpnJm0H24=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-xEgUehUSMj2xnXtRkylsQg-1; Fri, 09 Feb 2024 04:35:05 -0500
X-MC-Unique: xEgUehUSMj2xnXtRkylsQg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-42c53eca0a0so8720361cf.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707471304; x=1708076104;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CI9wnUlSYwl907bEUNI4LFnRb5QRLE5EzgZRZcfKM+o=;
 b=P7yz3+46uxXGJ4oSfJx8tFFb+DPX2bpSXZNyUC3t33A8muUbA710heCmNCfxu5yYtw
 SZUN4T7j1ugg4d90LWZkglRIjiuwmrq9/Onq23llclkTBmF7o/BPAnG4OayXhZFjIj1f
 UN/cKNmIGFsT/lAfsbw1R0sP0Ny3vhqPc3lmgnilj2oAkB6OK3RcfbIKPpZK8HInSePK
 Xjp/j+uVdHI9W68jjCGXNdniv1F9ECXN2mJMsgHEb063gS39gAhI9Rg+7nsOwQ6SQ/ed
 TqHX84+S7nrvGx2530jsCi+Trhim7oJIpfIZKQCJsO2JFVq9qnVhsl/dZcP2lTCjFZCm
 AFTg==
X-Gm-Message-State: AOJu0Yw+WMW0a4X+EAcAAbjEnCM5ha+cYDPvcpZKst4eIu3hxIyVB9gU
 qhh/7byF2quVZDVVM9ku3xv14by2xokNy01o+1ScJNv8UvbpddVwv1j+dZfSe9Qz3bu0Gaf5Xl7
 9wZrpzcFIIXPT8/pGPPscEigWMXZZIu3WNjJqjkayIgai/nZlFOM4
X-Received: by 2002:a05:622a:204:b0:42a:4350:64c7 with SMTP id
 b4-20020a05622a020400b0042a435064c7mr964690qtx.68.1707471304574; 
 Fri, 09 Feb 2024 01:35:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMaUzLpd6frxA3YakzANu34/19MDryptR8hgBY/hB+UqpT9znAzJ77wH6pQ2vAoTJQ2xjU3A==
X-Received: by 2002:a05:622a:204:b0:42a:4350:64c7 with SMTP id
 b4-20020a05622a020400b0042a435064c7mr964677qtx.68.1707471304296; 
 Fri, 09 Feb 2024 01:35:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXWGl5cz0ceKnc9Ppl7a7cItBAd46BvhZAeabnXsXOVl+B5EmKPgXBq2OnnrL2c6DY4LnN4DaUX944mBtS4xhXccjNb3iaSiFzs3+NazPO/dPaqGgMJLN0a5oPS
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 o19-20020ac85553000000b0042a31bc98b9sm544391qtr.24.2024.02.09.01.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 01:35:03 -0800 (PST)
Message-ID: <8ef5339a-2fb1-43a3-9091-534af48cf02f@redhat.com>
Date: Fri, 9 Feb 2024 10:35:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] migration: Add Error** argument to .load_setup()
 handler
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-3-clg@redhat.com> <ZcRY_-BE_vCwK68H@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZcRY_-BE_vCwK68H@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2/8/24 05:30, Peter Xu wrote:
> On Wed, Feb 07, 2024 at 02:33:35PM +0100, Cédric Le Goater wrote:
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 136c237f4079f68d4e578cf1c72eec2efc815bc8..8dac9bac2fe8b8c19e102c771a7ef6e976252906 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -3498,7 +3498,7 @@ void colo_release_ram_cache(void)
>>    * @f: QEMUFile where to receive the data
>>    * @opaque: RAMState pointer
> 
> Another one may need touch up..
> 
>>    */
>> -static int ram_load_setup(QEMUFile *f, void *opaque)
>> +static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>>       xbzrle_load_setup();
>>       ramblock_recv_map_init();
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index f2ae799bad13e631bccf733a34c3a8fd22e8dd48..990f4249a26d28117ee365d8b20fc5bbca0d43d6 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2737,7 +2737,7 @@ static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
>>       trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
>>   }
>>   
>> -static int qemu_loadvm_state_setup(QEMUFile *f)
>> +static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
>>   {
>>       SaveStateEntry *se;
>>       int ret;
>> @@ -2753,10 +2753,11 @@ static int qemu_loadvm_state_setup(QEMUFile *f)
>>               }
>>           }
>>   
>> -        ret = se->ops->load_setup(f, se->opaque);
>> +        ret = se->ops->load_setup(f, se->opaque, errp);
>>           if (ret < 0) {
>> +            error_prepend(errp, "Load state of device %s failed: ",
>> +                          se->idstr);
>>               qemu_file_set_error(f, ret);
> 
> Do we also want to switch to _set_error_obj()? 

yes. possible.

> Or even use migrate_set_error() 

It seems so and may be even remove it completely.

What we could do first is add an Errp ** argument to qemu_loadvm_state()
which would improve qmp_xen_load_devices_state() and load_snapshot().
It is less obvious for process_incoming_migration_co().

> (the latter may apply to previous patch too if it works)?

It seems safe to use migrate_set_error for both migration_thread() and
bg_migration_thread() because migration_detect_error() is called after
calling qemu_savevm_state_setup().

However, qemu_savevm_state() relies only on qemu_file_get_error() and
there would be a problem there I think.

Thanks,

C.


> 
>> -            error_report("Load state of device %s failed", se->idstr);
>>               return ret;
>>           }
>>       }
>> @@ -2937,7 +2938,8 @@ int qemu_loadvm_state(QEMUFile *f)
>>           return ret;
>>       }
>>   
>> -    if (qemu_loadvm_state_setup(f) != 0) {
>> +    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
>> +        error_report_err(local_err);
>>           return -EINVAL;
>>       }
>>   
>> -- 
>> 2.43.0
>>
>>
> 


