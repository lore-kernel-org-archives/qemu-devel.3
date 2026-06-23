Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351B8CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5O8-00077R-Tz; Tue, 23 Jun 2026 13:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc5O4-00075K-4t
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:58:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc5O2-0003MP-Ha
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:58:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2c6c57c5bcfso1401445ad.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782237493; x=1782842293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m6IWrhZJNYq6x4038TQAXR8G48lUi0rv/qq0/zDE44U=;
 b=jwzHMdiKqNDYLbtFxNPMeyiBWDs0QQn5wBG2lN26wHcpZmzN0g2ZRHZqUQvwmxqeDE
 R89XaWv4Md3vBZkmwheIn8X/lQJpyiwcAC7ygaPd+9n1+igyTv/tqNRw296jFjz5Fgyf
 MI36mDefvLeeMEF4c5MydUAqWI6u1uBTaC1Y54bPFxU1oYIsgjhtVAG68VlR9lK9pnl+
 hl3CgqF7geYWtgrttyFobt+51PahP3AZQRHtvmYFJ68bnJbPJvtitYuEd1aaZbzBJ/ml
 Ip8ggCLt1zusB1ICEh91IQoJMFLj/53wHLHflCD9t4ohpUUmTb6cfKWSWRYXFSbWXwjI
 1nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782237493; x=1782842293;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m6IWrhZJNYq6x4038TQAXR8G48lUi0rv/qq0/zDE44U=;
 b=sWRroEk9FIGSJa29DnvFv2OCmrTdN5D5ST+9CCmqrh69iUAYxm4XtrOghSwk3IXpXz
 RdXULKY51upbizTp/m2Z+XCA+ZL88PrwVKSwCAFgE2b9rkuxPMcBkcwjNrYvnwjMkHHU
 iyWqlARlZEcPR0P9hizjVEaIyBrwDJz7kaA7KR+qcomqJimQYzVXXTctaVllL1iIPegw
 IrLp+gyOFaDupYWdfVzcCyFXxKpRtmVTqLIJdiXQn5evgmtygZkCfRJMf7pE5LGMZ2AV
 89r66EqBG/LpUvrmlWbO81Heaqls99RfjCyRWjVCanUrhx6LP7UG60tTai0SC0YZm6On
 bnrg==
X-Gm-Message-State: AOJu0Yw0Umm9mT5OrG8eKjnofXhypcCtso7aPD8QrA5fg/bY2fzWkuNK
 hiIM+GMVyQL0jujlDnpsMhib4zYTZwz80xlBtQS/Iwni3Cd4LV/NLs9WR/BFHVVHaPfgYkCsYBs
 8NcMb
X-Gm-Gg: AfdE7cm5p1Qe93QjhcdiCOKm2JRSBM2vMMwyPvb5hy/o/IhDY2ZPZ8SQohDOM1gICLj
 B+KBZTPGsbxPoIGpUkrSWNoFDf2fbXYnpEUZ8eP7RcZU86jMfaUB9x2Dh831FQ/sHP82qKI+9IG
 JDrmY7Dd8nQdrlvJFv+UDoevqFckp8nFIduoqO92BggPrWQ7MxFEvmxJ9Pz6CWV4AmcoABLk8B6
 vEYMWSEPyKu1+naP8bn0BgUhrtLYaAoJvFAkBeY1CzceX7iI50EUGhXL4H2R2Tp2RN+m5b1e6ez
 yM+YLYIZBp/lpazdEHru1eQlkOZCr9Ru0105zrv0xpQ8pPoygMTlGhln35737UMULxOeiODaii7
 WsNMjA2ar7zAMxMnwmZYm9PMsHJEMUTmPyoO8FlBWX7VAwwM72SAhcO80R420V1fAGdSA6XsUZK
 MTCbT+tvOgY5kc/bF4eZIxkXoo0oRzm3ZkdFQIO4tqZgCAWlBsU+QMAR1wFg==
X-Received: by 2002:a17:902:ecc1:b0:2b0:608d:d8a8 with SMTP id
 d9443c01a7336-2c718cc4b81mr221222905ad.1.1782237492511; 
 Tue, 23 Jun 2026 10:58:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7439f85f1sm117500275ad.42.2026.06.23.10.58.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 10:58:12 -0700 (PDT)
Message-ID: <f6dccc6d-1cf0-4b28-a48b-c445d3c62094@linaro.org>
Date: Tue, 23 Jun 2026 10:58:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/40] bsd-user: catchup to locking / mapping routines
 in bsd-misc.
To: qemu-devel@nongnu.org
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
 <20260620-misc-2026q2-v3-1-f6ce23ad8dda@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260620-misc-2026q2-v3-1-f6ce23ad8dda@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/20/26 21:19, Warner Losh wrote:
> These were added to bsd-misc.c in a prior series. The declarations
> logically belong here, but aren't strictly needed with the current
> structure of the code due to include contamination.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/qemu-bsd.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
> index 756425d18e..f7c8338213 100644
> --- a/bsd-user/qemu-bsd.h
> +++ b/bsd-user/qemu-bsd.h
> @@ -32,6 +32,24 @@ int host_to_target_waitstatus(int status);
>   void h2g_rusage(const struct rusage *rusage,
>           struct target_freebsd_rusage *target_rusage);
>   
> +/* bsd-misc.c */
> +abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid);
> +
> +abi_long target_to_host_semarray(int semid, unsigned short **host_array,
> +        abi_ulong target_addr);
> +abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
> +        unsigned short **host_array);
> +
> +abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
> +        abi_ulong target_addr);
> +abi_long host_to_target_semid_ds(abi_ulong target_addr,
> +        struct semid_ds *host_sd);
> +
> +abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
> +        abi_ulong target_addr);
> +abi_long host_to_target_msqid_ds(abi_ulong target_addr,
> +        struct msqid_ds *host_md);
> +
>   /* bsd-mem.c */
>   void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
>           struct target_ipc_perm *target_ip);
> 

These are already present at the bottom of qemu-bsd.h.  Rebase error?


r~

