Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24809FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 12:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKFMc-0001Zb-7O; Tue, 05 May 2026 08:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKFMY-0001ZN-4M
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:58:58 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKFMW-0002P4-DP
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:58:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso64497315e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777985935; x=1778590735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FZ7FTXo3W+oQA5dX87yhdh2ygCzKVxOBwJWoRndWHCc=;
 b=H2ki4LzLhyXGp0lSZY/BU7vUeC7NIkjPO+0qBpv43nIBfm4OvNDJy/pjsqeHO3AoxM
 oM1bQax0U9WZZJ9P6FLIfExHxz8i6nsIGvlB1P+FFB2J5ECZkvt8fpHqiOODw3mqWbDO
 ouPi22AdV1QWJQKnxWvuXoKevLVIRJNRr5RdTqwIcbrqpX8+8a29QLsgRPVLZJWW+Gwt
 61VaCe+POe4rb9vVa7f2bxu9jdfRIdN2gxoslNwxL6oulELlx4HZsgvjL9UgJh8A2A38
 9hj9FOGT/qKFa7fz5x8cSnEMgwZduBTLlGFJvKfTGx3DgAV2y66c7C8rx48th9KN/0Dg
 Qjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777985935; x=1778590735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FZ7FTXo3W+oQA5dX87yhdh2ygCzKVxOBwJWoRndWHCc=;
 b=E1wYur/HWyTeEykgJKlT99BX1gkLbTeQtdlNOWJgchL/7ck9BS1tZhR5bGfETukZI0
 py9Qq3yjxO5NNSMCCLtmuI0T+FeOWZYVPfAAcnsurLfqZDCBADT41IbBRRRNGJJ8Y+bu
 PYv7h66kR9Z699xOvq7GiYtiJTRzhwulVXkK3CutGwzHFhpI+W1VGU0NQN7yjYgsYAVU
 qjEI5AfAzo1se5QojC0ZdToRpSxcvmdgef7Ld9h/e6eMhTkypyfklp/t5RxGVlOEwLAN
 TNlCsVPOA6NGipGJT25qnhm7TU1EzhZb2aRr1CE5JkFmQ7fAymVEuCWFZjfr5clluDlC
 oP9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ85q9QcXDLa9R0B3N8kW9pKaMD1uuCaGeJaeE5lebXExkCEolBxFUPPa9mas7uPAZboRwZgrd4XwUZ2@nongnu.org
X-Gm-Message-State: AOJu0Yx2TuKodzRWk5oa1VWAy5obE7er8wg3fd/xmveVOLPCBJKa3s7W
 cCf1yV5XkTRu4syE5Ivd9BtkeOCVq2Xgz9pw6LdNA7+o3Fc6uHAZv664h883mCNFAjHn98MlF0f
 5MyAqsws=
X-Gm-Gg: AeBDievSfLiS1F1cjXJr9ngd675ok4pSLTALzsZkBCqyu8PqV93xWy02C/zkdZRGILb
 9HXaPkHoJsyh4jgnRa90nBl/9Y84mm6v5BAIq9Jcmw0kLijXJP0F8q+GqWeNqE7uEmOrZMoep20
 AEcLJhrhikbHLGan5L+c3gwyFSvyMoFDLhRfIg6Ntx1WxmUzi9LzO+jgL3m4zKnFw/G5E6AARbM
 SO7x3SpNuDmIQy5FvHHspWlxrDZN8Rq9KMj3a6qrvilbtV4VpfX+ivKhvbrkH8+xN6kaJAfLdfa
 x4AyLinGBlCvtCGjO3Y7YAtUSJk7TOZNvLJOOaV2YIYadTU1jB80j8EsmQRINGz4VPg3vzvEYec
 InY4uEJYB0945DSoAPmLyrN6XKarfnloDVUNNwhOH1CBCN6piDNPGcwQBl4Ij1d/UCBOTdlfytx
 QZLwoXXiBtU3bkurBbk3qLWkt0NXCvmt57DjHOTOY/QXerkoxbBDP0h6QBUouhnVvOq5QDwxa2b
 FkX
X-Received: by 2002:a05:600c:4445:b0:488:af48:af11 with SMTP id
 5b1f17b1804b1-48a9853c8efmr228801765e9.1.1777985934583; 
 Tue, 05 May 2026 05:58:54 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d17ff628esm47160075e9.1.2026.05.05.05.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 05:58:54 -0700 (PDT)
Message-ID: <0f68fa39-f190-420c-a55a-f31a7b95663c@linaro.org>
Date: Tue, 5 May 2026 14:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] Monitor patches for 2026-05-05
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com
References: <20260505123502.1316554-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260505123502.1316554-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/5/26 14:34, Markus Armbruster wrote:
> The following changes since commit ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-05-01 14:41:49 -0400)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-monitor-2026-05-05
> 
> for you to fetch changes up to ea017f67ce1ca34c7503b6f23f48b433585d37ac:
> 
>    monitor: Add `clear` command (2026-05-05 13:53:03 +0200)
> 
> ----------------------------------------------------------------
> Monitor patches for 2026-05-05
> 
> ----------------------------------------------------------------
> AlanoSong@163.com (1):
>        monitor: Add `clear` command
> 
> Dr. David Alan Gilbert (3):
>        hmp*hx: Move info docs
>        hxtool: Split srst/erst add checks
>        hxtool: Error on missing docs
> 
>   include/monitor/hmp.h |  1 +
>   monitor/hmp-cmds.c    | 11 +++++++++++
>   hmp-commands-info.hx  |  9 +--------
>   hmp-commands.hx       | 41 +++++++++++++++++++++++++++++++----------
>   scripts/hxtool        | 39 ++++++++++++++++++++++++++++++++++++---
>   5 files changed, 80 insertions(+), 21 deletions(-)
> 

Obviously this conflicts with the PR I'm waiting since 10 days to post:

$ git merge pull-monitor-2026-05-05
Auto-merging hmp-commands-info.hx
Auto-merging hmp-commands.hx
CONFLICT (content): Merge conflict in hmp-commands.hx
Auto-merging include/monitor/hmp.h
Auto-merging monitor/hmp-cmds.c
Automatic merge failed; fix conflicts and then commit the result.

Sigh.

