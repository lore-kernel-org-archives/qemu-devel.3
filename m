Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C27C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzsMV-0002Vh-UE; Fri, 28 Aug 2026 04:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzsMU-0002VW-4b
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:54:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzsMS-0001oA-OT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:54:57 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so5042845e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787907295; x=1788512095; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xdIse+755ESEtXAf8FTGrtnACDo5SMWBhg0NlB1V6wU=;
 b=Va5Sqqlz9nT0qFVwVllmItvoLwTLEOI2X7Z9IYfPdpK9a4l+JNy/Gmchh2p8S/sVa2
 zeI3pc3F5TqxcU51o8p2lfQbE5iHRn5eRjzS4eEFQAD0fir2W7S0WkVjpEvaM+2PSEv4
 oV3JM71+sCupUyTLWobrC8FjCgRpF+KmQPzdjnKa1GejvsLvR7MM6/pKIu4lYCeH8lf2
 UqZPqI35bZmtwE+9yUpD7E0WTirAhxSXzbraYmU71hV4M2t+Y30HDl0q1M3FWhUJwRNm
 J4vCdjoj03AsSdZhnE2HAUen1g7oW1XVgO6b2TzRCi6UlhQ5ZgBwpOG0Le7H1+JwnmsP
 cpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787907295; x=1788512095;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xdIse+755ESEtXAf8FTGrtnACDo5SMWBhg0NlB1V6wU=;
 b=YmrDrtcuHvips9bSX52SuExkdxgFg9FIl7B4wtSHU8DxgkQz4AFbtaowdXdwtzf6Am
 ckjeLGzFrZg6B6M3XxRM6D+HmypImVzvBwHsqRRO58qHCg9RSA6Kcy+iWgLoTeLOWXFc
 wSDCPnTWIv+NoGMYvmlrbZRmmbDZyJBYmXowH6f62WA36XZeCjUNWCJBU1uH7CMEmI58
 kIfOJLRH8Pd376SCPCr0YuhFmhb3xLcyvgmICpONgfc5+48bsWyzz68csMEunTRkpj5f
 irfCjvJfWTjKiXBHDLSG1XxFNVyuG8YQsdr+NF9iVHOOWVLRJzyDh5W0TZ8j7CYkGxsp
 57Gw==
X-Gm-Message-State: AFuF++khzPga9U8rgCoFkzTPqClhUJjTZBRQ56IH1UioaCgN9RqOYjGp
 y4CMVushbg0bcyfGvMYhquabTy5E93EGwu58tbExnxkcO5iWNFulgzi4CLRrOcohtDE=
X-Gm-Gg: AR+sD11W/Yn6bpYDV+3la1XRapBh7fno6qLEWwA1YbXWIPcRnuNsRzVcMxrNsVf+qLC
 ksXBAgJpbE8NARtgdqV6Tw+ZM5Oj7O+sTl4hlFhkWLBLKmL4rT13NFLoiStjCGnJWuz4Cw7rn3I
 RIwOUwLzWs+AizZ1AfXEwZBTUNWzbC4Y09urHH4l4ds0I8yWtYgSk8c1zJ8MEwHku4Ux6rsr49D
 3AVS0aMktBCmQ46kLc2T4phZxe8wk+suYJzAGsmESdwuHgfHFblkZMEgwRNzVJPIFz70R++nO/2
 Wucp15QdU26bmdiqcTw6bLaUyJr+27GlB/j4SzOW3znWxKwp0/ucIMCDvv1VO8MlwBla5tLAkho
 /+nnVbItiv+mML5rU8B74dERilDanUKKn+iUWsWsLzFT6S/a1eXmDAMXh/HK+52xWmw5uH89WK2
 GHq00b9c1Lwgqffcpsl8EHSfzp3x7bSA7RKxX8zojLe+zjJQvTRDDjL5nZuqH1
X-Received: by 2002:a05:600d:8498:20b0:499:dbae:86be with SMTP id
 5b1f17b1804b1-49b91c4de9bmr58380555e9.14.1787907295245; 
 Fri, 28 Aug 2026 01:54:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9267c369sm28402775e9.3.2026.08.28.01.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 01:54:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7E6B75F7E6;
 Fri, 28 Aug 2026 09:54:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Stafford Horne <shorne@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Palmer
 Dabbelt
 <palmer@dabbelt.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>,  Helge Deller <deller@gmx.de>,  Max
 Filippov <jcmvbkbc@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Song Gao <17746591750@163.com>,  Yoshinori
 Sato <yoshinori.sato@nifty.com>,  Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>,  Aniket Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v8 089/105] tests/tcg/tricore: system tests
In-Reply-To: <20260827221506.91574-90-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Thu, 27 Aug 2026 22:14:50 +0000")
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <20260827221506.91574-90-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Fri, 28 Aug 2026 09:54:53 +0100
Message-ID: <87cxv24obm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

