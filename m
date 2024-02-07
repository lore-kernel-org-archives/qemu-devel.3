Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7599FC48297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 03:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXYBA-0000zD-FO; Tue, 06 Feb 2024 22:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXYB6-0000vR-8b
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:00:48 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXYB4-0002Xe-QT
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:00:48 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d958e0d73dso1505925ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 19:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707274845; x=1707879645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uivkR/8c92ObuW/uqwbDVnO2ED4wYDNecWvPHtU5H48=;
 b=FytLP6lFWk+3zRiKzyOMr19SrtoV1trxL+jkCApywy3PIGDpv4eQjTPZBCJjTzKMda
 ScCA6HYUy/QNIj0xnNhqGU9O9SdtkqPBJJktIfSfSojkUfvRkloD3RPxb8CQ7F9Np63u
 5Ff/Kv3YF4hMywuNeKwsn/GQUnzu5AVeNam5tTjWzZEMIYU8j/tb8ImwjOlKpBcD11jN
 pWy4/NJU/umhTWDtv72Ptmm4sBIaLrOpbgLDulQf0dEHiWnAVbNaN+WPxJixPi66tABF
 4BQK5y8nrxr2VU5uCBmXLhTOL6+QgtST8gC5bBjn4n/YxfrggIWO4nvdsYeK+OoEelJ7
 Pcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707274845; x=1707879645;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uivkR/8c92ObuW/uqwbDVnO2ED4wYDNecWvPHtU5H48=;
 b=f9rfA48l5Nsn2hz4CGYxFE2gKRqofZ5iN+hmx1lrIiJqWsYCUCjPbT/+zvo0CqfXT1
 nSJdEPPBykgR3B1sRiyEt/XTacWqpGU5/RKDCXdooRRSM+NjqF3/Z6KkQp+iVTmgrPCu
 N8nC5fByWj0i5C9xeColrOdv82VN7hxCoN8bWrY60K4Vu8zho1cku+km1vQ8pLkXcfij
 suQoVqQGkRyhFun3P92OhPpIanAajxdkyNYDrZbOYeexu8UtA96OvnUw4FfEuWrlgXoZ
 EyYgELG5kIlM5Rhusa1W2ugDUt4quNpsLPi//MY04Xtji1zmGPJqPEjXsDDr3J/3lxkp
 RD1Q==
X-Gm-Message-State: AOJu0YxElVX6zYB6r6q3l3N9W/nVQiVgw5uGY4PBCOyF1T+BwJmIeBco
 l6v0JRod2kjD5UJGfnAtqKAxvg4CwEqMZfCHHTrjwyjlnURNxYoc1jqgmeNDYMwCES2hB1rucXs
 WGA8=
X-Google-Smtp-Source: AGHT+IEUMkxXIbKKKOX+DnT6BN/fiz5s+0v8WzKu0Mrj/kXeEqQ0EJ6LAYV1rrCkatUX719mZpwHqQ==
X-Received: by 2002:a17:902:6f16:b0:1d7:7583:6d1c with SMTP id
 w22-20020a1709026f1600b001d775836d1cmr4657149plk.16.1707274845487; 
 Tue, 06 Feb 2024 19:00:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX8+zFIcQywzPYmh1imaYRWy7N4fM4S9zxGKpZ233cIEd23VCZ/KJ5UgUkqVA0rRnQ+C471RxQOxxHEooBHE8HbIkLnithbEK6OgDxemnkskADstPPR0x516O2bIHv0mwqm+4e2tlfqYzP/Yj3oT24ry0KIK65ivBhDZVl+bbuRu1xC6QkbvlL6nsJDcLsI7jzxQXa78ePriA2krHKYUh9jQ/Ih4GdHtpycyatB0aQbsx2XnmlMLT943owS0zn3jaSHcC0NVhPOii0HsXWfpxz0rNz3IbSY3DOnynZ/Ml3JoeCwPQ==
Received: from [192.168.188.227] (60-242-98-186.static.tpgi.com.au.
 [60.242.98.186]) by smtp.gmail.com with ESMTPSA id
 kh11-20020a170903064b00b001d8e91cff10sm262708plb.5.2024.02.06.19.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 19:00:45 -0800 (PST)
Message-ID: <dff7e9f2-f337-47d0-90a6-567e333ec0bf@linaro.org>
Date: Wed, 7 Feb 2024 13:00:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/17] cpu: call plugin init hook asynchronously
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
 <20240206092423.3005995-5-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206092423.3005995-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/6/24 19:24, Pierrick Bouvier wrote:
> This ensures we run during a cpu_exec, which allows to call start/end
> exclusive from this init hook (needed for new scoreboard API introduced
> later).
> 
> async work is run before any tb is translated/executed, so we can
> guarantee plugin init will be called before any other hook.
> 
> The previous change made sure that any idle/resume cb call will not be
> done before initializing plugin for a given vcpu.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/core/cpu-common.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

