Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3418C52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 22:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seMCN-0003Wa-0i; Wed, 14 Aug 2024 18:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1seMCK-0003VJ-Pr
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1seMCJ-0002fW-9i
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723673425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QXKaNtHzt8r9hABvyyMSmjkxYE78pK1lQYIcudY4AJk=;
 b=HoLrL1OJWDN/6GuP6B57Ty04OquaeB/pwBEqJ7klOy3Sy4I4oL6MnT3KbR4m8wYGoUo4fj
 2hoX68MMJEcwVVOpxk/RbxGiZkpTXUSHbT56GikDRG//Ozu/226eW0a/n5RmYCgjbS74mW
 1fXEmuG7WTx/InV2JubceO6NtRd6NHo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-x83N4Hr7PZOlH0C7q6So5g-1; Wed, 14 Aug 2024 18:10:23 -0400
X-MC-Unique: x83N4Hr7PZOlH0C7q6So5g-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5bd326f3f52so345875a12.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 15:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723673422; x=1724278222;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QXKaNtHzt8r9hABvyyMSmjkxYE78pK1lQYIcudY4AJk=;
 b=IbkUCbY1nUxoCrzBLo4/SVgGoD49vTDhqqiePY3ERW859hoHjuN7EFIOdSl76gv05H
 YVDVCi4eteWw76logDEMe3PGc8HhMEjHQFHlRxUv7q/cZUYIwUpyTBamlHjD3o2DBPTz
 /5w1Kmrf4LywjREsPebUYhaoGaq+Boa3IWiRNbE2fKcDVJLhM6CW1UHbvEiF5+2qrIZ6
 hO/DcMtien47+H0LWPG2KWS41k2SeGZ3At2uP0mPEDTG6lMPUSU2q3Z7ffEyemyRD2XS
 jyxLIWN0rQpBXq2tO+s61z+9SSEZx1tPkF5bRUWw99sX8c0cFiKBJIr54dge9W8NNokI
 5z8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXht2rY0Mh5IeOP6MW2E4ymS69ExjgvbdJY5XzKoyP9sD9xgGvGwGFjoCIkpMftUhsAaV7ZrzZRk4G7K7FekiMGiTHZT14=
X-Gm-Message-State: AOJu0Yw6skS1Bi9TY35WyQDhvehS/rh7KcTjI7XoXaCCUx4Yt2uZQLxP
 GjxNST9X19UIYTEObH+ecH8nqStp5mNfheQz69Pxz3onN6RSk5OUpo0jQn12YwV3AAdI7XSnlgK
 hgHbt/Fd1HltiHgFdrn4p6bQClap2r4CYi5nY20AWCwbDiXGqfs08
X-Received: by 2002:a05:6402:908:b0:5b9:17c7:93d6 with SMTP id
 4fb4d7f45d1cf-5bea1cad3b3mr2445684a12.25.1723673422204; 
 Wed, 14 Aug 2024 15:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhD+HFCs5haaKkuAjVZRoh0YlvbPxmHEdZyeFK0tFQnExmuNbVM4tx94MfxsR7yPK5b47kfA==
X-Received: by 2002:a05:6402:908:b0:5b9:17c7:93d6 with SMTP id
 4fb4d7f45d1cf-5bea1cad3b3mr2445670a12.25.1723673421714; 
 Wed, 14 Aug 2024 15:10:21 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc082f4dsm95007a12.96.2024.08.14.15.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 15:10:20 -0700 (PDT)
Message-ID: <98c499fc-20bf-4a1d-90ac-3df34836a968@redhat.com>
Date: Thu, 15 Aug 2024 00:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] timer: Fix a race condition between timer's callback
 and destroying code
To: Patrick Leis <venture@google.com>, Roman Kiryanov <rkir@google.com>
Cc: jansene@google.com, jpcottin@google.com, mett@google.com,
 qemu-devel@nongnu.org
References: <ad0740c5-9bc2-443c-9caa-a243b3a29108@redhat.com>
 <20240627003134.3447175-1-rkir@google.com>
 <CABgObfajkBU9-aGQcDGf6taUGwZOG=O5sewzc1HjCWTb5cVA1A@mail.gmail.com>
 <CAOGAQepLGTY-92So1arNZWjg9m+HZ8AjZ28Gsscm2ai5sj1AMQ@mail.gmail.com>
 <CABgObfaBjneGy__o_aABdm+60wsg=rxLmgZLthwCoezwnH34ZQ@mail.gmail.com>
 <CAOGAQeo+DZpE=6xEeUWUEkqSwYgturQ9QzXyzNNt7QfrFqea-Q@mail.gmail.com>
 <CAO=notwaOEkXK1PN679=1qTSnAh1R_f9kkRAF+ykLBij2nqy9A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAO=notwaOEkXK1PN679=1qTSnAh1R_f9kkRAF+ykLBij2nqy9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/14/24 23:12, Patrick Leis wrote:
>     I would go with your aio_wait_bh_oneshot suggestion. Please consider
>     adding it to QEMU as I pointed above. I can send a patch.
> 
> Hey - this is an important race condition to resolve, can we get some 
> attention back on this patchset please.  It's pressing.

Sorry about the delay.

The patch is good, and there is no reason why it should break.  But 
without a user (and as far as I understand there is no occurrence of 
this race condition in upstream QEMU code) there is no reason to include 
it in QEMU.  QEMU is not a library, and therefore there should be no 
unused functions in the code base.

You can keep it as a solution for the race condition in your code; 
depending on how your fork is organized, it may be kept in qemu-timer.c 
or in a file that is part of your additional device models.

Thanks,

Paolo


