Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2BFC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPWD-0001wg-1P; Wed, 27 Mar 2024 05:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPWC-0001wW-8G
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:24:24 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPWA-0004aw-IN
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:24:23 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-789e2bf854dso383157885a.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711531461; x=1712136261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=36vD2IyTv6tfafKn4ObjwXFWKfxmUeiLPKcX3FNqucc=;
 b=vXJ78wlbkEs3WPwvFyLdJlGTFuHOXade1W5mzt8z9u6Bc44Bgyhfrqrsd1jOBRv6SP
 Dch0KZhsB/Fw4DryQ11qzY/xdY9DxiDKxt6y57BBqz76J83Fykd4ockvY3bzThI8fM5d
 FQfd02fJcJeb7x4kwnGaU9+JN9CVMmVW6EIHpjd3pNsYzqbY0WWZBf08eIPV3bj+9l9O
 YFr8KjEefi5LZi6iEEKq0bXGXSnO8Vn3y2vbDs22rLOxllqp8B/cw/arKnMjPnyQnjBg
 nMKEsfGvA6tW4X6FgfZABeaiK95pxlSga+hEc+h5vQzQIm8L7kxAxbHPwpE7uOx3iOq8
 cH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711531461; x=1712136261;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=36vD2IyTv6tfafKn4ObjwXFWKfxmUeiLPKcX3FNqucc=;
 b=Ch5eFweCLwDLlGfgZSUB703MYpr26qwMZ/3SwdLoh3xYc/Ohhw6b8aDmUUiAesZAMR
 v7H7mnGuGxu/XvGn4oDslWX8zuFdEgLChSYGR7OtZWR3MLSS9CeZV/0XXD/fumLjPH7R
 RZyjYKjvlvsYlAzw4FXBRsNzh2MZ9IESpeZPoaAI7T5ByfsuQ9qkWsNeoo5ZAGQ4tubt
 kuvO78pBDwzy/3//pO8Skq6xAzqpxIikqNogbi4AeGAtfsnEE9Z8svEC+RemJKw9/aEM
 jOGA2dBhUFsHAgqxoWA+4qGLBgbs3zxx/d60d6/MTO/Vsuo6QRgau4fyeP5JMpiAh2sJ
 QZ+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiIDVg2wH2HkqVzYlX9XmJVCKUEzWX6PtpdB0Qr/LhTyucmtz6+Hrc0gRA1y2XFdNTXxvA3jwbHmt+Ww3dhrAuXKDZDjY=
X-Gm-Message-State: AOJu0YyNtjq5fPVu4YYRd1oVQ8Hd6F8IeL5vHzrlhZ48AofSUBsmTeNr
 iOhASgzPCBxpbnkcBb+/VepDRl+dOxP/EYxwFkzON+gNxBr01wHSgF7fVSz2NWQ=
X-Google-Smtp-Source: AGHT+IHz3j1rLl9eLOJB/vBy+hYIDnfMWrxyoSCDMK1vXHX2DGxehu+UDsaivnOekhXoYZFqpVhn9g==
X-Received: by 2002:a05:6214:1948:b0:696:1fd2:1401 with SMTP id
 q8-20020a056214194800b006961fd21401mr777135qvk.49.1711531460733; 
 Wed, 27 Mar 2024 02:24:20 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 4-20020ad45ba4000000b00696ae38c7bfsm437497qvq.35.2024.03.27.02.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 02:24:20 -0700 (PDT)
Message-ID: <4c535b7e-058c-4961-aba5-e4833ea86f33@linaro.org>
Date: Wed, 27 Mar 2024 10:24:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 01/18] hw/i386/pc: Remove deprecated pc-i440fx-2.0
 machine
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240305134221.30924-1-philmd@linaro.org>
 <20240305134221.30924-2-philmd@linaro.org>
 <571fb716-2f13-4ad7-b47b-8104ec46d1d3@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <571fb716-2f13-4ad7-b47b-8104ec46d1d3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x732.google.com
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

On 6/3/24 17:41, Thomas Huth wrote:
> On 05/03/2024 14.42, Philippe Mathieu-Daudé wrote:
>> The pc-i440fx-2.0 machine was deprecated for the 8.2
>> release (see commit c7437f0ddb "docs/about: Mark the
>> old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
>> time to remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   docs/about/deprecated.rst       |  2 +-
>>   docs/about/removed-features.rst |  2 +-
>>   include/hw/i386/pc.h            |  3 ---
>>   hw/i386/pc.c                    | 15 -------------
>>   hw/i386/pc_piix.c               | 37 ---------------------------------
>>   5 files changed, 2 insertions(+), 57 deletions(-)


>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index f5ff970acf..bb7ef31af2 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -311,21 +311,6 @@ GlobalProperty pc_compat_2_1[] = {
>>   };
>>   const size_t pc_compat_2_1_len = G_N_ELEMENTS(pc_compat_2_1);
>> -GlobalProperty pc_compat_2_0[] = {
>> -    PC_CPU_MODEL_IDS("2.0.0")
>> -    { "virtio-scsi-pci", "any_layout", "off" },
>> -    { "PIIX4_PM", "memory-hotplug-support", "off" },
>> -    { "apic", "version", "0x11" },
>> -    { "nec-usb-xhci", "superspeed-ports-first", "off" },
>> -    { "nec-usb-xhci", "force-pcie-endcap", "on" },
>> -    { "pci-serial", "prog_if", "0" },
>> -    { "pci-serial-2x", "prog_if", "0" },
>> -    { "pci-serial-4x", "prog_if", "0" },
>> -    { "virtio-net-pci", "guest_announce", "off" },
>> -    { "ICH9-LPC", "memory-hotplug-support", "off" },
> 
> I think you could clean up memory-hotplug-support for the ICH9-LPC 
> device now, too (in a separate patch).

Great suggestion, thanks!

> 
> For this patch here:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


