Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF44CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 21:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv2Qn-0000CO-RV; Thu, 11 Apr 2024 17:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv2Ql-0000Bv-Hi
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:58:03 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv2Qj-0007uQ-W1
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:58:03 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6ea0db2727bso198526a34.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712872680; x=1713477480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CzPmnD5689q+ByEqqNwyrNLJcNHT3bSNDP3tBt89904=;
 b=MjzFAMYmYJNshutNfferqrztjdesPvNqlb1nkdjtwGsbkjg4NuNUEBIS/8HTF/jjk5
 6M5l8GqtwvqHx0L0cf7lVn+hVP1d4rv4WStlmRtkoYye4MJq4SWV6uTAtQWnRlQAKuu8
 Ko7sSYAGQ0LWo08z5c53L2pwnCCGoh54kQRLSz9MMay6nUxMio9pSmiYMjoWnhSX+5Dy
 V/hWQSdIW/QsyajL02+TBtgBqcToQRItISh680yH7cDQ7Bz8+/11/fGDQwGk+KccHYL7
 VZG2gLe5pwYYSvCSVC571IgyIlhcSk7c7IEN/VHsFCvl0g62pb0CyH6WPW0bN22cCcPT
 ucvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712872680; x=1713477480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CzPmnD5689q+ByEqqNwyrNLJcNHT3bSNDP3tBt89904=;
 b=nynU2S8EKnwXFc9o2YAttIMATduiVJy6aMabKVR4Uo8L6Fy7dT/oAMgAZY/M9yXg0j
 +f5criLpQKWqoK+MdqSBURnyhC1D5FV+EB9oOiI5Y8/ivewGHjo/v1U0hhTd9SLSvA9p
 DVeMACSNIDSdQDvioKxXE+ZYv+LkFjCtRiKqCupCrrv5cDQX4PnORR3vEVJmHSHUCjxl
 C/wDKncTI2NVamUxvbYq0Xa6p/s8GfloC4Ula7Fr8evHfdNxDmOkYIJbrflzhfMHgBIu
 g8OEENQTNAhc8pTuWh0Cx/LUZMv6SESHHtR4I+VJ4eD9S350EKCEmSmjPu7kvz0dPO9d
 rd9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoDhZJLlgIaWE1i4N+1DTfJWouPUWup16czSm5H/IBH1n20gV16pncEpVIEqE1xd6SEm8eSixoUk/G3SVxNdjmnEFmFMU=
X-Gm-Message-State: AOJu0Yyn8Ev4JeW41pph0dkLRuGt7CB7jYdGrTK/rGoWhxZkrDz7P/VJ
 yrcGecgsgdng1xoDuD9HiPQd+GFcTzJmolXBM+i47DID1QF+perC2W8ad6R6ByUxcLd6VJomGrw
 I
X-Google-Smtp-Source: AGHT+IEu8Pt+BEnWZItopO6Az+itcLzbAWs2PubYoVbNYCqgIf9si9u2dhXg7/NYUHd36E0ObTG1cA==
X-Received: by 2002:a05:6830:1d78:b0:6ea:f61:ec98 with SMTP id
 l24-20020a0568301d7800b006ea0f61ec98mr998410oti.7.1712872680530; 
 Thu, 11 Apr 2024 14:58:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a639352000000b005f3c84e12c9sm1550481pgm.48.2024.04.11.14.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 14:58:00 -0700 (PDT)
Message-ID: <57bc4ad7-ade2-4ef1-80f5-8b5c6f6c85bf@linaro.org>
Date: Thu, 11 Apr 2024 14:57:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] disas/m68k: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240411213933.36548-1-philmd@linaro.org>
 <20240411213933.36548-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411213933.36548-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

On 4/11/24 14:39, Philippe Mathieu-Daudé wrote:
> @@ -974,7 +974,7 @@ print_base (int regno, bfd_vma disp, disassemble_info *info)
>         else
>   	(*info->fprintf_func) (info->stream, "%s@(", reg_names[regno]);
>   
> -      sprintf_vma (buf, disp);
> +      snprintf(buf, sizeof(buf), "%0" PRIx64, disp);
>         (*info->fprintf_func) (info->stream, "%s", buf);
>       }
>   }
> @@ -1069,7 +1069,7 @@ print_indexed (int basereg,
>         (*info->fprintf_func) (info->stream, ",%s", buf);
>         buf[0] = '\0';
>       }
> -  sprintf_vma (vmabuf, outer_disp);
> +  snprintf(vmabuf, sizeof(vmabuf), "%0" PRIx64, outer_disp);
>     (*info->fprintf_func) (info->stream, ")@(%s", vmabuf);
>     if (buf[0] != '\0')
>       (*info->fprintf_func) (info->stream, ",%s", buf);

In both cases, there's no need for the sprintf at all.
Fold everything into the adjacent fprintf.


r~

