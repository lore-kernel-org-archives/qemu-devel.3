Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000BF606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NBayxKcU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQ8T-0002IA-Lk; Thu, 29 Oct 2026 09:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQ8N-0002El-Mp
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:25:36 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQ8M-0008SQ-95
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:25:35 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-83bbcfba0ffso1587179a34.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793280332; x=1793885132; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+EzB3Hc/0A+ZBlzofpaUhIZtlYxC/IYPuF+iEPnRPfE=;
 b=NBayxKcUSY+YSs6fJlVgH/2H+aqJwtkWdGvwSATUKzctU+Xm5TXQfvtcTgAG8+93D1
 4hSvJOquqoBr1tQzVGBHxQHZPvP9DVwtX4OpO79CeDDR2mMzp11WPwux/FrflzU2qKsw
 ejn46iDKvo+9c0cnNLhfCvtpucn7tBKWsuOnbW7ZXtBlZldlJz37y5mFxQcdmXBQE/tP
 +71x4c5yS2wngW9HEtMY2VFLFImnUTKT7K5hIAkqmYnGAyF8s270LNL15bMbKDktkX0Q
 G5QwIwT0u0dwmdmXzBzokTgXk9+/oU+SNk4CNf8R5GJDKgmsNkxS4hLv9NHb7XplKp7R
 IcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793280332; x=1793885132;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+EzB3Hc/0A+ZBlzofpaUhIZtlYxC/IYPuF+iEPnRPfE=;
 b=tYGSVbFcAAhWDIKPQ3jGTFf9vWqdIfeK0XHItCbKoP5S3L8JswzEhXxxPBl65U0QPR
 RnRaRBC5KCdeCuj828DE0tsg+DlJWgwzG/KAT6k2PNkDygximbaRLWhctu2cwTbtPt6f
 4yQHHmvPvyE//OgUfN1+5sb0EF6fpwVNunScNAhwHQ03B2kJYFMlXLaXiy3T5KCoAoD1
 IsFIeqwhu1mNv51UjSBdInZmjez9UF/rSZF2qMye5ljFuiX1UAcZFa8uG12whLT893oc
 r68VENaYC5yxEVa4tzK4sks3lOOdlFVRTL0PF6r2cOkUlK8WREYY2d6TrDo/twZKYFUV
 gNNA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCqXlpqBvzvGDCtNkUiyGSbJ5JsaEM/Z4ukSkNyNl+1Ngi27j+pVcjNxpUYPOYdfFrt6CfXGSu+Hmp@nongnu.org
X-Gm-Message-State: AFq9FYK9cK5Hzs8MuuWFSBQk4eIWA5E4JpLjk8sguJM2yuwgWWASjoiR
 hU7uliUhAlFTEUHgENXZbhf3A5lwvkwtSbUZ4NYkEVXv7VzQ/nOwqPLbOctFVgRPesKM4Tk9wq5
 Wqjm4
X-Gm-Gg: AYBFou0UCDQ0nLqEwaIJOlPaz/QwaA5gdbQcHRwKdUfUSgNLXyJHqpwpXPo/FBewizp
 mSfBvkG9/ArICahnW0LO9rrumR6tz2LmNcGqrbEy3mBsgxuymFfg6WXYKqfRj9l9VBYgneBWxCw
 N9ZV+szPqwysA74rUwYgndtLPnW+XPsGpVng4kCcvfmgiH+Nj82VwVIjID2nEvyR3E4C/DDef77
 GUtL4riynPjYgOPaZPlovRgSz1McI+niY/kL5j145Y2VNVrEz3OcDFR2JSR3Vhkrnt3f9iRYhjo
 9eHCegd6Fl5tQ/UducFbg2o66lJk1sa/s+YyLW03SzMajzDF0LnxwmysODnn1X/lBzrIImiG9eT
 T/i3amfixkDqS1eiUOhT/FKIylSUoFcKL7OLvGoC7U9IwbO7P3G/UTKEy9wTihKt5T4PhrDojYJ
 yppWEG7nI23srnLmX9hy9A9AIHW7EDwqKdnxdRfIIfIqnjL9AM1LaQIqo8YUYipb5Ym9GaiIbVF
 aPUQNqlNc25OYwdddmcKyecS/nS57ugo2BaPKrUV18Vm9fE1w8w9BbR4x2n3BdPAKCi0NCFrfMY
 pIGChkEx/Go79RrNouxV2dYlJcKP3ZMm1b5zeyRig6lt
X-Received: by 2002:a05:6830:4413:b0:822:e9bf:6445 with SMTP id
 46e09a7af769-85abcd3f332mr4383007a34.9.1793280332199; 
 Thu, 29 Oct 2026 06:25:32 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1fd30da7sm5345912a34.15.2026.10.29.06.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 06:25:31 -0700 (PDT)
Message-ID: <21484da7-ef62-4ae3-b215-f3957d8cccf1@linaro.org>
Date: Thu, 29 Oct 2026 08:25:29 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/33] target/alpha: Register
 CPUClass::exception_name() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
 <20261022215115.19680-6-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261022215115.19680-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 16:50, Philippe Mathieu-Daudé wrote:
> +const char *alpha_exception_name(int excp)
> +{
> +    const char *name;
> +
> +    switch (excp) {
> +    case EXCP_RESET:
> +        name = "reset";
> +        break;

   return "reset";

etc, or pop them into an array.  The values come from an enumeration, so 
these are dense.


r~

