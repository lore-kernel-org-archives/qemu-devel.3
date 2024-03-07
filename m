Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5C5C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAzv-0002Ww-6a; Thu, 07 Mar 2024 05:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAzu-0002Wg-2u
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:29:10 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAzs-0000Yh-Is
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:29:09 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-565ef8af2f5so782434a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709807347; x=1710412147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bBjixhGwpPRXbBWvPVW1/TOt55RHglYe/2QWw77fZxM=;
 b=vVEQqaqipOSarpqf/Qw82UxUofmDX6qrIwoQtw+Ep3eYyDZ4udL3Qfc/yfLReSOFZ8
 5y0vCl9A8eq5B4hct368x9rgYXrmmQIDMhVpPky4dvnJA65WvWwxm2OcWw6JH5s3wL9l
 z3PZQawCNyUvq1JVpaq2BGErrrOlIY+sQKB/xcJxPl1AXoZcVX2DINywGB9829p2hgZL
 +pIuN2UbwDrKvtdjjJ2iIPEHfLC9T5MuDeekpKGmsGEFcB+znHkGGgg9zhf1tTfa6XJP
 O8A+NU+O5L0Rt+vy3rawLt0257x5nylMWPe0GEBlIXnMUp2zqF9N2WgZaB4zPRXGkmbe
 H23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709807347; x=1710412147;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bBjixhGwpPRXbBWvPVW1/TOt55RHglYe/2QWw77fZxM=;
 b=WfMGgFFvP7Wx/FhmBok/fZ9Mxb/eGxBy4e6MO69Zw8qBNOgKiLHcDAiOjnHnrRS1dM
 45lKnBz9tX+W4/V/MxKh4CFmUE6q7gkzR5RrX+oe5JL5ax4KEpc3iNbf1JXLyWPVKJBE
 4/SAkkNxO/iN1kjOoM21537cP6vHnlu8GjKNfX+9Bh9lBv3vUcp21grQghuRUPNxBPDQ
 YJhucAjeXOlov45hhgLjow5sgudc58kVnDmrpv0Mqdm3xv6cJB9MhECHQg3BmS6W8at9
 VndLDrP7OI4Y6FzWNJn0WXD+npp7/dgQzOvnbSrkGnMGE7txhP5kOlP2awDWoYahp0TB
 KV/A==
X-Gm-Message-State: AOJu0YxcWuR1HlSiBxV8xUg7yo0PG20kW0EYcnhUzDG9B5zglSaY7k4S
 ZYvXqnjeeH/2SlIm8D9e77hcINAMRNPurmqI4qSB4EJNp5WECYtXTHnkP5J9wjI=
X-Google-Smtp-Source: AGHT+IEXbSqZ8v0nYr59qNheD4g6p3I1VbEc6KKlt0J7gYpecpmYENL/TANVCiwIXfAlOqvvoGEbCA==
X-Received: by 2002:a17:906:264c:b0:a44:fdd8:6be with SMTP id
 i12-20020a170906264c00b00a44fdd806bemr11137307ejc.35.1709807347021; 
 Thu, 07 Mar 2024 02:29:07 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 qw28-20020a1709066a1c00b00a381ca0e589sm8063136ejc.22.2024.03.07.02.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:29:06 -0800 (PST)
Message-ID: <cbacdc1b-8e33-41b2-b46c-9872e50d745f@linaro.org>
Date: Thu, 7 Mar 2024 11:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/19] contrib/elf2dmp: Use rol64() to decode
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
 <20240307-elf2dmp-v4-14-4f324ad4d99d@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307-elf2dmp-v4-14-4f324ad4d99d@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 7/3/24 11:20, Akihiko Odaki wrote:
> rol64() is roubust against too large shift values and fixes UBSan
> warnings.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   contrib/elf2dmp/main.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


