Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC31C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubirr-0004uM-AB; Tue, 15 Jul 2025 12:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubiPg-0006S8-7m
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubiPd-0007SI-VU
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752596508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZLQKCgb3UqjKZgP7whg0mrQnuiKO/lw8RlSpFrlAQc=;
 b=UJoEmhzRWkNn/YVNqwt3QRk03R/1Fh9kInhESEPNQZghb5JpoErSmzJTPjq4D9zfCGVz5L
 BOVkiKWL9nMTanSATir+exwHI3/C7CMZhDdm7q1Amgm2SoTv5ZCaZYGPFvpKY2bFVwYFLg
 jCAp/dirXPTSKTnk84lCm9+UdJrUOME=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-k7qx9hmNPbaEMxE36Q1afg-1; Tue, 15 Jul 2025 12:21:45 -0400
X-MC-Unique: k7qx9hmNPbaEMxE36Q1afg-1
X-Mimecast-MFC-AGG-ID: k7qx9hmNPbaEMxE36Q1afg_1752596504
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a50049f8eeso2544396f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 09:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752596504; x=1753201304;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VZLQKCgb3UqjKZgP7whg0mrQnuiKO/lw8RlSpFrlAQc=;
 b=Js+YrY3/rEVRzNibsTgr3WNN3CQCCLNoJHtfX2JSBl9vMXpLEL4mI0DRi1Gk/gG+Ay
 glx7SVYkwoAYaYndDmO6nVysZz/AvYfYHGDnVF4cnhbXGwmmPjxCP/SMGqoKjIOITuPh
 rGK5nAVaKIfBtgwb+6i8rum8a0JuxiDN6rQ55gl336wmWpxN7Aun1TMtBlIthdQXde2d
 lZQ6LtW3G81J5Uqp7dC3itTahNNgG9g6B8FhaX39LDpa7wyTw7CCHQLFiTBYSoq2KhPy
 K3u4enM9c/3/Mjk6g4oeGt3T7UX0gI9SqfTSLAVQfUHhldLlNmmhZD6iI8Y2ug6JRzr2
 ZvMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwpm8Jnw36vBoKxMezykEp+rHPJHXqHo+s5qVBLzkY8nZ9FAq6+rlwkfaZW9cQxPNNoApGlyEGHVDg@nongnu.org
X-Gm-Message-State: AOJu0YxNLjGBVgUnN9wEZgVC3gtuhux007zcGrkYobnumsDMlgAxG7m8
 Q1lukwQ6pdC5dXMAhTCELAaSHvD/HywuysP986S60//EOWxgsDUKZCLoNP+0QnRDKQ/dFDiTzaE
 6Z7gw5dPQ6Q8aIl6P393S9ozzpni6zXiaYljKt/omu+cYN45PP8q0jD/l
X-Gm-Gg: ASbGncvq8yowelipjpUbhm50Rxhc7+TlBKLaGH64kmTbxGQ3f1e3VzAN+CGCr2FCe9x
 +41Z9fCyTLhBt0abvVoqR5PwrWbzr7ck1bS7XboyUfRxVHC2BRZw4AXfW3JrTO+CTlq/8W9vr0c
 6HZg/nvwO/V4WisczA3K7lnWSrraMRdmz7dh/sSe7sUJfoH1F2mu4EqZwKBZQ+tNBLLjnKJ9yDM
 has0yAdtmjBZXQxRkVEm5YjZAncXOz44Co5CThKrvsmN/Y+/v3859n6mQGq1S71uG6tND31yiUz
 oovnv/KthH7Wyb+RQjEAffOOBTaXxWKHeL+R1Sze4mQHgxNG9ZIpzn7ChLPaarfUUKOmbpZ49cb
 Y7Xtgc6kDYsQ=
X-Received: by 2002:a5d:648c:0:b0:3b4:9b82:d431 with SMTP id
 ffacd0b85a97d-3b5f188062dmr12660723f8f.13.1752596504253; 
 Tue, 15 Jul 2025 09:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFjcZRJiPD4zHE+0lra8fOt9B6ubbaYYVrgYE4PkZvLn9utF/Uyi12I1tJIDD5QFG+igeVeg==
X-Received: by 2002:a5d:648c:0:b0:3b4:9b82:d431 with SMTP id
 ffacd0b85a97d-3b5f188062dmr12660699f8f.13.1752596503827; 
 Tue, 15 Jul 2025 09:21:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd18a2sm15366931f8f.20.2025.07.15.09.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 09:21:43 -0700 (PDT)
Message-ID: <f1381483-a507-4420-a0c9-52bf8131e6e6@redhat.com>
Date: Tue, 15 Jul 2025 18:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 06/13] virtio-pci: implement support for extended
 features
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <eb1aa9c8442d9b482b5c84fdca54b92c8a824495.1752229731.git.pabeni@redhat.com>
 <8af39b78-a95d-4093-b68c-20b556860a09@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <8af39b78-a95d-4093-b68c-20b556860a09@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
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

On 7/15/25 9:42 AM, Akihiko Odaki wrote:
> On 2025/07/11 22:02, Paolo Abeni wrote:
>> @@ -158,7 +159,10 @@ struct VirtIOPCIProxy {
>>       uint32_t nvectors;
>>       uint32_t dfselect;
>>       uint32_t gfselect;
>> -    uint32_t guest_features[2];
>> +    union {
>> +        uint32_t guest_features[2];
>> +        uint32_t guest_features128[4];
>> +    };
> 
> I don't see anything preventing you from directly extending guest_features.

Uhmm... I have a vague memory of some interim revisions doing that and
failing miserably (but I have no log of the actual details). I'll try to
have another shot at it.

Thanks,

Paolo


