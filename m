Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE7606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qp9JM1lV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVoLr-0003Pn-7a; Tue, 24 Nov 2026 06:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xVoLp-0003PX-OS
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:06:17 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xVoLn-0003rL-TX
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:06:17 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso2797092f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 03:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795518370; x=1796123170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y6q37ugMse9ZNQuIZfed2EkKG6d87ZD3Dsy04MHQ8KI=;
 b=qp9JM1lV2vjLzb3RJPzs5Ri80y+FpV6HcF8xGWCuyl77+GKJZ/FGFrNoMG/y9Z+W/t
 TDfWBrLlngefXI6kirqMONXWULs1ukJNXAC6scwKERJMaln7qip1i/BgPNcF7KJonhpd
 AUF63khmN+pfnvaW+VqqnOafmT6GzqRW08udAJuoB3o5dvvzz/7s3L3agk8ks0ptVmpd
 G0cv99GWgL5CeZkhWMlueaeLbPSBUTwpUW5S2tDwM/dv4nBcAmaEKlMcVzpKKSgBR4ah
 YyzAz07u8ZajHHTlMyBjP5pX1nky83FM551szBoy9xviELqB2YkuHXzeMeERQ25Gfbmc
 WIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795518370; x=1796123170;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y6q37ugMse9ZNQuIZfed2EkKG6d87ZD3Dsy04MHQ8KI=;
 b=mBCeAKhaoo7RuG4Bw40yOC+daQcjfOml4VmwfDdwLWIZrKQ9l/zdS48B8V0LvIOmGE
 UR5ndGBdtqx8T8vp9VCqHHewQ/TwqeFBAkeeO756KfnSRJtzxUJjVjbIBwXrQ95I6ztp
 wguFv+u8Hit9bwn/hh3Ub/x7WPtRuVpcJBmokc+cDbbr6Vlp/l+MI+n6+waGX7HhpXZa
 nLyqSXCuXZIyE6EH0YsLH4qjGLXbPn+QfhWZSWDxG1J2fBt9Kh+qD+wav2C3WgdF+NPr
 qn3fB0BLrA25gG9QM57M+jRkRD5jXHB5JUWa4pgxTwNcjIcIaHv3HsNRnfFrwOY+1MyP
 JhQg==
X-Forwarded-Encrypted: i=1;
 AL+hErGXDKfS6WF2OUzRYNmOJxdsHGY+Q2unyG6ASP4OCDqDq5QQaO3PO3lECZmpAgJs3QtBIaXbuoxkI/OT@nongnu.org
X-Gm-Message-State: APuU4Z9TS4ISal7FVkrSIL1R5sXT6BGXUCQD2emdN0hVukH5UZ90FIU5
 SgAD68MSdfyMHJPRTBcb80IAExEtucFhyFZymn980CyhVt06ShG1fZ+GpH5cubQyiZo=
X-Gm-Gg: AZFdTZctxgHTd79W9CiXQF40Vug+gqOtdXsQI74YN06xNaupqKiIsaQKXUGAFjfCqAG
 DOXou/Ypza4+3Ar7BZMkLCgsGtFGN3eptY9At54Sra3qgcl2S9teCC0qdJr4PlT7B11T3Y5F90u
 i+pJzbdxQ6BHlEVHrfra1RNy/SYnQAWvz4ZCgLpaXmRSu5oQyIpFm5E4Mr/UrzqgdolNz2JIVEv
 XeyoYjt7WZ0FHF771XSmv3Jbz1HyCQbR3QncKHd61jiAeRToZtrkE2VAQVL9KFYw9G+FzKH5CZT
 mO/aQl+K7Pk3tZi0nTEFmuaQ6KOn6jlMeBSPpjExXU6IW0JOdBcsj+8VA6YvDTudEIPuJw/WpO+
 e5zrMH1OJhfe6MsK00W+bcHc8UjmtyMqhBt/4Kg497ti3FtUuWzjd9nVu3yQUlBFp2IqEgovmfa
 QNCeC1RDvwndZG6QMh5j/hdzRO8qYwCXWrUGbyvP163Ggyx8Wi87GP2mNru07OvGikubfuOHODW
 NSMxTIt8BPogP+eDI2VJRBcBEtRZQxr82lEcL5e3uBViXsAMjP99cHNps1IT2jYLoC9aKnnglmm
 SZMBDenoC1/sAJaUnXdq+OeOvMmQ
X-Received: by 2002:a05:6000:184a:b0:48d:fd4d:7fbe with SMTP id
 ffacd0b85a97d-4abad6a42f2mr27127003f8f.2.1795518370100; 
 Tue, 24 Nov 2026 03:06:10 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf62f7sm29165984f8f.13.2026.11.24.03.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 03:06:09 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 217085F7E4;
 Tue, 24 Nov 2026 11:06:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Jean-Christophe Dubois
 <jcd@tribudubois.net>
Subject: Re: [PATCH for-11.2] hw/watchdog/wdt_imx2: Fix migration when
 pretimeout-support not enabled
In-Reply-To: <20261116114641.1799526-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 16 Nov 2026 11:46:41 +0000")
References: <20261116114641.1799526-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.5-pre2; emacs 30.1
Date: Tue, 24 Nov 2026 11:06:08 +0000
Message-ID: <87se0qv68v.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Maydell <peter.maydell@linaro.org> writes:

> The wdt_imx2 device has optional support for pretimeouts, which are
> present on most i.MX SoCs but not on i.MX31.  If the QOM property
> 'pretimeout-support' is not set to true then we don't create the
> ptimer associated with that feature.  However, the migration vmstate
> unconditionally lists that ptimer, with the result that trying to
> save the vmstate of an i.MX31-based machine like "kzm" will hit an
> assertion.
>
> Move the migration of 'itimer' into its own subsection which we only
> send when pretimeout support is enabled.
>
> This bug has existed in the code for a long time, but it was hidden
> until commit d9abd0253be ("hw/watchdog/wdt_imx2: Remove redundant
> attributes)" because a bug in the VMSTATE_PTIMER() macro together
> with the fact that the vmstate_imx2_wdt version_id was 0 meant that
> we weren't trying to migrate the device's ptimers at all, and so
> we avoided the assertion (but didn't migrate correctly).
>
> This is a migration compatibility break for this device, but it isn't
> used in any versioned machine types, and we've already decided to
> break compat on it this release cycle.
>
> Fixes: daca13d495a11 ("hw/watchdog: Implement full i.MX watchdog support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4876
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Based-on: 20261106163657.3825938-1-peter.maydell@linaro.org
> ("Fix 'version' arg of VMSTATE_PTIMER")
>  -- the patch in that which sets minimum_version_id to 1 in
>     the wdt_imx2 vmstate would otherwise be a conflict

LGTM

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

