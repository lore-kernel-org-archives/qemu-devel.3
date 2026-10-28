Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F4606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yn+X3vxv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLs2Q-0008R0-1i; Tue, 27 Oct 2026 21:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLs2O-0008Qo-Fv
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 21:01:08 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLs2M-0007y2-Rd
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 21:01:08 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-823e4047037so332817a34.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793149265; x=1793754065; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DVdq5qz3x2CnY3+QvLQ1AI3qiwhFdXLl0UUfTG2NcaA=;
 b=Yn+X3vxvqLe+T4xFIYxwGbQSSsZZS61EHa5+NBxlHWfmu1xMZoe+wCTE0598Mp+hS3
 N2XqvmHWggYe0dHdiWr3CDt1x+XnF+ftlFNnWas8+u8yNx9TLtGtUzi8bijXeKhDvJxE
 JbDsCv3c3OOFO1BwlCDtE+DHKdt3a7x6qLBo54zTEejxhjTZ++XPz9q2YDQ8Zwpb2RfS
 P++9UBwfydq4pjjEc/KNnVxJSN+D+xB5y2axZ6bO9tpOvWKOZ1hm5YkYLNYE82qXRJq4
 hP+3HUNh/ej0yg73lKiRV8Yw7rDx8ibMeH5CaAIFNUCCf/aRVaxUokP1xN8218BvrETg
 Tdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793149265; x=1793754065;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DVdq5qz3x2CnY3+QvLQ1AI3qiwhFdXLl0UUfTG2NcaA=;
 b=EsA2xVaKVDjfxZj0cB72HCqxs3O1uZwEbIdWi9phUyewLZUKeR1rH/Rk+tWCGF957F
 oagQZuu6ujiBg1vPlWMs4Ge+GNL2jD7cXrWFgnsVMdYgwxNDrt8S97q0Obv6vRgXTydy
 MsIbz1SHYA19zkfWsDEFshwEkfuI7FTqGZ/ZDylesyNAeGd1VObsBRSUkHjmwbY7qrFJ
 QdWTd5EyZLw+w/FUCXrxtG7BigqZ5yCVzlWrzBVnRIyxnJnHWonyOJq4AOEGDvAJJeyz
 hQL29Ju6Pzaul6GO7NCEpIPvfMfOOy0O+Ca2qbb2bc7tt90Kzp7ww3Q7CnFdn1WWlqP2
 1Qrw==
X-Gm-Message-State: AFq9FYJW2IXpH3PziUnowuYsoAGKhBwgtPqVHG4ddbfbQ/vfOOJkpjcz
 AiZZ8G9NnhFwmL1Q1ABC+3/ApAwp0bA0ED9z0dIGPTj6TQk7se67L4WNgXon3R6F3RQUPUibwIa
 saxvJ
X-Gm-Gg: AYBFou3ovQp9NtSsQXrI1/PXa1/fcXH1D4Y2bS2ziT3l0Iu3BblFxylwzim8fP5D38o
 0SD+Yp9JfHRmR4WJnP4zIz7lRSh2gPJZAzPeqo37wDDVFx+VJvq5B8sBinUhFhrTd0Z1GBDWpCZ
 /27J4ve7EiDLe/j+ZOR108lkEQRchEjSBbkzyKW5lwVzXnTckdnScNBwyRIovo76d9ClT3t9FbT
 wPd1f5vjsnl3OmlMrZwgKJrGixvLFLu2YiEsk1jVY0SOsl/Lw+VdONy/V4AWgQv0NIUwybCP80v
 6UJA40yzeb6wB7+JK+LKJmTd6fD3aJPLTzqzfP5Zxapxb0vVgDpljX2et/SMQrbvH/423oc2M8a
 KO6P+SCIcGPFaIx1SIhoJ8SbZ7s+SrKHQiMNcHiaGEdbkGGo3CmuSmfR8nsQiRMNiiQEPbo9Oic
 PKl74+prV54K9P+RRnPs057mkYGT082aGIn5w9XtFe+wcvpz6KmIzGIJ8aPKx9bwyypzncjgXA6
 io1JZkLWT334FrYTfFwdi+poLjvZyZ1+y50t3zF8tnYsJ6GMIUIuew8VzcBl9bPwx4vZ/CKGRYP
 2hgM3PEFJm56YTA4G8zG5CKBZ75uhRVriERbL3woIoqG
X-Received: by 2002:a05:6830:2695:b0:80c:d34f:5f5e with SMTP id
 46e09a7af769-85abd809ecemr1002967a34.23.1793149264912; 
 Tue, 27 Oct 2026 18:01:04 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f43671esm221764a34.5.2026.10.27.18.01.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 18:01:04 -0700 (PDT)
Message-ID: <0dab848f-426e-49af-a28e-8165591b9d03@linaro.org>
Date: Tue, 27 Oct 2026 20:01:02 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 51/59] system: Remove deprecated 'debug-threads' option for
 -name
To: qemu-devel@nongnu.org
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
 <20261027192341.9197-52-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261027192341.9197-52-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 14:23, Philippe Mathieu-Daudé wrote:
> 'debug-threads' option for -name was deprecated in v11.0
> (commit 1b65aeed2a0 "system: unconditionally enable thread
> naming") thus can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> Reviewed-by: Ján Tomko<jtomko@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert<dave@treblig.org>
> Message-Id:<20261018232917.7716-1-philmd@oss.qualcomm.com>
> ---
>   docs/about/deprecated.rst             |  7 -------
>   docs/about/removed-features.rst       |  9 +++++++--
>   system/vl.c                           | 11 -----------
>   tests/qtest/migration/framework.c     |  4 ++--
>   tests/qtest/migration/precopy-tests.c |  2 +-
>   qemu-options.hx                       |  7 +++----
>   6 files changed, 13 insertions(+), 27 deletions(-)

You need to remove this from the testsuite as well:

https://gitlab.com/qemu-project/qemu/-/jobs/17523155796#L58


r~

