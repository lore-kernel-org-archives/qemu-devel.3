Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA48C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmrz-00059D-HV; Mon, 24 Mar 2025 14:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmrM-0004uH-1m
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:49:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmrI-0000Fu-GR
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:49:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so34241535e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842150; x=1743446950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sFlWlcqAP7iDgyuzwKYgSc2P9Vq7g3reEoKeMZ0CQDI=;
 b=OwO27njvtRAdoSetkCjuyKJTFAQXDPZ6QMn7SRw8ahvIvfjCDaH8jH9QUrkyDDcUJf
 6/vubEByWBiQmed153w6oJ1IU0hWr1JYLx2dR9AVgHGkOwNGO97U8S0+0/OZCqY9h/iA
 KeOd2Xb9EKqp7MiHdXmB3nEFe/0nwDRqydh0x78XQGecqOdomjzonyzfrhEh9VjZpSNS
 JAqEPYJwQDtQ4UZxJn/8zw2ILSzzU1gvtIqk3KsIi02811tKAUj/PAmKpgzTVVWsCrhS
 +oIrfQ/8ZpGJ5Sq2IxGNUwLKW7dl3sVfu/9jhXkEQpou1qD8epmOyGsg/vG++vWgYvJt
 p/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842150; x=1743446950;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sFlWlcqAP7iDgyuzwKYgSc2P9Vq7g3reEoKeMZ0CQDI=;
 b=ok7F3dsVJ7V2BWke06wTyqEprJbclg0Pfi4PI+xLTl86NKks5gsVVIks15yQfxn7YC
 qb7NybxCkbL1wqG1DiblFqtqE24SAfQZap2Mt55viNpiIAB1MtNK7vhTt2Pkt9kDMnYC
 XBXbB5OCg2wiXuDr4Qdlu8kaMyvMzgVricEjXOcfJISR/VnNqcnVxEcHfxTZhmOLdzAE
 UUdFU6FefMfZnIEO7zd3+/csmHn76UbZDYMB1efWp2mhgDrUZIdz8733ejxdeX3WlFne
 SAVAOx1XDxuu53VpzqYI7+cDeN7E3qANrAt87sDtdyFFGfwPMHu1UWNzIglBLW9k65JC
 stwg==
X-Gm-Message-State: AOJu0YzA6Y2jvTiupOSegsOTml7y0S+a0N/OldzrOBuXGR4lKesLuaoJ
 C/N3no+EKJFctloqOhcRoAq7g8jZPkOY4DYKUVeJYdPYyN5ISpFJj1Jl2LiMnbyR6bTkPiHZ0FH
 i
X-Gm-Gg: ASbGnctCb466oiisJuERS3ydO1bqVp1Nn6Ji1GFBDTUzsDQpN3E05l2OZYrrCcaj9OU
 is/jpBhUs3RoOsG4/cnRD/IA4YwNi46G/JX67vJGpj2efAjQm1ULSAQ9d91jVZ/OcSILppgCprJ
 l3w+vnAiPY4T9aQHyITL38+Uggyxx/c4BMnhHcrCYiVp4tcdK6HOYi/UFTD/d/EaJCG33exaD/q
 uTOpg96nfbdmI0hLFKQqmI3xda75cpq+xBsOrdIlKKd7jM3l76zmW2IB2JZCJVyRPkDyeDEVPGq
 2SCLB2IT0vUcp06Cc/i6Vj8IyYx0N12ev9Tx48AESIBP/FT7hNfT37XwZB1/7+f+eibmGWeqGsD
 PBIj1MnKXW7HHscJlYg==
X-Google-Smtp-Source: AGHT+IFZWMFYTyNVIl16SDSbIyT5WZLE6/ACWDvoFAEqkk4UCcTngt9yS3mk/henqerU1rTwIuxCUQ==
X-Received: by 2002:a05:600c:4f0b:b0:43d:82c:2b23 with SMTP id
 5b1f17b1804b1-43d50a1d187mr120771495e9.23.1742842150111; 
 Mon, 24 Mar 2025 11:49:10 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43e2asm183508785e9.11.2025.03.24.11.49.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 11:49:09 -0700 (PDT)
Message-ID: <11fd1211-3a35-4c4f-b765-85b15d3c9fc9@linaro.org>
Date: Mon, 24 Mar 2025 19:49:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 6/7] target/s390x: Register CPUClass:list_cpus
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250324184611.44031-1-philmd@linaro.org>
 <20250324184611.44031-7-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250324184611.44031-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 24/3/25 19:46, Philippe Mathieu-Daudé wrote:
> Register s390_cpu_list() as CPUClass:list_cpus callback
> and remove the cpu_list definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/cpu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 8449bfee5a9..2876f2c4eb3 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -385,6 +385,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>                                          &scc->parent_phases);
>   
>       cc->class_by_name = s390_cpu_class_by_name;
> +    cc->list_cpus = s390_cpu_list;
>       cc->mmu_index = s390x_cpu_mmu_index;
>       cc->dump_state = s390_cpu_dump_state;
>       cc->query_cpu_fast = s390_query_cpu_fast;

Grr, I forgot to commit this hunk:

-- >8 --
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -902,5 +902,2 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)

-#define cpu_list s390_cpu_list
-
-
  /* helper.c */

---

