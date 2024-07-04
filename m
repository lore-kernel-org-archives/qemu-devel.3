Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F17C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPCte-00052a-S4; Wed, 03 Jul 2024 23:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPCtc-00052H-Fp; Wed, 03 Jul 2024 23:12:32 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPCta-00058W-Qp; Wed, 03 Jul 2024 23:12:32 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7067108f2cdso165648b3a.1; 
 Wed, 03 Jul 2024 20:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720062749; x=1720667549; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vIpk2hTuboav/csV+AvXPd9VbWUOPpLMO6LH+weGUY=;
 b=AgNHVhgyxMHBMTxHbtNi03tngl0BkMIGXREYJcNatXw1vRVswx5BhcHs5tgx8k9Zfj
 60KVSaQF7l0PuvaKm5QOVT8/ClptBn96Ig7MEklIZrybNt3W4fbZ/xE/LqrmJhZ0n6Mv
 kEMItuy8f2V0LILUXEPKrwzOig10LvoWFLcdqNGdHb973ZS4bGetY0cFnnesvHpWPfrD
 zo5bedd6jZ+8SlDW8pHB0R0yZgS897PwcdrhISD+j+/xjK1c597KsX/SbrhiJ5VZHirB
 GE/UAbOcQDxIABxw4/rtey4uMBstKLETxK5ApbobKHJinAwyoRKtEcjCTN5faEJ/JNzL
 kUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720062749; x=1720667549;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0vIpk2hTuboav/csV+AvXPd9VbWUOPpLMO6LH+weGUY=;
 b=XnuXdN3aIVc6dMjTRkQL5Baq3BGIdWy2XLDiE3sdaA5tkx+FSco7zP36F0Z8E/cRsy
 fik+xQA2poa0I2vIL4yTC0S5S5L8IoeihbyW+CgtzuXpzDvePKakS+dPkuNFo8CPB7rF
 OxsgIDzSQYz+OPIEWtV9M9UceF25bnDSV0M9c14bYH7ZS4joqqXJhHETO3H2UUJpghkd
 n4fARX36IpmwXJTwao3oSho4t4g7xrRW+V7N3gBDejvYZVlG8A2LYngq2M8unawqALr7
 3tEf3WSeYHkb+wcQn8wsTxnXt5uskbck5xI0mVGnYiVC1x3VJ/JOfWgJrwtSYxZZDTr0
 7+dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqL8eh/20iL6f3hmj1UFCsDCmcqY8TjFRpt1JCjvJMHJ1pjJX7AtP9UqaAfgfLsVfBpmRAm/rQp9/ttSHPu+1JGB5/URNhfeWd1UzAqUsyPqfGFlQvJtImlLg=
X-Gm-Message-State: AOJu0YwfbzqNUuDqRxrjiPXwAgE3RhMaiDse9OjsN9FgFqL1ISenHzPX
 dZZq0w2azOB65/qbYm8BQxWral7QUEuO/Pc0fYHPHoKN+O3rEnFU
X-Google-Smtp-Source: AGHT+IFBChDeP18JaYtspV3IbogoLdvOrmlHkU1d3RmljlmXg2SJagSablEjptJiZu/gdMspX721zg==
X-Received: by 2002:a05:6a00:2401:b0:705:c273:d19 with SMTP id
 d2e1a72fcca58-70b00946d36mr417167b3a.12.1720062748748; 
 Wed, 03 Jul 2024 20:12:28 -0700 (PDT)
Received: from localhost ([1.146.95.80]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70af8097796sm879452b3a.84.2024.07.03.20.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 20:12:28 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 13:12:09 +1000
Message-Id: <D2GFCLH11HGJ.1IJGANHQ9ZQRL@gmail.com>
To: "Salil Mehta" <salil.mehta@huawei.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <mst@redhat.com>
Cc: <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <shahuang@redhat.com>, <zhao1.liu@intel.com>,
 <linuxarm@huawei.com>
Subject: Re: [PATCH RFC V3 02/29] cpu-common: Add common CPU utility for
 possible vCPUs
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-3-salil.mehta@huawei.com>
In-Reply-To: <20240613233639.202896-3-salil.mehta@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

On Fri Jun 14, 2024 at 9:36 AM AEST, Salil Mehta wrote:

[...]

> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 60b160d0b4..60b4778da9 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h

[...]

> +/**
> + * qemu_get_cpu_archid:
> + * @cpu_index: possible vCPU for which arch-id needs to be retreived
> + *
> + * Fetches the vCPU arch-id from the present possible vCPUs.
> + *
> + * Returns: arch-id of the possible vCPU
> + */
> +uint64_t qemu_get_cpu_archid(int cpu_index);

Not sure if blind... I can't see where this is used.

I'd be interested to see why it needs to be in non-arch code,
presumably it's only relevant to arch specific code. I'm
guessing ACPI needs it, but then could it be put into some
ACPI state or helper?

Thanks,
Nick

