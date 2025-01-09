Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F71E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwQM-0004vm-U6; Thu, 09 Jan 2025 12:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVwQL-0004v9-Cw
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:34:25 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVwQJ-0003Ow-Ug
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:34:25 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaedd529ba1so174522066b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736444062; x=1737048862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrmknCsxdatabuV8zxlG+lrjUW7Vi4THLFTRJrD1IMM=;
 b=pI9Rswzb6gJU4BPdNW+vpVkq4mfMOoReiLTNJ0bxaSPNvFDJotQivJGPXES7c1XXsc
 kO0Y0Irgzdft96RyP+zVN4X7VHSASZYm184+UbHlSSVkL6NyUE18/LlLRhvNZeD/wzxz
 Egr7t05a68Pl5Zqo2kJqDG2B2ARS8ssl/d66wOagzshi6AmJRGsmLaNfLDayloENRh3D
 pmkJfbjmx8jn/By2WAJ0Mx0qZVJbzNeImKTacvpNO7+Enj+c7zUmIF6B8IDMGPU+n1Hs
 V3tHyW1ocOKCEFIXKodTJuqlHXAn6ZeEn0dGoA/ymsOpkHQD0MsLWH9EPoFbvS+ldJPv
 eR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736444062; x=1737048862;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nrmknCsxdatabuV8zxlG+lrjUW7Vi4THLFTRJrD1IMM=;
 b=CYJi/fIyFuR/79lDwVc+OdL2lwaKja518sKTyRcEoDoU7UF68ke9823F7B7sjJ6F2P
 /H1OqX3xTGV4IRbWfYU+7bquGaXo1mjK+2k5d78JAAy5VKcpdmaeGDpvl51Ed/zD6qvr
 I7EG5fLAkD7mL7kteMYBDGRHmgHy6MM2xoFiIYFUOyHzvvsl1VwhZYdn9s4cCgn9c9h7
 KAdtrjEyhrX0EiwEk64aVs1ycGwDZEFeurmG6Fx8VJE48J7VUHulKY4giPZfw0Ij+0Yt
 DNBCDdj87eeTAx7dNyXY7kF3AwCiYFacHDC69maBhuYAnTSC4S2nDGiVobDxtd13WAX3
 20ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1dtLiytpS3U9gS5MMSK9QywBZKVd1rjoQ9LGZmwc+5G2oB9rAuiC3JRbi2Kyk8E3IAltxadQFFEc0@nongnu.org
X-Gm-Message-State: AOJu0YwgvEFvefa2J3/eX81BMWuGUyl0ePKKCoMZDCVauRzjYWVdlrBB
 2vGa+PnRcD6YySwrRPZcmj0+xqe/KDjsFWUCWZrDv/hyY3EPqy+lCLV7UNmJ7D4=
X-Gm-Gg: ASbGncv0Q5EV7BQM1dN5yxjGzuOTkUL/MY4BWm8lrS6zGdvL7ePLFaAJ8Vs1/tGOwql
 Igijn2kGATHM5yIqXhWaVG26sVuqnImtgwziKj0j3Ltjt6pg3Fd0NSFfgFFQbYFRyK2e03T+rif
 7oW8qVSdrZLN9LIfm8w0jcREzNF8pqNkuBhEA/v81ogyO2lgjeyMk3NJ1Vw/0q0W7cV89WpSKHS
 n+9HzxCxmHEQ3xqt3gAMkhF6WFVwLigT00AX1b1ZRhxI7Bq9W5Fpr4=
X-Google-Smtp-Source: AGHT+IGmeZyrfKuGz2SLVDzfNOd3KvpUkfgHBJjpJTiJ7ZC4DtXb0RY+CduOJ/wmui1nQbSqaPWKjg==
X-Received: by 2002:a05:6402:26cf:b0:5d4:55e:f99e with SMTP id
 4fb4d7f45d1cf-5d972e1d7dfmr17974980a12.18.1736444062135; 
 Thu, 09 Jan 2025 09:34:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9900c4ba2sm773646a12.30.2025.01.09.09.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:34:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 572FE5F75D;
 Thu,  9 Jan 2025 17:34:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nabih Estefan <nabihestefan@google.com>
Cc: peter.maydell@linaro.org,  qemu-arm@nongnu.org,  qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  its@irrelevant.dk,  kbusch@kernel.org,
 eric.auger@redhat.com,  roqueh@google.com
Subject: Re: [PATCH 0/2] ARM SMMUv3 StreamID Implementation
In-Reply-To: <20240221171716.1260192-1-nabihestefan@google.com> (Nabih
 Estefan's message of "Wed, 21 Feb 2024 17:17:14 +0000")
References: <20240221171716.1260192-1-nabihestefan@google.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 17:34:20 +0000
Message-ID: <87h6676gdf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Nabih Estefan <nabihestefan@google.com> writes:

> This patch series modifies the ARM SMMUv3 to be able to work with an
> implementation specific StreamID that does not match exactly the PCIe BDF.
> The way to achieve this is by converting the smmu_get_sid and smmu_iommu_=
mr
> functions to virtual functions that can be overridden by inheritance, mak=
ing
> sure the StreamID is consistently 32 bits and removing the hardcoding of =
the
> SMMU_IDR1.SIDSIZE to 16 bits.

I was just going through my outstanding review queue for '24 and saw
this didn't get merged. Was there a re-spin that I missed? I see Eric
left a comment on 2/2.

>
> Roque Arcudia Hernandez (2):
>   hw/arm/smmuv3: Check StreamIDs against SMMU_IDR1.SIDSIZE value
>   hw/arm/smmu-common: Create virtual function for implementation defined
>     StreamID
>
>  hw/arm/smmu-common.c         | 12 ++++++++++++
>  hw/arm/smmuv3.c              |  4 +++-
>  include/hw/arm/smmu-common.h | 16 +++++++++++-----
>  3 files changed, 26 insertions(+), 6 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

