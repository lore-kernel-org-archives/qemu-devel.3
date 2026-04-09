Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960E5F364A6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAtYr-00083W-UL; Thu, 09 Apr 2026 13:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wAtYr-00081r-3G
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:53:01 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wAtYp-0005jK-Mj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:53:00 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-12c287eb77fso56874c88.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775757178; x=1776361978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7goyZ9sb61nd5DhdbjSqdoaLm4SdTVWUyhQNAskMZj8=;
 b=sabIIv9emrYvdpQqq59W/TbDNc1o6gm+CNdjGMsaCnenzShEAQMHfxFenXQ4tORwZ1
 FhG5Hlv1gdezY/C31J9g5wTQ1fFSgfQ6WLgYh13RTlzcrZXrCdxAZzVrF7HKPDc8S+xp
 Mw+8AcjapMtWGc7Udk57d8TIJrn43T8VoDdH18ZtfxfHz2GMoupcswBpTsUOOM3MRlD6
 xS+C54oWpcDdzGDAdSjf23syFKIp9zsQeak36JdBP6pc0qfjwxrRNN2j1GS1VBFg4TDy
 SJzibmTITMk7fn1Kl7tOymfY8C8fNEse9YlFA6AaKsRW8b+m5SQ2kcVkm/BoRwLGdHfD
 m0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775757178; x=1776361978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7goyZ9sb61nd5DhdbjSqdoaLm4SdTVWUyhQNAskMZj8=;
 b=rkB29CwO6NXCoTjRpTQf/XjasTqjyNxOYPk3rnOSesLZVU8XrnWL6oJnHnaNYCd3jq
 VP6UnLJJuOLdhQVfXVqXCaUDGuxIc4NgPiFeGf72CccQWfugBhofMuvC32kItwN9VFz3
 bAzYNFByN+yAJIx28yNF8ekxTfEXpR8mM6spNj+liePVBy0MtE3p/iCmG0aozw7XdDFL
 Nt7tW+RjsEtvv1fHK71T+kOGdvaBgj2ftMFJvSW58eUv44AhbkyWrb31zGjjMK5hgOwb
 84S7bt4o3n0kuF/TO5/By6iBjqYgXYSTMyZ3yZEyr4Sy/KlRB13RDXJ9KbLlUJ38P//C
 YqtQ==
X-Gm-Message-State: AOJu0Yws413NBBubacbCSdj3IVkEG+9maBlDXVNOyT2Mu/CzQDfTtmhP
 XlZQDJRx8BQGzYYVhJOgOc9tbPYgMWNaOeUzPH/UKSrE898z8j6xndepQqQSSs+b
X-Gm-Gg: AeBDieunFoxKbnMNJuxQWwLqOWDWrnt10PlPm3dCNHrcYs+LQDN4X0+n33KdY/rPNQa
 D7JiS1ZboLJwkpQsBaGIsNFehhxo4vcX9uutlTAwNC3NbVz9dmpKgwceE0Jd5JIK0YSegFPJnx5
 bEOW83Y9Osef/J+QjqncoJ5KSiTQghyUzj4PpUxc58Ksxq7EQfAfHKNQduj19uGa5UOlZnyAjkx
 82jYygkpI6pDShGWwLb7tP+jU1fGZA8kK7ZZzQKKjuq470ZPrxEO+2zRX8HuHkRFP8uMZ3zi3bz
 SDHMyJZB/bAKyiEiIFve/WXT2AGXtDSh3jI/sRo0PxSomr9rTQp/j/cX3SEer7wzIfaSuWXLBGI
 KqEK5pNaPzE8Qd+RN7tGEzqfm56es6FI9bdWBRgaJY14lQwEncH28cB+acvM6LJ7/+U58VzHr9r
 EYvNhnkroXYNmy3Z0dCsN1gP5sDb+JLDQg8buaA+zXbNZlu9l0iSIWpA==
X-Received: by 2002:a05:7301:6446:b0:2c5:3b87:2ff0 with SMTP id
 5a478bee46e88-2d586992153mr41599eec.12.1775757177586; 
 Thu, 09 Apr 2026 10:52:57 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.183])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69b3sm637578eec.1.2026.04.09.10.52.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 10:52:57 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: Lucas Amaral <lucaaamaral@gmail.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH v5 0/4] virtio-gpu: enable Venus/Vulkan without OpenGL
 display
Date: Thu,  9 Apr 2026 14:52:52 -0300
Message-ID: <20260409175252.40828-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317182049.33848-1-lucaaamaral@gmail.com>
References: <20260317182049.33848-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x122c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Ping.

https://patchew.org/QEMU/20260317182049.33848-1-lucaaamaral@gmail.com/

Marc-André gave Reviewed-by on patch 1/4 in v2. Patches 2-4 awaiting
review. Series still applies cleanly on current master.

Thanks,
Lucas

