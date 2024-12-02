Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE971D7832F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 15:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI8Sv-0006yz-UM; Mon, 02 Dec 2024 10:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI8Ss-0006yZ-LI
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:35:58 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI8Sr-0001LP-53
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:35:58 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so52871366b.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 07:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733153755; x=1733758555; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqpnZWzzQdOU7DiriRbHVIXJ2GTUEvQTElO9eIv7UpE=;
 b=L8CcFJZliG9who3YuRZcs2yYTozVFUBeTZ0W/jqBldZue+XianfUltomZtV7X/0lpW
 VVaHC2wQhPgkLjXSn3d0r+ZTPGuqJpcVzmvFHyP+7STCxyOARY/AGUqOBWZZW4k4oVDh
 loWPrayV1R7Gn5LsH+IbdBh31By09JhiDAgYifNedwlAAQBPXMBGo67rt8vCn1s1EiD2
 ThnCJRSulW9dfzCVB1ouFwb5MGsggNS1QbHUJA4+1ANT+xAT/GamEjXnFuYaDoFituyn
 95arXfNV0j5RZ7WErwJHkCPiVInI45gXQHauY+3VbJ9OUy+eDN7cp5FmfYkXsn998nlT
 kGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733153755; x=1733758555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqpnZWzzQdOU7DiriRbHVIXJ2GTUEvQTElO9eIv7UpE=;
 b=i3C5eSJ+L2Ueu/Oze3o7ac0R17u5XkPfrUarqNnrYIBAvgo7kRlGUZl3WH5Ro/cMyZ
 FtggcdPpQCsklRpM3iyyyde9+cl9YlyRx3Ik73QN7XayxmRP2CiEfrS2RFZAiL9eRoWJ
 6j2h0H5cdcVadY5gOeU7jDLZJg/AW9Re1lNGxxlr+eelXkst7cDEPisDnro2paAlWK46
 /zQBW/gPMAPB21u8T3nDDY2Yg6ej6eP5eRh8TVjhzL0t80w2rmYbWgyahXp0qWMXv0qu
 DmQC3sq7c8/t027P+yJR2LJnUYkXg+zdxygERyNRMveqiGtDrvT2YTM73EUb39Cu48Oq
 7mAA==
X-Gm-Message-State: AOJu0YyVgQka+pMapxiC0Uo0GuwuGm1xGrQIarJTtRESTJhNeKwhxUDT
 yA120nc/OhBxDLvf5JYMUJz4YO4KVvK36kLJkwSGxGJuuzlnxAlGNsgs25GRxneB4MleTqgEVpb
 +9/eEAo0pCFnnWrME2S5aQ0tufOksSkqAPkG2zA==
X-Gm-Gg: ASbGncv6ji3kCer0pt520pkyrCp9cZ7FGAeRbZdaxthixvA4FUWNm2F80vqPX1U7/+I
 FzPdNIOXslTVtGoorb47t7wqvnINqRLpY
X-Google-Smtp-Source: AGHT+IE9h0I3km+IQsqdVFQodQ8YLXc4W1KUVR8PGE4tuHLnZohpE0+b+I1/DvueFfI8zrAKVx3DXOZt3iwarmhvybw=
X-Received: by 2002:a17:906:2181:b0:aa5:1df4:f57d with SMTP id
 a640c23a62f3a-aa580ee0131mr2241648866b.2.1733153754789; Mon, 02 Dec 2024
 07:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20241117225643.768322-1-ioan-cristian.cirstea@tutanota.com>
 <20241117225643.768322-5-ioan-cristian.cirstea@tutanota.com>
In-Reply-To: <20241117225643.768322-5-ioan-cristian.cirstea@tutanota.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 15:35:44 +0000
Message-ID: <CAFEAcA-yCHwzg7n9cSUicS+PKqrJS2_ibmomw=U-8rixDU0OsA@mail.gmail.com>
Subject: Re: [PATCH 5/7] [BCM2835 AUX 5/7] Suffix constants
To: =?UTF-8?Q?Ioan=2DCristian_C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?UTF-8?Q?Ioan=2DCristian_C=C3=8ERSTEA?= <ioan-cristian.cirstea@tutanota.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

On Sun, 17 Nov 2024 at 23:02, Ioan-Cristian C=C3=8ERSTEA
<jean.christian.cirstea@gmail.com> wrote:
>
> The constants defined through the preprocessor must be unsigned. Also,
> unsigned integer constants are consistent across different bases (see
> section 6.4.4.1 of the C99 standard draft).
>
> Signed-off-by: Ioan-Cristian C=C3=8ERSTEA <ioan-cristian.cirstea@tutanota=
.com>
> ---
>  hw/char/bcm2835_aux.c | 52 +++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

I don't understand what this is trying to fix;
can you explain in more detail, please?

Some of these constants are ones you've added in earlier
patches in this series. If they need the U suffix for
correct behaviour then you should add them with the
U suffix initially, not add without and then change here.

thanks
-- PMM

