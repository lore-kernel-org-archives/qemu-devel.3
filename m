Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3036AC87FDA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 15:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk2HJ-0005Iv-GW; Thu, 07 Aug 2025 11:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uk2HI-0005F2-1Y
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 11:11:36 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uk2HG-0006G5-Hx
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 11:11:35 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b8d0f1fb49so637392f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 08:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754579491; x=1755184291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpqPnw6+VyeU3ESlPvYO8l3ftjOYPSRSgEpE+HLivKw=;
 b=ej3F7Aps/LGDBhMASrlGO2V8mc4ZtzIJZ0fFICy5MqTkvzZOsbZbVTIB2x/K75SGmS
 fYuBByRwSTrLcWGf+zPARC3hg8DIRWxNK+B/KxoxuT0v08LWKLI+yjOQ6kNLPUCfWPtd
 dX2vKXj0Skcu/LQ2Z9slMwySEg+Qp7MZdJ8t2RQ473AzBV1wbDYyQKtk1mV52Geo+XoU
 MbmInKf3flh0NIBjUppdPNiVDSVONsRLtdToadVmwZCqJJSgLcvtDcpLqAeYgg9BFjb1
 4uVuSSmFnfLfZI3HFpJBqCkK4Lae29bJDhtqOJ7LE6H3rMgEXrEqfXm7LkVYR4bwVj9n
 757Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754579491; x=1755184291;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OpqPnw6+VyeU3ESlPvYO8l3ftjOYPSRSgEpE+HLivKw=;
 b=J1VyuEKGDuw2IKy9IXsp8kSiA9Gp7HiGQ6POo4SJhLKZ71OL4Q0qTvRI785EgR+at8
 ZrFDcI3TKoMZv/SQoPqiBo0xeL4pS/Xz4+Ub4nWOO2ocr5h8N8gmhnVYgKUdshdY2Iuu
 u0mrBsXKLA15RZbS/UQGiFK2Hd2UsvQV2M26HA9Nj1WygfAwJwimfTcBND3J04fgTxQl
 rgBMsqGEbu8Hvm+zYguINrFeXl3ZtP7jSOW1GJWtXQ/+TY8FpX6uf7A1FChaNty394Dd
 kT7Io2OuPU8rIKkN3UroMGXdGAP9kZIrox9FQSlfr6zWOt7ryiISVY/6y1LrdCgt/hbI
 gV7g==
X-Gm-Message-State: AOJu0YwoQcfN1dP0XUlUd6VmeDDyq3bQhrkjQUclx+2LUI5T5RczUJGO
 r02Ws5UTe6FB7aM5I1RXsh/ZkDA2RW8IU3t8+XTWWEvWMLv6dMvWqCDYmJ4xaP68TaQ=
X-Gm-Gg: ASbGncsTyvfpuwO7VLBhPR5eESAi9ELWoC8/wBYsPe+FrKoZZ6INMA0l2dwJhkuq49n
 iEndlwFljrI9AW9aRVNrWchxjDk0yC79QcXntrvnQkGogILg5PoPwWu3ddZ5avMi7vTZrbXb9kZ
 I6YBVR89WHLN3sFExWmjAwy+dBUiUn3PBRSYWmH+ByLVom1wVYSw+F+bPnFGC5tgEGiGhovlKBt
 FSwrMDYQ6NqSgs5i37+2VmckuxiKO4CsTS+9O1pimm5qfwuxGsS6tYXwPilxNE5QGOjp8NrfZxd
 co6tBhwUharpmZxSXib0qT6OcZdZjp+H7WUUJqey7oH9FqNw9C96UrYooM0XFgG84wJf3YOEzhS
 TR4dStWiJ5WFw18cTjOhibwI=
X-Google-Smtp-Source: AGHT+IFPcAlVrWOhe1wWpOL+C9aoxPMdnOaOkN400JPEQlEfXdp6ztJhs6I9seGlcPSk/ZfWJ9MqIg==
X-Received: by 2002:a05:6000:2f85:b0:3a8:38b4:1d55 with SMTP id
 ffacd0b85a97d-3b8f41d46bamr6417823f8f.28.1754579491517; 
 Thu, 07 Aug 2025 08:11:31 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dc2647f6sm83313575e9.2.2025.08.07.08.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 08:11:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A824F5F88A;
 Thu, 07 Aug 2025 16:11:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-rust@nongnu.org,  pbonzini@redhat.com,
 zhao1.liu@intel.com
Subject: Re: [PATCH 1/2] docs/devel/rust: Add mention of 128bit integers
In-Reply-To: <20250807-rust-docs-add-128bit-mention-v1-1-1d8a1ece3a51@linaro.org>
 (Manos Pitsidianakis's message of "Thu, 07 Aug 2025 16:02:04 +0300")
References: <20250807-rust-docs-add-128bit-mention-v1-0-1d8a1ece3a51@linaro.org>
 <20250807-rust-docs-add-128bit-mention-v1-1-1d8a1ece3a51@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Thu, 07 Aug 2025 16:11:29 +0100
Message-ID: <87bjoryxni.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> FFI and 128bit integers are now stable in 1.89.0, add a mention in the
> "missing" list.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

