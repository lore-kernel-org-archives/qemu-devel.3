Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF62CC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD552-0004Mp-BG; Fri, 31 May 2024 12:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sD550-0004Lv-Gp
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:26:10 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sD54v-0002l3-Nj
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:26:10 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e95a75a90eso24163151fa.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717172764; x=1717777564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hOxI1QVtY0w2dEqJlIdylvR5aFS4PVqW53VJJkmzXok=;
 b=uuJE6JgUo+8SxvR88H2UUUw5KC85OSk1fwMNJyeB6zIbU2EzcuFYo2hM+Sr+v+22rb
 A8ccpyw3gHLs75pXHlDHF/7KKYOuwa06I0XqlSwlCcF2xI6ZIsWHK2WPlpxjNLiGHL0d
 bleuFaquRz2dT9iVjq+wK3MuhggNjH06tzfSKElpPWJSj4+f9/YVZe9Dhu/9jQ6BlvOm
 F/0BlpKDLs7GtmWXsfnrP9CwbPBB1k4h4dkBLOKoRq5YC3JU6UDZR7MKvfot0gM6XL7M
 Wau2Fqd6c+hoCmXLpE4ETrNxu3eGX7yQ2eN7MfAvhe7Lfc3FGLXeIfbxmcqSNU7bzmDX
 XWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717172764; x=1717777564;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOxI1QVtY0w2dEqJlIdylvR5aFS4PVqW53VJJkmzXok=;
 b=BxJtgrNshKrPZJaw/HUAVW2GKeBbZ14TMwt3T/3D5FnOWcsCdusVmUCfnIqIkugkq7
 KU9EGJ/2yVng4BHN032tusA485jbEUANQhd1s7/nesuHsmh64vOfidmymtwjV2fjFwla
 kxac9eSoHv9tr/oSSH8TNsWttTgKp6YY1W/IRcKjbtGc7K54TrJ2hd+4x0Y7IHXitWQd
 ZtION0Ro7tLBh+Myort31qDl0MtSBw56QiARNGEjcYKX3VpuiM3BJRXX4PlERA5MHFhD
 omSqbXU7uYkZhDfRaDzDybzBB/uF8wybgyiIZg58R130A+wIGlmD4BVu1MmfArA3ps9B
 M4Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8axtjUVrsfMtYMrPUkzvsVfQ0vwj/2G0CpOFOCe1N0Jlev2bQv8aAnc6S4LHceJVScdtKLBj2YHUrJGJ44XjciHp4ToY=
X-Gm-Message-State: AOJu0Yz33/sees/+1u74F5YWvoDPbgpdRBHT9A00QAvDTnFpJVUfeaSl
 KJ4yOMBCeanuDujf0fpynTTuzgVDf8M31iMFhZhvivWHkb/0B5X01I801ORwXeQ=
X-Google-Smtp-Source: AGHT+IHKqUIvyx1MF/D/CJAKVCg5tJgUf8/AL5scWetjEJcEs1L4XWZ9Al+wL1ivxtGW7yOIJKhwJw==
X-Received: by 2002:a05:6512:2009:b0:523:bbcd:ed5f with SMTP id
 2adb3069b0e04-52b895a0b0fmr1326209e87.33.1717172763748; 
 Fri, 31 May 2024 09:26:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31c9bc79sm1185071a12.89.2024.05.31.09.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 09:26:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B60295F8A3;
 Fri, 31 May 2024 17:26:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] plugins: Ensure register handles are not NULL
In-Reply-To: <20240229-null-v1-1-e716501d981e@daynix.com> (Akihiko Odaki's
 message of "Thu, 29 Feb 2024 18:28:00 +0900")
References: <20240229-null-v1-1-e716501d981e@daynix.com>
Date: Fri, 31 May 2024 17:26:02 +0100
Message-ID: <87cyp2aqxx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x233.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> Ensure register handles are not NULL so that a plugin can assume NULL is
> invalid as a register handle.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

