Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0630CAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 10:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxNhF-0000Wk-Ev; Sat, 13 Sep 2025 06:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uxNhA-0000Vn-1r
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 06:41:28 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uxNh8-00075J-4q
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 06:41:27 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3e2fdddd01dso730349f8f.2
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 03:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757760082; x=1758364882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vh+SgW2hatK0SUgymNzrF8SEj3BK7LjCZUWvoGgzqqs=;
 b=Hn59elhJtGJ5rPHx7rvbHVoy8fn+ixFv56II1VnC90t3C73eP8cPXH96vhIlngzmNQ
 B6ZmtSLSNQcnEvpTMAH7nIZJOQCC6AzAP2trLBOgLxfp225zXm5yhh7dtVkR0nSOttWR
 4GOvqfWqJUzrZIvFlaIpB8F3VpP70094BHGbwFf0nw97RnMEH6t7qGsllSGoJ8Bb6ABu
 eTsIda1AbYOIv8YvqgvjQyZuCKtDNHG/l8HAyHw5UTZMPbLyxJfhOoiRxMor3++5FGLw
 J1TtTsM6DDLHl6YKnSopCXeK7zwoNQnZV4Rk2MVGLZkdtTn2hRLArfFuBloqSBVrGt4B
 MMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757760082; x=1758364882;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vh+SgW2hatK0SUgymNzrF8SEj3BK7LjCZUWvoGgzqqs=;
 b=irravbdzDMi3CrViIj2GxzAoIUdO6pKF9LbP7VX75cmZZzJGvBONRtDnaAYviZgYZW
 az9kXhHZF8PDeaW18ZyvIBwRUxc47LTPctIo3d0K5xKQ2ymirNIHH27CLZJS37tAVkm9
 nfp1nBSt74TlQrX9qWmd5+G3ikun4M3TcQxBedyyvVR9lEbWpb5iMB6g2fg3pUQpbHlY
 AdPH6EqJhJqh9E5cuwUBZsKdaTs6b66DImkdpMVNSFQJtU+VjL0PhNQViQyO8vy5Op/h
 NrjADc82V9CvMrrV2UR3MkSZv20xwIFsvRh6h9UiRglT8dzVMIFv8iNOshizPs1eG2I1
 Mc/g==
X-Gm-Message-State: AOJu0Yx977hsKHL2hUhdRv94gORQMAYE0mmfQrPa8WW9VlWRnJ7fHDJc
 AzWrtFma3NDnUTKXl/GXkdD9zCvKjTyCW299wreKazGoiJquoO2gGFvWsBZkt+KARn3jU4ksgMh
 tLkuaiRI=
X-Gm-Gg: ASbGncvf3MNLEEv2DxKq5Xmur8lvtZ3nbTuec/0WeeUhI/N6+SnPn6hIkwFABbkLE8c
 heUKcpfcitFmQSrk8KGIA9ApmnppGGoKEVLsieAZajhIjSRfe8aruh073fr3PKhVXeLHgx5/Uv5
 qmrM6P9YOhjs366G5JlJIEGAe+C7Xoqm3fm5syHOJcRdwCDRvuDAPcnz47CkWKP86K2mxwKWRCQ
 LIb9siWzn5efFwgXOZsCyi7JdQMxnlNiDKW3bjGNvDDzV5Yd+dFcvNnRCDHscNjCUDVkQgj6ihz
 u8TTQ7EUZ9Vg/l5QUPI7SQRxioDyFI6HxtRMK4cT/Ip8Hlnzk/HxNtGOt09I6iWmZpc9Be25TTe
 AQIWfMMDKOTbOUiq23Ic6aypsK/9035hoDw==
X-Google-Smtp-Source: AGHT+IF80KEbThwPIDK3iivFW5hiqHYuMq5JZvcu/0oSRvcbWyq31ppEDRCgmvWje0FIwCZEEYP4Zw==
X-Received: by 2002:a5d:5d89:0:b0:3df:c5e3:55f8 with SMTP id
 ffacd0b85a97d-3e765a12a7fmr6134544f8f.54.1757760081601; 
 Sat, 13 Sep 2025 03:41:21 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607e2d43sm9891223f8f.59.2025.09.13.03.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 03:41:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C5125F7F7;
 Sat, 13 Sep 2025 11:41:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] .gitmodules: move u-boot mirrors to qemu-project-mirrors
In-Reply-To: <20250908141911.2546063-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Mon, 8 Sep 2025 15:19:11 +0100")
References: <20250908141911.2546063-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Sat, 13 Sep 2025 11:41:18 +0100
Message-ID: <87v7lm7hyp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> To continue our GitLab Open Source Program license we need to pass an
> automated license check for all repos under qemu-project. While U-Boot
> is clearly GPLv2 rather than fight with the automated validation
> script just move the mirror across to a separate project.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: qemu-stable@nongnu.org

Gentle ping.

The GitLab OSS SaaS license expires on the 28th and I'd like to get all
the bits passing before then so I have time to address anything else
that might come up.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

