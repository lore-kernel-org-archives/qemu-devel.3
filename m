Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1A1C30658
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 17:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMW7E-0007Rj-4W; Wed, 26 Jun 2024 13:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMW7C-0007RT-RZ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 13:07:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMW7B-0007DM-6g
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 13:07:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so5862655e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719421643; x=1720026443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ujgvp9qy9kh4XNanVSe8dOExLRTgaDQ/D5cPA5rx/og=;
 b=XiLP7FjRpssPfoCRNiPxLhGjGEa5Ix5bjpfLFj5r31yvSCc3/u+wCrVW79ZvVzUfb8
 QNv7EujSIaZarY1ichIqG+GvV7S6tzyUsRrxR0AdPYQ0azae1tKkoNyTJEnBmrrOxNSa
 sQoqQPGN3yGg0xJfrMGx5Nmu9TaTj0oORipxUn4c4ZzE1NhbgsPVuGYFX5pjEm/xHdZr
 /wEIHTVtsBlVDFNPII6heOy3duoimSacZW2e+rt9e8acSZL81WVhQ7x9/rDaZYVBFZMG
 eSGi7ti6GetMFzjUKcd+o6IbLoySHJjvREEZ4X0BhMZmBE46FzzxUIHGdjVqzgqZFfzT
 dE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719421643; x=1720026443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ujgvp9qy9kh4XNanVSe8dOExLRTgaDQ/D5cPA5rx/og=;
 b=TekfzW86LYubg0kGW1fmg7V89BwpxHMPuCIANcmsytGO0tvAMClBcKgmGzIiV2Slh3
 +msMvFBU4zkG7GfUTkGJzV4LIfAMtqAkVMfW8NyjGcSkJZq1EooIu0Lv2i0A3wMwntGz
 qy4LzLPQh7TTFAHRM+2w6EvM4NYa4nkhFBlljJBEp4MA8BJvduoS4dqYc9gJEK1gp7T5
 OrkSPtnUW+qATFuaiZoIk9tF0f/K3RjFwwg4MNOARL0nGKZBUOwSNoQvwalM9zHD43wg
 chz4ke+JHgvo/67A8ol8b4Norl7JHAlqQDKxNP6PwKXQaKSID6qDwfsOk2HwKVHfRinQ
 Bu/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIreGCqRFHe0AdfEOvq+Nqvl8vfH7Fl2yj/Uvhu+yH+hnlO8eebbOl3yMdxH0rqbaVV6+aRzShcHxQ0JbzcP95HePanao=
X-Gm-Message-State: AOJu0YxOvJimR7r5DiLeBZoulTnHZ8DUUDUIgzmBnAdLcWMohjqOSICz
 qKah0pOC2GjT1JeQtCWx+II2UdanwfTxacXii5pOgXelUWpFbAKyc7+BpxitSHg=
X-Google-Smtp-Source: AGHT+IEGKR6unT757x9SBaW08pNFQd8M+J7xs8S4DH4YwHzKdblKgfzIhuNXWLg53uNjCMh4TGtkJA==
X-Received: by 2002:a05:600c:68c6:b0:424:7443:e6d8 with SMTP id
 5b1f17b1804b1-425630fcde1mr2831885e9.9.1719421643603; 
 Wed, 26 Jun 2024 10:07:23 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.234])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8266ae7sm31920535e9.20.2024.06.26.10.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 10:07:22 -0700 (PDT)
Message-ID: <ae8ae1e3-746d-4a38-9478-f765cbb3e2bb@linaro.org>
Date: Wed, 26 Jun 2024 19:07:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] vl.c: select_machine(): improve error message
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-trivial@nongnu.org, armbru@redhat.com
References: <20240626134305.432627-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240626134305.432627-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/6/24 15:43, Vladimir Sementsov-Ogievskiy wrote:

> Vladimir Sementsov-Ogievskiy (3):
>    vl.c: select_machine(): use ERRP_GUARD instead of error propagation
>    vl.c: select_machine(): use g_autoptr
>    vl.c: select_machine(): add selected machine type to error message

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


