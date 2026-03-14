Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA78E10706DC
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 14:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1PY2-0001a3-LU; Sat, 14 Mar 2026 10:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1PXs-0001W7-SC
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 10:00:49 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1PXq-0004yz-T4
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 10:00:48 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439a89b6fd0so3076869f8f.2
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773496839; x=1774101639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PSc4s1Hy7JWz/i++MGZVP8X7Dx005HwHzvl5ROwQJvU=;
 b=JtHFtMR1CkGyVnFUkBfSgdrRieOx82kIUuoMB83EN+3oten8x2xmNFKicSLbigYVFD
 v7sXKywmf8ZEA7VrFd/7UYioMAc99xO71GS2LwDY1CkkyDuHHrVW6wLJ5k/hByQk0GOl
 JEOE3LocnlQVckgCrmQtfjQNKDOBB3JI0s9yoWq1Sf8WB7dRB8mp3p4X1Czy+c+5mhZH
 cQitKVeUw1eDwgC80fRafUF5UXuH788Zxr7adjDojpCVqk50yu2fTEfYD+NycTITnGNS
 jRt8NCqJMDIumF+1JNvsl2BPpGw85wXXcbp4cU+ttnv77yrjSd4HOOfNQiTBqjEKAsgg
 mr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773496839; x=1774101639;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PSc4s1Hy7JWz/i++MGZVP8X7Dx005HwHzvl5ROwQJvU=;
 b=VT5uB7w4ZdjTaz3YSQBhY1zqYInYWpEmmjDLjx8HstDq/1axMexvDnOPEMQdrsI7wr
 EH06JfiHx44pzV4bzq59AGenFSMojF8SR2NMh4FSJsSnnO9JhFqjihsSsioK8PvWTbyw
 G04M41peiIlF2NpK7jntZzGMzxopfUoHoMgip5Oi7lglORWtDWJFRiD+JFOecfHWcLwY
 cl6AKrFNcB3E2wpm1ENULG6CBDjtwnlmdh713SYIh5se3XjjftGJStsZitfb4InocTVI
 plo3UTcpIQ0eD64OEpmKZZdWSkqs/IAyySy6gqGapMOKaH7EEI0OBTSrB1C8SnpjBZY5
 1Y8Q==
X-Gm-Message-State: AOJu0YzA8ZVTzheI37TaXqgYsIVMMo0eh5H5Yx2jsCxJsZffyxudIQZB
 +qvb9oa1bUBYu6SxJYF9Xj0B/lSrUX+qZeRe56hxlmm8JOFetUR8QDrMcgbxx0jwaMg=
X-Gm-Gg: ATEYQzyp3CYHYrFq4GUOM2BLl8A63upr7tN3dRWfJKST0zP7dn9evYGieHTb/vwlYg7
 CXojmjT1vaHFpDa0nahKpKmohgpqFUVChGE7srAgY4A5cyaDxN/ZB1q9lm4s+163WnOeIxvb7Lg
 TgODg49z0nA6nGB/CtOms00SQ4xfAptvF0NWFmT5LIbqLMaGVtI1LfIV5xPWkxcyAfVM6zMwjlC
 dB5zi1udBTBieBJQOpAETr1vuRLoJCaWFS6TWv7XqmyLJhXyWoeJOrcjNZaGwUEWfCNuWEkPqZ5
 r0t3aZa6KK9lYMCQy0PO8fpDl85AsI2pKmihZmgR2nERS+J1BxLIrkdnqU2u32AGWTeiIQYE0Bv
 KyWBPf9FR+PDF9GF8/+i4+56afXuwEyyR6Lz2McMuA9DxH7znl5rxPT10OYU0qtH6YzKcBuL4dc
 f/CJlEKTp6/QVm6gfvliKPI1WoDXFnT9g/5EeD7kgZfPMoZ6VYfnZaIu9vbj79pFcMLw==
X-Received: by 2002:a05:6000:2584:b0:439:ccd7:cdb6 with SMTP id
 ffacd0b85a97d-43a04d8c23bmr12716211f8f.14.1773496839313; 
 Sat, 14 Mar 2026 07:00:39 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1a72cdsm26619527f8f.9.2026.03.14.07.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2026 07:00:38 -0700 (PDT)
Message-ID: <fdcd1a39-2325-46f0-b613-073779f1cd5a@linaro.org>
Date: Sat, 14 Mar 2026 15:00:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] MAINTAINERS: Downgrade the functional testing section
 to "Odd Fixes"
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org
References: <20260313113424.15583-1-thuth@redhat.com>
 <20260313113424.15583-5-thuth@redhat.com> <abP4OfQX5n1erZne@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <abP4OfQX5n1erZne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/3/26 12:42, Daniel P. Berrangé wrote:
> On Fri, Mar 13, 2026 at 12:34:22PM +0100, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> I won't have that much time for QEMU anymore in the future, so downgrade
>> the status of the "functional testing framework" section to "Odd Fixes"
>> to avoid wrong expectations. While we're at it, also switch to my other
>> e-mail address here that I'm already using for the other sections where
>> I am still listed as maintainer / reviewer.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   MAINTAINERS | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> FYI, this section only applies to the core framework itself. The
> individual test files are all distributed across the arch target
> maintainers.
> 
> I was in two minds as to whether to declare myself a replacement
> maintainer for Thomas. I'll try to collect & review any patches
> to the core framework in the absence of anyone else wanting to
> step up, but I didn't want to guarantee I'd be able to spend
> regular time on it as a formal maintainer assignment.

Good to know, thanks for the update!


