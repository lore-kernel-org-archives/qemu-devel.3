Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58A3C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Bas-0005su-HH; Mon, 14 Sep 2026 14:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Bar-0005sY-37
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:39:53 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6Bap-0004EL-AX
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:39:52 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398c066106cso2025889a91.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789411189; x=1790015989; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IVzusJ89u+5300SYV7tOzlauq0FtY5j3SFhXmPaj7W0=;
 b=hzcEKvQaJMdMDK3T4fjmhVvrG8F1IplQE7q8KWwBV3Ek8EclNEw1EdgrsH75I6YHee
 O+IvfcdRlUXFGZL+NcaNXLFs8vYCgxkrYjwGPGxFlWloItQTGZx0lmTvxptmz6EGNKUp
 IOaQTBVoUat3XoGb3o8cA4OTeLT53WyUm/1sJi4JSDEmlR4aSSSbSsrMEgpPDaO5PB09
 5j8PaKud+aDJAS1+fQnaPARtsIYyzfLvydK4RBEFN3/jsUNxHDuIY/Aq2FHBS7sRC0eN
 f6WnoHFQgSWFVrY+EExJEw7JBqg/6L5zAMOoM0CjLZVHWopCDahbmWt6StVWozag+iSr
 Kemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789411189; x=1790015989;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IVzusJ89u+5300SYV7tOzlauq0FtY5j3SFhXmPaj7W0=;
 b=rsE+CY49qplyMulKaxCxuQvOsxOkmFlcBXZwdgT9l6IKzz5fl+HBmiXQ+DT8SQ06DZ
 wa83b2xfzi0A237kq31PrLQsAMa4vDAPujaeQQn3Jxhe4jFvqP6fIC7XY4jil18XQD8I
 NuPk1aTV1NGrPUDCeka9k+l3qzLn4BmAA6keZC72/HLqFzsXp6EhNrxlLCh+lDzKpTIU
 m6mkl4bKF8A+AqaQDaAZDkpYfeM2lKTSv6tMc39kiLV5flHAC5EwjYKQvLoDn5MiwcKF
 gnRygZH56at0xkC0DR/Wqr227itCuzYO13/2qTk+roXCaH7Ft6IHxlhoqJb8juWn6TvI
 N+PA==
X-Gm-Message-State: AFuF++ni70wk3yH0+QMdx4zM5ax2KTsUNDbIBGEsVvBLxguPXIrQ9iRY
 H9tLS8HE0yM6f14iEW9eL4FqggAZqISQbmJBiSKTG5TpbgyWWNLVLXambrL5BE7q0kYmhU6y4pS
 lYiEH
X-Gm-Gg: AYBFou0W03OeqxXEa17n20n/10cA6PwV+pepe/syM/TKGacFedKSTFfIctnQPHvBlRe
 O9g6vxsNUX+vCXMENAc7UqipmpEIldstdsulg1RjVH7gd9caply4+WAW7XLQWMutCNjVz1ceCNK
 mi/QCrOqSXx9hPxaVzbsLyToTsfldB4R6xwEAbQlrdnbpCOiuEl+nKBe/zxKXLBp18juy1yFH6W
 +3g7WF49IZOYGjJQh3/ivbubQo5tAbzO+7Q7b/SA/e+HWED3m8fHKSobaLhBqGy1kVi8evWoIHK
 OzlMNxiSE6U/3VK+0BCutj12wj9lbfQcHi2tkBoyFHBUM/C8jC/a1Nm3kVqloH5+OrNkcN6waqb
 CpeKQaLZ/dRQfUmY1lUQTvo/ggiKVHICu4fPRz/gZh9expzGdrG1rPgmZFsAkMO7Qc6l36/b94h
 FlPzJu4yqw94ZP9xqIWqnmmnYvbDyd+cwLr1DEXVdALS7XES2kElG4kwWKP5Q4DP31p0S6614Vf
 dzqXVyx8QU0xMLtep0anIkcE+eJ+hLQLFFWL2EVQxt+is6o+5edcqNd3r2DcQ==
X-Received: by 2002:a17:90b:3e4f:b0:398:9be6:f997 with SMTP id
 98e67ed59e1d1-39dec0f7abamr8807665a91.22.1789411189184; 
 Mon, 14 Sep 2026 11:39:49 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1438d1381c2sm522369c88.10.2026.09.14.11.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 11:39:48 -0700 (PDT)
Message-ID: <15c1d593-588a-4ab3-b438-a499cb719e7c@linaro.org>
Date: Mon, 14 Sep 2026 08:39:46 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] target/arm: Implement HCR_EL2.TID3 trap on
 undefined TID3 registers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260806173123.333423-1-richard.henderson@linaro.org>
 <20260806173123.333423-4-richard.henderson@linaro.org>
 <CAFEAcA-NoW=39G_m21zQO6CzH5UU3MnsKuFNjkjX-55gzXqD2g@mail.gmail.com>
 <a930c1b6-dd93-46ad-9e61-eafda9dcaac9@linaro.org>
 <CAFEAcA_-UwXB9svLsFwJRfe37+CkwkRHnNVoWDScTEL=L4uOpw@mail.gmail.com>
 <72dd2ada-3b4d-4563-860a-86bf6c6a8a90@linaro.org>
 <CAFEAcA_7eYjtgXVidEMsG9ztZf1Zy8A4Qip_baSGxdNRQQKj6g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_7eYjtgXVidEMsG9ztZf1Zy8A4Qip_baSGxdNRQQKj6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/14/26 08:21, Peter Maydell wrote:
> On Mon, 14 Sept 2026 at 19:12, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 9/14/26 07:51, Peter Maydell wrote:
>>> On Mon, 14 Sept 2026 at 18:21, Richard Henderson
>>> <richard.henderson@linaro.org> wrote:
>>>>
>>>> On 9/13/26 23:16, Peter Maydell wrote:
>>>>> On Thu, 6 Aug 2026 at 18:32, Richard Henderson
>>>>> <richard.henderson@linaro.org> wrote:
>>>>>>
>>>>>> It is IMPLEMENTATION DEFINED whether HCR_EL2.TID3 traps on registers
>>>>>> within the range which are not explicitly listed.  Previously we chose
>>>>>> not to honor the TID3 bit.
>>>>>>
>>>>>> However, with FEAT_IDTE3 it becomes mandatory to honor SCR_EL3.TID3
>>>>>> on these registers, so we might as well honor HCR_EL2.TID3 too.
>>>>>
>>>>> I thought we agreed not to change the behaviour here? Is this
>>>>> just a "forgot to update commit message" thing?
>>>> Oh, yes.  Because I did update the code to test for v8 in translate.c.
>>>
>>> So what does this patch do? Is it just a no-behaviour-change
>>> refactor so we have a place to add the SCR_EL3.TID3 check
>>> in the following patch ?
>> It does what it says on the tin -- it honors HCR_EL2.TID3 for undefined
>> registers.  We currently only do this via access_tid3 for defined registers.
> 
> But there aren't any genuinely UNDEFINED encodings in the TID3
> space, are there? The ID register space has to RES0, not UNDEF,
> for reserved encodings, and so we have cpreg structs for
> all the reserved encodings in the ID space.
Since we don't do this for all arm_cpreg_encoding_in_idspace(), I 
assumed that we didn't do it for all arm_cpreg_encoding_in_tid3() either.

Either that, or we have existing dead code testing 
arm_cpreg_encoding_in_idspace()?

I wonder if I should prove that either way with a test at startup...


r~

