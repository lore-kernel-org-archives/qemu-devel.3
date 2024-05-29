Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A9FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 18:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCORG-0003bM-Vt; Wed, 29 May 2024 14:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCORG-0003bD-0s
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:54:18 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCORD-000524-T9
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:54:17 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-681a4427816so53107a12.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717008854; x=1717613654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3WMv8DCVN4oIU6nQp6oJh/Ux2zQlTi4Elj7ApRKNByY=;
 b=G5JqxwiM7upa2MdKkFBQSl1Kr9tmDu4dLXJRD39hfdhlEPBLN6jbtZxNaHge63qC55
 UVhrJVzTtSdmiDWb5T1FoxEDeufxhV1DqmAr0fWpwzbyc2/U7rislCapttnkRngkvCJS
 TtjAnqXCMS2kATboRL8flEvhpucO5wVlEnYk1RjZ2XvMFELc0sv2wTM/kPt5eROUgAmD
 8tfXVW4QvAGsR6+Gf3CdbgZKvBs7sXK32pysBjYmSXUqHgV/BtKzaBBi61QmG3dBfWwm
 evmUeElE3LM+xRMY8paa6AeIDqRkiyHJjzUPMc2hjhyx05j4Ap4ABYAZP8+l5qMNGKFu
 jyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717008854; x=1717613654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3WMv8DCVN4oIU6nQp6oJh/Ux2zQlTi4Elj7ApRKNByY=;
 b=WKDdnVHGsSq8X0sjkvu5PQoxgBXOkvqXcqlYj1s+VZM0wpL3onMGrfzolbOWywKZhj
 6TDNnq4EWyhsjkCjoJeSHIcPIiWK2OSA9u6ik9dejqlw4TIGtk1F+VKe7xD+F1mSkI/1
 7nX2amXGcnsjB8BYw85PiyM6noZbbykYA5pS51jeUOziXvLG2q7vEAm9X4jYV/pUvTQT
 o0gaZCxVlGDPaaRs6DC8We2zfTR1CapnFXYxMBMdVJ415ZaefeVXOZWW8MOMWKq5rmM2
 BmpasMYIhjGmzRgPSIvBLcyJLwObuanlMFTicAxdSZTSRci2LfEn0KRi1ccs2slkPVFM
 KofA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdX94OdpzmSe4C1Jr+rWMnGHAiC0CHgfbHVylZhFugT6wICmWN7FZq8G8RnoI6nuYS1xBhK15m8N4o0Xi5pjwBsI8y4lg=
X-Gm-Message-State: AOJu0Yz7Pnkbk2sZID0DQzUKDFGishGVpHlvHbTb04SdKQGIwlVg6B0v
 aRB7pGdBFyHHGy9YmZJ4yNcDF6Qu7+dhlYNWFpVVN5iOHlnyNIKS0nqYZTgLoOFu2rL216IJm1N
 g
X-Google-Smtp-Source: AGHT+IF/jNwQqWprxAl5dIkVpOcfI2x9L/fTBgaof5h1g0scSIXtd5jK85ymbdTHwFyu35pl2Uxfog==
X-Received: by 2002:a17:90a:134e:b0:2bd:edd0:9e34 with SMTP id
 98e67ed59e1d1-2bf5e47392dmr14756052a91.2.1717008853659; 
 Wed, 29 May 2024 11:54:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a778309csm108053a91.25.2024.05.29.11.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 11:54:13 -0700 (PDT)
Message-ID: <fba7f067-cc90-4713-af69-6e164923f362@linaro.org>
Date: Wed, 29 May 2024 11:54:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/22] s390x, build-oss-fuzz and Clang -fsanitize=undefined
 fixes
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20240529105454.1149225-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240529105454.1149225-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/29/24 03:54, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 79d7475f39f1b0f05fcb159f5cdcbf162340dc7e:
> 
>    Merge tag 'pull-block-jobs-2024-04-29-v2' ofhttps://gitlab.com/vsementsov/qemu  into staging (2024-05-28 11:28:34 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2024-05-29
> 
> for you to fetch changes up to b04091393e6a71065aee6c91b2566f2dec95a4c9:
> 
>    qapi: Do not cast function pointers (2024-05-29 12:41:56 +0200)
> 
> ----------------------------------------------------------------
> * Fix and improve PER emulation on s390x
> * Fix problems of the build-oss-fuzz CI job
> * Fix broken update-linux-headers.sh script
> * Fixes for compiling with -fsanitize=undefined on latest Clang versions

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


