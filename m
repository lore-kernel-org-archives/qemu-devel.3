Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291D3C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 17:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOL2A-00087A-Sh; Mon, 01 Jul 2024 13:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOL1y-00080s-Qs
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 13:41:36 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOL1w-0008Rr-8q
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 13:41:34 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-707040e3018so2326917a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719855688; x=1720460488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=53q30pHUIRq4Vkz15pi0Vkg6y4C5BMfrxQtO9AW5YbI=;
 b=mFfwEaxAUU9SJ+AFOym/On+yPCxoUekgHTv9yopxxQRlfaifvgqkeLKj8BH/mmF2fQ
 AaKmPkrzkjPwKpoy71cKLL/uK188NpT39eGNpSzqnX0whldeR4pmzlbN+tWoUWxz8cnV
 UHf4LGJkdU0eoriTX4qxso59t6s3x5SZIhwmCWb4x3cXyNonAcklndlb2gRZB20PTpAb
 EhxLA1DBeQ7YG/LGYA8E8Vt7l/8cniVRBBX25hziQ2kMMXwK2BamQ+02D2+hyBMfMRy/
 jKe//JHowCvG3XNPbd+JRLxsbY26BCWkCgzrFWtkjM8NUdM/gryev+7Kj5WMCxxtvKlh
 yRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719855688; x=1720460488;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=53q30pHUIRq4Vkz15pi0Vkg6y4C5BMfrxQtO9AW5YbI=;
 b=qmj7VY1RXcCkiJ9MGmmIz8/iuyzTXW5CwBetJjitsNdE0Uk07og6rRnkFF6UJjQv86
 tLfmsIUPMPHC9yWzbW+DJTzKh5ci46J+FmZb+qdv2WQ1xovmJG19pR02u56lPgX1A4Tn
 LnLwaOTr02xNWCxTEcV1JNE0Km85vJZhTNx/0lpIJafAYOnabwzPD8KvU+GqPVzYJk/M
 Y8DwqNEOez8NGe3c1eEX+72hQAtMfvEbJ6nEwVwE8vxlq8rtlHqa3Sm6z3tsA8L+hl4v
 fcZHt6KMiPR63FrdgtYx3FqKhbKCNLq32Gy26yLEx+fSg6vs9Dm5YPIb4r/Nx0noCO8b
 0Vew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIh5+bKGk5TfOExYqzu/6S3GLnOXEuAyie3szP3hIFow7wU4NjMVlRBiEoNv8ZRErxVxhbBvdls2z4OW2PJlukc3ZkQfg=
X-Gm-Message-State: AOJu0YykcJw22yDg5eNJdRJ3xEkLCnCj/rHmMcuJm22E4tyW42mc1hwl
 KfBzeUtqsHFZA9FgyY1rjYkZAAGCDdMVEJGJ6WTGofeUrzOimvlDDEFi06A/B90=
X-Google-Smtp-Source: AGHT+IHWwFg57TDVcHaUJkwIC7X7elNdCqgMSGyOuXuGTvNA9DSi2ovl3bJ7XJGHVtCi/q73QnCTIw==
X-Received: by 2002:a05:6a20:4a8a:b0:1be:da68:1f25 with SMTP id
 adf61e73a8af0-1bef6243152mr7590795637.57.1719855688180; 
 Mon, 01 Jul 2024 10:41:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1596680sm67697225ad.247.2024.07.01.10.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 10:41:27 -0700 (PDT)
Message-ID: <5649fdb0-676c-4bf3-8dc2-c9244ed655b1@linaro.org>
Date: Mon, 1 Jul 2024 10:41:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] xen queue 2024-07-01
To: anthony@xenproject.org, qemu-devel@nongnu.org
References: <20240701131833.29486-1-anthony@xenproject.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240701131833.29486-1-anthony@xenproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 7/1/24 06:18, anthony@xenproject.org wrote:
> From: Anthony PERARD<anthony@xenproject.org>
> 
> The following changes since commit b6d32a06fc0984e537091cba08f2e1ed9f775d74:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu  into staging (2024-06-30 16:12:24 -0700)
> 
> are available in the Git repository at:
> 
>    https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git  tags/pull-xen-20240701
> 
> for you to fetch changes up to 410b4d560dfa3b38a11ad19cf00180238651d9b7:
> 
>    xen-hvm: Avoid livelock while handling buffered ioreqs (2024-07-01 14:57:18 +0200)
> 
> ----------------------------------------------------------------
> Xen queue:
> 
> * Improvement for running QEMU in a stubdomain.
> * Improve handling of buffered ioreqs.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


