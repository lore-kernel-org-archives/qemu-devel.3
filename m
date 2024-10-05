Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D6CCFB420
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 17:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx91m-0004Bu-Qg; Sat, 05 Oct 2024 13:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx91l-0004BU-HR
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 13:57:13 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx91i-00078w-F2
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 13:57:13 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7d666fb3fb9so1789365a12.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728151027; x=1728755827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oH6qFnpsyq1vZoA/TFNAdu4px6DufCXgtvDbE23CtPE=;
 b=X/tB4zqcn88xIhi4yBXgHGCtSCzlllx2HkgBjmmNyMn4YgXBBDZgJbTAg2ojKQO7s7
 9FK6lrM191aIyQq65qO33qnUfmeFNgVmgi2WxYlfu/M3QlZXeb+/2fefT0/itytKW+kf
 KW7MbxB8GV2PM3Ko1UQmrG1SdREkKBoBrF4pFROYc/89a+paCLu6sv3FzgCXW+XLtEE4
 pfPGET2G8Nm0MkRUDPuvbYFt4mBHZ1+7WtzuiNt5kLkjljqdeXMzDSF3cOBu/3sWoic9
 0fsCj+SziAQnY82juXxfV4hCdzyr8Mky2ebRGgXGLd1peeH/y524YgmAJV8PcqJ0Qq5J
 4yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728151027; x=1728755827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oH6qFnpsyq1vZoA/TFNAdu4px6DufCXgtvDbE23CtPE=;
 b=i/kMHo4VkhcZJjiMh6HoWJ9+GsJp/jglMIvugmn+S+w9RWCq5oPKW4Mmr56xqSlZRd
 oFASrJHIaQw2Cl0NJXBpTydFWOacFbXWKBkwa4fhJKZSy9u4ZANUwaNQyKieqnHxwBpz
 u2wcqjrk6K5BX8w6yhmwgN4d3bwtRiLk0yIm8L1bq5YPeEd49aYrH3XxNg0ccAfEqeiJ
 lWI9aGI5gSba0YHx9y+p2q0Rxgv/ESPg7jkCKMLi9vSIYqD1+r1w8BeYVOZ4zc1MgykU
 ncMxazHHB1slRknF2UCBy5pAewnoQDnQHuAzaudIksh/Fd7RCHCB0wGTiNiHi0z0/M2W
 GWyQ==
X-Gm-Message-State: AOJu0YxpHKZLw0tPhsxOLsG2QnXNV0rbfAz08LYCRrYTQ5K181UY9gHn
 Z0ttnYyWGsY/e9/2ePYNRpf4p77GZUMH/zFk3Hib5IjTrLVdJog6wRqBElHN428zAhVny/PxMLT
 S
X-Google-Smtp-Source: AGHT+IEljhaNme4gCLe2lUi4WZhFrFaHJLn0B2Fxaw7XHSxiJJaVqskrGKtjqmlm0Q/t1ia9m+fuJg==
X-Received: by 2002:a05:6a21:a4c1:b0:1c8:de01:e7e5 with SMTP id
 adf61e73a8af0-1d6e02db711mr9366231637.15.1728151027356; 
 Sat, 05 Oct 2024 10:57:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d66410sm1789194b3a.145.2024.10.05.10.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 10:57:06 -0700 (PDT)
Message-ID: <cb4ccc1a-cb6c-4c1c-bc46-2ec81543e6da@linaro.org>
Date: Sat, 5 Oct 2024 10:57:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Trace wait4()'s and waitpid()'s wstatus
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
References: <20241001193244.14939-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241001193244.14939-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 10/1/24 12:32, Ilya Leoshkevich wrote:
> Borrow the code for formatting the most frequent WIFEXITED() and
> WIFSIGNALED() special cases from from the strace's printstatus().
> 
> Output examples:
> 
>      474729 wait4(-1,0x7f00767ff0a0,0,(nil)) = 474733 (wstatus={WIFEXITED(s) && WEXITSTATUS(s) == 1})
>      475833 wait4(-1,0x7f7de61ff0a0,0,(nil)) = 475837 (wstatus={WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL})
>      1168 waitpid(1171,0x7f44eea00340,0) = 1171 (wstatus={WIFSIGNALED(s) && WTERMSIG(s) == SIGKILL})
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/strace.c    | 61 ++++++++++++++++++++++++++++++++++++++++++
>   linux-user/strace.list |  6 +++--
>   2 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index b4d1098170e..d5d1f18304d 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -4168,6 +4168,67 @@ print_ioctl(CPUArchState *cpu_env, const struct syscallname *name,
>   }
>   #endif
>   
> +#if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
> +static void print_wstatus(int wstatus)
> +{
> +    if (WIFSIGNALED(wstatus)) {
> +        qemu_log("{WIFSIGNALED(s) && WTERMSIG(s) == ");
> +        print_signal(WTERMSIG(wstatus), 1);
> +        if (WCOREDUMP(wstatus)) {
> +            qemu_log(" && WCOREDUMP(s)");
> +        }
> +        qemu_log("}");
> +    } else if (WIFEXITED(wstatus)) {
> +        qemu_log("{WIFEXITED(s) && WEXITSTATUS(s) == %d}",
> +                 WEXITSTATUS(wstatus));
> +    } else {
> +        print_number(wstatus, 1);
> +    }
> +}
> +
> +static void print_ret_wstatus(abi_long ret, abi_long wstatus_addr)
> +{
> +    if (!print_syscall_err(ret)) {
> +        qemu_log(TARGET_ABI_FMT_ld " (wstatus=", ret);
> +        if (wstatus_addr == 0) {
> +            qemu_log("NULL");

I think you could merge the == 0 check into the outer IF, and avoid printing the returned 
wstatus entirely.

Otherwise
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

