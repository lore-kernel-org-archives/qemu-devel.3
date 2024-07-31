Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B093C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 12:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ8lY-0000Ud-EN; Wed, 31 Jul 2024 08:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8lW-0000Q5-WA
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:49:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8lU-00071G-1K
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:49:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42819654737so31551505e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 05:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722430150; x=1723034950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jp0XEWfoV6UAMUmJuEK79uZeFv0OkdbSZRZPPBr/GmM=;
 b=TNjUiiAcFH6b6335nS2neiS3JBGAGG2D/yOQ6O4WpUNd9jQAyEOyM5FOHDo8I31PGI
 rsHT+bre2ixYqalPAybyBT4TAukpxAWpozYKeSL/laMu8iZPeybLq8mNkkc7nj+Y8n0E
 x0ZjM2F5qk60rGeKvS5ASE0/8QPQLFk/G9bjz8lH8VFSiVzuGCEuH4qdToTjWavd7CIs
 AE6jjWCVj0yGt7HnRm7W/NEpw8SHlI2ONh5H7zbJIQtUbpmZNLowE/4s0jdHdeopKxib
 W5KA4yWQSz2kfShm15Qk1LLhOxL/hM1B2yCDqizmDMbD98McLIhmBQTwWMKGG7DKYSDX
 NUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722430150; x=1723034950;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jp0XEWfoV6UAMUmJuEK79uZeFv0OkdbSZRZPPBr/GmM=;
 b=YGJsAu7hFEsAZmnPc1noLm3SNl2MpiqKB1zaGRjIr2WVYvY1GTTnziW1K9Wqcagt3F
 SUduyXrDSy9jlFV3XklNHzPI9OJg8OSNhq3YqzZUNLhwQw1vAAOviK3XjoVtkZrBuUwp
 buB3opK9gQL2YhsdSkLwEXWzhAlCHMx+8t9bLKOD5IhYQRF5LTxlE+Fi9753Uk91BbM1
 MDcM1Wr6CAF10KeqkxkJ+ElBGVf4J4eYV+dXVP5LEnqwkyDhu0no088dNZo0kkwLOazr
 OdS7vQcu6RFZHYjn3a3XbsRk8XUgWlEkcXfLeCcpb/ajGmpUynUSK3z8hbiGe64ISoeM
 3cgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYrN9Qbechsp/+ogoiUZ1DFOz/RlwL1W1w7WoFliPumvBRFSLJP+gbHHqHwC1cItttTaagtlzqBQzKF0oawkGcFaTdRt0=
X-Gm-Message-State: AOJu0Ywny98cqDH6a3Q+stMfV6hWouzqaa43Q71IpbBPMTKXmsz9V6hF
 6dwtFZedMB77F3zUrnlZODljv8McrjYO1kSrQWpFwA9GdBnGsDveGznQk27yIhI=
X-Google-Smtp-Source: AGHT+IH/TuMCUSBZVjKxsn7d0NGI/k4SSXOrP4kJDmvTaGmchBgnV04P1fxNrI7QGx3oAJmbt4ae5A==
X-Received: by 2002:a05:600c:444d:b0:426:6e95:78d6 with SMTP id
 5b1f17b1804b1-42811d71018mr92807465e9.4.1722430150492; 
 Wed, 31 Jul 2024 05:49:10 -0700 (PDT)
Received: from [192.168.214.175] (29.170.88.92.rev.sfr.net. [92.88.170.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bac5458sm20110455e9.23.2024.07.31.05.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 05:49:10 -0700 (PDT)
Message-ID: <46673c5c-2f02-4d35-8a9b-04a8473889ee@linaro.org>
Date: Wed, 31 Jul 2024 14:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/24] python: Install pycotap in our venv if necessary
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-2-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The upcoming functional tests will require pycotap for providing
> TAP output from the python-based tests. Since we want to be able
> to run some of the tests offline by default, too, let's install
> it along with meson in our venv if necessary (it's size is only
> 5 kB, so adding the wheel here should not really be a problem).
> 
> The wheel file has been obtained with:
> 
>   pip download --only-binary :all: --dest . --no-cache pycotap
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   python/wheels/pycotap-1.3.1-py3-none-any.whl | Bin 0 -> 5119 bytes
>   pythondeps.toml                              |   1 +
>   2 files changed, 1 insertion(+)
>   create mode 100644 python/wheels/pycotap-1.3.1-py3-none-any.whl

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


