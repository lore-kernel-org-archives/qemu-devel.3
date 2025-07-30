Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B55C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 19:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhCko-0005ox-DJ; Wed, 30 Jul 2025 15:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAsr-0004S8-Jr
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:46:34 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAsp-0008RF-Na
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:46:33 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7698e914cd2so80355b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753897590; x=1754502390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z1tdg/d08QzhkT2bfQRh+cZppFogE73Ky3vRpYTZgzU=;
 b=r3mYf7BRFlSG3pParJPDm22OsKHA6cHWC76BCPBkutlb8Athui6KQwMzfScVgHcRI/
 vyy9K0qEstRdbF/mEEADozXFDwslyqtsVOB6wTU6rJiygme8KKLSj61UyhscQHM957Uk
 srZWcl75WyRYroYqqN0HgKp7QuuR8ZNuZUpN2wlDUR6OH15HXUkouTAtmUhvmPb1fxKa
 hpRJLn/lFmfD1ytc7S2m55hBzIWSeIKUi8L6oCWrP9g6Xd0TwcHpt0vITFHhqXWDlKFm
 TwTsrNU24SVxU2ufzucyN+ZCsLJrxJ+zRxg1I+b8MSRSmCx8EetuVcrqeMU6IkeO5oDx
 CwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753897590; x=1754502390;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z1tdg/d08QzhkT2bfQRh+cZppFogE73Ky3vRpYTZgzU=;
 b=Qgq7pOh3lTeoJlHsAJKW1Cbn6EXEpKhaZo8hLvowMsv8VMmaHekX3B8BOuxrzKw8rP
 z+TP/2ABvo8S3WJuPGXmn/6MUtDQWfXKsxQ9HmV6EFfJUCjjHG1Tb1YjTzS7OsRvCV0j
 sS0UWytALcc0tvQUQvn67D8R3s3MbkjU5abirKXHhVzCaUTcuum4rR/JVz4epL54cmoz
 e4LrkNqYM9sCd4dmyM+sVtG2Wm/MYuQQvkTY5Fq5pJHjA8IWCrgJXiSd6v5rvQLXsxdA
 2WXM5U2roXwTZtrOZS+JbRpv+xvWXFaq8jnfvldTlQLLu7kLPnMJTriw1Hf8apjflwOj
 Cu/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpPdaTUr1XzZapWcT1ISSdUZrH76FC8MG8X/psu6b7KQiVtd8qju70VnQF0CG7xg/XywwcUdrOL655@nongnu.org
X-Gm-Message-State: AOJu0YxQo5TmyG/Pt2E6uVlsg/keC9CciBOJmScAxlbU0rIUgCVOXZMb
 ERt/fssgWLv0yICmJsZt9wBzRwitlxsuak3WEaBYWhqYtciKoy2k1qydqyvVNkBGbmg=
X-Gm-Gg: ASbGncsyHJmrnDqyu/UpmsC3TDjd58jv/glVXrhvMZ6mRYMRBndMN6KR0X8TNk/xWcy
 e+v3dsyCjlRRuqu1otFZTHR62msam1X2nmUEUXfpdEAVhSMULax2GiGWbnbzsms1fVVvxxW33OM
 oyUP+atSGu9V/PA2wtc+Mll545EvcW20vWo8P2cc7piVmYfY+LC11UFqZvdDYpy/IU0XPSTPn3S
 LxeuSbhJkVCMz9NIpWYk61Clc2+2jFAYsnCGxFxkmPZYRAJsweZoqSuJRbkSz95HL4KD1jgaUuh
 vTNr7keAsUTyW8V5ANcLlVS/fXTad0u7fYN423eaW8ahCa9srmE34CmK48pMJq48nPhfGzEyYK1
 85wMEjVe/fMk6R1zhQ0hjInIRG50e3UTL8pw=
X-Google-Smtp-Source: AGHT+IEmL+Ew2foSmVtFJD39m997U7VhLkJBpwFNvj2o49jnA5jVFn7CLzqiziCyTZmgMni+u+2m0g==
X-Received: by 2002:a05:6a00:4b05:b0:749:bb6:3a8e with SMTP id
 d2e1a72fcca58-76ab1021233mr5268371b3a.1.1753897590261; 
 Wed, 30 Jul 2025 10:46:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bc889f6eesm113487b3a.98.2025.07.30.10.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 10:46:29 -0700 (PDT)
Message-ID: <b728df0f-13a3-400b-ba01-9b87dcb5f893@linaro.org>
Date: Wed, 30 Jul 2025 10:46:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] contrib/plugins/hotblocks: Print uint64_t with PRIu64
 rather than PRId64
Content-Language: en-US
To: Alex Bradbury <asb@igalia.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com
References: <cover.1753857212.git.asb@igalia.com>
 <5d26c9d99ee87ac4a4034ff64e3d8881253eedf3.1753857212.git.asb@igalia.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5d26c9d99ee87ac4a4034ff64e3d8881253eedf3.1753857212.git.asb@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 7/29/25 11:41 PM, Alex Bradbury wrote:
> qemu_plugin_u64_sum returns a uint64_t, so PRIu64 is the correct format
> specifier.
> 
> Signed-off-by: Alex Bradbury <asb@igalia.com>
> ---
>   contrib/plugins/hotblocks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


