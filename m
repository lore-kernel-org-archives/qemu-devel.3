Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267CDCFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAL9-0006QB-Bo; Sat, 05 Oct 2024 15:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAL7-0006Q2-MF
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:21:17 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAL6-0004Q8-2Z
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:21:17 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7e9ff6fb4c6so562733a12.3
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728156074; x=1728760874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+4tKvFiN/mMD4cJcaRR/iG3S3o2uVzmMa4butsf3pP4=;
 b=ju9gncKQUyqolX4VqXCm6si8O7NkyyddUTxnsWQcKu3oiDBRg+aWSHTz0rMlaJpoZ6
 u1ZwGflJwYORJMHrckpm+5Vq/xaWiU9yn0goEpHSPWc9Qfq876pbfDB9Fo5r7qqkCMMM
 3oo5J20Ut9oq6Gv1qBromhO2sIV1w6TdnoDyRENh58kNvGKw4kzuByNSlkWsKDuAp7Zu
 Q9TzzAebEqkqt+iADJkag3iC5DkwZiVlcyNQjHBfz3AwXkt0pgAmYku77X0JLhd4M8Yv
 jq0deop2MvZ2HvNrDulQTj/jGL+DW6tebHjTMprB6UrydoQJtGFbqpV1m1Z4mC1IIHu4
 psAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728156074; x=1728760874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+4tKvFiN/mMD4cJcaRR/iG3S3o2uVzmMa4butsf3pP4=;
 b=PQdLVRw7cn5IG0DUS22OmAZAQD3uTIRqqdzgw1LO8981zebNR9QSnZfnV/XlkkuJOz
 dZ03I+3DpxldMOeKAqAVs7frM0D9bh44onANFdfq76TL6FIxalM9njCTUOjcIOUqPDlL
 xR0tp1zMU5T+KOKebS5vvTbyACIP7mIrG7fpNWylShp+5jP++PGfmn1e0fppxpuPrhMA
 spTYO0XOsqgD3N4hB6bc24/PYLcxwHxJG59PyB/Qm02RP3QnB4uJ7XkXr5X44LRxOrC9
 xBjfZFVIWW05QuVvecOMXs74S9CXEl0zbHplJEN+7g9jk2XQIGhddcHhlwkaA8PVzl+v
 6E9Q==
X-Gm-Message-State: AOJu0Yzdr3pvx6S2fcFa/W92oUPsk08Qkki5kLM0+1pVD5lGSlB/vkC5
 KQqZ6KMBTagPfymupHofv1MHOvQB4hcHGVzVhhU0Iuc+MU+YtljyJI4NBn5OjLY=
X-Google-Smtp-Source: AGHT+IFK04BAjembx2vV1wTuQMeNrkTwpfqWbZbMwYKJtQDwrqDgncYmCgtuL/7luQ6C6yjDEtMQ6Q==
X-Received: by 2002:a05:6a20:d045:b0:1cf:1b7d:8481 with SMTP id
 adf61e73a8af0-1d6dfab6e03mr12098409637.32.1728156074254; 
 Sat, 05 Oct 2024 12:21:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d67c6dsm1845396b3a.178.2024.10.05.12.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 12:21:13 -0700 (PDT)
Message-ID: <f0be0fb5-d4b8-4949-a3bc-6496f9696bd8@linaro.org>
Date: Sat, 5 Oct 2024 12:21:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] gdbstub: Move phy_memory_mode to GDBSystemState
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <20240923162208.90745-3-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240923162208.90745-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 9/23/24 09:12, Ilya Leoshkevich wrote:
> Follow the convention that all the pieces of the global stub state must
> be inside a single struct.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   gdbstub/system.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index 1ad87fe7fdf..5ce357c6c2b 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -35,6 +35,7 @@
>   typedef struct {
>       CharBackend chr;
>       Chardev *mon_chr;
> +    int phy_memory_mode;
>   } GDBSystemState;

While you're at it, this should be a bool.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

>   
>   GDBSystemState gdbserver_system_state;
> @@ -445,14 +446,12 @@ void gdb_qemu_exit(int code)
>   /*
>    * Memory access
>    */
> -static int phy_memory_mode;
> -
>   int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
>                                  uint8_t *buf, int len, bool is_write)
>   {
>       CPUClass *cc;
>   
> -    if (phy_memory_mode) {
> +    if (gdbserver_system_state.phy_memory_mode) {
>           if (is_write) {
>               cpu_physical_memory_write(addr, buf, len);
>           } else {
> @@ -491,7 +490,8 @@ bool gdb_can_reverse(void)
>   void gdb_handle_query_qemu_phy_mem_mode(GArray *params,
>                                           void *ctx)
>   {
> -    g_string_printf(gdbserver_state.str_buf, "%d", phy_memory_mode);
> +    g_string_printf(gdbserver_state.str_buf, "%d",
> +                    gdbserver_system_state.phy_memory_mode);
>       gdb_put_strbuf();
>   }
>   
> @@ -503,9 +503,9 @@ void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *ctx)
>       }
>   
>       if (!gdb_get_cmd_param(params, 0)->val_ul) {
> -        phy_memory_mode = 0;
> +        gdbserver_system_state.phy_memory_mode = 0;
>       } else {
> -        phy_memory_mode = 1;
> +        gdbserver_system_state.phy_memory_mode = 1;
>       }
>       gdb_put_packet("OK");
>   }


