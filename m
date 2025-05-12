Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87901C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 22:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEbkk-0000aN-Jc; Mon, 12 May 2025 18:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEbkc-0000Yi-FH
 for qemu-devel@nongnu.org; Mon, 12 May 2025 18:35:58 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEbkV-0007zr-86
 for qemu-devel@nongnu.org; Mon, 12 May 2025 18:35:56 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b24f986674fso2941649a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747089346; x=1747694146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e6CsWcsrs+eaVGdX6HotaIPsQ8UrFAiZsDAulFqRlYw=;
 b=BZp5W1dgGj7bs37rm3bcG64QgE33a+6vtHrBt4eXV+b/SMR6VuYgshVPQEpxMv2lwO
 5cXXvo3NoSbQPGqy9D7yEKWeQ5m/jsUq28x8HHgzAiFNBeneeq8MSTsMkgGrCWzXBVNF
 NgXXz94TwIOv1jyta6le+3dJJxFOsZ3vbPlEnUz96wdbmTMxiIs4M0LS/Xz0z8DKZZ3t
 j7frs6LQgj7MNSruERk/Lel5mMsvo6dvfeZp2mhMjWQSssiIDaQrheBKEyxSwhVoSwZa
 uqKAPoHeZdfvv1ncA1HGMOaKwgPpm0R90EGwmBsYWxv+zCCoh6vBgDXueXkYCqqpaSbI
 s8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747089346; x=1747694146;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e6CsWcsrs+eaVGdX6HotaIPsQ8UrFAiZsDAulFqRlYw=;
 b=MU7BZRxRIjk/cekif12jRSj9DgmPfzZpGqtcFFk5ZGfP3ohYEQTjlMGMMw+r2hwjlp
 147W141pHa53Y5UUZ4uyZAPuhKCQsPagLVP0dXa3Q0sGezFoiFZEe3NEKbvW1G7wgTV+
 gsoIB6Vh+vd3NY11tPiXmNpYC2iYnJMjUmBVOwUqfUpjfLiVUW3w8BmepFubNChVtc/u
 IbJBwBNorH1Qp/npqFYS5o2GlJ7U1y7fDg8mp46T/ed4YlJ2UyDLBALo/1UoOfOXg+ib
 B7vSStgv6JLsg1SJIjaYHzqVUd1CesCvDFr2aWUM/plhSpi3JwZahFew9K1Na7EreZTo
 86OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrxyUCQkUHjMDLRccKa4U7iV1tq+KOSA8tH5tkKY6UyFENkSgBLgcHRWbSETiFjARMWQNxAr/ohgV1@nongnu.org
X-Gm-Message-State: AOJu0Yys5v8Yf0lXHLsP+cLgBw/+5Qkzh9vIF+oThFTr6KbMSKQdFiGV
 vIqJlkPM/k+deIIpu9okkpYKWH82VsAlBs95TBbchy//FQ45TRz55EjMGcwyDnAH7MSLKwhaH3v
 g
X-Gm-Gg: ASbGnctCFZUY602qeCNZq4iFX1nAHYmACUtLn4l1LvTpyixyQxGWfBb+MZe016vt3rv
 BKgvLDkDT36dJOwHv569h6E+WLUepp4vG7suFI0//nY637CahHLzbvoatsl+HBk3KTXrLJjGRUk
 rhFFhgHBJbIoOIDNGjarorvP6voPwimQXDUPaE3gc02rtTHDrgyeC7LsGuXcez9UrnYo2SUyWcV
 epAWFSD8u450uhNLwdnYvnSqqKIZcGnayvQ8BK99IWL6ukVxSVkBxwXAmmSML6tFv9pZ0D7lAG3
 PH2LQZ72ua9frvCks13OFizgggz4PcFrxCjNyyUALeIc5mvnuQCoOX9LGsggUSZV
X-Google-Smtp-Source: AGHT+IF5BQEYHbxNMoPxGFeZlDE9+x31nDAirjOd1avbsBmwqV2B9nnWqsHTJHGz+oxdIwH6oVu4Uw==
X-Received: by 2002:a17:903:984:b0:220:e91f:4408 with SMTP id
 d9443c01a7336-2317cb540f0mr15960465ad.22.1747089346355; 
 Mon, 12 May 2025 15:35:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39dd438dsm7127337a91.14.2025.05.12.15.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 15:35:45 -0700 (PDT)
Message-ID: <03be983a-689f-41b2-b659-27611cdb82b4@linaro.org>
Date: Mon, 12 May 2025 15:35:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/23] plugins: add types for callbacks related to
 certain discontinuities
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <cover.1746968215.git.neither@nut.email>
 <dd35ee0194bc8c30340b31c85ea1e5ba64eb9140.1746968215.git.neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <dd35ee0194bc8c30340b31c85ea1e5ba64eb9140.1746968215.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

Hi Julian,

On 5/11/25 6:13 AM, Julian Ganz wrote:
> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. However, traps of
> any kind, i.e. interrupts or exceptions, were previously not covered.
> These kinds of events are arguably quite significant and usually go hand
> in hand with a PC discontinuity. On most platforms, the discontinuity
> also includes a transition from some "mode" to another. Thus, plugins
> for the analysis of (virtualized) embedded systems may benefit from or
> even require the possiblity to perform work on the occurance of an
> interrupt or exception.
> 
> This change introduces the concept of such a discontinuity event in the
> form of an enumeration. Currently only traps are covered. Specifically
> we (loosely) define interrupts, exceptions and host calls across all
> platforms. In addition, this change introduces a type to use for
> callback functions related to such events. Since possible modes and the
> enumeration of interupts and exceptions vary greatly between different
> architectures, the callback type only receives the VCPU id, the type of
> event as well as the old and new PC.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   include/qemu/plugin.h      |  1 +
>   include/qemu/qemu-plugin.h | 44 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+)
> 

[...]

> +/**
> + * typedef qemu_plugin_vcpu_discon_cb_t - vcpu discontinuity callback
> + * @id: plugin ID
> + * @vcpu_index: the current vcpu context
> + * @type: the type of discontinuity
> + * @from_pc: the source of the discontinuity, e.g. the PC before the
> + *           transition
> + * @to_pc: the PC pointing to the next instruction to be executed
> + *
> + * The excact semantics of @from_pc depends on @the type of discontinuity. For

s/excact/exact

> + * interrupts, @from_pc will point to the next instruction which would have
> + * been executed. For exceptions and host calls, @from_pc will point to the
> + * instruction that caused the exception or issued the host call. Note that
> + * in the case of exceptions, the instruction may not be retired and thus not
> + * observable via general instruction exec callbacks. The same may be the case
> + * for some host calls such as hypervisor call "exceptions".
> + */

thanks for respinning this series.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


