Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BCECA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 10:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuTVn-0005Bs-5X; Fri, 05 Sep 2025 06:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uuTVi-0005BD-O1
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 06:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uuTVX-0006Yd-H4
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 06:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757067440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nrjYiPdlhmr5e0xwVaZAprEvtc4I5GQ9DJbOInyiQ6k=;
 b=ge5nqw2PDUxyTapMPGR2XK6qMu9RbmKVcvj3aUD5cPVzb9Sj3LjCIoMUKJXybGMLIMWnUe
 ms+9C2v92VKTnKsKjfjlOR+YKffdn32DToAvnLDEpRSDRBUEftjUkmHw1fHFE8YqI5V9mh
 C3Rqe4dLeKlFITdxbYPKB83D9ZPCACc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-guVuVngIMhSBdzsdl31R3A-1; Fri, 05 Sep 2025 06:17:17 -0400
X-MC-Unique: guVuVngIMhSBdzsdl31R3A-1
X-Mimecast-MFC-AGG-ID: guVuVngIMhSBdzsdl31R3A_1757067436
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b041abd4854so196047566b.2
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 03:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757067436; x=1757672236;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nrjYiPdlhmr5e0xwVaZAprEvtc4I5GQ9DJbOInyiQ6k=;
 b=IHtdV0OBFthtgh6b1RyfuM5DAOCCH8OV/8Mrun4oMwBs9tL03RZTq/5TdRTEzfL3rD
 lMg+eVrqOVltZ8bZ7JRP421pmz4CG/zVmzATx/3pR/StGXh95TYFDbFt7160/xzaYqUc
 PXSJrlkL38Xsu5HUMh5782VfesHvsxQxqbfMaLwsHm5912qblQefa4zcqfc07/OP0LqW
 gTF5xhi+rpoh3zl2y39AVEHfmxA3StfR9gI3vP5rkaEXHGhDz08oPJdLOgqDRjIdtkTt
 rLQ6IjO4eGrYoai5eGkRiVNeMiuRKcZB+SpeprHYJVMY3g7Ajtz0AFi8vy1JVLBwrnzn
 EclQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuaA2qH8U5camLPT6VpA6w62CBWk6odPRoh6J4I0A9Pzq07MT7/7qQEed45n8+L1Hrvp4Yy97rIsJl@nongnu.org
X-Gm-Message-State: AOJu0YxG3adWMjMopstuxpHEQdXvWr4Tr0FAyz1lmiBzfsjztT9r5Eqa
 j1IieddNndh8p4pGtdAB1mhpNSpRPl6HUyBdxDj8i0dV5AJCtnOyAb8kzFfW5S/M2rQ3w0/Ow6+
 wB5hF7EX7m6aIrhN7Jnd/o4MXIMHhHXy/vV9beIDzkfJOQocHHRQ+Dcow
X-Gm-Gg: ASbGnctrIIRIuJW4v4EpMBqSJwNJKm4d82cUsgyCpt6hkufzsJaQdfMB8LPANNXEu9i
 hc5KyBrW7aGikSjSmzm7FQhlXHR2qa2ZuNHGANm81iJ4XTivxGLE01QkzGzxMe3KaDJtEkgwznt
 zHSCJ648rYI4ZdBSOLbcTtZLs3686kS+jLqJULcPGhlPMgntcglbx+m8mMK8hgtI73mLol+C230
 /N+7j8DwdwOXHKuuBiKHuw6DBJFFHCaoTE8ZVmrxnkM71lRZ0PgAlLXdameF+kkDs1xX8z2g5DF
 wEe6ZWJeUzD4zCQqx8dSXvKAC7mVa5zpxHTJkzfdAbUJOdTgk+d/M/KqxWn7m6P2nMRJ/wl87Qg
 CfY1NSLIApzOP7rMoC92AZ323cnXTAml6ioPAvB4YN6bibBBO4MN93cQa
X-Received: by 2002:a17:907:9406:b0:b04:6973:1ee9 with SMTP id
 a640c23a62f3a-b0469731fbcmr996866166b.16.1757067435860; 
 Fri, 05 Sep 2025 03:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO+aQqqAMAs860Gp4gQ45mDbsMjo6EmKmnjdLh31g01BCLC3r8FocaPncFeJkzotxaP9LWuQ==
X-Received: by 2002:a17:907:9406:b0:b04:6973:1ee9 with SMTP id
 a640c23a62f3a-b0469731fbcmr996863366b.16.1757067435388; 
 Fri, 05 Sep 2025 03:17:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52?
 (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de.
 [2003:d8:2f4d:e00:298:59cc:2514:52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-621421b9debsm1293136a12.34.2025.09.05.03.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 03:17:14 -0700 (PDT)
Message-ID: <ac4a5808-e90e-434b-8cd5-4c25fc543501@redhat.com>
Date: Fri, 5 Sep 2025 12:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: Remap only populated parts in a section
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Steven Sistare <steven.sistare@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>
References: <20250814032414.301387-1-zhenzhong.duan@intel.com>
 <0286f864-9aaa-4a49-8975-cb1af3bb1270@oracle.com>
 <IA3PR11MB91363501F1A6ED40098AF8249207A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <0026017b-770e-467b-ab7d-98cac1c70463@oracle.com>
 <IA3PR11MB913635617BAC00289BC3DB1B9203A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <IA3PR11MB913635617BAC00289BC3DB1B9203A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 05.09.25 11:04, Duan, Zhenzhong wrote:
> + David Hildenbrand
> 
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH] vfio/container: Remap only populated parts in a section
>>
>> On 8/31/2025 10:13 PM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>> Subject: Re: [PATCH] vfio/container: Remap only populated parts in a
>> section
>>>>
>>>> On 8/13/2025 11:24 PM, Zhenzhong Duan wrote:
>>>>> If there are multiple containers and unmap-all fails for some container,
>> we
>>>>> need to remap vaddr for the other containers for which unmap-all
>>>> succeeded.
>>>>> When ram discard is enabled, we should only remap populated parts in a
>>>>> section instead of the whole section.
>>>>>
>>>>> Export vfio_ram_discard_notify_populate() and use it to do population.
>>>>>
>>>>> Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr
>>>> failure")
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> ---
>>>>> btw: I didn't find easy to test this corner case, only code inspecting
>>>>
>>>> Thanks Zhenzhong, this looks correct.
>>>>
>>>> However, I never liked patch
>>>>     eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr
>> failure")
>>>>
>>>> I think it adds too much complexity for a rare case.  In fact, if we
>>>> examine all the possible error return codes, I believe they all would
>>>> be caused by other qemu application bugs, or kernel bugs:
>>>>
>>>> vfio_dma_do_unmap()
>>>>     returns -EBUSY if an mdev exists.  qemu blocks live update blocker
>>>>       when mdev is present.  If this occurs, the blocker has a bug.
>>>>     returns -EINVAL if the vaddr was already invalidated.  qemu already
>>>>       invalidated it, or never remapped the vaddr after a previous live
>>>>       update.  Both are qemu bugs.
>>>>
>>>> iopt_unmap_all
>>>>     iopt_unmap_iova_range
>>>>       -EBUSY - qemu is concurrently performing other dma map or unmap
>>>>                operations.  a bug.
>>>>
>>>>       -EDEADLOCK - Something is not responding to unmap requests.
>>>>
>>>> Therefore, I think we should just revert eba1f657cbb1, and assert that
>>>> the qemu vfio_dma_unmap_vaddr_all() call succeeds.
>>>>
>>>> Thoughts?
>>>
>>> I agree it's a rare case and your suggestion will make code simple, but I feel
>> it's aggressive to kill QEMU instance if live update fails, try to restore and
>> keep current instance running is important in cloud env and looks more
>> moderate.
>>
>> OK.
>>
>> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
>>
>> (but you should also seek an RB from someone who is more familiar with ram
>> discard and
>> its callbacks).
> 
> Hi David, look forward to your comments, suggestions. Thanks

Hi!

I mean, the

	return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;

is completely wrong.

ram_discard_manager_replay_populated() should be the right thing to do.

Was this patch tested somehow (e.g., with virtio-mem), so we're sure it's
now behaving as expected?


I would add an empty line in vfio_cpr_rdm_remap().


Apart from that, LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


