Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29152C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHQS-0000Cc-6G; Thu, 02 Jul 2026 09:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wfHQR-0000CM-6z
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:25:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wfHQP-0003w6-NK
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:25:54 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493be1b9682so13364755e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782998752; x=1783603552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L62vL1euryObaQJ4CzJerOH2c0HGM8aUiyMPBkP380w=;
 b=JXjnlDJx+jsvZQxYufPQgMdp+Ry3n2jAG03z68AzzwHlTHWo+mvXz2lZdiF2N7vx36
 wRAuOqWPuWEf6lLIgo0b2kQF2S2TlXKXA8LC8Eh7y0b0rdmqvytO3bu3HJqayNfRLjvb
 3wHhNfjlIf1jbngoez7e2s3Nira/ow6LYx/3nIAo4kh/G7RMbBg7NJKf5XS3MxUF/8WH
 vhmImxTaAWR4K21ycMC4/HEdoFe5Lmj9uQ1hzB/VJaBUvMfC2z4SbOMG1EaLBdaeT114
 IaQ8YGHpEuC/uXV1DaEJrxuRIx9EUdLXoTSLyabVXLCtx+0K/owISIqx68fXKPsfk+8E
 ZOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998752; x=1783603552;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L62vL1euryObaQJ4CzJerOH2c0HGM8aUiyMPBkP380w=;
 b=R5EymgMxXjpMVjIEBeRgTiIHXr+XyBr365lRGEf8RIk7FusZeXYFBqILeL656K/yzB
 wVaWC33AV2Oj2qH+3lW/KTX4fkSV/v2+5KKRQEXmsUEpvJMzkFIg46fV1e8o/Oe+Tsvg
 uBwgizwcpmo+0OHXdqLMnHMR5bvLP284z+wAk34a1l9WCxt21Y1hVX5OOwY0N9Vwu5It
 5QLUOksE9A4bb0JqghYZFot/Uup1MN4c/X0SqJuqCG/Y0b+V9BknON5V9CrQ07EsKlzw
 h3aCHs4Tg4ubeXwh1WnW9Z2ZHPzIncna1RD0xVWMXkTXWrfZ5v0z4t0M0KmCQo2EA7Fs
 qJAw==
X-Gm-Message-State: AOJu0YxrvTwhU1D31Jfx52mHbYu2/6Dnd8vqckICd9cKhCUjmhRyYOby
 lw6gvKK3Q1rhPrCuB7XPaHyewoUlGm1LkMApxkcE8Vxuxet+pamlV8zbHW5fcdqukG8=
X-Gm-Gg: AfdE7cktbhPoc0iAK2g9jTTzXJUquCTUuQMOOuzswmFGCx5xcfo+hRaqaqiieC5wq7G
 lwS5C3vFHEDZDQMW98dfJmEWKYBM/dMXfqKtW6wZLF75aXLzhI0k2xUZGsOUNgTCwB9+MPOqsBI
 eUPnill6mPUAVjHP5/XWtoUMyL/sXhxjBxxOJ4uGhF8yS6a8A0yWUosjsq+bnKFIByhOQPQ+zwt
 BWR1wCvaLUHI/8jq3P60oMOFS3RjY2t8cIsyvyZIjGNwJUS3eRlFGGZFMQqSa8tEHCCafK7nUXe
 1a3eenUVAHfVY5/wk9vMzy7E8nynJTFC3U7nlRbtYbkRMWzC92o8bUfi6a//XtRdTB/URHLXKQM
 QVGsZMrDFYI9RtIYR4zI7UjizlRmTVcS2jrjVoSRGt6I5NxGq5/lExwUBJu6sVH7yVWAX/6aRyH
 ohsmr/3dGHEnoO
X-Received: by 2002:a05:600c:5010:b0:493:c453:600f with SMTP id
 5b1f17b1804b1-493c453616emr52830535e9.6.1782998751951; 
 Thu, 02 Jul 2026 06:25:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6372a31sm53855825e9.13.2026.07.02.06.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:25:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D409B5F89F;
 Thu, 02 Jul 2026 14:25:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Xiaoyao
 Li <xiaoyao.li@intel.com>,  Chao Liu <chao.liu.zevorn@gmail.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  qemu-ppc@nongnu.org,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 06/33] gdbstub: Add trace event for STEP packet handler
In-Reply-To: <20260630220100.1289-7-philmd@oss.qualcomm.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 1 Jul 2026 00:00:33
 +0200")
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-7-philmd@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Thu, 02 Jul 2026 14:25:49 +0100
Message-ID: <874iihtteq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub/gdbstub.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 26366acb674..246e7746300 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1369,6 +1369,7 @@ static void handle_step(GArray *params, void *user_=
ctx)
>          gdb_set_cpu_pc(gdb_get_cmd_param(params, 0)->val_ull);
>      }
>=20=20
> +    trace_gdbstub_op_stepping(gdbserver_state.c_cpu->cpu_index);
>      cpu_single_step(gdbserver_state.c_cpu, gdbserver_state.sstep_flags);
>      gdb_continue();
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

