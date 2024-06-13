Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3281C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 05:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHd1d-00018X-FE; Thu, 13 Jun 2024 01:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sHd1a-00017x-9c
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:29:26 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sHd1Y-0005mc-MM
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:29:26 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f44b594deeso6001415ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718256560; x=1718861360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RC/g44T1tBengbVeTREAFc1/bMQwczbeABYQvn/mEWU=;
 b=UeL1pD+n1F4D28Xg/FN6ZEt11as+utICYmnGz65cc0VwWILGd0ROKP2mK+LajXC7w3
 Y6NYQjYCquUq5moqoa6/hf/Sp5a2QoiKNg7CTdUwiBgzDUjiqoVGSVSH1MKKLMt2DidD
 JMLw9/iTHZIU++6mZAqayRbnTCMzW/JlNprVp3iKWys7ObyjQzeofm3mTICSssKCMKTb
 m5MQwjP3LLx0K0ceSZvUSQTeTn2pYPdZv6/PPdT7IaYOXwjN29vkx8F1a4y/+eGfuIhO
 QQSlZaLFsSxSjtOhwsRCwwrO1pJEP135kMYCC7HB8SPvUTfbr+r2vnOuE0iHzVWXIJcS
 +ocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718256560; x=1718861360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RC/g44T1tBengbVeTREAFc1/bMQwczbeABYQvn/mEWU=;
 b=S39RLTVj5HbA9vH24+Ke633/8aAOFjg4vjYiqkBVxqusCn7PS3Bf0C612fpj46ZzL+
 oCcMwzjmNAvHZY1bDAGz32W8ac6YaEGRjQ8pw/YVp81gyp8Ok5g4+kC8b1zhTtMMSGP5
 Xdf9OkVtDcjbn5OxG8TArpwx9LPUtkxSFFAfjAZIRLUi0krJWGJkb+3i9/5haGEuSZkW
 SE8by1ecyx401k4dO9rtX5/6TC3utMt7jr2pk1QdmRaGJNl0YAAozLqoLL1HndiUVo2v
 9k3iRHLi5CV4eZiFzCSg/rFDWriMIfytcEqjajRX8Z53m+EAfHXVwjkPM2NfQnfXEAoX
 NdNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJXlVnJOZAbrutjt4fUIvXdOEMbfQZlcZPHlp/xKvIGwLzAWuvkWupCgCVxy9Wfc5UTD2fKSWn3B0eaIfPKqWJW5ZC85c=
X-Gm-Message-State: AOJu0YwxGTZHdQsJovHX0XURz1Tx5wpA/6NarkHixnXDJb5jDQmO8N55
 whGy7t2mfXOHObknC+te0dbOIin/FPsYMjD98VALqMYOV/9KPvZFr6P4Qv+Vf0QKQpJhYeN5IJ5
 H3hY=
X-Google-Smtp-Source: AGHT+IFsndK5Waxu1v6Ri6mJ1vJMyg8PiI0mJlSVoS76HIeoX3l70AGp1oMEKmVBkC6NeqCnMaipRg==
X-Received: by 2002:a17:902:ce8b:b0:1f6:7dd6:8d95 with SMTP id
 d9443c01a7336-1f83b68c9b9mr40438835ad.39.1718256560130; 
 Wed, 12 Jun 2024 22:29:20 -0700 (PDT)
Received: from [192.168.236.227] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f1dedasm4178375ad.248.2024.06.12.22.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 22:29:19 -0700 (PDT)
Message-ID: <ae030ac2-9a91-43fc-99e8-b7bcc7c4d205@linaro.org>
Date: Wed, 12 Jun 2024 22:29:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/25] target/i386, SCSI changes for 2024-06-11
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240611142524.83762-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 6/11/24 07:24, Paolo Bonzini wrote:
> The following changes since commit 80e8f0602168f451a93e71cbb1d59e93d745e62e:
> 
>    Merge tag 'bsd-user-misc-2024q2-pull-request' of gitlab.com:bsdimp/qemu into staging (2024-06-09 11:21:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 58ab5e809ad66a02b6fa273ba11ed35b8b2fea60:
> 
>    target/i386: SEV: do not assume machine->cgs is SEV (2024-06-11 14:29:23 +0200)
> 
> ----------------------------------------------------------------
> * i386: fix issue with cache topology passthrough
> * scsi-disk: migrate emulated requests
> * i386/sev: fix Coverity issues
> * i386/tcg: more conversions to new decoder

Fails testing:

https://gitlab.com/qemu-project/qemu/-/jobs/7087568710
https://gitlab.com/qemu-project/qemu/-/jobs/7087568705
https://gitlab.com/qemu-project/qemu/-/jobs/7087568701
https://gitlab.com/qemu-project/qemu/-/jobs/7087568694


r~

