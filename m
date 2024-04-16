Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2342C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwiwY-0004Bt-Qh; Tue, 16 Apr 2024 09:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwiwE-00046j-0m
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:33:34 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwiwA-0006DP-W1
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:33:29 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3498c7d4473so349277f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713274405; x=1713879205; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ejCkE3cYY+5NHE0dWEkXgBRP4mtgFRv6mrQVJe9Kjo=;
 b=XAjHLgabfnZOzzaKrKG2a1y+Ld787QKVj/JxAuNHiFRsJLH4dvuIfH/tomy425KivL
 SVSiTID3OI+0GhZG+52rFVImvngM/xTCvq3foazEcxhgGCpMrKPgo1lcN3PwNnCr9nym
 Ai89O5wp1mEHcjvupshjy5tN1AzO/n79wWqv2pAyrZUG0QxT8j/hapckfiaPkF3p2oVE
 GWyuUFfjHRsYHePxnINoBh9aPAGlRy76Hrp4DEOedn9unRdM6z17mFSZGAaZLQ9q44ab
 7Q/HDVw/3QoQVkmgPO1kTAz15bRE6Wm++Gos5ozm0ATNr7aRIwPY1RkIUnbtQPmGx1Tv
 Cw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713274405; x=1713879205;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ejCkE3cYY+5NHE0dWEkXgBRP4mtgFRv6mrQVJe9Kjo=;
 b=rV3Cijaazzx9lbJG2HfcXsRIGq5QrAUjKp1HaGGJxFSflVgELz6kPrikzqQSO1xPGk
 sMxNKcTHqGmUqLIF61tvAQi2J/r8kc2MYKougFntoD2qOVEnc3GGGvUvsNdL/tHntyRJ
 TBIdECO1Oc6W2+pC+TFITfDFe2M4PAU5XO5c8lk6ZxHo8GhYAg308t6b8cLlnQQ2ZnCN
 prDUHDZMSDGndyZrvVhYvayR3FAae3klU5CL/Z54K9G3e5U8pb3C090DwfOQWDjrpBIh
 Tc2CvG7qk7n5EOIS0lUclRVSGtD86pRwJTDYyCQ73i9EoUMglvPQ7yF9GWB3v9+6sPxj
 E4Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTrHzRBqmIXRCHllaTNdFPuivJKtw/SmVCDjl7DmM9jfHPrNF5o3IJyE5GeCm5BOWbcHl9PAbH2Dr2IWYqxxaUq5o4Yxw=
X-Gm-Message-State: AOJu0Ywjq9JO2RS8DvFhVml4HZLOiqQKc7UKzPA7vGTsCv4XJ/vC5ZP8
 tyDxCMKn8RqVmPasG/Vr3OhGMG4PtWDPmRDaHkVznNEvNK95vK/QV30yIcqi7as=
X-Google-Smtp-Source: AGHT+IH92HJHUuNl6TyR7RfHKXIxtrZrX9UW/aYad8LjNwOFRn7nCyGMUtWcnxl8fGtGuf+eLBlrtw==
X-Received: by 2002:a5d:54c8:0:b0:345:c169:8808 with SMTP id
 x8-20020a5d54c8000000b00345c1698808mr9106697wrv.4.1713274405201; 
 Tue, 16 Apr 2024 06:33:25 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 dd15-20020a0560001e8f00b003436cb45f7esm14924652wrb.90.2024.04.16.06.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 06:33:24 -0700 (PDT)
Message-ID: <b2c237b5-9dc4-4557-ab00-0c19a5be0366@linaro.org>
Date: Tue, 16 Apr 2024 15:33:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 13/21] hw/mem/pc-dimm: Remove legacy_align
 argument from pc_dimm_pre_plug()
To: David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-14-philmd@linaro.org>
 <5efe6309-2c7e-404c-9674-2221606b35ac@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5efe6309-2c7e-404c-9674-2221606b35ac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 27/3/24 12:32, David Hildenbrand wrote:
> On 27.03.24 10:51, Philippe Mathieu-Daudé wrote:
>> 'legacy_align' is always NULL, remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Message-Id: <20240305134221.30924-11-philmd@linaro.org>
>> ---
> 
> I was really confused for a second until I saw that this series is 
> dependent on another one.
> 
> Please make sure to CC people you CC on patches to also CC on the cover 
> letter.

Oops, sorry. I really should patch that on git-publish...

> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!


