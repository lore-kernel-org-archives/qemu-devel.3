Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68087CF34CB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTY7-00020L-N8; Thu, 03 Oct 2024 17:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swTY5-0001zv-GE
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:39:50 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swTY3-0000BJ-Dw
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:39:48 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e078d28fe9so1092127a91.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727991586; x=1728596386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tT+uXnO9MWTfEyKw4IUf9eCuywwiLnfRhAjSsx7XhKk=;
 b=EVr09dP4ExtTn47HUF7yOUAq2nJ5bW7Wwrz5ba/HXkKwYiZcJV49QQ/TPN6S04f6Ga
 5ts6qRmNHsC8Un3xrEQOcJ9nmJtKc/GZrCLZM8tZXfpHez9X2sB/By6qklY2t2Yu9t+T
 qpoAzymcGkJTTZDbdECR6cjQgX4h+B1sFnkm3AW9eV8xPCUcaGWlw3ndoYVsNo0tHiMP
 u5Jdqixlq0CMPMuxrFPBJF7P/CDIF5StvnE0qkY9lVAf1wkxp3BSt4k92ATpQSK7KGPs
 rbfIR2/WZCK16N0OlXJdycckkj8UebHFxdnRekgve7TK7S1VDUlppg3lIEr3vCubL+in
 yRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727991586; x=1728596386;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tT+uXnO9MWTfEyKw4IUf9eCuywwiLnfRhAjSsx7XhKk=;
 b=YwcCxpD6DjHAXTs3/ZWHtoK5sBno/Iqzo4sA1187QisZ0zQVmlctxwmVzItCvbxt5W
 mND04OodhnSmdDsRuZl7lXSCFGAXdrsgrcKpE4vxM0EghfUyW2hL6veT+f/6MJk5i4JY
 BvmnA8o5QGNIZcTtgxHrw/zS6RRFRZZzwgSAhI5UkAdRDcgw82vullVkDXzQgR7OKQDh
 gJqyXWLUTJlQ1AujjSeOqf1arxrQKwRe652F+aFwrjMl8YWErEUdzG/vjnfGqOBQsQ8d
 J1ZljTeKv2D3sxw/AE0i6fvilfs1ejZJ0DHbOQ05ujqMDS8kXi1frEJR29CKd46pR+TC
 GvCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnNvmdnaYyp2zUSCLtLh7TW9Aar5bxyIKN6mVgwn1fB3G2JDE5g+RoaXtpUdTJxLGAlQT1VnAqcehP@nongnu.org
X-Gm-Message-State: AOJu0YxM0vrsNW+cg5cQFeWgnsWp/Md/xJsNiaraCCmqBkdBm+OPTE9x
 ft2e5h15P86Mr0rMdKfJXwnV4tRSomvaeIoY95OFejptQvI7kBEMTTWTcRa918A=
X-Google-Smtp-Source: AGHT+IEY86F3PQD8b8/A5oI+/mwnjror5rciGsAaeCXk9JKRzeG/0INj7cGEuw7VBkHrYxRXgw7H1g==
X-Received: by 2002:a17:90a:f40a:b0:2e1:e433:767e with SMTP id
 98e67ed59e1d1-2e1e631e566mr606891a91.28.1727991585900; 
 Thu, 03 Oct 2024 14:39:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e7ed58ffsm14809a91.1.2024.10.03.14.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:39:45 -0700 (PDT)
Message-ID: <e25e149c-19df-403c-9dc2-f413dda78e0a@linaro.org>
Date: Thu, 3 Oct 2024 14:39:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] exec/memory_ldst_phys: Introduce
 ld/st_endian_phys() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930073450.33195-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/30/24 00:34, Philippe Mathieu-Daudé wrote:
> Introduce the ld/st_endian_phys() API, which takes an extra
> boolean argument to dispatch to ld/st_{be,le}_phys() methods.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> TODO: Update docstring regexp
> ---
>   include/exec/memory_ldst_phys.h.inc | 66 +++++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
> 
> diff --git a/include/exec/memory_ldst_phys.h.inc b/include/exec/memory_ldst_phys.h.inc
> index ecd678610d..8ea162b40d 100644
> --- a/include/exec/memory_ldst_phys.h.inc
> +++ b/include/exec/memory_ldst_phys.h.inc
> @@ -74,6 +74,16 @@ static inline uint16_t glue(lduw_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
>                                                  MEMTXATTRS_UNSPECIFIED, NULL);
>   }
>   
> +static inline uint16_t glue(lduw_endian_phys, SUFFIX)(bool big_endian,
> +                                                      ARG1_DECL, hwaddr addr)
> +{
> +    return big_endian
> +           ? glue(address_space_lduw_le, SUFFIX)(ARG1, addr,
> +                                                 MEMTXATTRS_UNSPECIFIED, NULL)
> +           : glue(address_space_lduw_be, SUFFIX)(ARG1, addr,
> +                                                 MEMTXATTRS_UNSPECIFIED, NULL);
> +}
> +

This is backward, using the le function for big_endian true.

> +static inline uint32_t glue(ldl_endian_phys, SUFFIX)(bool big_endian,
> +                                                     ARG1_DECL, hwaddr addr)
> +{
> +    return big_endian
> +           ? glue(address_space_ldl_le, SUFFIX)(ARG1, addr,
> +                                                MEMTXATTRS_UNSPECIFIED, NULL)
> +           : glue(address_space_ldl_be, SUFFIX)(ARG1, addr,
> +                                                MEMTXATTRS_UNSPECIFIED, NULL);
> +}

Likewise.


r~

