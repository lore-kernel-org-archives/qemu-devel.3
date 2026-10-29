Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB57606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XEegXCEi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYMQ-0001Zc-8R; Thu, 29 Oct 2026 18:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMYMO-0001Yy-HM
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:12:36 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMYMM-0007jj-DG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:12:35 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4a6f2825dd6so19048fac.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793311952; x=1793916752; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+mF7uhmJ0247D96xpAWgu1JUQdZADogseF5itKE7Z8k=;
 b=XEegXCEirriLENZy61UjEQ8yGbvHYrFIQMirOtVInhhfuJQQE8iGz+9TB9PjV9zAV2
 SrFaxAlQ8yKf9tmtWdYHipWTgtAHFJkdvQjL35XWfO/BY5MW0nEQ6VHf+QGj2Zw3Jrlj
 8nrMlSHreM1bJ5pBSzO/CU8w7vnDtph8tCWBoVvmLSKLe4fwJ8W71hK7pBc9xqWYgWl4
 uK2Bz5Z+gaYzdIHAOn/Y+Uuq3u5mvU+5fW5xjw8c3jKQjmU9+4ASMrkBCZZVVvkZ5kdU
 6V6AK/qNP+YB4qTQx2O0bJ4KvJ+RPO4HJLYzB1XC1/8mbUhw4bxNeQjSzyc5nShAwBaw
 OUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793311952; x=1793916752;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+mF7uhmJ0247D96xpAWgu1JUQdZADogseF5itKE7Z8k=;
 b=rb1vWwLPbm/UIEvbRQNuSdOEh+Ybkl4gmoooiHVkh3bO4SSOiV37iWzpy0idz0KTph
 B1CeJOGZWjsd/bz1EDryNxliNotsph/E+8RQSSdrL46SK+ayCQrAo2FhjBxccmrrArK8
 HR25tZCCTbHiPRUGkgs496UYefRimO8pvJirojaJDx5ONiMMbFUFHPsGvDnABLmFO5O1
 Mo/0M7K0XkF/iLXiD4PGhEvnpPKGxufeemNBdpZjd8DiL2ijteHi/zJKqeVCxK1g1feL
 Nv/r6jWIwIhpjXFX/673RJv2N7i+lVO1XR3cm+nLUiiYBnTN8fn4UyBdFPpg8i4zqhqN
 xlSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9tBqa6vEq++mHkQ47VM7DcmlGDRSi4M4boI2G9hQNfscGogQoc0727uUOn4kA+QmT45aJZpdsM/S1@nongnu.org
X-Gm-Message-State: AFq9FYJ1hqGbPLG9rZktLmJXFDHcAVudPpjM74Xzqb/0jckpAIKRqen3
 a5umxewn+TXomMwk7kPZ2izp9xRaaePozNba76ZSAbLnCDl5ysL6eN7ysGVdDBuQdIyUZowAmlJ
 6xE8p
X-Gm-Gg: AYBFou3XQnIkTsT55jcMbZMRhSbUA6lDhnZIXSu2P5J0pvO/AYC8a/SiFEli9Xhpyza
 eQ4Mqaix6tHI07u/Y9P1amaCVMZZ6H2TKnhc+SZ1eLl21u6Y2vmwxmCBdhauxjC1n+vsTi4jun7
 sGgBhy7QhLerk5i8SNKvwUkkFQ/oXiRIhGJPA4Da34f5Nv85sbWl7O7WGjGAv6Qpe6LdHYOJtDj
 1xs6b32wd4AONVLdSNB0Tm+2TMeH2AZ8LePhJUpDKfX8AgpXU8p4ZFccEeBZehWyCIzn/3i9f9D
 4S85mu+UD8+ENOvH8uH1P1aj9soT1P5abkO6XD5jOcqyoFh2M9vSibX2lg6UXa3QpLP6oIGll2Q
 KPyBw2RFo6Dwmypun2ojZV9lWBhS118N7GHRiRbMvN0g9iihcttbM9zr+Dyw4LpWUl2F/jr8UPQ
 /IbNJ5+xeQ13fvOYMEK0+seBc0d37Q96HRye6zf/xLHTB2tkUhyjqNClXeQ3qtprjbwRd4b5i3T
 ol4WXARbEgnywpSWHmKnG27xYfLBjkVzt75CMkS/CTyQGNQrd5pTVnSZp6jVAmmY9fCpp8hRsAc
 zZqMm31ptWytxveIbglMgiYR6IxuTyqeqmP3XxjXLuw/1x189DoLDaNaktp4lPoKKfq4FldFFA+
 JulfNG0LKOmU=
X-Received: by 2002:a05:6871:4410:b0:490:35f6:2b8e with SMTP id
 586e51a60fabf-4a90763961emr370728fac.13.1793311952292; 
 Thu, 29 Oct 2026 15:12:32 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c22:98e:45a8:3c43:1165:d4ba?
 ([2607:fb91:2c22:98e:45a8:3c43:1165:d4ba])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90a3b5364sm119351fac.2.2026.10.29.15.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 15:12:28 -0700 (PDT)
Message-ID: <8c769188-14f9-494e-afc9-fe3087dc7baf@linaro.org>
Date: Thu, 29 Oct 2026 17:12:25 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/33] util/cutils: Add STR_ARRAY_ELEM_OR_NULL() for
 string table lookups
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
 <20261022215115.19680-3-philmd@oss.qualcomm.com>
 <d38a8380-9e17-4286-9b3b-a92020cb087f@linaro.org>
 <84240548-b0bd-48ae-a8c2-b81bd7e02280@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <84240548-b0bd-48ae-a8c2-b81bd7e02280@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 12:04, Pierrick Bouvier wrote:
>>>    +const char *str_array_elem_or_null(const char *const *array,
>>> +                                   size_t nelem, uint64_t index)
>>> +{
>>> +    return index >= nelem ? NULL : array[index];
>>> +}
>> Why is this trivial function out of line?
>>
> 
> It ensures array is a string array, and not any other type.
> _Generic could probably catch this also, with a more clunky syntax.
You can get the same thing from a static inline, is my point.


r~

