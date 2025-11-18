Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4119ECEE343
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 18:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQUo-0007D1-8u; Tue, 18 Nov 2025 13:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQUa-0007Ad-5X
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:31:57 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQUY-0001W9-G6
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:31:51 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b3d4d9ca6so4746488f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763490708; x=1764095508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3xPEYtAVCthWcnX00lwhr8U02DKSBK78TmnGzdiH/58=;
 b=uCMfSON7kfHKB46sRFmwC4NZ0Kqml4iV3bRcYoMoZmk+mCiVwy+EalVXwINfSdzM7e
 dJCw5fojbASHU+0aWywn3FbTx0ghnrD1RiuW4kHpbDQse+amSVgr5gpPwPd9jfJ8D7cV
 8hKAVcUW84/fSemhuYY1UPxXegu4X/PQBVqjylLx63Gl7TLF4CXKKlL6XSxy6IQd2P9Z
 tppaDydX0QWpXu2ibjYemZ1ZY/aJJBfjbOgZvd3Betx7FSvz5YDYcrQrd92+vTwmH6Fv
 Eh7sAfPaE+I/CF8Lu6O7b3qMo47tQfdP9wjZJDoFn8t5c+zIz6hFF5XjtG/GbNv2x2gM
 QsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763490708; x=1764095508;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3xPEYtAVCthWcnX00lwhr8U02DKSBK78TmnGzdiH/58=;
 b=QhgBshvkmONc5Rauua+1FIMSjd2gi1azYad3Ga/GzN4YlkkXmouwa5axGtr/uwGwBq
 pTFj4EvJn9IkGzGG0YdIjAy1UwCO17peyqGNrkjexC4JsUy3QLACsSLNufGy8esOICwa
 gFDWpObsF3kEiIsAFTvOEQy+PbUBVhzHl1hJftze2nNIi7GLPuXEoblcgWt0r9Q2KLaR
 FBxRBpOZYZYPIIJWKc1MGNcoQn4nAiWZOO4d1zLfuM3oNU3xG0j8mlwQqvWxNw3BR9zv
 efyBzt4Bb6PfVJJllMIdLoOjk7dhTOGMoYI+qyKhYJiRQU98kgf3gqLeXL2E7LkGEver
 355w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTFlXEuoGnrG4uqgYwfGP2mlDHCe6anGr6eSv1NMp/BZg3JNPEwU/mpEtRbuJlXXq8RQ9OFUlvF1mR@nongnu.org
X-Gm-Message-State: AOJu0YwmSxnGVbIWRIi20cW9NxTvCxqd0dcql4HaESVDN4cWp+GbwBFR
 Ybq0Roi/Lx3CDSujmy575wdTWsMpAy5aVl8h6JimgiY+gaBMNZ8pm/leJ1pySyc+nfI=
X-Gm-Gg: ASbGncs+7mR7oVktdn3JtlaiecMZ+XTuOcAtN/SO2V7qNN0Wb+CVIr4zsvzaphg0HoB
 3pS1QYoSMFFxYjG8+CSrfIoCc/uMtvF2EDMG9cUa9OB2JDF9HfFYONmEXLXiuQJId5ynwmk8PWu
 PXqf5gE2IbvQEdmPtZHWKNCNhzDGcbW0KCB4HCPlXrcZfQuIkwnAPNfZ7x/OaxtLY8OLUdQpA/D
 4w3SWutoZtyiyjPvCVoADMYXD792qXelm+MWGinNYtIAVHAuRqLMDlUyirkRBmq7MIbhDJrLykw
 Nh9+vmoU/iudQQ3u2OL8GOQb2E3KOrDE2bQ5VhYEP7lb59Ng/PByfDsZHDEI2PiKlzmXHYHm5kA
 KIckC3tvPMScrkehe0VNKDyaFTksDWIqp1BLIitZVkazehOKdkAseM2TIGzr1Kuu4tYRx0DOMyx
 86B3N0lKk7gZ/UZLzu87d+QJ+gGXKxfnM2/4xlUzDzIHhbeoRP8kyFHxLBpIe+kCsb
X-Google-Smtp-Source: AGHT+IGw2+iYZTOcuyRdaT9YffCLbaDzhukY7iuYwL3oqhKVUOepO1J0fqgI6bQOZRXIsQ/yCsY0vQ==
X-Received: by 2002:a05:6000:208a:b0:425:825d:15d1 with SMTP id
 ffacd0b85a97d-42b59384374mr16100983f8f.44.1763490708522; 
 Tue, 18 Nov 2025 10:31:48 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e85627sm35339570f8f.16.2025.11.18.10.31.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 10:31:47 -0800 (PST)
Message-ID: <6bec3310-5919-44df-ac38-b2ecd458ea5a@linaro.org>
Date: Tue, 18 Nov 2025 19:31:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ebpf: Error fixes and cleanups
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, berrange@redhat.com
References: <20251118154718.3969982-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251118154718.3969982-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 18/11/25 16:47, Markus Armbruster wrote:

> Markus Armbruster (3):
>    ebpf: Fix stubs to set an error when they return failure
>    ebpf: Clean up useless error check in ebpf_rss_set_all()
>    ebpf: Make ebpf_rss_load() return value consistent with @errp

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!

