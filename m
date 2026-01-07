Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91314CD5822
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 10:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdQlE-0000db-T3; Wed, 07 Jan 2026 05:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdQlB-0000Og-Fy
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 05:27:25 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdQlA-0005sb-0m
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 05:27:25 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43260a5a096so1259393f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 02:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767781641; x=1768386441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvZqZpwzW04v4tSp8tuCASnRPcPT5TqGG1EZoVmDGtM=;
 b=Xbt7I8a8fScBAjjMGHkKlL7ESgnw3KETJ5QSbI/RpEqpNAWAZsxt8KSVWYrzwDi62/
 igaR95rzx6D6yGcpbVr9xKZ4ifTNglsKcRXehSWUOqDD/T74Bl7FT4hPaLNx4PHqfIME
 ngqnQE6XNSjOZK7M071E9aFpSLimXwgI2ARtDYudFLinNndL1TIFNxbpoKLlhtNn6ot5
 HETxU4W0Io8xLN4rshv9bAGy+1xldNbPndNxevhkdRCJ4MTirm0cJRipAQmDepfcmTZN
 1HbKVXNRyRKS5JW6lWMauHWwUQkhr5cp4nc+K0ibCv0nm3cw8MAZJtzfWJugNvRowb0C
 3RWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767781641; x=1768386441;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rvZqZpwzW04v4tSp8tuCASnRPcPT5TqGG1EZoVmDGtM=;
 b=CtBo4ewTaAJqtgxHB43wbRFtxgCHGS2MwDxIvYB6D2QtLtXbrpcd4ECk4QDe4XNIl+
 XwCDO7A+ARyHP3z8o2vdHZ6da5zUb8PWnuu5gbCHekDHWc6kGYfMfdubF2ZHnfwf78no
 dVqGb4P7zBP4nATYXLE3e15kkw8FddroIs7O7gMsh1WS2mxMrJThXws2606dk8/d+du+
 +XCjvt+AFi4dmL8yG3gJrJrOdk8HgT2iflF33cYurUia2BjAMql30Tf8XtLJD4E3JJVX
 I2716f2nOBTqAR4hI3t7oG8o2nG/FEg4F2Jw/P11Xf3KYUuS/jJHmr58FmyTbDp0SI//
 4I3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjkDx2jWydPnYqss4A64EDZc96Xje+WOis4e5Rqvhr3aP0w5ZcYwbN/wbyZCSb0B/DiHtg41gVf0Q5@nongnu.org
X-Gm-Message-State: AOJu0Yw3AtMrqLhahOjbB0x86FkOroZr6TY0ndMf9s0gHMFwlYq4Wr1A
 cDQWFO125JmunJcp/TX3g1gbaOBilt7Fs0572Lz8QnEfHG8DS0iL8XyLBgqmvevyI8w=
X-Gm-Gg: AY/fxX7xK22PQDqXvKBP7wKu92OSl4FP8XNDpltS0cSJ4PckT2NCJ4KHDr80gQKkHHc
 SLG/NM4G99XuTegbtrfiAJXi+0nu46ndYtp8iRsd4VGoS0GCy3c5oEfq2xVTEq8oGRhYsZ1uQkr
 BTWRL9kXL2TbZMIVKztE5uiy7eh0Y5TF5dHVPJC5bOR/ZxSqCEA1yJThww3/Ab+PlUgIb3lZhhu
 1J3nfCMsickB5uJMEwtU8+a7sqeSrLL2Kw/hqIG1Asdmdteqf7ipEOTHl2Pgrdt5VdvzxscS6/P
 IsSVLM92UtyvZZRTJRyQe3In1JbC/QMinPUbWbmvR9i/AHI4lxnxCBwFghhdyno+gw8k27V+178
 /h7/GwCHk1MLK24L0ePG1OTqq+pEr0rbse9YCXlkFWlLBuOH1Jq24XmC7Ez0xLnrvyI1t6e931f
 uV4vxqkPMG3+0=
X-Google-Smtp-Source: AGHT+IEHWzw7EoE8O7WZbRGm1UJ6PRmLKJfImhyLqixpTfPXtfF7oGe3DDs44ZtWnx63qbg8072XHg==
X-Received: by 2002:a05:6000:2881:b0:430:fdfc:7ddf with SMTP id
 ffacd0b85a97d-432c37d2db0mr2422141f8f.42.1767781641059; 
 Wed, 07 Jan 2026 02:27:21 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee243sm9362186f8f.31.2026.01.07.02.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 02:27:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 764305F88E;
 Wed, 07 Jan 2026 10:27:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ani Sinha <anisinha@redhat.com>
Cc: John Snow <jsnow@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 qemu-trivial@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH] docs: update copyright year to 2026
In-Reply-To: <20260107045250.34420-1-anisinha@redhat.com> (Ani Sinha's message
 of "Wed, 7 Jan 2026 10:22:50 +0530")
References: <20260107045250.34420-1-anisinha@redhat.com>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Wed, 07 Jan 2026 10:27:19 +0000
Message-ID: <87eco1afaw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Ani Sinha <anisinha@redhat.com> writes:

> We are already in 2026. Update docs to update copyright info to year 2026.
>
> Cc: peter.maydell@linaro.org
> Cc: qemu-trivial@nongnu.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

