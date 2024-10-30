Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48716D5CC96
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 11:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t66uu-0006zm-5j; Wed, 30 Oct 2024 07:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t66uq-0006wZ-UW
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 07:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t66um-0005yU-MA
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 07:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730287862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sBwe9lKdGPhx+Q5TNzF2B3y6ox04xAuD3lMOCWECZok=;
 b=CEy7GILOfq238wzQA9Zj9rrVtNFRMfuZ4/7Ca8XSkEnpQniRTAtYZUxnnz/KI6LP2kJt4Z
 9QiFmynreZdszzBBy38smNdzGWIVky1+q1s+GE6/yCKVCO35ImvjTfTMHAZt+mmK/l7Cdj
 IN9w0Dh8p8YVGFMeyp0RfecfRk0a2K4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-574uifB8PumZXh8Tr1kcoA-1; Wed, 30 Oct 2024 07:31:01 -0400
X-MC-Unique: 574uifB8PumZXh8Tr1kcoA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d49887a2cso502133f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 04:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730287860; x=1730892660;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sBwe9lKdGPhx+Q5TNzF2B3y6ox04xAuD3lMOCWECZok=;
 b=C7IZUrinV/Q0U81XONk/KH8xQjWpdvrxMKM4qBEHfEzq1rWoqUyr5PR/RWWH/w/9ED
 eFgKFDfC8//CqZmVmKkTMWVj4RXsRqXDpbw4LbrsvJelzc3UfgXttQqq8hj2XjRMZlg5
 CllYUCF/HYKPG5+4kNBx7aU3mWOyVTPzL1L8a5fXCO6+7HEyyAEOhq1PVLa0SY//2Djj
 J9NSdYEUcq01Iz6hVixd/OxvX2hX/UxLAxCHEaysgRfDNO4tVZoh5f5mEYtyr2ClvAOv
 nuhphMLdlWPN/9VvZWHLq4/q98Z/TvHiIuMBidzTsTUwljB6h1wP6iBxaAyw8W1t+S7W
 3KyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMWFbRpEfgIV7tncUcIaFYJBmDZgvwIb9cAl0+HigXfDaZX0iCHgc7eJhyp0wC096m38x7kBN8C7sP@nongnu.org
X-Gm-Message-State: AOJu0YwJgsDv4wiF2MkbGdOBoHCGvKKnxFwTvR0oHJP/Ma6oKjcuoqv0
 wCj2sIniSNmWgD/K6TuOeRt0vNLWIAsmoX3N/1PZwoMyHWQiytok28W2N83NTioCg4o4fhj955o
 AW3JEg08WVZjzyt59CAS0DPmyiQG8jdAujq0s0qEaNiWej3FrLASa
X-Received: by 2002:adf:fd8b:0:b0:371:8685:84c with SMTP id
 ffacd0b85a97d-3817d62018amr4279273f8f.15.1730287860072; 
 Wed, 30 Oct 2024 04:31:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWN0xKoPJZ9g17OrAXXkkvyvAnJkjP7FnsvNQekWlOvA88Y7XMkpGxd7+bn+E9ee9EKdeatw==
X-Received: by 2002:adf:fd8b:0:b0:371:8685:84c with SMTP id
 ffacd0b85a97d-3817d62018amr4279241f8f.15.1730287859682; 
 Wed, 30 Oct 2024 04:30:59 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-381b693e3aesm2669377f8f.27.2024.10.30.04.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 04:30:59 -0700 (PDT)
Message-ID: <53d9a4a5-367e-4049-ae7a-fa3442c46877@redhat.com>
Date: Wed, 30 Oct 2024 12:30:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/6] AWS Nitro Enclave emulation support
To: Alexander Graf <graf@amazon.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, stefanha@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, berrange@redhat.com, philmd@linaro.org
References: <20241008211727.49088-1-dorjoychy111@gmail.com>
 <5839222b-4d61-419b-80a2-cc7afb36abc9@amazon.com>
 <CAFfO_h5HquFuWQSo0n009dgi48Qoi_5MdRFuHOuHMGWNB2Q8+A@mail.gmail.com>
 <CAFfO_h4QCDc5qTP_U+-c0NTxPh5J53x876e5aVskMHx28OUerQ@mail.gmail.com>
 <54fe9ff2-ee5c-42dc-adb0-b4131a496a0a@redhat.com>
 <a9595a5b-e964-4dd0-9725-278141b398a3@amazon.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <a9595a5b-e964-4dd0-9725-278141b398a3@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/30/24 09:43, Alexander Graf wrote:
>> Hi,
>>
>> sorry about the delay -- the patches failed CI and I didn't have much
>> time to investigate until now.
>>
>> The issues are basically:
>>
>> 1) some rST syntax errors
>>
>> 2) failures on non-Linux due to lack of VHOST_USER
>>
>> 3) failures on 32-bit due to uint64_t/long mismatch.
>>
>> While fixing (2) I also moved the dependency on libcbor and gnutls from
>> meson to Kconfig, and added --enable-libcbor to configure.  I also split
>> hw/core/eif.c to a separate symbol, just to simplify reproducing the
>> 32-bit failure on the right commit.
>>
>> And finally, VIRTIO_NSM should default to no (the nitro-enclave machne
>> takes care of selecting it).
>>
>> No big deal; it's easier done than described.  See attached patch for
>> the differences.
> 
> Thanks a bunch for looking deeply and fixing the issues above :). I 
> suppose the next step is to post v9 with your changes included?

No, I can see that it wasn't clear but I've queued it. :)

Paolo


