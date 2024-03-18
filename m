Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909EBC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmKHe-0003E0-8S; Mon, 18 Mar 2024 17:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmKHc-0003Dd-Lf
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:12:36 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmKHY-00016V-0e
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:12:36 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e0025ef1efso13808835ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 14:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710796350; x=1711401150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DSpRcfXXeNAsyspGA3LCbRbgZwe7YcIqg813WgHLL6s=;
 b=fJIV8BU5YBram6thuy6vyaisQJrsDQnjF7YALRlpebOTfv7TT0Y1cj0G9naMwQjffA
 yxuOf4WRoJ2k/JTd6cw9/G5P8PY/IrUaFOT7SSZ6dfKia4+fzUoP4KLKYdFIf8MNlJlo
 EmaeLxeVaLFXIDllmvEzFW3eeckttoG1PcPjLIkuvSksqgczjPiBWoqBc6IPEJ5+zNyu
 5qiaz3YYRCEZX8NLrEOx6lopaI5q7Zyt8Jlc9t+4yZB0AfHaEgVV6kyavMBbDMb3MoGY
 RW0S43j6aHLZT5NL4/9sVmFuAGXUdT1LxsENVF2XjA2R0qHcGI6uaRJQiDzpz18IK8UN
 TR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710796350; x=1711401150;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DSpRcfXXeNAsyspGA3LCbRbgZwe7YcIqg813WgHLL6s=;
 b=X9psUrmNL2vVMRhnexkQHaXWiyAthzuAJZNfOmIdAT9Judwaovu+NgjEEOwMhsT/2e
 ftbNRq0We3S09pEsczlMGNU2r8afeouukll/hh2u7LKWOvQNZYy4/n7ifoVC4BlZgiOv
 xPTb3Lz/vNoNkmMXQLuEcLgHD2Bow8lCTAuB4uB4tNv+aUlEArrHKedAVNfdPNzrukFh
 zQFFmIdl7Y4IUtlYiUrBnHnpCCGa0v/OIZEFdnxrBao3ShzQinOUX5TsFEV0+lNPzgM0
 JfK5b75aU+1QrhdKd3Jr2DbK5ip59znHHQeTfX/AMwi+Fu64h1FQIw5dlfNJY1IRBR9Q
 9M6g==
X-Gm-Message-State: AOJu0YwHP0D0LCPEcrrySTIGFww8RRZYgKZCpLy5CksEUbOnwS9tc4CZ
 fliWU+OwFTs1TXIIueLZsGBWO2oFUJHv7BctJr/W/clRL1AyhHS4vgzCMZqg8LY=
X-Google-Smtp-Source: AGHT+IEyswyvANj89TtikZOjnajyeYBHmN1Lnmw8N9f2MF9Qfy2C5OCSMgMkV2MuytxQ5W69eZTfXQ==
X-Received: by 2002:a17:902:ccd2:b0:1df:ff0a:70fe with SMTP id
 z18-20020a170902ccd200b001dfff0a70femr10082234ple.9.1710796350102; 
 Mon, 18 Mar 2024 14:12:30 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 l3-20020a170902f68300b001dd9090a37bsm7497830plg.197.2024.03.18.14.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 14:12:29 -0700 (PDT)
Message-ID: <1ac51271-1d1b-4623-bc56-0ceb920e7611@linaro.org>
Date: Mon, 18 Mar 2024 11:12:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] target/hppa: fix access_id check
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240317221431.251515-1-svens@stackframe.org>
 <20240317221431.251515-4-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240317221431.251515-4-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/17/24 12:14, Sven Schnelle wrote:
> +static bool match_prot_id(CPUHPPAState *env, uint32_t access_id, uint32_t *_pid)
> +{
> +    for (int i = 0; i < 8; i++) {
> +        uint32_t pid = get_pid(env, i);

There are only 4 pid's for pa1.x.

> +static uint32_t get_pid(CPUHPPAState *env, int num)
> +{
> +    const struct pid_map {
> +        int reg;
> +        bool shift;
> +    } *pid;
> +
> +    const struct pid_map pids64[] = {
> +        { .reg = 8,  .shift = true  },
> +        { .reg = 8,  .shift = false },
> +        { .reg = 9,  .shift = true  },
> +        { .reg = 9,  .shift = false },
> +        { .reg = 12, .shift = true  },
> +        { .reg = 12, .shift = false },
> +        { .reg = 13, .shift = true  },
> +        { .reg = 13, .shift = false }
> +    };
> +
> +    const struct pid_map pids32[] = {
> +        { .reg = 8,  .shift = false  },
> +        { .reg = 9,  .shift = false  },
> +        { .reg = 12, .shift = false  },
> +        { .reg = 13, .shift = false  },
> +    };
> +
> +    if (hppa_is_pa20(env)) {

This predicate is fairly expensive -- you don't want to put it deep inside a loop.
The table is very predictable.  Moreover, you don't need to test these in any particular 
order.

>          /* If bits [31:1] match, and bit 0 is set, suppress write.  */
> -        int match = ent->access_id * 2 + 1;
> -
> -        if (match == env->cr[CR_PID1] || match == env->cr[CR_PID2] ||
> -            match == env->cr[CR_PID3] || match == env->cr[CR_PID4]) {
> -            prot &= PAGE_READ | PAGE_EXEC;
> -            if (type == PAGE_WRITE) {
> -                ret = EXCP_DMPI;
> -                goto egress;
> +        uint32_t pid;
> +        if (match_prot_id(env, ent->access_id, &pid)) {
> +            if ((pid & 1) && (prot & PROT_WRITE)) {
> +                prot &= ~PROT_WRITE;
>              }
> +        } else {
> +            prot = 0;
>          }

You're losing the data memory protection id trap.

Therefore I suggest

/* Return the set of protections allowed by a PID match. */
static int match_prot_id_1(uint32_t access_id, uint32_t prot_id)
{
     if (((access_id ^ (prot_id >> 1) & ACCESS_ID_MASK) == 0) {
         return (prot_id & 1
                 ? PROT_EXEC | PROT_READ
                 : PROT_EXEC | PROT_READ | PROT_WRITE);
     }
     return 0;
}

static int match_prot_id32(CPUHPPAState *env, uint32_t access_id)
{
     int r, i;
     for (i = CR_PID1; i <= CR_PID4; ++i) {
         r = match_prot_id_1(access_id, env->cr[i]);
         if (r) {
             return r;
         }
     }
     return 0;
}

static int match_prot_id64(CPUHPPAState *env, uint32_t access_id)
{
     int r, i;
     for (i = CR_PID1; i <= CR_PID4; ++i) {
         r = match_prot_id_1(access_id, env->cr[i]);
         if (r) {
             return r;
         }
         r = match_prot_id_1(access_id, env->cr[i] >> 32);
         if (r) {
             return r;
         }
     }
     return 0;
}

---

     if (ent->access_id && MMU_IDX_TO_P(mmu_idx)) {
         int access_prot = (hppa_is_pa20(env)
                            ? match_prot_id64(env, ent->access_id)
                            : match_prot_id32(env, ent->access_id));
         if (prot & ~access_prot) {
             ret = EXCP_DMPI;
             goto egress;
         }
     }

At this point there are now a couple of hppa_is_pa20() calls within 
hppa_get_physical_address, which could be unified to a single local bool.


r~

