Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F370BC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 12:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYl4w-0002P1-6P; Fri, 17 Jan 2025 07:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tYl4t-0002N8-J7
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:03:55 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tYl4p-0002Hn-En
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:03:55 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43658c452f5so2707005e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 04:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737115428; x=1737720228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5Wn8IdIujOf9r+OIV59CwZZpGZD/iuYJPnVCpa5bUY=;
 b=dA9x13znO2kojao601aXVpjHn8sIv7uacjbEX109YNKDMC+ELJQ9M86N9WpoNRF3qk
 62JF5bmn5wZdq9GJ6IrdeyNWBemiAMr4HXr+fQ9R1bYhWqd+X7OfGmyUsaQqUvo2Mh/H
 Bwu+SuApiDCBDllXuDz4+lgN+fRUppwIhAPHTlCJGpPNPj/TG+nQImnJpwjV2sUwvf7l
 9U7x6bxosdW3Feqyp6sixmemm3y5Ro52LhsmAGWP4Gn4W06oU6kSYfVJqInDghghjBuV
 xWxWw41JztNZ/LuWYXTuqc9dzenkG4Upp5TVAw6AAOEsF5g7nwsjzFE1XOyeL2K9nF0l
 W95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737115428; x=1737720228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5Wn8IdIujOf9r+OIV59CwZZpGZD/iuYJPnVCpa5bUY=;
 b=X9NhuS25f3tbYN5GcFgWnIW8bs8K04ZRyOxOWkL0CMqvWPeIt65wnFxXMo2zSnAvs1
 jQ5WqdHb/timzXSlTZg2dzWX+K7UI4z5PD+KuHlQt4aNWcx7XQeEpKLKnI7LmA7FofZ0
 k/WM3D4ZqojBrcvUzuDCjmdrpXElaRf3rFCkb57U25pNjDmjpKEOZI6rgu+Du6vEqQMk
 Jicch9dVuEtHyxU5yMfOYZzJ+zNdtfGVnLn2ZSSx+gLkZMU8TxC+I+UeA9qAb1Q2QZ9C
 Ep2hE8gVnNeUYEwemExTPrF51p1aXgOkWpClN6mwlvSr5OqcqirGzNY1yUrgCRIczkeV
 7XyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiLgUgMjJBWF43HJsUTE1cyZOkN8Ivfm/ZkwF9GpMwtROhii+Y/Lp2MRrV8VqbaXH89GN7WkB3iTiD@nongnu.org
X-Gm-Message-State: AOJu0YwxWnPNFvIuDN9NmpRxiyPPJz6yqUCG3yeexDyRRS9UuRcF6pvh
 0/jv2392IQ9qma7siiWc5w7oudf9qKAHDpBDZkCYze9V41OfuD1v
X-Gm-Gg: ASbGncum+6/nRtbV1JBWRo2o/3hBo3KKCBg0RrmUW7BlYCY3YITEVRh25NAF6pmPgkK
 YTC52AHxhWLCSB0QeMYP7cj7VlQr1rbVoiVZ+UjRArJ5H1qAF7p/Zhdfv62gCVjdX1d5oz2TDhJ
 pWoNMlEyH74c+u+e2fSPjuY46Q1Gsmb0BL6bF9l6pgQUPd0iyMWKTLkSyhgJx9sC8Xx4utmu+vU
 e4y4gfCFDItAn4e1l2N2dEW0NVTFBVBwVDr7aiLmWA9zT3Q3HV3eD4gskomWXgy77JuiH37ecqa
 lmaX
X-Google-Smtp-Source: AGHT+IFfIARa2+qF5qJ2/NuY+vfOu11uyBNEGC3RsIWf2ftIrQy5yp/zYJr9Xe4I5SWsPPM0PlOAUw==
X-Received: by 2002:a05:600c:510b:b0:436:fb10:d595 with SMTP id
 5b1f17b1804b1-438913bff64mr9508785e9.1.1737115427391; 
 Fri, 17 Jan 2025 04:03:47 -0800 (PST)
Received: from L-H2N0CV05D839062.. ([79.175.87.218])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4389046226asm30938075e9.31.2025.01.17.04.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 04:03:46 -0800 (PST)
From: Aleksandar Rakic <rakicaleksandar1999@gmail.com>
X-Google-Original-From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: rakicaleksandar1999@gmail.com
Cc: aleksandar.rakic@htecgroup.com, alex.bennee@linaro.org, arikalo@gmail.com,
 aurelien@aurel32.net, berrange@redhat.com, cfu@mips.com,
 djordje.todorovic@htecgroup.com, hreitz@redhat.com,
 jiaxun.yang@flygoat.com, kwolf@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, pierrick.bouvier@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/4] target/mips: Enable MSA ASE using a CLI flag
Date: Fri, 17 Jan 2025 13:03:32 +0100
Message-Id: <20250117120332.795952-1-aleksandar.rakic@htecgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211151955.88016-1-aleksandar.rakic@htecgroup.com>
References: <20241211151955.88016-1-aleksandar.rakic@htecgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=rakicaleksandar1999@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

Could you please let us know if you have any comments
on the latest version of this patch?

Kind regards,
Aleksandar Rakic

