Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA9AC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAgh-0001Dz-Fk; Thu, 07 Mar 2024 05:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAgf-0001DW-2O
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:09:18 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riAgd-0003VT-GJ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:09:16 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a452877ddcaso96215366b.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709806154; x=1710410954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TZpIgS91/loiQnZwkkLKTUpXBgEv8+rL6LVDvH6XI0w=;
 b=ulRsi6qLcCCxuwRjVGid2baSNrgF+vB2KhDW5tWxdEE6eAnnGYJLXevLhjdvNzLW2N
 WLA9kAex+5o6U9eOO+6N0j91rZKx+WYkw7Rzxoyt/cY3QVwRt/9R2sGP96A44gyRTL4o
 sZigdc6RjQIgstFQ2kTR6zkAZwKzOFZeo+aE1mPwpVOOPjcAt14BMXGwjRRnIuDsTK/a
 zRS7ZFYUN3iadP7Xk1j7Vd6lmHrIRSbb3PzhSovx7G8A5WMRO1gEjzZgmHYWERneHH6u
 t8YGsjImFLUD+dlCk7Clo2PbTpOnDNGsyXqR02VJQqbAkZxem7kqeGEtRiN2+T1GcW9z
 +tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806154; x=1710410954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TZpIgS91/loiQnZwkkLKTUpXBgEv8+rL6LVDvH6XI0w=;
 b=a7BZYzsA6IuzjvTPn5W2eVaUduMiPSsNAqnkPWYoy29nVwMY1cGJTIKULBs6M2dkcK
 c67lRyfVAPCJTNPT+pdDKx/4tbAO+e1KtgxCQt6wAMVL6zrT4oPyX8hPZMF36tzuYnCa
 kINSVFv1HBLXZbYZoJs/POcSiQyHojdJsu9kPU4RCFJU+Oqk4Cbu2Psz9MoAviY/qKbC
 5iRGF8BwkBDXvSdheyXnExwLZ4v/MK30YGrQ0hyhedTZPbJPioOjS5bWKw8Orxx5og31
 pS8rMfrQDXKNGPSYF1zAA/53DRvDNrKj+Ut+ncV4Qz2ZStUB6PtPl8aS1qhHZzpf2zf3
 AxBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/si6O3YLvAEFNfl6dEomzPocTVNE4oIpCMA423O/p57x1TCNDVX1uwgy9vM50ga9l7oNQ/7UBFzZRbLSCt8hVvYFIR9g=
X-Gm-Message-State: AOJu0YyWvsCYX5A7cYHgWM9H3Cmr/iCtpVBWfCKwAdAvzXuhUkUyHBD6
 pvvk4UhmFLGoWIgMMTv7FFrR1HgX+V1gDvqvsbjCTGsM/KUp49+B3VnMRNnWjoc=
X-Google-Smtp-Source: AGHT+IHyrnotKrXhOGLpXg4/+M1d9fHrVSNAKlJpa2/hRa0bcDL3T8pWKIbn4OYV3K5bPFSFL09QTQ==
X-Received: by 2002:a17:906:38a:b0:a43:9f21:1a08 with SMTP id
 b10-20020a170906038a00b00a439f211a08mr11081577eja.63.1709806153918; 
 Thu, 07 Mar 2024 02:09:13 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 re8-20020a170906d8c800b00a43815bf5edsm7974189ejb.133.2024.03.07.02.09.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:09:13 -0800 (PST)
Message-ID: <35d52e6d-a293-4465-b902-01a00de7892c@linaro.org>
Date: Thu, 7 Mar 2024 11:09:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] Hexagon (target/hexagon) Remove
 hex_common.read_attribs_file
Content-Language: en-US
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, ale@rev.ng,
 anjo@rev.ng
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
 <20240307032327.4799-10-ltaylorsimpson@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307032327.4799-10-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 7/3/24 04:23, Taylor Simpson wrote:
> The attribinfo data structure is not used
> Adjust the command-line arguments to the python scripts
> Add hex_common.read_common_files for TCG/helper generation scripts
> 
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>   target/hexagon/gen_analyze_funcs.py     | 21 ++-------------
>   target/hexagon/gen_helper_funcs.py      | 21 ++-------------
>   target/hexagon/gen_helper_protos.py     | 21 ++-------------
>   target/hexagon/gen_idef_parser_funcs.py |  5 ++--
>   target/hexagon/gen_op_attribs.py        |  5 ++--
>   target/hexagon/gen_opcodes_def.py       |  4 +--
>   target/hexagon/gen_printinsn.py         |  5 ++--
>   target/hexagon/gen_tcg_func_table.py    |  5 ++--
>   target/hexagon/gen_tcg_funcs.py         | 21 ++-------------
>   target/hexagon/hex_common.py            | 35 +++++++++++++++----------
>   target/hexagon/meson.build              | 31 +++++++++++-----------
>   11 files changed, 54 insertions(+), 120 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


