Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3FFD132DF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 15:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7z7p-000444-AV; Mon, 04 Nov 2024 10:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t7z7i-0003yi-Ps; Mon, 04 Nov 2024 10:36:11 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t7z7g-0003lx-IT; Mon, 04 Nov 2024 10:36:09 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-720aa3dbda5so3180955b3a.1; 
 Mon, 04 Nov 2024 07:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730734567; x=1731339367; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=vvHW7G9dopReE0DN2xouuDL6BeM0lJUpiMkPKpZbS90=;
 b=nPo/Ps6svLJSdkuuLlRG8QDkqBHg57eU8x5faHC4zOLIEnivaFja/w7hZN1qHM7Oy5
 1BIj61AUiwhDu5n9Yw9XIemWmJV9IkcEcQ543FNON0iD8FE90/E9p6aUsIiBZVjIhSn6
 soCLi906ABgCcRd0kgTSQWsn/tS/OYDGchZjZDEFxPawxXMVtyrA1ZxOElhTzXekUXsi
 3dHkplcIPvrWex0amo+xtBUVfacRx6I2WBTszzoyMA0rp6sLNuN7kfvpFG3j2y1VdM0l
 DzfU8uHzjmmDoSJtoJ3bKUMIiG55VTuwPHlClspYS6mA5Sa1QNmxmLaZYrQt97v7Ttdd
 lEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730734567; x=1731339367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vvHW7G9dopReE0DN2xouuDL6BeM0lJUpiMkPKpZbS90=;
 b=dUu2UEaVglOMXs7q3AQbiLRGLI1SBH7bLOJ1Eil/GC36MGCIgRp8zKTHNBs5yzAIyF
 W6itW8tdIr4LUHDBR6WoGI/YPblZ2GvHWT9EsQvDdwJGzUeN5NsEGykhp0FtWdWwRUf1
 S1izJNCkuq2Icb5kLb95tJFtah7OYNFo4LD6sfSn/fkIJVHhxgEi5U0DJmLE072ysMAA
 fgtGS1Vv8PfYoxLX2E5lhU8PCjwt9GuXmJZnoNsP/nBC/THecmOABAfUEwDD+ufcPnd1
 C3qfwVCQEO6DGqnk4fdwtsm9f0RVRQxIH4pwn1z+rxkFD7yHk2qN4yJZOhd1+XToVaHC
 gz9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ4rK11bfalzoiI0KOVBc1g1G18MTt+3EEhZZy+ozmrUtEjEFABygcKodCr7D+mSt7L1dMN3AxIg==@nongnu.org
X-Gm-Message-State: AOJu0YyioOD+W6v06WfHJqCakqnSMoffKNyXfd1zbTrn3uUcMycVBJZj
 p99YIhTyzBaW5ZKGCgi7HtEvqGPnBaQb0g2f+XnJMw/+hLN/yajAc57QMw==
X-Google-Smtp-Source: AGHT+IG69y444Yra9U/G9GUsHez9XPPnb20A2q84H7ofUPQOMbSt1p4XvfBrqdnk0EMUP21nvq84ww==
X-Received: by 2002:a05:6a00:a1d:b0:71e:5b4a:66d4 with SMTP id
 d2e1a72fcca58-720ab3bbcb6mr26002363b3a.9.1730734566838; 
 Mon, 04 Nov 2024 07:36:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee452991f0sm7104918a12.13.2024.11.04.07.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 07:36:06 -0800 (PST)
Date: Mon, 4 Nov 2024 07:36:05 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 4/5] hw/net/lan9118_phy: Reuse MII constants
Message-ID: <f8b624f4-6d46-4cca-8a1b-88c36c001d8c@roeck-us.net>
References: <20241102125724.532843-1-shentey@gmail.com>
 <20241102125724.532843-5-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102125724.532843-5-shentey@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Nov 02, 2024 at 01:57:23PM +0100, Bernhard Beschow wrote:
> Prefer named constants over magic values for better readability.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

