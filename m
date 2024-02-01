Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3B0C47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWSa-0001Py-PT; Thu, 01 Feb 2024 07:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVWSB-0001Mz-Oy
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:46:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVWSA-0005nj-0E
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706791561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O9clC6sv9ByZKGN3sbyAhPx8HBkXHyz8S+YSVDWB3gg=;
 b=BgdGAGJKrtzps9Y8XIWF8QvK+G0Sk0yWB1tvqsTVzMZ7BQ5PdWr4laenaEmAw4OYBGEL0b
 NopFVu2oJ3nzv1115E5uSpmb2jaPcX0g7hETZmOT3D7mJxCv98E4ZdwQ658lBlNtY4Z/hz
 DvIqxSgksSeAvVWYGqh1KsA4Re3N3Rw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-38yuYSYLMbGFBorWzWV69w-1; Thu, 01 Feb 2024 07:45:59 -0500
X-MC-Unique: 38yuYSYLMbGFBorWzWV69w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40efbe60d32so4536785e9.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706791558; x=1707396358;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O9clC6sv9ByZKGN3sbyAhPx8HBkXHyz8S+YSVDWB3gg=;
 b=fmMaFdaXeWll/b6NabHWem3bOg1JTCiQuBfddQyu5QJbD1DlBHa9L1BaGyzkS8i+X8
 ZvjguOK5u/CRXgnbpk6nxKte+Gnj1QqeHfPjfvbTdwsUwDRg6JNnnpEePKj/V61pGYBC
 JLhO2JzS7Ft+FRU1tqEu55ZrTe2XN57XTzQos0OVffyoFUHNNhUrHqHjRxJ+m+ji94S4
 j+LvvAnsJRTzpjBEHPxHDKoZtqQ8l6FSTsPhSsrG/1j1K8x62MxqNll+McjBaLT1Fr9s
 tShgZt8SHY7Rb6cN+1WoNggLHjW1MGMnB4pqPxe0UdNcaL+JtBCiFSWvzjq3akkd4+36
 zDBw==
X-Gm-Message-State: AOJu0YzlYelMJIjVglk2butkdTyZUyWhgYAhoG3dCtte9Gz47TdSefDQ
 kMWP9Xst1ruafJHcfEVBnwxb/OvDQ1rkzOrSQl5v2ZfVVxm4Hk4Hd1310oM2IBhq5OZNPmDCNgg
 dA7Ij0GQOf2wtJnXq0g9FpIRfNIC6Q1bZeWkQ4na04C4EQN0vJ7kb
X-Received: by 2002:a05:600c:4ed1:b0:40e:f9f4:eed2 with SMTP id
 g17-20020a05600c4ed100b0040ef9f4eed2mr3782712wmq.28.1706791558375; 
 Thu, 01 Feb 2024 04:45:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDRcbC19xVDHx5NlroNzVq5ewHr7BtxWepacjm+e4ZFtUIFPc+WRTK6Ca6t+lP8PnKXVhIhw==
X-Received: by 2002:a05:600c:4ed1:b0:40e:f9f4:eed2 with SMTP id
 g17-20020a05600c4ed100b0040ef9f4eed2mr3782697wmq.28.1706791558062; 
 Thu, 01 Feb 2024 04:45:58 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUwNC83l9kQwnkTizLFwk56slYcmh2VkP7MerzNE5Uk6wTpnw5yxbLDZYkVoX5kDvBmPAgPX2JJKQu+doP5lXLGoI3jRrVQXDnj2ETN4SzMdCFnLkE+uD9EC5SUEFlaiRm5WoHWhsH1+K/9I3Lr5bL7PFZrzTiWy3/ka6LTqZpSCs2ddObSISoYsOe9T9Uxfg3ZTVz8KmBO7qDaealW1jFGToCsuAMiGQHexm+1lNqBLyO0erfk/cb5JY5oyJPYf7sksPdFymte2uo6leU0aWqJ0THFhVO4dCufdY0lzeqkoWvu4ekabTzbhD4HOPJNDsjmTe/jHvSKG9894Oe4wERebbMV8QjhJzDLRsJD2TtpFkheq4YXH53JPDXwHckMrD4FhjzV9LvWrfr0mdi1QSWnmDu09ZfDIbmnjjwXpoZupOpE+tYwKU/RFNEhehjxZIrv8jC9b+R4jpiATT9t5Ja/SQhr0vk6K3BAkzkc+31jAq1X1wTD7kYV9KElBEA6jUTgbyz57Z5BUMZhFamx3Vv+x9y+j1JLBMy7Pdm7kBKDgR1Hep4qsOoZBsQl3IILHOLZ+BzpvtJOZTvJ1tRHjRkP+PEp9KyIk9yzw/qB44rTL6zVKpz5TMJPS/lXirxHSqbVLCpDlLwQC407ZgyMl0G3p9QBnxWKkFw+I7DR1d3v
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 p13-20020a05600c468d00b0040ef2e7041esm4365169wmo.6.2024.02.01.04.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 04:45:57 -0800 (PST)
Message-ID: <69ce5d38-7bc1-4cd1-88d5-94f61161e588@redhat.com>
Date: Thu, 1 Feb 2024 13:45:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] docs: mark CRIS support as deprecated
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Beraldo Leal <bleal@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chris Wulff <crwulff@gmail.com>, Rabin Vincent <rabinv@axis.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
References: <20240201122835.1712347-1-alex.bennee@linaro.org>
 <20240201122835.1712347-3-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240201122835.1712347-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 01/02/2024 13.28, Alex Bennée wrote:
> This might be premature but while streamling the avocado tests I

s/streamling/streamlining/ ?

> realised the only tests we have are "check-tcg" ones. The aging
> fedora-criss-cross image works well enough for developers but can't be

s/criss/cris/

> used in CI as we need supported build platforms to build QEMU.
> 
> Does this mean the writing is on the wall for this architecture?
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Rabin Vincent <rabinv@axis.com>
> Cc: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Message-Id: <20230925144854.1872513-5-alex.bennee@linaro.org>
> ---
>   docs/about/deprecated.rst | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index d4492b94604..82922476d72 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -183,6 +183,14 @@ Nios II CPU (since 8.2)
>   The Nios II architecture is orphan. The ``nios2`` guest CPU support is
>   deprecated and will be removed in a future version of QEMU.
>   
> +CRIS CPU architecture (since 9.0)
> +'''''''''''''''''''''''''''''''''
> +
> +The CRIS architecture was pulled from Linux in 4.17 and the compiler
> +is no longer packaged in any distro making it harder to run the
> +``check-tcg`` tests. Unless we can improve the testing situation there
> +is a chance the code will bitrot without anyone noticing.

With the typos fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>



