Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D35C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSP7t-0003Q3-Vf; Tue, 23 Jan 2024 17:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSP7s-0003Ps-Ts
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:20:12 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSP7r-0008KJ-9A
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:20:12 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5ce9555d42eso4076447a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706048409; x=1706653209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sg17qJNt88oC2wjnfhfSuTZAiOBSUniuB/KWPjh33dk=;
 b=xb8OixH+GEjZ/aq9F8E8o15IYJTai9Qfyw3NAhAoVlJniKeXo9FatQV3p21z19WAbD
 Zx59zYsuEtdsv+eACljEuJ4eIQKz5NOi9IJp3gcmz9r08CllGLdAlzUPLbSlQi3PsUnq
 qhV6lzH+4gREq8VwZDkgg2rSs423ueOboqXT0A3r9eZYnCQ3Apg7OdKaB3/2dEb0CH23
 IOE89wUqWde9QVGvh9rO9SIwH5ds3hwyKJFxZH17T2sfErZgYJv+cPoTyiocxuCJ8akc
 ZRjzf+8rPZKI32nt3EHfCs/F2NjRV9bXgRBwoygjHRJIhXjnSFSsM3zoFCeOKqJiqk3R
 2JdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706048409; x=1706653209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sg17qJNt88oC2wjnfhfSuTZAiOBSUniuB/KWPjh33dk=;
 b=PuM+mpmaIJZfz6Eb6Z8aWWut8Imif6CjkJX0Bfv8yB0aRGLcn3X53bKN43EJ8F6EMC
 IsaH1Ed8vsuZtfJ4fGk4m3Ihh5Ok8iR/8cZiqdXN2jbYqGi/0ELRBCMIr1adqIrmjZi0
 k2OgxVP5D9ZN2XZOenKh0TfdGO9d2Tu6zbvtybPKenLFFGeuULoGnEtRxX5xgaBg6d2z
 /R3Tc40ddCNZgp9m1/+p1CdgJYMPIyYspRsBfox1duKgMC/UJ2NEIOe7K+MKkwVb1w7w
 O8samcLNAxqWftVqSbBlDa5wns6fRJDLdNTZzYzI2AkAA+Y6k4NuF0Jq4K6LFWySxEaJ
 1v5g==
X-Gm-Message-State: AOJu0YxYck/02Pe0sXpb1WkQqJJiLPiV86t6Ps/+bYdh4CgjtgTzkCcv
 GVi555mFO3G4DRsScGIXh9okBgLqUvF2Ba/mk1SJFS4XWpSC7GRdIyWKXP3UTwcq+vrv3igfH9b
 L
X-Google-Smtp-Source: AGHT+IG3u0SnyzaA8ON878DW79yoX7ho74ga2dMP04f9NM9ZSyocy3HAwWBWcFdaUyfIN5KqaaO1Dw==
X-Received: by 2002:a17:903:234a:b0:1d7:480b:883e with SMTP id
 c10-20020a170903234a00b001d7480b883emr5226111plh.33.1706048409121; 
 Tue, 23 Jan 2024 14:20:09 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 4-20020a170902ee4400b001d3ffb7c4c7sm9288030plo.40.2024.01.23.14.20.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 14:20:08 -0800 (PST)
Message-ID: <3c174755-cfa6-4067-887c-cb4820db7551@linaro.org>
Date: Wed, 24 Jan 2024 08:20:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/34] exec: [PAGE_VARY] Move TARGET_PAGE_BITS_VARY to
 common header
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-4-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-4-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 1/20/24 00:39, Anton Johansson wrote:
> We need to be able access the variable TARGET_PAGE_* macros in a
> target-independent manner.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>

I think you should pull all of these macros into a separate header.
The split here is a bit confusing.


r~

