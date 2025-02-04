Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0EAC02196
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKS2-0006Il-60; Tue, 04 Feb 2025 10:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKQy-0005xo-R6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:01:54 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKQv-0003Jv-So
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:01:51 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so5571487276.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738681308; x=1739286108; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i96K6oJTe9yCko7ETubUnTI4pspHh0HcmsrsCYj/siM=;
 b=ZsAL0QwjWuqB17R1ZHuLUXo4V76lHNn2cRs24pTopeLrlShzz3lUBl3HnX2ixRSrjJ
 z5EHmEDCtAowXIW4cYsyDU+sAgdnBU/CuWPyqyjqH15vLbFyuD4WFSAAX1OmmXRoeX02
 f5EB/W26EAJvuHcvSxpJQuOOFdmKE2nH16kJnTDjIP/XI0sH4I+AZ20ROY6sbLoatIZF
 Z2MlmmzVtxk7x3AohQ8bmFAr7mwADIAY7k9wXi9Ooi+eNWlp4ihXXegT/eO/G+8RBtDL
 tHqFFYx8EsooxPAyIbxS2ctdNGrm9yT4/a1sINP1ZrB0Rir7YXduSi8k+1BgqjM4fJGa
 w9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681308; x=1739286108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i96K6oJTe9yCko7ETubUnTI4pspHh0HcmsrsCYj/siM=;
 b=X7TeQfr8m7Y5GFuJ46dfpfAwnqGEJtPRMTkuVlBaFiVq22Rh8P7Biu1p4fm8JIVacf
 nECgmWZ4uVqAs4MrjGSAoTpgy2bUK1xekumaAi6GCEfzraXGO7RJ3Q28F60w6esoD94Y
 4p2Oe1KKcocppHmabmRlA7wKuw1+9EmBsfPTrsURyrEBZrXsHD1OkpnToyrnlDWhnPkk
 uJ579OMJIQCjtjljZhMf6c4jCvri6TqlXZ6nuCpPNbLvOSuZyRJ9QHzhn4ty+hFY7/m5
 eWd3OsktqrYaAmCT9zGvRneCMVgznVBplj69r4tKSOqs4EO+Qt0MCuTebX30Cd6AyBut
 fYBQ==
X-Gm-Message-State: AOJu0Ywj40KltT9vEVHq0THZRzGvAHzOVKcn17NUB/I4LQAkAvq5I3H/
 /lAEQdoAvJzJ245Sn2RoeXATi1OE4mpDMHk9svYLcoNUw1/MILxp/f787PI2+sqXelfKnKTAvBl
 DeyRLb8fmIqKEaDx7A2BtDQx1E5s+RWGpW8mTlQ==
X-Gm-Gg: ASbGncuOeW4KAKCJ0CYb8dbyX7rhFsZZr3IcP8mUtnqEqeiJZ38AFAhq0ZzFu8S+Mka
 Fg9wohzlQv8XFpiC2TMd4PC5WQCcVsHMKBfIPkjRIpYoHcE2vsxnjX78ax8kwXfwBtx31tbYMQg
 ==
X-Google-Smtp-Source: AGHT+IGqdRFVVlgvBC9VJmskRtI7WIvKmj7y5vYNXJS+YwDjaPEGEDaekuhEAzi17kMbX4ub1OfNDI3cJcnzBm/H7yQ=
X-Received: by 2002:a05:6902:1549:b0:e57:f841:94b5 with SMTP id
 3f1490d57ef6-e58a4a9c45cmr19114402276.9.1738681299015; Tue, 04 Feb 2025
 07:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-2-philmd@linaro.org>
In-Reply-To: <20250204002240.97830-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:01:27 +0000
X-Gm-Features: AWEUYZleavtlFLCYcqPwtasPxF3I4nOwiYTgSufdo5qM95M5JBXV4T0flBNl_U4
Message-ID: <CAFEAcA9kabWXcfWBNBmp2o1MtXX3zZ8cqhKuSm54w6zghypwJg@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] hw/arm/raspi: Access SoC parent object using
 BCM283X_BASE() macro
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <lvivier@redhat.com>, 
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 Jared Mauch <jared+home@puck.nether.net>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 4 Feb 2025 at 00:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> We shouldn't access a QOM parent object directly.
> Use the appropriate type-cast macro.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/raspi.c   | 2 +-
>  hw/arm/raspi4b.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

