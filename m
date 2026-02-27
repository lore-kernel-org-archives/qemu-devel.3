Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF45AFD7F97
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 11:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvwIY-0000Vg-AE; Fri, 27 Feb 2026 06:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvwIU-0000VG-RE
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:46:20 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvwIT-0006kb-HR
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 06:46:18 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43994aa265eso1157603f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 03:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772192776; x=1772797576; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LrKxCNju2kfpIBaZEx7Fk0b+gCWV8XoZT6Wm8OO/Cdk=;
 b=sswsontbBxrqV6pIoj6lTm33hi7vo7CHX4SbZ53PR7FLQYq65jaeUEPUmcqBLa/2Eu
 mSO/JOuKVklJQ3slTH7n4pLqZwZNLT1qLuLYlWe34XkwJLvH2mawp09eyvcMRwSr4MyR
 IqULLn05FEyevqkaav9IkN6fS9wfSD3wh0XpT8h5eNLChBTJh84ZJPQz9o0hsloo4Ulw
 pHrH3hB382VmzXyksryLcVKoDCNGxrrCw+dGjY3ru9s7VugjRoWDJE9txxSphuKr/3Ur
 emL4ko5MFCXi758RiFBDWls8vW0kXrcMmGvxf9gvNTC/whielHulTDDDSWrvQC0WzM4I
 ajhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772192776; x=1772797576;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LrKxCNju2kfpIBaZEx7Fk0b+gCWV8XoZT6Wm8OO/Cdk=;
 b=tgBMxHtMY+2eAWH/LOMBJxaxP4G7x2qlKgokd5qYyCD5q35NbZq4WDY4CKduoNDd6I
 qMP56fd0YrF9Qai4Q9k02PUYQ0NY3DsN/eoXJVqpX5YRYzC9HphpUA4TG0IrMHXfpVZ3
 CnIH1RM6mWj/xxK16MOuKcVT3gWrkGgLMmzmIqld8Y9jNS7+ukwYWw6gwujEs2eWdqDV
 3Y7o7BAD1OhR5EnolkoOTb7QH/6rwRXWXnR9KojMwyL7yGxJU0EKuBJhqE2D0xPWEtKT
 FohkzdXwQmpYIZhhTuVtKClpQiBMsyzWCZxNS0QL00CPTaVoGzXUu4uELbFzeFQlMlzX
 nw1w==
X-Gm-Message-State: AOJu0Yx+ODwgviENSqV+x0wGtc86TDLM2odPujl8qfCgaQrNoZiRq95Q
 GR9UzzWgzhOkns9pdjmiR2zLnOOQB52C45gf6KAvWLMql4wfy2a8XEAT0YAPkUYMpgRdiPbwN3b
 pWIkq
X-Gm-Gg: ATEYQzyNbMeLouyqKWwkF3JA0PRDfIF7Qt01dOaT/vAMT2FLP2BsUb+r+sEJ86+X5hJ
 fu6EPebfUoiAK7+m9SHhBKFYxBfSAFuro1XBxA7y7UfXsULMXyNnrHp0A1Wpat5P6Atuv3nUeuG
 tqeG+fQcZ2IC8MbEXB9QPeDzAbeR/1eP/UfakM0XZvv8EkDlCXlVMMR14x70anAV0HyHN0697HD
 0S/hZu2VrltdBXlz2iU6o60nJb8Fp3RbBSBautjw5Aam1xlow73sLtahqzaZcsggCsub8vK9EKs
 A1KLqLgqL9hxwXFQ7vFm2CPR6WmCpWR4iDkyOr2H7T4DW2FeOZut9r6e6UjHe92Z5mkgf4QDjYX
 bAIngVMcC6GFhjSfbmkm6Ktn/dIJMbh8PTKAaxSaF2e99A6jB+nxdYhI3asAsGldEc5SFtR5s/E
 9evYGyPiciUcvi58BgJtthWfwZWw==
X-Received: by 2002:a5d:5f54:0:b0:439:8a14:ba2c with SMTP id
 ffacd0b85a97d-4399de20554mr3873321f8f.35.1772192775930; 
 Fri, 27 Feb 2026 03:46:15 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:c790:8bcf:454b:dbb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c71b498sm6375587f8f.15.2026.02.27.03.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 03:46:15 -0800 (PST)
Date: Fri, 27 Feb 2026 11:46:14 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 2/2] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
Message-ID: <aaGEBp6IMZwEllOW@linaro.org>
References: <20260227101040.70763-1-philmd@linaro.org>
 <20260227101040.70763-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260227101040.70763-3-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x435.google.com
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

On Fri, Feb 27, 2026 at 11:10:39AM +0100, Philippe Mathieu-Daudé wrote:
> gdb_static_features[] only contains strings, nothing target-specific.
> Instead of generating one file per target, generate a single file
> with a single gdb_static_features[] array.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  meson.build                               | 10 ----------
>  stubs/gdbstub.c => gdbstub/gdb-xml-stub.c |  0
>  gdbstub/meson.build                       | 19 +++++++++++++++++++
>  stubs/meson.build                         |  2 --
>  4 files changed, 19 insertions(+), 12 deletions(-)
>  rename stubs/gdbstub.c => gdbstub/gdb-xml-stub.c (100%)
> 

LGTM

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


