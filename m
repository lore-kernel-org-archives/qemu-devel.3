Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6E0C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thRUu-0003T8-0p; Mon, 10 Feb 2025 05:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1thRUm-0003Pe-UZ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:58:37 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1thRUk-0007hl-3A
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:58:31 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f7f03d7c0so25604345ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739185107; x=1739789907; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=TTw3oipbc9mEa3kutybdfiO/gPFj6uPVJ1j4sa10MFY=;
 b=nL4k56MwNcK0q+d1gffjk6CSaYRSBs1Y35PavxAHRFQ/3L7d9qfLP6piGR5/VvM+1h
 F5HpFuIsk84SqqhwNbCNEijfpcYUy6SzQqXga8zpBF9ZtNLih/l2Xznx6oeazgUGM5Cn
 9SqzBKz2vXFkrDvahiaxknI84Il65DuOkRVjpu038Mg+h9dCKHvMvReBFlZok/D4vr7Y
 apSOwdQCAyGbtVjH4nOpjPx9K7A4qHV/dsCOBto5YvT23V/eJz2qVdVMeZdJwXdc9fHf
 IBu3+V9g2/X1pEye7nrwUtVetBz6EC0SsGN1LXTwfFy6rqok8DJCRWESx18FCzRiB2Iz
 /OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739185107; x=1739789907;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TTw3oipbc9mEa3kutybdfiO/gPFj6uPVJ1j4sa10MFY=;
 b=bOi0+oEjJStJ9ZfIlXs79qJs3uSZwpOWmxCywGF5BXnXjFSX6AiWg82I+oGlVlqPjs
 xp7j+qqib0TohoNFLzRHwCS1PkAQJG8mue7Wn1mIsMc6WS/HFivznsr1MZsofwi7Uybp
 F15MbrUYkIhsfff41YMiimBQo6sh71ne3PKkpNV5FTqjb+Io1h96pY1xVr38fSxNqzV3
 +3BVG+XXitcC9h6TN4IDeSqB8KLVtPbhU0Qd/6oHvVYOfx0rm7Q26LdkYe2w6TntI3gQ
 z/aTg9e6BHECDmpa/gLM5dluuv04KSEt0vLid0tkUtZS1c+MSItrvZ+GcIbP0/NEU16a
 zgkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMpP29S9XFPafI+MB1VCH+QrsgTBd2IUs3CgBfC7Bzp4c+/lZXAU+eZDCUKW2/ehaVL3EeoCAbHtTl@nongnu.org
X-Gm-Message-State: AOJu0YzP349RZBoNJwM82KYv2Ho6UGp0gDsn7vksh5FFx8Fl1UqLRysg
 1bC4ib/mgIH1kS3wUY5LDDaWWnDxzNQ198ZxsiBW85oNhocYqwY1
X-Gm-Gg: ASbGncvL/az1q6S70nnt/n1lmmYMBKXyfHIwO8Y58fhqvjyq9fo/GID4Jorcp7QU+l/
 UZsrmJQRkgp4ViXwW9sjT3YwLuOayIfqGZmqGeynNdXyaRM9pagtKWNuJ1xWwQLl+2tmpLefkNc
 HPunQlhINtzPsTAshUsPwTTmrX/DnVRZgjW6Y0cCeh44PQZLgCi9l6RLV7zhGVngp1Au0ZvG3Gw
 vdZSbUmQIw9RpDrqwX+aUBvSMTzy+ftqWDg0GESfp/IAT5Ey56GcOBjxHiq
X-Google-Smtp-Source: AGHT+IHPlIUGTZoHhQ2d4NwYFcYBHfCad9bnvbW+vkChjaYJaPGnMMbzVNbpxBfXD6Hhwq5e8wHuKg==
X-Received: by 2002:a05:6a20:6f07:b0:1db:e0d7:675c with SMTP id
 adf61e73a8af0-1ee03a42a1bmr26305450637.13.1739185107251; 
 Mon, 10 Feb 2025 02:58:27 -0800 (PST)
Received: from [192.168.1.18] ([223.233.85.39])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048ae7bc5sm7320707b3a.82.2025.02.10.02.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 02:58:26 -0800 (PST)
Message-ID: <69a7da95-c050-4a22-b295-ff3c2eb34fb4@gmail.com>
Date: Mon, 10 Feb 2025 16:28:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
From: Sahil Siddiq <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <9b20ffc4-b55b-42c8-9847-a677c30c0051@gmail.com>
 <CAJaqyWf_9btBAtZ1TrUDpCh-eTD47ELHO5jxWJW3gOAZO0tMCw@mail.gmail.com>
 <f670a48e-73ab-4027-9d2b-d4fafa54cd16@gmail.com>
 <CAJaqyWftS8angT2=XUUFiR_5yjxNOmV4WXHe3cxkb4t6KbQdDw@mail.gmail.com>
 <4ee57bd3-5ea0-49a7-969e-c3fe902d8246@gmail.com>
 <CAJaqyWf9g_yAb6oYf_bJ5st9owKOzJDKbcWh6k+ZYZ3-mRSaVg@mail.gmail.com>
 <b5e90abd-9fa0-4ab8-9ad2-2b673f1c0784@gmail.com>
 <CAJaqyWcgEefe8EKeuY_hxPuPfdOk6yPiFw1gaY5fvKYc7vPo5g@mail.gmail.com>
 <91d6b4b3-be87-462c-9a0a-4f3fc8ebe4c1@gmail.com>
 <CAJaqyWfL9sWRgk-zMyW_+K0dAp18iDNw1AxJLoLHoSN=GA5_sg@mail.gmail.com>
 <dd634f4f-1539-44dd-8f97-6d1173dcd626@gmail.com>
 <CAJaqyWe3qTJhQrkP2gkmCeand_63O_R6ZNvWSgGJQpE-3Qz3aw@mail.gmail.com>
 <5ada25cb-405e-4587-b230-b6a3ce7dbdc2@gmail.com>
 <CAJaqyWfkOwC_-3N66Gq2EM+eXz7hNv3n+W_2W6XtJZ0iS8PQPw@mail.gmail.com>
 <360803dd-f1e0-48a3-8917-2477d8a821a9@gmail.com>
Content-Language: en-US
Autocrypt: addr=icegambit91@gmail.com; keydata=
 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
 rPgMe6IIvn24UuW2f6fIt0AaqOWq
In-Reply-To: <360803dd-f1e0-48a3-8917-2477d8a821a9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On 2/6/25 8:47 PM, Sahil Siddiq wrote:
> On 2/6/25 12:42 PM, Eugenio Perez Martin wrote:
>> On Thu, Feb 6, 2025 at 6:26 AM Sahil Siddiq <icegambit91@gmail.com> wrote:
>>> On 2/4/25 11:45 PM, Eugenio Perez Martin wrote:
>>>> PS: Please note that you can check packed_vq SVQ implementation
>>>> already without CVQ, as these features are totally orthogonal :).
>>>>
>>>
>>> Right. Now that I can ping with the ctrl features turned off, I think
>>> this should take precedence. There's another issue specific to the
>>> packed virtqueue case. It causes the kernel to crash. I have been
>>> investigating this and the situation here looks very similar to what's
>>> explained in Jason Wang's mail [2]. My plan of action is to apply his
>>> changes in L2's kernel and check if that resolves the problem.
>>>
>>> The details of the crash can be found in this mail [3].
>>>
>>
>> If you're testing this series without changes, I think that is caused
>> by not implementing the packed version of vhost_svq_get_buf.
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2024-12/msg01902.html
>>
> 
> Oh, apologies, I think I had misunderstood your response in the linked mail.
> Until now, I thought they were unrelated. In that case, I'll implement the
> packed version of vhost_svq_get_buf. Hopefully that fixes it :).
> 

I noticed one thing while testing some of the changes that I have made.
I haven't finished making the relevant changes to all the functions which
will have to handle split and packed vq differently. L2's kernel crashes
when I launch L0-QEMU with ctrl_vq=on,ctrl_rx=on. However, when I start
L0-QEMU with ctrl_vq=off,ctrl_rx=off,ctrl_vlan=off,ctrl_mac_addr=off, L2's
kernel boots successfully. Tracing L2-QEMU also confirms that the packed
feature is enabled. With all the ctrl features disabled, I think pinging
will also be possible once I finish implementing the packed versions of
the other functions.

There's another thing that I am confused about regarding the current
implementation (in the master branch).

In hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_vring_write_descs() [1],
svq->free_head saves the descriptor in the specified format using
"le16_to_cpu" (line 171). On the other hand, the value of i is stored
in the native endianness using "cpu_to_le16" (line 168). If "i" is to be
stored in the native endianness (little endian in this case), then
should svq->free_head first be converted to little endian before being
assigned to "i" at the start of the function (line 142)?

Thanks,
Sahil

[1] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shadow-virtqueue.c


