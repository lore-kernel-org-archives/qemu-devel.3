Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF6DC46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpFN-0002Xm-H8; Wed, 24 Jan 2024 21:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpFK-0002WF-Gx
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:13:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rSpFJ-0005k2-5k
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 21:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706148816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbOWVHLWrEllIjLWxH6N9QIFGu10xS+Eyveo/tRa8wE=;
 b=jSF3NY58ofV7Q2V5cBszQaEhBrTaZNjzehUljQkwH+Xllu0HRa5u6mr60HQsMw9FAKRaT+
 J4CmXXLdGg+B2ZOZJxiahC+Xvd774LZ7cm20PFL00sOMvU4ib3lXxAOJvRjeyvOyBGIUww
 wIGom6BhEVB9oyfpuppYvtIYGhzbNmk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454--GY9hPhaPq2QS5sa0o857Q-1; Wed, 24 Jan 2024 21:13:34 -0500
X-MC-Unique: -GY9hPhaPq2QS5sa0o857Q-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6ddd005c848so69566b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 18:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706148813; x=1706753613;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tbOWVHLWrEllIjLWxH6N9QIFGu10xS+Eyveo/tRa8wE=;
 b=B9ZpOnAeR0RRm65JcjakJnhFUMIMESnVnhN4KZEASM4Jt8v3EII1vqUDqHbyd4De5H
 ZtJ0pb4lF3HegISfSJpYO14kz1dMBS/ld61jxBHdM14cEj/ZIDu6l5xl1wWYXPzz/9X6
 rH7vrRgYEx3YxWXcvIEhtTOSytG4SEWAuRMla9JV6urta08aON/wb8DbT11r5XM/eZAI
 hNUxtgW/GM2bi3vDQSCCB5+qvpT9eZEl+Va+A90dcBk2ZjLQVhgkz225oEeBiMlfPFf9
 PaZW7fah5PN8ScQfzVkMLrHAg4whh/TQUjzfkzfIMgXC96GeJWboqsKwv3R9uHyIKwfb
 2yhg==
X-Gm-Message-State: AOJu0Ywmq/K1flZFJE/tJqG/MK+Tx26O/4jVwNjSxhAoTYzLyXF2TE/c
 JaFc8Y6D0h7NoAZzunrk03a8X8QmoImjeGPgijpv69R4ceTV3SF1pTbwKXMFhR3Cmzyoc35NWDX
 V1P++3qyC7QXD+3MbHVfV1L7DaL5QLorVoJXFx05rGZSXs09ctOoA
X-Received: by 2002:a05:6a00:2295:b0:6d9:8f6f:6b7e with SMTP id
 f21-20020a056a00229500b006d98f6f6b7emr168340pfe.56.1706148813133; 
 Wed, 24 Jan 2024 18:13:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5RKnKO4mRHthMGp6eM6oWJrH6M2ppCU4t3BOI/0aJ4ZmUrNvbVNnoYN5VqMnQhg6l05llJQ==
X-Received: by 2002:a05:6a00:2295:b0:6d9:8f6f:6b7e with SMTP id
 f21-20020a056a00229500b006d98f6f6b7emr168323pfe.56.1706148812759; 
 Wed, 24 Jan 2024 18:13:32 -0800 (PST)
Received: from [10.72.112.202] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 b19-20020aa78713000000b006ddc661a619sm423036pfo.7.2024.01.24.18.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 18:13:32 -0800 (PST)
Message-ID: <4adbafc5-82c9-4182-bda2-0b3ebf2022ff@redhat.com>
Date: Thu, 25 Jan 2024 12:13:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw/arm/highbank: Add missing QOM parent for CPU
 cores
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240123222508.13826-1-philmd@linaro.org>
 <20240123222508.13826-4-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240123222508.13826-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/24/24 08:25, Philippe Mathieu-Daudé wrote:
> QDev objects created with qdev_new() need to manually add
> their parent relationship with object_property_add_child().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/highbank.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


