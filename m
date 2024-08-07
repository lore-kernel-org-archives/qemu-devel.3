Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C6CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 05:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbZQm-0005xs-96; Wed, 07 Aug 2024 01:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbZQj-0005x1-I6
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 01:41:49 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbZQh-0001VW-Lo
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 01:41:49 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fec34f94abso13875165ad.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 22:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723009305; x=1723614105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T3w+2QId1ZQyxO99JnbH84QOnL5R+4JsK0mgPwR5poI=;
 b=LvUiEgVdkvg7HzN4hhp39nH0noFxgEri1CBUi2d2b9kQkPlS4qguRQXxc8uVm7EgQ3
 IYy+jrgRT3wBCo/X/3+pyAXPQPEOv7haq2LJkbDYEEPi3QjV2dtKvU3yRBHAkIPkdQSp
 wNeqcxu5eA90TO9NmCzvkEToHYxwi103/w6IgdEijjv0K++bR0vz849WSYunVD6NkrjB
 8tqPe0goamobQQ/+QlMbjfNlt0mK9SWdpMzBn3i44fy8kXP8TILtkgTP44CV0AbPPt4Q
 /GX+d/aE+3PaQMAPcNE5dCiub4K53DLhb8dMFDASjV4bBiG1qhkggeW1xLN+xFYVSg0K
 tNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723009305; x=1723614105;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T3w+2QId1ZQyxO99JnbH84QOnL5R+4JsK0mgPwR5poI=;
 b=CIxAYgiCb14czEIKxgFXG7aQyg6jqLHnoOWIiCHGEIKEaAuKritO+53ZldB+bw44mp
 9MLO/upPxun/NJ3kuTDNbY+I+TjVxJO3NEnv4Zt8f1IHAG5oo1MGVuotQ8gDSvw81J8K
 HQXTSS1fHxOsxW4cfRkv6Vt/jM3+G/nynGI8UYfBx6ipHgXqR5X+4zkEqutty4U57G2t
 N0GL38DNVGZzl2Y4fq2sspmfY6q3E0nNyaa44o/RnTKEW9c80SS77NfDdDlGDIoIXscK
 WEwvZZk5FmBrjEA4VIsMunwfC2x/RLk5TtxADhv5dt1fvIzGEY8WnAfK3WxAtpuYQNNL
 A7KA==
X-Gm-Message-State: AOJu0YzDjPPsweeZZSTZj0+V+PZQ+78qnCiiVKYbCwe+BI6LOcVzipYV
 CM2Eqx/LPffG8Ug+i51MiK+CCpMCrtCRdLhGfAqqKrAp1ppUmucX7riPezCfM1f5BEs6ZidIiVZ
 SoO0=
X-Google-Smtp-Source: AGHT+IFhS46imipa2Mq5k59hEhWhvgNDV7BVRKmI5NIIcsSjDVoQPwRvoxaNRNKPVGQflkHuQnSSFQ==
X-Received: by 2002:a17:902:ce91:b0:1fd:96e1:802a with SMTP id
 d9443c01a7336-1ff5749b888mr174730955ad.59.1723009304579; 
 Tue, 06 Aug 2024 22:41:44 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:a5a9:fca2:ca83:cf2e?
 (2403-580a-f89b-0-a5a9-fca2-ca83-cf2e.ip6.aussiebb.net.
 [2403:580a:f89b:0:a5a9:fca2:ca83:cf2e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff59058512sm96785135ad.135.2024.08.06.22.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 22:41:44 -0700 (PDT)
Message-ID: <c119648c-179d-4332-a658-8ce5153e1dea@linaro.org>
Date: Wed, 7 Aug 2024 15:41:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/i386: Fix carry flag for BLSI
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240801075845.573075-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240801075845.573075-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 8/1/24 17:58, Richard Henderson wrote:
> Fix #2175.
> 
> r~
> 
> Richard Henderson (2):
>    target/i386: Split out gen_prepare_val_nz
>    target/i386: Fix carry flag for BLSI
> 
>   target/i386/cpu.h                        |  5 +++++
>   target/i386/tcg/cc_helper.c              | 18 ++++++++++++++++
>   target/i386/tcg/translate.c              | 27 +++++++++++++++++-------
>   tests/tcg/x86_64/test-2175.c             | 24 +++++++++++++++++++++
>   target/i386/tcg/cc_helper_template.h.inc | 18 ++++++++++++++++
>   target/i386/tcg/emit.c.inc               |  2 +-
>   tests/tcg/x86_64/Makefile.target         |  1 +
>   7 files changed, 86 insertions(+), 9 deletions(-)
>   create mode 100644 tests/tcg/x86_64/test-2175.c
> 

Ping.


r~

