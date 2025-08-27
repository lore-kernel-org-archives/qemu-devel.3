Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F99CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urBHE-0007L3-3b; Wed, 27 Aug 2025 04:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urBHC-0007Ct-6g
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urBH7-0004xB-Vm
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756282369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H/00J/+IDLSRiwp7fmEW0WLqPAQqXOv2laMkrbaaiis=;
 b=XMjqxzrf2DEdapuaWMgCnI+uN7rciPnmYj1SSF/wfKvB8BnPKycWt+rDLrg3GrtslwX0bx
 hh+BSTZcZuBR6B72aH6pS4LsNCj9Safz4jbMy0PtX8h+5oXhZbODd7LdFf4VICb7KOlYiO
 4R8ECA9BamwwsyrAPgx1eTXAlHzdsFo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-pUbbvGK_MRS1jFwOU-nRLQ-1; Wed, 27 Aug 2025 04:12:47 -0400
X-MC-Unique: pUbbvGK_MRS1jFwOU-nRLQ-1
X-Mimecast-MFC-AGG-ID: pUbbvGK_MRS1jFwOU-nRLQ_1756282366
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b645707f1so11466555e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 01:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756282366; x=1756887166;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H/00J/+IDLSRiwp7fmEW0WLqPAQqXOv2laMkrbaaiis=;
 b=Y8U+Zj9hrlA7O1lDh5OZSRu3J8g7kPDVfCsKSnjyDV7lDDY8YV6kyhFeh9kHy0bNAU
 Fk44NF0z1fC0UNLaelJpX2jtiE+jl7AEV3yEFsS1MW/BkAESPyBIg6oCDNSg9EhQWgWT
 G1RAdyTpsG+GCHGa8QBOqvci2aleXC1DIyXCB8QCbCw1yDcR51lvRfNEl3B1DrtI0QhN
 7e086CT9ezA8R46OACRzE6frpf6Q7MITFUkBDR9y6R95jyI1UkWo0o961fPux9yietis
 B6nqpRqFh5VAAeCXiVYipQwiBBp7jgv4oK4I13vhn73iYIzR+hnTxIJGw6l45dBVVEfv
 mrAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDtzyQxL8LQViro8kmM7QTOaDDGDSLdUFrYuplHB12s16lLAmuwdOltY1rmDe9XOlLbShsa5f4iwJm@nongnu.org
X-Gm-Message-State: AOJu0YwDGzYb6Y/BOAMatFeBLnm7xepOxpEfx09RZ6NfjW8k7xgprK4b
 ruMdUFDhvF5NTYFZTC4EbovhtXXSdGKAY8IWPgZNefczAJvN9uIW4XmT0hPA9i1vnwm8pGIPGba
 FIW3NkNdML9cgLsO7DBGrbTKKGC9PXqeMea+HWcvcl3zhoIY3wsrcFMId
X-Gm-Gg: ASbGncu95PWPt9/vnTIykB+71OyugQES/T7+0hP4PrnyfazLX2FJq/C5oUY+hltus1T
 ZV4D6bodDHgioi8Ub0sI3OkRG2VUa4W/KSn6DyIhFRDlIxP0Gzrc2YHa811yiBKn5MIo2Ko7puH
 hJPBDZPT0mvWQEhIokM8eiWZHwQZa4qOnJQxxunO80j3PzeVR3gBoXHlZVEeQeERS5LyFU3FawS
 lGdGHfFErT6i0ieCYAixxjXZQY49TdIkdCsv+eYnxgpMbP6pcVw0RC/xVJidOY8rehb5axexBx2
 0F1TBqNvIrZjeYSXwOLPy7aI0I0SlVeMWnpbjukevOcpVas8gmz/kY2eNIcvlFDlYhzOJoRks6/
 sJVCLfO49lm4DOOnT+S/H5x4WRjPO1Y53mTNINFpSoCE=
X-Received: by 2002:a05:6000:400e:b0:3b7:9c79:32ac with SMTP id
 ffacd0b85a97d-3c5ddd7f89amr13751382f8f.52.1756282366454; 
 Wed, 27 Aug 2025 01:12:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6yECmmyD2j0y4jqiOod+K6ZDzigy4+k+jUZso+vj0lOok1lnFqtEvWjaX7d+gFI9D+RMQLQ==
X-Received: by 2002:a05:6000:400e:b0:3b7:9c79:32ac with SMTP id
 ffacd0b85a97d-3c5ddd7f89amr13751348f8f.52.1756282366010; 
 Wed, 27 Aug 2025 01:12:46 -0700 (PDT)
Received: from [192.168.10.27] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3ca6240b4f9sm10318099f8f.15.2025.08.27.01.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 01:12:45 -0700 (PDT)
Message-ID: <3d7f2ebe-111a-4858-a014-4e82872c0e88@redhat.com>
Date: Wed, 27 Aug 2025 10:12:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tcg/i386: Improve 8-bit shifts with VGF2P8AFFINEQB
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250809234208.12158-1-richard.henderson@linaro.org>
 <31647a8c-60b7-4e27-b89f-6d1709331ec0@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <31647a8c-60b7-4e27-b89f-6d1709331ec0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On 8/27/25 09:26, Richard Henderson wrote:
> On 8/10/25 09:42, Richard Henderson wrote:
>> x86 doesn't directly support 8-bit vector shifts, so we have
>> some 2 to 5 insn expansions.  With VGF2P8AFFINEQB, we can do
>> it in 1 insn, plus a (possibly shared) constant load.
>>
>>
>> r~
>>
>>
>> Richard Henderson (3):
>>    cpuinfo/i386: Detect GFNI as an AVX extension
>>    tcg/i386: Add INDEX_op_x86_vgf2p8affineqb_vec
>>    tcg/i386: Use vgf2p8affineqb for MO_8 vector shifts
>>
>>   host/include/i386/host/cpuinfo.h |  1 +
>>   include/qemu/cpuid.h             |  3 ++
>>   util/cpuinfo-i386.c              |  1 +
>>   tcg/i386/tcg-target-opc.h.inc    |  1 +
>>   tcg/i386/tcg-target.c.inc        | 81 ++++++++++++++++++++++++++++++--
>>   5 files changed, 83 insertions(+), 4 deletions(-)
>>
> 
> Ping.

I don't know the target-independent part of TCG, but arithmetic right 
shift by 7 probably should keep using pcmpgtb?

There's also a typo in patch 1 (s/NF/FN/):

+#ifndef bit_GNFI
+#define bit_GNFI        (1 << 8)
+#endif

Paolo


