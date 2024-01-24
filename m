Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363ECC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 03:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSTdD-0003tH-SS; Tue, 23 Jan 2024 22:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rSTdB-0003sF-PO
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:08:50 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rSTd7-0001EY-4R
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:08:48 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5c6bd3100fcso2341367a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 19:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706065723; x=1706670523;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VFo8VE/oCNQcg7y+0hi3tk0ijg8Jc1j7rMhdDApnhJI=;
 b=mQGOkkEu43Yak1i9Ew+GDnLyjlbNSw/NY+2V9oRWHIC1gKJxwlwEh/1AfE9+l/2p6A
 ++50L2H9BdywOQ/HFNVJh2QYIW5xDT6CFlFm0B/t/adLeg9SvNxrmbKNUxC8HDVXZQhf
 m8oDCmJ6PHGVzeBgzsfN/0/MIryVUt18asaNRZGXOKAyO68owE3LRjeTVq5qKsgM6M4t
 C/hw+z5W1MtH+TSmzAYjrthAyc5zjlOzmsuGwKMOj6LbAMqvuKLgPcnpVMcIQZTWhwyv
 nGsdiy3YfmFnSFyapidYJI/UczZFgTGMqqatKHd/hUdfgzESUGK1LL/5lcYo8ffS7ZnB
 4c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706065723; x=1706670523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VFo8VE/oCNQcg7y+0hi3tk0ijg8Jc1j7rMhdDApnhJI=;
 b=sZ2frbAt3yxqRkDqLu6/MBq05YxtET08uFudkXdKrFn0ea+AjZDZt8NzrwttcKUIwI
 YIyIKze3znJx4jMXhEHkofuaZUkBCmjj17d9yauqQXpNKARjCsnC1IdrvlG3Oi+E3W7L
 MFxT/O2ZUPhORGvw/dBZsIdA6xDQHI4XmUcqtYdd/fCzozaNyH2n4BlkVZSV7isHLqSJ
 CvV0NeV8Lyu8+Wwp+rHkdGgFUmAEhNYUDhEJTI+CP1wBckXmbT/UATURL52le3h9EfqI
 qfEOdKQamtzpzLIUwCbZDADHR8t8+RIBJeAxerG3vZQGZzYEexe0rDQoyWR43VBH37/x
 KFsA==
X-Gm-Message-State: AOJu0Ywme41McAGzqUw4XDh7MeF7agkyB0/K4YWTcDEDSr++yM3fYgAU
 pd/1zbktNAaaDmgN4XExOHOrFu7SACN2zDD8pJ6KIOjcI4gK8xhvNSsXHzE/RNo=
X-Google-Smtp-Source: AGHT+IHfntglvY7cr85OSIKd+heawzghHZglxVkz5tGKJB42nnuYpbxcKdH1C6I7IIHf5nsB+5FoRQ==
X-Received: by 2002:a05:6a20:7284:b0:19c:53aa:53dd with SMTP id
 o4-20020a056a20728400b0019c53aa53ddmr210373pzk.42.1706065722914; 
 Tue, 23 Jan 2024 19:08:42 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a170902c9cc00b001d7267934c7sm7127456pld.298.2024.01.23.19.08.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 19:08:42 -0800 (PST)
Message-ID: <15d2f958-a51e-4b87-9a70-28edf3b55491@daynix.com>
Date: Wed, 24 Jan 2024 12:08:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/21] hw/riscv: Use misa_mxl instead of misa_mxl_max
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
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
 <20240122145610.413836-2-alex.bennee@linaro.org>
 <20240123-b8d1c55688885bfc9125c42b@orel>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240123-b8d1c55688885bfc9125c42b@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
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

On 2024/01/23 17:20, Andrew Jones wrote:
> On Mon, Jan 22, 2024 at 02:55:50PM +0000, Alex Bennée wrote:
>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>> The effective MXL value matters when booting.
> 
> I'd prefer this commit message get some elaboration. riscv_is_32bit()
> is used in a variety of contexts, some where it should be reporting
> the max misa.mxl. However, when used for booting an S-mode kernel it
> should indeed report the effective mxl. I think we're fine with the
> change, though, because at init and on reset the effective mxl is set
> to the max mxl, so, in those contexts, where riscv_is_32bit() should
> be reporting the max, it does.
> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Message-Id: <20240103173349.398526-23-alex.bennee@linaro.org>
>> Message-Id: <20231213-riscv-v7-1-a760156a337f@daynix.com>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   hw/riscv/boot.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>> index 0ffca05189f..bc67c0bd189 100644
>> --- a/hw/riscv/boot.c
>> +++ b/hw/riscv/boot.c
>> @@ -36,7 +36,7 @@
>>   
>>   bool riscv_is_32bit(RISCVHartArrayState *harts)
>>   {
>> -    return harts->harts[0].env.misa_mxl_max == MXL_RV32;
>> +    return harts->harts[0].env.misa_mxl == MXL_RV32;
>>   }
> 
> Assuming everyone agrees with what I've written above, then maybe we
> should write something similar in a comment above this function.
> 
> Thanks,
> drew

The corresponding commit in my series has a more elaborated message:
https://patchew.org/QEMU/20240115-riscv-v9-0-ff171e1aedc8@daynix.com/20240115-riscv-v9-1-ff171e1aedc8@daynix.com/

Alex, can you pull it?

Regards,
Akihiko Odaki

