Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32320C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 09:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN7lv-0001Qe-9k; Fri, 28 Jun 2024 05:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN7lt-0001OC-B5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:19:57 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN7lr-0003eA-Q5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 05:19:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3676447928bso222629f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 02:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719566394; x=1720171194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W6JAEbIVXyf3nuDbPMuYG6CD+orFOdGkrHRmSucKKRo=;
 b=GOKBq58oeBtf4mVrlhYCUACfqizBCMSKuukLw7vP0QaXZfvYljSnhYm1VvXj3Rsyv9
 nj5BR5eR7q5haPOFrkX70bSls506IgI79f7k17PtT/vL0yQ3zcrFvtpemarWS9QDzE1e
 UfvKdtwlOpp//6d79zFSsyDlGZd1pdsS9oifVI7s2uuyJYDwdHhVI+BO7Cle3hWw29o9
 x7dGAAglWMZpzAk1eVSnQN8TQ2uoa5PyaoZcBEuUhG1ByHuDoZ8RkvCWaCfCa9hNg+UH
 81WZ/VLgt3YWVxMhfTkqVfntX4yzgEThQLLeYDgroqktE1oPJkjmOYHKonn0/wTZmFf0
 Gz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719566394; x=1720171194;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W6JAEbIVXyf3nuDbPMuYG6CD+orFOdGkrHRmSucKKRo=;
 b=DWawgBi9AS8Ll9OKsXR/z/gU/Tv0W/TVtiaN3DPDtc59KK8A8F0sTp9YI7FvFJzSNn
 NrKoX+sslcA4SyLcx5iqoKusORgesvWsaqDDwah9Xq2lln/I0bIo8vjuZyoUfoM243E5
 xGKj9xmIJz+l1WAVZLK/PDKzzU1jmNnzqKwV2+hOyxa9eVdJDgeSuidy6gInMQAisfqF
 i6wfYoQfWw3F8YtgSmkU5fZfDbGdY/mwxj8DoRxklQVzmfo5B7qxGMNjxV6YV1jaS0jB
 e8VcIAk3Z6uLtNagSDGebhIuO1ZPTcadYx1ckNaNp4rUS35vJhLoijgO3IzDln+64H48
 XVIA==
X-Gm-Message-State: AOJu0YzL3r1lZG5NxEGxXSP6+ytp3HJov7MEgic6I/teyeTCkTkNyEh7
 ObcFfp2V2ginv//zQdyOaAHqNqnaq2EgIq6p94QHAhOkxy0rpjTk0cgMVrerDrY=
X-Google-Smtp-Source: AGHT+IH69JNk+GgGCG7PavyG7efUhaw/kvxpKilqG/Jzo0BXvXF6yTnsc+ucpn/QRcTxD/vbkrXE3g==
X-Received: by 2002:a05:6000:178c:b0:366:e9f2:a551 with SMTP id
 ffacd0b85a97d-366e9f2a667mr12867600f8f.43.1719566394007; 
 Fri, 28 Jun 2024 02:19:54 -0700 (PDT)
Received: from [192.168.69.100] (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1108b0sm1637802f8f.114.2024.06.28.02.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 02:19:53 -0700 (PDT)
Message-ID: <6908ca71-6df8-4aff-b1d0-39e35aad7a1e@linaro.org>
Date: Fri, 28 Jun 2024 11:19:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 02/98] hw/sd/sdcard: Use spec v3.01 by default
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-3-philmd@linaro.org> <Zn5w6A20UVkrP3ca@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zn5w6A20UVkrP3ca@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 28/6/24 10:14, Daniel P. Berrangé wrote:
> On Fri, Jun 28, 2024 at 09:00:38AM +0200, Philippe Mathieu-Daudé wrote:
>> Recent SDHCI expect cards to support the v3.01 spec
>> to negociate lower I/O voltage. Select it by default.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/sd/sd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index a48010cfc1..d0a1d5db18 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -2280,7 +2280,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
>>   
>>   static Property sd_properties[] = {
>>       DEFINE_PROP_UINT8("spec_version", SDState,
>> -                      spec_version, SD_PHY_SPECv2_00_VERS),
>> +                      spec_version, SD_PHY_SPECv3_01_VERS),
> 
> Shouldn't such a change be tied to machine type versions ?

I don't think so, SD cards are external to machines (like
CDROM you can use any brand). IOW machines only provide a
SD card reader, user can insert any card there.

SD specs are backward compatible. If host FW only knows
about v2.00 commands (spec is from 2006 btw) a v3.01 card
will works.

BTW latest spec is v9.10 from 2023. The more recent card
I bought supports spec v6.00 from 2018.

