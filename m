Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341D9C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 11:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJASc-0007pe-E3; Mon, 17 Jun 2024 07:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJASR-0007mj-Qx
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:23:31 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJASP-0002HM-FT
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:23:31 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57c60b13a56so5009778a12.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 04:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718623408; x=1719228208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YUM2qgT8yh9/vvQa5VxbrizX1nhNn6mWSdBf+rOIRA8=;
 b=k8IR1fVguozzg7kQijOxelCmwb6YhQzkG5rb4MXFPlQ5YylfSaJZhNgcArzVk6n43/
 TElZHnpIVat6J5EVhN8t3V47vEhDoaoh80Olsjm/ntX3nwe1mGktWmsUaqXSFJslH2M5
 KyaOnZSKiZ+JxhWeghqbhM5rUm9KywtmP89EZF1NdZkhaV0d5kY1mOGaStRv2RAJWEwO
 RTjPbJz1BCHpXSeQSrIEVD6bn21WusyDjnp78YH5uGLMXcidAuvKjx9yENIl6k4WzSOn
 8jJSeZjY+vHzxWpKaiZtH0jRpkGevL19m05GG1Ce8PCDO1UL0Vj2yC8rVR9UHS1JFJuy
 bYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718623408; x=1719228208;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YUM2qgT8yh9/vvQa5VxbrizX1nhNn6mWSdBf+rOIRA8=;
 b=Ulc1CadKMeriMBPQR2rE7iOZtIWyehwvS30hArBBvVGlLg4x+GS2u3Vj6LPzQgPNWi
 jvW7uVxf9AMumO4J5VdMHIdq6avkl/d8S/Nn+nc7MG+cK/5fpKF614fVlTzkOyfMC2Oy
 MMXZH9f7QI3ISax9KR2HmD+7UEkR8+oqyEQzVwXt/pt5BOQ8bKwb8TppwGvJy5tWdXY5
 gituVtge9VIXAHt+QYbCScWzu/e1VtT1vPkmxoMIy8UcWLFVsIFiJ76EkEAm5/ZCnm/7
 Dwu2xSB6D7+8oHhgaYPbImVJF1FgRktJweFIcz2nF2kA0r8GMGWRvDHi3oDA3M4J/jO+
 yLJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzdss9upvWJ2WJuhRpE1ZCCaUyPmbDbKZotJr8Wz15QxESLBq776bg83QfdE5ru6yXIZ5tPr3W6ZrqZP9pqqpK5PKGKWs=
X-Gm-Message-State: AOJu0YzUZDpTYITlkFyeJWAJCNb5GMAFjsO2YN62oSYquaahX4Ax4GJn
 zZrR7vdmpu6tnt11n/GZgq2qbNO0QEXlLYwM2Leo7w6jZAPhQzvee6E4YLSiQ28=
X-Google-Smtp-Source: AGHT+IFnnG9aijmNroB3F/m9W5KPd8wZ1F7ClllLQeFWFu6YwXIcf0SzPonWujcWK0bNG7HYRFNYqA==
X-Received: by 2002:a50:a458:0:b0:57a:322c:b1a5 with SMTP id
 4fb4d7f45d1cf-57cbd6a6d1dmr5404020a12.38.1718623407721; 
 Mon, 17 Jun 2024 04:23:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb741e5a3sm6233761a12.65.2024.06.17.04.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 04:23:27 -0700 (PDT)
Message-ID: <5f2f61f8-3dbc-4f03-8e60-a39cd1180e1b@linaro.org>
Date: Mon, 17 Jun 2024 13:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/26] hw/ppc: Avoid using Monitor in
 xive_tctx_pic_print_info()
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240610062105.49848-1-philmd@linaro.org>
 <20240610062105.49848-4-philmd@linaro.org>
 <0c72e586-9905-49e2-90ac-10426ea5691e@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0c72e586-9905-49e2-90ac-10426ea5691e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

Hi Harsh,

On 17/6/24 12:19, Harsh Prateek Bora wrote:
> On 6/10/24 11:50, Philippe Mathieu-Daudé wrote:
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index fa23b27a2b..5854358f65 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -1223,7 +1223,13 @@ static void 
>> pnv_chip_power9_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
>>   static void pnv_chip_power9_intc_print_info(PnvChip *chip, 
>> PowerPCCPU *cpu,
>>                                               Monitor *mon)
>>   {
>> -    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), mon);
>> +    g_autoptr(GString) buf = g_string_new("");
>> +    g_autoptr(HumanReadableText) info = NULL;
>> +
>> +    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
>> +
>> +    info = human_readable_text_from_str(buf);
>> +    monitor_puts(mon, info->human_readable_text);
>>   }
>>   static void pnv_chip_power10_intc_create(PnvChip *chip, PowerPCCPU 
>> *cpu,
>> @@ -1267,7 +1273,13 @@ static void 
>> pnv_chip_power10_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
>>   static void pnv_chip_power10_intc_print_info(PnvChip *chip, 
>> PowerPCCPU *cpu,
>>                                                Monitor *mon)
>>   {
>> -    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), mon);
>> +    g_autoptr(GString) buf = g_string_new("");
>> +    g_autoptr(HumanReadableText) info = NULL;
>> +
>> +    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
>> +
>> +    info = human_readable_text_from_str(buf);
>> +    monitor_puts(mon, info->human_readable_text);
>>   }
> 
> We have an existing code duplication in above two routines which is 
> getting worse with these multi-lines getting duplicated. Could _power9_ 
> be changed to inline and called from _power10_ as well?

The duplicated lines get removed later. This series is a mere API
upgrade, the final diff is smaller (although harder to review, which
is why I did it with many trivial patches).

_power9_ / _power10_ simplification could be done but as a separate
patch from this series, since different matter IMHO.

Thanks for your reviews!

Phil.

