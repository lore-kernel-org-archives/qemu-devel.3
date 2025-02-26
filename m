Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829DAC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDN0-0007ll-An; Wed, 26 Feb 2025 04:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnDMr-0007fs-AS
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:06:14 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnDMn-0000j6-U0
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:06:12 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38f378498c9so6392221f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 01:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740560762; x=1741165562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBWrVeN4EVHwtHqwKyo9ht5xZB0DSq+t4haivjiFQkw=;
 b=Y6wKrKBCXdhHv5TVb1NX/1SNm30HP/YNl55CUBvgvRkTJoPih4vSM3C+hIihUFiHAz
 JqbBAJjpDtWY1ZZghXHknMwMjvN1Xw9HtOflaqCsIY9U6rbL8P754eJbz74e6Ost++C4
 OA/sjK3D4KtalDUaNwzyL8bRlcKP89FnE0x7jh8LXosI0y8Jl3TGbUcEg6K4Qcf7MaLC
 oN3HDdOswrwtnlPVMbFdITgGIeBo+yEHnIoXHxoEMEIc1mVsAx7m/0KcUKbmfrwyd6ig
 UPBhSkKsBf/oxuJMbgw2w9mZBFgrJ18GLb3TgLOP2KvBafIOZXBQ7DD2PonwaA/pguYb
 +jPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740560762; x=1741165562;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QBWrVeN4EVHwtHqwKyo9ht5xZB0DSq+t4haivjiFQkw=;
 b=afFuNAVse4teKBBAErZxX+/SVv0f1/eJOT00in8D9icmTTbEhT36EzfQ+hhg6cFAM1
 88D5Jg56CwIBrt1E3pb0tcf7mC6uWBFwNKfx5DAteHA4wLNz4u8amPDZzjSyWua8f441
 FbQBnheQe6ImbWpm9vbdf/9nYe3Dzknxkr0pv4XpIhM8EXTZ6JyLZPjxDX2gelNpEFxu
 KGZO3jGlQM5odzqybb3NNvSrbDTVWk2Z3WVvOeqn9vJPh+IFGBQz/W7v8+/GWr49z7PD
 o56WAjcA7aFgiYPKrPq3Hs3RLFXMonZFJZwxfqBPmhGK2/MyLeDWXO14W2+TOnsCw0+u
 4Etg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVncNha37SgazJF7p91dZ+hDrD6TxP0z5jubzdYEmyNIFqntcxMrIk+bCJRRX+ifmEIR0Pgp6gMhB/D@nongnu.org
X-Gm-Message-State: AOJu0YzAQD+++Iwk+IhOJBMo3YkwdmwI5qTeAwae+mprJ2AuJ4h9h8XC
 CocpZ6jYbeEV9np3s95JgWVEQTWaer2HaCsFAnmJhsvwccn7KDvqtgv28QPz0lQ=
X-Gm-Gg: ASbGncuLB4CVwvn+513QyZkEUTsVz8hg3StY8T2wMEle1oNtOJW+OenTK+jQxGzpL/3
 CR8uwazBnb68friKRKkuYE2qe1tUXrBe3lv5vwpEyYjvvrsM2iaSgjaZuXaKPBG4N3P2sVIMyp8
 EUcYZADcQKrqrbFTH5kusoGV5IarpfOTLuetVROSuriSBiR4tmQKCEszqCVLYs4u1GaW0u7wVB8
 1DciJ90LNiaPSX4lJ/6NZuMjeXWyLaharyw0Hqj+ez6KVObwRCyMRb31/1EBlxpIdwbUl5yQxje
 mBXlo6uxzSF93bclVw44q2KAKoLJ
X-Google-Smtp-Source: AGHT+IE6lDytnnt/EgCisSZKqUaXgdV81dzoVdi0zdOm2dvvDR9J6kB7xq5P8f8C5Vs5Qd/QhdcBvg==
X-Received: by 2002:a5d:6241:0:b0:38d:d371:e01d with SMTP id
 ffacd0b85a97d-390cc63c05bmr4397012f8f.49.1740560762505; 
 Wed, 26 Feb 2025 01:06:02 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86caa8sm4789219f8f.25.2025.02.26.01.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 01:06:02 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5983B5F87C;
 Wed, 26 Feb 2025 09:06:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH v3 4/9] target/arm: Always apply CNTVOFF_EL2 for
 CNTV_TVAL_EL02 accesses
In-Reply-To: <20250204125009.2281315-5-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 4 Feb 2025 12:50:04 +0000")
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
 <20250204125009.2281315-5-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 26 Feb 2025 09:06:01 +0000
Message-ID: <87ikox3wjq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> Currently we handle CNTV_TVAL_EL02 by calling gt_tval_read() for the
> EL1 virt timer.  This is almost correct, but the underlying
> CNTV_TVAL_EL0 register behaves slightly differently.  CNTV_TVAL_EL02
> always applies the CNTVOFF_EL2 offset; CNTV_TVAL_EL0 doesn't do so if
> we're at EL2 and HCR_EL2.E2H is 1.
>
> We were getting this wrong, because we ended up in
> gt_virt_cnt_offset() and did the E2H check.
>
> Factor out the tval read/write calculation from the selection of the
> offset, so that we can special case gt_virt_tval_read() and
> gt_virt_tval_write() to unconditionally pass CNTVOFF_EL2.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

