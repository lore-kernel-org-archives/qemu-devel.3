Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783B8C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0xD-0005Im-1L; Tue, 12 Mar 2024 08:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk0x6-0005Hy-0P
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk0x2-0001PP-Bc
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710245387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0S74ou4gcQVDiTW98h84qJf5ql6dvj7Eo2S7TP4R0A=;
 b=G/k01H3ySwt1NY9ggJohVOV7m7sFcIKliiIacDJMLpMZoS4lo6TSijLyg18A2KTgroodfs
 BKF5idXWwA+OYkADGD9AanUqGUKH06q797GfLiFOVdPdAvCfKatTdMv3G8Z9Ey7TqRFMVn
 +VLQasY9C3GNUwS6gU9LVvwg1+vjTEo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-LuKumqeeNEulYVgna_FKCA-1; Tue, 12 Mar 2024 08:09:46 -0400
X-MC-Unique: LuKumqeeNEulYVgna_FKCA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513c1e823ffso489252e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 05:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710245385; x=1710850185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W0S74ou4gcQVDiTW98h84qJf5ql6dvj7Eo2S7TP4R0A=;
 b=kvJqeOa4GHSxkiCKo7LjYIljFKK1gcK/N+icm2MBKQor93DBBsn1mp9Wldjifms2Cv
 rtO06yew+CuF6g+QwaFHwImbDYQr+KrYIj/4lNV+guh0kO3uoxV06Preu1uqGP8sfSaZ
 04YJ9t1/W2vhbhiLUEsys8/6KHuPnc6QCiCCZgRKKDwjyIiT0IKOoD9SEYhKwMTSfdvz
 fKwfls1Ey2o+B+tV1fC/i5WcmTnQUo7UyO3ljeh00BMr6Ux7Z3tErgooSPIa3ovuWv69
 Vw9PxqMIYisPglFFfTLxiHsLuySh/HFolhrXIb68AjRASgYEcqr3NPPPiUkFcr2XDGN/
 BwaA==
X-Gm-Message-State: AOJu0YxE3dd9U4eY9OtR5p7JBwEc6tclb+37Bu8s08/LdlTTffiR3y5s
 8lWI6PQtANaIaoI4wLYmWst1bBsZAekFOtmjVol3GLvhMCJLqiTgnq+3AuLMGBxanYtZbn9zJGv
 2F+N/mM1PwABFwLH1p9KljNH4e5cNpm8ZBBJ9y0W6lIQ0AA2MXGMC
X-Received: by 2002:a19:e04e:0:b0:513:45b6:18b2 with SMTP id
 g14-20020a19e04e000000b0051345b618b2mr6016824lfj.44.1710245384694; 
 Tue, 12 Mar 2024 05:09:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRk+/Gp8niqYvlym62LR2RO+Rm6blv0wPAsqXkPtcmfVjJRRDCXSuldMyvkgkVma8AWf16hw==
X-Received: by 2002:a19:e04e:0:b0:513:45b6:18b2 with SMTP id
 g14-20020a19e04e000000b0051345b618b2mr6016807lfj.44.1710245384340; 
 Tue, 12 Mar 2024 05:09:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 bj28-20020a0560001e1c00b0033e7de97214sm9059807wrb.40.2024.03.12.05.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 05:09:43 -0700 (PDT)
Message-ID: <5f727597-3a2c-45c4-aab1-f4ee4cedfb20@redhat.com>
Date: Tue, 12 Mar 2024 13:09:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/25] migration: Improve error reporting
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com> <ZerJDAdaakTCtECF@x1n>
 <Ze9ogyFZT73gB-La@x1n> <0a1c329e-e6ab-4329-815d-e6be3e64c2ae@redhat.com>
 <5ca62745-deae-41b5-a9ef-2269a7220830@redhat.com> <ZfBBnWcBTFqlH2wf@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZfBBnWcBTFqlH2wf@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

On 3/12/24 12:50, Peter Xu wrote:
> On Tue, Mar 12, 2024 at 10:58:51AM +0100, Cédric Le Goater wrote:
>> On 3/12/24 08:16, Cédric Le Goater wrote:
>>> On 3/11/24 21:24, Peter Xu wrote:
>>>> On Fri, Mar 08, 2024 at 04:15:08PM +0800, Peter Xu wrote:
>>>>> On Wed, Mar 06, 2024 at 02:34:15PM +0100, Cédric Le Goater wrote:
>>>>>> * [1-4] already queued in migration-next.
>>>>>>     migration: Report error when shutdown fails
>>>>>>     migration: Remove SaveStateHandler and LoadStateHandler typedefs
>>>>>>     migration: Add documentation for SaveVMHandlers
>>>>>>     migration: Do not call PRECOPY_NOTIFY_SETUP notifiers in case of error
>>>>>> * [5-9] are prequisite changes in other components related to the
>>>>>>     migration save_setup() handler. They make sure a failure is not
>>>>>>     returned without setting an error.
>>>>>>     s390/stattrib: Add Error** argument to set_migrationmode() handler
>>>>>>     vfio: Always report an error in vfio_save_setup()
>>>>>>     migration: Always report an error in block_save_setup()
>>>>>>     migration: Always report an error in ram_save_setup()
>>>>>>     migration: Add Error** argument to vmstate_save()
>>>>>>
>>>>>> * [10-15] are the core changes in migration and memory components to
>>>>>>     propagate an error reported in a save_setup() handler.
>>>>>>
>>>>>>     migration: Add Error** argument to qemu_savevm_state_setup()
>>>>>>     migration: Add Error** argument to .save_setup() handler
>>>>>>     migration: Add Error** argument to .load_setup() handler
>>>>>
>>>>> Further queued 5-12 in migration-staging (until here), thanks.
>>>>
>>>> Just to keep a record: due to the virtio failover test failure and the
>>>> other block migration uncertainty in patch 7 (in which case we may want to
>>>> have a fix on sectors==0 case), I unqueued this chunk for 9.0.
>>>
>>> ok. I will ask the block folks for help to understand if sectors==0
>>> is also an error in the save_setup context. May be  we can still
>>> merge these in 9.0 cycle.
>>
>> I discussed with Kevin and sectors==0 is not an error case, the loop
>> should simply continue. That said, commit 66db46ca83b8 ("migration:
>> Deprecate block migration") would let us remove all that code in
>> the next cycle which is even simpler.
> 
> Thanks for taking a look.  I can try to have a look at removing block
> migration in 9.1.

Just sent a 9.0 fix for the block part.

> Regarding to the failover failure - I still think what you posted as a
> "hack" could be an official patch.  Do you plan to send it?  
> Or do you have anything else in mind?

I was hoping to fix the test case instead. I can try to improve the hack
I sent this afternoon.

Thanks,

C.


> 
> For 9.0, we're missing softfreeze. IIUC we can only merge things like
> regression fixes, documentation updates, some test changess, etc.. into rc
> windows. With QEMU's heavy reliance on CI now I don't even think most test
> case changes would be applicable for RCs unless it's never run in a CI.  So
> unless there's a strong need, it'll be easier if we wait for 9.1 (but yet
> again, we can still queue them earlier, so they will appear in the 1st 9.1
> pull).
> 
> Thanks,
> 


