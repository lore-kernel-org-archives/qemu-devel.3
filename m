Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B57FC28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfFh-0007Ep-1k; Fri, 07 Mar 2025 16:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqfFd-00077a-8l
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:29:02 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqfFb-0008WO-OJ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:29:01 -0500
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6e8f05acc13so22758476d6.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741382938; x=1741987738; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mSAQJ1vKyJ0QCykel+IIhAmjouiLaGgh/DQ/JMfu1FQ=;
 b=IvElSeUWyNNa/6pP4nTDinvEucHeCng19VaZo7FLmDMr3dzU+cwle85sdaKxOnPQV2
 yUyuzDBFRWzfRzw+ZQCH9uMMbZ8DvaRwwt7fSx9NXB3tJzXR2k6cSea69FBMIqtP2W8/
 8ubFWyJZR+ml+UuM+ubWnashMNuHEQ/n+Wz4oNkx/7Sqak/GB7UeaWCB3w+2fU0o9gQk
 gfJPMDJktXRDL+x0JyJlT/6YI5T//U26O83GxJYBYma8vCGLujjHOUKKQH/DhH2kJzlC
 H7TNkm72DLrbtCiVfoe+LAa2snHxtbAn0P2gk6KPYBUw7cl3efa9ruDL6d1uZoZh1JsP
 n8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741382938; x=1741987738;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mSAQJ1vKyJ0QCykel+IIhAmjouiLaGgh/DQ/JMfu1FQ=;
 b=urCBUOq+3TA0yuGgx80Al9dtAZDTGjiSH1ovsyVWyPyknBLWNXp3TXHwoihEueG14y
 bWTOTFJFKeNBT1tXOJWUFbdS4C20eOaUyvKh2EF1n9EdKPC3485SUJSiuN4GHWWkana9
 5mrNzGePPTcjiwwg+NgHGw+M0FWhWYySR4L71lumULo2DLF3R7td3Fbyw8Ys3iycKcyS
 LVJGvIS1b+PbtHAXeoDFn8+OMlhknfODLbq9HRtC/goDzbbsS73DW+I7KNYR3P/jJW+w
 rSbCpaPsBLn/gfrEtbhtm4IaQKpvTJPUwoBqSxVVelwZgxMk6cuswT9o4o0JFcUEPHwb
 YFBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX73u7/V1S2s8MSM0fa9NLxGhAn1Q7m6fD1GNhJ7jKmWO2wUt37zGzXSK3y1yW3mKEBYju9DQZ0eQOc@nongnu.org
X-Gm-Message-State: AOJu0YxOa5uX3j3zXGP6af5pghkBIJHtVl6HrbPUOWLtB5qz/rS81M/P
 2g3Doj8ICSyJZo2S4Xpcx7f+yiIHh7iI0TG9+jcsLjfgl7HRyEsL
X-Gm-Gg: ASbGnctQCNznq//jBvrYKb0yWXk1xn3SvA1aTve+R1i9MDs+OQoloVEZi2dptinn19S
 DXYGUJNXuXe8i+IX+falZZ+1B3AnfPhhp7YAtnRQL9UKKSPM+vE/KJyWFEtH5fpZYR6vPhOs1XK
 W3htXwNha4+Qjomu4Dcwoiq4iGlNoVcgGsjffd8d33ZRunDNNZCQhBau2ALUZbp8knCdGlCrkKt
 2RFuz8xOr6P0CrQYeIszsW+FhPzv1jhZQHO27FuTVzmCgMMsBuCg1omIh8VuprKrM4MPPTq8FNe
 6SB3+i04XaCrUorA5kIjR91XYgRJKjdVpcvBYhud+Zn4CkYMyO9MWlAXSTg+o7c=
X-Google-Smtp-Source: AGHT+IFCQQxC0KxZ/p9IlGfoLP5BxGIgVBSWWeIiRhjjlwlm0HgcQLp2iCmYembXDe5Okne/+d/z+w==
X-Received: by 2002:a05:6214:258f:b0:6e6:6598:84c1 with SMTP id
 6a1803df08f44-6e900692cbamr65331816d6.42.1741382938520; 
 Fri, 07 Mar 2025 13:28:58 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:8188:4e08:c1e3:fcd4])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715baaasm23506896d6.85.2025.03.07.13.28.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:28:58 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-21-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-21-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 20/38] target/hexagon: Implement do_raise_exception()
Date: Fri, 7 Mar 2025 15:28:56 -0600
Message-ID: <02ab01db8fa7$efe738e0$cfb5aaa0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgGOJ++8tPAeNUA=
X-Antivirus: Norton (VPS 250307-8, 3/7/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 20/38] target/hexagon: Implement do_raise_exception()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c index
> ccd806836c..1aa5b32b1f 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -37,6 +37,26 @@
>  #define SF_MANTBITS    23
> 
>  /* Exceptions processing helpers */
> +G_NORETURN
> +void do_raise_exception(CPUHexagonState *env, uint32_t exception,
> +                        target_ulong PC, uintptr_t retaddr) {
> +    CPUState *cs = env_cpu(env);
> +#ifdef CONFIG_USER_ONLY
> +    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08x\n", __func__, exception);
> +#else
> +    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08x, @ %08" PRIx32 "\n",
> +                  __func__, exception, PC);
> +
> +    ASSERT_DIRECT_TO_GUEST_UNSET(env, exception); #endif
> +
> +    env->gpr[HEX_REG_PC] = PC;
> +    cs->exception_index = exception;
> +    cpu_loop_exit_restore(cs, retaddr);
> +    cs->halted = false;

Shouldn't cs->halted be set before cpu_loop_exit_restore?

> +}


