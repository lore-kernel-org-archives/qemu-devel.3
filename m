Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890A0C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmuIf-0005KU-R0; Tue, 25 Feb 2025 07:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmuIP-0005Ii-Qn
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:44:24 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmuIN-0003bq-RF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:44:21 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38f1e8efef5so3254730f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 04:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740487458; x=1741092258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NK1n6Lqgn4G5WCmuXE4U4lQ1gplVqfE4dwMWvEYq/Yk=;
 b=fQE4ZQfmdcwDX2j5X+RX8GCk1PKbxCqrtQFNR+WGfuw5tvmeUpGFci+QqJizn1gzL8
 bnUnBksnwtxrIU+OjBy4RCZE0W/UyiJOiBcN+izBI3pYR/f8YT0nECwp+4ukdtc5OH/l
 LcuvajyHfp17CBaS2Ar3EsBUrRea174hL7kq9t3G/2Yaqy67d0XtwnzFV3oEx4LBEPKF
 LnWwaWAvlYNWEXVsFMZE5OmVLyAre1UOh5QwdlV0C2xDITJU97U1YrTnYGgesxymDyHd
 MtcOo88NHXVu0crqP30rhR5xhwX5GQVGqRybQ+JZiqCPeJnyjjjGHMcwRc1vc3zpqeeJ
 ctvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740487458; x=1741092258;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NK1n6Lqgn4G5WCmuXE4U4lQ1gplVqfE4dwMWvEYq/Yk=;
 b=XK92ma9u/7gSmrgJWKkrrJDY3rXRpQ+3faK1iAcVTEDgA2P38IEp6PRGf6gDpxr5U4
 nsxHSXVoXjVNPR/3UAvGmmLJBkEA6SD8eTW7E9eDtzp84CocbQWJbgXU0NUyUj9HsYsz
 Sf6VDMlADrE7MmKnSqSPQcrgycAa8VnmgZF8uoHqJKEg/IujUdkNb+9il9zzXZmj6AFp
 ZPwqKJCxm2r8OEa7o9XhJI5N6nG8xk8GJpZ7rVl8k9nvgYz+kqPIAiCa9QTOlPVRHgSq
 prU6lFcsLOBMtkgHkwt5PQPDOvOCRo4kufXKJuheOYZBDoOalxHQDJQ4ECSYo2M3bYHs
 SWbg==
X-Gm-Message-State: AOJu0YzbwWABYG2gex6Jh8jJK24RmkD+QmjSRkFoZfQIJk3FJ2IQPSV/
 YQH1wfDFpCmQkLUWGXdRInFbMRm7iE049zMlSi+yjEeCKLkdsddbKPCGmtLefOE=
X-Gm-Gg: ASbGncvxa02UqM3yHephkcdZykK99Vs7EWiH8h6DZsnUxVqwXi77vM7RirmPMkZZZSx
 7eVrrJA8xXNqACLSRaVq8f3bXftn2XY6lDKgoq/GhX2vnPMk2+PVIbjRATq7F5j4O36/VWUOnA7
 UYcoT0DbT7FB8q66jrJq3B3yYgD6K8AWh2B8xLP22ZRIJashmO5H8GzKXT6OwoeeKr+3Yb8xolm
 pRrJO5+3crWK+Ynl3ASknF9zQ1oRmEjbB1ChhRIOnJDEmp0+SRtVo6uuVzzMvwoXavu9u1ROoFU
 E8EtJu6ZON90f+JO4/VTGUP0o6tA
X-Google-Smtp-Source: AGHT+IG1qD8cG++Qfpp3hhQ3niJ0LA0AXN89+cT0j0E4ouGUFsKIAxPvcgsifCuXdNDnG7Ch4rFxdg==
X-Received: by 2002:adf:fec2:0:b0:38d:dc4d:3476 with SMTP id
 ffacd0b85a97d-390cc63898cmr1692356f8f.52.1740487457858; 
 Tue, 25 Feb 2025 04:44:17 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab1532f20sm25654035e9.8.2025.02.25.04.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 04:44:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 961495F7DC;
 Tue, 25 Feb 2025 12:44:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 07/10] accel/tcg: Simplify use of &first_cpu in
 rr_cpu_thread_fn()
In-Reply-To: <20250207162048.1890669-8-imammedo@redhat.com> (Igor Mammedov's
 message of "Fri, 7 Feb 2025 17:20:45 +0100")
References: <20250207162048.1890669-1-imammedo@redhat.com>
 <20250207162048.1890669-8-imammedo@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 25 Feb 2025 12:44:16 +0000
Message-ID: <87msea5h3z.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Igor Mammedov <imammedo@redhat.com> writes:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Let vCPUs wait for themselves being ready first, then other ones.
> This allows the first thread to starts without the global vcpu
> queue (thus &first_cpu) being populated.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

