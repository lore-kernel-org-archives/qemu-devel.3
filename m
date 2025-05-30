Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CF1C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 06:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtNn-0006kb-DW; Fri, 30 May 2025 02:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKtNl-0006kA-D0
 for qemu-devel@nongnu.org; Fri, 30 May 2025 02:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKtNj-0002DJ-Dm
 for qemu-devel@nongnu.org; Fri, 30 May 2025 02:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748587097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MRUQctAiTvmvIG5YcPzhEMil4entyaV0xruuBpmcVkg=;
 b=jOshh2GokyfktCKh8aT909gBImqFdm4viQY4Id7R9Q7T7a62FGPjKwAN5DCPQOyp1txTVY
 xfXwucUwP1kJNXP84b6il4mzAY8yvoywCSKXHRu6OcKv+G6bd5aTVJhJFLP5W0IMvgQo5W
 wdBx+UAatGeK9LsKydVFDQf11GVbDJM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-k_4ZONkGOE2noX1d3vueHg-1; Fri, 30 May 2025 02:38:15 -0400
X-MC-Unique: k_4ZONkGOE2noX1d3vueHg-1
X-Mimecast-MFC-AGG-ID: k_4ZONkGOE2noX1d3vueHg_1748587094
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-604c41e0c10so1486323a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 23:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748587094; x=1749191894;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MRUQctAiTvmvIG5YcPzhEMil4entyaV0xruuBpmcVkg=;
 b=vunnMMC0CPpvBkRN0x/GJK8Z8TDGIUbXKLwbzlb3mjcTTrqQH0Z2KHtm+BOmTqufnO
 eHqAEtMPPwaC+LPJZ9ySS/LFVniUF0BzQUS8BqhNH5Qi+75Vc/t9pABVGfck9UA1UfGp
 aQ1zpkdfmRvS6AgFZMI5ZNXW8X1oHFKExooX0G19c3+0tckzc0gM5GkNodp3MF99Ks13
 +B1jw1cFlEUAHPcIHkGiZZXRF8NpfnHMlaLBwhMq4d6NkuHFnmh1AB1h1T3zuDIZXNg3
 HDh3ZO6mqBGkI0dBfPY1+hyiMS3Ijv/oH5V9kdzPsyIJ06QhLyZzxEGiJxlWPlngPruw
 D39Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW76WlPg1i+rJbqQNGgjoBy+QSCR66Y51ePh6OBA9df2iBojVqSYfHfybc8jduczpfja9zawDuotQSC@nongnu.org
X-Gm-Message-State: AOJu0YygWfV+tEGSSVoNveTRX2qKlea8Hgt3H6UPhS7DlH9IVRAA6FRE
 ewRLNHFx5JW8xoZNKSk8xeuMFEDgf091vDOTlWxaUUw3YqTAN4LMcYDDb1Co9YddS9o33fZ4Ilz
 Ty4LD+V8L7gmj+xqxprz08Wu+vDssMNhwnJ0mtxuHxh4xf/jqXeDhWu8V
X-Gm-Gg: ASbGncvCuG1eSwnBXpd6n5UPtJ1U7e8JZOo9Mo+OzYnNTr35CrIFUjZxTIeqazxpTg0
 W44zpbs5RqllQqMR6b3Vr0maUmvDUFld0oWmByAfwJOU6pgJV0NtgyVquSiNTqAmcM1VMvTWPao
 rMzfhss6UMRLO/Glm1Sz2YPcEaz+g2OQL2OFbmg/H7ushJ8ihrRSi1sydmT2PxTL3IU6PtG11Dx
 Ovo6b4wmHNKniNGHdsxBsbxeBD0TLxbgyrtOeBAE/79Re1CHWhUeH3kw5xZgyi9CAH3yLGZagPn
 SJbpO7LYaJxDfzHR/672jspQa1dGPhPz+eurD5pHEhO8TJGBD8Kt
X-Received: by 2002:a17:906:a996:b0:ad8:9909:20aa with SMTP id
 a640c23a62f3a-adb36bee594mr70441566b.40.1748587094149; 
 Thu, 29 May 2025 23:38:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2C9/6LHiHAU2LS13ZkGDY+kK19m0REAIWZilefydS2/UpWeolWwWtmB/rvLvYmZFQURqs8w==
X-Received: by 2002:a17:906:a996:b0:ad8:9909:20aa with SMTP id
 a640c23a62f3a-adb36bee594mr70440266b.40.1748587093715; 
 Thu, 29 May 2025 23:38:13 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net.
 [47.64.112.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5dd04551sm271064566b.93.2025.05.29.23.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 23:38:12 -0700 (PDT)
Message-ID: <8a1c3cba-548b-4286-9aae-bc2b3b0a1830@redhat.com>
Date: Fri, 30 May 2025 08:38:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/25] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-8-zycai@linux.ibm.com>
 <b986097d-d78b-4163-831b-2551336711ea@redhat.com>
 <3d790dad-d4be-443a-ac9b-7c2a5bc53e17@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <3d790dad-d4be-443a-ac9b-7c2a5bc53e17@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/05/2025 21.09, Zhuoying Cai wrote:
> 
> On 5/14/25 12:18 PM, Thomas Huth wrote:
>> On 09/05/2025 00.50, Zhuoying Cai wrote:
...
>>> +int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
>>> +                                 QCryptoKeyidFlags flag,
>>> +                                 uint8_t *result,
>>> +                                 size_t *resultlen,
>>> +                                 Error **errp)
>>> +{
>>> +    int ret = -1;
>>> +    int keyid_len;
>>> +    gnutls_x509_crt_t crt;
>>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>>> +    gnutls_x509_crt_fmt_t fmt;
>>> +
>>> +    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
>>> +        error_setg(errp, "Unknown key id flag");
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (result == NULL) {
>>> +        error_setg(errp, "No valid buffer given");
>>> +        return -1;
>>> +    }
>>
>> This check sounds like it could also be a simple g_assert() statement instead?
>>
> 
> g_assert() may not be ideal here, as it will terminate the guest if the
> assertion fails, which is not the intended behavior.

OK, but if it is valid to call this function with result == NULL, then this 
does not sound like an error, thus you likely should not use error_setg() 
here. If it *not* valid to call this function with result == NULL, then 
there is a programming error and it is OK to use g_assert() here.
Anyway, please add a comment in front of the function where you describe the 
parameters, including the information whether the pointers are allowed to be 
NULL or not.

  Thomas


