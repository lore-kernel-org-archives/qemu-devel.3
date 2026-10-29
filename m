Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64270606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LXQnyzW/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQCj-00047F-NC; Thu, 29 Oct 2026 09:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQCh-00044V-HT
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:30:03 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQCe-0000Jr-Sw
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:30:03 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-82109f51565so1008985a34.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793280599; x=1793885399; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WZ55lRvOcUl9suJlF9ZDwqt7NSHQhYBMum/pCls/wQc=;
 b=LXQnyzW/1OD+VAEVGY/MZOzfno46IiB7iDl9ZNvT5fk/Ftwfu8C6fUrtZc0I4FpoQZ
 cR9Q1i0yEnI641rdAydazScfDGR27xPVtTQ6nLRQWGBw7SsTZpqh0trpgFvmCh8B9yHr
 xF3q0158T25f/FlyXzD374tciUZQRF0d5d7tXgiSdch6w4BN3l53sXK/RLRkgHKhl2oP
 Dv6OUFAkrAJNw6oBug09y+80cxq9QJyk6JSVWxovAM009C59B7W11kmm933m98rgwdqq
 /CK0sH+w8Aa7BUpqU3XOmGhpzZGsAz2milkByyimb7J+unGb/4M4m07ZjNhWQsXmJjin
 d4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793280599; x=1793885399;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WZ55lRvOcUl9suJlF9ZDwqt7NSHQhYBMum/pCls/wQc=;
 b=VIN1MNGvOKMQnDChQ6F3CA2Cc//RtCBwXjXlMmTC5VfrBB4KA/UJFgnrzpVcgVbla6
 5hVcyegJXhtmeTuwlf6osILq77WwxyHmhL2NzV0NDov1NIzF+BS+UjecGKCYvyxJKmht
 Cg/bMtvzog5PUtaN34Lb4MAZnFHZyq2Gh1UH0QsgsHAbQerDhAQ+Ibz7FilSWRPbXp4a
 xGSzfDB5FdqYAA+FdwkdV8aJIzlCm4S9eS+5Woq1Ww/DjjTV6UQgj8x0+gApKDJIP1KV
 ri1cf+Fo4b4X+ZEXDb0mUwwHbGQBYUnARIlZtYTzrxA2ieLWwgY25DzyGjVx3nf4ou2O
 BlJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLrQGl75Z7fluhMAjNJ0bcYBtujk4X4tmJA1UXevEXWrDEZ3VLaRytAQeaCovXDZE6Wz+Idvb2OEdB@nongnu.org
X-Gm-Message-State: AFq9FYL2Y7+Y+4j8x9cLOTxhY7o0QexpwJgRGFfBpCpTc3rIb/XkMoeg
 uPRnmf/Meee3FsIARD1vNW+i5flkbnQqj/F25/URvLWbGFt99QgDqObuHC5dPcRfnLTjUC/fdMb
 aOVXI
X-Gm-Gg: AYBFou1+afBL4PgdyPUkLrGNcjoYo7rudq/wuMTzFYuNkmv4VGxiL5NGfMiVFZmFR+t
 J3Uw9qGmhVFhx6JliHlaQ4g19XTjs44JU7wrun4JEUVh3/vM9x+WGmCf7mcRg5w56Niwxn8Xe3H
 TwayLoKkHWv6GYvbvidDXj9b4eGQx5ZtlMnlllb0k84r/u9RBjjQhvZjXzutqF0TknjhZtOkzqd
 I+aG1sYKpUbhtlOl1B0j0hQTsxi00WXrjdhArrywnSoReJ0oISktDTT2qzelSMKa5dy+l6/bVxM
 uFXWThzuNFzskd/lx1Mb6uUCSOYU+TeYetNXsG8P80cSwT9FqHgYl1cuBND8XvhXBv+xxvYoOn1
 4AjHjFd1aCqGyrgEN6fiEhCGEqrhcMLWSRdrBpxutN1HPREP7ng/fCowzGSQFe0NG9fXjCxpPVv
 alWxgLcvQgwxQ9rNiaUsqC/q4JxVQKk9jAfLbOhFKnCPd26zO+rlCRPKD4/eo7f5kHj9ljO2/FI
 o6yKb9kIqLNvrVbFjv8le5nD5V5O+wxn2Bd6m53fPEonhaTEI9mwb+EHDehesOGx9tM44TqkzOy
 38TmKifH5zO0M+IZM1hScCT5O1gPoQu5DbhSOV/WkSwd
X-Received: by 2002:a05:6830:4110:b0:821:a094:b26d with SMTP id
 46e09a7af769-85ab9e47c2amr4841309a34.13.1793280599062; 
 Thu, 29 Oct 2026 06:29:59 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f841563sm4385175a34.12.2026.10.29.06.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 06:29:58 -0700 (PDT)
Message-ID: <a7f44aaa-7ac6-4e48-8717-4a29585bc2a0@linaro.org>
Date: Thu, 29 Oct 2026 08:29:57 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/33] cpus: Introduce CPUClass::exception_name()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
 <20261022215115.19680-5-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261022215115.19680-5-philmd@oss.qualcomm.com>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 16:50, Philippe Mathieu-Daudé wrote:
> Have targets register a helper to resolve their exceptions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/hw/core/cpu.h       | 2 ++
>   accel/tcg/cpu-exec-common.c | 6 ++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 456154df6f6..9d71db16d2f 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -108,6 +108,7 @@ struct SemihostingCPUOps;
>    * @list_cpus: list available CPU models and flags.
>    * @parse_features: Callback to parse command line arguments.
>    * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
> + * @exception_name: Callback for getting architecture exception name.
>    * @memory_rw_debug: Callback for GDB memory access.
>    * @dump_state: Callback for dumping state.
>    * @query_cpu_fast:
> @@ -178,6 +179,7 @@ struct CPUClass {
>       const char * (*gdb_arch_name)(CPUState *cpu);
>       const char * (*gdb_get_core_xml_file)(CPUState *cpu);
>   
> +    const char *(*exception_name)(int exception);
Not keen on "int" while you're standardizing on STR_ARRAY_ELEM_OR_NULL 
and thus an unsigned comparison vs ARRAY_SIZE.


r~

