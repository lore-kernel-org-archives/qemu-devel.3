Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A0AC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 14:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulqQu-0005Fv-Sc; Tue, 12 Aug 2025 10:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulqQp-0005Fl-Po
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulqQf-0006NR-3z
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755010597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HPVOIfTAgDtIBQ0XZVeGui2p5hA3M1GqY+xjrokESos=;
 b=AGKX2MUybIJX5AQOAP/vX03I5AC5ChvZIvW+OrKk4O3GPX1cb0hYUfP/munncQJ+C9hrBR
 NMVx+2UsZKPdNviwKR2WSk+zgYkiK7W12KUo0IfzhP+/K0xLczOnPBWIvSa/E7NbqhLvcW
 Oo4v9JaWvRGoG36G9NyzxZ6ph7uXe5I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-qzT26DO1OBSKLhYyPz-aGw-1; Tue, 12 Aug 2025 10:56:36 -0400
X-MC-Unique: qzT26DO1OBSKLhYyPz-aGw-1
X-Mimecast-MFC-AGG-ID: qzT26DO1OBSKLhYyPz-aGw_1755010596
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7e8100bef92so1219055985a.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 07:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755010595; x=1755615395;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HPVOIfTAgDtIBQ0XZVeGui2p5hA3M1GqY+xjrokESos=;
 b=jnBla+lGQa5k/NLxtqeHyLpQHCAsCwQmzKB2d8zogBmXqmeX1Nx0nAPoeQQqnQSrWy
 OZqDbcvKhxIe22cfkCFmD6Iq35pSQKLql/WfJ6j0hXNuUflYxHF4ups7+Y/nZg7S8ocj
 GE5vktUq8evOlwMQcHO2vllbIZQIeImVlZOwpfDBpx/WRABbr9BeeD3ZI9Ea/b+cnwH8
 ++dwmX2L3QvtuwxkIdFNgYKUfON790M+Rs56cR4zLO2hGt9/hJ8DNcZN2heMebhBeKfb
 bxVcjzyPtaVmMvJsB1bvgYwgHkeS1FBzDkC6a73SRIOI+tkUot56KrWikhAQNYSThhAI
 bzTA==
X-Gm-Message-State: AOJu0YwOvJqp1XONF5WlgMpr8utAPhTCbAyVKA0RHyUP3pVvp/1hotMk
 gYM4F7CdtCM6n0Lc7aveukSQo8rMBdifOQeqLiqDilzX0HtrU5q+Rbo/WoMOXFnSc9trmvvPa2A
 e4HwrN0kw3wclXfohqLsHBTKp5wH64fKj9I0Dl03DhQWhWITbOthrttGxJwhIUzed
X-Gm-Gg: ASbGncuhvZVhdwI9Rwfzep/vEQpT5xy7lkoP1RHqoUi+SS5kktNUjlTnqJ0wfJQKZ/z
 LVIqmyM5/z7j2miWM5pokK2Ia+LxtAhxwd/6MArn0JodZ+IXwTUrmpTb2aUOt5ex5B6rdhq8IJz
 E16+eYXkqft10nPSMxEcYx0TxxKM6VZgwOvuyMaW6aTk1Cfp4TKdfhschDefPJ0hv6HguVRIoD+
 W5ERgt1U2QD908WYvnHn9qoRS5JEIs4zKt4qC+biu0jzgI2wTlkih/7ym/w3bhvxjoI2luNKE6e
 TN0C+G3i+X+zgc52dSKBOscZt1IiWHt46yb3Ty2Ssm7xmT9sajmdURf1KQYV/uvwpQv0auZXVA0
 EwQ==
X-Received: by 2002:a05:620a:2147:b0:7e3:477d:53b5 with SMTP id
 af79cd13be357-7e86446673fmr468085a.13.1755010595442; 
 Tue, 12 Aug 2025 07:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGybWucUVIyijX8SuiHLjDTwglw66S733txzW75VIGFms4ploITvEa3o9goT9cGv4LpMf8J1A==
X-Received: by 2002:a05:620a:2147:b0:7e3:477d:53b5 with SMTP id
 af79cd13be357-7e86446673fmr463885a.13.1755010594969; 
 Tue, 12 Aug 2025 07:56:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e822b6c47esm906825785a.39.2025.08.12.07.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 07:56:34 -0700 (PDT)
Message-ID: <f6165e17-a926-4a59-9b59-2dd6853f20a6@redhat.com>
Date: Tue, 12 Aug 2025 16:56:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] VFIO migration will not be aborted in a corner scenario
To: Avihai Horon <avihaih@nvidia.com>, Kunkun Jiang <jiangkunkun@huawei.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 wanghaibin.wang@huawei.com, Zenghui Yu <yuzenghui@huawei.com>
References: <6f64724d-7869-1283-bb75-193c7fba5576@huawei.com>
 <f6c1cff4-a0ca-436a-b8d7-3d19ce49e848@redhat.com>
 <506cab2c-35aa-4c68-ba94-b26ba1b315bc@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <506cab2c-35aa-4c68-ba94-b26ba1b315bc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/12/25 16:08, Avihai Horon wrote:
> 
> On 11/08/2025 19:34, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hello,
>>
>> + Avihai
>>
>> On 8/11/25 18:02, Kunkun Jiang wrote:
>>> Hi all,
>>>
>>> While testing VFIO migration, I encountered an corner scenario case:
>>> VFIO migration will not be aborted when the vfio device of dst-vm fails to transition from RESUMING to RUNNING state in vfio_vmstate_change.
>>>
>>> I saw the comments in the vfio_vmstate_change but I don't understand why no action is taken for this situation.
>>
>> There is error handling in vfio_vmstate_change() :
>>
>>         /*
>>          * Migration should be aborted in this case, but vm_state_notify()
>>          * currently does not support reporting failures.
>>          */
>>         migration_file_set_error(ret, local_err);
> 
> Hmm, I think this only sets the error on src. On dst we don't have MigrationState->to_dst_file, so we end up just reporting the error.
> But even if we did set it, no one is checking if there is a migration error after vm_start() is called in process_incoming_migration_bh().
> 
>>
>>> Allowing the live migration process to continue could cause unrecoverable damage to the VM.
> 
> What do you mean by unrecoverable damage to the VM?
> If RESUMING->RUNNING transition fails, would a VFIO reset recover the device and allow the VM to continue operation with damage limited only to the VFIO device?
> 
>>> In this case, can we directly exit the dst-vm? Through the return-path mechanism, the src-vm can continue to run.
>>>
>>> Looking forward to your reply.
>>
> The straightforward solution, as you suggested, is to exit dst upon error in RESUMING->RUNNING transition and notify about it to src through the return-path.
> However, I am not sure if failing the migration after vm_start() on dst is a bit late (as we start vCPUs and do migration_block_activate, etc.).
> 
> But I can think of another way to solve this, hopefully simpler.
> According to VFIO migration uAPI [1]:
>   * RESUMING -> STOP
>   *   Leaving RESUMING terminates a data transfer session and indicates the
>   *   device should complete processing of the data delivered by write(). The
>   *   kernel migration driver should complete the incorporation of data written
>   *   to the data transfer FD into the device internal state and perform
>   *   final validity and consistency checking of the new device state. If the
>   *   user provided data is found to be incomplete, inconsistent, or otherwise
>   *   invalid, the migration driver must fail the SET_STATE ioctl and
>   *   optionally go to the ERROR state as described below.
> 
> So, IIUC, we can add an explicit RESUMING->STOP transition [2] after the device config is loaded (which is the last data the device is expected to receive).
> If this transition fails, it means something was wrong with migration, and we can send src an error msg via return-path (and not continue to vm_start()).
> 
> Maybe this approach is less complicated than the first one, and it will also work if src VM was paused prior migration.
> I already tested some POC and it seems to be working (at least with an artificial error i injected in RESUMING->STOP transition).
> Kunkun, can you apply the following diff [3] and check if this solves the issue?
> 
> And in general, what do you think? Should we go with this approach or do you have other ideas?
> 
> Thanks.
> 
> [1] https://elixir.bootlin.com/linux/v6.16/source/include/uapi/linux/vfio.h#L1099
> [2] Today RESUMING->STOP is done implicitly by the VFIO driver as part of RESUMING->RUNNING transition.
> [3]

Avihai,

Could you please send an RFC patch with Peter and Fabiano in cc: ?
This will help to discuss the proposal and keep track of the issue.


Kunkun Jiang,

Could you please share details on your environment ?

Thanks,

C.


