Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CA6C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 12:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkkBl-0002z1-JH; Thu, 14 Mar 2024 08:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkkBi-0002yB-Oo
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:28:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rkkBg-00023O-If
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 08:27:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-413fd8e4b3cso7235e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710419274; x=1711024074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xU6vldNdfhEMmVPXKJ6F5qcXFrr2Um3C9M04lDiDrWk=;
 b=jWHTiPYxLb3Ml71vaWRCBL9+TcBkmX/7uNMOx31dQxYUtSOB3ibFQDTogmSJrshc31
 5oNskTkNwRMRyQaatAkYhiRo0xXX5DzBGXxFOSZbMIp6nLu65Q9Apqw8W0a+kt3kzobk
 8nY7xrX2poxPRnaGbvNFKnfOTYCHmXYT3kRpc8xkf4TmlYhn9EUny4JeN/nc1DYXSFwL
 6M5cmB9EqIgdf4gM5dCl68Qtbnq1a26/SkRjvJ/0Fd/z/9x/c1sPyhzMXhkcE3IkixCp
 Kv0z+FveLeGQVZuFmDNGl0iuG+OkKhs2VjmI3Hd/huYieox2TYNBhKUS9kS50W4kltyK
 d/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710419274; x=1711024074;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xU6vldNdfhEMmVPXKJ6F5qcXFrr2Um3C9M04lDiDrWk=;
 b=QnuHES0aZwrNiO3uWYTdsoNUhGsQ+hbWcA8DhkENuoRglxC5LYzEbibC2gay3/B9bA
 XdbfJrVLw9a5xzxwDNNiLUZE5QcZRK1kU5tIBA68PzjN3HDwWx50sq0SmwEp7+TPwRMl
 T8kuPkzyVmETymKniGIyF8XbdLoMXNI6KQSeW+WP6FqlucRmUV0xF8mx+/5c8plnBB/P
 n4fu80RUTlEppdxRDnSd9SCYofI/fVn9gAG74QqiAaULvBJ954W0q35GNt90mTooVbMU
 H1IoqGav1wDGTPh/MF8ArowLJLKzYBYtvg3M67WKRLNFhREwqfJOpbRMkLGUpPyW0Ftk
 2OvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM1x6jjxdMoIjviMRbtBgfIluDnOoPH2v3NRj2bncJuNT6eoZB3fOzFDW8gln8yMjkgEGFdRULdopUR8MbCTWl7ti7VZQ=
X-Gm-Message-State: AOJu0Yxo5XEHKsNm3E9XQ+xzHNtPDJ2GyHM+Km5ihgK2xPuS++1Ou+jT
 qYG6i9strLW1TW1PPZUNxmLgsVVIgICSv2BGK/3TsT0hkHAn7XTbaZ7n/gHA4s4=
X-Google-Smtp-Source: AGHT+IGdjXLSsBcTydOuzGhEIqXIgYfB39PmTdc7Tr1snp3xVBMv79jSxyiAaXlcItpN/QE8PNtvhA==
X-Received: by 2002:a05:600c:310d:b0:412:bcc1:44cc with SMTP id
 g13-20020a05600c310d00b00412bcc144ccmr1388987wmo.3.1710419274371; 
 Thu, 14 Mar 2024 05:27:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a13-20020adfeecd000000b0033ec94c6277sm646545wrp.115.2024.03.14.05.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 05:27:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7AC575F713;
 Thu, 14 Mar 2024 12:27:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel@nongnu.org,  Radoslaw Biernacki <rad@semihalf.com>,  Leif
 Lindholm <quic_llindhol@quicinc.com>,  Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Wainer dos
 Santos Moschetta
 <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Brad Smith
 <brad@comstyle.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH v2 2/4] tests/avocado: drop virtio-rng from sbsa-ref tests
In-Reply-To: <CAFEAcA8GhAMtvsRE71fybuY90hXBavbXwCrb=-fWGqg8JebTEQ@mail.gmail.com>
 (Peter Maydell's message of "Thu, 14 Mar 2024 12:14:03 +0000")
References: <20240314-sbsa-ref-firmware-update-v2-0-b557c56559cd@linaro.org>
 <20240314-sbsa-ref-firmware-update-v2-2-b557c56559cd@linaro.org>
 <87h6h9gghs.fsf@draig.linaro.org>
 <CAFEAcA8GhAMtvsRE71fybuY90hXBavbXwCrb=-fWGqg8JebTEQ@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.2
Date: Thu, 14 Mar 2024 12:27:53 +0000
Message-ID: <875xxpgfqu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 14 Mar 2024 at 12:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> writes:
>>
>> > sbsa-ref is supposed to emulate real hardware so virtio-rng-pci
>> > does not fit here
>>
>> What is real anyway ;-)
>>
>> VirtIO devices exist in real life and I would argue for PCI the device
>> appears very much like a normal PCI device. I could see the argument for
>> avoiding virtio-mmio devices which are a lot more VM-only in flavour.
>
> But our platform for testing virtio-rng-pci should be the 'virt'
> board (and our avocado test for virt does indeed have that device).
> What exactly are we adding by testing it also in sbsa-ref,
> where the typical user will *not* be using it (if they wanted
> a virtio setup they would be using 'virt')?

I assume just ensuring the board has enough entropy to boot cleanly. If
it doesn't need it then it doesn't matter I guess.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

