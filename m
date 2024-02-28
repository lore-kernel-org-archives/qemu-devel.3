Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917D7C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCBt-0003Gy-Ud; Wed, 28 Feb 2024 00:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfCBs-0003GK-G4
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:09:12 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfCBj-0005C7-HY
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:09:12 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc5d0162bcso43058955ad.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 21:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709096942; x=1709701742;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cslmreSRbrQ1KYjx5gJYbed1Ss6prRm6Ac4nj/FDVd0=;
 b=qeeyP+tzjc7k4jnftGJ/EVECn6Iv/aALIxAHxfa3VPF8seY24qyb5tR3p2cQmudU30
 mLCgLGNoDMwrj5q8em9WeywpE5L2rdX4OHw0C/V7xMsHyogAi7xhSJBo3hMXL6HnIa7h
 GOaq8m4BBiPzA+q3hwOTH/oFSaI51hfI7Rgx1AbxYldQxwdmS445u/iN2aA6CtzHmp0M
 Er/8wqMreigNumvQeN4LpBTMxFE236MFJcg3smYHcgv/TNg2D9v0vLjx+zQN6fEoiGMZ
 gwiCq895HUiVKxWy3pMT2/j1cTLfBSBSltOlhxguaHji7v/CYLg5TF0NwuGIt1cTjSXL
 DbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709096942; x=1709701742;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cslmreSRbrQ1KYjx5gJYbed1Ss6prRm6Ac4nj/FDVd0=;
 b=K98qLlf+uX6XouMB8WXVZjyB2oDz6Ebsm09SPIP3PwZcbYGnzIDJMWrsboBuqzgwId
 A17ahAQBTu8FUwEtdeosSrp8O6S6HOXzCMTPkNxDY0/WHlKwsytOEiQ4dntFP6ou2yY/
 1oqT2OBtm9ZtPUXodSypEOahLAa/KbusvURYC+RQBjRYz3NTnWgj/OyWkW/z4w8kiFqf
 XgnKho0reG4sFxo5Nmr6SWrCBiAAqX5SJ1GOmb9bPQLX8D/9NMvXODF83NG03tFmDjBl
 fascBQ4aG20x08O+LMYzn7kcgb6qxKXLsy22n2J+ODvAj1jaZjBUB+aHH0qtJuiYMFuq
 UnpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVScwyS+x9vL6zjIgIZkATfqvFr5f1DekPKIty3FvYCtx7xZ7FKq0SnhGxdC5nfPXO+nNZzV0k78/De2sgRo0wdA+3i6ak=
X-Gm-Message-State: AOJu0YxagIa31vbyq+gipdGferl9lMPGp/KOQSvwGYeruyZa4Saqqg9+
 C+YVw0G0Lt9CGlMiUEg906jn3rfzYh5a7Yuue++NLU46Fp/xCZreonQYq42NQFQ=
X-Google-Smtp-Source: AGHT+IFNE9qxi2xbfuI0Uw+IMseWdlT6n78xSU1nbtCMaZDWvoU4Y3Qy/kKFYK79bAUdUounxM9n/w==
X-Received: by 2002:a17:902:eccb:b0:1dc:c17d:6edd with SMTP id
 a11-20020a170902eccb00b001dcc17d6eddmr2707125plh.20.1709096941959; 
 Tue, 27 Feb 2024 21:09:01 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 km13-20020a17090327cd00b001db5ecb2899sm2376359plb.162.2024.02.27.21.08.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 21:09:01 -0800 (PST)
Message-ID: <ec233087-c919-47d9-b48f-044495d0a74a@daynix.com>
Date: Wed, 28 Feb 2024 14:08:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/29] gdbstub: expose api to find registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-s390x@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow
 <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
 <20240227144335.1196131-22-alex.bennee@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240227144335.1196131-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2024/02/27 23:43, Alex Bennée wrote:
> Expose an internal API to QEMU to return all the registers for a vCPU.
> The list containing the details required to called gdb_read_register().
> 
> Based-on: <20231025093128.33116-15-akihiko.odaki@daynix.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-Id: <20240103173349.398526-38-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> 
> ---
> v3
>    - rm unused api functions left over
> ---
>   include/exec/gdbstub.h | 28 ++++++++++++++++++++++++++++
>   gdbstub/gdbstub.c      | 27 ++++++++++++++++++++++++++-
>   2 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index da9ddfe54c5..eb14b91139b 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -111,6 +111,34 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
>    */
>   const GDBFeature *gdb_find_static_feature(const char *xmlname);
>   
> +/**
> + * gdb_read_register() - Read a register associated with a CPU.
> + * @cpu: The CPU associated with the register.
> + * @buf: The buffer that the read register will be appended to.
> + * @reg: The register's number returned by gdb_find_feature_register().
> + *
> + * Return: The number of read bytes.
> + */
> +int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
> +
> +/**
> + * typedef GDBRegDesc - a register description from gdbstub
> + */
> +typedef struct {
> +    int gdb_reg;
> +    const char *name;
> +    const char *feature_name;
> +} GDBRegDesc;
> +
> +/**
> + * gdb_get_register_list() - Return list of all registers for CPU
> + * @cpu: The CPU being searched
> + *
> + * Returns a GArray of GDBRegDesc, caller frees array but not the
> + * const strings.
> + */
> +GArray *gdb_get_register_list(CPUState *cpu);
> +
>   void gdb_set_stop_cpu(CPUState *cpu);
>   
>   /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index a55b5e6581a..2909bc8c69f 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -490,7 +490,32 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
>       g_assert_not_reached();
>   }
>   
> -static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
> +GArray *gdb_get_register_list(CPUState *cpu)
> +{
> +    GArray *results = g_array_new(true, true, sizeof(GDBRegDesc));
> +
> +    /* registers are only available once the CPU is initialised */
> +    if (!cpu->gdb_regs) {
> +        return results;
> +    }
> +
> +    for (int f = 0; f < cpu->gdb_regs->len; f++) {
> +        GDBRegisterState *r = &g_array_index(cpu->gdb_regs, GDBRegisterState, f);
> +        for (int i = 0; i < r->feature->num_regs; i++) {
> +            const char *name = r->feature->regs[i];
> +            GDBRegDesc desc = {
> +                r->base_reg + i,
> +                name,
> +                r->feature->name
> +            };
> +            g_array_append_val(results, desc);
> +        }
> +    }
> +
> +    return results;
> +}
> +
> +int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
>   {
>       CPUClass *cc = CPU_GET_CLASS(cpu);
>       GDBRegisterState *r;

