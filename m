Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D8ACCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95n6-0002tU-Ln; Wed, 15 Oct 2025 14:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95n4-0002s4-81
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:59:58 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95mt-0005ji-8q
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:59:56 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-471075c0a18so7875815e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551182; x=1761155982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tBe+842uOTZCnkRahMzCWf3vP/Ks4xTfLKxqVUc11G4=;
 b=zJ3+lqw++wsfK6sIU83ql097B4IBchs4dR1gINq+vidOKlm/Q4CwK+PYR66iNi1cbq
 v9dKK2lznWsgolk6/RwbUMd4w+o2c+gNw4II6orLe8MT9eJQxotY3Lcd6M/BdLVbCeA9
 NO3O6nMplI8UTlz++r81xS6u+k4cqIw6w+Qm1Q88gaV3dlYpkeAT8BD/vkyj2J5UYyuB
 v//XhlL42F2yNs9MWkEsxPGyiE7xwwfcHuodHsuzHUfK6OB2iUpCQNw6RHuJRSpcgzHO
 WTDSrCeEzeZblWPod2ba2LjCNpbjqs1BaC8pPUNx2yHz+wyEsNPNGvBj430jdpxXjYSS
 9KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551182; x=1761155982;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tBe+842uOTZCnkRahMzCWf3vP/Ks4xTfLKxqVUc11G4=;
 b=FmKpMWpQpAP+zNNTu4iP7gmfdgcqJevkeyAjGb+czbzWaylTliQh2cpGvGggVOFHUi
 ic0SaPrqLMUMvfP3rKLKvUglY+IDH8GwBP4yDE6Yh2FjdKFzk9jQ+ToSZDvGtyzWcTyE
 CcMuir+1ssRoBwrtFyv0360OH1O8UMiFtB79TV+GcZkfZWd57k77TUQG/IEHzCVGgKk3
 Ly+46+DAIHZANnHj5WN90750TXPtT31zufDTWghvINtb8XXEQ5poq5UGDNitvHFqmFH2
 9zN/NdJ5v5c9pIzyhELce7Clt0ZuIHxJoIKIreoKqzXX+BpcG5VQX+13zbcySUOMmWYj
 L27g==
X-Gm-Message-State: AOJu0YxIcEf8sY2SU9HAmCyqOD5TZymUw3G8m6b0fnYsSc+GTFX6LuqM
 7s9yQN0Ym9mWOu3/KMvG4VP76HPc63gvjiVh/HFy84FTauO6LJmpEIsjwOuW+HBJmx3VGRuY7qG
 hTj7Kf5eDOQ==
X-Gm-Gg: ASbGnctfIIWzBi2zecw6qE2OTdKc15htvRhYBEcEu0iVhkzAMWbkIpj3LtD2WacuC4n
 igfKITMo7A6KicjvyCGifW8juOkvWbORHBQ3So9GyxshIgVIIbmeyAoQeV1Cc3SBvU7zGruLDs4
 pdDUXUqSeKCfp6z23A12iPF2rFpyncOONpaT+DcK93NhGjKYK8j9smpi5s2mMbfTly7gzRQ1BFJ
 pr3HtsfGoetfzZbrR9Uz0TQFAjgpCUG//p1EbEJbzGkmQKX4R2YYJGYwKl/rIaGl5oudiUbeNxI
 2jUc/qxHa+6HP6a3KmSxtQICtLugKdm/Ytc+X0YkR1La52iGdAwlFJEiOKIt9GAEKmQE6hXsEch
 TWM8kAfumTmCdrgRnmdHJQHy+gigEKP/pRlj4cxy5jQoQZswawUhhE2Br3jNRtprX1P8rafvaTo
 DIoKBsxKigd0npMflEysVCgjA=
X-Google-Smtp-Source: AGHT+IFRavpRbgOOai+PP8b+fkMvgnQUrEMpx8gbhDkTihKnpuBYjim9UanuUIHNik9+R2wUMLFDlA==
X-Received: by 2002:a05:600c:1548:b0:46f:b42e:ed87 with SMTP id
 5b1f17b1804b1-46fb42eee16mr148158195e9.40.1760551182125; 
 Wed, 15 Oct 2025 10:59:42 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482b9absm364877215e9.2.2025.10.15.10.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 10:59:41 -0700 (PDT)
Message-ID: <f55ffd33-e746-48c7-9faa-94ccaa4f4be6@linaro.org>
Date: Wed, 15 Oct 2025 19:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] target/microblaze: Have compute_ldst_addr_type[ab]
 return TCG_i32
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20251015175717.93945-1-philmd@linaro.org>
 <20251015175717.93945-6-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015175717.93945-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 15/10/25 19:57, Philippe Mathieu-Daudé wrote:
> Both compute_ldst_addr_typea() and compute_ldst_addr_typeb()
> bodies use a TCG_i32, so return the same type.
> 
> Suggested-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/translate.c | 48 +++++++++++++++++------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index bc38ff0af92..002f921e00f 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -604,7 +604,7 @@ static bool trans_wdic(DisasContext *dc, arg_wdic *a)
>   DO_TYPEA(xor, false, tcg_gen_xor_i32)
>   DO_TYPEBI(xori, false, tcg_gen_xori_i32)
>   
> -static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
> +static TCG_i32 compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
>   {

s/TCG_i32/TCGv_i32/ 🤦

