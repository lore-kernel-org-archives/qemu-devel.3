Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A9EC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 07:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscl4-0001og-G0; Thu, 13 Mar 2025 03:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsckq-0001lR-1J
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tsckn-0000jh-RG
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741849995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZeCl4YFFkg8EsfM706WnpDD4OpEDEXoMNVNBR/VrAJ8=;
 b=ZEnNOGvn09zQVB5ywnTMyWhf9qh9l9sAvtwL1vu/Y6gGxEIzTTZPZS0ou2kRxE8jgC52fA
 OfMNwgsRSAgw8YinBEGdLSAFV0eXObk3WnJTlYwJP1o19VgN3B095n3mH3X16wa1DC6L/e
 UdDSh2zIHaiUhHwjQ3O9893nS3qVR/4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-d_WYmxX-PIu84mWrgwLu8Q-1; Thu, 13 Mar 2025 03:13:13 -0400
X-MC-Unique: d_WYmxX-PIu84mWrgwLu8Q-1
X-Mimecast-MFC-AGG-ID: d_WYmxX-PIu84mWrgwLu8Q_1741849992
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d08915f61so2647505e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 00:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741849992; x=1742454792;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZeCl4YFFkg8EsfM706WnpDD4OpEDEXoMNVNBR/VrAJ8=;
 b=VGGny6Nzymh8h+2hahCeDVREWlzUZd4dHHACVutMxy/6MOKZNJwDYnH03JoRDC5f2Y
 rhQB4fC75O5d6/TnDu7KkCj/1f3ip4c0vKHlmS8pO3sJwaHNzfRofb6jliCiRHibXzia
 I1ijAx8CYe9GuHLze2xzG5V/CMY5yUXczdEztPqReICHVqdlGPm9CfMnx7GuE+5OP8T6
 KlpjA7AwATAD9uqmVJLfdx0MUkJgEIuOm8xzK24ZpEUqzMYQS2grJfQ6PPo872ZpVq0W
 UPAf+JCKYmLduELUD0Jn4GLJEmINaFu06M3YduQFT+eP5vdlsD4B+UyU1I4g0Oz5dYZK
 CGxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxCOhkle6k+DB5uV9hVcbGLp4iWuiWSTO5dlRNaczF5+jiBD4KKCYx4rmA2KJ/fDu0bvh7zXGSwiqU@nongnu.org
X-Gm-Message-State: AOJu0YynzgNI9uHyfWDZfUTURiqPYq15+cFdMRii07rJlRSuhKckbdJQ
 5GR4N9l58aYqaYos5nYXmCVMC6aw5Sa+huGzsGXF1xujy/XNGTaGv5PihdOEDUIfGJ/l5uxqBeo
 6AnMCofmBUu3x+r/gGZy3sKNcMXaHR4LfnKCR9R9t2RuHAwnHVRH8
X-Gm-Gg: ASbGncsFhc9uQAbnnLYuMmj386zlRMbrthPkaoCCzY0JHxnHntMtW1/MiO2BT/m8KuN
 TxjWewFcykwB35d75MKhUiLB0H6XA9JpQCZKkQ19wUO1F5aSqLG5bFxsxY7KaM+/QGh2KJsuxjz
 +juM5wSRZAAzWmCdnrezBahhh5WOcj9DFLcR/H3RIYXHtU1Y04NKuk+f750c0FcO2DbPMPn/pI8
 au5SH4EOyJTxiuFx1/fL9PZGMKNZhhZGxdx8GckPUtzn7H562tpc/Kt7xUBm0Hd2BTQuhDZDAWH
 GMBXE/IycuzooVYg2szxVVp/eT3uZgF72z9FdYy9EwRxB8k=
X-Received: by 2002:a05:6000:144d:b0:391:2e58:f085 with SMTP id
 ffacd0b85a97d-39132dab192mr19201852f8f.54.1741849992522; 
 Thu, 13 Mar 2025 00:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs8btHNb5qk/wRSmSEDdwyD94EGegHVCRogu04ZjtRkBvAwf+Zdk/wftPE15yOxgh6AIGhmg==
X-Received: by 2002:a05:6000:144d:b0:391:2e58:f085 with SMTP id
 ffacd0b85a97d-39132dab192mr19201834f8f.54.1741849992158; 
 Thu, 13 Mar 2025 00:13:12 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d188b74b0sm10342515e9.15.2025.03.13.00.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 00:13:11 -0700 (PDT)
Message-ID: <e554655e-7f28-4d45-8faa-3c06b72f74ad@redhat.com>
Date: Thu, 13 Mar 2025 08:13:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: skip vulkan test if mssing
 vulkaninfo
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250312190314.1632357-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250312190314.1632357-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


Missing "i" in "mssing" in the subject.

On 12/03/2025 20.03, Alex Bennée wrote:
> I could have sworn I had this is a previous iteration of the patches
> but I guess it got lost in a re-base. As we are going to call
> vulkaninfo to probe for "bad" drivers we need to skip if the binary
> isn't available.
> 
> Fixes: 9f7e493d11 (tests/functional: skip vulkan tests with nVidia)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/test_aarch64_virt_gpu.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
> index f19a47f8b6..314d994a7a 100755
> --- a/tests/functional/test_aarch64_virt_gpu.py
> +++ b/tests/functional/test_aarch64_virt_gpu.py
> @@ -115,6 +115,7 @@ def test_aarch64_virt_with_virgl_blobs_gpu(self):
>           self._run_virt_weston_test("glmark2-wayland -b:duration=1.0")
>   
>       @skipIfMissingCommands('zstd')
> +    @skipIfMissingCommands('vulkaninfo')
>       def test_aarch64_virt_with_vulkan_gpu(self):

The check_output call in this function is already wrapped with a try-except 
statement, isn't that enough already?

  Thomas


