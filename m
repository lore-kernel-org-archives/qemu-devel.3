Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE378606A32C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h/dmvIwI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP0Ha-0004rZ-Sc; Thu, 05 Nov 2026 11:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xP0HZ-0004n3-GM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:25:45 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xP0HX-0000a4-Nu
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:25:45 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3b09a65c76dso1574929a91.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 08:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793895942; x=1794500742; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v+gAwBDizpFz6gCkgFo/bx1wVYeo0S9Hh3v4e4yszu8=;
 b=h/dmvIwIc7ecXGS0YXCNP7S1YtDEU4Hm6wBIMiVhaIxr9FCZJU4n0IDG6wz6SaA7ku
 89CHtQjwsHzbWXE8jNxnYDY20wWFP4hDbxACikkM2VvsFsHXyGPD7i+BmrHAVSDZtv3T
 HhnnKdOn5LbP0Xu9GIdcOnxgGRfsDhWyA+93HX+BOAfK0wzFBeRLeeSI+rko8R+K+VGL
 vaOlZ2mZ191NQSpkgW4c2SFmVrUHyCdM45zLjisH/5Y/dpZ+FSXX8mIFZj8NM+scyz//
 HIDeX7oRxLXqxFu2DxRFbZq5GydCzDleYjss6nrtORBZ+CB+0eqkYAUT5j46yxmZVUc8
 Znow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793895942; x=1794500742;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v+gAwBDizpFz6gCkgFo/bx1wVYeo0S9Hh3v4e4yszu8=;
 b=kgOJXZzCpew+TRdgGpWPwgVSp4QiyuMjkIkGjT80odff7FOLD1HDs1YtTL7K9T6DLm
 qphtg2CqmxpvffceYTs8qnf+nANjG0NNwbStYK8cjlXO9yx5IFRHrHzeEr4JfeSXQ5zu
 X8Ig/lLSvLxpRWmaISA4gA4dWKanKyznDkv8LzZVlxlWzW37z63DLqT688rryRq0iQvf
 XOXO5RK2M0uzkdD9TZDp58JHMDkwuHuDvlN5bk2Kadqf2c2yoKYnTELE7ieXc+1+ZyQp
 CnUrUVHOqmIya17xb+WtvUbs2jIfaji5PRqwARDxRoqRcok6QQ+uPQw0V4SGbv46zgOa
 6wUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzemQWD++4EMbNZ8KmCfl3KumUQc4juuEHJ0p8vrh8KNsx+y5IymDGRK6COIdqkHOUKZSXuCdvQ1TVz@nongnu.org
X-Gm-Message-State: APuU4Z/upzYKuRCLtmrykHY98yiCYa324r8mT+DQhvj7VXzDfsOxd3jf
 VA9/kDVnpJKGwW/HP6/zDRV6gw37a+Nh70oJAnkyg3sAu8K82Bzsgi23flI0Kpb1on4Hw8iKRN/
 wNFSu
X-Gm-Gg: AYBFou2gRzGdF+IbfmNZtYGNzfKzGbWefxBya9CpmjxEBZaK07cWqWlCwDAt+9XEZfj
 m4OUWZSfil2z6rYcKsA4Rd6jX+M+aePys7QZerqvul7Rqfua/85AXzFt+85GP6E5HMXqvroGnzu
 QqM6+VnQ9VBCXIHe+bmbJ279JI0ZKSXbpPY5RNgSEm7m0zcpm6979wmKVPwG+Ax1XTlVQDKkaci
 VttOAnitqeWICs51Ak72tRrsAIQppEZuXpgKkfUBdla6qMLbcV4VWUMce/V/4oHrm6FtxeZi60f
 OwAFwNbBV8zoKLVs2MKuMTB6q3+P1yf9zMebC7jk+DZE4JVkKRq/rzyuph2pafNsPkO2pvOkVFg
 IpcHo6q3fTFfq2pT/sTqK8smvSSUJHkEjGK6FqSPsb5gkfsV+5z9klpss9PvSPCpy5SmObFDAVE
 kNqf6IQEGGyIqdDuCRwrFbBM2DZfWAI2djAGu+GzA9UioRMRdIK4gKnGTZQ3jVZHD7TVMwl8d0y
 aRd3qmbkvAKUqsl9gAB8JY4Ukjw/bnSbRtHuqtwCWZEWw/r9Qw3mX8W1bEkRl1QLYKMdmtkDlA8
 8zLX+v0tORnyxlPMtjV0uNbG4S944ynYBwBKRII14ujSiCsv3FmWCtdPjlQKj5WpiSW7Pg==
X-Received: by 2002:a17:90b:4cd1:b0:3ab:2d46:1dd6 with SMTP id
 98e67ed59e1d1-3ae895a56a3mr17235621a91.4.1793895941868; 
 Thu, 05 Nov 2026 08:25:41 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b094d70a60sm4720640a91.1.2026.11.05.08.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 08:25:41 -0800 (PST)
Message-ID: <5be9a4dd-9eec-4f59-bfcb-256d891faf7c@linaro.org>
Date: Thu, 5 Nov 2026 08:25:39 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] qom-qdev queue 20261105
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org
References: <20261105105502.1786431-1-mark.caveayland@nutanix.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261105105502.1786431-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 11/5/26 02:54, Mark Cave-Ayland wrote:
> The following changes since commit f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5:
> 
>    Merge tag 'pull-11.2-misc-fixes-031126-1' ofhttps://gitlab.com/stsquad/qemu into staging (2026-11-03 14:44:10 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mcayland-ntx/qemu.git tags/qom-qdev-20261105
> 
> for you to fetch changes up to 24ce0031350003bfb70676f47937dac8fb3f8294:
> 
>    i8259.c: don't leak I8259_PIC output IRQ (2026-11-05 10:51:55 +0000)
> 
> ----------------------------------------------------------------
> qom-qdev queue
> - Fixes a memory leak in the new i8259 PIC rework that was generating a
>    lot of noise during "make check" as reported by Peter.

Applied, thanks.

r~

