Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD17FC27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfmk-0003On-Lq; Thu, 30 May 2024 09:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfmi-00034c-Eu
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:25:36 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfmg-0000my-SL
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:25:36 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57a033c2ec2so898914a12.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717075532; x=1717680332; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sqYoA3Pj5io/PxPv27YnPfkDCwyRMGELSJA3oVkMxVk=;
 b=KRQ0njgFqBJFvJa+8UdbPyS3E+G4QSZKu7MuPKb4+WQCOKuTc/IvRUOzLuXuQGDKVu
 veFoXaTeBs01CJwXVLN6zcMTJyx5myK3kNcfaARGmAlF4nTXGYR5ZUSkafnrZKhJJhWj
 ULZd2Aia28qqfpyugB3dvtVH0zYIlX85LUOnlms3IJAgtKLmjMSR31EFIp9UNIs03B98
 UTJB9fc1teSynJ7QGCqS1IRW/SczIOIj0/LQ6bhyzlpVQn922RXheUB+qPMukPR3b5G0
 ricQugV5fGgOorCJkf9TMKcS7nlhpc4YC+wj9LJXFTh70u+HmotS3h37/Av2pW8NCJHE
 7xUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717075532; x=1717680332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sqYoA3Pj5io/PxPv27YnPfkDCwyRMGELSJA3oVkMxVk=;
 b=A68rVPWXYBbPbs/gCO+2Rn/K5m7Q6y3XHx/cO5vUnhIoK6UETzOXHyavTZkCoYTOpF
 EB/tLkKGyVu9PH8wWh8jmXVaCLJFl89b576rOvyT3REPNAyN2h8dRgpF5DRGBi53URVe
 icxB6dKx8jEkxv0G8SUsvkVUSbCaz88SUC7LxC1rNHBg4/2ct84BdlCHZAxIpEdEi1Uu
 6NocA3HjxNnfebkUCnhZ9ZSIDM2Gu2Gx/qbVdBvLC4fWv8B/YYzkQxerHOcOdRMVTdzf
 ZkPSU/FtnxWQe0pgaiWHZYRBCQC0Zz07A+YYWnGK/DYu77orteEYvSrDcHkyPwjmKFne
 yyvQ==
X-Gm-Message-State: AOJu0Yw9zD9wa1d9Dr1D4Zaxr6+uhybgEsLUQ3oJe3uD7u06Yhx4/GuZ
 3PMQSlw9Bi8QXDDpzGeq4Q2NygcgoO5Lwx0T12HaKz45ftiqBC5Zud+y/+jdSmqwhbzOQ/5b3FK
 K29ERkRZTOYKBtzvU+PWAHjiz7yvU3JwqAyFpt/MKbZ2pOCAz
X-Google-Smtp-Source: AGHT+IHSKwZmvablwvEdlIYjfJ4XjA6x64YcWoEUgcaSZJHqLoWHXr1IrRmT6OQg81A5xsTPg9dI4z94EO9U2FUiBkg=
X-Received: by 2002:a50:8d55:0:b0:578:5242:a22c with SMTP id
 4fb4d7f45d1cf-57a178e5644mr1319391a12.25.1717075532111; Thu, 30 May 2024
 06:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-13-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 14:25:19 +0100
Message-ID: <CAFEAcA8OsojqaPQy3iryM+rmexXdtW8VFQQ_bKzaOP=9CQCm5w@mail.gmail.com>
Subject: Re: [PATCH RISU v2 12/13] sparc64: Add IMA instructions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sun, 26 May 2024 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

