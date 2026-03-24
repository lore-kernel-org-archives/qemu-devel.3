Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7E1F54AC7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52vm-0002P6-95; Tue, 24 Mar 2026 10:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w52vk-0002OV-Lk
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:40:28 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w52vj-0007Xy-4a
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:40:28 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so3673728f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774363225; x=1774968025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/SXj4H7HP2XVHFTch68KGJ+xNuAOFKZUkUODfKg2QzY=;
 b=qEylFLk6rwSvGITsVEFShGq2dwY6MNaaHRAKv/Dpp48F1ILolAx8o8mAUbZKFRMCVw
 tfSW4vH4q6RbrKWUtkqOVkK7bm8KFkYtptx8dg4SEjsI5D+dn4XZBPlTHSsNgHGV1TnQ
 V1984McISDlbPS2cUKuzjDRuziV6GJcJkR4Q6l6pXyhkUi3txpIOSfznFgM0IwqnKorf
 eCqvw8u3W/1PnE7/Gjs3+lf1OMclg3i9NKO0OT4tL6hoaMZIdcQB33OgOfcg/iVKjbn0
 VjHFvOyqY8+C3O9YqzVcalSv5PQ7jWIoQKkFrrKAGudGSeD5GrjQgCrw4WPP/l1Ah27s
 VBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363225; x=1774968025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/SXj4H7HP2XVHFTch68KGJ+xNuAOFKZUkUODfKg2QzY=;
 b=giCKlWw+dSizQRu4w3/cqh3yl8wlq3FyPXr0iB+AV8HypFoRsXIVNR+I/7071vBmuC
 +ZgbfcExEnsjGFjLn+oLuD8NqNYBMQpVdGMxQsbLUwFmJEp20yjxjAReuRjmV9rro11/
 R9nFIyWOVrVpKyUjNJfIlqUW24Rv857kbwU60Vwr9Q9HNHSFuAnfkJG12MOZBOrdXfhD
 f6caWi7flxBOLRQr+Liiah0Uu4m80hY0ob9uc5jpcEQfEiNaPT8srTBdV+G0ofjQXfHu
 caK1Wd9kBmyZP0nnz8gEHyggbFp/U3yTa3ADsQPUg920bgdNwcZDfAqjN1FuFxdBYXI8
 VnRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGvN8H5c6Ogc+mWPaGG/0rLcWs9t1V3K++LYIe9JZ0e5g6NZnytCYMzA5xRaz/n7HIlq7xFuz8att2@nongnu.org
X-Gm-Message-State: AOJu0Yy5hBlQzBr9FpTHUiJB6fCWg9G7jPXEaT7JPSX9gm6KsYTvZTzq
 JagI0zPcTR6AzrTf6XXDjygLuCq4Qv/IQ7VyDB7PJL8sHLyCczwh97lRPI8bhdsprKA=
X-Gm-Gg: ATEYQzzOHpirO0TCZJgiarE1LbdZVXhCQ7ajbyOSJXofFhfIjTnFOJF4y9Iedy2jru6
 qplOkybrhIT5va1zVEX0gnuhWXcXvD7GGqxuIzP7sjQaGpP6ZYE9EIowAQx+aQrv/cM4mM/U6ST
 qVwMAzEG03ONGM3fHXbW/DwX5yDkZyBE0qixxZzIKaopsozFHMNlfwjZpI0Wi7mfHqpDb1z+9vf
 6CpcyXps/iIUSZzFbUelzjJJqB2QJkHobJN7jQg/rN+3I6p5IOktalB3RLo3XBuyBF0UT+kFdtN
 HQAHfcse9RLwdPRJQPXCe1TC9xEG3h1/zw3CxamIDXq+V27zX8qDpTdZUdH/BjL7JM3PsiolAao
 2l/YNd6io3rBFfoiw0Qd4OAqy+8VlpPEwibG/sQUCIZs9xFJA+bNND6qt099QsGN3BDZMU6oWFu
 tNatPVfRXYetMFT70m7wUINq56PtiG4LwdyaQo638PvKZfXH0Xph1F347EHsczNHucMQ==
X-Received: by 2002:a05:6000:41e7:b0:43b:4133:658a with SMTP id
 ffacd0b85a97d-43b805c9685mr5485704f8f.30.1774363224575; 
 Tue, 24 Mar 2026 07:40:24 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae16fsm39045814f8f.8.2026.03.24.07.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 07:40:23 -0700 (PDT)
Message-ID: <58537a1e-9716-4abd-90a2-59ea4b971017@linaro.org>
Date: Tue, 24 Mar 2026 15:40:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/usb/hcd-ohci: check for MPS=0 to avoid infinite loop
Content-Language: en-US
To: Jenny Guanni Qu <qguanni@gmail.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, mcascell@redhat.com, peter.maydell@linaro.org,
 qemu-security@nongnu.org
References: <20260321000444.909451-1-qguanni@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260321000444.909451-1-qguanni@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 21/3/26 01:04, Jenny Guanni Qu wrote:
> When a guest sets MaxPacketSize to 0 in an OHCI Endpoint Descriptor,
> ohci_service_td() transfers 0 bytes per iteration. The Transfer
> Descriptor never completes because CBP never advances toward BE,
> causing ohci_service_ed_list() to loop indefinitely and hang QEMU.
> 
> Add a check for MPS==0 after extracting the field from ED flags.
> If MPS is zero, call ohci_die() to reset the controller and return
> an error, preventing the infinite loop.
> 
> Fixes: CVE-2026-3890
> Reported-by: Jenny Guanni Qu <qguanni@gmail.com>
> Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
> ---
>   hw/usb/hcd-ohci.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
Merged as commit 129922c2bc398b656a9180150e667f98fdf0d402, thanks.

