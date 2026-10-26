Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5AD606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A/4uXxPA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNmv-0001zR-47; Mon, 26 Oct 2026 12:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLNmo-0001yY-D8
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:43:03 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLNmm-0002cH-NJ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:43:02 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b0a28a720aso30873697b3.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793032979; cv=none;
 d=google.com; s=arc-20260327;
 b=X20DRy8QgM4PMs4M1ga0sFXslw96rqIFlrPYCdNnpL2Ma2ggfnUUOuzljEVnzD2u+d
 NFbWFNkKI34DBXU5/lrG4fbuf3HtDrghfnWV26ivofG0qZxf/sudX6ayKBBX+mdSB63L
 U5T3kMnv3gjatV9atVzTYlaPpWVnM+8EYhoMOGqp4ZcUjb/hATPpclpb+G5Bko4F5X6n
 1E1Ra80QJfrdRSQZmsuUVGQKHe14eoR2j0lvcNkToOxN9vudmSQHnThqpN1++GFqD1Mq
 TGnUK2GnYIanJitcdqOcBicOwY/ECeI1ImmRlq5z87ieeIa7PETbieYKCDtOptovJFCR
 btQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xOBRXzbt6r9ew54Em7+vNkDxd7Ou8xwVH2KbAHvk8ow=;
 fh=WtfYBioCERIpilaIlgQ8CdUwqaZjijWidHTN6miTi2I=;
 b=BD36+rJebkp1V0+drQWNc+DND25oO3MzkdATlPrY1ElkERxdguR0u6d8ErkVkxdkdZ
 wSUevQj2RE/HcABFZOeIpJFtZSs0edd5x9ipPa4MFBPEe7TTGskTCcyuUwbYUTMEhxyO
 EzDE0dCha8raEoM8NxtCVgdwGT2I13OezWfvq/IPPuHO5WqyBVqa+gWQxKOoSDa0IVBp
 bLpw1Fc64VZDLJOnELfCAloCOCekKs0CDYbUlHfhqJX42MPNIPirybVZQUCnmFj3PxCd
 XLiJQVWktqy5mWpDy2agMUSU/xoMD1i9NuPXh3ccvsLS8tecfM97dwt+aosmABX7yf4T
 7PIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793032979; x=1793637779; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xOBRXzbt6r9ew54Em7+vNkDxd7Ou8xwVH2KbAHvk8ow=;
 b=A/4uXxPA8/u5Hw/0Ukdn9vSE+FI5SoofIFKEH6Oqe0BMcrkXX+1Hr3tZfiaIMvI9am
 c9joDx7xBAvD2i8HRPRR2ZV/ie6gQRRpJVPdzJjtySZ+4wegvNkSV/EQ4bTEzQj9dKOP
 3BhnHWFRBohtjyZb13ZBnwxKBsGFXnpxhbcyvHes4mTjF/jou53aO9yfLez1cWwDLG2Y
 zO1LrWVuPuv6gXHTM7hyD+Ua7YF+XmhyB8BXzZf12nUsDqIloIsN7kqS8jL0F1x3VQYM
 Qmwj2mwXEOTmIZykYVaEVH/HZpnQ5oLmWp+saSzo8Vn0QBnLX4dU79hxDNloocNrrpaF
 5Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032979; x=1793637779;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xOBRXzbt6r9ew54Em7+vNkDxd7Ou8xwVH2KbAHvk8ow=;
 b=GkNqMD+T7IaF/TvQO5zqMcekm6n3XVVYXWCReVSjuX0FTi/2mAXdWToAesWpLu1YfT
 U2Rrl+uNmj+YFIme9kwg/hfKfXD5yh7GTeCldoqrBmQBRD1W0+vyjrOMyzdt5Xx4JnZ8
 XpNxVN+qCa8zqOSJuZ/iZfDK482FCd469pVmfEQAdbyd34wqgmnJl8JkblzyXrgmjfrb
 HN/atP+Yb2NuDPBGtLSKd294XUMQ0KRQoizyIISt5gQ8odBbMDqXohcw/jvaGw61Xcqz
 AahJViaqpwyaYiq1qTv9hIVYxR8nm/Jed6TrMqY8ZLoplC67hYHL1S92dSZOVOnBpYTI
 kr9A==
X-Gm-Message-State: AFq9FYLw6EqPsvf+J9Cr0kWCD3fiRCEawHrGIdhF3oAAvdjrAZjQSn0k
 6qq020dXcy9TdhJlzZ8n2dW4azOVeFYCOJdnWF8aRPZSthqr5suiJo97kzbnWt7gAwRI1560o0v
 10Gc/8UWTgzAbRBTeHizkDVcEimhatUr9q+J6P0LofA==
X-Gm-Gg: AYBFou0iH+VYJ11kM0iRIuWbHaJAAemyAVmlHzfdyQDZOz5mAJ30klt64pmNOnHlh+C
 hZfiLiDtfFn0Gfa8slgNDMYLeScVUP35y0KSJRbxz7tQvxRBH1CPU0b9q1dkaNC8+g7pwQHZ1GJ
 IvLbOGJr3AgV2Lttt4sneHnIU/rJguyFrXzKPs6pkBEIdfDPstVqY04YEPNWaCtGKbLXD3bhcp9
 S0fjyj8eOLvTDQE1BDAxFyTCjHxW37dNe4qx6jY3E4+/5XKiRniaahADdHw3lHuF4Hdyffd8ctD
 GDO4CWHIxiLXCMn3862RdcQP6bmY8HTjdqyO03Bo3nQexeEXyQQUvBN36zsTdC6iohrs+nbqEQT
 zpMwW7YpganCYR34x0lcsMaGq7JmD4sJM7nrpeT7/saeqDHN4RHDGJC/Ah+DxeKXMVAc3SdVltQ
 /F6hK9UBDZxpMjP6g+ZVPY
X-Received: by 2002:a05:690c:5804:b0:8b0:9f2c:cfa0 with SMTP id
 00721157ae682-8b166c2e7c3mr38637587b3.44.1793032979179; Mon, 26 Oct 2026
 09:42:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260721131457.3062767-1-farosas@suse.de>
In-Reply-To: <20260721131457.3062767-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2026 16:42:46 +0000
X-Gm-Features: AclHuK-cditHL0tqybCwtOInQHsQAOsuEwOJt9lZrIsYEiN4mBe1ADl1uR8PSDc
Message-ID: <CAFEAcA9GDRQoqEXAt5-Mnm7jTPvpkZ6EPPvxiL7h_mFZOMuW6w@mail.gmail.com>
Subject: Re: [PATCH v2] docs: Add security considerations for migration
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 21 Jul 2026 at 14:15, Fabiano Rosas <farosas@suse.de> wrote:
>
> Add the security considerations that are unique to migration and that
> do not already fall into one of the other categories. Some aspects are
> better framed as security architecture considerations, so extend that
> section to mention TLS and clarify that disk images and guest network
> also need to be isolated from other processes, not just other guests.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/system/security.rst | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index 52bbf0cc7a2..af626a42307 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -133,6 +133,16 @@ an issue as a normal bug.
>    that affect the level 0 QEMU process. While these bugs should be
>    fixed, they will not be triaged as security flaws at this time.
>
> +* **migration/snapshots**. Migration failures and snapshot load
> +  failures are considered part of normal operation as long as the
> +  source virtual machine and savevm file, respectively, are still
> +  functional. Aborting the QEMU process at the migration/snapshot
> +  destination is similarly not considered a security issue. The
> +  migration stream is assumed to be secure as long as the design
> +  principles described in the Architecture section are held, in
> +  which case plain manipulation of the stream is not considered as
> +  an attack vector.

Reading this (which is now in our docs), it seems unclear to me
about whether it intends to say that any and all bugs that can
be triggered only by manipulating the migration stream are outside
the security scope, or only some of them.

It says "plain manipulation of the stream is not considered as
an attack vector", which suggests "everything is out of scope".
But on the other hand it has an explicit list ("migration
failures", "snapshot load failures", "aborting the QEMU process"),
so does it mean by that that other things than those listed
(e.g. "overruns a buffer in the destination") still are security
issues ?

I'd appreciate clarification, as it would make it easier to
triage reported issues out of the confidential state.

thanks
-- PMM

