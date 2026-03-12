Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09101106ACD4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 17:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0jl1-0003hz-4K; Thu, 12 Mar 2026 13:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0jkz-0003cp-2X
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 13:23:33 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0jkx-0004EG-BU
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 13:23:32 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ae4d48dc2fso6676255ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773336210; x=1773941010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Z6p6DnS+yFnJjqgKnp/HrvPkfWLOg3iglYJk8SByVI=;
 b=sXNWin20MUcJFhOpRnFH+6mY7xx716niIn88YLt3bivDhAiKjILbftdkvCNqd29yb7
 mwheas+feyNbaLtB+u+XNvJncfS6HgMfj2trwZ5KKqZ4IHjLFGJOhiAYS5FEk8AEoP7Q
 tzeV7oW/4mg5+NS0I9ucS1dx8oIr5m7DegUHrRD6OdhyYQ0lZB2LiO7NWbX6J+jlq0yo
 hfaeOMO/knJqtSvd/OSQkvKbf/qdNMkBiSXotPq1E6orXNIVTP4uEUXYOyQSitzzdJYe
 A/yZ44oif2jKOuOCJbK6Vx7WAy/Y9/XKlBefcmjZAg9ytliXwCRcHywHzr34YPlhqmxp
 czRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773336210; x=1773941010;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Z6p6DnS+yFnJjqgKnp/HrvPkfWLOg3iglYJk8SByVI=;
 b=lPmI7/ky66E5Z306COVIVU3mRio/BPx1C0yFxxAOiwmRtGZYNsdHy2/87BwJmSWiRt
 G4WVeHJMHetaLj+vq8bsn4oWeMBrobgwqTGISqCd54QKsbBTC6ls6JL7zGFr9NDLEIR8
 FGRLkzBkz+3oLJDi/lMjEUUW79WJXplHmj61VtkBpMO43muJEsJvJgJSAmIImpQXBCCs
 FuLVUBQ3gRHa2nAiqh3Eux/KFtToj4xRJqpNXfmpDzViOtYRSKgPDXZYq2P1aIkCJohh
 wUzH98MAd/h5ThPronYH7eJhaDvV5TlJ7pAtkeEVoPAhnhu8lwe4gfyEA4vefC8JNGau
 G55g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbZuY3mO5h9vg+98tq1kAc4VXm4dKYveeg+TAckX6hiN2bj+lM/um4voMqd/VvsbvEC9SNcpf1k9lu@nongnu.org
X-Gm-Message-State: AOJu0YxJLa0FQ+moh6xU4q6XmLy9Sj48W+lcD405+NHKdjEtMRNtOlIY
 qRpI8jP4x7KMdBIJ1XaqnawRvK3I/lyNzrV0EzFI25Z0L27ASq6QzfxHqDE0ZUR78o4=
X-Gm-Gg: ATEYQzwmxydL6XNpFyjFHX04wvwZBVjsp/SABaGEJO9maVAQ+bJImLQBRx+9g4PC4OV
 ankqZgKZyVhhGdqnx0tEq/aIkxE7HojVucQARmgpfTs4QxEIELb6zMaKDeoMYaQd6WhUYNwP2ql
 NbHzEZHTwlNcVwJDtBPzL+gABVk2/XGJrxEbjGEZa6gR36zpX1EXaf+SDb5LloTGknSzkxflCMZ
 3l1Rb0vfbfSrJP3fFdhC/btPJz+gE5VVzXtp1DLR8HJJQlPp3bbDt0aAID9cmhsqD105zgWzZRl
 vmd/oWbORFjkRpBWrlM5YfY8WMCwIf24rM+wv4fZAdjrQ5kyos0YH1em0pEwfD4jp26gLoWwYNX
 pjmbndgcb8Rr3avb9C02izKfcCCR15ip7HGjA3DDvSu3/Xxrj4hBrS2vsXwT9DlzhhDi3W3rewV
 fMpPAabC/2zHIsYHGsAsNLg0VCTmDhyO5kWR40O6ALMZa6QkJc57P7wl1Lk6Gyfowasu/V
X-Received: by 2002:a17:903:3c46:b0:2ae:572a:9f19 with SMTP id
 d9443c01a7336-2aecaa387d2mr2759425ad.21.1773336209780; 
 Thu, 12 Mar 2026 10:23:29 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae222a69sm61409325ad.14.2026.03.12.10.23.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 10:23:29 -0700 (PDT)
Message-ID: <6458a275-0870-4de7-b72c-db959aa84029@linaro.org>
Date: Thu, 12 Mar 2026 10:23:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial v3] plugins: add missing docstrings to
 qemu-plugin.h
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org
References: <20260311-add-missing-plugin-docs-v3-1-d68b9135e397@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260311-add-missing-plugin-docs-v3-1-d68b9135e397@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/11/26 3:25 AM, Florian Hofhammer wrote:
> This patch adds docstrings for typedefs and function declarations in
> include/plugins/qemu-plugin.h that were previously missing. This
> resolves inconsistencies in the docs, e.g., the description for
> qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb()
> but code cache flush callbacks not being documented themselves.
> 
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
> Hi,
> 
> While working on a QEMU plugin and browsing the online docs at
> https://www.qemu.org/docs/master/devel/tcg-plugins.html, I noticed that
> some of the API functions were not actually documented.
> 
> I went through the include/plugins/qemu-plugin.h header file and added
> docstrings where they were missing, hoping of course that I documented
> the correct functionality based on my understanding of the plugin
> internals.
> 
> I hope that's useful and I didn't miss anything!
> 
> Best regards,
> Florian
> 
> Changes in v3:
> - Fix documentation build issue due to incorrect parameter name
> - Link to v2: https://lore.kernel.org/qemu-devel/20260310-add-missing-plugin-docs-v2-1-e9a91cb6974a@epfl.ch
> Changes in v2:
> - Added semantics clarification to the qemu_plugin_register_flush_cb()
>    docstring (suggested by Pierrick)
> - Link to v1: https://lore.kernel.org/qemu-devel/20260309-add-missing-plugin-docs-v1-1-41dddcd177c8@epfl.ch
> ---
>   include/plugins/qemu-plugin.h | 106 +++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 94 insertions(+), 12 deletions(-)
> 

This was merged into master (c4c27695a14f7171a31e8c5d060d931bb1f37fef).
Thank you for your contribution!

Regards,
Pierrick

