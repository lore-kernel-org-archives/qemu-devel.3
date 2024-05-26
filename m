Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5280FC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 20:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBKYk-0008C5-4c; Sun, 26 May 2024 16:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sBKYi-0008Bk-NV
 for qemu-devel@nongnu.org; Sun, 26 May 2024 16:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sBKYh-0001SV-5d
 for qemu-devel@nongnu.org; Sun, 26 May 2024 16:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716755614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkNfFVVPDqUVp8a5CUaXLRSp02OkpQY7QQb3ZBw0PlQ=;
 b=FdFoKEwecE3NQYRSne7YrNLTFNojIGP+SetAnbGoztZJgQ4JzkDiydfWRClsvVOoNVbtb7
 j+oc7krANemz45IzIPmN7mRxidbdvf17Lu0fa/lvCyQCRa8Y1E/Z2GKhu+KKswltPhJv5J
 XR8YWShPXTaPcVpyHOzgARH57shTbPo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-7p7F1eVQNty0HhILqNrAXA-1; Sun, 26 May 2024 16:33:32 -0400
X-MC-Unique: 7p7F1eVQNty0HhILqNrAXA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a626ac4d29aso122268566b.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 13:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716755611; x=1717360411;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dkNfFVVPDqUVp8a5CUaXLRSp02OkpQY7QQb3ZBw0PlQ=;
 b=A4urcfQ8hAV3thYFFoLDQtT4tR7sIdVnrd1q91xcJOm620qeXH51kssUd2XMmDdnTu
 mz8GJHHuFpx9ekDr2fJa1uH646wOnj9D3QYHlyXFUIIKpTN48RElz53CtKh6ycWTnXeD
 g5/23lMHuqM6GSFD48+u0kbZc8/BHxq+jrR5+Ywwf3Gb37/KPosviKMpIrj0n2q7riqr
 EW3+cdrkfMiN6f2WPYgEyjCnx1h/aLs3IV7j2qIEeg3LHRnSW/npFq/TdGdw/71OpmqB
 dP5T0WhAyeoe3KaLoRJeTdzwlU6pm1xR35g3BfNe5V+z6FL4U5V+5+oySQ4aBUNuyMKn
 j+/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoROy3Ys4kkVahUjp9+HjfbjeA63lEQy/l6uJzBUOZc9CCgoIA7rtS6KV5izt92yHj9j4zv4xv0HDTvkJziIZT0C+HqGo=
X-Gm-Message-State: AOJu0YwjwbbDSBBx0ZMXHeBWIENuLSRWwizTNjuCjscdkFoVcxGKk9GS
 uXUJEzSCwOYdglszWcpPzRKKD3Qu7QG9TZjUwIU9/uApDGcIigVLYbGUOn3H1ONKH/EfasFcnHm
 F7mUEdOdQj8+A2JLcnxnUDD/OCx0x80Yn8xdLmYsEI8d5RIMZ3f3T
X-Received: by 2002:a17:906:a2d3:b0:a5c:df23:c9c6 with SMTP id
 a640c23a62f3a-a6265149c2cmr551083566b.47.1716755611378; 
 Sun, 26 May 2024 13:33:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBsk/gvyLkp9XtgY6J2fcz5RVnUeLWINHl7GolxyqndQrbV+7jixTxAKv8X0JzyFTRXi7auA==
X-Received: by 2002:a17:906:a2d3:b0:a5c:df23:c9c6 with SMTP id
 a640c23a62f3a-a6265149c2cmr551081466b.47.1716755610863; 
 Sun, 26 May 2024 13:33:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e?
 (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de.
 [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c93a81dsm416159566b.87.2024.05.26.13.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 May 2024 13:33:30 -0700 (PDT)
Message-ID: <22e05fc7-6256-41b3-9f0d-f983f169b08c@redhat.com>
Date: Sun, 26 May 2024 22:33:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] hw/intc/s390_flic: Migrate pending state
To: Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240525131241.378473-1-npiggin@gmail.com>
 <20240525131241.378473-2-npiggin@gmail.com>
 <3bf1025b-021a-42fa-a4cc-d3cd9ea90676@redhat.com>
 <10e876de-b973-4016-9155-960383d46297@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <10e876de-b973-4016-9155-960383d46297@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Am 26.05.24 um 21:44 schrieb Richard Henderson:
> On 5/26/24 08:53, David Hildenbrand wrote:
>> Am 25.05.24 um 15:12 schrieb Nicholas Piggin:
>>> The flic pending state is not migrated, so if the machine is migrated
>>> while an interrupt is pending, it can be lost. This shows up in
>>> qtest migration test, an extint is pending (due to console writes?)
>>> and the CPU waits via s390_cpu_set_psw and expects the interrupt to
>>> wake it. However when the flic pending state is lost, s390_cpu_has_int
>>> returns false, so s390_cpu_exec_interrupt falls through to halting
>>> again.
>>>
>>> Fix this by migrating pending. This prevents the qtest from hanging.
>>> Does service_param need to be migrated? Or the IO lists?
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>   hw/intc/s390_flic.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
>>> index 6771645699..b70cf2295a 100644
>>> --- a/hw/intc/s390_flic.c
>>> +++ b/hw/intc/s390_flic.c
>>> @@ -369,6 +369,7 @@ static const VMStateDescription qemu_s390_flic_vmstate = {
>>>       .fields = (const VMStateField[]) {
>>>           VMSTATE_UINT8(simm, QEMUS390FLICState),
>>>           VMSTATE_UINT8(nimm, QEMUS390FLICState),
>>> +        VMSTATE_UINT32(pending, QEMUS390FLICState),
>>>           VMSTATE_END_OF_LIST()
>>>       }
>>>   };
>>
>> Likely you have to handle this using QEMU compat machines.
> 
> Well, since existing migration is broken, I don't think you have to preserve 

Migration is broken only in some case "while an interrupt is pending, it can be 
lost".

> compatibility.  But you do have to bump the version number.

Looking at it, this is TCG only, so likely we don't care that much about 
migration compatibility. But I have no idea what level of compatibility we want 
to support there.

-- 
Thanks,

David / dhildenb


