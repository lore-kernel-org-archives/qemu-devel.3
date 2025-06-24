Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60957C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 09:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU04P-00021t-Vm; Tue, 24 Jun 2025 05:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uU04O-00021i-Nx
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uU04M-0001f3-TH
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750757757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A7j320pgNGwREHdaMcoWoRZBdKtkashEbvkHwqBzUMg=;
 b=QSNOr+LwkptyDlkPXl2BFCtEVVWGImBw9E82OHm7v/1CKb20eS8ytewwcCW6VpER5UIkUz
 WLjryBIKHjFYwAOsW7mY3q3nzAOvdr2vJg6jOWlGNNg7ARzw1ttmv027KaVDU5VhV7c7Mw
 LybAHK8Q8x6w9dK4x96LbZgpY2L8DOQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Xl1YZwPCOxekX1rQt8XAKQ-1; Tue, 24 Jun 2025 05:35:55 -0400
X-MC-Unique: Xl1YZwPCOxekX1rQt8XAKQ-1
X-Mimecast-MFC-AGG-ID: Xl1YZwPCOxekX1rQt8XAKQ_1750757755
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso2829328f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 02:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750757754; x=1751362554;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A7j320pgNGwREHdaMcoWoRZBdKtkashEbvkHwqBzUMg=;
 b=ea0/uOD9EDE3FU7i7lB1iv3xXoDXWT00HWLrAsUdVNMxnhBVEgCb4LplOf7IcKiZjY
 olM5GoP0vNF2FczqAaUxmXFgiV1vQM9l3poJi0Iw2LDddrV6615Xfru26kRpFukCMt65
 rtkmOOCyZsHVzpWsqh9zegHjly6TrnFpVazl5EiBUjtvLS0NUwIxeWOeYpfFLPm3IG05
 iL60iaXXvfylgpDslhkmWezuDRZLIW0amfm7GJpkyiqp0iOAmYpdFFBQMqtsNI2n1EpS
 09MounopAHsFwuGlPe8pQ6PgewDjHqpfmssJhIis/u5X5ZsTUU578F+WQiCX1Et4ywAM
 g62w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9wMtsSTzLbMEK5+IVGi8dJM97/JS5yAouLsiD+qTTmL2VXF13x5VLnRQkkOiSpajj0tWBlbY4Cvdt@nongnu.org
X-Gm-Message-State: AOJu0YzqoiYBdbgwf6Dx0akAsSn7FO6b0XdpcwUIrP4/fCzVHr/JNV8y
 0v8M+KWasW/3XnbfqCHG2ZQmy3Nbzw/MNb4e6FWhFOUCw+XnN0aQQxrb1GgjrsfO19/CMtlzHTT
 GHw2p8X6I6ad8CKPxrfBZM5umUR6mJI+aVDLNyQC7lctIR35dqLmbbxXx
X-Gm-Gg: ASbGncsHUZFigRKjxA2cIQiPC1x0SfeaVNvK2X962DUZUk1spFbo5pkDuZ6orygnI63
 8c3q4dM08pMNgv3U/E9bVVzsLPP1v2AbERvUFW9vqK/7MXsqpkLURoH8UyOFaOGNI5+hCGkciQB
 hgRaE83X9fhEaLX5L6ERXoIbq29/MWMfarqNwWoQRAOEU6bZ41QIgQB6hFIHeiiXbnwiYhql2K8
 AJwVczozjymrNvwRfInvZQtkvrXU7weyvFM5j96gq0lR1j/RB0sUwzhvZCw7MrutrSiVtSVYI92
 tFjjbiKQTMB977zespfN+SoaMz54B9DBCzkDLCVb2T9fpKVztu1cnb+mvAt1
X-Received: by 2002:a05:6000:4014:b0:3a5:541c:b40f with SMTP id
 ffacd0b85a97d-3a6d12dba33mr11318173f8f.9.1750757754501; 
 Tue, 24 Jun 2025 02:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMMbjY7S+glrtuuHb4lV/mKzqmfr0n8uwgfnuAmHKi6X6xfe+yBG4TMwu2pMTQdJG+FzNWlg==
X-Received: by 2002:a05:6000:4014:b0:3a5:541c:b40f with SMTP id
 ffacd0b85a97d-3a6d12dba33mr11318149f8f.9.1750757754068; 
 Tue, 24 Jun 2025 02:35:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8050fd6sm1498107f8f.17.2025.06.24.02.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 02:35:53 -0700 (PDT)
Message-ID: <b7daa3c2-a9ad-419b-a84f-16054543ba76@redhat.com>
Date: Tue, 24 Jun 2025 11:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: add license tag to some files
To: John Levon <john.levon@nutanix.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250623093053.1495509-1-john.levon@nutanix.com>
 <78fc7bed-75cb-4d9a-b6e2-86b95319bcfa@redhat.com>
 <aFpqaC8HGEK5A7dV@redhat.com> <aFptjwzxKjvwYUgP@lent>
 <00590277-eb13-48b2-afeb-f99134fb3265@redhat.com> <aFpwrqX0idMrL34I@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aFpwrqX0idMrL34I@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/24/25 11:32, John Levon wrote:
> On Tue, Jun 24, 2025 at 11:27:57AM +0200, Cédric Le Goater wrote:
> 
>> On 6/24/25 11:19, John Levon wrote:
>>> On Tue, Jun 24, 2025 at 10:05:44AM +0100, Daniel P. Berrangé wrote:
>>>
>>>> On Tue, Jun 24, 2025 at 10:34:40AM +0200, Cédric Le Goater wrote:
>>>>> + Daniel
>>>>>
>>>>> On 6/23/25 11:30, John Levon wrote:
>>>>>> Add SPDX-License-Identifier to some files missing it in hw/vfio/.
>>>>>>
>>>>>> Signed-off-by: John Levon <john.levon@nutanix.com>
>>>>>> ---
>>>>>>     hw/vfio/trace.h      | 3 +++
>>>>>>     hw/vfio/Kconfig      | 2 ++
>>>>>>     hw/vfio/meson.build  | 2 ++
>>>>>>     hw/vfio/trace-events | 2 ++
>>>>>>     4 files changed, 9 insertions(+)
>>>>>
>>>>> Daniel, What would be our position on such files ?
>>>
>>>> TL;DR: this patch looks reasonable, and we might as well take it, but
>>>> there is no expectation that people need to extend this work across the
>>>> code tree unless they love doing historical code tracing :-)
>>>
>>> I was required to send this patch,
>>
>> ?
>>
>>> as Cédric wanted the same files in
>>> hw/vfio-user/ to have the identifier.
>>
>> SPDX tags are required for newly created files, the ones introduced
>> under hw/vfio-user/.
>>
>> Old files don't have to be changed. It would require a legal due
>> diligence which is a complex process.
> 
> These files came from hw/vfio/ and were then modified so would carry the same
> license. Please let me know what you'd like me to do.

Ah. Please consider them as new. These are infrastructure files which are
all similar across the QEMU project.

Thanks,

C.


