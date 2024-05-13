Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EE2C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Wbr-0002hI-Df; Mon, 13 May 2024 10:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Wbo-0002b3-Kv
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:24:57 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Wbm-0001HH-5U
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:24:56 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e4b90b03a9so49835141fa.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715610290; x=1716215090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=InkH27BvtZX7rKA4G7bUkVIe0lHy4wDl05j6hkh9R1c=;
 b=Xw9RH6HfakOMLchxl8Ug/wm9LcWSUfBFd1Wk+bR2u+sSgEsrWDH1bS3hLtTTBpgLfR
 IyswTX+WsEt01d53hF2epX57+NDL/BVEEYY+PfgwcodoZ4TmTsMcZDxC5I0/M70uMtFl
 Orb3zVf0kpNEZx/hzAY+DKUSpqX7Tr78DL/FycedY/rMNTshrx0HP7nHb/el++6y35iU
 jgCUCd+FhJ5mBYApxjkpb27N/1drLLsWLZgKLB5QaVWWq229lO3JUxTMtElzrbDd+8QK
 w49tQAzI1wied8mpuj38jDSmpx+yzrt+naaJV9k90I/kAG9iz7w8H33M3WCbXuE/4FoO
 5GfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715610290; x=1716215090;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=InkH27BvtZX7rKA4G7bUkVIe0lHy4wDl05j6hkh9R1c=;
 b=vdflUW2HpV9RElaFrQ6HKdv1ErOg3acUrpTg3cu71NUr8KQB+FQGx/z++lk6TYivLs
 zIGNamnn0ygnIQ3vgbgXE+fxOgPNqHg6ybAeyI505G7ZFwUAysjntkB3J+ct6u3TMaSm
 KRW/tDJa5Do+2TzuZTEeQ1PurlIGo/aTwAjebIIA1V/PVqJsq5Z2RVgsPfUYxEfxAq4i
 Mj2oSN8WjkiDKbSdvaZ3K8M73ByREI7lQzInDIB0MEZVCkKAykYSonUnxaIkzIGVEYqu
 bqJDfFHKgH1eW6Sad3lP8YMADIIrhZRFy4HP7amtcwxKXtgqJgjtzg6mnXKx9pMLot7F
 0Zgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwWvTp5+MznjQJrNRsv+S+Zx1ki/vARI6EH/tsBt2tex03H9qC5jBo+I+r8FqZalRC3ryaRNr0fhBhU10FVO9GbRn4R8o=
X-Gm-Message-State: AOJu0YwKxfJfDVyC47iF9Vt2eYtlRH15tocae0lqIZDOMu1PQzf2WkKk
 hW11Ybjg3kQr7z2DevAxPqanF31uyiqRszH27V9WtrCjwNSsj2yc5ao/sZTce+Y=
X-Google-Smtp-Source: AGHT+IFXxmIOC92WptK9bK9qoFdMjr2iTtl5LmcBLcS4anTS2K2VuewvUUX/IImxM2ruyAzFPgdy1Q==
X-Received: by 2002:a05:651c:550:b0:2df:b0e3:b548 with SMTP id
 38308e7fff4ca-2e5203a4a63mr69043091fa.42.1715610289864; 
 Mon, 13 May 2024 07:24:49 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee92c7sm164221445e9.34.2024.05.13.07.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:24:49 -0700 (PDT)
Message-ID: <b0d9d518-9e44-4278-b2d9-71258b5dc1f6@linaro.org>
Date: Mon, 13 May 2024 16:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] block: Improve error message when external snapshot
 can't flush
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 pbonzini@redhat.com, richard.henderson@linaro.org, qemu-block@nongnu.org
References: <20240513141703.549874-1-armbru@redhat.com>
 <20240513141703.549874-2-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513141703.549874-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

On 13/5/24 16:16, Markus Armbruster wrote:
> external_snapshot_action() reports bdrv_flush() failure to its caller
> as
> 
>      An IO error has occurred
> 
> The errno code returned by bdrv_flush() is lost.
> 
> Improve this to
> 
>      Write to node '<device or node name>' failed: <description of errno>
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   blockdev.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



