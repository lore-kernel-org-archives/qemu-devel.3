Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272A9CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE18N-00038s-Ow; Wed, 29 Oct 2025 04:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE17a-0002mu-RF
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE17M-0003HT-3Y
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761724872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uLXSoRHam4XODuFX6V9SmzU5hdolKnRMNDurEhPR/zM=;
 b=V8Gm7O/jU+F4QOK98elRdwwcZ4ctzySYMFuSG2jNVn2VJO91au+/aRU074yGK5AD8eK9W2
 9MBUvozVkC1ENMDwN6UDJyGYXikfwsVWcu4GMRz02Z4xS2Xk8R7mqA7fB1Ef8vc9UOtx6N
 FOJGfqMmPkf419E8+ZOhKEZITVtWDsA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Vg4EAccCPDuUg5Kk28vfNg-1; Wed, 29 Oct 2025 04:01:10 -0400
X-MC-Unique: Vg4EAccCPDuUg5Kk28vfNg-1
X-Mimecast-MFC-AGG-ID: Vg4EAccCPDuUg5Kk28vfNg_1761724869
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-471168953bdso5918395e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761724869; x=1762329669;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uLXSoRHam4XODuFX6V9SmzU5hdolKnRMNDurEhPR/zM=;
 b=sCnmSbPqChhzsQAVQLUksXbUXsByysyV0szeXcVnsEqAIsdTWECSGC1x2mZH5FqeCO
 YBmw7CB493kDER6ISyK4aTG5E5L0ulK50xIkVfvmjqlJZGcqrt+JBX7Ftdu27w/Nlt9C
 IRw/pQcHabqc1V1VQ3hvGhdOY8hOpo7xJe0nDOXphyRfp0zZ1mUIYw/c2P3zOcc/M6iM
 Zi5FYRUKgn+vYUgl3RI/+N3CebjuoNcgQHVKjyOnQqZDu5PwJdhtJReY1rE7hgA4/lZE
 zbXaHQXbPVn4Mk2wXHHAHtv9kswDVOSw2h79gr27M8kYWhW78zfF9pqqyiNDJTJPTiWk
 Jivg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV47fEboQ5BNsHUvk2ovw1tnwtJBj7lUz/nlMncppXvNV+4FAmIRObWEzO4nuvvEkPz2AYEaDyT1eb9@nongnu.org
X-Gm-Message-State: AOJu0YzHBRdbuDdXcQOkqMgKGavsG1myJxcPjm3N8TD0blVCbl2m8jjL
 vR92fPdcXduUGXPX8WD4WNktdU37A9bUpoh7BBg9xRlOJmL426vmheWvZnK5FZZeslvo6E5xjKV
 cKwVMdqtokF/TNli1bWWhsyRvV4tX8TZLwEObhaAT09GzZZdwRcJOoOMv
X-Gm-Gg: ASbGncsyHaSzdcLqd685jRGSALFctLciBwTuVVpnWgt8JPy17VaD6PX4adQ81ByTPTx
 Ka9aRE9WsL/Z0SQaZgKJTuH/40XYm2OGdZT8y21alEonGwOdrc7xBtt9Mz+eKqPDp/F+HgVJcUE
 Em6hpKhjzqox8gOglcPY0mqwgODfSwylscuMcTIKQBqgosDdL/EEZChr5v4l6wAWgRfH3Ng1ZF5
 8YRmiQ4bEwljsA7t7U1dKn+msOgsPzvHxtsD9ua1r737KbLKFIZkBU4xizPjXaO2GlzHkHXwuim
 sAlYxqb5U2ApQTTu4SCMC4PKaQMAZrjjcENcfvmOAB8zN3BrJzHovNmJFNAK2BGDNUCnExQ=
X-Received: by 2002:a05:600c:6d06:b0:475:de06:dbaf with SMTP id
 5b1f17b1804b1-477181a46e6mr34152865e9.17.1761724868910; 
 Wed, 29 Oct 2025 01:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5MyaZE3wF3ALC7Ez5Ufg67ebvu+/KhqekXlwQFwxluqxyur3m+SZ14Xg8tVPDKpjaxQJfsQ==
X-Received: by 2002:a05:600c:6d06:b0:475:de06:dbaf with SMTP id
 5b1f17b1804b1-477181a46e6mr34152595e9.17.1761724868419; 
 Wed, 29 Oct 2025 01:01:08 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952da12dsm25281621f8f.29.2025.10.29.01.01.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:01:08 -0700 (PDT)
Message-ID: <0a951fde-2ea9-4707-b80a-26d33475d35f@redhat.com>
Date: Wed, 29 Oct 2025 09:01:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/bcm283x: Initialize CPU objects in SoC common
 DeviceRealize()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251029075257.63635-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251029075257.63635-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/10/2025 08.52, Philippe Mathieu-Daudé wrote:
> QOM .instance_init() handler can not fail. QDev DeviceRealize
> can.
> 
> The device-introspect QTest enumerates all QDev types and
> instantiate each one, without realizing it, then introspects
> the instance properties.
> 
> When switching to a single QEMU binary, all QDev types are
> available in the binary, but only a filtered subset might be
> available, depending on which previous target the binary is
> trying to mimic.
> 
> In particular with the Raspi machines, the TYPE_RASPI4B_MACHINE
> and ARM_CPU_TYPE_NAME("cortex-a72") will be built in the
> qemu-system-arm binary, while not available (because filtered
> as being 64-bit, for the qemu-system-aarch64 binary).
> 
> However the TYPE_BCM2838 SoC is not filtered out, and will
> abort when being initialized, because the "cortex-a72" CPU type
> is filtered out, leading to device-introspect failure:
> 
>    1/1 qemu:qtest+qtest-arm / qtest-arm/device-introspect-test        ERROR            2.46s   killed by signal 6 SIGABRT
>    stderr:
>    unknown type 'cortex-a72-arm-cpu'
>    Broken pipe
>    ../../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
>    (test program exited with status code -6)
>    TAP parsing error: Too few tests run (expected 167, got 5)
> 
> In order to avoid that, move the CPU *initialization* in the
> SoC DeviceRealize handler, so the SoC initialization won't
> fail, while realization still will.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/bcm2836.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index cd61ba15054..6e4066f137d 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -25,12 +25,7 @@ static void bcm283x_base_init(Object *obj)
>   {
>       BCM283XBaseState *s = BCM283X_BASE(obj);
>       BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(obj);
> -    int n;
>   
> -    for (n = 0; n < bc->core_count; n++) {
> -        object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
> -                                bc->cpu_type);
> -    }
>       if (bc->core_count > 1) {
>           qdev_property_add_static(DEVICE(obj), &bcm2836_enabled_cores_property);
>           qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count);
> @@ -65,6 +60,11 @@ bool bcm283x_common_realize(DeviceState *dev, BCMSocPeripheralBaseState *ps,
>       BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(dev);
>       Object *obj;
>   
> +    for (int n = 0; n < bc->core_count; n++) {
> +        object_initialize_child(OBJECT(dev), "cpu[*]", &s->cpu[n].core,
> +                                bc->cpu_type);
> +    }
> +
>       /* common peripherals from bcm2835 */
>   
>       obj = object_property_get_link(OBJECT(dev), "ram", &error_abort);

Reviewed-by: Thomas Huth <thuth@redhat.com>


