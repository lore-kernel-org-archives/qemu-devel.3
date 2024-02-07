Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34FFC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 05:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXay6-0005Ga-Kw; Wed, 07 Feb 2024 00:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXay0-0005G4-BO
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 00:59:29 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXaxy-00049k-7d
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 00:59:27 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so29905366b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 21:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707285564; x=1707890364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5zFoQFTwEmwNFyWuTMDXQFaAIEDUHHBcrKekJ9KyuLA=;
 b=Y+LKjDVHmC1nYkmLSNNQItiRxilPb0MAyOg9kgXY37LvURAxXCQO89EoK+jPoRTKpO
 nsakaoVS6l3FaNJOfcE2cHtnE972gISvQ8owNUf9B3roKL05xOtp18rErLLE71rzYj6I
 9/1d4x5JmhopzBQIzc/e6zPGL4pBSEZQJmswf6PYC5slBSC1+njG6E4Orp/K33/sC6cG
 3pfEmtxGGgXIkddrCmM6xnBfaCw5NpVgoeg6zOQ7iS6JlF6AzfRImKlxl0qGH8c/quWX
 JV+QsNahSryRocqKxj8vXCuaiwLQj0bBQiYLH6mUE13R/cwVc+a2tC/oxnNCg26Oze7h
 jYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707285564; x=1707890364;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5zFoQFTwEmwNFyWuTMDXQFaAIEDUHHBcrKekJ9KyuLA=;
 b=xDU94lYpk/j2gtDYoVyvxQc943g41ofGbNj4YqpC0xA7CFyNMvWLZLjZKC/ZfCD6MY
 LlkaeIvvvwqfvZi3Y+kT7cad/x4AoF4DABpDw11drW8W1pXQnLWKsxg0m7IXW83QwkKn
 SXDQWlZiO3T9lqKEBHUMa+rYDb+YdQgW0qAA4H4NOVlH03PM5j6yDxMX+Hz45UgfxpUh
 OBtKogNBlCJGdz1C28jaz4NnRvvVusJSti/Dt4v2y59pkcp33MgVA5rqsHe4b/CVMiE/
 ZFZ0cvNp+EHkMrdd2/dR18UxQ4YM0HKmiaFkfJj5gyqUTQ8GAIS7i+DmOerJBW/7o7bm
 5jKw==
X-Gm-Message-State: AOJu0YxL4wOctDwHhJmMbemancG4m8Pq0Nxo9ecJIIyKjmbHdJG9ihiq
 4KXgn9dyE/werUefbsbd6onu/rsGDifF1L6/Jqrw99izkKHc48kNGMLFKZpxlLs=
X-Google-Smtp-Source: AGHT+IFGmHRig14xmfWcdgiq2ux6S31f9kgE1l3S6m/Av9FGSE0WEHcyBsXJ7uVbud+zuXPMCT6F7Q==
X-Received: by 2002:a17:906:895:b0:a37:9bae:ee09 with SMTP id
 n21-20020a170906089500b00a379baeee09mr3353688eje.11.1707285564629; 
 Tue, 06 Feb 2024 21:59:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Ar+vYdUAh4mCXRTlN5Inyq7IxPDaThhmkiKjIuLdUvHeOIIrgsZY2Ei+GVV7gHq+xIVk0fkFwFl0nFIFYQHoCAhP/5O7PGhbW2EybcQBn3RLN4ARk+RHwyH29jIJmxsvg+n7pV+7njoT24nyVJiR5NKDCQjyWXQmFrw2K+Umbn4eFdkNy9NLA75bPzqto2XTxV7lr+5ZmgAf1pQ3/bruiu1kduHFoTVAz2+CeWJCKJKS8g8vfUboWatRHmt0vgoSaC6UlwoBPUrI3uCwEjOCCfmh02CwbXR9f3fXrBDu7t2E01KlvBnMyZrIp0vcxX80bXzFvTzPCelyS+lvuZsEaRun1GA6aeV8jd+tdw1ZdJ7D0/FqIvnrAx/kQew6KIQfCS7JRulw+6gwT4S4RLDLfk2jFldCJZ5uQwx1l7O/3fLbHPupnoIORXki5CUoLvXdATRXFELtDVb2fjjq2m3rne0dYGe/U0Lcolj8b53wa9e3/WyPUZ2uDusqTucRPtC/ebtyelpjjgYeNIuJ20yO0b15kylwlHKbkF9l6nDCbvQMlnLwXFEzclFl/LA=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 i17-20020a170906265100b00a38576aefabsm353945ejc.161.2024.02.06.21.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 21:59:24 -0800 (PST)
Message-ID: <9b6555f7-65ce-4efd-a45d-10aacf71446e@linaro.org>
Date: Wed, 7 Feb 2024 06:59:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/21] i386/cpu: Consolidate the use of topo_info in
 cpu_x86_cpuid()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Yongwei Ma
 <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>
References: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
 <20240131101350.109512-9-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240131101350.109512-9-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 31/1/24 11:13, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> In cpu_x86_cpuid(), there are many variables in representing the cpu
> topology, e.g., topo_info, cs->nr_cores and cs->nr_threads.
> 
> Since the names of cs->nr_cores/cs->nr_threads does not accurately
> represent its meaning, the use of cs->nr_cores/cs->nr_threads is prone
> to confusion and mistakes.
> 
> And the structure X86CPUTopoInfo names its members clearly, thus the
> variable "topo_info" should be preferred.
> 
> In addition, in cpu_x86_cpuid(), to uniformly use the topology variable,
> replace env->dies with topo_info.dies_per_pkg as well.
> 
> Suggested-by: Robert Hoo <robert.hu@linux.intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes since v7:
>   * Renamed cpus_per_pkg to threads_per_pkg. (Xiaoyao)
>   * Dropped Michael/Babu's Acked/Tested tags since the code change.
>   * Re-added Yongwei's Tested tag For his re-testing.
>   * Added Xiaoyao's Reviewed tag.
> 
> Changes since v3:
>   * Fixed typo. (Babu)
> 
> Changes since v1:
>   * Extracted cores_per_socket from the code block and use it as a local
>     variable for cpu_x86_cpuid(). (Yanan)
>   * Removed vcpus_per_socket variable and use cpus_per_pkg directly.
>     (Yanan)
>   * Replaced env->dies with topo_info.dies_per_pkg in cpu_x86_cpuid().
> ---
>   target/i386/cpu.c | 31 ++++++++++++++++++-------------
>   1 file changed, 18 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


