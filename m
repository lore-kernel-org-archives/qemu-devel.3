Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8237AC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 00:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUEgJ-0003Lb-Sj; Wed, 17 Jul 2024 20:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUEg8-0003KV-Fg
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 20:07:31 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUEg4-0004Le-VL
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 20:07:23 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso636325ab.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 17:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721261237; x=1721866037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GNR2YS9MjwWFaWYnC9lPcaXv1f+Sf7sD5HNAWySJCKg=;
 b=Aztn/pf2s08KNSk5Xpp9a+4O7JqFvK0A1sQOhD8HHrtNXKu5Nu530ZBXU1hhoyqZRV
 JPmXqg5LrI5pSLWSeDLBR4S8T91jaTqXQUCySKgxbTD3aMTM1zfV3ZIrQ0dLHjq3qQSG
 K2vFa9LVHuMLTfa7g1nlkMckJTaydfeDg/162ehkNSuSNZB2eHTUiJgPS4j+0p2VJDW9
 ZwM6ZtUQwyiKT7X0ZFJQOfyu7biZITglCjT/HwdpllNXjjKbgrFCAYsBuBbMNNZUPvih
 92oopyWCtlo+gnwrwkw/90gcJYqWLG1hunLUWdJ12bnOOD6RALxl+jHbLH5fFLdSBXTo
 K2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721261237; x=1721866037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GNR2YS9MjwWFaWYnC9lPcaXv1f+Sf7sD5HNAWySJCKg=;
 b=cVYR3Y/WhfuKUPYv3lnzHBIrDBwcPeZ6vt/MeE3p37jhmO7oostz+9Kj8fQNup1YJA
 q5jGaajRom7YRv3dkKkVWmg3/hB1ToJpCq1bS6OVRP1xwnOiyFllU8xyZZaqgSknOUZs
 KatY6CNi0wRub5h5+aS/OEHIZKXi8I2CqJWzbAPX58xSBJxjC+5EdMGBYK/1QQ6FNYxd
 YTGSkOazexnorCzjGgcGd0HogOL1hSfSb++2rPJRzD1q95DAjMZVDvR2hI1A5AkOVzyL
 SHSXM6k6RyzYpkWW81r+79oHmBIfByps/roWKGEUK5dNpg946aEOvZs3CH7I6ZvhNYyP
 qvTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIjmv5BujH4SbpKjU77qqUIqzC8yT2KbwSFE/D+1QdOU2M6hD+UpnH1kXMmingEjpgFUGI0TACMFfhNtFj0fE5Bm89G+c=
X-Gm-Message-State: AOJu0YwvKeW52y36SAWj/3dNz2sUm+xacDeLO/gp+24nIZ0GXUK7ZC2j
 AJVU9TAVKeZGj8zVC/SHHow5gVi3FWPDKFejHyyZIqL2XS0Q6NcfsR5L2cW1YXQ=
X-Google-Smtp-Source: AGHT+IElvg7LdUul5H7Ag10tM0g5J0xvexPxFPmRGmzypRfmLDQ+LAaOhO8Rya81tV/tRRSerOMMpA==
X-Received: by 2002:a05:6e02:1385:b0:375:a3d8:97be with SMTP id
 e9e14a558f8ab-39555613dadmr45274165ab.9.1721261237163; 
 Wed, 17 Jul 2024 17:07:17 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-78e3485dcc7sm6883702a12.39.2024.07.17.17.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 17:07:16 -0700 (PDT)
Message-ID: <b38350fb-ca7c-41a3-afb3-296677f8adce@linaro.org>
Date: Thu, 18 Jul 2024 10:07:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/20] i386, bugfix changes for QEMU 9.1 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240717050331.295371-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x132.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/17/24 15:03, Paolo Bonzini wrote:
> The following changes since commit 959269e910944c03bc13f300d65bf08b060d5d0f:
> 
>    Merge tag 'python-pull-request' ofhttps://gitlab.com/jsnow/qemu into staging (2024-07-16 06:45:23 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 6a079f2e68e1832ebca0e7d64bc31ffebde9b2dd:
> 
>    target/i386/tcg: save current task state before loading new one (2024-07-16 18:18:25 +0200)
> 
> ----------------------------------------------------------------
> * target/i386/tcg: fixes for seg_helper.c
> * SEV: Don't allow automatic fallback to legacy KVM_SEV_INIT,
>    but also don't use it by default
> * scsi: honor bootindex again for legacy drives
> * hpet, utils, scsi, build, cpu: miscellaneous bugfixes

Applied, thanks.


r~

