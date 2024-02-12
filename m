Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAC6C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZRIu-0007jq-4W; Mon, 12 Feb 2024 03:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZRIo-0007j0-EX
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:04:34 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZRIm-0007V3-VR
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:04:34 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so3696606a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 00:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707725071; x=1708329871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bcAI+IMpL6rPpIAJ2qssU93f0W6UQ7rDAhE9iUXw3ko=;
 b=xx46Gs4biftgFu4JIqzLkD8Xcputap3/vlONkTCzPdTyBS1mSgCgQN1+fdpw+hojVn
 zZs7IK997T6l68XVH0gcrZ3mI8Oe5+1oJ88+3wL8yl6/WvDiODmhmvq04nesHlLyt9hM
 /ermGhSED3K14XOmZBcnMZB58P5QmpNdOTlFxYWuq9U6EhnpvetFw6mUCTeatPcNVXQ4
 pPT7sw8yFl1A8T/NgbBflkl4IxefwFZ8v2XNMcqQlgbf155R68FqGplID/y4X+hsurxk
 Z9cAipp4Bk7d0lksBn7jAVi3v2JIoYLyw6Xcgg9lZsKcU1BVHoeekD12S1aoSXQu4mol
 cA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707725071; x=1708329871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bcAI+IMpL6rPpIAJ2qssU93f0W6UQ7rDAhE9iUXw3ko=;
 b=k0RtAW9WN/YfUYnxmEw+gl/3fBiryGFv3hnXTKORnNHZPz3ehD61ppzIOpGoALWW9V
 6g+Gr4m0W7DMTFL5a4BzjDJcHHovmQmJ/t0H3IL166d/4asJqJ+gifH4AXJcH0k2NzI0
 U+7zxpxGDfCPsKbXxSpkljvefOC73EdxEqrutBpm4j921k4ALPtRjaT/3h+yDkOMbCQE
 +RED2P3OcURnoNxH4Ftp/N6pHcwzlR3TurHUl4AbPSQ2+i/N6tqbhyXmvCwPQ55hCUjs
 w+xtX+ChQ6BafHYI9X7dt2JxBugiJGEbjnbrhATdQVXdevFus4+9zBxF9BKy3qdmqfTR
 207A==
X-Gm-Message-State: AOJu0Yyqoh1VIRh1fcs2WgQTpM6+s8P8EEsP6TO7UEjZiVsZwGunu2wQ
 RBvG87arcm9j/9yrFpI6BTkJc62m4x/pBpOIvKp6wCDqOyJU571binSwdIVaYAo=
X-Google-Smtp-Source: AGHT+IGH6WYrUvteI7OlST7hTmEldSIAVxbgf6QH/k0L7nFurdNtax1x/pulQaLzyzYbzGkZWyPtXA==
X-Received: by 2002:aa7:d7c9:0:b0:55f:fd77:7b2d with SMTP id
 e9-20020aa7d7c9000000b0055ffd777b2dmr3787999eds.5.1707725071551; 
 Mon, 12 Feb 2024 00:04:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXw9VGini6i/9+RsE6sK1C2z24OJAS5IdTYb3KPe7Hzt9IjHT+YZygKbHxZiGFCB6uI98Y+E98DByRT1sAXdTrIhO9yqDi/xb7g5Ly9+mLIMZI9beo1a8oZSwvuHbywFZzXCYH1BDMNpxCY6MhWThgCCs0USW3o/Lb2Tb1et2+KaM7AiGljn6JYzpnKDnJRTmatf71Nuu66Ng9nDr4J0YUlkL0u1c/JnpZOnhKI2TGPOgfQzobtzpBNwUig5VROJvEelj8cNT9C0B6y+GEa7JJbkv6YVRczZefZ+R4OYuCMrCUF4i7n3OlBItCLbpvQeiRLHPVT6NzpFDVhNMi3zasaKeA24ZXd5vYXrl5yUUpsyzXnr3u2N2I4ukZCppKMpiR/0tTHunwMuE4CxUpcVF1jN9Gz
Received: from [192.168.69.100] (vau06-h02-176-184-43-97.dsl.sta.abo.bbox.fr.
 [176.184.43.97]) by smtp.gmail.com with ESMTPSA id
 et13-20020a056402378d00b0055d19c9daf2sm2490156edb.15.2024.02.12.00.04.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 00:04:31 -0800 (PST)
Message-ID: <a0eec17e-7331-40ab-8e42-6c0243a20da0@linaro.org>
Date: Mon, 12 Feb 2024 09:04:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw/qdev: Remove opts member
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
 <20240210-reuse-v2-3-24ba2a502692@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240210-reuse-v2-3-24ba2a502692@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 10/2/24 11:24, Akihiko Odaki wrote:
> It is no longer used.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/hw/qdev-core.h |  4 ----
>   hw/core/qdev.c         |  1 -
>   system/qdev-monitor.c  | 12 +++++++-----
>   3 files changed, 7 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


