Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5408AD637B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVe25-0007zN-DE; Tue, 16 Dec 2025 18:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVe21-0007yA-NB
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:00:38 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVe20-0002Zs-0g
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:00:37 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7fc0c1d45a4so987169b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 15:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765926034; x=1766530834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=51PBnHcGWlDlgUAtaOIDRyrY122NrKUym3Eg85RU+Jk=;
 b=SBcOV+gx9HjowPmw7+oheNCv3Eg+/prmR3RqjQPiHm2MLnl7fsWSwnlJ1vi1fQLaza
 j2auz2asZUYCowd7C849ERmE9bYGRl9E48LXr4CUda8hZBwtrQPT540tXXyf7PO+LZ0N
 JFpuSbJZ99QJIL3rmB+5VEl1TIV/psk9ZI1e3/6kDOmeAmeOyi+f2CIy7vVDbTQSQwCD
 huStgGB0E349MGwoDagcB6eswD/9SdSxkAIdzQIxQOrDHPtNkhr8RvHfbbJkBQLvbqIi
 svolNQMCRr4PcXf20I3QzawybfxP4P7puZeP9NxkbKMMiALsx5Ir3UHHSo726jfussLj
 EF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765926034; x=1766530834;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=51PBnHcGWlDlgUAtaOIDRyrY122NrKUym3Eg85RU+Jk=;
 b=nB9bpq2LTQ3Xc9gTQ9xLGXe5WRaTKebKO+zwlxE4nAq6cHQVec6Th7Vfc0IagnRMQy
 XDJbxOCMyQ4mSp0FKLrGgq5piB5ccgTYQMTBdBNNvVg84mfMHQuLKRzaEEDkjOt25dap
 354goA9pyPXkaO245oz10mlOgZva7qKw6nid7o+DW+4NhQkjlljMBIlZ72QY9xapph5G
 E/o7qt/uy9uY7mkMabfE4DU1DWa7A1Fl6I+6r/6YrCXrbq9by7oG6T3DtGo2fZ8MM/TF
 PYslAWgYR26cbs618Z5DkoZ99PayfWeRPLaRAQcnOnPi1qdXvN23kOqZLlGKnG1RrlrQ
 nYnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKd6/QNxlwgbMhfVcPva2iMX/Er/6ZqzWc4u/2Tg9nZfmTGHOzyHuLlQfN5W2E4bAwGwx+qF666bMU@nongnu.org
X-Gm-Message-State: AOJu0YwksrmhQgplUI2+avo9Rf4TOhoqgWy3jstDvXGOg9oC21OGcQ4x
 ILJXuM08Ls5Dxdp1cU7gjcjXP24mVycI1SGco0jRe7637WJXHll7pzr1Wup0Sz8P7Q4=
X-Gm-Gg: AY/fxX57poEjGXa5cYgcNtWRCI2lwqQYydeFToOBw7A8MFvOcfjIqUl6rQG+vZsGgSa
 b1kcOcuelo3WlUx38oPcKO0BZN+zsooa3G7d6gpr0HadIZB3YB4YX2h4pi2kYR6SxUXwvsMZ6fm
 LTtWqPOw3MOBGvt5OxdGxkqfB0LfVEDjrg3AZBF1sQjDAKDNCcI5tdVWRpv4vmCIqDW6qwSysSG
 FQtZTDrLoMjkTkTuogTSN0hDBTtZXU00/cbkna3qqaNCWLGHG+XrloUS/cVzBNdEhP9ieKhtXew
 CGAw2oa1KIvYOvqZ8hOcELqBkADAVPQnUtr6IPyqpgNYNHs8tuEfCUfqzOd7DpWn1sEqMMBU2IV
 CBkNrnrqQLfjCr1y2hD4dFW3qBmKHBPvID5RFLzo4yeonN0s9bZfrGK75RR4OCTD726gfZgNBT3
 t4c3+vPpRIjUJ/W7z+jvuno6SslHziJKNUGyPUkKE4WmF8BKkCz4aHhFKqqzSWwUlYjw==
X-Google-Smtp-Source: AGHT+IFZ3oBslqXPrBXTjANNrvugLOCrMJTIq/pheSF9RAQf6Q7kSy2TL35fZdajqBWGbNtFZI59Iw==
X-Received: by 2002:a05:6a00:b483:b0:7c2:7365:767b with SMTP id
 d2e1a72fcca58-7f66f9f2f5dmr15099827b3a.3.1765926033912; 
 Tue, 16 Dec 2025 15:00:33 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fcbb11e265sm607210b3a.33.2025.12.16.15.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 15:00:33 -0800 (PST)
Message-ID: <345bee9e-4b3d-411c-9f45-eba47a72366e@linaro.org>
Date: Tue, 16 Dec 2025 15:00:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] util: Move qemu_ftruncate64 from block/file-win32.c
 to oslib-win32.c
Content-Language: en-US
To: phind.uet@gmail.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20251215164512.322786-1-phind.uet@gmail.com>
 <20251215164512.322786-3-phind.uet@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251215164512.322786-3-phind.uet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 12/15/25 8:45 AM, phind.uet@gmail.com wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> qemu_ftruncate64() is utility function that may be used outside of the block
> layer. Move it to util/oslib-win32.c where other Windows-specific utility
> functions reside.
> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>   block/file-win32.c | 32 --------------------------------
>   util/oslib-win32.c | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+), 32 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


