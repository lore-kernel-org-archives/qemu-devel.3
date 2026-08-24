Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D1AC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyTdf-0006cF-78; Mon, 24 Aug 2026 08:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wyTde-0006bz-L0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:18:54 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wyTdd-0005tj-3Q
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:18:54 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2d6b5aa7535so7635925ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 05:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787573932; x=1788178732; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zwFk7Qs7LW2zpArddxeb2NmtMBSk1hlDqg+eAqih/2w=;
 b=D10MMqq+QkaYbh8VAKHreEG38nmzEQiioh5WtTIkiL2UlAqX2yYmw2hwtY+i2AU8oZ
 M0NQdLQYElayjdGZUOJzKbxuM6PvUs1ZyYa8L5g47h/K1skMVDl+0qvBTxCu+VJt9LHd
 UEfTXznwqOgkB7rnWVsSnD7fsfEbH6QD1DworDOuDOGRi/BSpls2V0hq9+9541VX8ysE
 FPMCR9lI4wODzFON3PNSkv31B+BoOHnluS0+3OCoG9hbtJJ1EUadHwtaYgULtcEtM+Yl
 oHQ1n0kdLezluOdhA5COFXu0yJO5MdMe0MmPFs2rzixZSZOXhJiZu1xdE2TapCuCdRzB
 F+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787573932; x=1788178732;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zwFk7Qs7LW2zpArddxeb2NmtMBSk1hlDqg+eAqih/2w=;
 b=LgXMUlDwd3rFkV/EMlpxLGAvueuoH8yY/VCejcuENMYHy9BEbGBA6fnnvxCk9Qycym
 vEoEb7ZNcwKnLKIvRiwXjK8Y6V8iQJsC44ZmGxDpD6ThorGFlaiL0ukewXO8lVBpXBGb
 M1CBe1hbGX/fDL2U9+sHHZ5zuNXPfZRC8hZJdqurKZHM+zbwGoyofx1XR1f7tEC1QZrP
 Xm0X+AL2eRDg9bfkPIRDPDDMYR2NxPHh/Y8Yhd+9t1UnFbm9KSif7FY/Ti7fkuDXwj00
 QlWlNV4WpHNZTrUrozinqQvimQpPrZcCo3AKLMHWkV4nQ3j5SI3vutfI/L8JYIzzhkHk
 mS3A==
X-Gm-Message-State: AFuF++nVljszrdBm2bFk0w+e4M/NgA09+3/r2aETc4UVFkBUchBEGWf5
 mxT6+wBe97KgYi2o2Rn0WAPOCR15TONde65pYAadnxW9dLcp70hCPuUU
X-Gm-Gg: AR+sD12oiyUHvN7YoLDpzP2LFghUEzePgpdveby4gBVk7XIT8qUPO+S9iJqkD+Rwx5n
 yorErBwJ092xm4ZS2WrUG8FG75T7ImpReUHWMHH5ZpwGry2b05dY3Jz+hSgq4/bLgY/ulyJicpT
 sj3EnFMa8wxRKK89+x8GQ2hxBXjpCeTgzRgIuh/HhaLhCZB8GJm0f7/SfNF3de7XVwywK6VOulU
 KphLfA2FuW/GmO/uSWs87qz6U73x8c8PD0iT9+Z8M/FeL4RYEnHL4WIEiIG4CVRm/LOPM/eX1pD
 FIcX4W9OG7O6KURhI+6/pAbU4rGnHLwEJ0SiUo+wACAXRj8ioYqEE4WbCr0f56ZAbRtWvBtfm5j
 DdXv8dmzMFmZ07fa6DaaZaCTjGATMLtSq4Lrmd6VaGiDXIo+ir7HmzYpcQm48GG3DAN1+WVpOm/
 NJTlzhVba2/8zCsnO6QjN9kuDR68bRl/TcuiGVcOz7Q+C8+ZyaNtvyhzJESTwdnrpN5Zxn
X-Received: by 2002:a17:903:2c04:b0:2c9:e9db:8167 with SMTP id
 d9443c01a7336-2d64ae365bcmr507511125ad.7.1787573931552; 
 Mon, 24 Aug 2026 05:18:51 -0700 (PDT)
Received: from smtpclient.apple ([117.55.237.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d6767b0aeesm16343435ad.36.2026.08.24.05.18.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Aug 2026 05:18:51 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2 3/6] hw/arm/ax3000-soc: Add missing class_size to
 TypeInfo
From: Jack Wang <163wangjack@gmail.com>
In-Reply-To: <20260824030505.1969726-4-kchiu@axiado.com>
Date: Mon, 24 Aug 2026 20:18:36 +0800
Cc: qemu-devel@nongnu.org,
 peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <118138DB-16FF-4F7C-8E75-92976E21A71B@gmail.com>
References: <20260824030505.1969726-4-kchiu@axiado.com>
To: kchiu@axiado.com
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


Hi Kuan-Jui

Sorry again for ambiguity in my previous message.Before I only found =
problem in ax3005.  After applying the series to my local checkout and =
in my local it look like

 .instance_init =3D ax3000_init,
 .class_size =3D sizeof(Ax3000SoCClass),=20
 .class_init =3D ax3000_class_init,
 .class_size =3D sizeof(Ax3000SoCClass),

The missing `class_size` issue for AX3000 appears to have already been =
fixed upstream by the following patch: in =
https://lore.kernel.org/qemu-devel/20260821110101.3971391-16-peter.maydell=
@linaro.org/ in could confirm it

Best regards : )
Jack Wang

> static const TypeInfo axiado_soc_types[] =3D {
>         .parent         =3D TYPE_SYS_BUS_DEVICE,
>         .instance_size  =3D sizeof(Ax3000SoCState),
>         .instance_init  =3D ax3000_init,
> +        .class_size     =3D sizeof(Ax3000SoCClass),
>         .class_init     =3D ax3000_class_init,
>     }
> };

