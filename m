Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138E4EF99C5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqyFI-0008Io-Sf; Fri, 13 Feb 2026 13:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqyF9-0008Db-RC
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:50:20 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqyF6-0005MP-Il
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:50:19 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-82310b74496so740044b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771008614; x=1771613414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VQUCMXpt8/EMIihQeh1TPzgL08qe5OTDSUZujcmNfGA=;
 b=q8SrRQVwtwjlg63y0tNyBOAEZmh7gGtK08z7U7AKrGmSQhylxu4ULK8otdT91+MUIx
 76RKID7I4sMNZs9+PxM03Q3ykiVb3W2iJOvxJ93/ZRZcOE7+kjSCMG4McWR1HDnVIxrT
 92N4klMIhIZDmKZ+RPcLf0lCUY0V3H4Aid1E+5qJmQbpbHyo7xB77meLQ3IEL7JPu9nv
 FhMqHgedGwIiE5u6O7gKa7NSZ8v/wVhlEnOei1iR7go8jimq1NHpELhyK8DHsys8RHew
 fDP1ERhpCNQ2Er3O90bho1vjvwwpSJ1nju7oBsAdfT/9xdE/z21feBoaCFtuCN1bOwCk
 OI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771008614; x=1771613414;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VQUCMXpt8/EMIihQeh1TPzgL08qe5OTDSUZujcmNfGA=;
 b=p2mTTontZkKKB+b42Fn+x/W7+dI0XjmWfLpPRVsJal7vehfCOxUQWPDYGlOcwYPdZh
 dUFNI0IKNVQ7kTbmtRGiEqf++gwkdt2kNbBNIqYooZ3aeeD+M9lDgPI52ayJkSXAnrxF
 KzvBZ/UBbr9A9g69Lltaf533k7gxpEiKWmwRuVLzsTUxXeAG3my7Fkib2ifsduLBto4h
 Jov4LXqL35CzaHfcYV28mIkOmVPXj4FYTDRzeegKInjiQsdVd35JN5EQaKXcu48b52+Z
 sOHnvdaRTGiMpjwhx1I9CuXoAa0wQacuzY4ocLhtOgFXWdnRzL08kcHl7jBOaszv4C9P
 8PhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXiRIP6hk6SgKBjUzJ1yldP28mo6MCYGG8oEa6bNcJX6LsiIITasrToFDL0EBAbRAzf5PZgkdxVYMc@nongnu.org
X-Gm-Message-State: AOJu0YznsbKZ0IBgpRjOu0FLRf6p+bdlRKznDFazxn7vfJ3EFZkEArDw
 MNJAa3TvpqYHDiWYn0hDeDTgyWucPUTfber2YCIKfl/eEnSUp+dd6XUviurq9Y0/Dk4=
X-Gm-Gg: AZuq6aLyS1nqwsbeOsoFUFoB4u8I8e9W65gflocYTMiFuOFuu5IvHK9OTWf5Qomxkfq
 T7r3COe+wufmicP5aEwhateN/4AvoqRF1khB20l9XC87Vbs3Z1H4dcpSVytZWtFrLSFkd+uD/S9
 eF3uCbqBa6Urhd7rccjCp0YSJI+EwxbGtd2CBVPjShB9nwkNIrcPOT3wIzCvi3W5qjcdgesQTVa
 jBwhg9+jRufjLhWwfYk1QHtjg/V0jh41xtk8qYk6LtbDhGK7UiOI44uNqh3Ca7+VeNbwO9SVVfn
 EATQ3Ibouaw0GM2Q9hNcugqRv9mkDGCqMmbjrvh459Dcp01ww39qn1dirhDpQbTlxe+yqDswUcd
 QKDGlXpsuRo0ekxS3eWG8fCvRJOleSbQO80ykC1XlgkJ5WgggjE9C6xbjlb61q+4DDL0xXQ/TBT
 eoaDJR97nGJc8bK7D+BqA9Qt0Lpuz4w37EX8yHkDFdLUONMewIKT47aA1QSA/Bybk1Qx5jrCPAH
 Gt5rbA=
X-Received: by 2002:a05:6a00:3005:b0:7f6:4922:89c4 with SMTP id
 d2e1a72fcca58-824c9601758mr3062277b3a.55.1771008613712; 
 Fri, 13 Feb 2026 10:50:13 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6bb55adsm3196390b3a.62.2026.02.13.10.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 10:50:13 -0800 (PST)
Message-ID: <e5e753b7-da36-4667-ac9e-98f834fcae03@linaro.org>
Date: Fri, 13 Feb 2026 10:50:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] qemu: Document qemu_arch_available() method
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260213175032.32121-1-philmd@linaro.org>
 <20260213175032.32121-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260213175032.32121-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x442.google.com
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

On 2/13/26 9:50 AM, Philippe Mathieu-Daudé wrote:
> qemu_arch_available() is used to check if a broadly available
> feature should be exposed to a particular set of target
> architectures.
> 
> Since its argument is a mask of bits, rename it as @arch_bitmask.
> 
> We have less than 32 target architectures so far, so restrict it
> to the uint32_t type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/arch_init.h | 8 +++++++-
>   system/arch_init.c         | 4 ++--
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

