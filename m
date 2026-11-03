Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A3606A31B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CgwjTb+M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOKwM-0000C2-Jn; Tue, 03 Nov 2026 15:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOKwK-0000Br-93
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 15:17:04 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOKwI-0005YK-Jm
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 15:17:04 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3acd21ba21aso39293a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 12:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793737021; x=1794341821; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nY91Evczc6e26nbZageoLtDblkD0wk8cAq+/sOd4LTo=;
 b=CgwjTb+M4WfGw/fFQKj7Keqa81VVq1IMQalELI5vp9Q4OcYE0YwGcurE7+ZF3cwRyk
 GYlzr+gYulY7NME+vh9IOpLcb3FgxavqFuhozSiC3Y8bGs6HW2ym6GP5HXUjU1T2brgD
 NCRbC4ivxTIpb93zhgaGU9xLJKGcj1FKEd1lWKef4iDr0NpdS/NwVzbgsubYhgMMiais
 tAXsfuHX3NiD+APqv+cNKYK7VkxRVtYFpG3UaLeQArkRXSfYAC7JNjiNoSeNU4ZwDLLS
 A+93lJUXvHm0wjYs+bz4OyLXw7zfFa5G3BPMP8ajCrH1xwTO8b/WkEeeTgunGuAAOeLF
 ksvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793737021; x=1794341821;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nY91Evczc6e26nbZageoLtDblkD0wk8cAq+/sOd4LTo=;
 b=l2pOt0lr7kLOf5lKqMOrdAwxJLsYyWsh6D1CP/JV+G9NW8kBIrvDV6QDmyR8TYchmu
 ZjT4lIP57HWj/vRJ+JR7D3gZWO4e4Kt84IlLgvv+9lbrAfxrxRAzOK4+L2UQebheWnpf
 /qgK/Hz70Ddq9tDuhzLPKzmExBhB+FSKSlAQwWE116L3RHhC0Cknfsp0/AtSLJwxPdrr
 3QxHXXl8pmVh9ZEEW8RkLk2eVSELTVh/1cZcdH7ZjBkCMr8mb/M6CPiZEzmskC3E0Wmv
 RA7ZVzTxHxzLgOZSWbOcN2SEznCVCGVKxGaW1u3CTBnRgAU/PcC6HlQW8MQ4ClCkI2RB
 kEIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYczPf/NwiYGjRHN2fJZp3Jn5wEtFntNTVVmmGMe4mfwTOcQqcp/HoM+QgcojVLM/aBKulH0fdnD8I@nongnu.org
X-Gm-Message-State: APuU4Z/hMG19kQaCqPhSUw31tyXR0XQLvUIGFHRnnvbykqU4qscNuotq
 AXZ80Q2v7i5d/5VpMz8R0HGK/gNky65hDOhRUNMIEMxm5UidHxcaI5VmwuLexFIOuYk=
X-Gm-Gg: AYBFou3aoDnNWQ2DuHxSkHWAlP6RNHVGNmhqFpg60eknm4Nwrq2QHgscFnh3aJkEV+L
 F9uyOkJwsoOa8yWFW9sL7nRobPI07sQDHxCMqirYh/731FOM4OcoN7QPHLTdwROb+Ff3Zg5g8tV
 bAIbnfX8PBYekURbfmquZE0aWrx9+iZq/XDjQESmq/d1qxkkQNSeYMSmq/rDZHyp8Ixisy/pUXG
 mFb7CoF96CU9ZgesTlPqQoEHfmW+wkTENcObVPoVjBSPHQpjBv7zk095LsCGMAcBVTiIf14I2kU
 QcWMKFMGQASRKIpz1RBcZFACtk6ZuRJVx/ulUBQggIU6M4joERpPQdeV6Nl2b7TuslsYq9KAWzY
 kr8L54LFWqUVFbRiXKmB3U0j4rKFGZEkCHSLbZrew7M5Z8v4J1dv8+5f5wU3CtkGeddWRrPfrXe
 1ITpAH9ZUU34cWv98QDXKY4K92bSFRXh5qz5pwLVfE7Dsbsl08wM/FM3ymDq0sWqcXuZTwSxSnv
 TGS3GwAcI+vVAwdZhudI62XlHHPa0JhHEQfwVCxuh7nPlZaD4FdsxM/DaqyK+iOLj96yP08ppaO
 o0K4aJ/3HvvdLoLW7uIzjPwZa8K05VBuomu5uciKGFUmb8shMBBgkDM84xXqQyu9vQlXHQ==
X-Received: by 2002:a17:90b:562d:b0:3ab:884b:65a8 with SMTP id
 98e67ed59e1d1-3ae898149d4mr11444212a91.26.1793737020704; 
 Tue, 03 Nov 2026 12:17:00 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0944a0ff7sm485421a91.10.2026.11.03.12.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 12:17:00 -0800 (PST)
Message-ID: <f4ead73b-bc7f-4f8d-8c3e-2cfff7112816@linaro.org>
Date: Tue, 3 Nov 2026 12:16:58 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] block patches through 2026-11-02
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20261103035506.2688772-18-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261103035506.2688772-18-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 11/2/26 19:54, Eric Blake wrote:
> The following changes since commit 1c1f512972b25229d4b69ae7a3a7e5d7df30a6a6:
> 
>    Merge tag 'mips-20261102' ofhttps://github.com/philmd/qemu into staging (2026-11-02 08:54:24 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-11-02
> 
> for you to fetch changes up to dd3efac4c2416a38bc7f92881c2a1f6b3ec053fd:
> 
>    block/block-copy: coalesce write-zeroes tasks (2026-11-02 21:37:20 -0600)
> 
> ----------------------------------------------------------------
> block patches through 2026-11-02
> 
> - Denis V. Lunev: honor block size change on scsi child
> - Denis V. Lunev: cheaper zero handling in backup/commit

Applied, thanks.

r~

