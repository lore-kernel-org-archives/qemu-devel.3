Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF73C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTN9S-0008ET-LQ; Fri, 26 Jan 2024 09:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTN9R-0008EC-Hp
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:25:49 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTN9P-0006Km-O2
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:25:49 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-558f523c072so222258a12.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279146; x=1706883946; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oDILiIAGWBL8LZeEZ8HBbbbCjS5wToKXJm9FSBk2ZKE=;
 b=sLvYQHFYQg0ItspCCHlYhLSkCTsvaHI8PI1WkPhFu9JydMRkE14CquKUVphFTiE6tV
 FXjbskCiD+Td/V43u7V+pjAgGXzWY2RzFC+kuRRSPymJ9LgSJxI8PyXgzBsbbawfoD7o
 07hgKOGxV0S9QrbcFeMsbzwS3YFpeYfTmy6KnRftAd2TIls5wYY+kdsV1npS+ZeJhdAs
 ulr/amWNLA71+r7fnf2pn/0ZKYkUMx8w5Mb8XH1RVw7dlkNsivYE/tVcdPhn4gYwbSex
 m9Gxav0YVVPBHDORZbyCyY+eWujVFmFF7FvgdDwAxXFc7bUSLKehtPhfXPRbwOYdFcEP
 O0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279146; x=1706883946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oDILiIAGWBL8LZeEZ8HBbbbCjS5wToKXJm9FSBk2ZKE=;
 b=eFhcFdZ9wVjWnO9ifXplMgn5Gf/CFMRYUzRx+h6hZY7V+iHgMvnDXeaWDc23X6jONr
 rH12yxmUfXIYHpPHxOlZD8lx1YlBjGg86uJrm8aCFV5miCY519PJnV8GKPXvYIrm5Lmy
 xvsM+dTr3E3NBISOdMSCEV6+H+0pGqHc7sC6LkdaDwtlIxoAn4jMAXfZF+q5lByXDgtq
 h9MZq5wAqMFaCGS3PsCBl7zdf7kftVzFI/0W/GzlButMw2/NKss2ywvpCJ+u3T0jMddc
 Ei89sbkdqMJPFVJxI0DwzvEuIj8EuiklhEpX5OD5RFVfRtS0EYKhnqZm/MlGk0G8b1ld
 XTWA==
X-Gm-Message-State: AOJu0YxsXdIMoBiTbQ1RIAkg1DAVc/i4nPYjp8z0ZBT27xcrwpRbDUqp
 VwzLcgQUeUOHbAKZC1zaIE3APqm11SB5F1YWG0WCyxkjGZ8bTsMyRg5vk8RJ8XnwhGqaynistwK
 M0NDmirOJFafomA877KinmvpAfiRRFXydzVcepg==
X-Google-Smtp-Source: AGHT+IHNul6xHkagugJua+VUiwHANtqP4t2lx7nbhSa+LpW093Mt5TiB/VHcw25El7Pl057A98RC0uiGvw9FRxAN0Zg=
X-Received: by 2002:a05:6402:1288:b0:55c:78e9:de0c with SMTP id
 w8-20020a056402128800b0055c78e9de0cmr539082edv.32.1706279146271; Fri, 26 Jan
 2024 06:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20240126122717.221575-1-kwolf@redhat.com>
In-Reply-To: <20240126122717.221575-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 14:25:34 +0000
Message-ID: <CAFEAcA96Nn94HZOtzi6_7NVeD=JxXJ6f3u-JwM0VrOOOrrPu7w@mail.gmail.com>
Subject: Re: [PULL v3 00/18] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 26 Jan 2024 at 12:28, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 5bab95dc74d43bbb28c6a96d24c810a664432057:
>
>   Merge tag 'pull-request-2024-01-24' of https://gitlab.com/thuth/qemu into staging (2024-01-25 12:33:42 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to acf2b9fce9f402b070a65bea584582df0378da9e:
>
>   iotests/277: Use iotests.sock_dir for socket creation (2024-01-26 12:27:41 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - virtio-blk: Multiqueue fixes and cleanups
> - blklogwrites: Fixes for write_zeroes and superblock update races
> - commit/stream: Allow users to request only format driver names in
>   backing file format
> - monitor: only run coroutine commands in qemu_aio_context
> - Some iotest fixes
>
> ----------------------------------------------------------------

Not specific to this pullreq, but I've started seeing occasional
failures of iotest 144, apparently due to a '{"return": {}}'
line in the output not always appearing at the same point:

https://gitlab.com/qemu-project/qemu/-/issues/2126

Could you (or some other block person) have a look, please?

(In the meantime, I'm still testing this pullreq.)

-- PMM

