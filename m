Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE9DC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxLW-0001Ip-LH; Tue, 12 Mar 2024 04:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxKl-0000xo-Dv
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:18:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxKi-0008Qy-Nj
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:18:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-413328344acso3596655e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231479; x=1710836279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8w2pq46hy0Mz/wZ1vAcx77hNZPpAPfFuAfn0j0C2iDY=;
 b=NDG6lMSnMdVf1DwBxfohlUnEkgqV3QMn27IukHmDHu27U3Wm0G0p5IgX5srqn0o2cY
 irVednWnm/3AC3FCd8FvdlFq9mQJ7Pe1FDXmevW1b4SAaNu2XWPZlr4jGEjpOyDlTbU/
 YMrMu8E8+BUht3s1oTQRU0FArt9pDjdnC0fVuRQ6SAnpIylN3HNxis6hd3jtGF3VTQg8
 MKCFnMAQ0IJ9u/ncI+85s4kZ4VZYtJ2/Uwd2qEnJjHeR9503SNWxZwd/aRxk2HybkWHf
 ohDLfXSwFPpyuRpBXvtpW3fIcffw5pKgBTAp8unaH1nRfEnzzzHghFgeWXrgjPpkDEQx
 NlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231479; x=1710836279;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8w2pq46hy0Mz/wZ1vAcx77hNZPpAPfFuAfn0j0C2iDY=;
 b=kKVIqN/bTfIW/iafc08EVYK1UFbiU53eyCemZ7/FrFONItHNDrgtPcYFCeHYBGtK8/
 8X24EgbRydt7Eh0FG4UR7VQOPA29nJfpr8AnWN+yGR/RKIvWIFcGDgqgXKABjIwyt5+1
 ySaU+mZinGqC1wtldlGA9j9oM/875ri3dUDbPOrlvgmmipfkg6UJgXYBQ8vhAaLJmG33
 PZvv3QegDG7AEMU38TtXWKUiOf38lzKBApur/yu0zKjbHIotWA7MLcxwsNvp/gg5eE/F
 t5pm4i/wWJdwsROcSSyrb357x6FwX3jcePuqVCW/FJoklYppm5LwT6InGjK3nvrCPcrq
 lsnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd9YiH9w4PyL5YyUYtYLDr5/Y7fcLGPn7vJOiNRLbUCTtrtfc5Cg1vGeuLKzJNWBV2Wcv3YwHL4UrWC2Buk2gx6L4I64c=
X-Gm-Message-State: AOJu0Yy++AaaJ6e1K6JMZjKmMm2XiFoClJE5FBAaoVtJXK9M4mQzVEeL
 dUbay3HlaDg0sJ9r9DH7GWikq6SfDiMP5Stn4h6TqDdqe+upG5v+k0GGUE9MQbzLXVXCyiNIrEt
 u
X-Google-Smtp-Source: AGHT+IGrp0PF8uOdr5giTtjGmTX+DeqTRHzhTgTHLVa407dbJ4wRX/WbfdJDkaNI917iniqLUX4EEg==
X-Received: by 2002:a05:600c:4f92:b0:413:3160:841d with SMTP id
 n18-20020a05600c4f9200b004133160841dmr1183854wmq.8.1710231479031; 
 Tue, 12 Mar 2024 01:17:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a05600c46ce00b00412b4dca795sm11617377wmo.7.2024.03.12.01.17.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 01:17:58 -0700 (PDT)
Message-ID: <3ddee848-5625-42f4-bcc0-2b13fb70254f@linaro.org>
Date: Tue, 12 Mar 2024 09:17:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sun4u: remap ebus BAR0 to use unassigned_io_ops instead
 of alias to PCI IO space
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20240311064345.2531197-1-mark.cave-ayland@ilande.co.uk>
 <eadc337e-7575-4756-ab8d-9c951cdde644@linaro.org>
In-Reply-To: <eadc337e-7575-4756-ab8d-9c951cdde644@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/3/24 09:28, Philippe Mathieu-Daudé wrote:
> On 11/3/24 07:43, Mark Cave-Ayland wrote:
>> During kernel startup OpenBSD accesses addresses mapped by BAR0 of the 
>> ebus device
>> but at offsets where no IO devices exist. Before commit 4aa07e8649 
>> ("hw/sparc64/ebus:
>> Access memory regions via pci_address_space_io()") BAR0 was mapped to 
>> legacy IO
>> space which allows accesses to unmapped devices to succeed, but 
>> afterwards these
>> accesses to unmapped PCI IO space cause a memory fault which prevents 
>> OpenBSD from
>> booting.
>>
>> Since no devices are mapped at the addresses accessed by OpenBSD, 
>> change ebus BAR0
>> from a PCI IO space alias to an IO memory region using 
>> unassigned_io_ops which allows
>> these accesses to succeed and so allows OpenBSD to boot once again.
>>
>> Fixes: 4aa07e8649 ("hw/sparc64/ebus: Access memory regions via 
>> pci_address_space_io()")
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> ---
>>
>> [MCA: I'd like to merge this for 9.0 since I've been carrying various 
>> local workarounds
>> to allow OpenBSD to boot on SPARC64 for some time.]
> 
> Sure.

Patch queued!

