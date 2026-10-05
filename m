Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DACFCA5FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkIe-0000Vy-On; Mon, 05 Oct 2026 11:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDkIZ-0000VI-EG
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:08:17 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDkIV-00064a-C8
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:08:14 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8ac8a2ac52bso12496637b3.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 08:08:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791212887; cv=none;
 d=google.com; s=arc-20260327;
 b=KFOEPlP9/g6+qbSTXz835WYFo14cPlxFWrpYsp9Q234/T3wnzhrsLSDe9uvJ0ZkRvv
 w97tOBbCgkEG6xO6H+XB4dNV3jJFDx40vHFr/vHqlcl34VNXExPp4yUMVfF4ktZwO12M
 Y/aNnTEKsRzy4hOo2c4WJGdj25AEAx+MdhMwwYnFNy7Gz/hKu3RMJMObwA22lh3CaDZs
 1RfIFH57vhvyjkN67JTzI++/63kC/rtoh5i8VfWn68imKbs+sLUVCAmuLX7TGkm0TPwq
 gS3xZlrgh8+eUjY8HbkLZ4iup5eKgqfgqr11w/5yZuqkh4ljf8Q4FmGpbIA7r2Y4PQH6
 Aqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oq5JYA1bgT50M9QhvD044UfS8+Gb/z4f3LAqwgF2ZEQ=;
 fh=EjplmlcXR8MWJXDdpR5ncThIs/e4S293bvxZuvqDLMM=;
 b=CgDHUUIiYj8CNgvutoMuMBF4R1TGBiEYS9jed2KP3qPzuPxn/6jT9ZOBxH2WwQ70zt
 wyvg2lOftMtTepSci649X2KWv/oPqAO3rDR08b54D8f+NJoN1C+l68N5CFWP3zS4usO5
 jc3reJORzg8i8ECXrgBqTFuY3ICVyoi6Ik3w/OCOJqAFEPPXP2y6yKvxSetln0Ujnsh0
 bgjAOXAJyqk2lOG+jMalvRzSrX01QoVtzgUqA4exHVTg2EsdATGbLXBpKaVc85XXkne0
 OdPf/A3qxZ6KUNzCKp4cTXiaVSroMEu7xm1fbCtCynmyU7e/UnWde1uLDCJk2/Kbla3p
 zGbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791212887; x=1791817687; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oq5JYA1bgT50M9QhvD044UfS8+Gb/z4f3LAqwgF2ZEQ=;
 b=B5Dm5/5E2WuUyyGSP0c9C+2LwnqjC9xNcn+7+Nff+6FdSYRRferIAWZkX0w1r6Ap3o
 f5Q4IrHgV6e3ZsaYfKiHvx/Umc+SQTBMSQcZyGcDW5zF2nRI3QIggi/3qNQXnIuBFHAC
 M/Y4wqouUtklEPvDbnmiW8Ck657qKGwMvnuoerBRO5meEZTtvHozcpC8arluGMxd4CKZ
 SadBCSxWMxtTwszC4ZUmHU/kTzRKBiTuCpcE9Ap6cDBsf5EKvL+JsSednZYWSJKIfqqh
 m6LVS7Q684zd8cxoGpTOtedF7/u5aBUh9e2qLy+bhCZAh0iK8+J5xSotoGifMiVsJzDS
 89FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791212887; x=1791817687;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oq5JYA1bgT50M9QhvD044UfS8+Gb/z4f3LAqwgF2ZEQ=;
 b=UMkFcu8DA0DaCH129p/oCKmMAxuEElyPNqtW9D4qoVeF2r8HC8AgdxnAUO7lG8ia58
 yPUVu0wbaRAgbhbYEdGbQKxeLVyBpybHFKpkIG6+LWvcaYPj6Z/F9kp06GNLBg0v9gCl
 ikC8IKrSnMcuA60oCVIzAqlxbckC/ZoLiLS9cSEoCcSIR7ItyXm9drF08ovG2QCo08EL
 pqqjhPmccSk4xIYSGS3gsNil10C/9nuxutnUEgPh6XNfhvmT4YTMnkEHExFmRgXJIZc+
 cQUN1Jwv9dRa43OlD/0hIUwv5xNHOZdK/cZ3zqDikm/Xr7/S8SjdYL3qVRamlofQy2Dk
 azLw==
X-Gm-Message-State: AFq9FYIaRfnXaDlyBKWTCD0gmMDprGq0jNs/uqKDC9nMjbyNtDTX7cM3
 GHDzYc4udkVri+0LcS9dazej6aMEzkdle1kXTWEL5C/eBYo9E6JqZhWFTipiDouQOguEwr66iYA
 sFfT1vDbeqdoBpDxNnbJHVEZ69zMeQys=
X-Gm-Gg: AYBFou3nxCi2rEduXnNUjzP8rb1s/wpkPiDLHBF/TUKnOh8VkoJGMvoBnbrsxBE4r33
 FqYtODt1b2kIbwhZf6ZOz4xnMzE+VJRzrtxNCCmj8kjRjo7EHOSSM1vgH+TIWTamsHYpgRfPG9C
 mSmPTTezpBSz/iY/SBL3yjafLLcjkSQ4fGyig4acIC3RGx36YEjrXYWRi9inWa5y85T4Sgd9Zm7
 hEnx9B4d9xV+6hvwefRIqGS1pVCkO1DukP8NTNUKbT4Zs0wRem50JaND0GsCieT19MDps3VtK5D
 5kgNBYp75oXGoKX9ZcIobI1n2oSNRi7qJYb3QA37NB8fqVjTuRyMDuQxE0aHotzpjPQ572XgWZB
 T0n+v9qSg/zYgNLs=
X-Received: by 2002:a05:690c:c510:b0:88b:6ad8:48cc with SMTP id
 00721157ae682-8acdae9b61dmr63940687b3.16.1791212886786; Mon, 05 Oct 2026
 08:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20261005101800.10821-1-shentey@gmail.com>
 <20261005101800.10821-14-shentey@gmail.com>
In-Reply-To: <20261005101800.10821-14-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 23:07:54 +0800
X-Gm-Features: AclHuK-qMuFjt5suOK997ZTubhMbQVt--84kuqd3YFOJAEMoXX0o4Ih5TpU9JXs
Message-ID: <CAEUhbmVmuYTAHMWwGeTX3he_1_AvzTV63CwLwG+pPgYgvUk3aA@mail.gmail.com>
Subject: Re: [PATCH v3 13/31] hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 5, 2026 at 6:23=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
> machine reset.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/arm/fsl-imx31.h | 5 ++---
>  hw/arm/fsl-imx31.c         | 7 +------
>  hw/arm/kzm.c               | 2 +-
>  3 files changed, 4 insertions(+), 10 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

