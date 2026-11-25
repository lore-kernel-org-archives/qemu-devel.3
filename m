Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCACD606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Vw1QGDdQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWFpp-0007fv-2o; Wed, 25 Nov 2026 11:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWFpK-0007HV-Fa
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 11:26:34 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWFpH-0005N5-TK
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 11:26:33 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cde827b7b95so1761244a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 08:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795623990; x=1796228790; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LoCKbRX5CM5VN/YMcsvAA+tKHcDiFIgculkImN7moaU=;
 b=Vw1QGDdQ0VjpsyTbmp4d7EpKS/dTGxgAHHdxoTZSDB1ULvdj2OsZuSzN7c/co/YzwU
 SnpW3R+4K91lbv++ccHOxi4mADqsfCvm+OcULBgwV1NlaqlZ34np9ghGGutn85HUc/z1
 zJm45eKfHKna4rn80uUuk5Am3iWQiV9AC66aWn/c2y80cCg8+Ctn28+qL5LW+9xUWhWT
 R7zM60tLImg4wE8PpvGMq6BrVg61PaWDAh7OMA5TnyE4tXyoC4LDlVQCd4tlMePA6l1+
 T0teECSd2Cb/Fnr+TAgaLK2Kj8rApd4NAl0c+a//C79r7EnQHKqK2c35MyAZjcDBq3JC
 Pb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795623990; x=1796228790;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LoCKbRX5CM5VN/YMcsvAA+tKHcDiFIgculkImN7moaU=;
 b=HdK2hhrMZVfKrZXsq1zfpJ/B3tyCNVIYt5IH+HZty3BSR9MT9X+yIW4l67q14tuLJ+
 VgnzOxmcP5PIynhOKj/05zQSsjTl5dUGZE4UIjjXRNUBqfWuAfrLt5T4XY65sxaVBFDv
 k1wWOj2s+F8BbC+0HcvcG7D9MFWammgjIy/4YtAGWkooP9/iylwEFLx5/NOqEFCl8d1l
 /4UA3Wy5hilgv3QtQnLddpK56OC66IGuptaiIJVFR6ug8NSlzKxY70mWRuh0OBE7XRWI
 lbixLhOg9gSuB51q8MkthIAX1cZUfh1J/InXlY3q064LrdJmEaYmKVlA4s954A1Dl2HM
 4bPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGuM/A3Ino97UL5X3W1OpMgGlCFJNSVoD+5s5kBmYLv2UHQ2eNITbxqkctq63Qu3okFfDD6oF9X7iZZ@nongnu.org
X-Gm-Message-State: APuU4Z/rcrwOWz6+qODLeBOwlPgmfetHH2VYdPk6H96cG0/l0mujZxDp
 SyXO4j/CL0cNPVP/xMR+AP4lnTSklSJ9c4TRfIEehWGAjZ4NUADX6FIn6OfHYWnvSN8=
X-Gm-Gg: AZFdTZcCTPMtuFGQor74VO62Ia9bxHpI4/IXciaybJ1AwJVDsAnvQ+sg7ywUiABudmx
 MrBG5z3/E8lldhk92AESKEeigbaBBYS4IlIEh0RP1eNsooBYs6ZvQqLwo25fv4sVr4YnQjuNCpW
 hbA3gf5K57EhlIBFM7XsUYAkM4XUJ0ptzbZbIB5DiKmYCagqmhkiKMkNSLP/fGrQhOylMsa/02o
 bsO8Ml9MDAGxvb1x7nl3P8RG4wHjDj7/Nu7BloVxjd8N/T76Ai9DRFVE22F1Jyplilf6YZK+o7H
 CDXzYwapynwUUYMqFCik1i7T9IBPgK2qHR8MVIdBVbAszrixMe2KkhjANh3ZWbCNlJRbuAx7got
 T5eVBZHfp/1+h4KSU75uqkag/7jtzjc0BAVUr+mOBnQ2jUi/j8WJf7XKDYFXvc6miJshLBlAOOd
 8GyW3K1INMHHUWRnD0v1rDtJmxGWI6EyBgxBGDeEOqAktgkWJlY7dLD0vE2G6QoWYGcUlJC2f6l
 +iOgh7zZXIW3BpC1dxxrPspegfFBJHHzqrNLTYxVvJ50Qcdiw/SjagcL6ve0igMMc8goasj7IVx
 FDkkqXv+k4M3G0qLTHH+15RvqkAiJZ65VEK9uQvkfuQ=
X-Received: by 2002:a17:90b:1802:b0:3ac:a139:1b13 with SMTP id
 98e67ed59e1d1-3b41c93ccf9mr17160471a91.29.1795623990360; 
 Wed, 25 Nov 2026 08:26:30 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ffa98esm31100275a91.17.2026.11.25.08.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 08:26:30 -0800 (PST)
Message-ID: <ce23fb8b-9879-40f9-a0dc-069457bd4944@linaro.org>
Date: Wed, 25 Nov 2026 08:26:25 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for-11.2 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Fam Zheng <fam@euphon.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261124211230.1944962-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261124211230.1944962-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 11/24/26 13:12, Stefan Hajnoczi wrote:
> The following changes since commit 6bf90d4fc5027567cb704d7888f5ec792b4ed75a:
> 
>    Merge tag 'pull-target-arm-20261124' ofhttps://gitlab.com/pm215/qemu into staging (2026-11-24 07:09:41 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> 
> for you to fetch changes up to d8be4d3166ae991b28171fed3fd336632ba54d5e:
> 
>    fdmon-io_uring: avoid idle event loop being accounted as IO wait (2026-11-24 15:03:00 -0500)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Thomas & Fiona's fix for io_uring IO wait accounting.

Applied, thanks.

r~

