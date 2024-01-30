Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF54C48285
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 12:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUnfa-0000TG-6T; Tue, 30 Jan 2024 07:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rUnfX-0000Sy-Ud
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:56:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rUnfW-0006Bs-Ek
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:56:51 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40fafc8bd6dso1927655e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 04:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706619409; x=1707224209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2iSsxPIT3imvSJBzaN9anM8k2bjym4QBLY2oH/L6Vg=;
 b=ahcj3Pvb7Dkkuum0+jX6LFxO8Wn2B3uveowdmohfiKYPWKYMQ/3ufLg3fTIX7BMoKn
 lzFQbylslh0ptULK0chCU/OrrsEZtypn+0jGlyknuxAhx+dHfcCPChbhhLRelPUet1wx
 kBAV4pkHQBjOjuXCOEZ3R8tXSaz5w6qXTgQLzz8uj7TDOmJLb6sdRLLVo7Z6D1AG7uVQ
 D6VzU4f/hXEP4eAWKINS4dl07ZMUdpDtykLykYDiL2Ui2j5dHUizY/sY71EHSOr2qB2J
 8Pijbykm6uJUV5M6P2bg+FVuK8tooJ0TkJcYxlNuwiIFSgW74U3yfD3QxjY8SC4xXvDA
 gCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706619409; x=1707224209;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2iSsxPIT3imvSJBzaN9anM8k2bjym4QBLY2oH/L6Vg=;
 b=bd6NklpfVhqyLx2d1FRBxH8qRwVUv5FiIvPxPz9mbU9cFTDTSUec743zslpcEvg1gG
 9T7mciLVlinNwCx6NI7Fz2I+Pmga2y7GHrwVJ9cjvdmcIlhe4j5v9xyqPBv28EaeETFM
 xNInLHrL2hYfmeJYJfOoLjvLpjTsIFRVfc4zk7gyboBYwoZYMIu+Z5yKZzweA5oPEgY3
 /FrQEz1f/m1t5t7o5xk3i+b7oVoGf6jyWqT0HynQxv9gg4EKdo6iHkIgJ8+QlnJZtpH4
 Ce41eCDLWHmoW1YwVIbxNTlT+fk46ImOEUOE9oqPe/baUATpoI5HaS6jjg8qBWNz4I/5
 EbMQ==
X-Gm-Message-State: AOJu0YyWUVTcKHPdEoEVm/8aM9sKilO+sFXKdabEgWVdPukVgJi9qBiv
 SCypZgrTVcQH0v4FNUrZMKvWjqNxfy847A9sz6roMg0fyIJ3zevj
X-Google-Smtp-Source: AGHT+IE/0uOYm3cXha46IUHms1EvDcJjPTjai6Rqd8AIvkebrrTORgeWkurh45RNqkrtdrrdYkm8sA==
X-Received: by 2002:a05:600c:358b:b0:40f:993e:8f1c with SMTP id
 p11-20020a05600c358b00b0040f993e8f1cmr677694wmq.21.1706619408718; 
 Tue, 30 Jan 2024 04:56:48 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf172400ed0c0d8c68bcda58.dip0.t-ipconnect.de.
 [2003:fa:af17:2400:ed0c:d8c:68bc:da58])
 by smtp.gmail.com with ESMTPSA id
 bk7-20020a0560001d8700b0033addbf2d2csm10242230wrb.9.2024.01.30.04.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 04:56:48 -0800 (PST)
Date: Tue, 30 Jan 2024 12:56:48 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
CC: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] isa: extract FDC37M81X to a separate file
In-Reply-To: <950918b9-29b3-4950-9e04-d66c5bdfbd6c@linaro.org>
References: <20240129133751.1106716-1-pbonzini@redhat.com>
 <20240129133751.1106716-3-pbonzini@redhat.com>
 <AE14AC8A-AA67-4F69-8D45-640C93217935@gmail.com>
 <CABgObfYe8DNifSra_42L06bJ_ACuoTZ_yxNjUUkyuqROypiZNA@mail.gmail.com>
 <950918b9-29b3-4950-9e04-d66c5bdfbd6c@linaro.org>
Message-ID: <B4B8C0EB-EF6E-4FD8-9C50-619393A9BEBF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 30=2E Januar 2024 07:48:50 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>On 29/1/24 21:26, Paolo Bonzini wrote:
>> On Mon, Jan 29, 2024 at 8:49=E2=80=AFPM Bernhard Beschow <shentey@gmail=
=2Ecom> wrote:
>>> Don't we prefer a macro for below code? While touching the code we cou=
ld use it=2E (Sorry I can't recall its name from the top of my head and I d=
on't have access to the code right now)=2E
>>=20
>> Ah yeah, OBJECT_DEFINE_TYPE=2E Not sure it's much of a win because
>> neither finalize or instance_init are required here=2E
>
>Bernhard likely meant type_init() -> DEFINE_TYPES()=2E

Indeed=2E And it doesn't cover the TypeInfo structure which for some reaso=
n I thought it did=2E=2E=2E

Anyway, I pointed this out because the maintainer of the device model gave=
 similar comments in the past=2E So, speaking of maintainers: The MAINTAINE=
RS file might need an update, too=2E

Best regards,
Bernhard

