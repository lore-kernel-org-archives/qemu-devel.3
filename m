Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2243FC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubcB3-0001DX-HL; Tue, 15 Jul 2025 05:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcB1-0001An-Ka
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:42:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcAz-0001YT-Ci
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:42:19 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45629703011so2005075e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752572534; x=1753177334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FUQDtPtqA9J0WeMqj2rfH7HSR91QxRvxTrz+Nr80bcc=;
 b=yVmj0lkw5Y7vsNmd3OwmWNHkHJEeR0JH++zvqmdyYPbXQqLEEtLRLiVowCguE9OFG3
 r/KpfZgf/BwyDWLxn0w01DT2SlGu18E1yAEqdaYY0q//UrD9NCq3JTxNnOuivxPkVsFj
 S4yL41lalOg98O8t9fo560wzrJcmuTp7Dncv7WWBWmpFrAE9c6yBApj1HQbFEHYrowGN
 AyYWzabqDGkflx0WW3E69aTe1Fx4GQObXtB3z7zJH4Ra1EK2ZjrOGJ6dwVf6wNr4QZIc
 z6e0p9tD+RVFWAro0/7Vn5yrWZPoQWO4ZuvFmYkE/VXIRGjOT2gUYYwxNwKLn9NF4++B
 dk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752572534; x=1753177334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FUQDtPtqA9J0WeMqj2rfH7HSR91QxRvxTrz+Nr80bcc=;
 b=bNAUV4MHN6zRWqyW0QKeXy9jkxk8TaBpm7iFAGnQp2Umxnta9WWwXkA8C61eO+woyh
 JwHX0ROkzxxmwMQppDpxbaXsx+HFGPNrX+SBFNsj4wENjOTapE1/7naQP6rWL+m8HbmU
 VOrnJST4+QyENwFNs0hsi6CFikSX8lDy8IZBm6xG1Qj/btH5MKUQ70PFj9RXXXMovNUw
 sClHJejXXGVqLM9BiKr++ImykqLYvz9Onw05LJTmIRyjQdx8eyzR5hx1VeEzdvz7royn
 FMHNvnSrdP3nTFfyuCph0BLUNXLtLCp/2RFLuw+POBxzak8KAS+24VQpSoq0DE4lfudX
 Hyxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv9rYDBT3hN6TgxF+7diAVtk7zv60ESbAnbyXwtMcyPSoDhHt0YewbOibtmVzAMs5lH9aFEupUAzLW@nongnu.org
X-Gm-Message-State: AOJu0YxhhgfzJIPv9+zyRcQfOIXsIoVPocwKDHDqIJfvce3vSfYqeapY
 w3HeyRQKkeNL8yDcFFmZoOnBdlnezcP8aTstezFGaiyZi5dJL8li+/4MOTftksI5Ey4=
X-Gm-Gg: ASbGncvL6sCEZjywAV1CKb9QXISiKgSlw4HJGZu7oQw7byCe2RJ90FUv8UfomyXqJZ4
 RIM2GAVEs5GOLPZ4AFbSo61iL4LkDkCSFhkgWPp5iIUgpz4HGDRq7jsppJprA4/KKoNjDWCMScc
 UfFlXK3627ug6oNKFV6VXttH8s1SNjMXvc7dnVWe+UhKhO0Y6l4SGUV/TFonLA7a6jNHJjYwEbb
 BnWtWNWP5KUXpxOvi0aKr205EssDYcVDXya2gTe+aRc1ZzGd9tmrd0hB54ErIjRQHarpWUmemGN
 QsRwMC52ICQSyOcD1Z/2Pr/rwCS0JqDsLuGiWIaiuzVNHGlDK7M7caJC1U4fhD9V+hEhpM65NZe
 8AXAzsLTHIiFG/YGxGuZImz/TuUKokBS4XkuM6w2feFG/uzio80Y1EhozYHrPkAjH4rzdBUUH1F
 sozO1feg==
X-Google-Smtp-Source: AGHT+IEq5YncY0ZFSAxUFoScbIe3ZUrufZrrQZwL3RgKMYoJ5AcgErAx0Ri3SdLeS+rPVCEGbIsyPg==
X-Received: by 2002:a05:600c:1ca2:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-4561a699783mr63834885e9.13.1752572533943; 
 Tue, 15 Jul 2025 02:42:13 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562930c719sm8873855e9.28.2025.07.15.02.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:42:13 -0700 (PDT)
Message-ID: <af69d05d-eb73-4f3c-8d53-89d53fb5375b@linaro.org>
Date: Tue, 15 Jul 2025 11:42:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/22] vfio-user/pci.c: update VFIOUserPCIDevice
 declaration
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-12-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715093110.107317-12-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/7/25 11:25, Mark Cave-Ayland wrote:
> Update the VFIOUserPCIDevice declaration so that it is closer to our coding
> guidelines: add a blank line after the parent object.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio-user/pci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index be71c77729..da6fe51809 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -21,6 +21,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
>   
>   struct VFIOUserPCIDevice {
>       VFIOPCIDevice device;

s/device/parent_obj/?

> +
>       SocketAddress *socket;
>       bool send_queued;   /* all sends are queued */
>       uint32_t wait_time; /* timeout for message replies */

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


