Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B35D4A5E6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 01:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgYjU-0005uT-5R; Thu, 15 Jan 2026 20:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vgYjS-0005tN-99
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:34:34 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vgYjQ-0006i1-S5
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 20:34:34 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-29f102b013fso14260355ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 17:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768527271; x=1769132071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7R7SACgHTMWnccyhVwBGcXBkrm2xAf0n5nc3F2XKg0A=;
 b=UzxchyBQsfGXz2EkOHVpP6pse8nxPSfePeoC4ZHSwOzMjPYNZhtLAZpf20Rfcvq9Ie
 HubwOC54wMDZgvQ0bqPw7uodgF/aMy+PfRanSZGBhpuwAoSEfREmkPqecWa7BS0+VIfg
 +TsH/BcbeD+/09HJoy6aR7SeIEP0Hpq7jXON//VgOvpOMBWpJRXAZhJPwG/HFNnf52Cz
 2rtznbd2tONCzIFHotiGIujnYuVA64c3zI49jgIAvWpKNqDkwYMzpn8EcIb0U8GngGOw
 NUicTR44B57mNON7ldAw9qL9gr0vVBkyeE5b6r/k935CXbk9pGxrYhYlGaEXU2cUwtKW
 s2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768527271; x=1769132071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7R7SACgHTMWnccyhVwBGcXBkrm2xAf0n5nc3F2XKg0A=;
 b=KMZGYRWv/Mw0VuqjA1sB8qPKv58rGHdZX2ApXE47Xz1ryiQbuiXo6/uXVPgmr81b9R
 ojBSRIaOdmdKoggOpmrU55MKeLsNjHAN4NBO7AkxPVIxb3dDWr0F6dr/Vbe7/7VqyPp4
 eiard9Q5SdnhnKuu7ys1sdy1r4DETf9ZnHV1O87Ci9vG9puk5euW2753/fNs70seVCg5
 nwZ0vHiLoGVzM0zgAqH70n63SzuJpQJeNNZ96T8oIqgOzE2BkScIARwMS2sSFu9RTRy+
 0pBD7s/b/7CBuOsLmVmDRIGd8C2Nd2pX3EfQbZ6irD5Qx1aI/402AxYPiU/qj1iGjtkR
 F8Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz0WyF7AWroXqD7yK6lN2iOVozFewR6IGnvy9VrPkryynpM9cljdlhI737RLKVw/Dz3fH4+PH4KNeX@nongnu.org
X-Gm-Message-State: AOJu0Yy06pwx5UWleq/1yhGltgxvfYB9VCuGVA51bodTg3fu7l2i5+tf
 U+NbnKTFdVrmdIcpJ5I20xQdvD5mlq1v5eU3gklWkm6QKeifD+MXbygZ
X-Gm-Gg: AY/fxX7Pv2VQ13XJQDGQu6TXTV8Fabj7N/9+8/zKHF3cN8K4glelH2CfJA7K5qTycpe
 nxakw76JKaVLW14xC2FJ5AYTKbnFGYsA2gBnU+lqjE42f9in2wWgLv9EVhJKNTyyA4GY1HQ2GJO
 KbgrnqN1EDSvZmdvHUtazqSmbrTNSRcdg0uk8f1sSH1T/Bg3vntVlO7TIOt8a53B/lRz06pR6kX
 E7+WN6LiOi2HG3+EmKNpFa6Sh92bDIJ3HZWBCYMWsVxkzb83f9t0mlpF59RvEsail/zu+Vn9BEH
 qXVGjAwds6IcAIpdEF0/qMxjMj0gDo9Gm0fn7bB4FYR58idd3x7YPvhH9SGXFYodpA3OLjp5sm8
 kPgrhtYpBLK9KdikHMlq4jFfEOBB/GK40Bjjn8GoarZ0yp+yxYV/gzX37BKtzONNqwkwbbbnrwA
 8bMKZWrOZZoakVffba22UOc2JxDE06
X-Received: by 2002:a17:902:f689:b0:2a0:f488:24e with SMTP id
 d9443c01a7336-2a7188f90damr10576435ad.28.1768527271460; 
 Thu, 15 Jan 2026 17:34:31 -0800 (PST)
Received: from [192.168.0.22] ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193fab79sm4931555ad.67.2026.01.15.17.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 17:34:30 -0800 (PST)
Message-ID: <9279c11c-dfb6-4233-a530-68ded75fcbc1@gmail.com>
Date: Fri, 16 Jan 2026 10:34:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/3] hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
Content-Language: ko
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
References: <cover.1768452598.git.jeuk20.kim@samsung.com>
 <a508208eda9711c8779ce4fbab28c98999e628d6.1768452598.git.jeuk20.kim@samsung.com>
 <be82b155-a61e-43f9-ba16-ae2c6d227087@linaro.org>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <be82b155-a61e-43f9-ba16-ae2c6d227087@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


On 1/16/2026 7:30 AM, Richard Henderson wrote:
> On 1/15/26 15:53, Jeuk Kim wrote:
>> The UFS spec defines the PRDT data byte count as an 18-bit field. This
>> commit masks the value to the lower 18 bits to prevent incorrect
>> transfer lengths and ensure compliance.
>>
>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> ---
>>   hw/ufs/ufs.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
>> index cab42ae7b6..4ee6755d82 100644
>> --- a/hw/ufs/ufs.c
>> +++ b/hw/ufs/ufs.c
>> @@ -224,7 +224,8 @@ static MemTxResult ufs_dma_read_prdt(UfsRequest 
>> *req)
>>         for (uint16_t i = 0; i < prdt_len; ++i) {
>>           hwaddr data_dma_addr = le64_to_cpu(prd_entries[i].addr);
>> -        uint32_t data_byte_count = le32_to_cpu(prd_entries[i].size) 
>> + 1;
>> +        uint32_t data_byte_count =
>> +            le32_to_cpu(prd_entries[i].size & 0x3ffff) + 1;
>>           qemu_sglist_add(req->sg, data_dma_addr, data_byte_count);
>>           req->data_len += data_byte_count;
>>       }
>
> This fails on a big-endian host:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/12725280508
>
> You need to move the mask outside of the le32_to_cpu.
>
>
> r~


Thanks for letting me know.

I’ll fix it and send an updated patch.


