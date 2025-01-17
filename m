Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3737AC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjlZ-0000G2-2F; Fri, 17 Jan 2025 05:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYjlV-0000Fk-J1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:39:49 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYjlU-0006RV-1Q
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:39:49 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaee0b309adso316536366b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 02:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737110386; x=1737715186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rL41149iz+LogUGvpRAlZGTfajCPt4Sy+zrwIeoC0bM=;
 b=yvOa+NZWO/279Rwj3+2LLOkpLd6OBwSo8vzHVN98Wso4TLQBPNhsKl3CEQ4REGfKqb
 AbE6vk6SYdl+F0EMdK9GaKyvwGDdupq1D5d4xfBx/vmS89P8gME1fL1VidBBuRuUaHgj
 ta6hwnJNcE5dRDWJFCi4sMRvogV/y67BPg0m1/8QVTgDjmoBJ8XTwH3p8jP2o2iLyEG0
 8VtN5LgCDanBIgklbbhT/ezoLfR6yjqjVIQEZlANJ9onuFmGGMLZrfle4xcebm49MprE
 rN1fhViBy3jzj1tsiJSpS203NqN42JygISgnWCSgH2yyoIfNQUCKjAg74LiqPdmFhyQN
 516Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737110386; x=1737715186;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rL41149iz+LogUGvpRAlZGTfajCPt4Sy+zrwIeoC0bM=;
 b=ivO4nU2+wKZKXIz52sjZD32FMVSvt5Xx/jMKyDZwhW9A5XrTZ3EoJE5kuSpkrQ1m7d
 gWKgcvIrf0C2CJMZNDcx6W/0QeosG6qNhpsCo7bG8sHlQJc4jhiMTsy5o+elradHCHZC
 OJftV55sSK/UeOWUO6devTjXQZ9rb0Ul7JFsy86RndhhMG8S1w5juE6ohUybRQTl2CiX
 DuBXKfS25lH7k0p818yOzFHoumFTdBokt+Be3JMWF1E7vuTNflDNvJ2FaoRuR6sQeOHF
 jrnMqStMx8CRWgkOGUcKrQqcffFQ/4ONdxG3Oj4cYsuCo3R1CgRKD8qXosSLhgLeBV/U
 szsw==
X-Gm-Message-State: AOJu0YxYAXpiVaMujC2kL9oZkxvg0M3gzRahoGUmX1TRuzvdX80hHGmR
 ey/gdk2nZUFoIo7/UwzLbPIxUm5xFY2L+7hW0cLiBFVnvkF/SCVs8sA+rPMpqDqMzekONCloq/l
 6rcA=
X-Gm-Gg: ASbGncs2JtkCHynYaoB9U8ThhTgVY3f9WooXKNpYj4FSCXulpSMqBZ/ec4xWFWYlhRg
 nGIqCloFxj6Pk7UXfYyAcixmaasg5PQSTSfHN2if84PfhXA0lDEPZHGe69XZKJgXcRXyMW+lQnG
 ROicFLnF3GY7/SplYo0ftDS1VsdHDcOYXnHoQsVgTcEcK1gTRPdVEyLphu1gVH7ILVPtt2/YukH
 5JQbhUZj3Pe8gQPXaBlfMhD++5IVoIbba0M13AT/k6ZhGwW4RNkYTnE3GEQ4MkFkA5r
X-Google-Smtp-Source: AGHT+IGA4uqxZUglczLCIMU2iw30xy87UwB5Q4wDEy70Ra3hVdj/RtwufPNadCh42YHAkDAGlQkA8Q==
X-Received: by 2002:a17:907:2d0e:b0:aae:849f:3255 with SMTP id
 a640c23a62f3a-ab38b1c4d61mr215424966b.34.1737110385887; 
 Fri, 17 Jan 2025 02:39:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f87d65sm147152366b.151.2025.01.17.02.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 02:39:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A3FFF6083E;
 Fri, 17 Jan 2025 10:39:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Kyle Evans <kevans@freebsd.org>,  Hanna Reitz
 <hreitz@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>,  Kevin Wolf <kwolf@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  qemu-block@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2] qemu/compiler: Absorb 'clang-tsa.h'
In-Reply-To: <20250116211111.53961-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 16 Jan 2025 22:11:11
 +0100")
References: <20250116211111.53961-1-philmd@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 17 Jan 2025 10:39:44 +0000
Message-ID: <874j1xhggf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

> We already have "qemu/compiler.h" for compiler-specific arrangements,
> automatically included by "qemu/osdep.h" for each source file. No
> need to explicitly include a header for a Clang particularity,
> let the common "qemu/compiler.h" deal with that by having it
> include "qemu/clang-tsa.h" (renamed as qemu/clang-tsa.h.inc).
> Add a check to not include "qemu/clang-tsa.h.inc" directly,
> remove previous "qemu/clang-tsa.h" inclusions.
>
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

