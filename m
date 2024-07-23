Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3349CC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAx2-0000Uk-3E; Tue, 23 Jul 2024 04:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWAww-0000GC-RK
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:32:47 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWAws-0002Jm-KO
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:32:45 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5d4fb707895so2846950eaf.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 01:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721723559; x=1722328359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i1HsrNGYROwEjyyCcgc112TzpLNVhTPHk8V0j2hJlVM=;
 b=uKBmPZHAlDLwzeawgdHJTiG2+ZcDNNW9J+AZXFU3i9EhaPp2qKHdGSEDog4xXWDGbU
 uIJd9nz1EftzKftdp6hueGpO8ynwGs/9M3sZXB1WjBqyMjieKeIBB6grLtul+06eQAWm
 kGASPGBnlIEj03HqcraNAeQStISE2dh7XtrvjkgCKv0S+9O0eaOqrBBY55WXv+1OwHnS
 0HWU5lrmlPPXY4hbRcSg2AphiFAfMt5s7t2Ww3Tvkrf13+sCAWg33bxABrPC9UMIuhYJ
 1zIi52Wx3ZOu86coF+WjHTYlpvq8BNOMg9xptWc1RFHpjXj7YwZSG4yKFq5tMQuF2tls
 xrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721723559; x=1722328359;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i1HsrNGYROwEjyyCcgc112TzpLNVhTPHk8V0j2hJlVM=;
 b=XF+dX+K85TbKsh3NKAbcn9/WSZIrWgbczGVRfkJxoNFhnaZrXFBGB0x3ngxgpt8peH
 NnwsnvFXqciq0cJkWz2E95J+Y4+mMniaXTMwgPwMGaeitCMa8vatUbQhxnUmM12+xpGK
 Z+sjQZKkraos/kkxXZxN/ihNwUiJTLPXJlnJpA09ALrYLxH+jbTLUB2uZm4CIi3ZUcrL
 V83cXwJ+uFhOTozrpTM97V/P1bI54/JGrFCAgzfuDD09XwsFBuXYwjmfor9wzr+dyAUf
 QDFfRR3zqsIGtSFO28hAo17tcN+PHQWD6DKDx0QakqVgIBkroEsMeeWrWGDW3rgy0Vcn
 BH1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyX5VFpwWpACZW/PLNcxuywWZOgymsSp2W1os2D6EpKyxhLmJFUgH5KePfUC4PlPPSbTmvMP2hzPGUCcesY0opmhYsGHo=
X-Gm-Message-State: AOJu0YyovjQ6YvYWDm7iljg5PqHnax5nkJcEhoVXq3slMSmCti23p+Ul
 TctYTnsImVl1HWp+CTyzbB0ia4UwhQGyTymPxyXVhUHJDxOmOie9Ec4MKUDbC3o=
X-Google-Smtp-Source: AGHT+IHn2OhicMNIvcOSh+aY89fJz23BNRs8cH54YO4pe++5ox6QZTrJQRqDiSlRcrF3lI+55veTFQ==
X-Received: by 2002:a05:6358:98a8:b0:19f:4ca6:86c2 with SMTP id
 e5c5f4694b2df-1acc5c6e3femr1110557955d.25.1721723559424; 
 Tue, 23 Jul 2024 01:32:39 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:3c7e:f232:ff2a:defe?
 (2403-580a-f89b-0-3c7e-f232-ff2a-defe.ip6.aussiebb.net.
 [2403:580a:f89b:0:3c7e:f232:ff2a:defe])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-79f0a5c824csm5847393a12.17.2024.07.23.01.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:32:38 -0700 (PDT)
Message-ID: <ecd75607-c457-4f60-9d38-5ef92a7002d9@linaro.org>
Date: Tue, 23 Jul 2024 18:32:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 3/8] CI: Add build-system-rust-debian job
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <ef587f7f38ad5714d5c8eeb05448d19a6130799e.1721648163.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ef587f7f38ad5714d5c8eeb05448d19a6130799e.1721648163.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

On 7/22/24 21:43, Manos Pitsidianakis wrote:
> Add job that builds with rust support enabled on debian.
> 
> Signed-off-by: Manos Pitsidianakis<manos.pitsidianakis@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

