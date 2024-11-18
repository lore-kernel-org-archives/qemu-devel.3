Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A743DD4921C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1WT-0002AU-BU; Mon, 18 Nov 2024 08:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tD1WO-0002A9-FL
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:10:30 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tD1WL-0000ci-RV
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:10:27 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-50d2d300718so738069e0c.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 05:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731935418; x=1732540218; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H7Sitr+3eeGJGfcF9aUyXpNi5h0jkU2kroAcdRC0FNE=;
 b=hO42cGCGMA4yNh/Kzh0oDVhnvpJVrc5FBq1NIHq5dGuJus3YqLeeC4y7CAc9et2ThR
 O3AbeZQBGO4RAfrv3PM07PsqLwcaDthRUodFusT15PEc4ZMKAtWTxGlZn02R3G1+1lWq
 eyDbwLS95zFss+NxwinsCN594HoT91ugbQLScmwO/uFnw7lljF3AA7ge7ONYMbpf+tIM
 PHA2EAXqH20S7mrkY2HqD+z4QSj5804VCtYBuB/ZXGVDOmP2K6SP0rdrfUuWvrv+gy7L
 twv4I6SbHV5FS9FHCT6JMIbhtHvg5D5spx5HZbAKVsx1ikYZYuVK5NFz12gbCHDJbu+h
 tjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731935418; x=1732540218;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H7Sitr+3eeGJGfcF9aUyXpNi5h0jkU2kroAcdRC0FNE=;
 b=UVKW/3g7txVwureXplhO1p1zvBYqtk55W3ieJb+SUwkKNqXF3J/uxRQZIOsDAN8/SL
 Km+XFdOYPKjRIpz+0l9/Tbkml17SGljc0WBizOsYnscoDgkF9mzI8nTEewrFdgMqmHdf
 frrUecVVfyKdAXX9WcbBFUOSdj7zE9HDRfpo40WCn+T3LKJiSWTeD2mM56feuR6Jkznf
 NhEBgDI6Dqd14iFiHnTHJfUkmzLbyEix9SyIeeySB+Sff7mqrrS32Hf97Z+4vkfJspTX
 13Q3sMOwvhOMQcoht9MzyedORTM51RHIPyb0qr9dheNSzpG9mWBacnAmzJDGnp8EIWV+
 7fjg==
X-Gm-Message-State: AOJu0YzflVlPZnIKX2JyBPjOTfRUxn/n72UfkgC/J/sDyPfIc623sYoq
 mZLj9OSPrhjBmBVHtp5ciaSbFwnkT/ajpEe7V7w2wt9v6J1Ho9Y+8NP5qFG4CQUEdjK62PH4pzZ
 nT+kAeLoVH6NFztN5batubjuFkuwQpw==
X-Google-Smtp-Source: AGHT+IEmuj71Y8QN0eP8jUTDYa1KrifrfLD9W9p7zluofOZl2wH3TYj7rtAPjGVkkxksLTtj8CK3GxucQj8kYom9gx4=
X-Received: by 2002:a05:6122:1d92:b0:50c:99da:4f70 with SMTP id
 71dfb90a1353d-51477e7dbb8mr9774676e0c.2.1731935418336; Mon, 18 Nov 2024
 05:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20241109122844.24057-1-dorjoychy111@gmail.com>
In-Reply-To: <20241109122844.24057-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 18 Nov 2024 19:10:24 +0600
Message-ID: <CAFfO_h7QxmXNGv2DM900hUvN7GG+WRTq6774it4VLq6FzmS6Aw@mail.gmail.com>
Subject: Re: [PATCH] docs/nitro-enclave: Fix terminal commands formatting
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, PYZOR_CHECK=1.392,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Ping.

Regards,
Dorjoy

