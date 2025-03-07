Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6155C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdRY-00039Y-9E; Fri, 07 Mar 2025 14:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdR4-0002RU-7F
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:32:42 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdR2-0006zk-Bf
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:32:42 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2feae794508so3620634a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741375958; x=1741980758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MeKWtiInp5V+cmwwK3Y1NC5YRaGg6vaRs97hD7A0NQA=;
 b=JZIdsTClgXCKm1n7G0++6pqUzivYv7reYWD0HU25v5psn3ehX0W334a/Sc2d7n9JKt
 0bpqIVoOOl8bfpc7bvTnyMK4KEhZlcQAsUr8HEYKAHzlliZibly894P3E3Ftdy9kSddI
 VZdt8QCldZRMDj/fccqQqR6zkDwFTYfVHedassdp8ZyQRLHvfjorRM/C1DwpbOhQUJN/
 hgkHMUJNKQihMUG/OFbbOs4EHPrMHER3WFXzWsX0aeqCXKJzX+AwjhUwJEe32WqErn2X
 T4KoeEfX7vQs97BjrlXshtjfxeU9hF5OKqpJhl+NILuKHsw/2yVMj1vGiTypMJeEXOPs
 X2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741375958; x=1741980758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MeKWtiInp5V+cmwwK3Y1NC5YRaGg6vaRs97hD7A0NQA=;
 b=BKNupHo32gk38XcXPNJCXZzOqxHMCAvqbdoR2apkeYUQkMJHmrBmTtBUrGjwE5QQN1
 MZc9xGfbfGaKVN0mwakOvNYtkXkrj9fHxxY53KuuSAT8UCnCUamvSxaHKLByHL1WZ6yz
 s0wVyCEpvzGdwjeoi3LjkysWoY/EIDkRtidqQj9jCW3SrGrCo4u82jD/MbQZuh+yfbST
 VJDpS5SEDirmxbegdSmIy7hbXVUIAR5lQhFxjn7Xq0aFCq8gXJCayh/ch3kLnXy5qNr/
 dq66V/WTwBx0HMJNsdL2P/cjCUc/Kdg+3f1dQl3ukVcCBuDIJZqJPfj0I5zgZ5DZMwdf
 2T4g==
X-Gm-Message-State: AOJu0YyvzF2yuJb/8oig4yI8PkJvj3IPruGPDtCvL8OadziJnaBE0uhi
 +rhR2/fNpcTcq+OjenFLo3lkQCEz1lrJKJ8wt4lBewO07SdN4ML8eX5dvQ6aggpXifafCcT39O0
 O
X-Gm-Gg: ASbGnctmWd02F+HLnhUniqJwRhdZx9d5P/HnjlgSYyLte7lVbiFNvOVErXghAnRWZH1
 fo71Zx0V6czinnfDX32jXYtK/PTwlr9Y/GK1BPVQCSdMasITo9kQl4JN47UmQ+BJJs8EH6J9Btp
 kgM4k8yQgzXqa5SE8O710rUXyuTqlOlaFj7ODpEupvnCoEG2xkRPBMzE/xk83VF5T2suhIP2scy
 7CH+uIIHPHINz6OGEfsZQb/s4qgKivfhsxQVafl5WV859Wo+94INDjXCNQhCiCPuRgPcOAuoGuL
 dvLpg/LeRXzAOv/Yz9sutFjzmYnJk/vHOs2/qx+5/CDlRsG+DUk+s17ZYg==
X-Google-Smtp-Source: AGHT+IFyYXzUnplKfHzTRwjXR6Pptw2Ed9CumeXy1pPAFDk/GxVx6wFsvOZ3tk3Y0JCtpo/anM2miw==
X-Received: by 2002:a17:90b:4c44:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-2ff7cf22f41mr8270598a91.33.1741375958305; 
 Fri, 07 Mar 2025 11:32:38 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109ddffesm34103155ad.40.2025.03.07.11.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:32:37 -0800 (PST)
Message-ID: <8739f1cd-e2d0-4720-9f72-c7ca60c85d8a@linaro.org>
Date: Fri, 7 Mar 2025 11:32:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] hw/hyperv/syndbg: common compilation unit
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
 <20250307191003.248950-6-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307191003.248950-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

On 3/7/25 11:10, Pierrick Bouvier wrote:
> Replace TARGET_PAGE.* by runtime calls
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/hyperv/syndbg.c    | 10 +++++++---
>   hw/hyperv/meson.build |  2 +-
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
> index d3e39170772..ee91266c070 100644
> --- a/hw/hyperv/syndbg.c
> +++ b/hw/hyperv/syndbg.c
> @@ -14,7 +14,7 @@
>   #include "migration/vmstate.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/loader.h"
> -#include "cpu.h"
> +#include "exec/target_page.h"
>   #include "hw/hyperv/hyperv.h"
>   #include "hw/hyperv/vmbus-bridge.h"
>   #include "hw/hyperv/hyperv-proto.h"
> @@ -183,12 +183,14 @@ static bool create_udp_pkt(HvSynDbg *syndbg, void *pkt, uint32_t pkt_len,
>       return true;
>   }
>   
> +#define MSG_BUFSZ 4096
> +
>   static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
>                                   uint32_t count, bool is_raw, uint32_t options,
>                                   uint64_t timeout, uint32_t *retrieved_count)
>   {
>       uint16_t ret;
> -    uint8_t data_buf[TARGET_PAGE_SIZE - UDP_PKT_HEADER_SIZE];
> +    uint8_t data_buf[MSG_BUFSZ];
>       hwaddr out_len;
>       void *out_data;
>       ssize_t recv_byte_count;
> @@ -201,7 +203,7 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
>           recv_byte_count = 0;
>       } else {
>           recv_byte_count = recv(syndbg->socket, data_buf,
> -                               MIN(sizeof(data_buf), count), MSG_WAITALL);
> +                               MIN(MSG_BUFSZ, count), MSG_WAITALL);
>           if (recv_byte_count == -1) {
>               return HV_STATUS_INVALID_PARAMETER;
>           }
> @@ -374,6 +376,8 @@ static const Property hv_syndbg_properties[] = {
>   
>   static void hv_syndbg_class_init(ObjectClass *klass, void *data)
>   {
> +    g_assert(MSG_BUFSZ > qemu_target_page_size());
> +

Should be >= here.

>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       device_class_set_props(dc, hv_syndbg_properties);
> diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
> index c855fdcf04c..a9f2045a9af 100644
> --- a/hw/hyperv/meson.build
> +++ b/hw/hyperv/meson.build
> @@ -1,6 +1,6 @@
>   specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
>   specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
>   system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
> -specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
> +system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
>   specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
>   system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))


