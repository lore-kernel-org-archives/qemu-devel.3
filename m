Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCF6C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 16:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s41S2-00027t-Sm; Mon, 06 May 2024 12:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s41S1-00027c-Ki
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:44:29 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s41S0-0002p6-34
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:44:29 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2b3c1ea9a68so1361648a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715013866; x=1715618666; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TKnVpzlGUfaJivEclnatDx05HM4aFa8QFfDTGGOHKt8=;
 b=x0wUdJN+x0OTkAxQOwncmctWtZZUalKhGrd62ZiNwBTzk4MQF6wPZl4a5/U58bJmc7
 R226rbbc7BtKEJ5V9MITXRQCrG8x2aEdLaHAFyX6spcxz9gxR76865GvZezPibT12bH3
 2Zb2I3wyn9wAYCqzmaqm2SSg87GtSfJRUBWt8yz6pozXQ3Mo9lfpfCWcnpJpoSXrGVJD
 PflujVSk+l66q1gcnMHzA+HdY9T76MCOAxxf0JjH8pe+oWFz9O+mnq3iRKQ9JwN+UwOd
 Y2gv57S+guve0N/c++ygpdM4w/Qfya8oTcTyzdi76pDwfgm1OTXtMD0gpVa78modx09r
 fCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715013866; x=1715618666;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TKnVpzlGUfaJivEclnatDx05HM4aFa8QFfDTGGOHKt8=;
 b=NmPNKW+z6kefIxHz+a2jDnoceBAioGYNRqfqRwUYTQb2Enw14g00T+1oDb7DSZBndk
 HcUIpgPZ/lBRr0fEQyg0P/7PFsP7fhaRLvkFWzxjpzigTxKtGJOliFYwhRb8K9D1ibhF
 AMSTKXQmVFTl5iWAoJ97u4SVYkfav5VSisnWdjM8njFcGWh7h/gelu28RaX/FZ7DT7RD
 pocsIaqsAs6bnqj5KKrzegaPb4WlaKiNftDkndw5JbVsi+RpdCVs/P58b5C+DGZqRgsm
 dHfM9ZRE77x6L3bcm0UZvBqRoc1PLZ29d0aidF0vd6avfu+/wduGXrAkOKjaP8oExYUi
 lwxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjpUickcjOPeeQwBZbjYaP34Q2Bf7sHBrrAI027n2gDhJ6s86P970rKfa7fEKMyi/oae9OYTW+h86AdsTQW5zlNhpZxxA=
X-Gm-Message-State: AOJu0YyRgN+k9c+UmEeOkpWpioskTkeIz7drboSibfrgCnZ63UVSME/E
 5k4q36Df2orTU+6IaOej2eN5FMsTyLm68PyPIsm82bHbaVnbEqL0lXhx98guk4w=
X-Google-Smtp-Source: AGHT+IHX+NJVYoXJ02QIOhij1fb8KvA1VWvvscyVANmKB12YzyQEImHkqNNeDtF3ftA79Smn/Efz4g==
X-Received: by 2002:a17:90b:b18:b0:2b4:5ea3:f681 with SMTP id
 98e67ed59e1d1-2b5bbc385ffmr284721a91.10.1715013865701; 
 Mon, 06 May 2024 09:44:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 cz16-20020a17090ad45000b002b206acbbb3sm10263508pjb.30.2024.05.06.09.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 09:44:25 -0700 (PDT)
Message-ID: <da1e4b31-4d96-4fe2-90e8-a1d5a26be0f3@linaro.org>
Date: Mon, 6 May 2024 09:44:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/25] target/i386: move 60-BF opcodes to new decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20240506080957.10005-1-pbonzini@redhat.com>
 <20240506080957.10005-16-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506080957.10005-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 5/6/24 01:09, Paolo Bonzini wrote:
> Compared to the old decoder, the main differences in translation
> are for the little-used ARPL instruction.  IMUL is adjusted a bit
> to share more code to produce flags, but is otherwise very similar.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +static void gen_POPA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
> +{
> +   gen_popa(s);
> +}
...
> +static void gen_PUSHA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
> +{
> +   gen_pusha(s);
> +}

3-space indent?


r~

