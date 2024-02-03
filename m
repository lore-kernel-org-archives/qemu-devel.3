Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A26C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 11:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWE7t-0003cd-JA; Sat, 03 Feb 2024 06:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWE7r-0003bP-MA
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 06:23:59 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWE7p-0000vS-Ls
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 06:23:59 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28bec6ae0ffso2168114a91.3
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 03:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706959436; x=1707564236;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bSAtRqrGA4Qilfsh+L9FviEDBUsiw2624Ro/wIEyZrY=;
 b=WmsP7+bUcSzIY+GPULk9wluQ3xoeC6tKXrHjCHQ0XcEXh+GikwXGGsOKDXR5OIBjHu
 VoEytbMHXBjxRRORotMlsgO+kZxMSjIdODUBn6GlwHg13raOy8Xj/vimeg8fvZUdfLXQ
 JZ6jmYrxUOHhsvAc1LmZsyNz8ek9ZSBqZ7FTBQUGYkW/5v57uMEXf3LNs/Q4/6mwNbyP
 y6FWEzu+oOPZIjYu4fay43SZ3u+5Ju6Bqsx8Wysurn+XikelMn25+W4AknLNznZUMdxi
 mncP+r3W7/RCcU/6eqnfuv7LC1o92tcbY/kUrbq8ipS8P13DPQuENOG2IqKe/DuppGo/
 zasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706959436; x=1707564236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bSAtRqrGA4Qilfsh+L9FviEDBUsiw2624Ro/wIEyZrY=;
 b=rtJ3fdsy+x+81d0BO+srjpa1UE4CRUM2jlevfFVYGaRLeyIyJ4Syng9VrNJeSB8HSX
 jjPX6h5THY4S8kVzrLZpIkKPVCmRTTPZFL/FX3JyvBfuwVi1wjkAHfUv0NrPnLlgWxsX
 ovvEpQvf/w0o/J9jZPtxrXxfCCUwKukRMGmdCoDAc5kNdLe/4YPf22wnGnAefv4t3urF
 0H1uIHOhwqYM7e7JBVi5LAVJfZ4Iih1LvInPin/7CYUjJfKVxH7aODHL/1X7QPjFMFXU
 efN6XLuALC6ShkJjzZk2RsnhIs+dj9HDhngnfwZ3nNM1EiuryZxvnqGcO5dlWay5UhhF
 YR5g==
X-Gm-Message-State: AOJu0YwbjIBZOlEEjwQgSuq/NXi5EHWVr9UxykK2RKUgdQlGtwyLqOpo
 aovysSB93xkP3JE8fsKBeGKdsR5DJ7AeID1MMkxlrZI3e8mmduwqThZDpRx1oHk=
X-Google-Smtp-Source: AGHT+IHPaqap/JjgDEzVtaBWCtzuONuSGi44VB6rioaLH3Z6bjrWFq6xvyRFUPfLWxury4+JZw7MgQ==
X-Received: by 2002:a17:902:780b:b0:1d8:f394:da39 with SMTP id
 p11-20020a170902780b00b001d8f394da39mr4375822pll.65.1706959436157; 
 Sat, 03 Feb 2024 03:23:56 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWIhe73GuX77EdQC21jhOMH1cCMjup0xs9XUgvz1QDsTzxwNqNeC/XIRhOf9K5GlOal62DOk+GXrrsjLBUo3QzsWA5hx6PvHCmMOGtGVfaibSCr+dkYmjD/2iZYJnbmyWr9A2ZuWdUYte5beZq9faKwqpkWoI5qyA7OgmxThmp/FZA0n0+Dqyp8Ex4LSeEHvzKqZQSzqt65SS6eN3qGWruwuJf24r2v/Ut+VXwMmQted5ZWQOc6+4TULF8gGR9Qamo1/FtpwCTs9p7sRovVRajDWSFo13Y1pWVteuLkhnccEFtrYeCzrMqp1n+AWdnhobXzDvXAqZJIj6DipcL8RLrx2DZeuOQjcFW9Z3cBx2PpLtlElkG1/hJw7JcGjj4F9fJCFXkVDg5byreRU++FMXXYsFATP1SsN7oDjcae3q4vx/5fw5AYSq7xSMMbZ6YX0TJRN5ROwlWxtvwtppkCGUWw4qlHJRaUxbCeZY9Jl6lLd2ahPSRoKxtQNAu889P9pXLVngVE+d7A9LpA3v4Nrs5zZcNFeFBUrK+cY4aVq3bevKcobon8M3GXDrM+NRUJokn/GoYnyUtvAEb7l+oOHlfuu0tVuvEIfPmyTVPZ2i9xmz6MUzR1cB4pvTZF4M1GOKigg1Tl2ueeacSKbFcwNll3d7a/xkEY3MUC9tM5QNL1Jt9sdG7rUa1BOpHJO0HUUavRQ1d51RtI7j8RAg/PlEmEYkeVUqiw+rWm6A1iypL1RzM+8ek/ZfzUpXkPV9lBHN3ttgTxkVGcNYjXW/Jb91DDYF55YaDZ7HUd4UCbwfMXNLxjGTtT5S0Xv/fD9VCsWhon7d1F489j00eV7fA2m8ACC6wCJfixmMEMndGogPhzxI/nBs1exxVLTAik9QqDSKVqlfyY4fR+3HsLMGZtqpvH3WwUhRYPJvrf+r6CRy45yB6A9zxhvHJ4hjhPfr+oj+0SJz
 QCPZi+ctqp1tXcFw4iL9vK2pBKIx7b9JCAgW0k4U0xnm7hKt1oXV2osBAVWRohKhI84gaCMy1S+A/jgfK3+AOSljo4jkKK6qbhO5khAntnenwGukz046w54fE29MTQFeyxJnvE4Q0OttlXReGZ8+t+GN249dt42XQtML7wEQ/pfvf6Djbxbsb0xniUgAJoMJh4SACHRM/bMrcthBIVR+rL+kSNC8PJY9/WztPYUkbyEa+2e8RUsUxuoZmf1ww8bWQYOhPtgsUur6T4l1T7eqS/WiMxTb8Q8et9XJ4I9x8kUo85ZYRtcpcTp2qTPCpWRQ==
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a1709029f9800b001d7207fa2a7sm3054236plq.152.2024.02.03.03.23.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 03:23:55 -0800 (PST)
Message-ID: <1c9a2e94-0c54-446b-99a2-69e25e9725df@daynix.com>
Date: Sat, 3 Feb 2024 20:23:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/21] gdbstub: expose api to find registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Laurent Vivier
 <laurent@vivier.eu>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Alexandre Iooss
 <erdnaxe@crans.org>, John Snow <jsnow@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 David Woodhouse <dwmw2@infradead.org>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Brian Cain <bcain@quicinc.com>,
 Paul Durrant <paul@xen.org>
References: <20240122145610.413836-1-alex.bennee@linaro.org>
 <20240122145610.413836-17-alex.bennee@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240122145610.413836-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
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

On 2024/01/22 23:56, Alex Bennée wrote:
> Expose an internal API to QEMU to return all the registers for a vCPU.
> The list containing the details required to called gdb_read_register().
> 
> Based-on: <20231025093128.33116-15-akihiko.odaki@daynix.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-Id: <20240103173349.398526-38-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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

nit: Add struct name; docs/devel/style.rst says struct has a CamelCase 
name *and* corresponding typedef, though this rule is apparently not 
strictly enforced.

