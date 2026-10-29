Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A46606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=go2spi/i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMMWT-0003c0-NO; Thu, 29 Oct 2026 05:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMMWS-0003bn-3i
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:34:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMMWQ-0006bn-C5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:34:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so16862705e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793266448; x=1793871248; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FkKAwe29qLJ7Uj5AJYcP4QrT9HrTNMMgmsyR6DO7Of4=;
 b=go2spi/i2ynGdqZ9iEf478+hae9e08iPLInqfPAI1BEGY4FBvTNVtDEXwCbM2oRaEc
 OxbwoQgnNCaSniLSkcg1B0TJSihvS98gxC7ckiUQq8wGe3LSA3D3ycV4vF0BYqgBuoDp
 94VLR+MLYC7uwHu6p16ijuZPbr8zxVBDRkMO4Jl+WfdXmc1ZJJLlTEIP39OgTqtGLCS3
 NiM23c2WsWMHCAjUA4wyiepmzQZ7xgTMrkqZF089FtO/kiZZZMQIopr7ervDddw3LViK
 0EqF3WfOd539d25xTclBWEDWumfoEyJ5MlXbhZCX0paYii7lQm1f+PxdVmuRgdtfkxJa
 JYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793266448; x=1793871248;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FkKAwe29qLJ7Uj5AJYcP4QrT9HrTNMMgmsyR6DO7Of4=;
 b=uj62luAvKTxnwUonvsbHskGV2LXTEpDYkVBTu9I3GWqbSrcvemlQGDo1TBlkvONuRN
 Xep2aCJhMX8CjKJlBQu+2Fmu5Y5NBR35jczX0yQFGHUm/4tpWu7afuTo7lbvU0+84B/G
 Ma5HDlx5fvZw2YQUg9GODmzF3WvLz28OB2IrotY+gty+6hLQs8azo6EsUf/IMelExw94
 FDlzukihw6of0Hcj5yB/lBFM9v5iNC1/t3UiBbN6BVQETOdY0jYr1wNCphVji1j+EIeS
 njQxQIFgH6oLRi4+d7RbCLO48PFHzK2fWFnKlEJ8oRP18tbDoBey0jBdwP0vx/XaT3vY
 jfIw==
X-Gm-Message-State: AFq9FYIo/3YC/a091y2YEppaKaT3YgOPkWYhfHQqMjlPaH+UdfzWFYDf
 5oT7Be0dGsSstdNyxJW7ppRftMb/VAZINVFjyG4k752gTiJqlWNI8XuvTURh+ThWOJs=
X-Gm-Gg: AYBFou0MPHBPuG0al7YwtoBZsUfO3l/DMWbDrPwLsWxOoQXiu5OdmzrXWniX+TNrbFM
 qbSRxst6DEVUDJZN3nh1RsFpi+nwip8mQG1I+z0tn40od9lNUbyrQVFjGeMEBqe0tLPpuxkuaCX
 H/OjLVIX4eYIyBd8BeJ7rAmzZ8gBaFfc4m7YB39E1RdQas2GoznbBHfzcFWrdVzREIkq6IjZ9m+
 vUynXNowPkFDqQsIjO+1uDfw9Lge16cvA/QyFC6SYopriCrwk2mGKyc/rrTcfeKz9TPyZ43FILG
 eXPW5x485DP+qhijYSjpP6hMQ/9ozCZuRgZbZs2Sp2oDvTQ+02UEb7H5Q9v1uonhJNNQKLyxxAb
 3uGcdgbWeum0cyRs96iBZ02Rcgx2HoMnRZKTyLDiaje3M1v8iZbKyYqDnHfAct0j825MncV3HcI
 oPiU9M8Z+CbUzyBnCUCdumjMdQBhATH1XWhXrWF/RDcdEcY7v84HWBzn7LACEfAbsgHfA7DwWKV
 SKsqMzxePiyzO2Sl2X7TA7Dp35nE7oOEUD6JN7fbxszkC/zjBvEwRNOc7nb52kJHyTEW7qyBa3d
 hJ3CNbji0KSoxxYtR6LpU78WVr4YjHID9Ipa7dFRq/nGHd/VZQ==
X-Received: by 2002:a05:600d:604d:b0:4a1:e0d5:293e with SMTP id
 5b1f17b1804b1-4a966c3f65amr108767535e9.21.1793266447745; 
 Thu, 29 Oct 2026 02:34:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80285b88sm53040265e9.14.2026.10.29.02.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 02:34:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EEC355F887;
 Thu, 29 Oct 2026 09:34:05 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <20260930085433.830743-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 30 Sep 2026 10:54:30 +0200")
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Thu, 29 Oct 2026 09:34:05 +0000
Message-ID: <87jyn0am0i.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Paolo Bonzini <pbonzini@redhat.com> writes:

<snip>
> +
> +- It's fine to use LLMs to answer questions, analyze, distill,
> +  refine, check, suggest, review. Use of LLMs to *create* is limited.
> +
> +- If in doubt, disclose any use of AI tools other than simple code
> +  completion and code review.
> +
> +- LLMs are allowed as a tool to write *better*, not *faster*.
> +
> +**For any kind of LLM usage, the expectation is that the human contribut=
or
> +shall be able to :ref:`understand and explain the changes
> +  <write_a_meaningful_commit_message>`, the design choices, and the
> +rationale behind them.**

I only just noticed with a CI run that the indent here trips up the
link:

  /home/alex/lsrc/qemu.git/docs/devel/llm-usage.rst:40: ERROR: Unexpected i=
ndentation. [docutils]
  /home/alex/lsrc/qemu.git/docs/devel/llm-usage.rst:38: WARNING: Inline str=
ong start-string without end-string. [docutils]
  /home/alex/lsrc/qemu.git/docs/devel/llm-usage.rst:38: WARNING: Inline int=
erpreted text or phrase reference start-string without end-string. [docutil=
s]
  /home/alex/lsrc/qemu.git/docs/devel/llm-usage.rst:41: WARNING: Block quot=
e ends without a blank line; unexpected unindent. [docutils]

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

