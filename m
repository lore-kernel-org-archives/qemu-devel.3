Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B58C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 05:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHGyA-0005Ny-4G; Wed, 12 Jun 2024 01:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHGy6-0005Ng-Rp
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 01:56:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHGy5-0006y8-Ae
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 01:56:22 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42172ed3597so3076315e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 22:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718171777; x=1718776577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jYHZaN45vf3CJ7MZUewyItUNwBDHtfuOw1uMdT8KgxM=;
 b=xUeMfYRcCWm95VW7oS/8x3+nG2aJf32aUxYfT4iP6+yVVFovediihPWPi/nTZLPyzv
 +Pcq+ZTz5Onm/Vw7+ajIIICeOL9PAAxL+5aTvFCxBFkCTGcIueCyXOydn+p6StU+dj3C
 9g4vFVJ9hPqNV26WO/IuStX1gzUJ6cLEUou9T95/EdM1yS0v7RmeyFA9yLvC2yHwWkqQ
 ryu6ypD6K2G4Ux4oxCTjF3QIJrm7aiphoe94a+ZfvCFBtGKdILDGAsx7288p3MkMJW63
 yUkioEQOPfu/So7gW+Z/jW5NJ3TUPLLwvB7YmjlYTPLOfIHMU7FeTUJRwSvUknicQGmt
 mecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718171777; x=1718776577;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jYHZaN45vf3CJ7MZUewyItUNwBDHtfuOw1uMdT8KgxM=;
 b=JSTgowIKUdiTZJ2jXXBKxuLmbKpxYK/nIkdJ6KWWKdowWiVxux2FBj46zkFUP9Jbpr
 TOYzhzzNxYkJBq3IU8fTnr+fOJFjNg4HXNLNjPhG8nls0nRAcrqVKjC+T/U71a3FoxzH
 inHJwRpRGjsQKJvLtDx1565Ye9n7XAGL5OJyQn1rUlN1BLTITK2faIIQzFX9hRUUeBOm
 yCPsk1JXW2xeFtnakX9YaS5/vK+AnF7sEOYI6YJYx5IlTbuSDaHkshjaUmOD7UsfrYHb
 j84X/g0GL9ow112s8vgln6o2eb/77Me8SmxtrrY1oxicorPykxqVJUezMwSYaL28FNIw
 hC5w==
X-Gm-Message-State: AOJu0Yz/+5Kf1LOjKZzaSx+rRTZNXFcWw9Ln5BTvv/Y7aWrjtXugMRp8
 kwMQ/IMhpcEAozPCSEos/V8qv8x22WVMk4xe/tVTYvA6VxDWDR6LhK0qrPYVKXd5wzwFy72DjnU
 a+rU=
X-Google-Smtp-Source: AGHT+IHbr/XyemPBB1pCa7ba2td1ShxCvaA9/Sg6GSssvurctrTitA9MiOqKZS+Wl1wBqFvL4/27Fw==
X-Received: by 2002:a05:600c:4f4d:b0:421:8234:9bb4 with SMTP id
 5b1f17b1804b1-422866c0a78mr7292895e9.19.1718171777359; 
 Tue, 11 Jun 2024 22:56:17 -0700 (PDT)
Received: from meli-email.org (adsl-33.37.6.162.tellas.gr. [37.6.162.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422869d4f2esm11876185e9.0.2024.06.11.22.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 22:56:17 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:55:44 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: richard.henderson@linaro.org
Subject: Re: [PATCH] accel/tcg: Fix typo causing tb->page_addr[1] to not be
 recorded
User-Agent: meli 0.8.6
References: <20240611215814.32752-1-anjo@rev.ng>
In-Reply-To: <20240611215814.32752-1-anjo@rev.ng>
Message-ID: <eydtr.swwnp3delkqt@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

On Wed, 12 Jun 2024 00:58, Anton Johansson via <qemu-devel@nongnu.org> wrote:
>For TBs crossing page boundaries, the 2nd page will never be
>recorded/removed, as the index of the 2nd page is computed from the
>address of the 1st page. This is due to a typo, fix it.
>
>Signed-off-by: Anton Johansson <anjo@rev.ng>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

