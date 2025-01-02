Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1718AE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 09:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTHmA-0007hq-2R; Thu, 02 Jan 2025 04:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTHm8-0007ha-Mp
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 04:45:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTHm6-0003WG-Fd
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 04:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735811152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GQQvWKY2Z9YnK45SPae5pep8qJupARh9ECkIJaf7nBo=;
 b=O46tzxzq688y1/uRK5lksjEgV2E9lkjRS2yTlzsrwJKnAl5C7duHJPE9QtUrCVSQ62Pga7
 +xuzU7BxtsdYimC4OC803jNSfbRenailpBWE0GwGKONDNdzqqpV35qzbB4t01BfibjUeQR
 kSfI3bitsNRhyEBS+6Ry+UD5cAnGEPM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-OFmjo5EGMam_THjKQsnzAw-1; Thu, 02 Jan 2025 04:45:49 -0500
X-MC-Unique: OFmjo5EGMam_THjKQsnzAw-1
X-Mimecast-MFC-AGG-ID: OFmjo5EGMam_THjKQsnzAw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so68578755e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 01:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735811148; x=1736415948;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GQQvWKY2Z9YnK45SPae5pep8qJupARh9ECkIJaf7nBo=;
 b=IZq24H37gUs5fJEVmtfViq9UN5q9/vJohol3pBwJ0yJBTTccbcTRRl8m4CneM7HKgc
 O6Jrz5MBW3BzUpb5lDAnP2gpUZoeNFmNfJiZucbKwpe0JVya+NtUHX0UBytjzl9VUhSc
 cJxN5bkYlrXj/UdM9QS/91GyJMKJDOfL9dM4YoHCVUmhR09VYSdPUo5jI/tEIo9omehP
 ZKFFSLfMlgHqQgML880kzQlKyG9Xrgs0wKnIVvY019/LveJxmr1PU1jcDFZ+b7ZQ5ugx
 nZENiQ8NjisSzIwxOUO2b7alshuEy6RQlPqG0zRIHxRB8D9FRN1z8DMqtT/7jLhSFmrL
 LcWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS+fl6JxOU/lUYUy6Hmu7hVbKKQGjNrXEJAQohxXz2eodr9IJmc0WYDCFDTkqYD/yrWkvD/sI56Rzs@nongnu.org
X-Gm-Message-State: AOJu0YxPPB6wZcQbmwz2bsYX5l5GJKnV77DyioSEZ6tAELualCmUX5AE
 nFjv8n9oEObgl2w2/V+NiLBMGgVMEzSsZSbeqP8HjNC1lXNkAMDBRhCu/L8x/HWWi+7cACklef4
 2RFmqz+67mb3p+0dGA38GIYPy8hOqkxcKMNagzKoROo3t9k0MczjO
X-Gm-Gg: ASbGncsYPDcMu6ny9i4g3vYPydTP09Z6eCd+SFyam89wjgzpqfrAMrjMk3Vdh04ZLq6
 2FjPyixUMcBbnin6glJ31J+6MDxWOgb/qOZTRBT9BQEHboIOJh4S7jl32Y2PmRM9OEi1Ooav20y
 67cS0SLGqL3tnctU9Pd5zCrxwqV1SjE3cs6qCwqhlMUZRLPmUdRjitKYqhfCDXrsxTIPyuHA9zE
 SoYgpWylJ5LxyBXc+9QwW6IiFadpHfnrAO2NiFGvTu4m3bTaqXoAVfnKf0W7K9JeaQIeHyP5oPt
 NbvJgvBC5BdL
X-Received: by 2002:a5d:5f83:0:b0:385:fae7:fe50 with SMTP id
 ffacd0b85a97d-38a223ffb18mr35615614f8f.42.1735811148180; 
 Thu, 02 Jan 2025 01:45:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHZez2ddXhejOpVD2Qn6Y/dwM1crdPZeXEjaOAGhtfJw/iDGxCAIs3TDbdvraXnKOBHconTA==
X-Received: by 2002:a5d:5f83:0:b0:385:fae7:fe50 with SMTP id
 ffacd0b85a97d-38a223ffb18mr35615596f8f.42.1735811147887; 
 Thu, 02 Jan 2025 01:45:47 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-148.web.vodafone.de.
 [109.42.51.148]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4365c08afcbsm456539985e9.21.2025.01.02.01.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 01:45:46 -0800 (PST)
Message-ID: <00ad22b7-4885-4142-b675-4f4143fc668d@redhat.com>
Date: Thu, 2 Jan 2025 10:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tests: Add functional tests for HPPA machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250102092301.42122-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250102092301.42122-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 02/01/2025 10.23, Philippe Mathieu-Daudé wrote:
> Add quick firmware boot tests (less than 1sec) for the
> B160L (32-bit) and C3700 (64-bit) HPPA machines:
> 
>    $ make check-functional-hppa
>    ...
>    4/4 qemu:func-quick+func-hppa / func-hppa-hppa_seabios    OK 0.22s 2 subtests passed
> 
> Remove the duplicated B160L test in qtest/boot-serial-test.c.

Thanks, this only tried to test the "hppa" machine which got renamed, so the 
qtest was only skipping for the hppa target.

Reviewed-by: Thomas Huth <thuth@redhat.com>


