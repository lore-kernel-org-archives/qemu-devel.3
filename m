Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39300D2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3y8-00081y-8Y; Sun, 11 Jan 2026 17:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3y6-00081G-C5
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 17:31:30 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3y4-0002RL-0r
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 17:31:30 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34c3259da34so3488896a91.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 14:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768170686; x=1768775486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GBFaaJ7vjzL+7j+QVMompySRTEXLuyvVSbef+v4rvLM=;
 b=Ap2q+Yt0CqhQeuBxze1isU/L81NjvVgG7PHfr4MgiUjqnowSEA+wTyr8NGDnhwvtId
 QyIkFa/XfKMrxd4EAKJ1re71LinLxfHkSq847RsHIm/lHej7+C/c6TxlUe629uyo6n+p
 wdkpS36lPfB4/BZVBNYhBmTsCmX9bXHIhyruRMKcadi2wYN/FOjLE6xNN0BzXlS3XPc3
 /UTw34Vu3fmWQtxO4YWBaOsZyInZKH7yxPF3+XkIksvayrsopqIbIrgXGF6V2VQFOrNo
 TaNmjKfMWCq6N3xpjKncBKvTHt8FUqWm4NZtqXoEDlgc/et+702IN+c6kj22NPuIRzOO
 Tr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768170686; x=1768775486;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBFaaJ7vjzL+7j+QVMompySRTEXLuyvVSbef+v4rvLM=;
 b=BlDjs3D/O8d6P1n9oLCSponW6atofGvcpGT/nnLS7cX9psTrz0x48ec+wqNTlhPEOZ
 wO3EPKAtPZADmFc7V0DEOwOhhbl6Zo1Vbx1b+acAQwnLtL2TpWBHqWuLYspLORoNMYEb
 HoFG7x/AtB/Twk2WqfcOpiETux0PBlQUCpsJ/2KQWqejNCxSbSFK9JiDakLjRFmraETi
 8pI9tWsTdyy54Lk5Gm3q+TfVoLLvYkI9DLRTagafB3uzQ/ne7/X9dpIv1vxgx9mmHv1v
 KULfKIHy7LrJQ9mqon41PsS32kNe+BumgjstZZBdtB3tlSUYGWONsRIDlvlSwBPI9ekq
 OD0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZB69ECWfroZsMN7Wn0tbQzXcDAa+4kVckrNCOc8UkSS6nwHfFG4bAlPfOXxogTWDknvKuGkwCHcGp@nongnu.org
X-Gm-Message-State: AOJu0Yx8i1MYWTV+tsCUwvtox4i2uk9xnQLO4V7L/PZNHGrcwz47xTvP
 eWIUOIG7TwUxS4tzB+fvyiBrHSTU4OV/uW1QtvCg/9yX2Ca57fqPsA0lOOKbNnnZkr0=
X-Gm-Gg: AY/fxX52s5TFZiigfm2HV6cNAXA2Zup+BL4yTzk2cTXuq37KgSA5YgpPghAiECWqdpn
 7rkqUlwKYLBNIanVn4PJ6oFwvEa+ABInHm0IFrbm6UmDPWAxiaC1wcH0jQqmdjMSlZvffFqSn+o
 R3nUFee0GBzRp06REJHvBJ3aSylCMQeY/EqMa/UFUV7fhePd7ZNSOaCUnl+6ekzpIamlqyX6Mjp
 9Aes1ruuPX4OKZPRshb5pKB1i/WBuGpEWPDS/7VYJF5gttKePMP2daxS/U3HYHxr4ZOeI0nDalP
 mcbV/CAUPk6KlC+Z0mVnfC6Zgq//e4XWtwQTfYmLgtwotPeigMiRF142X/d/AvS2qGsGSmxZ8Ke
 ijxXnDtwPw9SGXbg2mFsCPrlUQVUTtxtpkp3wD9bqZ+tFGiJ7PZ14twr9EcxU8TNEW9ONX0mMq3
 Id0OSz/RTQW1sUo3SDnKc3BQoLrg==
X-Google-Smtp-Source: AGHT+IEEoAwSkhHdCfV2K9htdbG+NhznRya8MgqisflSKGo6FMswPcOnC7LJPl85TAklt6ul2HLM8Q==
X-Received: by 2002:a17:90a:d890:b0:32e:a10b:ce33 with SMTP id
 98e67ed59e1d1-34f68c9138emr14578846a91.21.1768170686244; 
 Sun, 11 Jan 2026 14:31:26 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28f678sm15782533a12.3.2026.01.11.14.31.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 14:31:25 -0800 (PST)
Message-ID: <66500211-1716-445d-96c9-2964da8ad657@linaro.org>
Date: Mon, 12 Jan 2026 09:31:16 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/24] util: add support for formatting a program name
 in messages
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-23-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108170338.2693853-23-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 1/9/26 04:03, Daniel P. Berrangé wrote:
> The error_report function can include the program name in any
> messages it prints. The qemu_log function has no equivalent
> behaviour.
> 
> This introduces support for a "program name" in the new
> messages API, which will be included by default for all
> binaries.
> 
> This change tweaks the output of the error_report function,
> adding a space between the program name and the location
> info. The qemu_log function will gain the program name. This
> can be easily seen with the 'log' trace backend, and how it
> is now more closely matching error_report output.
> 
> Before:
> 
>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
>    qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5584e13937f0 dir=fish
>    qcrypto_tls_creds_get_path TLS creds path creds=0x5584e13937f0 filename=ca-cert.pem path=<none>
>    qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> After:
> 
>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
>    qemu-system-x86_64: qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5584e13937f0 dir=fish
>    qemu-system-x86_64: qcrypto_tls_creds_get_path TLS creds path creds=0x5584e13937f0 filename=ca-cert.pem path=<none>
>    qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> When adding this the '-msg program-name=on|off' option is
> introduced, so that the program name (which is enabled by
> default) can be supressed if desired. This could be useful
> if '-msg guest-name=on' is being used as a more informative
> identifier.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   include/qemu/message.h         |  1 +
>   qemu-options.hx                |  9 +++++++--
>   system/vl.c                    | 11 ++++++++++-
>   tests/unit/test-error-report.c |  5 +++--
>   util/error-report.c            |  4 ----
>   util/message.c                 | 10 +++++++++-
>   6 files changed, 30 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

