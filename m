Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1320DC982DB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 17:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgnEN-00072M-U3; Fri, 16 Jan 2026 12:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgnDT-0005r4-2a
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 12:02:34 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgnDQ-0003Ex-ID
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 12:02:30 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-81db1530173so1117935b3a.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 09:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768582945; x=1769187745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IaC5cMq3hpNZfgvKzXrbibMIMM2X53QxWy4khHC+OFo=;
 b=Z4cIh9xrIyVUWHFt/6oNIExZipTv44PwFF/lWITXP+BG50nNNpXJy2byScCjnPPRqA
 wT0mS9AV3Z8drju0XM7gfrs6F9MUKDxhjpwmIawenKz4oMUEldSTReZoqM5rWJOLPUQl
 0Dj/m71u/EV0MFKW97B7SPS9+luNc7FOyqqVoJh0A9IO9DneFpG1+vTYXY4Pb95QsPwV
 sfiwGqQKvAvZOTb92lM+P16STqVUATgBDfC4MWLfDZhiPQAhLInU4hCT/wlywtK3XsAK
 Jsflgi8iG8Lkk6LkHPub3Atx91BlYbH7cxtZzxp746VXNcx6OriBI2IVfFv1xqt4LWU7
 OptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768582945; x=1769187745;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IaC5cMq3hpNZfgvKzXrbibMIMM2X53QxWy4khHC+OFo=;
 b=L5oooc7JNwfpZmaZd07gzswjlSbczlrNFD7u4OslZ81+G9eTTlLpJNbhcVgNnSOIBZ
 UaHa9JGHFn8jcXLcepygZsf1Z8BHxWjMKVa735aWmkrzcXieexUBs9ECHq+4iqE1rH9S
 JWxKV8bk6rpiLYQnjFVW20jQtnSevvAC+ZrZPkELRSuT9Vbf8BRKmN8dkDfc/ilFh74u
 TaIC5Fv39MTvg7BMTmB5aehVVQ2Mi3s8NVakVnE17Wz3Z2wsKoXgno/iaBZX2oKzVJky
 nycRzIpR1Vvfh+v3Utbp2WAHI/rXG7IGtw5KUnnY/kN798Ft3liyi0TgD9TFs9bwwEB6
 PsAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+28Odi3JAMFq89Bjg8FaJCBIjssrxTpt131w37qIEcCcOYk/isczhY22eH5n/I3hZPFLTcc/6O7RO@nongnu.org
X-Gm-Message-State: AOJu0YzaI+OhqFm3qJ8GbaivwqxoHLmQyv9Yb5CmAmrJEee/GRNiv/3D
 yaOY/xA2Xqt70jiw0xJWVn0edD1mta9qcj//YzXY7uTs0+xZi4kuHH5LYMIdgzotOkA=
X-Gm-Gg: AY/fxX7o5JTuwH1PePocctHOB8Ol7QOKFLupEIShldHYy2ucR6UbkHKWClBigzw3euE
 dC9Q5pfE+9Sj5EodbtFulxzsdHFx9MGNEpm+9LCHbtPRZOlX9ONmwG/q6EKhJz2YXYQgY9hLQ/D
 gefWaXqfGk/2JhSRlqPl8n26UFAZy7ZYQPEmqb+BeJnIQSGV7KFasyuUkvJyTQvidcrTpdyjuDv
 aQX4JQr3tGwGs8njzrPfaTyZSEgZtiRcS3QrphDfRaAlKvDEwHcLqcooBVy21cCHsSGrSpte0jM
 9T61Igog2LEMkXsHG8zSogXwXCi1miWwUmYE3sS/tZVmMG8oZ5MdXFO1b2uuyBOORprqPW6Fq26
 hmbiTjQWU2elGJI61GWg7MxDOu92z7py7MZAXxWbG6GWHyD5lQ1sjtR7FXX3QjKArVxGxOofHrV
 g+TJWW28q8YZUl2xO5qKE5Yam9nYfqBN4p9w19wIGDpqnpn0dWwa4BKGy8
X-Received: by 2002:a05:6a00:891:b0:81d:7db9:9c4b with SMTP id
 d2e1a72fcca58-81f9f689487mr3338752b3a.14.1768582944751; 
 Fri, 16 Jan 2026 09:02:24 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa108c51dsm2548282b3a.14.2026.01.16.09.02.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 09:02:24 -0800 (PST)
Message-ID: <e86ac5f5-2131-45f6-ab40-1f24dd553669@linaro.org>
Date: Fri, 16 Jan 2026 09:02:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add docs/system/i386/ to the general x86
 architecture section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-trivial@nongnu.org
References: <20260116101139.269906-1-thuth@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260116101139.269906-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 1/16/26 2:11 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We've got a section for generic x86 architecture support in our
> MAINTAINERS file - this should cover the docs/system/i386/ folder, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

