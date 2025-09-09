Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27F6CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzFr-0004yt-Dn; Tue, 09 Sep 2025 10:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvzFn-0004yD-MJ
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:23:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvzFe-0001Ah-If
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:23:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso37283335e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757427784; x=1758032584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTbTNGBs12hKrgX33g5TtcG2VI2h8zjQ7uuRv7/1cXo=;
 b=Bbu+YhdDpTwqcle5xfinyOWgs+MQWQCYSe7bSncHA05WcWLR82PuaMH3kriid2F+Ie
 S/Z+FhCXKQa1pRVYd5reumYpnKoYw8FsFbK9PU+5qTHMWAyBmQ3+N5IJ4VeeYq93RD7L
 FYuCHERQDT6Qs2QW677Z6nLAGyxqtdOHhr22W7M1mXB+cS4cVfcjP7UPCupmTGD7TRbM
 E00KtNaofrJ1halHFXbZYeWGhBp/qA4u+YAJ/qBqB4ODj1+2iAWRj/zB3z43ANZ/EQif
 Ywl74YYF7ikHZWQ7kLUOMNoMkcHWXwp9a2fQyFrMZgbWvKLepm/GQOQ97vxNYUJivoXJ
 iPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757427784; x=1758032584;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rTbTNGBs12hKrgX33g5TtcG2VI2h8zjQ7uuRv7/1cXo=;
 b=prTh9dYrYPIk+7K7oyaj6HZtPSMhoBCcr3KmD8qdANoV8MtcVN0H2TaZiOrloRx7wY
 BME+y4iL++IvItgpnh/fYG/Czx3BPgSNd9bo5+3PHpDl/pKHmrtLg5dRwY7KsNlU2Kwo
 ZWjKgBZ3EqtbyGBWK4mjvMOR8xIFIzTldPe2PE1yTg1voCp3bT36MQfk51NKr6vgjaP5
 VYlEoXXFkOXXOkWKGak8G2ZsXE1YGBO3FN5ztm92RThrtF/VGv4VVVyKFwtz/BGfJ22j
 W51MSiwlYwiE75IsIHvM1ZmYbAlZ+JTR5cNEVgxHzHjIfQNhxICijsdGCCfaTdYneWRc
 x6Nw==
X-Gm-Message-State: AOJu0Yx7XZ5Ht92EZlgNZqqHwA5/p78xgbSCAzDajcFSHo41U2DwiyZu
 E31XJ5IbyL8mxXnmF0bV0QjvM61DtH5+6QW+Tq1vyjb4HpcqAknw/9CHFJse7E/yH1g=
X-Gm-Gg: ASbGncsDRLxDc0HQy19rAvX+MpYurPasZ8uFCTuV8unHTEtT+AbwzrwwwpL6oIOxRWl
 ygHCXOgCbLI0iVlxKWIHFHVAACiutb8xtGEMcDWh/6fZPcqLYuMmbpFAYveg2L04OCr1hzaWWoF
 3NuJJEydJRexJWx2s5M2IfFGzNt15dgHf53RVaP/T0Yu1JZijXLKAKaG6Qb0AMkeB1m94wIg7gG
 bgomvyUUJFf6HwoZbx38svKb1806+thF88yg2ZgK5Rj1Flil6HzGi2RYSPJF0T50FMR6iaO1oHi
 UekzL/s+mNOb2v68eerF7unNJhDax/TfhkzGMNZN6DfgxEprB4VBOcOwAJNtCrTLkFcSQlyAYC4
 20RnWIQ64I0CsFdpK6ITNiic=
X-Google-Smtp-Source: AGHT+IFEYhqB6jqtrSuvNWEvDRv8kHfitb3oIudVuSwmEKimQuVtjWbocg2zCuCY1qCw8ZW3DQOWOw==
X-Received: by 2002:a05:600c:1c97:b0:45d:e54b:fa0c with SMTP id
 5b1f17b1804b1-45de54bfc44mr97019545e9.17.1757427783743; 
 Tue, 09 Sep 2025 07:23:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45de24ab648sm125066855e9.5.2025.09.09.07.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:23:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F24735F7CC;
 Tue, 09 Sep 2025 15:23:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org,  Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan =?utf-8?Q?L=C3=BCbbe?= <jlu@pengutronix.de>
Subject: Re: [PATCH v3 6/6] docs: Add eMMC device model description
In-Reply-To: <2a8d6226903d8dcf9615b5ac5a40522b6bf2f7c3.1757422256.git.jan.kiszka@siemens.com>
 (Jan Kiszka's message of "Tue, 9 Sep 2025 14:50:56 +0200")
References: <cover.1757422256.git.jan.kiszka@siemens.com>
 <2a8d6226903d8dcf9615b5ac5a40522b6bf2f7c3.1757422256.git.jan.kiszka@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 09 Sep 2025 15:23:01 +0100
Message-ID: <878qin7liy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

With typo fix:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

