Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21762606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=b5vwkg7Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZLp-0001Dl-1k; Thu, 12 Nov 2026 13:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRZLc-0001CU-LV
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:16:32 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRZLa-0006Yp-S7
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:16:32 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3adac5c10e3so42891a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794507387; x=1795112187; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HVY2mygvzjfaTe8Ilxp7jURdd69HcM0iQlAQO87fJ/c=;
 b=b5vwkg7YykOGM33Fqb+CKpjNQrhvvfbVqHDAxZReIIEZ4dFCZ8oebKiq4yy41aIdve
 rkE9eUyeI0uarOvzzsybXPwSK6Ifx3zk7yvn67ildy6Mgs2+oZzrGLUCsHxOzIVXNNYt
 K/CQNEnxGdxzXncUzRAWomUP/5X/qsd5JttHqwB/ldbzGZf7la6AgE1MMNxuOpHEHmB0
 8DWgNklF+1ZxwHsYKeYC8vv+gtGjyskKhde9Q8ipggwW8hy2EPXjm3sBSvH3GfN6ndLM
 TLN3NBC47MiZoKEylqIAhcQ+wi0HKSPJs7NwXvwayltwi24xvl4hvAVTZTONW3enwSSi
 /2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794507387; x=1795112187;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HVY2mygvzjfaTe8Ilxp7jURdd69HcM0iQlAQO87fJ/c=;
 b=WfF/PBgSLiASZOMhkEpb1dlzrJmGRW1zaD/v8d4S7rt3V4pi5K0Zf3RSQract2LZTm
 E83Nc4+tGz0ZlGK0fi954YL6pUaCBRu9Eq3xfR/GFet4rrxbM5oKczWtPpBdmTqHAjx5
 s197UWwOfni76UPAFp9kriRIltpnexDenfLXQF8y5FxCC1PfHk0gJFpaOmHb3FVHN5qf
 GHc8FjVv8CndsX0BLeQj0T71G6QeAOq7BcF9vaIa3gy86/IgREiy01NWsJXqx3gluVls
 zIweC59GiHcmVAO7Pa7l2yZFcMxk4Q08KidAppgUdTu3aSX432tpVLE+L3xsbDefvetN
 aOQA==
X-Forwarded-Encrypted: i=1;
 AL+hErEqZ1NNCxbcOU08awjmXALEF/wrTATQuYLFCm5xYPmrZaoz0iZ13AoZnYfVO/5Hu3a27BYIiKBpmg1W@nongnu.org
X-Gm-Message-State: APuU4Z8SsmW5XJeMSMECXEaaQ3eaO0p9fM4gCkLT5cAYxEwh/vZWCNLm
 qVdjNjkqW9XGnclVRvfbA3LQn2fon2IJgHpETGHVk4P8Yx2NU+sakWjcVKIhNSrBk1sGwH3nCW6
 gZQLj8P8=
X-Gm-Gg: AYBFou0ilkprkr+syHS6T8jtBQNbZHNbiRavMsEBl+/ortXHZOrKQKL7GFNPK45LniP
 GBYzrGElb1t3IA8MTDkItQlalWdN79Dt+liLECYh6rUqx7gvcFtxpFpyvg2vnR0h3c+NoNxrN4S
 qQgFclWe4GewuSFxVTpkVaHg+rAwfyFeafRFNAp7r+ZxQe45NFpIUa6hsl7EUTxItmuGKfJakKY
 W3QQfhzwcnFW4JUi6ZLfHjlemKcISe11tWYbl5KV8Iwl7CCo5PQtR8wT3DBEGwdxNnllNifiW10
 JPqXRVl3BBWJSJcwJN2tWDD1TWpYDCxsjxC8DClRm9IJHrKNAScVto0R4uy12WY9PSUlK7QwshJ
 iOXU12qX6iSXSJPVxAoZLX5dq/y356zgvm51njN3FxezJ1ibmmxzFu15XYCr5snl8azzDXZ47ly
 tMsxYwOQ/QXm5Sm75qAyi837qbb/F95mfe/3Yq/Yjbtd6A59u5WzCan4Z9p5jsT7JzrcLHc2+f0
 XzwtiEDF3+mWA1G+uzQ9EgVP6cBk09pIe4Ks8+orsiPkYRLMkSkJckAeFG/gNkxfbqNtjYg/uYi
 L4XscouNYhXRXQsIbY7vOwbhgG5ocsSLkvFZ6LRkyfI=
X-Received: by 2002:a17:90b:3904:b0:3b0:99f8:eba8 with SMTP id
 98e67ed59e1d1-3b182f8ba20mr6460918a91.66.1794507387373; 
 Thu, 12 Nov 2026 10:16:27 -0800 (PST)
Received: from [172.31.6.238] ([69.196.88.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d27cf1sm5906951a91.12.2026.11.12.10.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 10:16:26 -0800 (PST)
Message-ID: <820539b6-d161-43ff-8889-cb40c1ecc6f2@linaro.org>
Date: Thu, 12 Nov 2026 11:16:24 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] NBD patches through 2026-11-10
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20261111035200.1751734-10-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261111035200.1751734-10-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 11/10/26 19:51, Eric Blake wrote:
> The following changes since commit 723622bedb0b423de7d1c61ebbe6e7a71934949c:
> 
>    Merge tag 'for-upstream' ofhttps://repo.or.cz/qemu/kevin into staging (2026-11-09 11:58:07 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-11-10
> 
> for you to fetch changes up to 1be14f69a8350349388763f83578f071fdbfee07:
> 
>    iotests: Add another nbd-robustness test (2026-11-10 11:20:24 -0600)
> 
> ----------------------------------------------------------------
> NBD patches through 2026-11-10
> 
> A few bug fixes:
> - Guillaume Vincke: improve connection retry if NBD client hangs up quickly
> - Eric Blake: fix two low-severity CVEs with non-compliant NBD clients

New failure:

https://gitlab.com/qemu-project/qemu/-/jobs/17979973534#L298

137/150 block-qcow2-optional+block-slow - 
qemu:io-qcow2-nbd-stale-connection          FAIL             2.37s 
exit status 1

{"error": {"class": "GenericError", "desc": "write failed: Input/output 
error"}}


r~

