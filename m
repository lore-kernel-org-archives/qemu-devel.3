Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1260C41513
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 16:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPltK-0008V7-GN; Fri, 05 Jul 2024 12:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPltI-0008OL-87
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 12:34:32 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPltG-0002gW-PV
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 12:34:31 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3839d74a2abso6103245ab.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 09:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720197269; x=1720802069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=03aL4emIefcjYIg0HnF+4eNDMqJB4FbEPJCILYtwM6k=;
 b=fY/sEdJLKQktebn3We3nnx7qzxvi7iR2ufnu8zHABLnVz1y0I8V/F+BN5cn0g+/uSa
 69KlCkKuB7Uew9yDPmVGUVb9Yorc/NrqBn28YKKh+zN17IV8+1Zdpt0VqeP1ezaT1Cy/
 AwT6lbwib5F5id5k9OErPjHmfSdbup0eMpXbq9ugDxe1mQlIj0oFn6ubHXnvyjbKO2BJ
 HD7yY3Ins1zE6r0WdODCklQgwqn6j9DkCWtof7EmM6RnsS4Qs/d791lOayAHCFUr9daa
 EqiF2Se8MwYw3S1KQ6cLqgTT2z5iUUvcwl13VpPlD1zLs1xuokz2rXHbmO3ZW/L/5qZU
 ik/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720197269; x=1720802069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=03aL4emIefcjYIg0HnF+4eNDMqJB4FbEPJCILYtwM6k=;
 b=tne+zOK+hnrXhqrX3D0p4WAoZNxLTU6NqPyj2P7NWuAF9PLWbAxWoLdBexjexgCywQ
 D1FccHMYpTaYVzcqAc8xd1a8H7671ozNnBW4bXzDqFVMiPCIwoTdhv/4T3aOD/TSO9j9
 kTu8AcQgWoYgEj+0x2ELlgqVfoI6IkfFl7xi9msfZrMZ3Dr67swclI+RIz8hQtEJvr7p
 19C0GQw1ZlG2MD8spmnRGBmcTyNmDPervOtbzKYzW44/0OO/KsD+cKQfXUfgXZX6RGlF
 jpbSZ7xwECuV0HcE8QKpmfiJtGDbQOqQQW29/4euOBOw4FIRJn98Tsh4bCe2uxXtf5Lr
 kEMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFZb+2+NlVoDaJZFt3eprG2pE+8MEUNvPRYkidgETq6vcqSpQExR44tnXAc3Tkbuf9ZCqRLK1hT4buMzN9yzXi6N3xFV0=
X-Gm-Message-State: AOJu0Yw6I5B0oCSPU5waB0dSJdYX7XbbuWyCytPPQag+BG9OfaDrO0yT
 vEn0iQopJHguk3pxLO5p40HwzibfzW0+DgXOmRb5V6212kd6asB6kXrlm5I1Fxk=
X-Google-Smtp-Source: AGHT+IG7oxeE6wEa24tLg+K6GXPrJ3DSBNGxYLGs5/2m0Nu+kpVNSg48FgkDgDVLnETQMDzyhaY2qg==
X-Received: by 2002:a05:6e02:1fea:b0:375:a205:86a6 with SMTP id
 e9e14a558f8ab-38398ced11fmr52971195ab.17.1720197269189; 
 Fri, 05 Jul 2024 09:34:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6afb9042sm11494733a12.41.2024.07.05.09.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 09:34:28 -0700 (PDT)
Message-ID: <e8613098-74e2-4c14-9f47-24cc7a6b0b62@linaro.org>
Date: Fri, 5 Jul 2024 09:34:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] plugins: save value during memory accesses
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
 <20240705003421.750895-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240705003421.750895-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12a.google.com
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

On 7/4/24 17:34, Pierrick Bouvier wrote:
> +static void
> +plugin_gen_mem_callbacks_i32(TCGv_i32 val,
> +                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
> +                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
> +{
> +#ifdef CONFIG_PLUGIN
> +    if (tcg_ctx->plugin_insn != NULL) {
> +        tcg_gen_st_i32(val, tcg_env,
> +                       offsetof(CPUState, neg.plugin_mem_value_low) -
> +                       sizeof(CPUState));
> +        plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
> +    }
> +#endif
> +}

You need the big-endian offset for the low half of the uint64_t:

   HOST_BIG_ENDIAN * 4.


r~

