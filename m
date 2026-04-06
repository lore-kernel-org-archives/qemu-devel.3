Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8696F46C66
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 17:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9npW-0008Ek-Tt; Mon, 06 Apr 2026 13:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9npU-0008E8-3m
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 13:33:40 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9npR-000332-ND
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 13:33:39 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b24fede2acso23014965ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775496815; x=1776101615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ie8HAZyDxiPllwp4jMYeRvYXphQlZUiK5/MSDW9Tk00=;
 b=jp4fSHAkzR4xtDlLGaOMEH3/QksBXsOqeqOWiHswCN10mz0wChPCIFv0UO2IbA+pPJ
 E+cF3DqvQI7IzN7BhDmGdeJqGenwthiTY4sg8masqbOgZiCvH+wMd4IVtWdjaGzFhSsf
 SvRjnCn8wAr5m2pv9yjUyBuAok8MFUzJ06LuR6OA8HjzgXSSE68wWQunu4Du9nKTgDuU
 M18EpreTrEhJk1jfFf/KbJt0tgiZCXjpyLhdZWs9RK2bXztBALGI0uoj4dTeqIQdocAk
 AM7yqF83cRXHIVUVcdNiczFrWzmtvwZB9ZuFQVX+tmlgLQ69KNQEESvEMxb8sJS7ZsIH
 q+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775496815; x=1776101615;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ie8HAZyDxiPllwp4jMYeRvYXphQlZUiK5/MSDW9Tk00=;
 b=CCbnUD+KsyytnkIIqyagUNUPrRvN8+YK5AvaxNVi3amsTLe92p0UcDTi1SHG4j/RNR
 R7L1mgvx678wCwBJ0zv826FF0r/XFRlP6axdq2dqIJPvWNQZeFPPoeZmIAOsjv6Xkpvj
 1PW/c9gaI5Ptuf+Rn1Hb+97VTpp5oZ5obpRCDFaAgx+01bQxXulkU6WoCDm5rXaNz8Bo
 RFAQ0HCeR19oJp98vsHGFsl5F1we1JiBJrlD9LHrAOFd2nPnH0Gzma5TP9VGktqYTgdo
 rjgB6wMsN++Pb2p/cl9fBJv5x5vquythByELlWJsa/mlH0yT+fpKcEZIgq+gd8ZobHW7
 2VDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCFv0cDcAe3UZp+Mgfzh8Gb5y/SXy67fKB7JXV0t2Kzcu3jKOJiEtOMO783izM2lsjDqmudcxfmZzf@nongnu.org
X-Gm-Message-State: AOJu0Yzyv/Oe8m4ofGWsp50GNUF8hmrigjLeBu/ykGXzwkudJ3T9EvEQ
 Ehs4svuVSqOOYrHG6U0q+cnHtNjJSIeXCkTdqkccnMZ+6j45Yn14jbaRzYiiMuD5IPk=
X-Gm-Gg: AeBDietfDI2keQYXL9LsObrpAVwOsxtnyeJ2jSC6RPFIehHSAmfwBSXGBsR99zV4ahN
 lpkfLtjO44h+zxe7UDAoQIFebsrpcmMc+FOap72uR06p91Vn6AXFXRovUCFsA1IsvDZXrpz0QgH
 unzBogNLc+W4qXvijzwKD8flXA+fpiqqbhIWYlj32S9I6ipgDRHaRNcP1B9rxrfuDFQ6HngsnUV
 NXdvhWk7aZMszSEUlIf/VIAZ4ghuczCwOn5cPGv764T3SkOS35yBxWZqyZX5LaObOcQux/qWsSA
 Yodx4hfM0eBRMMIPawVn2tJqXN+XP65XgdX9SfVAGlJ8yX144dfz5blEIKg5UpqOCru5QmceSfq
 Eo8ILjH6SNtlBgv4DPQC306VlZjIitFJLarrqHakRTabij3btU9OPOHNWn+Y4vU5BwV0Vd2FV5C
 cVC3pIZximUP9W+l/tRZuBuVmQFsRt20n3isqDcQSZptTJbOFVWpOzjkzs6Prm7Y8G8jnl9g==
X-Received: by 2002:a17:903:1a30:b0:2b0:c90f:449b with SMTP id
 d9443c01a7336-2b2817d8a15mr135393185ad.10.1775496814979; 
 Mon, 06 Apr 2026 10:33:34 -0700 (PDT)
Received: from [192.168.1.168] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478b64csm151204235ad.30.2026.04.06.10.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 10:33:34 -0700 (PDT)
Message-ID: <ca592a46-ff33-4f98-adad-7227844a7d41@linaro.org>
Date: Mon, 6 Apr 2026 10:33:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] contrib/plugins: add syscall-filter passthrough
 zlib demo
Content-Language: en-US
To: XU Kailiang <xukl2019@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Ziyang Zhang <functioner@sjtu.edu.cn>,
 Yun Wang <yunwang94@sjtu.edu.cn>, Mingyuan Xia <xiamy@ultrarisc.com>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>
References: <20260331173656.35305-1-xukl2019@sjtu.edu.cn>
 <20260406153331.8846-1-xukl2019@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260406153331.8846-1-xukl2019@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

Hi Kailiang,

On 4/6/26 8:32 AM, XU Kailiang wrote:
> Hi,
> 
> This v2 simplifies the earlier series into one minimal, runnable example for
> the linux-user syscall filter API.
> 
> It adds:
> 
> - one plugin: contrib/plugins/passthrough.c
> - one matching in-tree example: contrib/plugins/passthrough-examples/ (zlib)
> 
> The plugin handles a small passthrough protocol over a magic syscall
> (load HTL module, resolve HTL symbol, invoke HTL entry). The zlib guest thunk
> library (GTL) uses this protocol to forward selected zlib calls to host-side
> HTL/native zlib.
> 
> Compared to v1 [1], this version narrows scope:
> 
> - drop the callback/qsort prototype
> - drop extra demo variants
> - keep only a single plugin + single matching example that is easy to build
>    and reproduce
> 
> Build/repro documentation is provided in:
> 
> - docs/about/emulation.rst
> - contrib/plugins/passthrough-examples/README.rst
> 
> Thanks,
> XU Kailiang
> 
> [1]: https://lore.kernel.org/qemu-devel/20260331173656.35305-1-xukl2019@sjtu.edu.cn/T/#t
> 
> ---
> 
> XU Kailiang (1):
>    contrib/plugins: add syscall-filter passthrough zlib demo
> 
>   contrib/plugins/meson.build                   |  11 ++
>   contrib/plugins/passthrough-examples/Makefile |  23 +++
>   .../plugins/passthrough-examples/README.rst   |  60 +++++++
>   .../plugins/passthrough-examples/meson.build  |  19 ++
>   .../passthrough-examples/passthrough-gtl.c    |  41 +++++
>   .../passthrough-examples/passthrough-gtl.h    |  17 ++
>   .../plugins/passthrough-examples/zlib-demo.c  |  90 ++++++++++
>   .../plugins/passthrough-examples/zlib-gtl.c   |  72 ++++++++
>   .../plugins/passthrough-examples/zlib-htl.c   |  37 ++++
>   contrib/plugins/passthrough-protocol.h        |  14 ++
>   contrib/plugins/passthrough.c                 | 162 ++++++++++++++++++
>   docs/about/emulation.rst                      |  33 ++++
>   12 files changed, 579 insertions(+)
>   create mode 100644 contrib/plugins/passthrough-examples/Makefile
>   create mode 100644 contrib/plugins/passthrough-examples/README.rst
>   create mode 100644 contrib/plugins/passthrough-examples/meson.build
>   create mode 100644 contrib/plugins/passthrough-examples/passthrough-gtl.c
>   create mode 100644 contrib/plugins/passthrough-examples/passthrough-gtl.h
>   create mode 100644 contrib/plugins/passthrough-examples/zlib-demo.c
>   create mode 100644 contrib/plugins/passthrough-examples/zlib-gtl.c
>   create mode 100644 contrib/plugins/passthrough-examples/zlib-htl.c
>   create mode 100644 contrib/plugins/passthrough-protocol.h
>   create mode 100644 contrib/plugins/passthrough.c
> 
> 
> base-commit: b6a7d06213e5d2f7d124d16418bc289c4a8a4b82

thanks for posting it.

It seems there has been a confusion with what we talked about 
previously, and I'm sorry about that.

When mentioning a minimal example, what I had in mind was the Lorelei 
plugin with a minimal example using it. The goal was *not* to show how 
Lorelei internals work (thunk libraries, etc), but how to use Lorelei 
itself.

 From our follow-up conversation on Discord, I understand that Lorelei 
is still in heavy development, so it might be a bit early to integrate 
this in QEMU. I understand also there might be other changes required on 
linux-user side for some specific applications. We would be happy to 
review those, if we can have an upstream plugin justifying this.

Thus, I would invite you to keep on working on Lorelei until you have a 
stable plugin covering all use cases, and see to upstream it if you need 
other changes on linux-user side. Else, I think it can stay downstream 
with Lorelei libraries also.

Keep us informed of the progress on Lorelei :)!

Cheers,
Pierrick

