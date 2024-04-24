Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904F9C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzY8h-0004lH-QW; Wed, 24 Apr 2024 04:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzY8b-0004dT-Li
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:37:57 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzY8Z-0001lk-Tv
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:37:57 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d8a24f8a3cso82933731fa.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713947874; x=1714552674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kr4rn0fr1RcDoImrOy+lafgj5qW+Ky8y/aVAmX/iyWs=;
 b=XFelXd2oTsx02G8ZdDXmVjGbpYgi1KSYNt6Zaup8rAtACf7bwnzBTFhWiW1nZZZ8ma
 6In0NhJM06ldH4yxtvaZdvlkSkBVJ2ajkZ8sct9ar0ufrAGI6eXjBzlhg90xgCSGa4Zm
 xqaieFBF4T9Cd+y7V5yoFbXpG1m4VbgNcirPhKrxB/8GahPrITd1AZgkvarKY+eT4W9y
 8C/wjbWPCUVUxVWgEDu02mK+b9UBP5p9ZddRDvqFzSEQcLM4Q/U5/kfj6M0kmc2a+sj4
 05Fgo256seu7SQmWl2WJEOj4bhFH+F+CGZ6Ob1Sef2sgKpqPgfEATRc8KCqZaTMI9otA
 c/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713947874; x=1714552674;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kr4rn0fr1RcDoImrOy+lafgj5qW+Ky8y/aVAmX/iyWs=;
 b=oeL2OtGwzqhBCShgMlB1rumeM52oF6sPfY7cvc2Fhyipm+ytXlPFG3bbrPVqNortxm
 soZydsYadmZxgH+80XF2f/g8WlTWcf5mXJxin3Jo/SO/C7i83fMdP85o0p07sNtbj4lA
 AE2+pCFr8eGHsN5iCsgT04f+eUPW76I/T5OVxrzmT3jUCrrPBbaDMP8GaNeC11vZ7xUc
 T0arXnI63Or5aWRC9q5kqR4sOQ4RF1Eu5/3olTj7UX/FyiSdDGsktYU0HoeyvMPAeRbu
 nQb7EgzNb+abf/RwQxwv/dI4OBaFQpj2Yny8wiDiV/fQIcwBKMjowmcBZVzJMFYxLssD
 OPHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmfjY0/eCwMi+EDf105kCPOnUCzsNwatgvAuFnjzmvNQMEiXQjUbE7fYjEmdB5Yvqtb2twvCJZG68lviL6DCy6YPtYykM=
X-Gm-Message-State: AOJu0YwsRY4b7aUIE0oJejTm0nSu0hbLz6PW7/8SbZgUOuIdnZByrFQ9
 OqDOXmrBT9Aw7kPqZ07tWd8HKpYfGmt13aLkg1pFxeVvETwFMoBLAOWU8t+KHUg=
X-Google-Smtp-Source: AGHT+IEb/89CgCpbYA/Hvif/am+PovRCB1drljgnSWoLkVLTGj8Bi6YNprH7+yxl/KcosNnA7Yh6pA==
X-Received: by 2002:a2e:b1c9:0:b0:2dc:d2c5:ec8 with SMTP id
 e9-20020a2eb1c9000000b002dcd2c50ec8mr1045244lja.39.1713947873789; 
 Wed, 24 Apr 2024 01:37:53 -0700 (PDT)
Received: from [192.168.1.102] (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr.
 [176.184.51.42]) by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c3b8500b0041a3b5ed993sm11238581wms.25.2024.04.24.01.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 01:37:53 -0700 (PDT)
Message-ID: <19eadc84-1038-44b6-af2f-61abe9a18b45@linaro.org>
Date: Wed, 24 Apr 2024 10:37:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d/cirrus.yml: Fix the NetBSD and OpenBSD
 Cirrus-CI KVM jobs
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240424074202.245646-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424074202.245646-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

On 24/4/24 09:42, Thomas Huth wrote:
> Pulling the "master" libvirt-ci containers does not work anymore,
> so we have to switch to the "latest" instead. See also:
> https://gitlab.com/libvirt/libvirt/-/commit/5d591421220c850aa64a640
> https://gitlab.com/libvirt/libvirt-ci/-/commit/6e3c5ccac77714be70c0
> 
> The effects were dormant for a year as the old ':master' tags were
> not removed until some weeks ago.
> 
> The other Cirrus-CI jobs were already fixed in commit 1d2f2b35bc86b7a1
> ("gitlab-ci/cirrus: switch from 'master' to 'latest'"), but apparently
> nobody noticed the KVM jobs so far that need to be triggered manually.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .gitlab-ci.d/cirrus.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



