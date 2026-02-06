Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EFAEE20A5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voMDC-0000vS-BQ; Fri, 06 Feb 2026 08:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voMCx-0000mQ-Ng
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:49:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voMCw-0003bT-3t
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770385753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HMYNdXHdZterONrEcNKytTPOCRM0WILMkmfkSh1pI78=;
 b=b5YoGs4O7iLq9bKcndeCxhytlDbES2J1D1ELpF8xEw2vlKGOmXzv4ueOZzbMl0GRspcOXf
 +PaRoLMiqBc7HbVMguXwZjN3YW9m5G2fZjkW5rPIBJeJjjUnTjqnFU4sStGMK0ZoWLsr7B
 G7zl/Qmq/PhE691Xbrf4sj929BhsagI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-WHIdmov8MTmPOSxB5BxQ8w-1; Fri, 06 Feb 2026 08:49:12 -0500
X-MC-Unique: WHIdmov8MTmPOSxB5BxQ8w-1
X-Mimecast-MFC-AGG-ID: WHIdmov8MTmPOSxB5BxQ8w_1770385751
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-435af2d3144so448468f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 05:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770385751; x=1770990551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HMYNdXHdZterONrEcNKytTPOCRM0WILMkmfkSh1pI78=;
 b=i3AUamB9oioiTLyULofDT7izExBO/dc4nZvFq1gPjX/uT7yMjPLbknd423R/lfmp+d
 jPFUy6FJBKppU+YrcdFPsV02gMCCJMJOEseTC2safk8LcA9UEmJzITjB5AqftM2ab8oF
 fi2cBgF42R+UrrkegXHfnVoyrJ+ydfhSE7NDLETx4n7uIV/0ZaBMARNLQ0+Xl0TPOn84
 ipk+NucPd+d7jKOVW68bOxRwmX/lEPujnw+uhMjwjSskd7Ah2Wv1ymUvFHK7KaE18jjh
 yMnVokG/NyXb9q4hTuAKye0kAaPA7E9Y/ZgRkEk25lBXSx4BQ6oo/IZSFpJhyZBjbLNQ
 pl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770385751; x=1770990551;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMYNdXHdZterONrEcNKytTPOCRM0WILMkmfkSh1pI78=;
 b=KJNzxVUUNhijffToODzqvYmOyZLrWlggWOcUUm345fpqf2Ga10q/Dspl+xxo3gT3AI
 tqpViiPHszFyuFF0JCQAlBppabkPavDGPLYTvvWMnSltUQfEw5+qbFlumOPuDgXn9MuP
 OxGCUnujhRf8bhy3W7liTWNVoBn29UaZQjo9C+Pnz3WEq+Jlp2H8KAAt//cSTgQ4e6C3
 DBtpGKyPkMFq0iFdBKU2uPQ1aSfS7afj542htFcLfzM5tawPRqYbcHWKBWvC9ChxEe8n
 QIoa0qC6JomtmqamTAcp5ojPNBScEZW4ZWPlI+sUKdxD9aJfMhIf5O2ajq89RbZaOTBb
 ddig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTo68fFFxm6fvX3F3wyTkjL1ukHaNxvcYVwh+y04hur7sTRf15EZqzrTEOyO2olIJ7aTBuyn/Z+o5z@nongnu.org
X-Gm-Message-State: AOJu0YxXjhsdpdwMY25/Y25yZB1N1nT2FJ+JGkYsBD3mHrEGGIgjrbJb
 tBy3VLdd5r6O+gSdfPwre3uGuZhDcTb0LWQ2RLU+xomiChHhpA9ec/lAYT8vYtDq8V9li9hORvL
 XuN+4/ZVlPpVEkB84m1NCvOdTTpf+fDVFR1kzcV1LFr3OVnXpEsIfLYQT
X-Gm-Gg: AZuq6aLcdBJRTrpl43No/N9WP2Ke4lMC7q75psTcMsMyGpaTM92kFtICtq/YuHmffa9
 y+VfS2ed5AVxGYvyfEG2hepwXR+eVYG2Ia3CwD2uuiNWjrvcGJFw0+thCv/PR55nU5mnSuLoFA+
 6w0r7da95M7lFXaePf/mZakFpD6lZfY0Q+lE/V9QzFCuezrp7VxjYldxgO8zw+ssmuTLn+CVv/Y
 odsXjfq/+gBr75muKyMwKY8EAKEA7t2pCFIvC7gdIVvxXtaETatykgoyCkyixw0wMCYcF1o/IVQ
 3usGqTUHVz1SxptjF/4ux2fYK6C+8ExkfAKpmQbvhzSC6yAuN16YS1stN+T4CCFXGNPdhECu3fZ
 BNNIrpg0=
X-Received: by 2002:a05:6000:2601:b0:430:f449:5f18 with SMTP id
 ffacd0b85a97d-4362938a448mr4875578f8f.46.1770385750623; 
 Fri, 06 Feb 2026 05:49:10 -0800 (PST)
X-Received: by 2002:a05:6000:2601:b0:430:f449:5f18 with SMTP id
 ffacd0b85a97d-4362938a448mr4875533f8f.46.1770385750185; 
 Fri, 06 Feb 2026 05:49:10 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362974527fsm6480757f8f.31.2026.02.06.05.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 05:49:09 -0800 (PST)
Message-ID: <106811fe-4437-4a8c-9a39-33d64a287d6e@redhat.com>
Date: Fri, 6 Feb 2026 14:49:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] gitlab: ensure docker output is always displayed in CI
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260107130145.1495219-1-berrange@redhat.com>
 <20260107130145.1495219-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130145.1495219-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 07/01/2026 14.01, Daniel P. Berrangé wrote:
> Set the new $(DOCKER_V) variable from the previous commit, so that any
> CI jobs invoking docker will show the full stdout content. This improves
> the ability to diagnose any build failures in CI that involve docker.
> 
> For example, when a 'docker build' command fails, it lets us see which
> command in the Dockerfile failed and why.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/base.yml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
> index 921c562000..7640a1d52c 100644
> --- a/.gitlab-ci.d/base.yml
> +++ b/.gitlab-ci.d/base.yml
> @@ -28,6 +28,9 @@ variables:
>       # we don't need. The --filter options avoid blobs and tree references we aren't going to use
>       # and we also avoid fetching tags.
>       GIT_FETCH_EXTRA_FLAGS: --filter=blob:none --filter=tree:0 --no-tags --prune --quiet
> +    # Ensure docker.py / tests/docker/Makefile.include always displays stdout
> +    # from any docker commands to aid debugging of failures
> +    DOCKER_V: 1

Reviewed-by: Thomas Huth <thuth@redhat.com>


