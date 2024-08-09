Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9D4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scL9n-0002Ri-LQ; Fri, 09 Aug 2024 04:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scL9l-0002Jt-Mx
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:39:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scL9j-0001iZ-Hf
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:39:29 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-36ba3b06186so920907f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 01:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723192766; x=1723797566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=68ZgyUAZPfPVWK04cLRDBl8Wb9GYVLkXD7+nNU8ACuI=;
 b=Mlpcae/SQ1RLaruIUAu6P9JG8Uu9hKcPrjwPo3xnl8Y12z8Z4DDsNdSVc+pcnpyACH
 sMpSrNsnGHpmnBt+rwnQwAFn0sQzuyqoQ9R0nwz/Fxf1NmwXqh1GOCjJvMF0cDw5UIvb
 +gFjr5pAC0jz3kjSyV1rX92EwIcj8VhRSeZ/2QztfTW3bppi8uHlCFN2Xtr+rsm8t+F/
 oVn0HQJB2P8x7h5pKJ3YSNRKb+iC9N1/BRDAzVmJqT5LL4St8r6khfTaLg+lLp5kx9Fo
 S3eMytaoKyNyuS0b1xuTyWPXID3JB3134C1PwIr2bqbkS3HY2cOqT9iptHkxWQWSHx1F
 +Txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723192766; x=1723797566;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=68ZgyUAZPfPVWK04cLRDBl8Wb9GYVLkXD7+nNU8ACuI=;
 b=G6RG6ADyBZ2PAtsxkPRWB/ULmZU1SSgfgtb/O1LsbwfL1wIgIUb7IuK7XsGpeLTUqw
 n5rTlVCKsFeAXwrvChvAre/2/0YlmzBsfbOOmIlU93gzMGB8rvioa/mWa1/RYkAIOb2Q
 +PPiUTQ20sWuFX5q7Wa9zV7KV2MGTrUiI3IPj2gvi22TnMpZ0oS7PJxnFDWOYFZ7i1+Q
 e5khBgL9GF1IKZfLDmUvRi+bYTS9HJDusjYWN61kythQkhDyHxUchb+iPvbHc81xLJ6i
 KMgBsbziIUOYDjwMcmSmjSapLwuGfz5SQA7st35ZN+lK6+KVedty+ywB8u5kTns2Gjkg
 D8ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCjRWgU5QtmQupukYcuDAcEE8HkDBWdmyVm1ufROI8cQ7Q3QdmVz908AqkjZ0Sv9jX2MbSP6IbF3HVhP79zysiwJJWNNM=
X-Gm-Message-State: AOJu0Yy7b2FYAu9IZddr33pi9cVSFBBai0cOjtiWBInDLqCToej8AJHM
 qRqGCWMNgM/XZpKujLypm4Q1KFMFhv8OE1+DkOKBLBqnzWUmlcnej3CcxD880d8=
X-Google-Smtp-Source: AGHT+IGrA63awgIkKjoM2t1yLMZLu+jT2DCRe3ngcceviUlJGhxXV/A7655YAYkwFJ+2gRtxHEQLEw==
X-Received: by 2002:a05:6000:dce:b0:367:8a2b:7354 with SMTP id
 ffacd0b85a97d-36d5dd75e5emr638980f8f.11.1723192765780; 
 Fri, 09 Aug 2024 01:39:25 -0700 (PDT)
Received: from [192.168.178.175] (41.red-95-127-42.staticip.rima-tde.net.
 [95.127.42.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d2718a537sm4510098f8f.52.2024.08.09.01.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 01:39:25 -0700 (PDT)
Message-ID: <e32c4d75-9838-4dea-bbb6-6d86cd9f3d8d@linaro.org>
Date: Fri, 9 Aug 2024 10:39:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] qapi/crypto: Supply missing member documentation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 jiri@resnulli.us, jsnow@redhat.com
References: <20240808182636.3657537-1-armbru@redhat.com>
 <20240808182636.3657537-4-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240808182636.3657537-4-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 8/8/24 20:26, Markus Armbruster wrote:
> Since we neglect to document the members of QCryptoAkCipherKeyType,
> their description in the QEMU QMP Reference manual is "Not
> documented".  Fix that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/crypto.json | 4 ++++
>   qapi/pragma.json | 1 -
>   2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


