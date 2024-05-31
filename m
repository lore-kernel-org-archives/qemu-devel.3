Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21C6C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyHR-0007Py-RB; Fri, 31 May 2024 05:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCyHQ-0007Oz-8a
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:10:32 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCyHM-0005Sm-9T
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:10:31 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52b8b7b8698so291891e87.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717146624; x=1717751424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kipgqKIxTWjiY1J4diBph0ORkE9vgc6ZqFETK6Cxncw=;
 b=kX6/N9y0GzWQvdpnJZ5rjMuIiCadgUseCUfOT8om25MZ9cD89Oj9j95q2yYIM0eHKF
 Qr8qDg+ltcjx32hSALfFWI9V/sL1oNMB/2poXcseoyPL3oFc3h17G8jqz5htwiC1b/im
 E2tjraXvhfwWsvzn2h6jUe9gGqQihN8RJDfZBGAu+iyJn3BdVigmdMPjT8oG4ubzpcZy
 pGDgaCrmZCGw9cBZPocIUPKnigfUR9i6tzDRi95VjzmwF7EUbqXILSXlicqM/LJRnhQN
 yqWyAeSRzGFBrKN5Zl+ePm7jk3ka7B2zLcNWblSGsUJbBnu5YJKcWLhRcnHb6b828D8L
 alvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717146624; x=1717751424;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kipgqKIxTWjiY1J4diBph0ORkE9vgc6ZqFETK6Cxncw=;
 b=vsBXsX3MuqS2yflMp/LUdRDAjeTMQlbwP/kf+52uDDE6Iuall451eKMVZduTxpsCK9
 2ie9Wsidq4tHmgOFaG/hUc7WRAjEJwb25XrLx79IIhDLay02L6HfTSpMKFSU0PoiChK7
 fWnVLKKcq/P4KvEaCJKqLsMrqp+n+tTvPh41QWlOJgYcPxO8BzZBrf+8zsbgL/FsBUhZ
 sjiiWoULHwiR2qVoXf1NTnr1Wz518e91Caz1abQL/LL8zwM2LcqDXH/wD9+8/yyr6sOr
 qNeLytYKk9WjcdB505Gnm9Sg6lY90wm25dvI+ztKZptSSr7KWfX2rmkR2fjSI/CCz4bY
 Y+Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvJsn1NDcxB5XYb/qG+Wguzn904tCOTCHIgNHIUKitxb8fJ6HwvrBXxNAnxT/LCzdmDpu1s2HpNetgJ329BoSn0oFxZAA=
X-Gm-Message-State: AOJu0Yz1SO/1YMKkAWpe/qEwkADvdbTIOYpQ2ZgcyuqAlIv4fHEMNCEj
 irbda9Yo+fAzNvK7F3jogM66Iok0A53NGtzKHFB/wfzJMHpKYQZG
X-Google-Smtp-Source: AGHT+IG7vTACSFJneASAY6oepgxD0uTbsNdLpJPk2wq3sK792UuWxkKyL5fSGa5cotd0sdJt1GNwgA==
X-Received: by 2002:ac2:4a72:0:b0:519:1047:7eac with SMTP id
 2adb3069b0e04-52b89571166mr724613e87.23.1717146624171; 
 Fri, 31 May 2024 02:10:24 -0700 (PDT)
Received: from [192.168.3.251] (54-240-197-236.amazon.com. [54.240.197.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421270ad598sm48564345e9.41.2024.05.31.02.10.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 02:10:23 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <98ef7ab5-5c8f-45e8-9bd0-50e014b981ea@xen.org>
Date: Fri, 31 May 2024 10:10:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] hw/xen: Constify xenstore_be::XenDevOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240510104908.76908-1-philmd@linaro.org>
 <20240510104908.76908-4-philmd@linaro.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240510104908.76908-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=xadimgnik@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/05/2024 11:49, Philippe Mathieu-Daudé wrote:
> XenDevOps @ops is not updated, mark it const.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/xen/xen-legacy-backend.h | 2 +-
>   hw/xen/xen-legacy-backend.c         | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


