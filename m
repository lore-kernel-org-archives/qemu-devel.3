Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479C6079910
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qs8DhBV0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNvI6-0005fv-Sr; Mon, 02 Nov 2026 11:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNvI0-0005fP-OL
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:53:44 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNvHy-0004Zp-Rj
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:53:44 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3ae691283ecso1565689a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 08:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793638421; x=1794243221; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mPmA3OznOAHCE9Y450s3azRmayHkwA5MILAXw++sdoo=;
 b=qs8DhBV022MJ1Wt007JyYzOeXEcVyWAhyfYuzps1dAXXJzMsx+xNIiqqe/0a5XacnI
 pbqzh4cn/pQWGcbwBin+o2Az8Eib8yZb9acK7ca40kDfuqt6jtJXvY58RcrTTuon2WzE
 oA2roFUyBpqRNZLjYbCx8WjpZPH+yjhCU2XaVb0lAh1dr28MxnB6aReP8p2YqWYdrKHX
 H2T1PlI4WNQ9NS6JVFUMMkPPCUunTQpidxhQqbUqCWjj30GMMh8VPprcVuk06YjN1PqS
 Mydxu4IGB9afIQBebfF810hg5Nq0NsenL6N4GSTwY7uh07OCDYAGxLi+j0fxos4Uss87
 bzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793638421; x=1794243221;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mPmA3OznOAHCE9Y450s3azRmayHkwA5MILAXw++sdoo=;
 b=F6QDkC5cPKy4m2XZH6RvFr9iUjhXzF+ep6zwOlHDX4DGj3DBY3FWeJ1LHOWga4hhe3
 RD7uIgYA1N1mnCQDiK/9la4e6Gu9vErxSZFhnF/LnQWbzzbfajiPkSF6IT12Ma0U8cB0
 p3wOzQzjqzxZBhwLYH/UGAs65EiQKmmv5Xy8BDdfpoKnMzRCEmAZ/zLgr1BB5togpG3B
 N5ybjY6hTwTmWoWuruHtr/M5fNPMemkKOk+zdefDr/wD+YmaISZgUH1JS2gAVFxqV9oe
 TPNtmCo7/b2dwQ9++Ys0fd6h0awkbjG6iJWHs8hLzC0Ng3e9NPO6WyNMx5V9qQ6S0YMd
 FJeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6e3CiTQb7AVqlM5MtPiEDglfXvZNnq1543gvsj2mF6bc2qIXOQl9Jj98aNJSy6OTTeuQuqq1q3fLJ@nongnu.org
X-Gm-Message-State: APuU4Z8FUDXK/QHyCSyG5jPtBZMJCAwIqW4ivhwhK59MXmmAksFfmpj5
 P426M7R2eRvFFpQEpFtx43e/I5q5U+KUwJ2kniJ5/DqkSzSBJNFCNsxNhJJelGi33Xs=
X-Gm-Gg: AYBFou1jRz8RqQ1sxTZPppFIK6L2LBv+Z7pOLnAiLX9DTyJdhBjOU9QZWk3H+A+w/kj
 Omi2yIHytXSWM1G5nLkqO+LPkj3aberq5fveUlpbMBgLbORKoWZWl/CwYm81VAiD0O9D3uZuN0I
 yXNFOqg99QU4LeV3qqf9BCnoi986rauj1rqhG2Fw3JQzMCkyo3mVuMsqWg5zTGyqVCENyXgOyte
 GDhETqC4L9V9YUAARNbLqvn2xxAnQtJGekrHa2Bp6HQXpQlV0hqG8SHje33zkxW6ZFkyWETldeJ
 YEPVydri2o8H2HeNKQ3DDYuq3tRDp58lGORXsj+CuOYZZ8IYawKCQGp6CkOI5IW3zo2TehHPH8n
 ldIfsXyht/BTim5x7R6eFytW22jnJR5k7YNMc6+LJdfK3RlH67X2qv02WENypyOfs0TVKLakzzi
 cAva1NNEr9JNGag1whhV1eMCKO6u3w2npYJ+Pxf2ILaWADfc2Q9KPKce5X1h1w5AXmpEj2GKTXV
 wDDA1hoY7PCwE9vJOqhUxVZsfV6mLEeYL9FHZNw2sZVfRaoi1vVERbXzh57wfSHx1ClEImX4Ibn
 Dp5RmsNIGBiUeu50MDv9R38B9/py+PnLu2KzrklxnrOa5sU5B32MQrijs3bbOQsfzrFi9A==
X-Received: by 2002:a17:90b:57c5:b0:3a4:b509:88bd with SMTP id
 98e67ed59e1d1-3ae89559f3amr6147326a91.2.1793638420845; 
 Mon, 02 Nov 2026 08:53:40 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845ecaf5sm14925852a91.16.2026.11.02.08.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 08:53:40 -0800 (PST)
Message-ID: <8271c02a-8a43-47f9-ab44-18f4cf419494@linaro.org>
Date: Mon, 2 Nov 2026 08:53:38 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/74] QAPI patches for 2026-11-02
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20261102144018.3212223-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 06:39, Markus Armbruster wrote:
> The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> 
>    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2026-11-02
> 
> for you to fetch changes up to e963cc1906e22979c4e48cafdd0a72126748cb3e:
> 
>    tests/qmp-cmd-test: assert qapi-type resolves in query-qmp-schema (2026-11-02 15:38:04 +0100)
> 
> ----------------------------------------------------------------
> QAPI patches for 2026-11-02

Fails check-python-minreqs:

https://gitlab.com/qemu-project/qemu/-/jobs/17672036996

> ../scripts/qapi/schema.py:428: error: Function is missing a return type annotation  [no-untyped-def]
> ../scripts/qapi/schema.py:534: error: Function is missing a return type annotation  [no-untyped-def]


r~

