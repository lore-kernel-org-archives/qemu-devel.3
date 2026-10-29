Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B3606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uvJAhhfL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQEh-00056v-Kq; Thu, 29 Oct 2026 09:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQET-00056D-T2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:31:54 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQES-0000iU-6d
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:31:53 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6ddef424972so1651790eaf.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793280711; x=1793885511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EspXhGZf8qyk88Ef2c1YCCZz286bZGVQiJhAojQsEQc=;
 b=uvJAhhfL6zllu8WKfzazT4pZh73eyTIZBzR52pzhMddWAxVLZ3Qr5+urfDlVmzERvP
 mUIQvuFS90c9jVZeCaDAZ8dRBy7k08i/BdhIVZy7HwszaRkT3G3oe+sfWz3njLZax4sF
 nNfkH9YgTP2qNTCG2OZH8tNcN8NPzryM7j/TeR213oKnoPw5TQIoNixuYc+PyKCUmyJ0
 qU+phRUZc0lun75HhQo0HBQNT+49z728ve8liht4AwOEduCr2kEoA77mo9soUhJG7W80
 lVzRrUzmcRvChKy06O5CqKq8tCHrplgQuvXphzL4BllukH+/GzvUgRagllFjQttqoxqU
 9Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793280711; x=1793885511;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EspXhGZf8qyk88Ef2c1YCCZz286bZGVQiJhAojQsEQc=;
 b=n8pn7f6aCgIyF4iWrPkmEanWoOm6h1rUrUp3aCdXCIv87w51aCrTk0hsU6j5xBfb/M
 MitdeSrKbOzU/aKeS8E4k6EejpKgpuk39SNIBw+cFQ6wkexNMUmw5vfnY1tMQR6EtUJa
 SF3B0flscmzcIhZw8eyRjjd4jj9OnhFx72eFEnjaFcagPyHJ7s9y8EQXNOLPwkVjN/9s
 IrH2s3n1XW5T/4mw07gcrfRWDqMlbh2xfKyYJC6jbokUCGOrqWumZnSXotPI7V9AzGJX
 EWsumLzH/Pk60MSa60SCo9MCa4Z0nxS3cZUCgcQsCDHx5r29Z8u0cWL1BEMWPXVGqQ3z
 iHvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuQqQbDVCuc02QAAARnBn4RB3r/S9YKnJZRtfkT31Me+MXOw4ekY7FCqUqOC1GncY54POiP4n1Uh7Y@nongnu.org
X-Gm-Message-State: AFq9FYJegKts0WXF8bej5bwQ95pM1yF3tHUYEwOKrhqBbac2MwS9rquz
 k7Etl2H00WsAKAXnL0mwXqKrZsn43CDKnzjH5hBjt9OojgsLNcxEhf54zCgmLfun6b2nY6bhr0x
 xuAGC
X-Gm-Gg: AYBFou11U1LrLM1M7pPeC8dQr5oFtMohAMmjl6v75I1m9V8SDSxU0809Sz+xwdaOiSS
 pwS8vM8drekjg+JGjEjzbsUQN2uMdcMdxubpD/+CLOMprfBhd2kW8kCywMSgli0tp/1XVmorWD5
 cH+VUObOoAzfF6a9bpjIAN3Q0zyiM8AIHgGDklgmcYcwpCvNcEZ193qgMi0kfj0eUzz4o9YPlej
 PByQVpxIRfi4sWk35xvHwdQiDpO6ity9J11K2/jMUc39u6v7nLVvPxfqLcObkjOuynoLgVITD/H
 Fgovz7rFGN6Gcr8UVP82Hf59mpQ2EY1mAjXTIw8MgYQ6FfAuB+7hD1RN5AZbGC8+tyFK/fefuAz
 49Gt6sqd/iho2vyizo4fohB147LwHNETvAgI4Km25lL2n1E+pYSNDtVw1B3eDhTXjlySCV0tr1E
 GN70mmDszO0NxpTbLqCRxJnphjOsiqTNfOf3gwoiMMRjb9RgXLaDn+HRoF6rMlvHWYbXev6qUCJ
 XsP7kxkSrbW2jWjzkypj2OyZcRDydV9edS6eb7aUZPPXE4pV6SMvgTwH8rE44ZunP8DsKZOB4jv
 3FVjO5Xfhxpyp0K0T4Et8GFwtnUG37QNUviklTItyrxV2w==
X-Received: by 2002:a05:6820:168a:b0:6fd:e28f:ad38 with SMTP id
 006d021491bc7-713ee66c229mr2851949eaf.32.1793280710674; 
 Thu, 29 Oct 2026 06:31:50 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7142bb7942fsm4360416eaf.5.2026.10.29.06.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 06:31:49 -0700 (PDT)
Message-ID: <bd16e295-95fb-47ba-9cbc-8108bf7e67ee@linaro.org>
Date: Thu, 29 Oct 2026 08:31:48 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Misc fixes for QEMU Guest Agent (2026-10-28, set 2)
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261028172342.96036-1-kkostiuk@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028172342.96036-1-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 12:23, Kostiantyn Kostiuk wrote:
> The following changes since commit 73294d096cc591e122fde9e63db4739de6d84f2b:
> 
>    Merge tag 'qga-pull-2026-10-28' ofhttps://github.com/kostyanf14/qemu into staging (2026-10-28 06:21:59 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/kostyanf14/qemu.git tags/qga-pull-2026-10-28-2
> 
> for you to fetch changes up to e8953bf0be6f4399d1333f92db41e4d146f754af:
> 
>    qga/vss: fix provider handling of snapshots (2026-10-28 18:51:22 +0200)

Applied, thanks.

r~

