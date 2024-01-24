Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0471C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 01:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSSQ0-0002u8-Tq; Tue, 23 Jan 2024 20:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSSQ0-0002u0-A1
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:51:08 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSSPx-0006uM-8B
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:51:07 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d71cb97937so30059265ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 17:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706061063; x=1706665863; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jcyblh6lesa2++Oaey8QhwobyOMPL9wprPiqAR+KcEw=;
 b=KTEMeF9SnPnCy0+U1muu+kGEmruy317Cu4/9VJJGTHNyrAq2QHGH/EcgoZGXa2GrNZ
 3BLgCTbY0vxBFO1dp0spIMEn5rDuf/mrFqn3hMQK89dXQVRhWiUhdeCh6wR1s2kOrRSL
 6/96DSNQhoYAtHrqy3Hs4qhMeI2tc1l5IfdlmUaQHTxuB2edWQAHcNqaxPBcSHLxzD1Q
 +jwJvZT0iIlPuIwB58mOBy/PVUihs8BT5QOEAhwVcdHl7lTGvyM7ys68MBZbqfWoILR7
 PRqlvfUsljppLf7Dxkv2FXRPK3MQ5ZpRUZ9V5zOSGctvP503MurVgc8GdNglNF7pOl1r
 Fq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706061063; x=1706665863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jcyblh6lesa2++Oaey8QhwobyOMPL9wprPiqAR+KcEw=;
 b=aUsBuvzNm/HMybQH6hhET0e2IlE2A+1Tu2x9g1XGNTzKPOR7Mnof9TjOMCRFP0bekP
 0rSwZzdrNFjEasGgbUFkDFvrTLPHAHYzlFs3Ds1oGP+rGrMsW9D5Rrs9yYmwi3SJ+W1u
 rQ113k7PpdCUUj9wKaPxSXYXZ/XlzYXRD/bjVurseisYKMJYj8oRFO+yr8J0zzUrSvq4
 vxOsq+1sueuVSTkM1PZn1YAjWkmsagSa5t9vqhDuREmTqTZhh4ndOEvmw7l0BvXVLP9y
 oYKSrz4Qd16a1so4vw/0Rme+qa+Al5pNawCqvJNFMDIW61WUBROePjMXFyxUFNEN6AG4
 N9Hw==
X-Gm-Message-State: AOJu0YxUsw22CXrl+B+mTFDOcz2bjMwMTg3sD/1CnzY6doM0oXtWxsJx
 B4jdXS9srQlLBYs4YdjeEWG20tO7FOlWyB3+ZUWZCQlDcflBe1LX2jDPmtoAScQ=
X-Google-Smtp-Source: AGHT+IEZs6Jgc+TsAzm2ORWBYWkeFTyP0555EByvjGKnrwXLHP4rudUrO/Upqd8b+HvzbvSHLyfgDA==
X-Received: by 2002:a17:902:b587:b0:1d5:e89a:cd9f with SMTP id
 a7-20020a170902b58700b001d5e89acd9fmr51509pls.139.1706061063343; 
 Tue, 23 Jan 2024 17:51:03 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a170903124800b001d60a70809bsm9421430plh.168.2024.01.23.17.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 17:51:02 -0800 (PST)
Message-ID: <c35ef7c6-81fc-44e4-b148-9e98d80af397@linaro.org>
Date: Wed, 24 Jan 2024 11:50:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 23/34] tcg: [CPUTLB] Add `mo_te` field to TCGContext
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-24-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-24-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> Required by cpu_ldub_code() and friends in cputlb.c to access the MO_TE
> MemOp in a target-independent way.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/tcg/tcg.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 7743868dc9..4ca626aeae 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -489,6 +489,7 @@ struct TCGContext {
>       TCGType addr_type;            /* TCG_TYPE_I32 or TCG_TYPE_I64 */
>   
>   #ifdef CONFIG_SOFTMMU
> +    MemOp mo_te;
>       int page_mask;
>       uint8_t page_bits;
>       uint8_t tlb_dyn_max_bits;

Not the correct scope for this.


r~

