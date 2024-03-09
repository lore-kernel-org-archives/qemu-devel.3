Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291F5C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 11:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riv6k-00023x-K4; Sat, 09 Mar 2024 06:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riv6j-00023k-4M
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 06:43:17 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riv6h-0007ZD-I4
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 06:43:16 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-513a08f2263so136481e87.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 03:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709984593; x=1710589393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJaT4B/QpFAlTGoh6hDEgmFijrM/ZmigxmzihzfUq88=;
 b=q7iqnJeXkVap0Xg+1SsxtBswbCrKxnIOkF/cPUD5iCKFmfH0ZUh1V1Xr/tC3szDDp2
 SX1suXDF2Qco8JW2M9aQTRxRf4D4Oa7/+R3evCnYAOltEpUoM7bs00DTqonicjdWCqy3
 SgWds6mm4IEj0dvLytS3tpbC1PcA8sfuGedGyyEh5YP2ximydTrERgxs6SFbYURjD4Dp
 Bd025AvKrqnhv31lzaPlCOzzi/HxqPmR3Kp0ay4P0kfVwnZm83NPnzmPspwG7jeb4HWj
 Y8P7/SGMDkZKmhuUBaCM3k3pmkMZqsopL2/Wq5gHgdYcTeVEc9I4jnv7LG9o2EOV6FIQ
 BCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709984593; x=1710589393;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RJaT4B/QpFAlTGoh6hDEgmFijrM/ZmigxmzihzfUq88=;
 b=quKi+aFDKYIuSvN/o+PNfdhiNasoTecvLhNTAe5cZ687WFXPo7E7mIATV0INbgpSTs
 etXkLEXfXueEoX9KTglHSEOlgtlRReeIFz4Wx3p8ZhCs5DKqR08nbe32pa6g01UVDvn+
 UaBQJPlcmlb8qmtH1VzOG2vSGvhZ8yu0kNsTFp3D7918Z/hAa04iVr6EaxZK+afeHIbv
 3xVTBhisy3puTyJUnsnCRFo/DpvjXcCDf3I3mQnQpl9dES5g8bbubabsaj8psWM9hFmF
 7MtsNq0sAtcxnIlxI+osbl6Y5qBT8PNUnwt3DO2fhpcE2Ap1P//kMHZWmU3RNtZfP63F
 a83w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0ajkRcJ5+Qj5N8rDhXfL7XuJ5dbNolqHWg7IVQCkVOWSQmV9wL8ibW5w7A58btFYOKWktg/yWJFQQ62kw7Mr7lzVQOU8=
X-Gm-Message-State: AOJu0Yw1AVL8FHPt2mIyVlxt0xXKyxAkn766sOaGKzvi4hxDNAKj3HI+
 c+Bg+qCQWAOXuEltFQWMxgLNHU70Fs3HiqliaNydR5VdqmQMB8143Il0sNtf6Vs=
X-Google-Smtp-Source: AGHT+IESxozk2PeCXLxleGQTsSVR6Yb4/7Uu/IYHEub0mRs7QFB79hxO6BGwFPzxR6dTP00fAnIl+Q==
X-Received: by 2002:a05:6512:32b8:b0:513:2985:5e05 with SMTP id
 q24-20020a05651232b800b0051329855e05mr1121626lfe.57.1709984593398; 
 Sat, 09 Mar 2024 03:43:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w10-20020a5d680a000000b0033e0dd83be1sm1659842wru.91.2024.03.09.03.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 03:43:12 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 89F715F756;
 Sat,  9 Mar 2024 11:43:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 peter.maydell@linaro.org,  laurent@vivier.eu,  philmd@linaro.org
Subject: Re: [PATCH v2 3/5] gdbstub: Save target's siginfo
In-Reply-To: <bb7823f4-2c8f-4b0e-b76f-19de1b22c0b4@linaro.org> (Richard
 Henderson's message of "Fri, 8 Mar 2024 14:41:08 -1000")
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-3-gustavo.romero@linaro.org>
 <637e4407-4519-4d87-981a-acd9b5124970@linaro.org>
 <87y1atu0y8.fsf@draig.linaro.org>
 <9fea440d-f0c5-0a7c-a60e-b75e4dcf73c3@linaro.org>
 <87h6hgttjq.fsf@draig.linaro.org>
 <bb7823f4-2c8f-4b0e-b76f-19de1b22c0b4@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Sat, 09 Mar 2024 11:43:12 +0000
Message-ID: <871q8jd41b.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 3/8/24 09:25, Alex Benn=C3=A9e wrote:
>>    make vm-build-[open|net|free]bsd
>> see make vm-help for details.
>
> That won't build freebsd user.
> Something I've mentioned to you before...

  make vm-build-freebsd BUILD_TARGET=3Dall

I guess the default "check" target doesn't work due to the missing cross
compilers meaning we have no check-tcg target in the default check list.

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

