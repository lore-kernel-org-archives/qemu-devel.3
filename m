Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD97AC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reuV6-0001wh-CQ; Tue, 27 Feb 2024 05:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1reuUo-0001md-HL
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:15:35 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1reuUi-0002Mq-AL
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:15:32 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso35040605ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 02:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709028925; x=1709633725;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fx9hfe20Iig0ZK24L+ZonhivY18ZcsqsCbKd+RliBUI=;
 b=jQRo+vGvjda3XtMrxXp+Ovr5+wUBe/Iw3lcJyaDqSHcUmcFKEBDdUOqpu6hKTZwyZN
 TVHfty1DnIeJfLGyKVoBV4UCM+uWPKa3eDLBRBfPZpAQ2GFikUGXf0Zxerxc4CU6dgE5
 P11NG7vK+LbbM60RIF292HPOxViVRWI/OuwJiLNkiNo6fSo9WJUei1LXR3Fg5qoB8oy/
 DA/2Ib5LM3xWFXoDNWuYLrRAhcOt9rDIRpoCeAo26T8ugciFs3h7yC1JpA7W+72lapuM
 7Vi2suO0PA51p8bHZUeMoEsvJBUCsUtWCpM8FNrA6ML7z/a6qYH4sVFhVWmPGXpYaw2r
 J0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709028925; x=1709633725;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fx9hfe20Iig0ZK24L+ZonhivY18ZcsqsCbKd+RliBUI=;
 b=SEgvMVLDEznjVriOtRBngdUnrNwGy1jL+IB4VVIPPkPXN3LytQH5OYxepNZMQarzP6
 UVE09zFC9ESFTSXSLcsVGE76aIBKdKEYU6iUSnwsFWjMgI/hVut3JTnd/UffHE0pbj8B
 n8RGvF4TNA4+tqoipjrF/Bgcem/s8DDnya4InJpdOiAO2+zCcEk8tJO+XeF/mYfn8S7s
 Zc2Pu+s/G0EvE8qIMkCznHpfr1omipn07J/pjYJS/o12iIC+5OuEtch2UIMIAMwFuIv6
 iKeNluENUulc8+4yZF35XYpWuLQFRuqwWn6HkUYQ+AQ5JNv+CrcwesSLAFGtwtw9ddzS
 64yg==
X-Gm-Message-State: AOJu0YypNo1qaYZ5NtsBRuW5fGFJ0LT+ecoiGBei94+l2KBLP/NdImBf
 LcAOA1TgSJyBS4nrUwbbEej2e+6kZYw4wMzEM3Ms/pmfQAJl8n1kP09bxrGjLA0=
X-Google-Smtp-Source: AGHT+IGGyYlErA9kk8nMdcFcEbGt4QH298QVBJTxJGbBkIKqaaIPTH8dfJ9RDIhR8DJM5hC3k8xACg==
X-Received: by 2002:a17:902:d587:b0:1dc:ae92:7e9 with SMTP id
 k7-20020a170902d58700b001dcae9207e9mr4236692plh.62.1709028924773; 
 Tue, 27 Feb 2024 02:15:24 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 kn15-20020a170903078f00b001dbb0348733sm1193150plb.67.2024.02.27.02.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 02:15:24 -0800 (PST)
Message-ID: <485e6093-54e9-4ce4-ae01-c44525b202ef@daynix.com>
Date: Tue, 27 Feb 2024 19:15:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/27] plugins: add an API to read registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-riscv@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow
 <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Brian Cain <bcain@quicinc.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240226165646.425600-1-alex.bennee@linaro.org>
 <20240226165646.425600-22-alex.bennee@linaro.org>
 <b7aac53e-cde5-4596-b0fc-d39f52d4ceb8@daynix.com>
 <878r36dxsv.fsf@draig.linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <878r36dxsv.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SCC_BODY_URI_ONLY=2.699, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2024/02/27 19:08, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2024/02/27 1:56, Alex Bennée wrote:
>>> We can only request a list of registers once the vCPU has been
>>> initialised so the user needs to use either call the get function on
>>> vCPU initialisation or during the translation phase.
>>> We don't expose the reg number to the plugin instead hiding it
>>> behind
>>> an opaque handle. For now this is just the gdb_regnum encapsulated in
>>> an anonymous GPOINTER but in future as we add more state for plugins
>>> to track we can expand it.
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Hi,
>>
>> Mostly looks good. I have a few trivial comments so please have a look
>> at them.
> 
> Done
> 
> <snip>
>>> +        g_array_append_val(find_data, desc);
>>> +    }
>>> +
>>> +    return find_data;
>>> +}
>>> +
>>> +GArray *qemu_plugin_get_registers(void)
>>> +{
>>> +    g_assert(current_cpu);
>>> +
>>> +    g_autoptr(GArray) regs = gdb_get_register_list(current_cpu);
>>> +    return regs->len ? create_register_handles(current_cpu, regs) : NULL;
>>
>> Why do you need regs->len check?
> 
> Not all guests expose register to gdb so we need to catch that:
> 
>    TEST    catch-syscalls-with-libinsn.so on alpha
> **
> ERROR:../../plugins/api.c:459:qemu_plugin_get_registers: assertion failed: (regs->len)
> Aborted
Certainly regs->len can be 0, but why do you need to return NULL in that 
case? Can't qemu_plugin_get_registers() return an empty array just as 
gdb_get_register_list() does?

