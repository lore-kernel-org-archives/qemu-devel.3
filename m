Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA95C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Wq4-0000XA-SE; Thu, 02 May 2024 09:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s2Wpu-0000Th-DI
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:51:03 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s2Wpr-0002O1-DI
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:50:56 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a58ebdd8b64so673269866b.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714657853; x=1715262653; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ADYzzK7sfQhc2Nsz3fX7168QnixktK27LoNnMXAIJPA=;
 b=nxwvLwNGIGvhyUPeB/jN9Jof6SjKUdqpcDxKOVydjr78hd3TutKAaKyJYeQZO2lTyC
 9qogtIYjIZju7L3oX93ShFBTcYbDul7ujFmmEmIK3KkHsXjScGfvl+VGRkcsPkPl0Vqf
 c7QiHqvX1Nmax91s92985vShLCVg6AIgj4T9rxYQzfT9gvX9W+UD1143TofGMjNd5TLJ
 nUz9+CvYaHw3MxNKSW1gttPkS+f72u/NFOyPN4TvNoVfvjCD4LDNX7a4nxk8q5OhhSeZ
 8JHpWX6XTLmHSNFlm5BQ+XIMSNW/Zyi6QB/6kZM3ETP2akNB1AIy088mlICVyT0IMhtI
 2khQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714657853; x=1715262653;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ADYzzK7sfQhc2Nsz3fX7168QnixktK27LoNnMXAIJPA=;
 b=E7s2K+dbXLDusFoVv0P3345WWOQwBPTnRlOAAF6y428XrpNEK19ZB7HIbEY9h1Kkhe
 DPCrK0SwakwHCzTvkscpSFEOt4ZwHNbtx6XUs4CVAlSQiKl7IqivubfprCKFhcw4PpUz
 5iD26A9dftDAYR009U78Sc+9rumb7gCLaWNyVlDdnGn+n2Us47cEXJe/N/zhgEwaW0hg
 AY4AwcZ1iq8cRyHh/j2AmGpsT9ji1FbV5HxyrLxTVL2tWATdv1OjvcmOoEfOJVCw5f5w
 B6Gv6AAZ29BG/MCHkMeARyUiuaX4jkSZBWuLb0uj6+oP8nLFI6+KqWJoRi31T8SLAHdA
 auOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9TFTOygv45fyUAEkYC8kUTKZAbkVa2EWs5H5hhraJL0SyNfvnC1W8sqMUcltTtF/zsCUy4Y6lM1MsswyhyIuAjog6V/4=
X-Gm-Message-State: AOJu0YzKSFSh5wyOJqCJmyIjmwHzR8E4KtLdd6dWWoDKD9VpUShIgZo2
 dG/sSDzgLTSo15yOs8/XKTUTlAZWqWpEqhy5aIOLxTo0JZawwd3RacezI6hgPws=
X-Google-Smtp-Source: AGHT+IFB1rnuS5QAmnIHOSyBb9Ljp483G4l3pHNEH0rXn3o/KPRc1qJO6Qs75P1CNh4xSlrVT2++1Q==
X-Received: by 2002:a17:906:c10b:b0:a59:5592:37cf with SMTP id
 do11-20020a170906c10b00b00a59559237cfmr3721999ejc.5.1714657852800; 
 Thu, 02 May 2024 06:50:52 -0700 (PDT)
Received: from [192.168.200.106] (83.11.37.15.ipv4.supernova.orange.pl.
 [83.11.37.15]) by smtp.gmail.com with ESMTPSA id
 p25-20020a170906141900b00a55a5384986sm585494ejc.24.2024.05.02.06.50.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 06:50:52 -0700 (PDT)
Message-ID: <88e97ffd-f308-49db-aba6-ea3b9c308d21@linaro.org>
Date: Thu, 2 May 2024 15:50:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <7c6f66bf-2610-494c-9389-b558a11f8c5f@linaro.org>
 <CAFfO_h6-RXettxqnCYciDrq6ivsTHtM55FcksJSUNnLdbio4mg@mail.gmail.com>
 <c696603d-b8dc-4fed-96f0-da40c6ce8287@linaro.org>
 <CAFEAcA__6PJwdYLTuGbf01YOaV4t67dtRtbAbnP1eL7dd0YH0g@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <CAFEAcA__6PJwdYLTuGbf01YOaV4t67dtRtbAbnP1eL7dd0YH0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x633.google.com
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

W dniu 2.05.2024 o 15:13, Peter Maydell pisze:
> On Thu, 2 May 2024 at 14:11, Marcin Juszkiewicz
> <marcin.juszkiewicz@linaro.org> wrote:
>>
>> W dniu 2.05.2024 o 15:04, Dorjoy Chowdhury pisze:
>>>> Should "return" also have "(1 << 24) |" to have MT=1 set?
>>>>
>>>> Otherwise MPIDR_EL1 = 0x000100 can mean core0 in cluster1 or core1 in
>>>> cluster0.
>>>>
>>>> Value 0x1000100 shows MT=1 so thread0 in core1 in cluster0.
>>
>>> I don't know all the details but from what I understand the
>>> "arm_build_mp_afiinity" is used to set the "mp_affinity" member
>>> variable which I assume is about affinity, not the whole MPIDR
>>> register value. That is what I assumed because the Uniprocessor
>>> indication bit(30) is being set only in the "mpidr_read_val" function.
>>> In the patch, the MT bit is also being set in the "mpidr_read_val"
>>> function based on the SMT status (has_smt) of the CPU.
>>
>> mpidr_read_val() is used only to set VMPIDR and VMPIDR_EL2 registers.
>>
>> So setting MT bit for MPIDR_EL1 needs to be added somewhere.
> 
> The readfn for MPIDR_EL1 is mpidr_read(), which calls
> mpidr_read_val().

My mistake.

Both hw/arm/sbsa-ref.c and hw/arm/virt.c build cpu information in 
DeviceTree using "arm_build_mp_afinnity()" function. So if firmware 
parses it then it gets wrong values.

Firmware should probably read MPIDR_EL1 directly instead but what with 
those who read DT and rely on this value already?


