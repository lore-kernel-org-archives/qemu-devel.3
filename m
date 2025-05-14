Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D801CC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFC9F-00019g-3e; Wed, 14 May 2025 09:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFC9C-00016C-E6
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFC99-00069V-4s
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747229260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zDFYHZ3bbBEkqAbhA3DrQTSC2eCpc7SnEgdhQCFd5xo=;
 b=SHUadvsD2MEXPajdDz1/DWeI9JN5GSkrrQTuNiL7m/3BRfKjMtDuU4V2r5xk/G1JJT1Adj
 DaCyoDRnmBCkJjR71pJhMxU7ieXR9WlgEW24DuHqqwtKqBfGcAM6fWc0TOxZRqOczfvk+K
 c3uyIkRFSXa0Nj2IJha3gHJZ3y5I4gk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-d8TJJRhdMHaY9B-I5d5fTQ-1; Wed, 14 May 2025 09:27:38 -0400
X-MC-Unique: d8TJJRhdMHaY9B-I5d5fTQ-1
X-Mimecast-MFC-AGG-ID: d8TJJRhdMHaY9B-I5d5fTQ_1747229257
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442d472cf7fso41728915e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 06:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747229257; x=1747834057;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDFYHZ3bbBEkqAbhA3DrQTSC2eCpc7SnEgdhQCFd5xo=;
 b=Z+oGG3tRSbHTVfNwc4B2rMVh5OsHv0VVToRxC8AUcQgZs/S5TN5gcOA4E+5IGQRY/t
 IwC+MgTnzdko1nnXA8/BYyEZ5r9PKJeJosp3Tm1BuGBL3ZT3lGpAw4NcHa/pTdF2GO7/
 EXgFqy4tqnMrzsrFdkBi+uf+omurVYd2v8FLKwc81v8t1V7Do+Mcm4ilODdMAGG/LrF0
 9B6JwuXk4hnzbkQgfJ8mV62oB38/lc2FAfO6/3ILeR3D3mr7GmDPbxEwu2vupEnyk1aB
 FRw298AZNib6E96rVie9QXNSj4VGm2Fp6CeXSK9LEMibBlqS9ncv869tQzwgIP8e+78X
 lErA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE+E9/CzQPafK/B/OZNd0TqDH1qHNZX+n5xgCbthUz62LSWWaDqh914J58lUej8guUxceuJ0qMdy72@nongnu.org
X-Gm-Message-State: AOJu0Yzreo20vg9dORJ3yLxImzo8I6J4PjAN2D9kVJLyu0ZqpaMK+ZV0
 gc5Xrmz0jQlej7qOS2NZd/C5qWCnIWejgKXUAQlHJKxy7mpgxEkho0DWECdIANNDfL/EeAb1O13
 A5XJslj2Kc6XRkyrgNVOAAjlgE2b6cnRfbOA1GHYx0GDoB51+qHvg
X-Gm-Gg: ASbGnct4MQkoIqKC7xGmJ4K6VsP3TqHf+2Tn7qlhOXIOqZdbVRGdXcV52cIS6CxaoEm
 mRShOthZnTtmFy+Bc2frjCbWKmvI53x2f1MCDYJKgTzZOiAeIQJFq68XZxI9pNJed2uYN0jctN+
 uZyO9tdorcuT/jZXB/OYBryQPeDrfnQZR5jOifDfs/aoQn6CBaNGixV1QnmpoHRb5tHN8X3dbXD
 tP1kdZ3ZxgofLuwHuqwjsPLnA1z+8IUBuVu0nGY/U/GzKk4JqWCGuhrXrC2gJ1Sw31AdziIQo4a
 tsupq4GjSwkI6FZJT8AuItGGVKTOS9quZwb6oxvbgm+ri/8sxg==
X-Received: by 2002:a05:6000:144e:b0:39f:7e99:5e8c with SMTP id
 ffacd0b85a97d-3a349966789mr2787297f8f.51.1747229257472; 
 Wed, 14 May 2025 06:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHE7jZk1J9w59Yc2DBrD5D0VY5tQ7pJUphIp4utvT/dpa0iUVN+sepvgzUKk75vDFrpUNHtQ==
X-Received: by 2002:a05:6000:144e:b0:39f:7e99:5e8c with SMTP id
 ffacd0b85a97d-3a349966789mr2787267f8f.51.1747229257071; 
 Wed, 14 May 2025 06:27:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4bbf0sm19432355f8f.82.2025.05.14.06.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 06:27:36 -0700 (PDT)
Message-ID: <76676e3b-1b3a-48e7-9bd3-3017df35b31b@redhat.com>
Date: Wed, 14 May 2025 15:27:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] hw/arm/aspeed_ast2700-fc: Fix null pointer
 dereference in ca35 init
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, longzl2@lenovo.com, yunlin.tang@aspeedtech.com
References: <20250514090354.1461717-1-steven_lee@aspeedtech.com>
 <20250514090354.1461717-2-steven_lee@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250514090354.1461717-2-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/14/25 11:03, Steven Lee wrote:
> Clang's sanitizer reports a runtime error when booting with
> '-net nic -net user', due to a null pointer being passed
> to memory_region_find(), which subsequently triggers a crash in
> flatview_lookup().
> 
> Root cause:
> - Missing NIC configuration in the CA35 initialization.
> 
> Fix:
> - Reduce ca35 ram size from 2GiB to 1GiB to align with ast2700a1-evb,
>    where the ram-container is defined as 1GiB in its class.
> - Add nic configuration in ast2700fc's ca35 init function.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0-fc.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> index 125a3ade40..ff64605663 100644
> --- a/hw/arm/aspeed_ast27x0-fc.c
> +++ b/hw/arm/aspeed_ast27x0-fc.c
> @@ -48,7 +48,7 @@ struct Ast2700FCState {
>       bool mmio_exec;
>   };
>   
> -#define AST2700FC_BMC_RAM_SIZE (2 * GiB)
> +#define AST2700FC_BMC_RAM_SIZE (1 * GiB)
>   #define AST2700FC_CM4_DRAM_SIZE (32 * MiB)
>   
>   #define AST2700FC_HW_STRAP1 0x000000C0
> @@ -59,6 +59,7 @@ struct Ast2700FCState {
>   static void ast2700fc_ca35_init(MachineState *machine)
>   {
>       Ast2700FCState *s = AST2700A1FC(machine);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(machine);
>       AspeedSoCState *soc;
>       AspeedSoCClass *sc;
>   
> @@ -86,6 +87,14 @@ static void ast2700fc_ca35_init(MachineState *machine)
>                                    AST2700FC_BMC_RAM_SIZE, &error_abort)) {
>           return;
>       }
> +
> +    for (int i = 0; i < sc->macs_num; i++) {
> +        if ((amc->macs_mask & (1 << i)) &&
> +            !qemu_configure_nic_device(DEVICE(&soc->ftgmac100[i]),
> +                                       true, NULL)) {
> +            break;
> +        }
> +    }
>       if (!object_property_set_int(OBJECT(&s->ca35), "hw-strap1",
>                                    AST2700FC_HW_STRAP1, &error_abort)) {
>           return;
> @@ -171,6 +180,7 @@ static void ast2700fc_init(MachineState *machine)
>   static void ast2700fc_class_init(ObjectClass *oc, const void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
>   
>       mc->alias = "ast2700fc";
>       mc->desc = "ast2700 full core support";
> @@ -178,12 +188,13 @@ static void ast2700fc_class_init(ObjectClass *oc, const void *data)
>       mc->no_floppy = 1;
>       mc->no_cdrom = 1;
>       mc->min_cpus = mc->max_cpus = mc->default_cpus = 6;
> +    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
>   }
>   
>   static const TypeInfo ast2700fc_types[] = {
>       {
>           .name           = MACHINE_TYPE_NAME("ast2700fc"),
> -        .parent         = TYPE_MACHINE,
> +        .parent         = TYPE_ASPEED_MACHINE,
>           .class_init     = ast2700fc_class_init,
>           .instance_size  = sizeof(Ast2700FCState),
>       },

The "ast2700fc" machine cannot inherit from TYPE_ASPEED_MACHINE.
These are two different type of machines.

An "ast2700fc" machine state is described by :

     struct Ast2700FCState {
         MachineState parent_obj;
     
         MemoryRegion ca35_memory;
         MemoryRegion ca35_dram;
         MemoryRegion ssp_memory;
         MemoryRegion tsp_memory;
     
         Clock *ssp_sysclk;
         Clock *tsp_sysclk;
     
         Aspeed27x0SoCState ca35;
         Aspeed27x0SSPSoCState ssp;
         Aspeed27x0TSPSoCState tsp;
     
         bool mmio_exec;
     };
     
and a TYPE_ASPEED_MACHINE machine state is described by :

     struct AspeedMachineState {
         /* Private */
         MachineState parent_obj;
         /* Public */
     
         AspeedSoCState *soc;
         MemoryRegion boot_rom;
         bool mmio_exec;
         uint32_t uart_chosen;
         char *fmc_model;
         char *spi_model;
         uint32_t hw_strap1;
     };

These are not compatible.

You will need to redefine the attributes (state and class) you need
in the "ast2700fc" machine.


Thanks,

C.



