Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D46CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFra8-0006Q7-SN; Mon, 03 Nov 2025 05:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vFra6-0006NU-7A
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:14:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vFra3-00033B-Go
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:14:33 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-429b7eecf7cso2921168f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762164867; x=1762769667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nFg4r3tMVKZIK8gQcRSUk+riie/MEfDxMbtm0ctoTmQ=;
 b=ukqhLHfo6isAywR6425dOsEE3wv5uqX3ynHcp7od8ZZVgUoMv3r+UAlNiUUgohbmAI
 knrzyU/BHtj24br/RkD7jGUGIFK2cpf41p2LymZGO/HxJYV/LAPI/rYNrHfnuEutP19b
 K02vQyhU3nui8O25fys3SY/iwgISWARjMCyKd7UlqkrjXooF/22klPUWwGa5WjNo14b4
 yu/luMljEXDlLQ+R7djuzIx+G7m8IkJi6LCVDzOSu47xy4dbYPDbf88sJ4VVIVE9moQv
 9quvT/vOjc2qq52Tv4+vL6vHCqJCSZ+4JV82Cp9VifTxMbM6PPPtUgSwv2hW2a3kF14r
 eoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164867; x=1762769667;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nFg4r3tMVKZIK8gQcRSUk+riie/MEfDxMbtm0ctoTmQ=;
 b=W2ZwzdqJhVsghrv4gpq5HWHld13SRDGuo8yvNm5cBXfGD0xpV3IQsRzSDNLIpdb6N7
 ntU9BiL5Wh7Qg3doTktncKA85Uc4ZupxHaiXcXcWl2rESBO3yYB6aQ5HIcoLk/QjrUQ2
 nA7mbr7NdjrWUeoNBzV2Mlrt70T+YJCiPlETzAoiRFs7OaSMt8/K3ibdSBHpvDV4ThPQ
 kWLFHaN6lDnn2TGJoC/9L6Y0qF1iGta+1jyR2Vt7yrB56/oKFZnJtIx/XlBY9Tk0EGoI
 MeU9WnJAafaktIjGpeGj0Y7jieShp+Epk6bx0y0DowenoV6gSHLFW4mWGiPqPY4SO67Z
 79bA==
X-Gm-Message-State: AOJu0YzKDMQD7MtMrG8BtCBGu6uwTZSXp/2OxvHKGdMsd0Hl18a2Q2sO
 6dWT9TO7+Rz1BgTLKqRzmUjBz2SnFwJBvhjqSc6vewJN4rJK4p8MbWaUUVmNOQyGIth2OdQjhzS
 G5Gz/XFw=
X-Gm-Gg: ASbGncuyGP9BQFzNA2FjV+ERenpOR6mPda/AyzAiTBwSGRSYi3XQy6TfaYL+mLWrUGN
 H9Rmnn2py6jwWiSdyn2B6MKEX1GnmFSFLx2TluSNh7hcgRGp3Ckcpit1uoNych8wfqgPqdjHlfZ
 8sqI8QJHer4zeyLvPwzisiEK9EUJjSSBNr0LjS9AuCNEqrwWwjMYkCxD1l9KmOmrUHoLA+lquiJ
 hf0fjpxXlxzJ5MxXKXbBnkg9MK8RaxEjUhQHi6gYva1pt+QrRtl58Yzo5XJy4cSA9l93uxtRpL0
 8wwi6t29IuollGTK0Rz+8fehKXdNIEIKiSNmHd3K2IwaIIlCgkWUA0MqoIKm5Lq/OL2YkH4TKpe
 rmviA+oTP2gQjBqC1FwRUyA+TmUcT9LPJEuAJb1h6gnGyxYzzFURa4HQEyepfmnH4MNhNiLYZLP
 n6zaK1lGS6sBfVVjrMvBnnnIbGIrSQrrgnSPePw8zQI4f5opZomS0Q3Oe4zg==
X-Google-Smtp-Source: AGHT+IHvZX1ftc2CS+U9dU84N9FFPpIOGr3q5yl3PHs0abeg5NE14ngFB03hl6nlC6ERhhjITBuM8Q==
X-Received: by 2002:a05:6000:24c4:b0:429:8d74:4b16 with SMTP id
 ffacd0b85a97d-429b4c81dc6mr11991678f8f.20.1762164867105; 
 Mon, 03 Nov 2025 02:14:27 -0800 (PST)
Received: from [10.240.88.227] (34-203-142-46.pool.kielnet.net.
 [46.142.203.34]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c5e19103sm16367206f8f.28.2025.11.03.02.14.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 02:14:26 -0800 (PST)
Message-ID: <251b3f79-a2fb-47f2-b8d4-c4ea98aa3568@linaro.org>
Date: Mon, 3 Nov 2025 11:14:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Igvm 20251103 patches
To: qemu-devel@nongnu.org
References: <20251103084201.45417-1-kraxel@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251103084201.45417-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

On 11/3/25 09:41, Gerd Hoffmann wrote:
> The following changes since commit 53b41bb78950912ba2d9809eef6b45e4df30c647:
> 
>    Merge tag 'pull-target-arm-20251031' ofhttps://gitlab.com/pm215/qemu into staging (2025-11-01 10:52:48 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/kraxel/qemu.git tags/igvm-20251103--pull-request
> 
> for you to fetch changes up to 541e7a2d987cf74bc1931bdd99d64b27bc9f335b:
> 
>    igvm: add MAINTAINERS entry (2025-11-03 07:38:53 +0100)
> 
> ----------------------------------------------------------------
> igvm: improve native mode (non-confidential guest) supportY

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

