Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41521CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqTG-0006qg-OM; Fri, 29 May 2026 02:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSqTE-0006q1-Ks
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:13:25 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSqTC-0002UP-RJ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:13:24 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45e9f4a3510so4481346f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 23:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780035200; x=1780640000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ssUPyBd3usjcl8XTK0Fh5dUFXJll6uI+lXkI/PYXkCE=;
 b=w7jE7ScjErDmZrASvpANaUnw7+CleDc105A5F9+svfymtJULbuzu2hJpKZrIYAvzcO
 qzbJ0T0LZLKN/dhcMyws3yTr48XRPqiw0a1j6ZroJl0XHU88xDX1dyWJ1a3Xrc9nFLFz
 T8L79n/1evuURIwpSHZCTdBC5pFupLICct0oey/yuDeM1pkgEKKWeADlTs/MjCmTrftS
 8ePEc5ly7bGtfQw3+RAR4NvxJf3lb6AstxkcPPlecnHXXiliSjCT12DA7j4QMRZ6XLlR
 DaMH8jWB7dAIfa4r1iBGu+ZiS6tnxtDsWeD7gRwZGo4myu06+YC8YL8zKrtDCdU/K0FO
 HO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780035200; x=1780640000;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ssUPyBd3usjcl8XTK0Fh5dUFXJll6uI+lXkI/PYXkCE=;
 b=lfUzsq/Q1MgsWA6CO9KzkAY/Xmuk0/xLrWq5t7xmyVNTXa+ohN23FsNSMGo7Yh196w
 rDIPhwYkDQC8FbbNsLtOB3OKXhAF9OKev3ELDryqq92pLheyB7MYyPKbsORGsgi7w1p+
 lwJ6A1YhPXRn8oErTh01khDtFt8WhTWx7/ZALxxqznu2FzBDF0CpLwPvTnYRk/d2UFtX
 Rt/566KlcPIY6aPspimGxU6jVPMLXzeO8yXGSKtr+4GRkvGMMZoyD6nKsJ3XX4irNBwB
 gSo/TimAHGhkpWTpyZzbmOy3Qnie4gSrZ94dPNvej+rnQsrUMGgMQu6qUkdyqwQmnPh/
 u82w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QKaCsyNF/B5tcXS8nFt4iV/R9jKTtaRxEQNSxJtD/habLCUWyilx4zNlL7/DvjfcuZN1eQ9Te2xcs@nongnu.org
X-Gm-Message-State: AOJu0Yy3KMPwp5VySPz+RQUkI89pzgfcvtCzCdQOsyp45iLqZ8Fsr0qm
 0XtA4wAVcYbMPAAWl8Ouo5kE6WO93KP3Hm/cT6rbP84vwlm0CdEx/LXBrbgwzxl4Md3kY/yUtvF
 tzX2pXK0WfQ==
X-Gm-Gg: Acq92OGd7ARVSmno8VwZcs1JBM4TXN9Pf8H8E6zmGZeCRUhaBY2Q7s7rL62FGPvIVvT
 0BdQNFEUhhCsyL2FL4zrdXB6jPBjXGfluVOW+aPurR+gj/48bggf5MLse3ZWyii7kg8Z7WJvCFe
 wrMN9iVTioVzWfZyv+RmontiB3OLGA/ohr8ODqStcwvXXK+6PC9TY//xakW4X2oDkvcq/JJJS3j
 C7f7WN9tIO5xNSTpDb7qy2VdsUlZLC/hNR8aPrchfVHPklHK/fJlX6aTjuy3y/f/pUhW1irGmex
 yfBgWvlseK7c71+UublvEdWq1plCeRVryPsJ7HC7hzXQtJvtiFm4YzSU2CUpOKEMv93qzhU7Zhb
 YXMGfdmatHiMKeo1sitTWqq0c1hd5cpo+Plnj7/YgJpE5Qub43oB+BXhOdFTCQgOiK4l6mpqRvk
 Ovc1QfP4RhxK0BmzHhd8+c8QOBbE8IJAbpdE1iuXDlzosNfgURjw92VQxL2Bo4KNfjmGtszzUZP
 15TMQyY4JBqnow=
X-Received: by 2002:a05:6000:481c:b0:43d:733f:aee6 with SMTP id
 ffacd0b85a97d-45ef13f840fmr2337854f8f.10.1780035200534; 
 Thu, 28 May 2026 23:13:20 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34c3081sm1280877f8f.15.2026.05.28.23.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 23:13:19 -0700 (PDT)
Message-ID: <7d60a11f-c82d-4557-907c-ae6b6907761b@linaro.org>
Date: Fri, 29 May 2026 08:13:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qobject/json-writer: preallocate output buffer
Content-Language: en-US
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
References: <20260529023426.54680-1-guobin@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529023426.54680-1-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 29/5/26 04:34, Bin Guo wrote:
> json_writer_new() creates the output GString with g_string_new(NULL),
> which starts at the GLib default of 64 bytes.  Serializing typical
> QMP responses then requires multiple reallocations as the buffer
> grows -- for query-qmp-schema the GString is reallocated 12+ times.
> 
> Preallocate JSON_WRITER_INITIAL_SIZE (4096) bytes.  This covers
> most QMP responses without any reallocation.  4096 is one page on
> most systems, which is efficient for the allocator.

Why not use qemu_real_host_page_size()?

Anyhow,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>  The JSONWriter
> is a short-lived object so the preallocation does not accumulate.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   qobject/json-writer.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/qobject/json-writer.c b/qobject/json-writer.c
> index aac2c6ab71..fb3f3f3e3c 100644
> --- a/qobject/json-writer.c
> +++ b/qobject/json-writer.c
> @@ -24,13 +24,16 @@ struct JSONWriter {
>       GByteArray *container_is_array;
>   };
>   
> +/* Covers most QMP responses without reallocation (one page) */
> +#define JSON_WRITER_INITIAL_SIZE  4096
> +
>   JSONWriter *json_writer_new(bool pretty)
>   {
>       JSONWriter *writer = g_new(JSONWriter, 1);
>   
>       writer->pretty = pretty;
>       writer->need_comma = false;
> -    writer->contents = g_string_new(NULL);
> +    writer->contents = g_string_sized_new(JSON_WRITER_INITIAL_SIZE);
>       writer->container_is_array = g_byte_array_new();
>       return writer;
>   }


