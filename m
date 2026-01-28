Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068EAD46C05
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 21:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlDGk-0006D7-4W; Wed, 28 Jan 2026 16:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlDGi-0006Ac-6W
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 16:40:08 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlDGg-0002OF-6t
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 16:40:07 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34c5f0222b0so147013a91.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 13:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769636404; x=1770241204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KKtAgJnCDkn3F9ZmAc/xy0UwNpUIem5/38yDAGzrRKM=;
 b=yfVvSVxlZma2de1Wjm5nYCvd/XN4wf39D1sA2Nqno/CxQLKR/zYLhPATQaThlta1RH
 cTvcsZHgN6YMHasvE/801EWwRV9cOt4CXoVyfyFXx/t6sfZEFOzg5Sj1uNc+WN9b2ZMp
 UkSrYkottaulCyr13MobDYc04zlWGJHnXm5sqg5KqBZIElThF9d22JwvZd3zpS63kzCz
 6NDuC2pB/ZUuUtoaOBbDVxIq9meBxjNsXsS3LjORPZsigc8cGmGpo12Du2bUZtwN7jfS
 ve4eqf2f/bJD4ccTWPxa4d4usfXUoQcLl6UAk+lDTn6stkbOIKioJzV6NgINC+9Be5Yf
 ZqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769636404; x=1770241204;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KKtAgJnCDkn3F9ZmAc/xy0UwNpUIem5/38yDAGzrRKM=;
 b=FEmHDjeJVITF8N2+KYFWEhWPHrx9IK9X6TwLgg+kzqfwbNHcK05NpjMAteMJ4v1XOp
 I328+PaxvTZOYTANKmMvWcnx8JpRKtxgZFy8dIg1AGu+koxcj6hz6It6/do3XJdoJgPx
 ctfMlrjrXdfkkAmvN4qNVjoLGqeilJE1eyqHxk9Hnl5iVeAUe0d9NgB840OszX3hDGgV
 q26gIZt56demKwJ+Fx1h5UL6LnCDUD43jGOYV+FMQrRrlxeOwI8Yn/pzuWx+/NPebLiY
 4bk/U++X8PJ43hDTMK7CNNIQS438l6qx9r+7y/r1ZJBSD6hnsusel5je2TrGlbmIVi65
 FZkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXyUM2gFXgxXSiDwyeJ3rxJwVa+d8gdjWTosq4U8E5l6yddMGiT2PS72KR3xEmrgujWAp9RhDVJMkR@nongnu.org
X-Gm-Message-State: AOJu0YzrDTot/6HARqUjfJJuYbOGAnd8LYDm1/nipUNn7QK6Db8CC7m7
 mYaplq04DzSAJuIR8z67Kvn1tjQ/ZJyCXV5qe4j/LON/zf/5t/w3JnT4pgRbYntFNsL9hcgxDuT
 vY699ePE=
X-Gm-Gg: AZuq6aKaYtfIc5xQSzb2EdncWSPz65GcH4ofCO5o0LsKU+suACvrbx+MrLTFWfgi4Dv
 bl/xiR1trOmZJt6n++2HYgn3AgG38KWwxD3dQjesWyx/OjVBK+spOK+FlYTIj+DWnniiLI2R0HM
 2Ixx96CIMoHBtgL1YacWzY6LdlnrTvxY4906IU8O/1F++ZTIeKsIkrTaQzfjQSKptUjx+6dF3pa
 McSO1uAD9FFAMpw2fhs88Q9xzDbjutv0zwkXwAheZS0reEfFTPXZyvQPIbRADsLam2ybpCJpskn
 qxQT5VziiOKnyInRPEIdFLMWjHICeT1Xr2bvx2TZyL/i93dksEIGqzHDGldLqPZBOt9jm4kkEBs
 d8fV7fwhriaD47FqmoKz8Wt6BNyx+iiXYMqKG58cqa9hPgSNc/exww1HabCSxCm+lNfrUWdCWdG
 frIvID+FbsApvtTShC07WUgpxzMdYNB+qvbIKh6FqVjg4FASZ1M8sCPVdY
X-Received: by 2002:a17:90b:2ccd:b0:340:66f9:381 with SMTP id
 98e67ed59e1d1-353fece4a42mr5105173a91.10.1769636403906; 
 Wed, 28 Jan 2026 13:40:03 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3541110e107sm46415a91.14.2026.01.28.13.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 13:40:03 -0800 (PST)
Message-ID: <b74cbcec-16c3-40ed-b58f-bdf6b4d8b1fd@linaro.org>
Date: Wed, 28 Jan 2026 13:40:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] accel/tcg: Fix iotlb_to_section() for different
 AddressSpace
Content-Language: en-US
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>
References: <20260128152348.2095427-1-jim.shu@sifive.com>
 <20260128152348.2095427-3-jim.shu@sifive.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260128152348.2095427-3-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/28/26 7:23 AM, Jim Shu wrote:
> 'CPUTLBEntryFull.xlat_section' stores section_index in last 12 bits to
> find the correct section when CPU access the IO region over the IOTLB.
> However, section_index is only unique inside single AddressSpace. If
> address space translation is over IOMMUMemoryRegion, it could return
> section from other AddressSpace. 'iotlb_to_section()' API only finds the
> sections from CPU's AddressSpace so that it couldn't find section in
> other AddressSpace. Thus, using 'iotlb_to_section()' API will find the
> wrong section and QEMU will have wrong load/store access.
> 
> To fix this bug of iotlb_to_section(), store complete MemoryRegionSection
> pointer in CPUTLBEntryFull to replace the section_index in xlat_section.
> Rename 'xlat_section' to 'xlat' as we remove last 12 bits section_index
> inside. Also, since we directly use section pointer in the
> CPUTLBEntryFull (full->section), we can remove the unused functions:
> iotlb_to_section(), memory_region_section_get_iotlb().
> 
> This bug occurs only when
> (1) IOMMUMemoryRegion is in the path of CPU access.
> (2) IOMMUMemoryRegion returns different target_as and the section is in
> the IO region.
> 
> Common IOMMU devices don't have this issue since they are only in the
> path of DMA access. Currently, the bug only occurs when ARM MPC device
> (hw/misc/tz-mpc.c) returns 'blocked_io_as' to emulate blocked access
> handling. Upcoming RISC-V wgChecker [1] and IOPMP [2] devices are also
> affected by this bug.
> 
> [1] RISC-V WG:
> https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> [2] RISC-V IOPMP:
> https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/cputlb.c        | 22 ++++++++++------------
>   include/accel/tcg/iommu.h | 15 ---------------
>   include/exec/cputlb.h     |  4 ++--
>   include/hw/core/cpu.h     | 17 +++++++++--------
>   system/physmem.c          | 25 -------------------------
>   5 files changed, 21 insertions(+), 62 deletions(-)
> 

Excellent, we were looking at this area for this precise issue, and your 
solution is clean and simple.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

