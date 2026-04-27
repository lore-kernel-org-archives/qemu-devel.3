Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EB9FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHITS-0000Xs-Mv; Mon, 27 Apr 2026 05:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHITQ-0000Mp-2N
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:41:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHITN-000326-BZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:41:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488ba840146so90700535e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777282908; x=1777887708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9qBL0m3NYcXbunKk+ZDfMkPYLuNzIe/yFVC87ez3Jm4=;
 b=MY6xJuOxdFuO7VaeC72u0E5T2zOvsNCaesOeVY4UDUQW6lU2PmX8bDhMWYuLQ0dBDd
 u5OW94UXCmbuKwIaTjSNUfiz+x6qKHT1khO7zVMa1r17ipPCu0j6GArdZwyS4Y6ZYz33
 2vI3YGken5geihBw1a5835Buihdqb6mG7xpWhzm58lFImKG9YrJuGK50Gll7HdU/2yCr
 JWAdFGl6ncvJGgTx2IlYi3q6J/sYpUctiQHwZ3kxzECcEz25qJynE+d3TFSXNKRYTOAo
 J2k5j5Zmm8DURQ9oaN/uEjdTbph0GwxjumJ9H8Ly6SAmt6Vwws3EpPl+zW9J84oETcLl
 3KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282908; x=1777887708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9qBL0m3NYcXbunKk+ZDfMkPYLuNzIe/yFVC87ez3Jm4=;
 b=ILPCOpu9Um4qBtSdyDHYkM56e5gqRDF3UjbDVckw7jt6gzMeO5sPmXvRq0A8+WUGsY
 jMUSsXJaP1sDdfsYi5fyFW5pfOvKeI7pN2g2KE6GSwpYYVDH5MXDK5tpFaZOqvuh3W0Q
 9VNsXO5YkghvkoPP5/n/tjFk4j4RHvKCvOjpF67tuweonM8b2uoWztfuLEWjvCZqaFgd
 jEA7kDHViameWJz9FacWz5/tzfRlz8pNXu6BOlEeOzQESeHgab+zyDZip0zBN0YH7VK+
 M/LdGHBsSiVGaOMbfGgxTtZh47r8YDwKPaWxE6ojnpmgbwYCfXohqd2uYGm3eNITKFen
 Ai2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/n248fanhV3aSOpqLR7REhQfUYBmKDid8yZ25ifP94Im5ZbwLJv4+cloMpQhCLsKfo94eINtCgkwNM@nongnu.org
X-Gm-Message-State: AOJu0YyJPBb53tvJLk2CInOKjbR4OFo5DNDdMOa5x3DrVLsnL8RfutvT
 jKNzoBBnyoKzXS5WzSL8iG42Fq22hV3tE2aBzwUSK5DDUo+GMlaVhU9DEVRmCwNSrXo=
X-Gm-Gg: AeBDiev0JbPMDjHy9MtdcOfqsu4X1FVqhMu1zRN10yvLTEndlpa2JvzyO05boXUzoMv
 TchFk4y8NI35nqfkCqgThCpsS4GtDfVAutyXI10GGecUr36/AhBwHVaBAocbqQg74/IfR0WRyap
 Pv3nfDglYvLKy0rIRe8YVgN9qVPMacP/0H107QRyVpdMveMj4teE3G4HEK1KvqN2qzimEUncSDG
 yenekXr+TDr6xIgvVs3gNYsFl8QEw2mm7EoxW9cfzGCX0NKniD0CxwnP9XKjOuT9cU0PABQBAOm
 99T2kC7NcT2zIB/yzskE0utuhPJd9uvdf/mqX4zCaBg4wG2WvtKGgis91B5LSAFZp3V5EZHlRBh
 anAPhEcEt1xNhBtEVPAANyCbdyeLP/2uc/lPOG2UfDFr2TCH/2gboXszYd7mZQQuQkOoKE90KKg
 J+pyjE8Fe4xFhQBDhYGxVWj/vSxkZkQJuimQ+gwYAKCM8VL4EBbML0Af1vZPv4AzAdu8hlUuWtg
 92teZTnd4XbsLs=
X-Received: by 2002:a05:600c:890c:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-488fb739cd9mr496739595e9.1.1777282907600; 
 Mon, 27 Apr 2026 02:41:47 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb74c7a2sm246789995e9.1.2026.04.27.02.41.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 02:41:46 -0700 (PDT)
Message-ID: <c3d78266-458b-452b-a261-71d2204fbea4@linaro.org>
Date: Mon, 27 Apr 2026 11:41:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/84] fpu: Drop parts_muladd_scalbn
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/4/26 15:38, Richard Henderson wrote:
> Use parts{64,128}_muladd_scalbn at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 28 +++++++++-------------------
>   1 file changed, 9 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

