Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AA2C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVya-0002ZJ-7g; Tue, 20 Feb 2024 14:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVyY-0002Xy-QM
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:40:22 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVyU-0000Sj-TV
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:40:22 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so5204868b3a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708458009; x=1709062809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qwOoLzJwhge6FpSQFICN6eZMnhiQH8lEQ4sgsmL6vDE=;
 b=Lxi1PXTHpfokQ4M7qaIM7M463RN2X7Jq2ZrUejwtCY1O73PjmCp4fT24rgPSo0U2VU
 /ZUJLkoYQMW+pIt6iE6CZRlUNV0RoML8tjSoZG51W1IIStLMZWd0zbxC1jLX2syhOc0m
 Y+JUEiRhYM0W9hEaFDAaiDYqEVg3/1AAWpZFVlFeGClhbh538PRgCLRSZw/1VcCWvZXA
 3YX9tBiKMpWSrO41n8AXzAuMPI6gDbpIW6UdYxi2/5ysgcOxGzsCHza06IH5X+yqYIz8
 M+ZPi9R91cDPfn8orVKmr2NgAu4xtEdNGnUVJbAu2RlSyAryUnSvIBlqppY3joUdqIpg
 /tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708458009; x=1709062809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qwOoLzJwhge6FpSQFICN6eZMnhiQH8lEQ4sgsmL6vDE=;
 b=cf0/zfeV9j1mtI88/tkh4iz7LkDjx//i58DaDKTqTmgoG5Imn+eZnuiSbj8bF74rAY
 dffnfZP8kqH2diEGo8gxYu33QrEBNoGgYYeWGMFHH0RonVSMh3A/T/Okg5bC2QQ00V9h
 izXtC/AuJoM4d29bYVDuELb60/7mu4RP1MeL/SORTmZqaGQ4n568exniw+fZQrfs0oRs
 yusp1f/lKlZmlsYWB/zv9rZG76ioq8BIcnzKJ0k2EN3rB6zNE57Nv6e+oJOpRPfmYL0+
 QqTE3KXg420n5bUPlwG8xgkt6GN5DjdW5aYxAHpIOBtE4ACLfCd4nWIhP3fZHbCKyfsc
 ZiuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9uKXsINQYKN6zbSoTpHczLRxVoiHd/8BS7rGCQIpl9L8S8ToRG0j2o+Y3NEEZ35SdO4V160jam/7llOPpDdGLGl5ryzw=
X-Gm-Message-State: AOJu0Yw8nNojDav9/VTB37gq8kXA11afVvp/+ASXeRQxJZ9hoIQOy7cM
 PSpbs5ozjuo9wis+kigxSuOakIIjf28doU0EmRcHXQfHzijI19rSE6xm3FUIW5E=
X-Google-Smtp-Source: AGHT+IGsVrlrJM/J27LnE9rHWGOgdQVM2TiP8px1qk6HsMuH5YJe1FU+OtfU+gQlruFAkLU+MLIhJw==
X-Received: by 2002:a05:6a20:e614:b0:1a0:6873:9bd2 with SMTP id
 my20-20020a056a20e61400b001a068739bd2mr20430570pzb.2.1708458008936; 
 Tue, 20 Feb 2024 11:40:08 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 du26-20020a056a002b5a00b006e45ce4ba27sm4982630pfb.127.2024.02.20.11.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 11:40:08 -0800 (PST)
Message-ID: <55dc0ccb-1b8f-49f3-b387-cd80e737836e@linaro.org>
Date: Tue, 20 Feb 2024 09:40:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] include/qom/object.h: New
 OBJECT_DEFINE_SIMPLE_TYPE{, _WITH_INTERFACES} macros
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220160622.114437-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/20/24 06:06, Peter Maydell wrote:
> We have an OBJECT_DEFINE_TYPE_EXTENDED macro, plus several variations
> on it, which emits the boilerplate for the TypeInfo and ensures it is
> registered with the type system.  However, all the existing macros
> insist that the type being defined has its own FooClass struct, so
> they aren't useful for the common case of a simple leaf class which
> doesn't have any new methods or any other need for its own class
> struct (that is, for the kind of type that OBJECT_DECLARE_SIMPLE_TYPE
> declares).
> 
> Pull the actual implementation of OBJECT_DEFINE_TYPE_EXTENDED out
> into a new DO_OBJECT_DEFINE_TYPE_EXTENDED which parameterizes the
> value we use for the class_size field.  This lets us add a new
> OBJECT_DEFINE_SIMPLE_TYPE which does the same job as the various
> existing OBJECT_DEFINE_*_TYPE_* family macros for this kind of simple
> type, and the variant OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES for
> when the type will implement some interfaces.
> 
> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/devel/qom.rst   |  34 +++++++++++--
>   include/qom/object.h | 114 +++++++++++++++++++++++++++++++++----------
>   2 files changed, 117 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

