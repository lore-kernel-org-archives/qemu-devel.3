Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA783FD7F95
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 11:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvwHs-0008PQ-BY; Fri, 27 Feb 2026 06:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvwHq-0008PH-3r
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:45:38 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvwHo-0006aV-Fz
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:45:37 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso17243825e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 03:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772192734; x=1772797534; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PkEghKeh7w2aX08/FJav/D9oW5JURKO2hS+iPxWHQIM=;
 b=hCDMct2F/XpjpVyvhyRtmnFwSJfbnh9CeaWkbtte6QQi24hR6+NWG9SSs94SE+wO8B
 1PkOQS7jBxWqm8E8QtlBoitJ1IcyQKM8/wQmKfw6MJclNQhE7EiWaNHLQPVoyHuKa9TM
 vTZWHgFDNReQsvvQ28e3y2FZRS2CrRzs6wLFDhs9b18G2R2EYrK0waOCnNgz9bkeep9A
 QZCA9pEX2xAQy+VJk5jBOEYBrvvH3nPsJ73FDd2YENPEkk+79yMQKaFhj2IL8l4qjhIZ
 6ErzzvsGojK3QTqgULChNQwk9Ww4UoP4KxQVT5mSH+rUkzi4PcgEhe1MySVt8WtAZs9g
 qu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772192734; x=1772797534;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PkEghKeh7w2aX08/FJav/D9oW5JURKO2hS+iPxWHQIM=;
 b=rTbN9DlBkRq7dwrY+0Bss7x9stzq1EOWxBUlScpuvhD3mwQJdAW6p87tKOe+awMMEW
 EfCH+lR5XHERpuT8OxOW45a4kqMMel68i5Xksm1o5vYxPF0VUyFFghTJop+1/b/uOf+o
 C+NbQukW7G8cyUB+u7O+/1FDppJr42Ssewe7QweCwoIFypI7+RQHpgagDJUekKx4GVzB
 DTibtNvJDD/xyWs2eacpSaB5ZqRPGAXnoeaZ+A47W/EKPBCkURnyYjTDWNrRsx0oTHDL
 2K3rVNL798tjcnPck6mqiBrbYXTFYDLIIEDqJsVJ7XLAWHnOw34W8eML+0bkthqrBIhP
 /2KQ==
X-Gm-Message-State: AOJu0YwNTFIlUzUAHe2lqcysGUTNkcEMz/nsibAXcRxHg9FB84rtM7SJ
 uCCRbs+smwTkwvhnOtD6LmZj90eufDXy4XYHW+FdAwvDe1rz/uqpJ5gpYF67kHzoN/7ulng31dY
 Kor4+
X-Gm-Gg: ATEYQzwO2sPdo9d5Oz8lwnYFrrwxw4/3S9F/yFvkaj2F7maXp9UiQNwvLwJKJ4/rVH0
 ROtx3Mo1c9Ijlr0BPufReGx/qNiG9oenKgP4tOOcY9riFWC9+7lLExtbxBL92/xmSqoOrUqk9jG
 bSZC96RIXxoxiJ80MV4TMkBoIxDqnhy52P2Te5rAVT9BojOTJpaSOwcP/hKtk9tGElfwkzolEeP
 QpqGh+MoDxu3ShD74Lx7zceAymi9K+SULMnRgoNE9HnxNUbJMfDrT9ag18bOfmlwxu4wGuSQqBl
 hE2cuv5vL/6jyJTcp2RjIF3jY/AHw2agbmovun5n9ZrlJ664rBRmuBVKGQ2vmh5YBdJbUaUUHNu
 R3JOwso2huvAGIrcEAeLUpdyT0WCjqfanT2vYzGTqMRpW3WWdvrZr3CYitBDESqUd2T/gFzgixi
 h9tqiMNYxiMRPIF0Si+yE6RItl3w3mXfK7RGI=
X-Received: by 2002:a05:600c:45cc:b0:480:4be7:4f53 with SMTP id
 5b1f17b1804b1-483c9c2d51fmr40343475e9.31.1772192734118; 
 Fri, 27 Feb 2026 03:45:34 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:c790:8bcf:454b:dbb3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bffc17dasm106977495e9.2.2026.02.27.03.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 03:45:33 -0800 (PST)
Date: Fri, 27 Feb 2026 11:45:32 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 1/2] meson: Restrict gdbstub to user/system builds
Message-ID: <aaGD3FRwRW-H3Ex-@linaro.org>
References: <20260227101040.70763-1-philmd@linaro.org>
 <20260227101040.70763-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260227101040.70763-2-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 27, 2026 at 11:10:38AM +0100, Philippe Mathieu-Daudé wrote:
> Limited builds (tools, documentation) don't need to generate /
> build gdbstub files. Only process the gdbstub/ folder when
> user / system emulation / acceleration is built.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 3cd1d8dbc66..60415df69a1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3724,7 +3724,6 @@ subdir('qom')
>  subdir('authz')
>  subdir('crypto')
>  subdir('ui')
> -subdir('gdbstub')
>  if have_system
>    subdir('hw')
>  else
> @@ -3767,6 +3766,7 @@ if have_system or have_user
>                           output: 'decode-@BASENAME@.c.inc',
>                           arguments: ['@INPUT@', '@EXTRA_ARGS@', '-o', '@OUTPUT@'])
>    subdir('libdecnumber')
> +  subdir('gdbstub')
>    subdir('target')
>  endif
>  
> -- 
> 2.52.0
> 
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


