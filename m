Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C17FC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcsZk-0001fu-7a; Tue, 28 Jan 2025 15:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcsZi-0001fi-Lc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:52:47 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcsZg-0001Ot-IZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:52:46 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2166f1e589cso40784525ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738097562; x=1738702362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+AY5k8k+TxGfxhluS8BQjjUBCxahKfmtXeetBu/eOuo=;
 b=L6C4HsH61LD8TBbOSWyxTeXfLQvBYAwVMDmhSTO7JmVON2dwbjOUnTELGS4N6bQ14/
 IP4/HnCh3LcpvXDRKt7McxKG6vHW3PVEgssKt6DMoOdW7uPSkLy3mRGXsM4G7Ks4groI
 KMveWDZ589lwPt2HdbX8ZDNfSPjVTAV1fz0bZwr4AYjXJ0k6h0qIVCJB7sNi+i96LoPb
 yn8iFybDfUOyggtQOY0BVRnD9bwEOJASnJ/Dh88U34nRSydZPl83Dh+z1Z98DdsqZ5CF
 jaOjgj2V+X7/8xPKIqASVI2y8bkmBDHtDT/BQJ0B5jJ8JgGUcMOD29WaUkOvXY3ogX2f
 6d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738097562; x=1738702362;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+AY5k8k+TxGfxhluS8BQjjUBCxahKfmtXeetBu/eOuo=;
 b=Jx6+vY7AvLNHbZuQg4zWO44QPE7a8E4Oe5dnKNxAqucPaoCrlPSlhX3H5fmK1Mfa1F
 /Whow0wPoTbuNRtJFxMWc1PDOWDeewZ0MJFsh/uwFddme//6cXhnbN2+CSOBk9KvKtXB
 YoDI4buG3NInwXH+zFnlqFtXAIuAXhtWrt0Yv3Aq/GaHDRzTrpt5JJxws/bzLzU9729Y
 YD0piEc0HH4sr2GonSn26fZeGL5q1l0eQ0PQh6kHCmJOGqBxQ/cH4xaY34wD3BmW2fRQ
 H6WgsKNDeoAAym9FZ0WnhSwN2rPGA39oJFIuyNRr/XKYFnYxEycVOnpGkq3eCHk4CWBg
 7GvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlhWBh9h6rpNcmjMBgCDcp2Cr+PHIEl92GhA9+EQ0tv+l6prXshw8RpSdw2+/gdhP0vBFU7O48V0OL@nongnu.org
X-Gm-Message-State: AOJu0Yx3uN9LpSddmqHPhH1px7aUsBGLM6azvLdzpahKfQ7wyoOSs2rU
 ofhxLunFT47fN2oQ0N/34WClCS8HRahdEHKL3XTv9LwRou1VM+RdWhPcwPpZgKg=
X-Gm-Gg: ASbGnctutK9D6u8h16tF4G4zmZ2jjeZCg0eqUGih7RekN+d95ufb9an5D8sm7DdsGOx
 5aWuQzGCY9uRqEwa/OlSZWPFQ+1zYZX6iWXGqugmtOgEd7k5xbaG2asoAtpWsLAe4VhKnOekg10
 eLmL/Me4eDUCErqOMeFameOPOzFzASvqTgqOdiFQn+BkdLejZsiQITjxNEoqP2Zz8nezMSWPtUN
 IblLcpJoas24gW4iAuWjxi2nlmA0q+6RTLT+8Z8h9JXmjtqwr6DVTJmhvouD9Moe2OYz+HT6Yvb
 AABqc74gd1oTDysJJuQocBgGXwM3duZNAl2WCdp7xDrefcAssGz+U1LoeTvRGbfRDndq
X-Google-Smtp-Source: AGHT+IHX2b3c+1wIXKNlrq6ihzfzwVqiA1uBVnrtcveXRo1EFuqKfUsw89gpnINxgCOGI5vhU71s/g==
X-Received: by 2002:a05:6a21:1807:b0:1e1:932e:b348 with SMTP id
 adf61e73a8af0-1ed7a6236eamr1093398637.41.1738097561894; 
 Tue, 28 Jan 2025 12:52:41 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a78dfa2sm9626014b3a.157.2025.01.28.12.52.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 12:52:41 -0800 (PST)
Message-ID: <b7646baf-a07d-4ded-804c-6809173c1f6b@linaro.org>
Date: Tue, 28 Jan 2025 12:52:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/9] hw/qdev: Introduce DeviceClass::[un]wire()
 handlers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250128142152.9889-1-philmd@linaro.org>
 <20250128142152.9889-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128142152.9889-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/28/25 06:21, Philippe Mathieu-Daudé wrote:
> We are trying to understand what means "a qdev is realized".
> One explanation was "the device is guest visible"; however
> many devices are realized before being mapped, thus are not
> "guest visible". Some devices map / wire their IRQs before
> being realized (such ISA devices). There is a need for devices
> to be "automatically" mapped/wired (see [2]) such CLI-created
> devices, but this apply generically to dynamic machines.
> 
> Currently the device creation steps are expected to roughly be:
> 
>    (external use)                (QDev core)                   (Device Impl)
>     ~~~~~~~~~~~~                  ~~~~~~~~~                     ~~~~~~~~~~~
> 
>                                 INIT enter
>                     ----->
>                           +----------------------+
>                           |    Allocate state    |
>                           +----------------------+
>                                                   ----->
>                                                          +---------------------+
>                                                          | INIT children       |
>                                                          |                     |
>                                                          | Alias children properties
>                                                          |                     |
>                                                          | Expose properties   |
>                                  INIT exit               +---------------------+
>                     <-----------------------------------
>   +----------------+
>   | set properties |
>   |                |
>   | set ClkIn      |
>   +----------------+          REALIZE enter
>                     ---------------------------------->
>                                                         +----------------------+
>                                                         | Use config properties|
>                                                         |                      |
>                                                         | Realize children     |
>                                                         |                      |
>                                                         | Init GPIOs/IRQs      |
>                                                         |                      |
>                                                         | Init MemoryRegions   |
>                                                         +----------------------+
>                                 REALIZE exit
>                     <-----------------------------------                        ----  "realized" / "guest visible"
> +-----------------+
> | Explicit wiring:|
> |   IRQs          |
> |   I/O / Mem     |
> |   ClkOut        |
> +-----------------+             RESET enter
>                      --------------------------------->
>                                                         +----------------------+
>                                                         | Reset default values |
>                                                         +----------------------+
> 
> But as mentioned, various devices "wire" parts before they exit
> the "realize" step.
> In order to clarify, I'm trying to enforce what can be done
> *before* and *after* realization.
> 
> *after* a device is expected to be stable (no more configurable)
> and fully usable.
> 
> To be able to use internal/auto wiring (such ISA devices) and
> keep the current external/explicit wiring, I propose to add an
> extra "internal wiring" step, happening after the REALIZE step
> as:
> 
>    (external use)                (QDev core)                   (Device Impl)
>     ~~~~~~~~~~~~                  ~~~~~~~~~                     ~~~~~~~~~~~
> 
>                                 INIT enter
>                     ----->
>                           +----------------------+
>                           |    Allocate state    |
>                           +----------------------+
>                                                   ----->
>                                                          +---------------------+
>                                                          | INIT children       |
>                                                          |                     |
>                                                          | Alias children properties
>                                                          |                     |
>                                                          | Expose properties   |
>                                  INIT exit               +---------------------+
>                     <-----------------------------------
>   +----------------+
>   | set properties |
>   |                |
>   | set ClkIn      |
>   +----------------+          REALIZE enter
>                     ---------------------------------->
>                                                         +----------------------+
>                                                         | Use config properties|
>                                                         |                      |
>                                                         | Realize children     |
>                                                         |                      |
>                                                         | Init GPIOs/IRQs      |
>                                                         |                      |
>                                                         | Init MemoryRegions   |
>                                                         +----------------------+
>                                 REALIZE exit       <---
>                           +----------------------+
>                           | Internal auto wiring |
>                           |   IRQs               |  (i.e. ISA bus)
>                           |   I/O / Mem          |
>                           |   ClkOut             |
>                           +----------------------+
>                      <---                                                       ----  "realized"
> +-----------------+
> | External wiring:|
> |   IRQs          |
> |   I/O / Mem     |
> |   ClkOut        |
> +-----------------+             RESET enter                                    ----  "guest visible"
>                      --------------------------------->
>                                                         +----------------------+
>                                                         | Reset default values |
>                                                         +----------------------+
> 
> The "realized" point is not changed. "guest visible" concept only
> occurs *after* wiring, just before the reset phase.
> 
> This change introduces the DeviceClass::wire handler within qdev
> core realization code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/qdev-core.h |  7 +++++++
>   hw/core/qdev.c         | 20 +++++++++++++++++++-
>   2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 530f3da7021..021bb7afdc0 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -102,7 +102,12 @@ typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
>    * @props: Properties accessing state fields.
>    * @realize: Callback function invoked when the #DeviceState:realized
>    * property is changed to %true.
> + * @wire: Callback function called after @realize to connect IRQs,
> + * clocks and map memories. Can not fail.
> + * @unwire: Callback function to undo @wire. Called before @unrealize.
> + * Can not fail.
>    * @unrealize: Callback function invoked when the #DeviceState:realized
> + * property is changed to %false. Can not fail.
>    * property is changed to %false.
>    * @sync_config: Callback function invoked when QMP command device-sync-config
>    * is called. Should synchronize device configuration from host to guest part
> @@ -171,6 +176,8 @@ struct DeviceClass {
>        */
>       DeviceReset legacy_reset;
>       DeviceRealize realize;
> +    void (*wire)(DeviceState *dev);
> +    void (*unwire)(DeviceState *dev);
>       DeviceUnrealize unrealize;
>       DeviceSyncConfig sync_config;
>   
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 82bbdcb654e..38449255365 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -554,6 +554,15 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>               }
>          }
>   
> +        if (dc->wire) {
> +            if (!dc->unwire) {
> +                warn_report_once("wire() without unwire() for type '%s'",
> +                                 object_get_typename(OBJECT(dev)));
> +            }
> +            dc->wire(dev);
> +        }
> +
> +        /* At this point the device is "guest visible". */
>          qatomic_store_release(&dev->realized, value);
>   
>       } else if (!value && dev->realized) {
> @@ -573,6 +582,15 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>            */
>           smp_wmb();
>   
> +        if (dc->unwire) {
> +            if (!dc->wire) {
> +                error_report("disconnect() without connect() for type '%s'",
> +                             object_get_typename(OBJECT(dev)));
> +                abort();
> +            }
> +            dc->unwire(dev);
> +        }

Mismatched error messages (wire vs connect).
But, really, just check both directions properly at startup.
There's probably lots of places where devices are never unrealized.

Otherwise, this seems sane, having a kind of post_init on the realize path, running after 
all superclass realization is done.


r~

