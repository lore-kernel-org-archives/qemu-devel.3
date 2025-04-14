Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E9AC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 19:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4PU8-00047M-Ef; Mon, 14 Apr 2025 15:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u4PU6-00046u-4i; Mon, 14 Apr 2025 15:28:46 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u4PU3-0004qq-Ou; Mon, 14 Apr 2025 15:28:45 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e66407963fso8726931a12.2; 
 Mon, 14 Apr 2025 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744658921; x=1745263721; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l1zzlrDIDwaTayR2kV3gq/FOGLB5fEU+SLShVH4iQ9U=;
 b=DgQOZFxeE7R2lwVmczMY1iBFJDUYCDa2i5gAan7A+G8gJ7RJqjov16jGKl7ZlywvUO
 F1daAMg9lAQ5XGBcKuytADTrNyGjrq+VN4h7nrQrCTQySapYj7IcaY+APvshGoeApNgb
 /13519rnKLNSwXhGmPO9BD6LBAPHYy3sQzdhro9y/kIDI11UI5MUdBzYt4AWFtPBzTOM
 1n/7uIl3egsixRpTySdW5kZT8k4lJ1fYaENZEOdDw6Xc8O3ssnKjOOuw8AOHIRldoJok
 bUySpgesJwHCi/BxSesOqksjgBKW8glsZwsj5qqchyApNb2ZoXikAQSfgbHga7xjpy8B
 16FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744658921; x=1745263721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l1zzlrDIDwaTayR2kV3gq/FOGLB5fEU+SLShVH4iQ9U=;
 b=Py6/Q+pggu7fimMpLh3sVsuO3SE6hcMO+KOrrjwTHLe0fMwgjbnSPoDoh37gq+Jnpm
 2QDhzKM3navrmBgX1hb8/mCBAqMqb2EfDKekVYO3zbexouRs4ln0uoX18VxUS0Pc4bUg
 pwZSu/QzzPqFkBFA/w4+GPN85vb/DZyQutErBPpDQcN64QFMgyRfrE0Hhfg+qv6iLQ9v
 7xDmBU4cesYHYgE7ki8D7SaH8bv+rKBuO8uoj/FHBh5iN/QXawBOlu6dVRpuwH2/F94F
 0SLRj3kN4v8cYsv8t/D5oKzV30aGAi/YzH6CeOk8sGE51ZoOBsBj8Gyf4ZX282ikRayB
 LP3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeWX+/UeUqGBiXeCERvAbUWKQHfoxZB2ejU1oiTWgJvjYH2Oc8Y63uf5kbFlEgf+4cu6O7N7RNdhf2ldY=@nongnu.org
X-Gm-Message-State: AOJu0Yw+My2E6CFI23/zO/XKcUkMQbxhNkgezhdBVLR3vdQxC0/CnzKg
 Qf6mEkMNoL9M/o+60QDyJW8bUM0cRSnMcGHwqDYw/XBjJHxZEWjZmMiLs/93wQn00X61/98MFLH
 Q/MI4YqaRzgh0hVhlU+fJtxtRgO4dSWgm
X-Gm-Gg: ASbGncupHE5zWATdEk9bf65HdiiE5n09LugGe78rAUzIQ07MPODk+5drtYYYeQEW0ST
 t2waAKi/RuXA8RSJRFFELY5Ci5Yd00ozNXkDgPhz6DGUQ6/pBYVJkP5oinqoe7f8jzfXoyg1hnG
 88jFPP6idVjJSA3DqGFXpl
X-Google-Smtp-Source: AGHT+IHNC9Fk46mn4Qyf5fB47lZR+qViduwuDBK1PHcJThfEAkEG1OrCqbWqsfei8gkp+iCYsd5P+LrxcEwr7D+Ml+4=
X-Received: by 2002:a05:6402:448e:b0:5f3:7f32:3b04 with SMTP id
 4fb4d7f45d1cf-5f37f32430fmr9958444a12.29.1744658921072; Mon, 14 Apr 2025
 12:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250413125937.2448971-1-mjt@tls.msk.ru>
 <e7c37e26-6ec4-45a9-90dc-c5654c2d1948@tls.msk.ru>
In-Reply-To: <e7c37e26-6ec4-45a9-90dc-c5654c2d1948@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 14 Apr 2025 15:28:29 -0400
X-Gm-Features: ATxdqUF_ufb-31qZyy-2EQZ_p6fzLbr5lmOurv4JNA-nLc1vnIEIpgG8VIpV37I
Message-ID: <CAJSP0QV2Q=+RikDpa5N94XjxXd+R+AfH8dOU1ADQPBSeeXk9sw@mail.gmail.com>
Subject: Re: [PULL v2 0/3] Trivial patches for 2025-04-13
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
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

Applied, thanks!

Stefan

