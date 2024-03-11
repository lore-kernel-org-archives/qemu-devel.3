Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEA2C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjb3o-0004Jq-S2; Mon, 11 Mar 2024 04:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjb3n-0004JY-B5
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:31:03 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjb3k-0000zr-Ps
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:31:02 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d27184197cso52342671fa.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710145858; x=1710750658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3A42ECrV9B34yammF+tL7LjRnFZFf85HtSpY5wcN7FA=;
 b=GNrwZcGur/PGSag9TYoBdxGFtjXByMIz+w1SBssqrZmZLogP1rdg2pNLlF3eMPTxmw
 1lgdgufhV5TBLT112I409WzybX0XT95D23xR5fvfJPeEkN1mtBOxu2WrRvXPXSJb1Y4e
 Eb6otxPkZNft3x8g98HnmS9H/8pELEc3NLqiKOYaMmqUiWJ+3PFIDAaqbmr2iIKJrCs1
 olUYKplVeUqXK7CKqw9UyRgtqEZ+UtoCL2RLLU5tIEZqMo93g7vElBvtPX+BzCgEAAVn
 RpCojUiQY1j9zi0z0eTCwpqBQ8rhNbLsOMvGMIaIdpYwZLV6cmL1u6wK0JvfAMKwbqm9
 njhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710145858; x=1710750658;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3A42ECrV9B34yammF+tL7LjRnFZFf85HtSpY5wcN7FA=;
 b=TWgq6bWLDAVN6LqG/SXQtnNVY09+XOTfjt0pSb2kCxQ6sV4JpqY5qdj2/lHghnz8pH
 INQ4ImyxLQmfZuLFvTq5JOhFRMqytST32oL81JxVPdlmp59F2N2x2bccXI3MD4Z/WcGN
 iPYiBwNzPfLZGok6dpuJo18eLDIacjt2pXXjuanCQiswBALn0FlCRgFFDGLf4OXVMM8f
 eEQieKw1mVmFGBRUhOYKGeA7A0e54uR8xig45XKn8VdV021DCRc+fgrawr1rEHubN5H3
 NhN50yH6ldaMueB7jDWrD162i3rlm1mIATdVYv34ikzfl3CxZnsbalSMNeQQi40/VflK
 7gfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4la+6dWIpt8Mj0DTEAGcrBoMf/FvYSDfZxVjpvLyKJBX9zRYo5VPbPf+bK38EOxRbkeIpNc6XNNU/AkD51DWqyR4f2kw=
X-Gm-Message-State: AOJu0YylagFcuhJDdc+y2cEdJw+rBoXtxzwPXBLZGh4ZndYhlCi2HKRl
 PQ/xVZoYNgV4DAy78jQdSwtRuH5ZQYg8qUXykGdHYPuamXo9cjFeFd4Hw3RBmUk=
X-Google-Smtp-Source: AGHT+IEtBzjjAKp2j8yYp1RZl6yzFkmgbzOLhiu6WlQK/7IU6hSYDVD1ZYgmScBZVnlSoHCSM9fXMQ==
X-Received: by 2002:a2e:7a19:0:b0:2d2:ef14:593e with SMTP id
 v25-20020a2e7a19000000b002d2ef14593emr3464669ljc.48.1710145858428; 
 Mon, 11 Mar 2024 01:30:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 ay4-20020a05600c1e0400b004132ba7fce4sm1408267wmb.48.2024.03.11.01.30.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 01:30:57 -0700 (PDT)
Message-ID: <717cd4bd-bea7-4997-9be8-d585d8e8f9b3@linaro.org>
Date: Mon, 11 Mar 2024 09:30:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/plugins: fix use-after-free bug
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20240311081619.669832-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311081619.669832-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

On 11/3/24 09:16, Paolo Bonzini wrote:
> rec->count.score is inside rec, which is freed before rec->count.score is.
> Reorder the instructions
> 
> Reported by Coverity as CID 1539967.
> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   contrib/plugins/howvec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
> index 2d10c87e0fb..94bbc53820a 100644
> --- a/contrib/plugins/howvec.c
> +++ b/contrib/plugins/howvec.c
> @@ -167,9 +167,9 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
>   static void free_record(gpointer data)
>   {
>       InsnExecCount *rec = (InsnExecCount *) data;
> +    qemu_plugin_scoreboard_free(rec->count.score);
>       g_free(rec->insn);
>       g_free(rec);
> -    qemu_plugin_scoreboard_free(rec->count.score);
>   }
>   
>   static void plugin_exit(qemu_plugin_id_t id, void *p)

Actually Pierrick sent the same:
https://lore.kernel.org/qemu-devel/20240311060456.218190-1-pierrick.bouvier@linaro.org/

