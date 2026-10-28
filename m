Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C06606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IZRizK+h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6Kc-0003C0-Mk; Wed, 28 Oct 2026 12:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6KH-00039g-DZ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:16:35 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6KF-0005rv-St
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:16:33 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b0f59a5fdeso11503077b3.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793204190; x=1793808990; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PQZTJ5jl1Cmd23E4uJmciMsO4Dz+/JorpYpFOsPWXqo=;
 b=IZRizK+hoPMyrOHlNcEx8SyU5XXq73fv5YheVU2k5q2v7yKVKbF4Aj5LKitCwL0ZzS
 pUuLZBhMeyBST0yTXBHWyykRa3hJARrvOZHhhriMo58HIaOHK86kUGlMkXTXrBsA3Xxi
 S3CpgsOvaYXNOMii3GGV5ZNTGpd5SZw9hih9eKQ4f4iXs8xP6C/ZmojEeTDROHkmXWTw
 b3lR/bG6GcPk+R99slXPZHunAG15ZOWQ5pDVb1aEbtxPx1MSbTtNNS1dSXvgbgFRSTCz
 Azeund+1MZN9jYS6+Vx3Pq1pragz5AAOaOI0laZXpxofVWd1U7lAra+rjbxRHRsYs2rC
 WGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793204190; x=1793808990;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PQZTJ5jl1Cmd23E4uJmciMsO4Dz+/JorpYpFOsPWXqo=;
 b=zyJYe0oTVTWVffl4vlX1lM2UJYsbYMLSsetmaPLxskjsAJ/vl1vrrDiVgI28tDaPYm
 fkLNp0Y2i+6eF2npTg5fS7PZiIi36e6Nd8QQqn9BFzXodRpefsuStJPI6Y6UiA0CNBXr
 9PiWsnfQfvV7ymo0O4hbfaPgvtlnHq4B059j1/oMbsc1l3SOrtG86WqTjGwS1sbyUVHq
 ihvUxTwOACm5XnsSQmYRk1KPJZy9TcxnYs3sCfasvp+4MPMjIAnNQZ+EYDZ3k5bB8Z6D
 GcWSJx/lerV1UiVg8VqeWYtepFMd9TokT9OJiB7pgLSrTbSMuGFFp4ohDJwvpOEzetbR
 y0tA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2H69MpeSpYtAQPznRDUh0mY4y4a7IDbzL6NdCQ94f6X3addqhuItjrHYdDKkdCGriLrmngRm1J6pr@nongnu.org
X-Gm-Message-State: AFq9FYK0wGyIQFJ99VoIZ2wefsPy3vnSI4AsUN35dbt99XO8FHzhBEM+
 gdj9x2F+HAuFMFiGVy1MfnSmCcRJ/mo6C5QzU1sGXB+ogRDKJlRzTsUA+/U0aCrijjE=
X-Gm-Gg: AYBFou3HtX+hwBHCxy6hv44xcyYuMbHk3L+HTq06jvllKVVzE0fK0ybgKVTf9zz1LPV
 l/4WC7JfpyDwNkX2eofAaRpqieuTACbrRIzTllq/l3bqSQ6hUxIMUYxd0WObxQAw6DTDnIGXaet
 odofcowNQsV/eVDfCC97uJn4FxkkPOFR5RxBFaAdvmSGpiJ6j1Ua/USEh9f6Y2Cajuutt1OA3DR
 eAgHhXVd302EU4PMB2S/iIWV88G82EhQQYziq/jVTL+GJBA9S06D5F09stVe8ULmOmdtIAFbuwt
 emwnEudo92QCo1MA0hXuKogCWg+O1P47HzwcfBOfODqk4wYFHNVawewkhcSYfKQ3GZQjaOnnX/F
 25IjHaGRPXQaD1CxpmrZWAYqZa5KRp+39p4reu8EonaWM9mSUs8ZR+4/P03OPxScZyc/tAdHGzq
 9FZ42+9LWSNN4kUpjXCB2dlyr7iR59D3YBNSEyGFIbsDZI/zDOn7r5ZxhIqjofKcQ7gTaRYsJ/3
 w874IZ+qpSfL9cipqa083k9IKFnq7oHTTWpkPFsjYB+LbyhK8NOh/cTxX9+pP0V58iZrIQ7s5pf
 aXl29r6k9JQldhFYtp+zgG1yQdPddvG/CieyGob7PIJolRYTyTmDTZpY4UFoZo+ryQk+iACX3B+
 WvzCZiyPcU8pR4SUawkUwYYUorULfJO/S
X-Received: by 2002:a05:690c:e3e2:b0:8b0:f074:75a0 with SMTP id
 00721157ae682-8b1b5c13161mr18578657b3.23.1793204190194; 
 Wed, 28 Oct 2026 09:16:30 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6?
 ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b19e43d1c6sm31482207b3.6.2026.10.28.09.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 09:16:29 -0700 (PDT)
Message-ID: <a94b80f5-1938-4fc7-a6f2-d50e045cf06f@linaro.org>
Date: Wed, 28 Oct 2026 11:16:27 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] target/mips: Convert nanoMIPS LI opcodes to
 decodetree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
 <20261026162034.32711-15-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261026162034.32711-15-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112c.google.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 11:20, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé<philmd@linaro.org>
> 
> Convert LI[16] and LI[48]. LI[16] decodes its 3-bit register
> with gpr3() and its immediate with s_eu() (0x7f encodes -1).
> LI[48] takes a 32-bit immediate and is not available in NMS
> cores; handle it in trans_LI_nnms(), which checks NMS before
> calling trans_LI(). Expose check_nms() for that purpose.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
> Since v3:
> - Fix LI[16] register decoding, using the gpr3() mapping
> - Fix LI[16] immediate, extracted unsigned
> - Fix LI[48] immediate halfword order
> - Replace the not_in_nms argument by trans_LI_nnms()
> - Reuse check_nms() from translate.c
> ---
>   target/mips/tcg/translate.h              |  1 +
>   target/mips/tcg/nanomips16.decode        |  9 ++++++++
>   target/mips/tcg/nanomips48.decode        |  8 ++++++++
>   target/mips/tcg/nanomips_translate.c     | 26 ++++++++++++++++++++++++
>   target/mips/tcg/translate.c              |  2 +-
>   target/mips/tcg/nanomips_translate.c.inc | 17 ----------------
>   6 files changed, 45 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

