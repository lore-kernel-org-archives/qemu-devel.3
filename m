Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52E4C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 02:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmm2G-0008OS-7T; Tue, 19 Mar 2024 22:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1rmm2E-0008OE-C7
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 22:50:34 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1rmm2C-0000Pw-Tt
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 22:50:34 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d46dd8b0b8so82806941fa.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 19:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710903028; x=1711507828; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4DasSimlPOzKfBBzUwG6cinBhfPfrlmp9ZuMad4xts4=;
 b=VJzm1UaqpwzVSbXrVeV9x9WPFPB3c23Qe/UJZscg8CAdGVBY0kziC1lGft6SpehevG
 rk3H9ZVg+kd9K9QfhNRxpigbrjQo0TeG5sFrHmfbDvqoSdlnlpktc2BirLhUIHs/WYUC
 CtZ9PRIKZZoTS4hRn4MXVcz7FCX5b9hVFCVz0YO4zP1KdyrOGAcDpy1wLQozlhnvDMYp
 uhRd/ZPdBCfDNLx2FoCwYVkdxO/jX5wTL+qcunUbsL6/IMfHSfjWrckdHIj7cI/I4I3F
 Gk3LCswIC1qQ/ZqOW5OauIBdnFXHhp/7u6Px1NEaiU4G/3MVXTgXYTwbADeLgZiysSmk
 2uHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710903028; x=1711507828;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4DasSimlPOzKfBBzUwG6cinBhfPfrlmp9ZuMad4xts4=;
 b=TcsRaLH22VEm3QgC9NLS70+hM6ENfxZXHMljBLshKt5TwcKOtM6tXJp2cTqjxgakES
 4LG6dIDsUnoknZHekQJNRut9Wv7jWSMqinMJdsnN/DUL5yTsh16el82tbFLhBSMw644s
 BOJI9hjNk9fQPwbzDDZxs8LFApdKgVQJtp6fO9TyuOPCLw0qDsycoAi5c3w678GryFkw
 xrJOWOnxpJFQmOZThiVHPIX9CrIeatbXjxeVT7CE3DFiJxtPw5ZeZFvMP4SAsoF2RsQI
 +bgHG0TEiiUuvMwqxEZtm73zmUWs/7eNEuaxh3Lh+NcNlMopdyirVZLqkyurmNz44o5v
 tOlg==
X-Gm-Message-State: AOJu0Yx+k1fWGL23xg08hwhuv7EPx5c5+/x5RWc43WBHM1EStBQvJuvd
 yJqehuDM4Rszz0rzazjHLieMC0u5xarBmtFLhQRdJTE19sQ1zX3iDtJWnADiCOtKBw2RDpiA1CO
 o6jeu+nDrVxzEO3xxq0y6r0Jp/o675K9rjRc2
X-Google-Smtp-Source: AGHT+IHFsBFbcZiSTfbldIknRvYcLQOhKhlclPCxGjvJLWH+cLqFaECokW8vLuZZ63fmHnoEBxFkK9LNyyl/O6KksO8=
X-Received: by 2002:a2e:a592:0:b0:2d4:6bad:69cd with SMTP id
 m18-20020a2ea592000000b002d46bad69cdmr12725073ljp.22.1710903028238; Tue, 19
 Mar 2024 19:50:28 -0700 (PDT)
MIME-Version: 1.0
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Wed, 20 Mar 2024 10:53:11 +0800
Message-ID: <CAOYM0N1MZfB7rkEcdwO3r=f-95LmU9jw4BV4hKL6Xh=Lo7=imw@mail.gmail.com>
Subject: How to compile QEMU with glib source code?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003e4fec06140ea782"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000003e4fec06140ea782
Content-Type: text/plain; charset="UTF-8"

How to compile QEMU with glib source code? But not with the glib library
I want to debug QEMU by stepping into glib internally.
Thanks.

--0000000000003e4fec06140ea782
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>How to compile QEMU with glib source code? But not with the glib library</div><div>I want to debug QEMU by stepping into glib internally.</div><div>Thanks.<br></div></div>

--0000000000003e4fec06140ea782--

