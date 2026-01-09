Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2107D277C0
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 23:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veLxF-0007QV-R5; Fri, 09 Jan 2026 18:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLxD-0007Pu-Kz
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:31:39 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLxC-0005Wh-4n
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:31:39 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a09d981507so26977555ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 15:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768001496; x=1768606296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/On9YMRS5wamKSpu5GSINZCNGcVZMOKt1wIVcT1yWYc=;
 b=R/+arRdInAKXNRzBe6U//qoyV6fxwAoh9SEnZfFEYYpOAETNXMRlLVu1wzDYCAulq4
 MuXcIWZ4kH2YCtAKlVq7G16Cz5gKYaPBdDH4x7q9Jb1YSmE70CyjdnV5whPKQvfLTjtN
 NuoFwYFB+oR3cbUr/Vpv1W8ZISeyTNBTkz+5zy2XRpf71b22WXWoePwvvJ+1kbcrGhz6
 UxwA403A3jOyoh4c7BXXfi6ypbmjJL09jYlvAXi0WTZ8pf0NK/hTb5khrADcu4sLpGGa
 KrFqjjSjDB1JBpQpGfRkHh8W7aP+PShpmkVzbC2L2ZlBpJbu2HYmcOU6Q9H5JKf2gLC+
 pj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768001496; x=1768606296;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/On9YMRS5wamKSpu5GSINZCNGcVZMOKt1wIVcT1yWYc=;
 b=t+IzIeYy0MK9F/eisAdjIsbRGJj0eiGm/ZdW8EsARk7r6hVNKAPXqRb3gO0WGbvSCp
 GYDxMI8iOcUSHouXw7dKXZAX9CpMox6bnNpCq9qvfJeI7D+1gc4M29vj55EgGN+rYxdw
 1LDrKndAMYM3+ZrOEDymOKPRPDVI+rICjK2hSxMiW3qTiOtGZr8C4PL8u2aWC5SUEHwu
 SLyMfmBxS+QLTy7TZA/159cpb+Mm5jUYmUn9UqDf9/xr+OIenjTtaPOyEViedGnXpyTU
 Ooazzg2vL1RiB+1tFE+kL3Ht0eNLT5E2QFUl3FZzYWCIzIpQFHZ/rQh75sQXrR9RgGYc
 bPcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqRFqPFmx1nYS4mGaTEZKCF+BaEMdfttmaexPJE4OzaiifbVRJHt9im1P/hLN0hJt7K5+3L2sDMmM4@nongnu.org
X-Gm-Message-State: AOJu0Yyaf/vujV8dIbeKKJ/n0sidiMxrT2aQqZsQc3VWvf1MM8ayboPL
 +K3lNG0HXWA2WHsMHFQzngk78A/qtkmNhdOhttOZzuhPb8lvJdFw478UKDh7vcFessU=
X-Gm-Gg: AY/fxX7rFYQUTWwaoUMlWjBvCeqcE3zimGfF6qUTA/n5I3IDek1tPwYdEt5RUoy4lTA
 vw9iXX+3xJ3Y2m/xq2/M2E5lSqRW1S4c7lPhJtUcruEOYrI7MCZbCBl+dtuwSAWSyllu+GsmSMf
 jmF3HCJQoPwB5FRY1iYzrBEf4ANoXBm0So2pKvlXMiPyr+/71Wfqds73iNipTaOnGRMBahnmE8W
 j26mQXrDzLnCWD2CnvvQVV1CQx4386XuZnXerF3OSdnav4ahz91tQDJrjZ5abpZyU0VdR/VhB5M
 Ln2Oud3MsrSuwqndWSZVd0eyEXJ9BBXFrl1BNHMEFWzrsfZ+ygkZCVzG6IWDYwnT5ruA/7/MLvL
 izmDBF58k1mJbC07dTHs0tl7FfHQ+JRadtUYjHc7MMyR+kAsWA9+JVIR1PJ+XmAzpY3bCVPmK6b
 EEQh9wV3zXKXK0U2YwC5iBYGDV3w==
X-Google-Smtp-Source: AGHT+IEvaIQfQVblt6b7lIsGZkE0HSfHMpLrcDjH2lxARewsVLMYaLC4i72dd2v4wudZC7tCrocbrA==
X-Received: by 2002:a17:903:1a27:b0:29f:2734:837d with SMTP id
 d9443c01a7336-2a3e39fd48fmr150742305ad.28.1768001491970; 
 Fri, 09 Jan 2026 15:31:31 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a2ecsm112612675ad.6.2026.01.09.15.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 15:31:31 -0800 (PST)
Message-ID: <a86928db-ccdf-4cde-9e6c-e07e5f65a9ad@linaro.org>
Date: Sat, 10 Jan 2026 10:31:27 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] MAINTAINERS patches for 2026-01-08
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20260108085850.1790958-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108085850.1790958-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/8/26 19:58, Markus Armbruster wrote:
> The following changes since commit 63a88166ab160d7d92da60b7fcb562c127e51862:
> 
>    Merge tag 'pull-request-2026-01-07' ofhttps://gitlab.com/thuth/qemu into staging (2026-01-08 07:24:44 +1100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-maintainers-2026-01-08
> 
> for you to fetch changes up to bfb8ab8370c6cbbb74fc55b4587ca83c71e623f6:
> 
>    MAINTAINERS: Add MAX78000FTHR section as orphan (2026-01-08 09:53:09 +0100)
> 
> ----------------------------------------------------------------
> MAINTAINERS patches for 2026-01-08


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

