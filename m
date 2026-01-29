Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA024D73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXsR-0005wu-UH; Thu, 29 Jan 2026 14:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlXsP-0005w0-P4
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:40:25 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlXsO-0001aR-3c
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:40:25 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c634bb5bd8eso283916a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 11:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769715622; x=1770320422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gi33PVulAppyaVXDEcU1cFkYUEPsCTICJl/yVBzEF48=;
 b=DyhL9LaNLXQ1sbQsylXV90mcOSvCodl4dpjMQFbWiFCciA7/vJsIlU+DQS94MIo33x
 Xc+S5QSs/fkzSEHtT5mdv5RfnkSU8ag3IyMyeXGevFKkA4mdm+KlVX9IJVmIEt7h7aGx
 EP22a+LdQ2N7RakRUrNlqE/phIej+cAW5iKLOWKsSFYOjh9/5x1Br4uoJUrZkaqAlOox
 NFbWDhGCo85kJ/MM6k58yjXH3xDiVV970WLNMI8Rv8CA6zQuw636/cbPsuBP+SDs+39a
 i8T0xAA0IdSBs4YF+p8IWg5KpInq8Zq+7YXvnaN0cqd5t5+jDzSrjzEBrf2NZDwVjVEb
 ZUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769715622; x=1770320422;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gi33PVulAppyaVXDEcU1cFkYUEPsCTICJl/yVBzEF48=;
 b=YgnERQK6ZtnY5WP4hIFe3NVZ4Tz1f9WRV0qnI0qAWKCtRcC/Nv49/37oTHH74tP210
 PK5sMensaQFcw1otrupIDcTiVtfxqfxR9+k/uhOEdR2kmiFFKvV5Mshd2gkZZuYyaOs4
 oQI/IffMYQY4XYQU8T8/Mgg2Q0/vyHmvL9Du37QaekTIMKQ2dmEzdHRoHQC1G3gpf48O
 ynU+jSqlKm9N+UJBu8H840j1tvS/OL3ho0xfQMX1prH13IFN9I37J+e5hvTy3PmBj8af
 i2TmrtEj3r9eB14rbEXr6IUHtLeYR7gFL6sED3bN4ySs9XBTckEmtJzakopsmh6VWTAa
 y0qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWOyGpKXvEz0VLG0PPFN7rUpxyOBtPQpagsNwD02MmtL3c2RO8OM6yPF7LvhAbTDITy0yPVsz04wkQ@nongnu.org
X-Gm-Message-State: AOJu0Ywu2iYlFOMxypsp4NI0pLEQJJ4Lm9l70wuqYkwVyENaWytcg9un
 3HTsvzEtBn4L0i0CoG9osOAAbF2Mq4mS/jxcSZHZz3liA2DRMiGnviSmI4056fJ0r68=
X-Gm-Gg: AZuq6aIWf1y6R0bI93r14JEpKqzjLX5GJ1KUvnd9+brH2EtMF/b2BI+GGffAUnlxDNv
 Dsiq1JmkcdMbe/V1LDCdAnxgku577sNZwW4bRzRCSWTi28Kwm8+CtsZQMExBEfjzgpL95RvSY2f
 hvDHISIZo8VYAgzMopMlxB8o7fEYQzKjcypdqTJV77XjrAswCqdU/HBreEfzIfaL453qxtfVcM2
 Bhvt4w7nRBfDNml4JRVXzl84xoZgCpiA+noY2A/AJegWGYZ1BrEGx+u48ODbvuIld6125FUF0VN
 gIeILmOqpV+5f71lbXqqgqTlX52GHjE0qwlCF6ytXJTXYzskfeOPUeQ1cHQBTTn4q3Q87A2I50t
 peBRbUsyQSVGpG2FHIdla4X9h4UYougC6uhOo+Tx/hm7t+l5rlyWDcCl6fMAxW34P4koNPAmBlY
 EMZEMESjk66BRnOuYYwAgI1GdJe2AxyC+ngY29EmOKKwP9AegDN9mJiXoW
X-Received: by 2002:a17:90b:4a4e:b0:330:7ff5:2c58 with SMTP id
 98e67ed59e1d1-3543b2f3403mr569568a91.7.1769715622272; 
 Thu, 29 Jan 2026 11:40:22 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61dfac1sm10227047a91.9.2026.01.29.11.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 11:40:21 -0800 (PST)
Message-ID: <983bdc51-7c3f-4d5a-a3ff-5ffe6fbf3271@linaro.org>
Date: Thu, 29 Jan 2026 11:40:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] monitor: Have MonitorDef::get_value() return an
 unsigned type
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20260129164039.58472-1-philmd@linaro.org>
 <20260129164039.58472-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260129164039.58472-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

On 1/29/26 8:40 AM, Philippe Mathieu-Daudé wrote:
> diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
> index 5167d17d41d..6d6653aee6e 100644
> --- a/include/monitor/hmp-target.h
> +++ b/include/monitor/hmp-target.h
> @@ -32,14 +32,13 @@ typedef struct MonitorDef MonitorDef;
>   struct MonitorDef {
>       const char *name;
>       int offset;
> -    target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
> -                             int val);
> +    uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
>       int type;
>   };
>   #endif
>   
> -#define MD_TLONG 0
> -#define MD_I32   1
> +#define MD_TULONG 0
> +#define MD_U32    1
>   
>   const MonitorDef *target_monitor_defs(void);
>   int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 420969bd6eb..1600666ee92 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -67,7 +67,6 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>   {
>       const MonitorDef *md = target_monitor_defs();
>       CPUState *cs = mon_get_cpu(mon);
> -    void *ptr;
>       uint64_t tmp = 0;
>       int ret;
>   
> @@ -81,13 +80,14 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>                   *pval = md->get_value(mon, md, md->offset);
>               } else {
>                   CPUArchState *env = mon_get_cpu_env(mon);
> -                ptr = (uint8_t *)env + md->offset;
> +                void *ptr = (uint8_t *)env + md->offset;
> +
>                   switch(md->type) {
> -                case MD_I32:
> -                    *pval = *(int32_t *)ptr;
> +                case MD_U32:
> +                    *pval = *(uint32_t *)ptr;
>                       break;
> -                case MD_TLONG:
> -                    *pval = *(target_long *)ptr;
> +                case MD_TULONG:
> +                    *pval = *(target_ulong *)ptr;
>                       break;
>                   default:
>                       *pval = 0;

This one is not obvious to me.
All the caller chain is using int64_t (maybe wrongly), so would be safer 
to keep a signed value, and adapt the read size.
So best would to merge this diff with next patch in series.

