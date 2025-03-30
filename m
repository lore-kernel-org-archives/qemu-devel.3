Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC418C28B20
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 09:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1typHR-0001IW-Tl; Sun, 30 Mar 2025 05:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1typHP-0001I4-5I; Sun, 30 Mar 2025 05:48:35 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1typHN-00058I-Nu; Sun, 30 Mar 2025 05:48:34 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac2dfdf3c38so643608166b.3; 
 Sun, 30 Mar 2025 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743328112; x=1743932912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRdudXDYt8RHgefvNy4Ckoqy5VflOX9G0dwjwHRqJVc=;
 b=h3qQDH17DWr5MHrGBZEkPFLxLGAqBxThkzpDy98ifrrK2QfNYQ2LhsNJy6g2Pj2nFy
 +mZxAvjsic91ZHJxYDpjxv1Znx8nn3mmGj/fin04KzXoTaWW9MkYM0EOIjio1d8Xvy+8
 KBibvxAjLZ2G2GpAHEpAjeaUknQz39YPt+X+fbBfaddeC0iyhohMkUL2tegBcat/9zm5
 rFmHEkA3rsf/nKwoJunJppvEq29ITQ3VR4yP8cQy940H5gLvBBocqzo0N4IEq8jK+t3j
 Gy+f1ecK5NVVzHeu/Z+908g9nSKyOSMd43giYhppwHWI3ctvRtgKKWt+MYcd6fsYZ20g
 wSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743328112; x=1743932912;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRdudXDYt8RHgefvNy4Ckoqy5VflOX9G0dwjwHRqJVc=;
 b=N3HaIA+czzF9Mn/DljPuORvU2Pd0rJbRptKpxJAq5H+g5rU5IVFGiTyibJsieFK2XV
 QLerDOMjrGVEzU6V5HEv2ln7KtbFAlFpGE6PEPsohCgHmGXn/M8BjOt5VrwAQRM3M8CJ
 M1wpFD/lpKkJFr26mkzWlwUQJihUE09frTJ6lyJg0ONvcPaZ9oVWGqkPn4lDsAT8fzGI
 K4XgOl3MIkkOEaMTuoD60O6Mpf7Dies0RX0cn/NNkmX2sRfZ6h5JsoHunoJOpuyCjc32
 0Bec+jGUQ6z5zCoVT7/jCdhAdjPMKezNMxlST4aXPRic8VeotENUTXnVnfGqjg/UoPsc
 HSFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrBWg3cxilEKvUjpWVz30mw3wOuplqVqEttW68Qt4w3kWIpr38wcZ5pLN/pm7wyKMTpjQeh2cPlg==@nongnu.org,
 AJvYcCWKh3+2xvxAj9PG6McSsV1n33iZ2w6yLRITH348mEF5qVPxiQgcu7gsqKyw7qN3ePtA5VOjVqgzn15dnw==@nongnu.org
X-Gm-Message-State: AOJu0YxCSZh6QsqyqAZJx7zNjf8Rd/fqcli1mYLskJD+9flPgp3cWJrH
 83gkYRUvxAaso0CFwwHCcNi0IgdE41Rom1LoXpUQ8bIbfHRimEaZ
X-Gm-Gg: ASbGncsmrzI0K7KVsKpI06LTx9JUR2KxE9W3hWGB8WX+6/xK4j2DSy3N3F7O/zdZvFa
 5Idrq5C5sfIxTDWBjGi/RbGnEZbpBHbcbZd7C1AqvH1aflVavXZ8Bk6lU12d8OL4BFdN3f69dTA
 Pu+xMkVVDkVI7H/ngfeyE1N1utTy7MlAsHBh9N7iaX3m3eKjVaUJDJufbEJJg7Pi9Tzh4WyURWG
 2ujnO0OAR6+gDLyDrLeWuDIpZe/8A31dsu08xKWWX8jsUfpQHuebBnl2yDPqCs6PvIGYksrKhHR
 TBmiXf0gCpqMyZrK7FRBeQ/kdApv6NrIy8ujgPZXJ9iHMrHHwQkMJ4oImuhsl4GfidwkR0n29tP
 2mDRQuTHemUCpTeS++GBsgQwNXPEsXpWt6SHLljlBPzi5r12nSwG1
X-Google-Smtp-Source: AGHT+IExwKQIT8sAh+WknFelYKSQjI3YJdL51UtwnRtaMfbhZzmteV7fSeTgsrEbISbQZWZ8p6z5ew==
X-Received: by 2002:a17:907:3f12:b0:ac6:b639:5a1a with SMTP id
 a640c23a62f3a-ac738b0ba28mr483032066b.28.1743328111543; 
 Sun, 30 Mar 2025 02:48:31 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2ddd-7900-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:2ddd:7900:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71922babbsm455901066b.5.2025.03.30.02.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 02:48:31 -0700 (PDT)
Date: Sun, 30 Mar 2025 09:48:30 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 0/3] i.MX 8M Plus EVK Fixes
In-Reply-To: <c794ca2f-43f7-4abd-86d0-650eb53602d4@linaro.org>
References: <20250318205709.28862-1-shentey@gmail.com>
 <c794ca2f-43f7-4abd-86d0-650eb53602d4@linaro.org>
Message-ID: <CEA374C6-D7EC-42DE-B8DA-EF6704C6527A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 27=2E M=C3=A4rz 2025 16:19:32 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@linaro=2Eorg>:
>
>> Bernhard Beschow (3):
>>    hw/arm/imx8mp-evk: Fix reference count of SoC object
>>    hw/arm/fsl-imx8mp: Derive struct FslImx8mpState from
>>      TYPE_SYS_BUS_DEVICE
>>    hw/arm/fsl-imx8mp: Remove unused define
>
>Series queued to hw-misc, thanks!

Thanks, Phil!

