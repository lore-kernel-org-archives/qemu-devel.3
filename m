Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228E4D44172
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 15:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDQ5M-0002MV-Fz; Tue, 19 Nov 2024 10:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDQ5E-0002Lh-6r
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:24:05 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tDQ5B-0006fw-It
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 10:24:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so47048615e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 07:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732029840; x=1732634640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rf+sBMxCnuVF5VYoW3/isl21q4ZfONnw2wM/tNHOz78=;
 b=ldprRKgWHUO2TTk8mfzQiMtrTWmSXq9y4E0UhLM7AuEDifb+FVgQVp+1arElSMY0wM
 ndH+L/sLSuCBWEjJ5+evb5gTEplsoGv6XQ0SbHeMQFzfrbL6Wj2Y0N05ouxFhisfYTnz
 jyl6Kxn+0ee4cbReooY2J1s6XwFsqGVB8OviN4+xczxUc/8KnNNSq9kuuTp5/zVPR17b
 hryGTcNsT/cRkiskgavbmaaDS3yovb6XuLsTEx+nSHHrlrCIcmRRVlNX3zT08g/Ew4ey
 2/KHIb1d1tv01jOWcMv3u5LDyKRBsk4Tc+dJRwUZ3k2L7LW+cNiM7XxgpWNEWObNV9PE
 VbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732029840; x=1732634640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rf+sBMxCnuVF5VYoW3/isl21q4ZfONnw2wM/tNHOz78=;
 b=CtnzVqMl0x1I4teNCXTFgAnuUB8vjxUTkNfwJHEhh9rvRtKytPqcINuSnS/053yw9E
 ifGabEvzs2uGAFYakbapyQ/WT4Isdi7zvrQs7dvi9nAN+Kau41qrSu3W0GHLr1D4iGF7
 qoUJDqMkYc8HScDNCwIOadPvEdFL60v3kMt6k6+NHHAn3P5yeJEgG/wTm5Xdh5ShN1qy
 l9Mv8T86OjlX/UMfv19RGcmB45/Vym0XIwW9eEZNEu5VPDuW9Y8ZLytmCY6ANlWn8tct
 OsfWN8MzjPt3VeLsPv7wpy6fO+ZyBHI7cLF+BpH4zy7aHOQ93wZ9XPZIprXtfb+eTJj0
 pZIg==
X-Gm-Message-State: AOJu0Yw291CHkv6vY2/K0p4iiCZvyOtwXvcyFN36M1MhOuZx0Kgi8YM9
 NmT3gW+ApmELi1ei33RUkpAnPbyTHcNkknHkR7GqTgH1RfYfztPlMRvORsC7zbM=
X-Google-Smtp-Source: AGHT+IG0VweSbgQXDXXJqUkOPvDpjRDgty2zCJSxNxmDStBmRJwXUD/q2IeFLkRoZ61F6kzvRhL5Tg==
X-Received: by 2002:a05:600c:4595:b0:42c:b80e:5e50 with SMTP id
 5b1f17b1804b1-432df67991emr146886675e9.0.1732029839802; 
 Tue, 19 Nov 2024 07:23:59 -0800 (PST)
Received: from [192.168.69.197] (sto95-h01-176-184-18-155.dsl.sta.abo.bbox.fr.
 [176.184.18.155]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38249ba168bsm5280464f8f.106.2024.11.19.07.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 07:23:59 -0800 (PST)
Message-ID: <0a642e87-53e5-444c-9254-689135036c56@linaro.org>
Date: Tue, 19 Nov 2024 16:23:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 9.2 2/2] hw/core/machine-smp: Fix error message
 parameter
To: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241110150901.130647-1-zhao1.liu@intel.com>
 <20241110150901.130647-3-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241110150901.130647-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 10/11/24 16:09, Zhao Liu wrote:
> In the loop checking smp cache support, the error message should report
> the current cache level and type.
> 
> Fix the parameter of error_setg() to ensure it reports the correct cache
> level and type.
> 
> Resolves: Coverity CID 1565391
> Fixes: f35c0221fef8 ("hw/core: Check smp cache topology support for machine")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/core/machine-smp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


