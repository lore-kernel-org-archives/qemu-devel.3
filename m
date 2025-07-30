Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C23C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 19:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhClS-0001mh-NH; Wed, 30 Jul 2025 15:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAsK-0003vI-JJ
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:46:04 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAsI-0008OM-HX
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:46:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-24022261323so12924165ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753897556; x=1754502356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=duG/XEJbPXmgtcb2K9ZA/+h4qoNbekN3/DWKVKUxHfg=;
 b=poNFVpKKJ9mivSwaiPPIi0GC+pyk2khShPAiB7m0yp/r7EWdxXzRYQNghmx8pdZCSl
 V8I1G3cMUOwtSlXkjlEmQQJ65TdQZbkSA1zh7QWamHEy2sQXr+hhJoK5a9SQL11bscf8
 SCOEZzNrl0ZWMWOoH/TzfXrEGTe/BMCXtqrtRRA2sNjLaTOJOQbYtpVZICF7qbGSgNHK
 QCG0qB2HRMe+eY4wTHMcHKwhtsKCVb4g2PAe1GBvv68LH2PLZGXykyE597tYGm+zuaAs
 WXKMqWqTCUw/dd1yYd7PvKvawseU0h6ER/ezQolLXZz5cGOIWRtDjGdKBFf1Y6zxWKAm
 tesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753897556; x=1754502356;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=duG/XEJbPXmgtcb2K9ZA/+h4qoNbekN3/DWKVKUxHfg=;
 b=hmdYDzhJDF+LZschU2NbZwaRBrNf8EisigA+tNjT+lYciucjl24/dgzs+AmOnKTWbD
 a1LzEg4OeXgZDq+fp8qxJFM2D4smi/G0fa7ID5RqtKQTVm8cq0quV1Edd/5+WeodrUGD
 uqQoy9GlwBeqXeD+BBQ+vw5jGJeIeqq6W7qYhsniPppx3u9snV8+6n/+FuugWCVEpGxy
 viE/FMKoQdBWT4zYSWWRJHmaNghxGDMWDnQkUqxeafSGNJGXAnSBcLWoBa1DX8MryO/9
 I7EfZNnAiLVRN+sKMhYVuJRNYLNLT9MiLbK6TPDvHww5pSxRDFj2VWsQsp9bqOTx0kbF
 aCfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk+KXfajwPFM8EjTFxV9mQjc8zADXOBuFvv67zn60OLxRA9POBnBQLl5RY5Py9+N8HvnCeXLukfFZW@nongnu.org
X-Gm-Message-State: AOJu0YwpLRI7qs35x1GOy9d784YbCcp0crK5S8aPbVPSCmFKbdXijhtE
 Aqm0Fu4EVgtUYm24BMyZvS8pHQ6fEPzqIeZNc+ZHOl1pUasw1gZdiYc1aT39fB2PPg8=
X-Gm-Gg: ASbGncs2TGIzlls3M4k5rRzBczXlv3W8vBzDgE2yLU3M1pli7ojYCZz7WxeyX5m/fd4
 KPlp4DQHoO6h2864F4XC5RAa4DqNWEdDh4PJoEqe70cmTOO0ngs6WjQnCQmMCI4A1vOt5LsBEDD
 P+Qdv/fHKq0qoFDgjwRGFp4rgcVzPgyyljv2rzJQZvdTVOAti7p1rFQuI5IUTgSFNGtsbFJTe2r
 zUhbwp895VB6vCrdC0kbTYTZ7sY7yos//ZHCssJ9E6+Xf1yOMeX0E7v9jH+gZk1DDHCgDQ1dlF7
 R/q/dZw4DfViBHZO97qiFTj85wXTM/dgyTTYz7tV/iLid+JM9E4svKSbmhRz2SJH6O6ZCCAZC1M
 QV7ls0BTagmYvL1GBW0Bg4TeUaixIp4t8c14=
X-Google-Smtp-Source: AGHT+IEMBhtmNFJtlGXpxjy6HclVHoEenwjsyAVLB7MjcUrrQnfzd0oxv+YmIMjb3cEE4Ztx/86qMQ==
X-Received: by 2002:a17:902:d505:b0:234:325:500b with SMTP id
 d9443c01a7336-240968b0063mr60570165ad.22.1753897555785; 
 Wed, 30 Jul 2025 10:45:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-240cbedc0eesm2213805ad.85.2025.07.30.10.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 10:45:55 -0700 (PDT)
Message-ID: <42da78db-e6ba-47c7-b93b-3ae51fb62f79@linaro.org>
Date: Wed, 30 Jul 2025 10:45:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] contrib/plugins/hotblocks: Fix off by one error in
 iteration of sorted blocks
Content-Language: en-US
To: Alex Bradbury <asb@igalia.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com
References: <cover.1753857212.git.asb@igalia.com>
 <f1ba2e57c6126472c0c8310774009f2455efc370.1753857212.git.asb@igalia.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f1ba2e57c6126472c0c8310774009f2455efc370.1753857212.git.asb@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 7/29/25 11:41 PM, Alex Bradbury wrote:
> The logic to iterate over the hottest blocks will never reach the last
> item in the list, as it checks `it->next != NULL` before entering the
> loop. It's hard to trigger this off-by-one error with the default
> limit=20, but it is a bug and is problematic if that default is changed
> to something larger.
> 
> Signed-off-by: Alex Bradbury <asb@igalia.com>
> ---
>   contrib/plugins/hotblocks.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Thanks for this one too.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


