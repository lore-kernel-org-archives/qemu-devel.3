Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0808CC6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 12:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rneTb-0006Or-Qi; Fri, 22 Mar 2024 08:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rneTa-0006OC-2j
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:58:26 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rneTY-0004Tt-2z
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:58:25 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56bc753f58eso2482929a12.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711112302; x=1711717102; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZhkeEo/UIFFLGByKCGYe1uYmHT0Fqpd3UUx9SW2R1yU=;
 b=muoYCEl5I593UejXWm6F0vTxdiiuZLh65Kr3fm4fZauZ1RyqCMQ6EIg/0UBSituYrg
 qcd0m51AFpoIlVSoHSk+5LLQ7fIROJhGX97tF3iLDarKmK3L2P7Azfm2i5DDMC5+1wlr
 faksg08zjYoPAuHBOU8zHikCA3ogfK8G9QymdVm1UZ0n4YAM525xjn6G79+GGi5rucpM
 2Nl2hp0WCpVvZ0x6H4hrwQ4n8BkEDJvWF+HeSoRbqjoWxTulGHqVJ3IHeeesuu3dgaAs
 /c0uuTGI3pbo+GS/wXEgJkthMUISn6MN+Gz+/nQ+wqcvq38TC3dC6jIqNG2d48BHGwDO
 5O0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711112302; x=1711717102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZhkeEo/UIFFLGByKCGYe1uYmHT0Fqpd3UUx9SW2R1yU=;
 b=qE9N8Sh5MVhVLewtY/qxoKZOFcxJCyx5tDcCOGj6S9kdRZMFDhlVigxUHqmPQ5Kr9v
 bmo3YYpi3N/ObfQtJC2npcnY202JhwW57HGjGB4ecXKv6alX9cOnHNqfxfXqpGj9yxd/
 sG+/UVpwad9Y2FFuDrnRQ3Hj3ABoKU+AN0X6GVqHbBfrhXmnxUDxBCXKixGdt9Ybmy8e
 azpOCnXRGO+Ht6Fti69BIsWw+Lo0E7kbLEb2pe6getxPmZYDgjZDbb9LlOusmzIH+4rr
 1szNRaM4n/uAEupfqLsaO2OmNfgNHAO4TJ15+UA8JlJsqi64GGRKePj/QYkvpx1TZjlj
 ZtKg==
X-Gm-Message-State: AOJu0YzlN5nJiCrm/IfQldDdSY8WTVVzW03b25LwCkQ1XvtOk7cw337v
 sXF6ZrdsSfgml3/aARt+9hD7VV29GmFB8ZkbBl0sUHk2SjyMcPExN76a6haiLdDxgRx046ZgJvK
 dN/v2jdnxRwK1sZQlbd+jY525Bagf1dWuh/uFM9hjFPn+eL31
X-Google-Smtp-Source: AGHT+IEsJeCIACebOEeFd1MlSgWVzCNZVWFCr+wuZKXLLV9ZfivBSlOWhmLOov7DmvFqbzUL0IPe5VLIc0elTIh2a2k=
X-Received: by 2002:a50:d60a:0:b0:56b:a969:e742 with SMTP id
 x10-20020a50d60a000000b0056ba969e742mr1570791edi.4.1711112302351; Fri, 22 Mar
 2024 05:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240322100323.1973836-1-gaosong@loongson.cn>
In-Reply-To: <20240322100323.1973836-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 12:58:11 +0000
Message-ID: <CAFEAcA-9maEMgawxvfndLyZ8uWnCdiD5VLY5H8NMJ8Ph6M05bg@mail.gmail.com>
Subject: Re: [PULL 0/1] loongarch fix for 9.0
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 22 Mar 2024 at 10:03, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit fea445e8fe9acea4f775a832815ee22bdf2b0222:
>
>   Merge tag 'pull-maintainer-final-for-real-this-time-200324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-21 10:31:56 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240322
>
> for you to fetch changes up to 1590154ee4376819a8c6ee61e849ebf4a4e7cd02:
>
>   target/loongarch: Fix qemu-system-loongarch64 assert failed with the option '-d int' (2024-03-22 17:57:49 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240322
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

