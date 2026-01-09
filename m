Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D74D1A613
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBxr-0006x6-UT; Fri, 09 Jan 2026 07:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veBxn-0006wH-Ak
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:51:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1veBxl-0000Wh-Lp
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767963092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hKAOQBl4Wv4To7mhUu6OsZ/Jtvw7S2ASbxbwos5UT20=;
 b=TVfdWAQClClOcnS8PwWu6SbrGSN/rQfh+q2qtW4W0qQC3M4l+Ic2DSVWlIOVmZgYQ0nyCN
 IC7CO+lUsA0pzhJFaXsJCVI6kLI2LpqeyZBxT8FmUL230RRmLroopAMV3H12KubmrI9e0j
 8JJr+BpNBZ+6Mi76vGVJuWJ0ShEG5yA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-GerO6sk5MZa24baBDAdPAw-1; Fri, 09 Jan 2026 07:51:31 -0500
X-MC-Unique: GerO6sk5MZa24baBDAdPAw-1
X-Mimecast-MFC-AGG-ID: GerO6sk5MZa24baBDAdPAw_1767963090
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b7d282ac8aaso609897466b.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 04:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767963090; x=1768567890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hKAOQBl4Wv4To7mhUu6OsZ/Jtvw7S2ASbxbwos5UT20=;
 b=Kimzt12VMoUmp3yE6wDvMtdUL/z0eE6wXqTESNrIBVtH+mtEcORPc+DHZcAUTVqchy
 y6d36U319+E4MjkNJvVH1xEdBZymP4BRGBO9icSNZU/Nd+/7hkIuOfk0mgJkUKkoJuaF
 MOmtdJKvDMh5psvJjVsHA0cRSqdIuiB1n6mTLYVS1HfEtMyHaVECc4nzS9vyN3Dct6Bq
 INUHtY7FBPd+9s8b4YjYVx9f07g3eDD+8LJo+Pk0CJCQSThMWYaj391eungOyFN1UQho
 Ggym5NCT4l/J1NbzGCQ4e5VJ/ZOY1GfqwSl80FPG1/8L2s2DvSDsBQPi/UXUgSLQunzi
 CN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767963090; x=1768567890;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKAOQBl4Wv4To7mhUu6OsZ/Jtvw7S2ASbxbwos5UT20=;
 b=EbPir5P5HVQgTdKWmWUafmIVvX6Z+kiZiMpmAEKTr29ZNEIQQ7ijcJ4gDm6O+mLcLP
 HojLE4AWeeJ+Ry+hzShZPoKCc4RsrR6VH6o5iBo6NCo4+I5AEiMOnvtcaG9SQkDWSI2K
 utKnVK2F0Q8EZDRwXp6D8SM4q5mfgMlZVL5NyWs18/NeWcGilj+jcnPBMii7tiSYuS7g
 u4Y30JPLkG4pV0ch2ZQhvT1cWo9+OcUV3P/1ZaSkNFzky3DrvfoiT4sISQWYBKzwg980
 TbZxz86PEY48tLrQ9WkOctecsvwGJFUTJL3aEPIaTHgolxiGG8WBs8qvQ4wHdFe95yUL
 eJXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEzqZYYeQp6lB/lSZ6IYcm4xPBr6uPUFL8lAI2ez179a4LkR9L7+k11ml00IcJMGxtOvxqfcGg313h@nongnu.org
X-Gm-Message-State: AOJu0YwoiDxtcfSYozMPICYZHCKBEbYZsKeI0//DorKYTH5q+S9vsz2h
 5RL5WTwu0NFud/TJurDTTwIn0BbK1Xb80YTWHLbcHlxbkcD1pDoI3Xw194lbuhSCrbhdjCfLh5Z
 pePLIf6SLtFlBXqR4ys5IulA/y82r1sfxFcQrzqo0DDwT/nYdyq7/cACx
X-Gm-Gg: AY/fxX622F+oLXk3GMvnxcUh/uyeJFS+wuyx6Ggmengg/e3rlCiV3U3bLkQ0DFkvrwA
 jjo7e29Kbe9+eJCFOn3rAkFs6aUWjpgGUpUUMKMqgvF9C31UyiEl2JQ4RL1R4FNb6949jqea3E5
 rOLCYqi7WSrshwUW5lV4HNLUE+ohSWEYWTd827wivN7rRH4BHkUpOd7Btv+CvxkH2BnZn8/zlKn
 HBPmeZhHUxywNgeJxGAlmTjm87QVmYKG0zGhc5Y1AUL7WFM94+Ng31g38kjThzvilnmpm+r1AFU
 3akOJ1wlhAzImjBiZvCMpXX1g39muTiCiodJfNtt3RV0ZaAHsAAwG+5XB1ABJdEx1JzfeJjWlkR
 83MdHeTc=
X-Received: by 2002:a17:906:9fd1:b0:b83:1433:78de with SMTP id
 a640c23a62f3a-b8444c4d398mr984931566b.12.1767963089846; 
 Fri, 09 Jan 2026 04:51:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcsoCJssoVYGsV33f6fBe8y8A/A5wwXlMrZSkxy9pY54wENHPUUO5gUwqQVIue6gQFQaxOXg==
X-Received: by 2002:a17:906:9fd1:b0:b83:1433:78de with SMTP id
 a640c23a62f3a-b8444c4d398mr984927566b.12.1767963089443; 
 Fri, 09 Jan 2026 04:51:29 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a230db0sm1123912866b.2.2026.01.09.04.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 04:51:29 -0800 (PST)
Message-ID: <4b8fa7be-b16e-495d-a7c5-2d3076283f9e@redhat.com>
Date: Fri, 9 Jan 2026 13:51:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/29] crypto/x509-utils: Add helper functions for DIAG
 508 subcode 1
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-12-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-12-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Introduce helper functions to support signature verification required by
> DIAG 508 subcode 1:
> 
> qcrypto_pkcs7_convert_sig_pem() – converts a signature from DER to PEM format
> qcrypto_x509_verify_sig() – verifies the provided data against the given signature
> 
> These functions enable basic signature verification support.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   crypto/x509-utils.c         | 108 ++++++++++++++++++++++++++++++++++++
>   include/crypto/x509-utils.h |  41 ++++++++++++++
>   2 files changed, 149 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


