Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FE0C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 07:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcKU1-0007NB-RY; Tue, 20 Feb 2024 02:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcKU0-0007Mz-4K
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:24:04 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcKTy-0001g6-KQ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:24:03 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4126f486429so1865675e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 23:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708413840; x=1709018640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YM1NlQyK5zbeCqLEXloo6PPnOIWmKmIp5G3ZeTymKIA=;
 b=HpI+uUNsIgHS74FayND8VElhB2XrtwXTjZc4iVTwxrzyCPFcKaXp4W30kwZpWpnEoA
 ujN9N2OSKQ7IL3dMSkHgCtcDM3W5EZw5npDv7gWP8Kzm7tvF883u0dyonZrmZIAusNIR
 qHLMGkNrxhoFzkdbkdG5fSFwUE11oX28nJSXq1dS9EmMOVVVIIpGXitJrxxiW7Ya+zMg
 1Y3fbxtDJxndwJP4oDK0WsZNTJEfxevsa9Q3tfsyE5zghWG3qCJJQ+ihdvcbaxqtjwWD
 vIphGAC0sKTwJtV8BeavSzbZqOF+KJnCnmsNf34V/VMGjT3+Vql6x3gYodWZTsO4LxFh
 aD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708413840; x=1709018640;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YM1NlQyK5zbeCqLEXloo6PPnOIWmKmIp5G3ZeTymKIA=;
 b=dzGMsAOrCch9TQ0gvjebyQ3pBMpmdQvB3DJwkh7zla+bVkp1MNhij+YpX+RexdO54i
 p09Z8u+gBC7z1RCjdc54PcuP7eQqEF6pxJHqEyIWTNoUzPIU/KsB+2IQtWhLUmThK9bO
 EUNi1Y2mX6kH8WOMYh0qc4yzPRgKKSwS09iAJWCLLczGRCEwjC3ZUfOifEUJuz7goYBA
 6mVHvBEZQ/95r/7Hm4G+xt1qtkv5HQYYIxnA6QLGGi2JwECaxl7Fuzr2aUs+0yctkQ7Z
 00VYnOXlJwf2MgKQBRLq24DVlGP0T38YHzpi/BQCSLqAk9UBYhzE72/JwbKBo7gLaGih
 YGrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWePYN6LmEW5pJpgb44GMj82ktBJoQXwwvcZl3/sFNnhazTMTI8QfZZNHvBB6NpDrY4o6hJ5E7F/HgywG9v2cgmj9GrY8o=
X-Gm-Message-State: AOJu0YwvmYG11nTfp+kVXmRgzw9PqK/ySU6IxqgYcbTeICkFK29Y0m4O
 Lwf/Hw1zi3DCN29J19yNFxu8fGXLtNH02GrzYQL2OQETtXnj/rT49A46Hp6Oajw=
X-Google-Smtp-Source: AGHT+IF5DoKgonF+tnO0MzgFZo3TQdtwhQWtFfmDuIWPWtYEWqXji1ffKHm2bQuoYJB8vMoFQuzmUA==
X-Received: by 2002:a05:600c:5486:b0:411:eb73:243b with SMTP id
 iv6-20020a05600c548600b00411eb73243bmr11412824wmb.5.1708413840667; 
 Mon, 19 Feb 2024 23:24:00 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 m6-20020a5d56c6000000b0033d56aa4f45sm4117974wrw.112.2024.02.19.23.23.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 23:24:00 -0800 (PST)
Message-ID: <197fa809-71f6-4cbf-b062-0edef3df36f7@linaro.org>
Date: Tue, 20 Feb 2024 08:23:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/i386/pc: Inline i8042_setup_a20_line() and remove
 it
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
References: <20240218131701.91132-1-shentey@gmail.com>
 <20240218131701.91132-5-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240218131701.91132-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 18/2/24 14:17, Bernhard Beschow wrote:
> This function is used once in the pc machines. Remove it since it contains one
> line only.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/input/i8042.h | 1 -
>   hw/i386/pc.c             | 2 +-
>   hw/input/pckbd.c         | 5 -----
>   3 files changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


