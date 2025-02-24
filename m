Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92D6C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 09:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmUqJ-0004cX-Bi; Mon, 24 Feb 2025 04:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmUq8-0004bZ-Mq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:33:30 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tmUq6-00079M-HC
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:33:28 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-439a331d981so35873955e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 01:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740389604; x=1740994404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HgKHuWX/erCQ1S/MP4clQkqoyCXWZVj1KjHUi72K+cA=;
 b=C/WcCN8g8HeqHJVrWNd7agqqRNdf+8G5YgQcByNE3BDUpg9xcGwVaJV7RYYM7C4xVD
 tJPtTxFIejcc4G4CAbckwAkuhBWtK0EVLTTdJd2PkQeFw6e4onM4kQpATW42jIrlnBfb
 KrAYhXPz1kIxkN25GWDaF2eVCwDzRVkLku3EdPajTElUL5PlnRtehb/W8ZoXe4CzGS1C
 DjtxpJBNfcH9sIM9LaH6F+LkjOcfIhAxMxGmRkd29exxbTt12pEFjARZwft3Z4PYelxN
 w0nGUM5j0e+us9GPllndyHKW17geQTTs6X///oi1aKfgeZaYtu8xH3x04RYOE/dvpz/J
 7BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740389604; x=1740994404;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HgKHuWX/erCQ1S/MP4clQkqoyCXWZVj1KjHUi72K+cA=;
 b=F3ThmbYX9cnZYEjSpaUbjIKoR6UF9DEtRPU+Cm2NCyZBS+bMZ57ua6mY4VYwIsk3WV
 e9c78kgJpfNtsoPcnlPmG1PVycu+AOfxkWNbfqFwMHW8GYFbOqaY8AESeSQz+ssJBCHO
 w2N0QMRIGQI5BGeqR3fMQhgNCoz84U0qgAcuYJOnFCA7QdHLdw/0UgwuihkwDp3t4goN
 G1K4E3sVnkcZ5iDr2dUlkE9YIHNF9O4z/UUL95PmHbtjxoV6ZBAuHWa94SObc5xHq+0i
 Umy0aNJqdoTZ0eTZLTDPUg7VXXzDm2zUii06CB6ZM2RQ0PhFSGgPYJzXVRJSg5JkN+Zo
 swmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKhEJnphxeQwoxQcgZlbLJAjL2CZZ8XJo4oPk5WWblINBZFc2Erzx83d/aMckvzOkpy1v0Gu6Ctv9r@nongnu.org
X-Gm-Message-State: AOJu0YxUhP26htmeOr0LyMHZcw+COjhqkT+20+K+K5RY8HqmQ9OTYcAn
 hF9m2ZjIPUhc1C6fGUo+d8EjE4EiQOoBHvsbmh24jM0B+PF1Y63l7SHOZ5YhJaoOB2dg9O0nwar
 tJrU=
X-Gm-Gg: ASbGncv0zEYc2Gii0o/+CaRBfDYr7CKuHxSud6/ipAgHjIm7vHGEf2yEfF4IY+EAg53
 QEAnrtoqD1Dc21ppp2IKnaHey3iUYyfoRs9ljihg4dADzHNHCBzaHRVMPvC0yn+ptoo7KUOYCEN
 CdjZT6TIg2GvhwcUapZz7Lm9mQdKgkWt05BBh/FhPVgMTsxDxLjCMccJkJhBaYsX7Ikv6/06a3z
 L4zjb+DJPNPk/fwWiv8RB7XJSfUCkWNyFNnZQ796h8MLl49fTV6He6CEiYvml7wCp349hdVqPiz
 7BUIiPpkHSQS8lYU/9FhB8xgC4J67YBQJ9kdblxu8fDzc1imdzT3KEpaiipLsWUmaPZmSg==
X-Google-Smtp-Source: AGHT+IHv3qOztqL9WrSlw5pO9MZt0joxs4C9HSaGY8TuU0o8gbMDgTgRNf7m5vzvDSLNJJLERrX2/A==
X-Received: by 2002:a05:600c:1986:b0:439:7c0b:13f6 with SMTP id
 5b1f17b1804b1-439b2d233e6mr96109205e9.31.1740389603883; 
 Mon, 24 Feb 2025 01:33:23 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8730sm31828617f8f.93.2025.02.24.01.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 01:33:23 -0800 (PST)
Message-ID: <3c9247b8-7caa-49f8-a892-f044ab48ec12@linaro.org>
Date: Mon, 24 Feb 2025 10:33:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Seeking help on implementing sync over ivshmem shared memory
To: Jayakrishnan A <jksoftdeveloper@gmail.com>, qemu-devel@nongnu.org
References: <CAEHwtECacvmv98uAvXisx57qEN1hMbLjHNWUkm8mOt56wtWGaQ@mail.gmail.com>
Content-Language: en-US
Cc: Gustavo Romero <gustavo.romero@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAEHwtECacvmv98uAvXisx57qEN1hMbLjHNWUkm8mOt56wtWGaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Cc'ing Gustavo who maintains the IVSHMEM device.

On 23/2/25 15:48, Jayakrishnan A wrote:
> Hi Team ,
> 
> Seeking help on implementing sync over ivshmem shared memory , As part 
> of internal project we could able to achieve shared ivshmem with 
> doorbell mechanism ,But in order to achieve shared memory 
> synchronisation we are trying to add atomic operation  over this shared 
> memory area variables , Just wanted to analyse whether this atomic 
> variable between VMs shared memory will work as expected , If not is 
> there any suggested way ahead to implement synchronisation over ivshmem 
> shared memory for threads running in multiple VMs.
> 
> Thanks and Regards ,
> Jayakrishnan A
> 


