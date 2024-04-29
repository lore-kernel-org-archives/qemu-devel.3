Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B0FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Wsd-0001sN-Bu; Mon, 29 Apr 2024 15:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1s1Wsb-0001qy-OO
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:41:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1s1WsZ-0001m3-BQ
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:41:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55ffso18934765e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714419693; x=1715024493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=EK+QgAf1Uu9FXCwwglqmF/U/fA030dNFq7Jdo/CG10k=;
 b=AS4buKmtlSdsYQUSG1sKGiyLMGhUs9t9x5KNCelusrdkdWKvGEEuTQSSPpKGMPQF/O
 SjnJaiZ7cPvO5dNC75FW9il5bIyyJWaOgKI3AK0X9SDFWKQylVvxOLa8g88Hq5bx+t1+
 89KF+v4UD7ibFoacv9fk46XC2aD9sdF7J/AtgqF6Da7hoBe0gWO/x0BdnesOB3EzImsf
 EddnaWx8Ch7wWu8ybCCKE1KvlykrhVdHS4FpKKnK+w2PJ/bj5mu2i6nyP5jyX7cbHd32
 JfMnvJFvsn5cxutttGbyS40tFLNaYnrE7kqVKcQaV6Ts1llcnZHLchWIXHLUAS8qy+9d
 adSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714419693; x=1715024493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EK+QgAf1Uu9FXCwwglqmF/U/fA030dNFq7Jdo/CG10k=;
 b=FsqDU/KgnTT4sVpdQ4aH0i/IoslKp4dQO0/T4RUYHiqUtEfcstYdrbxbM05IX01SrO
 DESdE1zn9lNNavzIMYQ4/ERYgitOzUcM24JwbiFkPjaEKy1Obt9pZ5++rkBp9so/4HTo
 xoRmz6AOYRJb9wQ4ZqpdlVwITu8mNW4RmRRrfS+CQ69whzoxWgIWrhhL739O4HwthXoW
 D6wuPYGS6/ncVuHcWU9Q8wK75B6hPuIsjZuPKh+nCgfxPbBBwGaqsYMoDzUMQd1M5qkg
 nW0sf9OFdX3laKpTdHwnQugBUGEZZQnqis3qEqyavAXsCbaUIPH2oO5j81u5+iYLZmWV
 W2/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsDjBn5yhz+3pymXZ2XH1yF0KyoONUQOmuqwwNkCWKK7kqb41jrfJ1PhBBBgmlv+XpqRVQ7OyRF5TAB75tu9yNIAqmgXw=
X-Gm-Message-State: AOJu0Yzi11ZSAn0WTMEIHRMkJa4R3ZgHkpwCF9ovn1oTn3D0pjvkTat4
 xJEplXqns/eh0254Nb+z7H97JNhbd+J3EOFYm0HkOWJ+zak5t5bd
X-Google-Smtp-Source: AGHT+IEpkJnb3/KgNpqW5Q3SgP/6fkwrGtlcw0208PRVbQlNi1grmiXT1hNanAw70/tnBHb3Zr+SHQ==
X-Received: by 2002:a05:600c:1906:b0:41a:7c1d:3326 with SMTP id
 j6-20020a05600c190600b0041a7c1d3326mr655177wmq.8.1714419693443; 
 Mon, 29 Apr 2024 12:41:33 -0700 (PDT)
Received: from [192.168.21.123] (54-240-197-239.amazon.com. [54.240.197.239])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a05600c0a0900b0041668162b45sm45732284wmp.26.2024.04.29.12.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 12:41:33 -0700 (PDT)
Message-ID: <5f757749-1968-417b-bbc3-8deba332c1aa@gmail.com>
Date: Mon, 29 Apr 2024 20:41:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update my email address
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>, 
 Anthony PERARD <anthony@xenproject.org>
References: <20240429154938.19340-1-anthony.perard@citrix.com>
Content-Language: en-US
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20240429154938.19340-1-anthony.perard@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32a.google.com
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 29/04/2024 16:49, Anthony PERARD wrote:
> From: Anthony PERARD <anthony.perard@citrix.com>
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Paul Durrant <paul@xen.org>


