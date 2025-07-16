Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B997C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 16:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc4e1-0005OC-1F; Wed, 16 Jul 2025 12:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uc4cA-000454-1Q
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uc4c7-0001yU-KM
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752681848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpP5RL5MgDH0q7GU8n3ztWq5vyHz8jck7h98GJZ4Qws=;
 b=BvSeOKMp+YE4pLrJLCFd0/rezCWZIhdcBEuL37hXGCPyNy6xLvpHEc6A1UO/mqYw7NPIB5
 EhoZeoDDMX1PfJ52HZkJY+OM+W04VjSU+QZE0iUZCp8jiJZli1HoaXCs958vHV+Dac4Bx+
 W7rs55OGo2hziH2FmL9/13d8jak0qEc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-PJJ71HSqN2yLSlMx8hlSfA-1; Wed, 16 Jul 2025 12:04:06 -0400
X-MC-Unique: PJJ71HSqN2yLSlMx8hlSfA-1
X-Mimecast-MFC-AGG-ID: PJJ71HSqN2yLSlMx8hlSfA_1752681845
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45597cc95d5so68445e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 09:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752681845; x=1753286645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wpP5RL5MgDH0q7GU8n3ztWq5vyHz8jck7h98GJZ4Qws=;
 b=q5diWRNGoym+WPiqvKfcCvKQPlOjrYuaaKBGhJTxFYOPjya/xCMw2x8Xiyzh4yXMcI
 WDfs6S8wzc1vUPy6ihIjrZC8QJnx2k/Ys5B7nDAQLzgilKiku6bQryuoVkOzglX9hsgO
 YmhVGSKCl6Na5LndCEb41cqMTAEbJ9sKsgnh6XS/1AkIv5MJKnQRsV9iZ/+5QiRQ57b0
 kwKqHd1wTjcO96D0Kon4OoDGhY/D9s6SM3Roi68cj8vXKmj87a9IKzJ5kJBv/HlPog4x
 EM/al0ng7NgDP77ZFIEeCCN/rzWB7izaRgznRSwyGC3X21utEJbasOmJ3DYbmthEbxLC
 dJPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBEiKOQVTrexvdhfu0nyw66FpSm7eanJf/vMIlJDpGxR8Yur9ubK0BFTya9aj26hTFUtvX7HOLc8sd@nongnu.org
X-Gm-Message-State: AOJu0YxXIDc9cXCgXUKC01Ni5MNF4tB5iyUzfyibYcgetf2cF0Q1aeAJ
 P9cwAoHeBTZIJx4CUk2Z7sKJTqOCT6tgHQXmnsEZEYyenqSm10KmtWQltAxtE2xKBdrDEqeU9Pg
 7F0OqTYt1KMzRSppkKDR5F99YTVOJzzyOtPSeZuiiF9qSEaJLEKVy5oQA
X-Gm-Gg: ASbGncse2uaeOGfZQ+gJcLmFTOeEsZtec1ztrEZZQJPsSZLR7XviNnIahRhz8yQ27AL
 40OAPq1uDpHqSi54mirhmGEmlQsKBqrEhbX+CEiu0PW789WE7/a8dMvX2aHQ7W8h6GvEq9xotEt
 +MstpzLRJNKPfy3HOqRSm/YpBnKDedsbIv1mAiFLHb5DhZaU7ePotpKhCqgm0S+ssnb8FgLpby6
 mhzfQj02X/E62Vt7dtw5bcRTGrBEvbBp7aKRvxcsWmERQ3k+DPjLCUj+dS00NfqZQMHgSE21A0I
 ZbCkjcramg4IfsBWcMq/+NJM1NVQLfn8quUrCxyIgcSIPmXjeKu3kQTw+yUJ342I/tdQmkClcmj
 i7srbgjYbDms=
X-Received: by 2002:a05:600c:45cd:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-4562e39b723mr32514115e9.32.1752681844350; 
 Wed, 16 Jul 2025 09:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfi7StPVA+v63wOR/ikn+iED0xbTzuAwwvWKtFngEvITrPXZ9OPyHtojBbNFKKBe2JVMjTVA==
X-Received: by 2002:a05:600c:45cd:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-4562e39b723mr32513235e9.32.1752681843728; 
 Wed, 16 Jul 2025 09:04:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e802984sm24991185e9.12.2025.07.16.09.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 09:04:03 -0700 (PDT)
Message-ID: <a6c9ce06-1f30-4999-9458-392b2a71aba4@redhat.com>
Date: Wed, 16 Jul 2025 18:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: boot failure on top of current git
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel <qemu-devel@nongnu.org>
References: <6c04f89b-0313-481a-9d26-1fe9e60e0616@redhat.com>
 <1331c1fe-6064-4580-8464-02dee23c1fe2@redhat.com>
 <5b901f04-da30-4f40-8ab9-803e03e43414@redhat.com>
 <CABgObfbV-V9JC=qAw4UL4pYWv-qcaPCpjSKwP5yohqbFGSnbkQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABgObfbV-V9JC=qAw4UL4pYWv-qcaPCpjSKwP5yohqbFGSnbkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
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

On 7/16/25 5:39 PM, Paolo Bonzini wrote:
> On Wed, Jul 16, 2025 at 5:26 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 7/16/25 5:22 PM, Paolo Bonzini wrote:
>>> On 7/16/25 16:44, Paolo Abeni wrote:
>>>> I'm observing boot failure for a rhel-9.7 VM. I'm using qemu git tree at
>>>> commit c079d3a31e.
>>>
>>> No and I cannot reproduce it.
>>>
>>> What host is it (processor) and kernel version?
>>
>> Host CPU is AMD EPYC 7302 16-Core Processor, the running hypervisor
>> kernel is ~current net-next (v6.16.0-rc5 + plus net-next new features
>> for 6.17)
> 
> Hmm I have AMD EPYC 7313. I have a 6.15.4 kernel but I will check the
> one you gave in the other message. Can you check if
> 
>   ./qemu-system-x86_64 -cpu host -accel kvm -smp 4
> 
> is enough to reproduce or a real guest is needed?

Yes, I get the core dump with the above:

# ./build/qemu-system-x86_64 -cpu host -accel kvm -smp 4
qemu-system-x86_64: ../target/i386/kvm/kvm-cpu.c:149:
kvm_cpu_xsave_init: Assertion `esa->size == eax' failed.
Aborted (core dumped)

/P


