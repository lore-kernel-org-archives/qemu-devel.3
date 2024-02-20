Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AA1C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 10:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNCa-0003ZU-RL; Tue, 20 Feb 2024 05:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcNCa-0003Z6-9T
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:18:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcNCX-0006NJ-IB
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:18:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4126dd40a54so4615145e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 02:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708424292; x=1709029092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dD47USlRE9SCSskFlIhsE3baFMZgQDtxOJr+pWEYaM=;
 b=Cr5bo1/UolsQMniaWoKy/NXWlYFRRK4G8kCEWjr70wpvd7p8w3L7F1+sC+dbwCvGfT
 1+W+fx1NbXqEKfvo7Wbm/zvYGvzEZGvBXwtIFciIUl/3X0f8jUUHArzYxKJUTfqbcKB0
 sgnYK4EO2V1w5QI0E+VqISh88aVFs+z68xOArDI0gzODCp1ARaqpLq34Q+c011GH2C99
 SVREfLeNIUWj+n4J4ZZ67RakU5PiM8Rp+tRvzmrRjMpmfCeYwU9LddEhrJU1Lgx96x4x
 xMlQxLTlBSCvOZdb/UlZgy6AkdYTtbRD/oFIpgfI2nyjuHwlvr5itBc46+RGWDCJbMhm
 HdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708424292; x=1709029092;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4dD47USlRE9SCSskFlIhsE3baFMZgQDtxOJr+pWEYaM=;
 b=cIACpp9nXfKGn4Sm7KAswG/VOXQnEr4r3Mw64Ak2ZHnqZm/1v0iLtv6kRINMPBqAdE
 w2PoFDpxisjEQGAWEmk5QZ0pxX/PMqMJCzfAuy9oANq9rjFLLyrkTOqs8rX7FxZjyhNF
 fQGntYV0/mnENFrld6c4cGM14GLg0jFvc7M+A/eZKQGOOQUQ6XMytnQXHFsTyHX+eO21
 nvrfjLfRrCfUM/H/pHukVyLHoIiHSWAN6GWazI9tH3U1OdTQeAfIlgv5TFBynaXKWNyb
 ITAg32wxaRn+RcvBurz+xYWQrS428JRXPs4yCFkNmHCQgvzrrMH75ubUvTKhGayUWxtm
 lPzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeiXFjXeX4vdIy9xOpIGyFdoksToPMEC+okWL9mBKaxXaagJfRkmF5vXrenSvDRN3W2ZeDL0pGWyPF3aUdubXWF9ARWYI=
X-Gm-Message-State: AOJu0YxrrzrsvB6sznU8F9ZcG38p0fOwhVxpJR89sOq/tbgOzNNX0h28
 ODLyqQY/Ymb/q2Pu68C+uzfhGEULD2kDz7ufMzGDwKYPZ/zJA7cLDN2x1AMFHt8=
X-Google-Smtp-Source: AGHT+IFKeje4En4OJW0yyKAkVrq/QTe/033HqKNOi+PNLpD5PN72yNamk4OxsBeHP0hmze2uQyTUGw==
X-Received: by 2002:a05:600c:1c1e:b0:412:1615:7343 with SMTP id
 j30-20020a05600c1c1e00b0041216157343mr13535031wms.5.1708424292077; 
 Tue, 20 Feb 2024 02:18:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f2-20020adfe902000000b0033cf24700e5sm12898016wrm.39.2024.02.20.02.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 02:18:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6B8B85F8B9;
 Tue, 20 Feb 2024 10:18:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-trivial@nongnu.org,  qemu-devel@nongnu.org,  Michael Tokarev
 <mjt@tls.msk.ru>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 "Hongren (Zenithal) Zheng" <i@zenithal.me>,  "Canokeys.org"
 <contact@canokeys.org>
Subject: Re: [PATCH v1 01/21] docs: correct typos
In-Reply-To: <135bbfcb6dd09377cfd39fb73c862cd0fb66bb20.1708419115.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Tue, 20 Feb 2024 10:52:08 +0200")
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <135bbfcb6dd09377cfd39fb73c862cd0fb66bb20.1708419115.git.manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Tue, 20 Feb 2024 10:18:11 +0000
Message-ID: <875xyje8ws.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> Correct typos automatically found with the `typos` tool
> <https://crates.io/crates/typos>
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

