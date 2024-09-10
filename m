Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45BEEDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so55U-0001GS-1D; Tue, 10 Sep 2024 13:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so55S-0001B8-Iu
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:55:34 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so55Q-0006EU-SC
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:55:34 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7163489149eso4763662a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725990931; x=1726595731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0PB7ZPbAlPULvfWvBp6OEDUYHJfTjrkqlqfAUe+t16I=;
 b=sYtAd5As9gBk7wmlqRCrOKSgLUjc1iY6TJGKixOe90EnwQuBBNox9wnWZNXD9AsEeo
 wLiunjdN0tGpz1oBHMWBYaf2leNHIFqDYezFUin3YJSp2gy+Zkfus4Na71jIc93ueFS0
 PdhlgHiRRfUBKhppUK8eDTW9/YR1SbOee5FXySyfLSwTBs2pSmF9kMNVR+NU6Th923X8
 CE+GoncYxR8T7gFvGIDLHVK9k5lhyJAhZuRrGqN0N3zMigK6zq6Ua50haH5DD/7u1Apv
 wU3Fx12Nf3tLHiWmcrAJLO8JCL49sDNBUTdT/iWjVNUHU0KhVIFTEOg7N9G+1dHJ1FsI
 ZRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725990931; x=1726595731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0PB7ZPbAlPULvfWvBp6OEDUYHJfTjrkqlqfAUe+t16I=;
 b=SJ5r66lOzgOCDIf0DLdlQhZHutuKPtNwv4f7fCa0vTlhXk3CBeAH2+YU2D+Hm0WGfN
 ySZy+f7bXSKBlhn0bV5y7hvIZnMTl7kwa5E37BIiAQ06dpDciUG523zfpKsEM170+YCd
 Bz0ba6z7qVpf815YrcmhVLdV0fYO9MLsaH+oTvBnsg6Upn413urMQJH5DKfs1yxfCWUZ
 +/VTNp7w/4zGaur23a8R+N0517j6PmKVwjNU/umF/Uiqx+kxs8V/f2RCHeRINJJyrStL
 o+230OVW92hlENBpoK+SrAiYi/nDZodr0HHzzY7KviAsQBGE21Ndicj9LFCdN6TvWkXN
 Ri8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkNzUxZWx60Q5X43XnytlHCFGcS9KY5w29h/gAuOQdd6dVtZpG+Kc5Fh7DRcqEOaB8at5vOSVAVBqH@nongnu.org
X-Gm-Message-State: AOJu0YzMrt0DddOM15RUk2SMFSYNhQ5nqFYaaNFRl4qwcRXwEOZyQ2El
 S7EyuP1TbkIqzuLRCzqc0JA+2GQnv4NbWJK3rWohAr/wjGysSig/ypAadIwUhgU=
X-Google-Smtp-Source: AGHT+IHwyvZzgdcmP8NDhfAoUhuKMu1HT7IiP9QherWRdqfKEoe52HN2Cv83ba8hCgyHtDnnLQR59A==
X-Received: by 2002:a17:90a:ee91:b0:2d8:7182:8704 with SMTP id
 98e67ed59e1d1-2dad50cb7e9mr16044398a91.31.1725990930411; 
 Tue, 10 Sep 2024 10:55:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db04136bc9sm6748225a91.1.2024.09.10.10.55.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 10:55:29 -0700 (PDT)
Message-ID: <64f15c58-e960-46aa-be96-d6c2dc760933@linaro.org>
Date: Tue, 10 Sep 2024 10:55:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Fix bad usage of has_cmd
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240910075820.51346-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910075820.51346-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 9/10/24 00:58, Thomas Huth wrote:
> has_cmd returns a tuple, not a boolean value. This fixes a crash when
> e.g. "tesseract" is not available in the test_m68k_nextcube test.
> 
> Reported-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   tests/functional/qemu_test/cmd.py       | 6 +++---
>   tests/functional/qemu_test/tesseract.py | 3 ++-
>   2 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

