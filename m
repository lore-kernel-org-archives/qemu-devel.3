Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73012C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 19:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txW4b-0003dX-AN; Wed, 26 Mar 2025 15:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1txW4Z-0003d8-Ei; Wed, 26 Mar 2025 15:05:55 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1txW4X-0008Nz-FL; Wed, 26 Mar 2025 15:05:55 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so25325966b.3; 
 Wed, 26 Mar 2025 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743015951; x=1743620751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSYXuYTaj5NQzsZFwP1eacN4Xq2f6sFTt9pNhUH9Rbc=;
 b=ipkDuaD3u67ywU5Uq5A8HWD8v66TsA7Kbol3pKUYGc/Vn5T74+rwM13FuAwivvColw
 IZITW90Z//QAlASGm9xnEAWm5fhoiz6PWHkLX/x7i8qFVCoB9vOjQw33um7Kj8+0gZ1o
 SaKXbexysLLeAiHmDgqbFUiL3BGc27IOu+KJMI8JpebF1550++rzrSw7QcsKEFLuOvWh
 L/1e9q5+aDc54LORByE3XL8/0JOJMXqRAZKggG2PR9/0CEsoTebv7Wg/AHRyDD1gcsx/
 Kw9cCSPJpiemeJsuhOeKb/YhDo4F2p5XQ+JtE3SQEvZ4SWVEFV/Oa7lVXLMeDVT4QJld
 Cbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743015951; x=1743620751;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JSYXuYTaj5NQzsZFwP1eacN4Xq2f6sFTt9pNhUH9Rbc=;
 b=ETTw4EOHmFFOJ8EoL6RCxQoIPiEoBji+HPZ+3+/7sitxYbCF5N2C3d26lvlSkP3eX3
 ScukuUdhqaKqZMzGgYv8JEOjtkaiL5ByPWEzJZXmofB+b2yAnAkv8t0Es3ORybIdr9WT
 DcKVFPx69mwvQyTcUs2w9jDVmKqGmyq6ix3waluKERu4uAPHpi+ajgeBamfLQisP3yOd
 Tuq/bOqeBAqb8eBzYcergKRBbklHDzx9gMkJ7fjuggw1ZQVTElI3ysl7EHGmWq0cu5jE
 zkefapKCYK3yb5mbdPzxWoK7emM68lVmOzy3synqNLlcNA12LvojQfD4yMe+XD0saqAC
 746w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVABOCpH6xyfCUbpf6p5m++RHOI+5HsBKs5Yx/o8eQi42aw3tVs+KqV2/kQ14+WpdLALR7VLfLqlA==@nongnu.org
X-Gm-Message-State: AOJu0Yxkw3oSd3pRqHZVJIdYKhTVVqE6YP/tRMT2OcAUncRthbVc4PKG
 vB3aKBiCAbspQ4BVlJMTzAnmII4Mm+T+pdqpGXRs9pDNt/KvQbdt
X-Gm-Gg: ASbGncs513r62ADxHBkatt/Q7F1CaSquU9G2SHPySwb8rBj84XwWresletYowJAaiqM
 exwN7xXK2iNyUZfmINnes59PvDFdfSMju3kIlmC+O6qh33aFnbX/kb1GHGDsesom1ixBUqT5f7p
 l8JbKgn/mTrx8Qe1+OBH14nS+LbhPBTkcgXuazi7E9m6aNsn+onWVbUDRfIK7GpEB1NSB3bkvMS
 N9SJTNzlxgficlKi0x35naSGxiN3/qYZKMdPRtJ9+OelaLXpKPWW/5wZapQinRaIXdQBzyPKGP5
 cYmSWNFaXgzx2N+Fy7+SGFMtR5RIgc0AU4MaNSHpo6SCFlb4gUvvmfD3pM0KcIFVv0W3ZPuq/Cy
 1sUDdKyLrZOMcun4HZJLyLvcvDRPQEDnM/4Gw8qN2u8okcZwK4XpC
X-Google-Smtp-Source: AGHT+IEOIWKHF/Pvl3q24FUlLVbInsA/hiPIaYSskv5nDwyxY0u4J41rJtXq5ywNVUCdrrpSm42i1w==
X-Received: by 2002:a17:907:3da1:b0:ac2:6bb5:413c with SMTP id
 a640c23a62f3a-ac6faf45fbcmr57071266b.31.1743015950961; 
 Wed, 26 Mar 2025 12:05:50 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2d98-2f00-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:2d98:2f00:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3ef86e529sm1080977366b.21.2025.03.26.12.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 12:05:50 -0700 (PDT)
Date: Wed, 26 Mar 2025 17:54:34 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/3=5D_hw/arm/imx8mp-ev?=
 =?US-ASCII?Q?k=3A_Fix_reference_count_of_SoC_object?=
In-Reply-To: <CAFEAcA8VRjD9bP+GOkCoVkFveTnuVbtfmk25rUHvQSec_ypjjw@mail.gmail.com>
References: <20250318205709.28862-1-shentey@gmail.com>
 <20250318205709.28862-2-shentey@gmail.com>
 <CAFEAcA8VRjD9bP+GOkCoVkFveTnuVbtfmk25rUHvQSec_ypjjw@mail.gmail.com>
Message-ID: <1B01DA49-6131-4C02-9A6E-AA0B2D8D49D4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
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



Am 19=2E M=C3=A4rz 2025 18:06:14 UTC schrieb Peter Maydell <peter=2Emaydel=
l@linaro=2Eorg>:
>On Tue, 18 Mar 2025 at 20:57, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>> TYPE_FSL_IMX8MP is created using object_new(), so must be realized with
>> qdev_realize_and_unref() to keep the reference counting intact=2E
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>
>Reviewed-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>

Ping for the series

>
>thanks
>-- PMM

