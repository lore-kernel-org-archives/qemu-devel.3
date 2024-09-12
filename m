Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A680BEED63F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 18:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sooR1-0004FL-8d; Thu, 12 Sep 2024 14:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooQz-00045q-NF
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:20:49 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooQy-0000jv-9b
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:20:49 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-718d606726cso795675b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726165247; x=1726770047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I1VG+rWfyKKDckt+wkS6SN52srcAQiuKOXesuq3EiCo=;
 b=PeciZFmDUJinDD+7TS+ypLPTNhIGO27zyYPHM8b7nlf64MXpzocQftPcblGNUtKU2u
 bxfYwfxT363/jWK5U9N8CWhy+TestYjMMsCyHeMwWLh0nQtX348C3dX8IxUqaL0/wU79
 MPPXmQy4oDssUMtCGhDhbmRZBC4dCS3En84cIF6qnq+1ZawElYLFo7fyBY29N1mnC5/J
 Bd1diY/ytXyrm3S1RH4IUjZp4AEVkKmhWA/k20ndCv+4dlcuxrTClJHDtrqhJaLbLL06
 5mxDLqvjS6eUzykCdbQ4kvjBPUKob9iitdJpxqB0QCCRb6u7grIJ2alZCawww8zHKHNC
 5b4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726165247; x=1726770047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I1VG+rWfyKKDckt+wkS6SN52srcAQiuKOXesuq3EiCo=;
 b=UfRXssKzpFyTAfU+n1G4g0WuPZaf+4tTDcv+wlaxAgteJDM//0vCx1gaIngWP6S7+X
 8ZDMnH1fH/cB+daWVVPAqExLyry46VwanCsR0kv2kje1YQSITCxqV5jPkgR6AdyvnQo/
 5YTEB7jOWPHCdsVDvICy8DJPJMrCVTzya+jsEX72QJmquxDDkiK5ItX282LOvrq9sk/K
 T5L45DBKKEd42DD7PU/cNB+Y7t7PJXSgBWvoX5ZFuLXQhiae8bXZGztRb2x7WqVWQhCF
 3rDzvDiZhp/Dh0Ye7mIAisFITL5Q6jxSW/JRr3GnF5iFzsC5brcA1zyEBs74O6OubrCz
 oyGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEh2c1xpYau6bjLYrjfMRQ1YSxP3RFvyqn+11JCPPtXStRU+aT4BK9k61sl84IPStplDrNc5ycSULA@nongnu.org
X-Gm-Message-State: AOJu0YzTpNffgNM3jljYFclrsO6KkfZgg3nZzX4hoRqoqePLNztc07PE
 SzCOwZYdmu+RIdatUtGQg7zGc5i6WtANkPhBfryqJAJz6YbPxnRuKI4Cj7GXkdk=
X-Google-Smtp-Source: AGHT+IEIRsxhyOlBqEsen7u9c5uBdqWnEfD1PRQHBcTkIKaZrw9cxPviucul3DSiiVV+2grgj+fpQw==
X-Received: by 2002:a05:6a00:3e09:b0:718:9625:cca0 with SMTP id
 d2e1a72fcca58-7192607f43bmr5819045b3a.7.1726165246614; 
 Thu, 12 Sep 2024 11:20:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090b0286sm5052648b3a.146.2024.09.12.11.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 11:20:46 -0700 (PDT)
Message-ID: <dc9390db-0128-4d52-85da-f960d835c05f@linaro.org>
Date: Thu, 12 Sep 2024 11:20:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 46/48] qom: remove return after g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
 <20240912161150.483515-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240912161150.483515-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 9/12/24 09:11, Pierrick Bouvier wrote:
> This patch is part of a series that moves towards a consistent use of
> g_assert_not_reached() rather than an ad hoc mix of different
> assertion mechanisms.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   qom/object.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 157a45c5f8b..28c5b66eab5 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2079,7 +2079,6 @@ const char *object_get_canonical_path_component(const Object *obj)
>   
>       /* obj had a parent but was not a child, should never happen */
>       g_assert_not_reached();
> -    return NULL;
>   }
>   
>   char *object_get_canonical_path(const Object *obj)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

