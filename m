Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D655C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 15:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRZfj-00034M-3Z; Wed, 10 Jul 2024 11:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRZfh-00033b-73
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:55:57 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRZff-0005wL-Dk
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:55:56 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7669d62b5bfso3381800a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720626953; x=1721231753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hY37YlJoWvkT+jXQ4WvxZso7KTj0Lrpth2qy3uayfBE=;
 b=oIVYphMhUOHg76FK2pUYy2jO/qQEVGJynabnqgQl+bFC4owTwe6OSHoC9Gj70kJ5wE
 v2prC5gqd28qHi2Tnjx0HOLXUnnASN9XboCWK/M5IgmToT1dN9eTMRciZzY7csZY+yyV
 AEAan+oto7xpCjEJSf7dzA14+esRRIqPn7hOmxAgieyPBdO34GIEtSH56LGlOZxG88+k
 20TkvPWFEpMRoIAnFcmYmofSsv27a4cB5L3bAEDUaJ4UebOhGUr6hiWlKR20Bg2+zFo7
 bX8RE0bKHyfP09AARV2a8c7x6Dnq2fHKfMYc6vp9qD5ypLepxU7z6tTH20PxLGqwW2Ho
 Rmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720626953; x=1721231753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hY37YlJoWvkT+jXQ4WvxZso7KTj0Lrpth2qy3uayfBE=;
 b=lhbl8Tv4X7blbf401Q8IBKH7TiWhzHs/b+Q6FC7wAmt8mZFORpMr9bDtrQh5u7139C
 BPLCQfxyOrrOZNnNt6IYHrh0cym2GiehB6jSwknK7xjF5UKs0tBfwBnFswz7JJ5sfIuX
 CVebHspAcL4W25BP6SSgmmTZICorm3anjsoHDshDcPh8H/xQBnk8tNhR497IrVTJeeJb
 bcE7RDJpH6ab1ZNdjWCHdNvo/Axo2h5uMRadDGOLylV9fVaaAmcBUzfuB7ERctzsOwdO
 YHWa2A+AVIWmrgz+C2bIO8xoWQrJIzM8Najw6eghd4bkgjyncd8y71JgvsGMLBNjoLV8
 UqGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRVIgVwvfrTlZ9JQAc7PBxvYy3s42BmkQGWPTKEIAdaUGuUxQskvyaFiP0NvMbCFzY6b07t53sfBkLIRwmIpburbIsEJM=
X-Gm-Message-State: AOJu0Yw7DM+Wwj1pgn2lhMkvt4qI4UuW+cTNB2M2DQrxos257DBdBdWU
 b6XokteICiwb/nTb0dlgzClCQq7PLCxmhE8Txr0dTB1gZhDj9iApCSrsdmm0ZZo=
X-Google-Smtp-Source: AGHT+IGl7av8jmlIQMdCxbAtb+FCnQT322f6pdgKdBxSo5VVU/AVZEcWDSB230elB65MMqEpjrX4xw==
X-Received: by 2002:a05:6a20:1589:b0:1c2:8eb7:19cd with SMTP id
 adf61e73a8af0-1c2984c871emr6661824637.42.1720626953346; 
 Wed, 10 Jul 2024 08:55:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ab75ffsm35389685ad.175.2024.07.10.08.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 08:55:52 -0700 (PDT)
Message-ID: <babc100c-35f7-4926-a1c5-afc0c49c47dd@linaro.org>
Date: Wed, 10 Jul 2024 08:55:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] target/i386/tcg: Compute MMU index once
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com
References: <20240710062920.73063-1-pbonzini@redhat.com>
 <20240710062920.73063-7-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240710062920.73063-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 7/9/24 23:29, Paolo Bonzini wrote:
> Add the MMU index to the StackAccess struct, so that it can be cached
> or (in the next patch) computed from information that is not in
> CPUX86State.
> 
> Co-developed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

