Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB44C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 19:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxAfl-00039s-NF; Wed, 17 Apr 2024 15:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAfg-00036E-Ng
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:10:17 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAfe-0003a8-HN
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:10:16 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e2c725e234so9550205ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 12:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713381012; x=1713985812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BggGVu6/f1Re++yYFbTbGyQ11OQ/IC8mulLj0TbbAtQ=;
 b=sUliQe3//l+YajrQMUWqBGUZLwDHEFOjDPBBPl0S/j6x8VydvkuNcQVQOyS8XyVJBI
 n+LzccbC2Yvz3mjopKuPNunLGiTMSuMzT+QiixlOOUCuVRn3g8261/XgX4CWnoD2tdHc
 05wRdIfVrFF8cY//R56gHkYUz32MmpLJMqFVhQO6vVk2LhWAjTaZB8QEKuQLYoD4b9et
 E9O85iWsswPipIJG9oju9LQM6272BtPf3rJr6w0cE/wHNleX/TuSxDLL3ucAhxc1l+Mf
 cVZbz2TUqy70lFywsGxcfifwEl02jrlofIARe+mU1jYcTmVLKJxvbJ0at25i1GlYPsxl
 nDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713381012; x=1713985812;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BggGVu6/f1Re++yYFbTbGyQ11OQ/IC8mulLj0TbbAtQ=;
 b=j3kWDlgjDThRGUjQZ5PgPUf/+OqazbEiPkfX9GjHuA/fO7+i7OxEBw831YlEdxhgtg
 s/G8Osi/ook7R0IeV3D2wUckZVdT5UNYSZLKxle4Zs95L6bRH0ucOvYHHOE2hDO/8fZO
 JoAFcZEyZqJQwLjQAgtVAnvpDSjWmWDZia3ty6fYI3P8R7TvmV0eJEL7t/yaebdHc2VV
 CWKWNfvm10Qe9nRYmny7THn1WlxlxaYxwvQt3oK1agcmnlo14o1imoV2d4Rf9ykNeeq2
 JoGLNO0DoLe4wK9Wl9E8yzI9xB2ln1zHiMLsOSkYf9jJDw5hqJNUwTXTxTf7ez7L+P9+
 VbSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWWW8e+iUSWF/nHeyRS+RyVzakPWV55mG+O+O/vHGnPynmumCoN33cyisNHqmhpYFyXheJgZdg1dfDdNnwQoVB//AlmCI=
X-Gm-Message-State: AOJu0Yzt1I7P5SFtfhCT1/966+oJovA7PXx1/245D7ywoqMaWa+yWZ9n
 tsg/1hC6fZjKWNCHP5y4zBLDUsW4/pB87JKKfkNk1AF2yiP7HiokOl2Jhib42fQ=
X-Google-Smtp-Source: AGHT+IE6RsmUEfbCu1MB4ErXmsS2Okbia9Z1u9A0hpYAYk5d37SW1X4SZr0S/FCV+d/9thixujBbRg==
X-Received: by 2002:a17:903:120e:b0:1e5:5760:a6c1 with SMTP id
 l14-20020a170903120e00b001e55760a6c1mr14768plh.21.1713381012341; 
 Wed, 17 Apr 2024 12:10:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 be10-20020a170902aa0a00b001e5df38994dsm8890589plb.248.2024.04.17.12.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 12:10:11 -0700 (PDT)
Message-ID: <613adbd5-9454-4f0a-93b2-5a3d7d85287a@linaro.org>
Date: Wed, 17 Apr 2024 12:10:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/21] gdbstub: Include missing 'hw/core/cpu.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>
References: <20240417182806.69446-1-philmd@linaro.org>
 <20240417182806.69446-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240417182806.69446-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 4/17/24 11:27, Philippe Mathieu-Daudé wrote:
> Functions such gdb_get_cpu_pid() dereference CPUState so
> require the structure declaration from "hw/core/cpu.h":
> 
>    static uint32_t gdb_get_cpu_pid(CPUState *cpu)
>    {
>      ...
>      return cpu->cluster_index + 1;
>    }
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Warner Losh<imp@bsdimp.com>
> Message-Id:<20231211212003.21686-15-philmd@linaro.org>
> ---
>   gdbstub/gdbstub.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

