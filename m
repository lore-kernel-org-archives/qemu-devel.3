Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E347CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 17:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruF9G-0005ug-QV; Tue, 09 Apr 2024 13:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruF9F-0005uT-5u
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 13:20:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruF9D-00073e-Kd
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 13:20:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-416b66163a9so6567205e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712683238; x=1713288038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7upzKhctXTHB+JezNvrEEB+2BZRWcLbA9Hxk6neYrCU=;
 b=upq4OEcZWbsbwcQ3fZXlNikRYWFKRG2TukPKMEm/x+blRc+jiKocwGqGjBdy5e6G0c
 fcTMbAJGYvPbPB46rM/8wCxxjTv/PjgKVbDuOzEuayqeJlBSQDTJ//69yHRrBSyflDuv
 IwB/ddcehD6nhGG02tSg/X2ipgvZ2fYRMf1OU90Ei/9sOETw2Y2t20hIqjgr1XE5+eBx
 0n5Q5Or+HmcDjnONQMCTrlydrt3zUGGIOmzgazqkl7V6u/kL4P/Atz+YlFBoEtcRdHn7
 l0CRESZQK/sw8DXYgbgv7qqy0FgyL4CyO7YBtpek6CmpAoUF0Sw1yn0R37lJVhM/zCDY
 5C1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712683238; x=1713288038;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7upzKhctXTHB+JezNvrEEB+2BZRWcLbA9Hxk6neYrCU=;
 b=IU6yM4eLZpsDEMPXRl9He1e5LjheH6+MH+Vg9uy31JR0Dg9R3LWi5Tczk+rkR/Ajvy
 nAMKxeyjctfdnXHUWLDgIQoRTTfXbJd2HZMjZ7mYqBZgTUcZ+q1PSAc5DkYG6uSTUWgr
 efZXkcR1F1oMhF6KTi8uj7bKfs+MRr7PMk7yarHHnCWL82OePJU6kmnnsRbo9GO+inP9
 0nLcf+R+R+pJoWuUxINBudQUD65NfnFLlYd96mWeTerHXWcS8Bh6MsI89jrVaPTBHw//
 X5zNlKGPgwofrN058Z2zM0oOgQx7macJ+8TqTnsUgBzIDw41okUJHZBPdYwTx0K0Qhkf
 b0KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUwhI8hFSUfTbN21fpnu9Yk2ePgWZS6J9ZFJHfXFpM+mSjUDiVdxvCUPa4DbtoBPUio0fXTYKhcpsl7a0//MbwqE2Kx3E=
X-Gm-Message-State: AOJu0YxYVpfBmNMvXuDtoHFxIjHrQeITkAs6dG4plDwnbGjEcdscvxvf
 S0rzzayH8My6Y8E+YRtEencQQC7Q+izVpw4Iw6CITuPA5QYPEDQwmP4VFVjhaEc=
X-Google-Smtp-Source: AGHT+IEoc0jly4dgSxE5syp4xtuG+LSngxikU0Y+j+d73nGZ0mEsXLPuWktELbfH+ec5Hze1g4bsww==
X-Received: by 2002:a05:600c:154b:b0:416:4641:5947 with SMTP id
 f11-20020a05600c154b00b0041646415947mr343827wmg.34.1712683237683; 
 Tue, 09 Apr 2024 10:20:37 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a05600c4d0200b0041668053ca9sm1996829wmp.0.2024.04.09.10.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 10:20:37 -0700 (PDT)
Message-ID: <0f4affa2-9ae3-4673-8542-ae42c1cb2218@linaro.org>
Date: Tue, 9 Apr 2024 19:20:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 17/19] target/i386: decode x87 instructions in a
 separate function
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-18-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240409164323.776660-18-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 9/4/24 18:43, Paolo Bonzini wrote:
> These are unlikely to be converted to the table-based decoding
> soon (perhaps there could be generic ESC decoding in decode-new.c.inc
> for the Mod/RM byte, but not operand decoding), so keep them separate
> from the remaining legacy-decoded instructions.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 1120 ++++++++++++++++++-----------------
>   1 file changed, 566 insertions(+), 554 deletions(-)

Reviewed with 'git-diff --color-moved=dimmed-zebra
--color-moved-ws=allow-indentation-change'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


