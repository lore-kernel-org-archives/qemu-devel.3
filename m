Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAEED1D495
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxKk-00086E-7P; Thu, 08 Jan 2026 16:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxKi-00082e-J7
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:14:16 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxKh-0004x4-7V
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:14:16 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81dbc0a99d2so223463b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906854; x=1768511654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XOj+EEiorwxcN20k0OqWF9BvLkj1Fv2CHdPqsvQxH5A=;
 b=mDxKeJ33H/PCbmwNqBipkxvbEDC/dGYp9VumBub+wEqRCC4Q0CPW6UNelKMehqlthM
 i07eU3MMDkk7EqWnCHHvTLj1ks/LiVBYPbxCgaZ5sMvS+Yu4giRBlbWbhG/lDsZFhy/J
 7FUfqTq0QdPwzSJPFHW7tkxcTlK0LW7YvEKfY/9AIc2A5UmLutDZEQiZQjsk/7slTuXS
 veiMP4H0Ypg7O9PlkIUDp1Mhp7qh6QzpjD6zA6sslsyskuwi8Y/kc/1OOVKxKs7PO2d0
 F792xEKMz9aiDVT92Ukvh3v1QZ/VjzZsaH4CrFd2eedtbPFkV80nOkUy5ZM5DMhftbqM
 P9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906854; x=1768511654;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XOj+EEiorwxcN20k0OqWF9BvLkj1Fv2CHdPqsvQxH5A=;
 b=Hpj9Vb+0qRAk+Xr2vIpmpQA1KLKASRLw3kUNp321V1HzFfBlppDkLoEwawk8dtLNbr
 eMhd9gcpYXJtht3oLfLJ5fHs+EEUBflYz9zRkDANziy3K0lAe86Z65PB5xzcx+mnByuS
 CsUhvtZOFnjzLpnzA1TxVDLPhGX9Yay+E7Ckr4O/d+C30ToI2cPdRPDVcahj3FSkrJWA
 igq+T0Gk1tERywVKwVair1TRDLvORZnMcHcwys14zsUPfFDuVioNXezUE0HQtCdv02mF
 m/Kef1fufJJ8jKTQNwyldRC3qmfELLZ5jmRNsR+/Tkfum7kS/HTltIOmGcBAxj/ub7Ut
 nNXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs5YrCueWwZO72fVlCpWOAMeDFvJpTsmhv8bV8K8xLZkOXNTf2yrcTZuLb7cQRwQP6L0sUYado+2/v@nongnu.org
X-Gm-Message-State: AOJu0YyJO85cCC9Gl4OGBLPXNp4j5JB0cxrbp9Na8bIxb1n6KB6pVXAz
 SuJJowREA9tKJlGLbFR3Qnc8DJwtBFW78W1qF2MswUk2cMtUTQhWvopKXhvv8oSR8G8=
X-Gm-Gg: AY/fxX41metm8x7u2n334R/DlrNlS57XuuxVaGowGMALpJVwwSO34/eaku6zhNwVfLI
 CMLeNFxBEQ9aMe7Fbm3C1hYiV5ohNsCTCdyJ69ufkLEr9Ez/osX9+v3cTY9acRuIPHjU0peNjxR
 v1Pa6NPdagYFvnmRUH79OT6eZumihBHJOYBvKC6jFstfadyys4y/pYss88d1HjmHPVuRzWEcek0
 vGBZxHKzej25iKnsY+uzmK8gcgEGELEvkx3+iciHrH3TZRftUCjUbcmvbJru24wtE+oSKqV2r1i
 rRhwaEpDCF7bf4fE6h7pJpIFSset/G/4BdAwHwldHYvxBfmBh/wsZ1j38Sx8cWBOgkhnrr78KI0
 JbMmI4B1xiSp6ZJI7D4kdx2JpmCT079ZicWyPdVgkAsWTk5NO2INEXGgrJLDye8lkn1ihyJgkat
 6rcfP/8WZAsSNSN8Eq/P3Jwtd/gMUoAEq82ZNW9lS/q6xDk0cp7/cHqT2f
X-Google-Smtp-Source: AGHT+IEZWqHtVXneEXkMTt70v3ugd990MHhv4yn7PE3GnbiSqrdyzsv84WiHDIRdiu/Ei+YwieQtfA==
X-Received: by 2002:a05:6a00:1a1b:b0:81c:4a92:2594 with SMTP id
 d2e1a72fcca58-81c4a92285fmr4052512b3a.40.1767906853733; 
 Thu, 08 Jan 2026 13:14:13 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c59e0531sm8449315b3a.49.2026.01.08.13.14.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:14:13 -0800 (PST)
Message-ID: <dd21c873-00e9-419c-9938-14c0916f8e10@linaro.org>
Date: Thu, 8 Jan 2026 13:14:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 44/50] target/s390x: Drop CONFIG_ATOMIC64 tests
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-45-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-45-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/mem_helper.c | 7 -------
>   1 file changed, 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

