Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F71C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 10:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tetrt-0005iN-Qz; Mon, 03 Feb 2025 05:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetrr-0005i8-DN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 05:39:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetrp-0000Z6-Rz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 05:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738579188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aZ405fYaKC2uzL2YkiH+Q6rW+6MMeta4RnE0eEGWVHw=;
 b=a3DB8rLkEhgdSK6DwncudRQQ+/J9nqUOT2mdvIy5FQeb9+diY+sUqnHAp39gGD5xrTqMe4
 3vdaBvzjIpaV7ihsFH+/2gOTeEy9sGhm5Gf3VNPq/wSCfMXJr9eDyHFllhGwRNAo/VFjYm
 gl0gTlpzOU2Nkv+IwHRSbkL3N5mK3uY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-40RS60gaO123G1tl14fFbA-1; Mon, 03 Feb 2025 05:39:46 -0500
X-MC-Unique: 40RS60gaO123G1tl14fFbA-1
X-Mimecast-MFC-AGG-ID: 40RS60gaO123G1tl14fFbA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-438e180821aso21665905e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 02:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738579186; x=1739183986;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aZ405fYaKC2uzL2YkiH+Q6rW+6MMeta4RnE0eEGWVHw=;
 b=TxTsve/0mTEOdkH0SRYLZ+1uVeCPcDWumgCGxw5+r6vvjixNzofUinw+70wt/sPA2w
 uzfiSLopAY1HuUcfOXoy7wuwjv0ZP0nh3RFUAXxhwxJaBDQfhrC+itVRWil4aFdivKkM
 V5Et+30XHtMcrkPtwy+Zci3lTE9mMFZws8clXMt32kDJBtqjcI3rXPp8sOvyOn670wBa
 vVxrcxmFNYVuhmFdjxuASrj4n05T3Cux6kw7kDDHCCZbqjTfUjvRqWkQJH4bhgEPxtKP
 whUyHV7ptSR7NG8ClR+gpD5yW88Sx+2ZJ88A2rH+PrmC7qaFeMVcUfRiwv21z9tDogy8
 6esw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPK5EPldlfX7/S/I819/+/oSAk1oMOTQh8XOa5UWkLSxmlBDxmbrRc15QcE+CuAmfFPqatV5ZRErcJ@nongnu.org
X-Gm-Message-State: AOJu0Yz0bqXi9uGlDGp669Ao6CWwVWbX2a/HC8B2umEGVcZzlHBxZ8WD
 2NXwR6G3ESIcKFqW2Dktqlzw179ma81qnCFxW+wA7OQDZTLL1zpFfqVuysFp4GXYZGsQqjb0A2o
 XsjRTjht9hlcrzlf+HIfUkYa0MtkDG/iIGSmlmwNV8ZRymNHRoG3d
X-Gm-Gg: ASbGncuXGluc1sYY1jVq/8aerzI9TrXzhDAnq2xfZfCNE3qgsDS2sbd3V2swwub3OUx
 2hPXwxYC5XpferNsf8Gq0gZDQ+ynmkic1/WZZV11Rluq7f0VLn+q9UHe4HM9+WYgqNYus4bjG8N
 LY2YZHckUyzwtQcReT7wv4dvA2p7mS2v7o1cn26iY00hkCKw4rNvb20PGltdHeDHDwEpS41NS3T
 Q6QkfY0UAj4iL9uI9TE9Riv0HM90G5MQ1ZO+MLB3u3El0tjWlTwezb0LA3PuiZKs190s2KsUDpt
 qYgnbq23Tm5FyQUNGx1MyEjCiUjYzA==
X-Received: by 2002:a05:600c:1e1b:b0:434:f5c0:328d with SMTP id
 5b1f17b1804b1-438dc40ffcfmr173837295e9.23.1738579185821; 
 Mon, 03 Feb 2025 02:39:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETCcfjRguPQ6yNtWADsAj4j0Iyr15+ZVOCQ9JvRYxOkxmHCwxBT/f2uy4XlOZz/X7gE08llA==
X-Received: by 2002:a05:600c:1e1b:b0:434:f5c0:328d with SMTP id
 5b1f17b1804b1-438dc40ffcfmr173837105e9.23.1738579185467; 
 Mon, 03 Feb 2025 02:39:45 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c13a0efsm12509977f8f.60.2025.02.03.02.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 02:39:45 -0800 (PST)
Message-ID: <47d703f2-bee2-4ee1-af13-624f6f0e7ee1@redhat.com>
Date: Mon, 3 Feb 2025 11:39:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] configure: Define TARGET_LONG_BITS in
 configs/targets/*.mak
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-11-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250203031821.741477-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/02/2025 04.18, Richard Henderson wrote:
> Define TARGET_LONG_BITS in each target's configure fragment.
> Do this without removing the define in target/*/cpu-param.h
> so that errors are caught like so:
> 
> In file included from .../src/include/exec/cpu-defs.h:26,
>                   from ../src/target/hppa/cpu.h:24,
>                   from ../src/linux-user/qemu.h:4,
>                   from ../src/linux-user/hppa/cpu_loop.c:21:
> ../src/target/hppa/cpu-param.h:11: error: "TARGET_LONG_BITS" redefined [-Werror]
>     11 | #define TARGET_LONG_BITS              64
>        |
> In file included from .../src/include/qemu/osdep.h:36,
>                   from ../src/linux-user/hppa/cpu_loop.c:20:
> ./hppa-linux-user-config-target.h:32: note: this is the location of the previous definition
>     32 | #define TARGET_LONG_BITS 32
>        |
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
[...]> diff --git a/configs/targets/hppa-linux-user.mak 
b/configs/targets/hppa-linux-user.mak
> index 8e0a80492f..4295cf384e 100644
> --- a/configs/targets/hppa-linux-user.mak
> +++ b/configs/targets/hppa-linux-user.mak
> @@ -3,3 +3,5 @@ TARGET_ABI32=y
>   TARGET_SYSTBL_ABI=common,32
>   TARGET_SYSTBL=syscall.tbl
>   TARGET_BIG_ENDIAN=y
> +# Compromise to ease maintainence vs system mode

s/maintainence/maintenance/

> diff --git a/configs/targets/mipsn32-linux-user.mak b/configs/targets/mipsn32-linux-user.mak
> index 206095da64..39ae214633 100644
> --- a/configs/targets/mipsn32-linux-user.mak
> +++ b/configs/targets/mipsn32-linux-user.mak
> @@ -5,3 +5,4 @@ TARGET_BASE_ARCH=mips
>   TARGET_SYSTBL_ABI=n32
>   TARGET_SYSTBL=syscall_n32.tbl
>   TARGET_BIG_ENDIAN=y
> +TARGET_LONG_BITS=64

Why is this 64 ?

> diff --git a/configs/targets/mipsn32el-linux-user.mak b/configs/targets/mipsn32el-linux-user.mak
> index ca2a3ed753..d9b61d6990 100644
> --- a/configs/targets/mipsn32el-linux-user.mak
> +++ b/configs/targets/mipsn32el-linux-user.mak
> @@ -4,3 +4,4 @@ TARGET_ABI32=y
>   TARGET_BASE_ARCH=mips
>   TARGET_SYSTBL_ABI=n32
>   TARGET_SYSTBL=syscall_n32.tbl
> +TARGET_LONG_BITS=64

dito?

> diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus-linux-user.mak
> index 6cc8fa516b..7a16934fd1 100644
> --- a/configs/targets/sparc32plus-linux-user.mak
> +++ b/configs/targets/sparc32plus-linux-user.mak
> @@ -5,3 +5,4 @@ TARGET_ABI_DIR=sparc
>   TARGET_SYSTBL_ABI=common,32
>   TARGET_SYSTBL=syscall.tbl
>   TARGET_BIG_ENDIAN=y
> +TARGET_LONG_BITS=64

Same question here: Why 64? If this isn't a mistake, could you maybe add a 
comment?

  Thanks,
   Thomas


