Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0FACA0EE6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 11:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umWRN-0005sN-9D; Thu, 14 Aug 2025 07:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umWRK-0005rD-2b
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 07:48:14 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umWRF-0002WZ-HY
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 07:48:13 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b9e41101d4so439044f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755172082; x=1755776882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qffpsmd9KZunZ/5hKG3AYa5TWm/pt6oeiktvEU5DzPE=;
 b=Pg671p31Pngg6OQ4nCTPzCKrGwRlq1qkRVeWgv+cdcCnAEjhKQHBQtOv45RQ9PnIY2
 G3BS+g2PtNwqaxBld6K2Bg6hLkragGqz3MglQwg+gG5YmQXBBEU67+L+haE+lnodJ3mH
 2n3NVMItBoN0imv9ZiHSqZWMA983Di+M/ih3mhydRv6R6Ki1F+mwsnqIcLMuhw3huu/E
 22rJs05eHYfj39N/4sNciBKPY7ROs7Dksp9TcfymvhOqB7pGzahRW7j/3OdiZ+NsQ/Iv
 q2VN9CoEnbrVrMv6eV1W5GpJnV00ScP5UazfgSBzYTR7pbnoP2ubVnPF1lL/vS6JdoTy
 JjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755172082; x=1755776882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qffpsmd9KZunZ/5hKG3AYa5TWm/pt6oeiktvEU5DzPE=;
 b=OR+ijqvk56ZB/XI9jykD4rLDp7UIwf/lMHGqUoe/Ry9A8deUaSLUvFm32qFcryLPPW
 4nG58u6p3JIbNnLXCANoWG61S/8eXbVbapyUy+F1XOv38fky7SKNYmqM+/Ex/cFgfaY1
 9xcyUen1X6vQPfqNR6EpOACSf2v8EavguA4cbjBpz8uSZfFcWujcphGuEUQ8dnDAo2Lk
 QvzQdu1o+GqB/KWhKpCiRxfWOofgTqZQ49DTjRqsBrHYXHwbQxAJDvrArOHdMmGvfVSY
 fdjII0omXxhQ7Z14cwf1xcuqVbhti1yitgmtFqr7PJmahKL4B90NGKlZnfD3Znngap2G
 wmsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw5Byft+SyVaL2pfN9uNKmRHlNOEqv1cSz0O0Xo5vwvDv3dYbMfT0lRbuIYhCRBbssg0SNf9q/mi0w@nongnu.org
X-Gm-Message-State: AOJu0YxC3BWRn58MQ0wHyIu4VKl52qePA9QO7eTtRfbBLKVwfI8zfFtf
 rEwJE32C3ATpmqAe+nr/IveFuVJCzTpYZhY8HbywhxgQvFYHnoiAjd5qGCIYHR6wEk0=
X-Gm-Gg: ASbGncu0hZv4+XLLqeY9pXZ53MxyMaN5eJ8akaKaWa7uon3FmJ72lpowr2t5LnL0gJ+
 8zC9Glv3x67flUWA6/SNgAxetjj5Z7YY9286qdieDvKBqmaM2/CeCSp63MGEolnv5s3lL9WixtS
 Z43NHZl5hq/kVtkVDDLF+2bQ4nIP8itRScoTwl1MN3gKZWfnHCDmjG80CK/hMpTYFaSnQKXsrD/
 gjEONS7whlf8QhraKwtetpdobeHwez22+n9btIB5F2+Nst/mYDjU30K+KyrfDs+40HfKcPQN8oA
 +AtLkTyDWuxf+Pe+xa7UPpun1u8VSSlo1NsvCNgBWyvGjBts6hcPWWZdER2uoQR4jAYP3qQ8OuU
 McvbrupY2i92sxdlx4vagI7s1z+LrwwMayQZsSwueDhgJuvue7p3PHa53d2Rl3LQLnA==
X-Google-Smtp-Source: AGHT+IELlpBp4cJiaNEHnUtc7b8WIRZUnZRa6F+7lQ5Pbk6io8Or6kI5XegCU/RpK4thnktHTWdFww==
X-Received: by 2002:a05:6000:240b:b0:3b7:fbe3:66bb with SMTP id
 ffacd0b85a97d-3b9fc3701f4mr2390506f8f.50.1755172082114; 
 Thu, 14 Aug 2025 04:48:02 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8ff860acbsm24323237f8f.51.2025.08.14.04.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 04:48:01 -0700 (PDT)
Message-ID: <426f2edc-9495-4796-abd1-b5de6529f015@linaro.org>
Date: Thu, 14 Aug 2025 13:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-pci: add defensive check for vector_irqfd
To: gerben@altlinux.org, qemu-devel@nongnu.org, mst@redhat.com
Cc: sdl.qemu@linuxtesting.org
References: <20250814110830.14660-1-gerben@altlinux.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250814110830.14660-1-gerben@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Denis,

On 14/8/25 13:08, gerben@altlinux.org wrote:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> Add a NULL check for proxy->vector_irqfd in
> virtio_pci_one_vector_unmask() before taking the irqfd path.
> This prevents potential access to uninitialized state if
> vector_irqfd is absent.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Reported-by: Alexey Appolonov <alexey@altlinux.org>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>   hw/virtio/virtio-pci.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 767216d795..07904f6f9b 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1015,7 +1015,11 @@ static int virtio_pci_one_vector_unmask(VirtIOPCIProxy *proxy,
>               event_notifier_set(n);
>           }
>       } else {
> -        ret = kvm_virtio_pci_irqfd_use(proxy, n, vector);
> +        if (proxy->vector_irqfd) {

Why check the callers and not once in the callee?

> +            ret = kvm_virtio_pci_irqfd_use(proxy, n, vector);
> +        } else {
> +            ret = -EFAULT;
> +        }
>       }
>       return ret;
>   }


