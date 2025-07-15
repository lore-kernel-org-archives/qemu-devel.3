Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5473DC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYrD-0002dZ-II; Tue, 15 Jul 2025 02:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubYqg-0002Ss-JI
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:09:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubYqd-0002pl-DV
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:09:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4561ca74829so15126095e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752559740; x=1753164540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9izkpMycP1+0XfZ18JI8dY3Ztme7gTEzGcbcPX9twfY=;
 b=YdOxT6+Bo8Zw+XSYt6LTiApDJAPheZYHzfckVKVHL3HDY9GWdnIIjCoOLiDudiAOFj
 06is17uoOULbesuvgCnoTdAXbCzmaKzK3fDz7FG3E2QIikgTGu3DGfM69ySFR+xM07cG
 AVnXY44BCxt3fRb4senR+talGIL+E2FuNmBNeGx0yZ80d25qEnAxrbYKW8qn6qmneYBq
 EJyiaPSDQUZZU2u1u2LLlm9s5avVc8EI+JxkG551sMQ8NYajnJqy6N13d3G5LtHGAS53
 B/M3kW0fOhlaJiIcOBtR7JhtV+B/KYEL6Gmtt+O3DVaoroGkqX9e6RfsN/E4B6zMWo3z
 v1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752559740; x=1753164540;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9izkpMycP1+0XfZ18JI8dY3Ztme7gTEzGcbcPX9twfY=;
 b=ifwf8fT19ouakXMtRVrC/Yb34L1stq4/PhV3BcJUdGoF0tZBYqQ4VBpXqnKchhpZmT
 9BI+yOueyb0uFDciAsaZPINhLuGS9iFNi/d5n8v3yPX8qkkK+Z8CDmc4angPZPtNQ1CV
 U5x3Qrw27VtiC2M17UuTW6+3s2LhKKl+/MYlJ6UPjvChy81lCWfkpr1KrZwh+VzzHf42
 zCOa0MP74pM1EemNYvtiFvk6mE/ruBXxdlgwdiFPpD22lezioKjzz0980igD4Fn9M5qC
 AIYqNNL7T4whtmt52oPtJUSeDdtmFCX5upnasmqkSOp481NueA34OGEQekf0lQuczquo
 pgKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3qn8G/5sGluaCmh/uT2DI/SSEWyb2e+Ihzrg8akmyeK/syiM43+KaJY7KU/xEmN5E6zWI45y3ubZw@nongnu.org
X-Gm-Message-State: AOJu0YwKNHQEcEspgPGFuMDfzMO8+eU2CFZxNj/a9WuUsd6CPBnUxKm0
 b8oO8mpAEXDKmNIs3NwdNainm/gVd6jDwUxZmtXmaqqHzkfKUG95dvK54iF38Ek/QThxL0NSpGZ
 FgyYk
X-Gm-Gg: ASbGnctxSxy8UifNuC14fj1mC5+07feLk4GupXywNmWmngEHs2h+JW/rTCdVs8Sdt1y
 ds/QDC1nGtuAhv//NvPKOHcLa9tjUH1Q56Pe+aZVEbIs7nGF7vtv/mXnQx3B7n2m/2kegiFJaeP
 VRqfkzfekmjaBYag6WwoLfHeKZ395Zg3JmDCSQpcTci7R844/wkJpfpMGp/cD/wYWAwEjOYs3i7
 sdgB5L37P/6jGICmewyY4dBFL3fWHSfkm+XOnbTMyOvPcLfJ5xKB25rUysHyOf1JZOq9SvAZPPZ
 5XbcTyLlhwc1tKigUTPkiEu1uDz0ZrPSRPQezTVBGygMUGMuf/Hn1sxSWkF0UY5mEVFOhe293Wg
 uV0tBp4BL++c9L93JoGqsQqpDFQx90T+Za0PTfLwqhZfaG8O5cdcf5Do9q+exuVR09BSOX2DbjR
 Wy
X-Google-Smtp-Source: AGHT+IGZsvPmQrxMgv0kIDabGb/55sNUhRtiEsf0GntxZhCIyD7/lZPJrdpCUtSOom5s69JSRkFBDw==
X-Received: by 2002:a05:600c:138d:b0:450:30e4:bdf6 with SMTP id
 5b1f17b1804b1-454f4257d10mr134948985e9.19.1752559739637; 
 Mon, 14 Jul 2025 23:08:59 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-455f222e4f4sm111280835e9.10.2025.07.14.23.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 23:08:59 -0700 (PDT)
Message-ID: <b709de4f-454b-46e6-93bb-9b07cd15ba2b@linaro.org>
Date: Tue, 15 Jul 2025 08:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] esp.c: only allow ESP commands permitted in the
 current mode
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, qemu-devel@nongnu.org
References: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 11/7/25 22:46, Mark Cave-Ayland wrote:
> This series contains a few minor tidy-ups along with an implementation of the
> logic to only allow ESP commands permitted in the current mode. The motivation
> is to fix GitLab issue #2464 which causes Windows NT MIPS to bluescreen on
> boot.

Series queued, thanks a lot for solving this!

Phil.

