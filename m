Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7E6C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 13:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjeLk-0008K7-LR; Sun, 16 Feb 2025 08:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjeLh-0008Jr-IE
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 08:06:17 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjeLf-00011Q-Pr
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 08:06:17 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e058ca6806so359057a12.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 05:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739711173; x=1740315973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hMZDhZmpxn7+zfYGgjSte8K0gBiKHgb+KvKwwfFtCjw=;
 b=jY0P0ciMCZDjBkWeJG4aXcSPcu1vYLjJr5MaBMMLforabDWGTAB9hwSSkXNbC7Phj8
 rkqBJp2Sc02VRTxCIdP2jg6bKChiuh37ljbqr0XJw6NIrWIWLvPRAZpCgPBPyXNRxwKe
 M2G8JDla8X2mcnWo1945GEp8xk6orPf2v3CvDXUYSru8mIN0Xyg12+LKQfvTbCKisOZ/
 sDrb4PlaNf8yG9h/aJExKCcDJK6aBZFYjmNaYbjz+FcrPwcRtlRoJ4c7JkyIDV0YnNwd
 jVKLznY7HmSlzxjokwn60pLXSsYuZWL8kYitUlxsP3h/6onT0Cmt+bsxHrB2VsLfRxf0
 VTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739711173; x=1740315973;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hMZDhZmpxn7+zfYGgjSte8K0gBiKHgb+KvKwwfFtCjw=;
 b=LBasNj9kXff45aSk39ICZPXtsFjxuaSCla5LECQtZ+/2ci6+LsPDL331uZfQEX9M7d
 OQVlUGbgN0jW6LnYq0iKKUVXIOA8DjcfoAQ8s3G8yejaIUtpRN+YDfCX/sYMTblm/URA
 +sfwIQOP1aGlmUnFFyxhNFpYA5VtRpPPkAAY0A7qQTaittRpBjbk6lxiCjmjDaBWDJ1s
 OMTNbikunJwiMJBNGLamuVabwczYKFMqD9dMAnYsZ9wsIksCkTtjRmtqcv0ETGBki1WS
 LScC0gedEO7IBJhnFT60LEQ4nbhz9N9oI5w0mcz3GFbESUIhz47t/ytfVl1phAfX08mM
 ot3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjk4DcKd2yuPpxo+DU0PSBSr5vyfO55rHizTuhvrP/dbqEYPguuGaIHuR/4XAm8Uo/Re1qO+y8VcjU@nongnu.org
X-Gm-Message-State: AOJu0YwSqDANpKiLFtcn0KZjvFt5/nALHFHILi0CdUEtSNdtTzb+KT3+
 I2qGlQE8BcdKnBjQMY8IA7fNCrHGgxtb6XEkGmi5Iz00YhrBtb7xrSq/Icl0MZk=
X-Gm-Gg: ASbGnctfVMfFOberCB6IswFvazQEo6Kizwny6tgqtFaUee7VQq52rmrSV1WZUHC+aOH
 ms3K5WfJc11YY0rS8h7zrXV7wOeFWR1dBGUwhtzdVRkcP1Q/LpUzoxpEdi6KcwvcRbxK0S2f6jh
 et13oiSyuZrrbpxX6CIv038Jd6F76cX5g60CdT/2RWqFic92p9+OVupK5NnovdJqDWSvK/27490
 Aohb0T53YmI8Gp299x1fEjiEFLpRcYmdlsMNZvPHZcMyr9Uo5bMnTUqpkET0V7sD24ZoNSKCqt3
 X/4HbRMj1D9z90mWuI45APaQY0I4G9HHoUJswa946BO+U69n47pL
X-Google-Smtp-Source: AGHT+IFNNkHni3IErKVpvBSLY0EWfE73HVWsrwFzTFSscimrOBouDfgbUp4Vjn7qwXaSbV596VUT6w==
X-Received: by 2002:a05:6402:2108:b0:5de:dd44:929e with SMTP id
 4fb4d7f45d1cf-5e0361c0409mr4253344a12.21.1739711173295; 
 Sun, 16 Feb 2025 05:06:13 -0800 (PST)
Received: from [10.223.46.213] (108.170.88.92.rev.sfr.net. [92.88.170.108])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dedd35b0aasm4327962a12.52.2025.02.16.05.06.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 05:06:12 -0800 (PST)
Message-ID: <154d2b06-a735-4ab3-860d-442564d4d0e6@linaro.org>
Date: Sun, 16 Feb 2025 14:06:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] tcg/aarch64: Use 'z' constraint
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
 <20250212034617.1079324-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212034617.1079324-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 12/2/25 04:46, Richard Henderson wrote:
> Note that 'Z' is still used for addsub2.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-con-set.h | 12 ++++-----
>   tcg/aarch64/tcg-target.c.inc     | 46 ++++++++++++++------------------
>   2 files changed, 26 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


