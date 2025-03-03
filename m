Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13255C19F32
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 02:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tovUw-00026a-U7; Sun, 02 Mar 2025 21:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tovUu-00026J-BS
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 21:25:36 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tovUs-0005UF-Ny
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 21:25:36 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-abf628d653eso171510466b.0
 for <qemu-devel@nongnu.org>; Sun, 02 Mar 2025 18:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740968730; x=1741573530; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WPRfkRN61+uV7ZLFQc3xJuK5PGzAUt7/nzRT+2/WjIQ=;
 b=Spq13KwDjG6eBmhpbknchkWkwEXFP5DH+HqaCGcuacseT0gi/a7vJDwhoAEjWolM4H
 Ts3z+mDI9WESQI4Xbgsn3sVP46PgpAvpim6+TnSCHOMOOjg2Z4iGhODEBdLAy/QENQCG
 MDOGsnv/TMDUX92ZN73NSWyVV8dHNI/e/G/sPk8IKauFc/NCEtCHXcVkxTfqCB+9pnOQ
 vPrvioieP4zbfYinrKgkoFmKCwrg+FtAicssU7xD+Wa0EGwUfeinxlOy8GhNUgF7jci3
 HFMmWjB7IZmHcHJzbKZJd0UntFV7bv5q6wVELIDG9ndHE/FfwcTNUBcvDLp7X/xyCNXu
 TuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740968730; x=1741573530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WPRfkRN61+uV7ZLFQc3xJuK5PGzAUt7/nzRT+2/WjIQ=;
 b=M/+Yt5CguWyJfkKSvzK5DuJShb/e0p3gFXgtwXiVhOHJNC5ceQsBql7DXb82NmAvAf
 29CMr84Tsvh/O8CMQK40DBWPOEQIWIhDHwaBDIwgK72T6fZjizrFd7E6bdlubYG1jQw1
 RCOp/WGIQuZqp1ktY+MYAq1kpuwp5G+mlBLM7DI6R+vvs8ZeMaFSn3WbrbmzaE4hv1R+
 EgscW/GxG0fLiB1IW9SpIU9pGdF8LTcLvUhnsbUiEQeIkH2QMLx+x+dI+7DkycgjGjGT
 O1a/saQgqY2NQsQ2Ra1FSaFsargACK7zYZNbLSXsQc+8CgX4A51fxnxjtaGe05TZCcKU
 /a3Q==
X-Gm-Message-State: AOJu0Yw66TC5kHAIO2QNUDQVLUGP10Im+EmvTPwhD6Cr/60ojTwN6HMx
 8x4PVi2y3l39Tsuy3J+a5htVD0YcGbSk+tmrHxU9T9JuCngadXvtvb8jjxFbZGmW5PvJXMM+LEv
 p3G6RchZmO81EJt3Jz7YFUmRqKcxLNVHl
X-Gm-Gg: ASbGnctG3S2il78NpVSZs28FimkHjrmCLTIZ/wq9Erw/BJ+rYChkMpVYmCvA0qK3YhX
 JwLE+a5/1yCvDks2SPQ3V3tpp5PhHGbiwHs8fuCJHg+gEJItq5WWvlAfW/yXl5CqKJy+d/wsWUq
 kG4V4zD+o4hCIlTZqe9HHyOMAV3Q==
X-Google-Smtp-Source: AGHT+IFprIC6/th1nAjz0dEb06WxDX9Xlwx7xWhTDrAJpug1a98lPt0u1dEHeOkkyC3aTfMMSEB9BvTQAIYy2F2BLWk=
X-Received: by 2002:a17:907:6d07:b0:ab9:137d:f6e7 with SMTP id
 a640c23a62f3a-abf25da2cd8mr1439935766b.7.1740968729404; Sun, 02 Mar 2025
 18:25:29 -0800 (PST)
MIME-Version: 1.0
References: <20250226102842.3721046-1-armbru@redhat.com>
 <20250226102842.3721046-4-armbru@redhat.com>
In-Reply-To: <20250226102842.3721046-4-armbru@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 3 Mar 2025 10:25:16 +0800
X-Gm-Features: AQ5f1Jr3EBBD18QVwXdjutpBUJ3kCORteAGOmXyWBXQl2nWAaR-5nX_uY7q2b8I
Message-ID: <CAJSP0QWWm7dcUNE0uYfUiNr98jpngDUQ0eGxNn3Vf2iQoC0d_Q@mail.gmail.com>
Subject: Re: [PULL 3/6] python: add qapi static analysis tests
To: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62e.google.com
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

Hi John,
Please take a look at this CI failure:
https://gitlab.com/qemu-project/qemu/-/jobs/9284725716#L150

If you cannot reproduce it locally there is a chance that other pull
requests on the staging branch caused the errors. If that's the case,
please wait for the next update to qemu.git/master and rebase your
patch.

Thanks,
Stefan

