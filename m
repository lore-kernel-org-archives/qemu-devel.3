Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C70C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTLve-0006vA-JU; Fri, 26 Jan 2024 08:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTLvZ-0006un-A8
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:07:25 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTLvX-0000bI-8h
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:07:24 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50f1c524010so374100e87.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 05:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706274441; x=1706879241; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EFmmIYnX5EcJdPs7My/z1SPwf5RyPAs/+fdJolE4HrI=;
 b=X6ighCMkfQGAB5MRb5ZtbDhhOWKe4loyimFAqAOfuH+V0JhVNjTg5X7iN7cCICwp2C
 1NhHoVwOsIJOc8Ue4937LbPRIF1twkB1IK6ACIOyU3zFOmCBDL4VHGpp3cduobvJk6ve
 +BGOxGqcWgzX02u+zsSHLGqv6g4T+fHaZQRcBFJjsNjK1nDaqpoTCItSDPVs9U/p+DFM
 5yU9B6+udl4qD6ZuXKFyKyPf04HVODKi5L0lecwKwmOFv6CCqArzRaYK9qhFYssCGuoo
 64dpXHFprRX7O9lMbUe436/bz4/SwkTOImGVZe9jrbfOfichlvVL0hgXJ9c89dIVv5Ti
 KbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706274441; x=1706879241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EFmmIYnX5EcJdPs7My/z1SPwf5RyPAs/+fdJolE4HrI=;
 b=DfzSNKQzvlTsjJqUKum1pBI+NPcnMxkhCZb5gml7N5EtBELkphtnqNLNxieqBuNrO8
 bygWncmVEc/XKkXDAFeLc9Kzimk+Swlc8wRtK+fEZbCthAeGjpDXY125ArhJzxyH1NAj
 ppr5KB09tvUFfRIidysTE/Lcp28WnReCb+lfbLqFcIo1bnc04eygy6BoggmJjvWWU5Hd
 g0j8pzPLbTJCykcPX1bZeoGmJB56gpYzStY+YdZiMTn214sEdAGFOI/PchWEX5upSEHK
 4zyICmVGH1sAB33zVrnfP4yioT9vr1V/XaKTX34aFm9rWOF1q5foDhAIEYk6ijfmo2f7
 tF5Q==
X-Gm-Message-State: AOJu0YwDS/WVEh05miTsaRAs2LXdgesOLvfs/tkjQaJrp7ftjhqfsyiP
 ZeFmm9Jcwh+jS4LbRlFUanRBwE0bHTq21kem1e41HmsY3fQw4BxAE8aoBOnWRdCbqTuK6M2/vAC
 +R55Nak/vO0Kwq1clq/MV+d5l1ABrZv93y0g1qg==
X-Google-Smtp-Source: AGHT+IEhnMfng9KHxCyKgF44HFTsO5zib0dtj2+NS81RPuZUlM/khi/obA79CBkdayKw63vNBJbpv8xMvLgkrBWxGjU=
X-Received: by 2002:a2e:9684:0:b0:2cf:2111:4e48 with SMTP id
 q4-20020a2e9684000000b002cf21114e48mr514991lji.52.1706274440829; Fri, 26 Jan
 2024 05:07:20 -0800 (PST)
MIME-Version: 1.0
References: <20240108140325.1291-1-n.ostrenkov@gmail.com>
 <CAC8KSA2ansk83=JL2GNLXSgvXUnpHMEf2HtvARYnpViiWTVtRw@mail.gmail.com>
In-Reply-To: <CAC8KSA2ansk83=JL2GNLXSgvXUnpHMEf2HtvARYnpViiWTVtRw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 13:07:09 +0000
Message-ID: <CAFEAcA9Z+usz599L2BHwXjgdHkXEkKRDLO3Ft0ZQccoEK6yWWA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm: add PCIe to Freescale i.MX6
To: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Cc: qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Thu, 25 Jan 2024 at 20:11, Nikita Ostrenkov <n.ostrenkov@gmail.com> wrote:
>
> Ping
> https://patchew.org/QEMU/20240108140325.1291-1-n.ostrenkov@gmail.com/

Sorry for overlooking this; I think it got lost in the post-holiday
mail pile :-)



Applied to target-arm.next, thanks.

-- PMM

