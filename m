Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0191C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAVti-0001Qi-M2; Fri, 24 May 2024 10:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVtg-0001Pg-GP
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:27:52 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVte-0002Kn-Vg
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:27:52 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2bde636ddc2so1487632a91.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716560868; x=1717165668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5O8j3f1ZBCQ/gYB7BymZfVTrP1RMYYvnEz3Vuyro/Zs=;
 b=aUeW86DZTs1cOwDntgmgvQy+Z00/Xe9KpKFLGf77GuQcGxIQaEuQJHsLiO6mHH5IK2
 aDRz05hoYGU4o9K2aI1zV6DizSf4EHV0sw3p9FrcpQuJLVe6CrIYTxKKXrytFsQ12UZL
 Iqv4z2GSE/ldxeICOQk+Yf9UXAbROZ8duZuPPROZYaGLEl1iUbcD4ob06Kc6aERAYCOR
 wx+IjFRejOgp8K3cHLKSl4G9RF/9+qfNJPvwconS0xxjHDpcDWKy6zVXfq0iOqf2b+rD
 w+aQiDPZopJdB0ye61PI1s/UzeY+EY1FyTkdKglmqxb2ksVA6RSDh0pMBKeEolKNXP38
 urMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716560868; x=1717165668;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5O8j3f1ZBCQ/gYB7BymZfVTrP1RMYYvnEz3Vuyro/Zs=;
 b=VypgYyx1THhAbJ6bA3p9vobdS9QA2Hh1Xz2JTzHJ11UWbHeFxrs4NOmTpAMnmC82Vk
 jzvX7flidALb9yGsFYoHprtkzQjzQoCZuloeNcy+MQft5ecW41bkeVCiuDsV3TqM8Ci0
 qLQdesqtNzShKigccCN8l/PTRBAbcggopx7ZIr2uA7jSHofUD3bgvqDa1fGUztm2XC+p
 ZGoYAIha9W2PVYI0SPi0W8+LCq468o9U3pRQrSbQtyjDOgSH4Kk/BJABVgf9k3Dej+hG
 OiC6H9bGBvQlwedRFBRMV3jw/VPthQWCJGZZpeyxbn3OyXbgCdp1g9TGlTzA9y8/qYXB
 oIBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfhdh2mIPCtO/JqPS6xGW9D5UMveOmt6wvqX6soPOd8DFFexlIoJm4oOS1fp48BTsP7XdsGnGJIEZiYw1P+3l8Ln39ua8=
X-Gm-Message-State: AOJu0Yw4WHNIgk3WokPiyaoGUIlWEBzMLyEGJxJjnIxH4VGDZIKRPbCE
 zc86W1cZkBUavrWEAh82MqN25K4jfoNxdsbArrSLuBDYaZ1PZag4l3Jog3GjllQ=
X-Google-Smtp-Source: AGHT+IF5mIQ/jUb4dby5KsLRTbxrmJaQL/Y8MAPvAl0rcdoPxBRLQHSw6uOdrtf7z4hf5p2HBNUQ0w==
X-Received: by 2002:a17:90b:4393:b0:2bf:7ccb:b8c0 with SMTP id
 98e67ed59e1d1-2bf7ccbbec5mr675329a91.26.1716560868561; 
 Fri, 24 May 2024 07:27:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f614036sm1436647a91.33.2024.05.24.07.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:27:48 -0700 (PDT)
Message-ID: <2a5c1d34-a45d-4b0c-92a1-98d285f7bf67@linaro.org>
Date: Fri, 24 May 2024 07:27:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] target/i386: avoid calling gen_eob_syscall before
 tb_stop
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-5-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> syscall and sysret only have one exit, so they do not need to
> generate the end-of-translation code inline.  It can be
> deferred to tb_stop.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

