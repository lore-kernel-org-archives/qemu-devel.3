Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85819C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rogfp-0006se-8C; Mon, 25 Mar 2024 05:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rogfj-0006qm-AV
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:31:18 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rogfh-0005IA-Bv
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:31:15 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-513dc9d6938so5176434e87.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 02:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711359071; x=1711963871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bvm7q1Z8UDikIjNXuJQ1hwjbYn/l0RMiGmMNh/s4WyM=;
 b=fuGTP/j9vRwkErUR7OQj4xa/m4I1Vyf6FE6rxjQ31YdBWFL2RbLNMWjQu7UeZuTjeN
 p2G0xP2Wjwyp7caURHq7sacMRCMyZkhvZnI7sCgAEZNENLkwKCeZMBIt4vk4aUQlFIrN
 uL4NzLsj7BEROKb0CoBbpatwLI/gKLkj1iAzrUgW2CcALzbza0SamI8GdtJ7XfPcOmZb
 I45erVO6XJ9tW021PCtjG25MERJD+exZnQ8XFDc3RimjekmSZ2JreslZXm7vt7n6CLRT
 6JIQGZgtxNk+QjhFEtpadx5sTK89PoRmyt4TynoMqZped72nsytWWPm7soWMk0GmuD+H
 l7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711359071; x=1711963871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bvm7q1Z8UDikIjNXuJQ1hwjbYn/l0RMiGmMNh/s4WyM=;
 b=PrzzskQEkixw8ts8DzMgZJLgzZe8NIfEDhiquhIWb29htiGPPpPwjS5wPQGYNAJyL9
 1N7u6hv7lRnHp8I0GqWgng/jKMHbMsx6Dxf5jcY6BEVdkfLn1/6OW3TDo44N8OuGhPpV
 ooXRaYL8NSxv+AH0baBtGO/glp3ddfvZmZpCQLrCzzLTCual6xYTLEli2nnnVN5Bq5/i
 70ui7MhtZB25UViaFotYBzjVTXL5SdXHCqpULHJel3deYtiKXp0JX85dPn7kMxoUOhV/
 AOHWj4b+2WI+tCjkwAB/mjeIZHCMEwHYrVq3i68n5sAmOJg9f5XJNAaijPPRZ+KIz2DX
 GmSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6nmwHswOXl24nts4LUBfBfT9qk2Gsfv3JfLo2hG1PH/YEsoUJCpRfCCNsTcRF2FTkrd4tqxn0HRG+ZOWKMmrs1TxRvDI=
X-Gm-Message-State: AOJu0YyiP48AzDxsZciMQUS9WxGWaBMsj+dhkMjqP+uII6Kv4VABMTUj
 r/LrGMc+XEqUoG+a7JZasASkCc34P1605AYgYG/1zEGVCC4FQWwm7GUzrHCGIl4=
X-Google-Smtp-Source: AGHT+IECrcRQQXsEtIB9P4OftG/ACAhshZY9nSyP7ddrZu3j7OF6AHDJjVb6SUQeshWwvLFsTOEWrg==
X-Received: by 2002:a05:6512:2188:b0:513:a7ce:525d with SMTP id
 b8-20020a056512218800b00513a7ce525dmr3373324lft.40.1711359071182; 
 Mon, 25 Mar 2024 02:31:11 -0700 (PDT)
Received: from [192.168.163.175] (237.red-88-29-182.dynamicip.rima-tde.net.
 [88.29.182.237]) by smtp.gmail.com with ESMTPSA id
 m15-20020a05600c4f4f00b00414037f27a9sm7844004wmq.31.2024.03.25.02.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 02:31:10 -0700 (PDT)
Message-ID: <1d708513-d071-4020-84db-fd345b3295a9@linaro.org>
Date: Mon, 25 Mar 2024 10:31:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/26] kvm: Introduce support for memory_attributes
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, michael.roth@amd.com, david@redhat.com
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-19-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240322181116.1228416-19-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

On 22/3/24 19:11, Paolo Bonzini wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> Introduce the helper functions to set the attributes of a range of
> memory to private or shared.
> 
> This is necessary to notify KVM the private/shared attribute of each gpa
> range. KVM needs the information to decide the GPA needs to be mapped at
> hva-based shared memory or guest_memfd based private memory.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Message-ID: <20240320083945.991426-11-michael.roth@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/sysemu/kvm.h |  4 ++++
>   accel/kvm/kvm-all.c  | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 54f4d83a370..bda309d5ffa 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -536,4 +536,8 @@ void kvm_mark_guest_state_protected(void);
>    * reported for the VM.
>    */
>   bool kvm_hwpoisoned_mem(void);
> +
> +int kvm_set_memory_attributes_private(hwaddr start, hwaddr size);
> +int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size);

uint64_t size? (kvm_memory_attributes::size is __u64).

