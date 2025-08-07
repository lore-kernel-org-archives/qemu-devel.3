Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BD3C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 06:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujuZc-0000oK-QM; Thu, 07 Aug 2025 02:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ujuZZ-0000mL-Kj
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 02:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ujuZX-00081D-Me
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 02:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754549873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kNavfqULsD0flnupSoDsTVvMQXtt4Pzepj2PmBq1v1o=;
 b=ARQjyZUf/+S+NOMldqTMWZ/m0Mld2U/Vwwbrd3UTAsGNlaQrZcvETGkiRWfxzWbAWGPPmc
 9FzhxPg9PI/EWVd6Yvn4SC9eBMxqRdMrLLq2aHa2hYy4FAHEDr+uZfArJpsRhKd6h7hAsx
 o63OK//MrXXb2HVE7qcEweB3dsoslNs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-wtwYxRcpPluYziIc0C0GgQ-1; Thu, 07 Aug 2025 02:57:52 -0400
X-MC-Unique: wtwYxRcpPluYziIc0C0GgQ-1
X-Mimecast-MFC-AGG-ID: wtwYxRcpPluYziIc0C0GgQ_1754549871
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-61598e5e8a6so592478a12.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 23:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754549871; x=1755154671;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kNavfqULsD0flnupSoDsTVvMQXtt4Pzepj2PmBq1v1o=;
 b=PlvuGSTxtGcnqEWUHdZXw7NdmQoMpkDMiUV+GfeghEieDDOIGjSBSzJ8rMKR3Dw28P
 tcLbgdtoEkUx8WP8cSAxHuHWtcbN28Sa2VVwHr3egyaSsIjbeiXZkOF7hyOcik4wbzG6
 Ifpqg1WPHkYfk5TQ2YSZdvvrpSuvSaIH3qPsYqMn91HvIl5tGo78V2Gs2ASrFEbpL9eE
 sXux4rqBVxxSi1ZCJrBN+UPzzuLfe6z7oFZLU+HttUxZN1QwUxob9fqh/tcz99+IL5Iv
 a/GJySTfurLmkpaCwqM01BXAnRdD/B0gGU0D7jRzJfNCgXS3Pc7/isBnmenolxUXuWVM
 Y8Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzFk+f1iBoEl/iCM/+/D9ozsmm8ThsmX27CKuZTMIkcxW/gOGwBqGc85PoAevma5yRBozg+JTBxLj9@nongnu.org
X-Gm-Message-State: AOJu0YwpBdYwEQQMhwQKZbn7671cNAQcCFE7V3+d1r4ni35C/jEgi6YL
 ReE70uurD1KjkOyokLxw+t4QmIVqd4BbpvX46DTmoFwJANy44s1GaKStKH+rJIArbgMvu5ksX4r
 CZ5MqIR1s2E5/j7uqYm5qUwWyUnD+iezDPMXXaCBGiviO9KjvjayTYZ5f
X-Gm-Gg: ASbGncuIU0gM23JvQC4GS0lxWrqIg+b4JVKH1GQ43dv1tgiKfhXn5aOc95SRi39CAWB
 FGBvT2n1u9e93QwiOVbHf9m+naUjrYwqRuPOlWhwjSTrUnfk7qAclUmJ41VFFe8hN0KWNsoCPF0
 Kq+tmDXz544gelQZcD7eNw6cnISHxgrJijosygVQrfgmFCgaIotcHIQeQdWhDBEchRYATvtD5UM
 FIiK2skFuWIq3KCHBMubgrSCOKJ7dcVOK67L8+HSUUmoIuoRbXl+xZhHfAq6yHmVpNNCn+9987G
 9AyeSe6ehxV19nhW3LYoUFUJo4+395wuwXQ472ctQYua36fRKno3lBCZTgcdgst2SpxVQ1k=
X-Received: by 2002:a05:6402:3513:b0:615:23f9:eec3 with SMTP id
 4fb4d7f45d1cf-61797dfd344mr4760125a12.27.1754549870823; 
 Wed, 06 Aug 2025 23:57:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY4xP+cH6fGChUK74CXLsQHMrXywrg1eNWnw0DODfarX1o1Z1QIkuWb4zZswjUAtztpJVitg==
X-Received: by 2002:a05:6402:3513:b0:615:23f9:eec3 with SMTP id
 4fb4d7f45d1cf-61797dfd344mr4760107a12.27.1754549870367; 
 Wed, 06 Aug 2025 23:57:50 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-42-50-164.web.vodafone.de.
 [109.42.50.164]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a9113e40sm11263733a12.57.2025.08.06.23.57.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 23:57:48 -0700 (PDT)
Message-ID: <ea9dc9fa-21d0-4e32-881f-d0a8ac4378ff@redhat.com>
Date: Thu, 7 Aug 2025 08:57:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] e1000e: Prevent crash from legacy interrupt firing after
 MSI-X enable
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250806152940.362418-1-lvivier@redhat.com>
 <cd941b5f-c969-4d31-8153-1237fa0d0538@rsg.ci.i.u-tokyo.ac.jp>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <cd941b5f-c969-4d31-8153-1237fa0d0538@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 06/08/2025 19.44, Akihiko Odaki wrote:
> On 2025/08/07 0:29, Laurent Vivier wrote:
>> A race condition between guest driver actions and QEMU timers can lead
>> to an assertion failure when the guest switches the e1000e from legacy
>> interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
>> RDTR) is active, but the guest enables MSI-X before the timer fires,
>> the pending interrupt cause can trigger an assert in
>> `e1000e_intmgr_collect_delayed_causes()`.
>>
>> The function's assertion (`assert(core->delayed_causes == 0)`)
>> incorrectly assumes that it's impossible for a legacy delayed interrupt
>> to be pending once the device is in MSI-X mode.
>>
>> This behavior is incorrect. On a physical device, a driver-initiated
>> mode switch would mask interrupts, reconfigure the hardware, and clear
>> any stale interrupt states. The legacy delay timers (TIDV/RDTR) are not
>> used for moderation in MSI-X mode; the Interrupt Throttle Rate (ITR)
>> mechanism is used instead. Therefore, any pending interrupt from the
>> old mode should be ignored.
> 
> It is true that triggering assertion is incorrect as per: docs/devel/secure- 
> coding-practices.rst
> 
> However, I don't see statements in the datasheet that says mode switch will 
> clear stale interrupts.
> 
> The expression "TIDV/RDTR are not used for moderation in MSI-X mode" is also 
> unclear. Behaving drivers may indeed use ITR for that purpose, but the 
> question for us is: what will e1000e do when the guest tries to use TIDV/ 
> RDTR in MSI-X mode anyway? That defines the behavior we need to implement.

If it's not clear what to do here, maybe we could use a 
qemu_log_mask(LOG_UNIMP, ...) for now?

  Thomas


