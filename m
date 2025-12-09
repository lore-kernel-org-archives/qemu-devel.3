Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5C2D3B7F3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT4eD-0004ci-Az; Tue, 09 Dec 2025 15:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vT4eA-0004cG-Ky
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:49:22 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vT4e9-00034t-8E
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:49:22 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42e2b80ab25so2501139f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765313359; x=1765918159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+RbwJ37V3UMttIjGuPcbd1lBCkRUL+wM1bmmqBNoJL0=;
 b=DXsj5Kf/+5lKn+8kKvZmY1CgMwgwJlRyXlDGMoiSE8njkHELp/K+DK5qTP1BZ6+5+k
 DkPeAZI55h6IN/8eP/JD0cTe/pEszJSRsIwK75EFlrIaEUwzbyDIEpFndmdvcatestYO
 Gu0cmPcRTu6XOKAojO5SBpq0uAn9bpdERjBuce6//MghnkKwjnMXEswBiLIB2QtAUEQZ
 da28BChInK1RqkKQPNHZBD6iF78q9Gb2UzPkAo0itXb0Wh2ExpQZRJXL8JssFEhIiQvT
 5CBuEEkvPdqfdcpxT6Wy8AAEb4TEY/sLj67Cj5cU0irD5cnBd+sp+et1WPePxGMXHPgl
 NtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765313359; x=1765918159;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+RbwJ37V3UMttIjGuPcbd1lBCkRUL+wM1bmmqBNoJL0=;
 b=gmZGmZPrqoU6T6YK+75eiukcwV3jkRRAJnnag2bNQ8lQxsnEyaTr88wnVUHGYqluX8
 k9Vj266VYKABZ3YfhHBdtF3MUostrdnEpP059IM5h6ohR4LA+Mrfm1NiBN4c/d7PAiGR
 dnCJVSinSajyCH7UFU6PyuOaMy2A9ERvJrKfP9hXJ7j5PgofRjrNlyvCwBI2UkUeYrYg
 t25KEkqOefE9cZLHTOZL+XedeURn5iXut8olxxlcE+MK5e40WKslL4ZE9djA0HDdpDcw
 phb/EcCcIUIX8K/j6DD/m2Ua86eFmZEahZweiqGzwHlSTJgcHdZ5vBmh4jbyRyOAIjId
 ly+g==
X-Gm-Message-State: AOJu0YzD+yJhZOKcmBgzc2LB9ylmIxkPBVXfv8VG47WeXx7Qfd/jvh1y
 YFcbj7kCoJeLioqGglhUIV2URJQrh+SjTwU02d4/TcnJKVKb4KqFw9h5n2OyUojmjpQ=
X-Gm-Gg: AY/fxX6EIJQcYF8OsxNiKr18tusOhearOWEwQp2OiZ7OUINM0ttOKwjlSi7Zqgd3yw2
 zhnKhJnx+gqOcXC6YeufffNT+iaRVBHmf/wR2YDCABgdJOoU/Wl4ggqfkdZP7ee5akJ56wWxh01
 MTQBezuDtCfH1I5UKUiT9UEzGIK9h0koF1flH6dSFbBKSxPViMWb4bQB53rFS2SNt/pTeWkW6Kl
 uvd96lXUrDRf/3h/fEImJ6SO4BS4o7qHhgMa8YDf9bs4312vFTEMUOOVv+l3yqqIna9JULL9KpT
 ++VVpX119TltmU8y2DGVgBpuIcmU1gDCESlQUgkLMclkmLYqlp/4K9ymO8rpUQOPF58wzlRnJRY
 LNONfGHsKxPkPqOfaNWXLCoboxz4f6e5Kg4Nsrr1IMtf7ii/kPW0IqxuFa2m8qWtymZ4J8cb6su
 0ODCccma1YAfa72I/bKh7XIw==
X-Google-Smtp-Source: AGHT+IG2jA7G3mCSIOme+uaGW6fDKNwSb9PW+PVNiBsb4w5qAOJsLgG6nEhI9xuVWpeXCf3M806+Jg==
X-Received: by 2002:a05:6000:2c11:b0:42b:3ab7:b8b8 with SMTP id
 ffacd0b85a97d-42fa39d2f5emr96548f8f.25.1765313359458; 
 Tue, 09 Dec 2025 12:49:19 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222506sm35873243f8f.28.2025.12.09.12.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 12:49:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 28BEB5F818;
 Tue, 09 Dec 2025 20:49:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC PATCH-for-10.2? v2] tests/tcg: Skip syscall catchpoint
 test if pipe2() syscall not available
In-Reply-To: <20251203143755.65535-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 3 Dec 2025 15:37:55
 +0100")
References: <20251203143755.65535-1-philmd@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 09 Dec 2025 20:49:18 +0000
Message-ID: <87y0nbv0s1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Avoid the following errors testing i386 and ppc64:
>
>   $ make check-tcg


what are you running on that this fails?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

