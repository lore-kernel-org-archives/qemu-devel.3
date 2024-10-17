Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739B6D21262
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 09:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1MrQ-0002U6-14; Thu, 17 Oct 2024 05:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1MrO-0002TR-BT
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:31:58 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1MrL-0006Kv-0E
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 05:31:58 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fb559b0b00so7417561fa.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729157512; x=1729762312; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tSUmQ+5UahoSL7J+r+hrCJZoKTaSjN8KDYFOwxiJCEU=;
 b=P5fahgx6oBiR9KAHWn4E+oLUnQMbboRs+yx8AF/xnut3e4tgHcD4qZYvIxCMSz1UgH
 w18IPiD6+hpmD6MZ85/5pKAu0mk3wH3+XcTbjaZnUqOa0cvsxkl1gK+CxkwlFjRU+sty
 xqXIINO/OXnkaMp88CCuqoAOQc6MnPUWq5dvGMKz++zeBtBZQpKQmHW5Q/d8a+Dizkss
 cqVQ3cHFsprU/R8tcj0WpuXrtvmAI4KwDCv53mMiKULflunb0uza3uayJVh66lnqMysq
 fNkwiOH91qJI9H1DV+cKX/19FqTdsAy66CmUd6olKfuD2bbS04nCG1LEJASgKji/RcPh
 Pp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729157512; x=1729762312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tSUmQ+5UahoSL7J+r+hrCJZoKTaSjN8KDYFOwxiJCEU=;
 b=LwSKnHpSVzw3OATW9wuv3VHRSZ6f43OLZJgm08CLfexYGm1lTeIdqy1ZASTZmWBUPz
 07YPGa8HORp1OogL7LFIlJYjH6DR5xlgmBxuuStBtQ0Z+2ZVRfPUx7cwbx6/mVFJXzs0
 hp2INXdiq6OFLzz5s50hf3K4+3sEUdJe9DuyCw3WsgxWwQmOR5QiQ2Xv7NmO++NqElWT
 CnHbbP030Pd1AyCFYcLZgwl4p8AgLRN5U4MH64EO6u6kkRcdI9JxijW5iJ/xsODIbM2l
 8O+sOlxTJe49vEfWRxiEN1QWfDmM5gUejCIbk7zT/EcMWzPTyaLK0D6zVWNtu7d4kVfh
 fODg==
X-Gm-Message-State: AOJu0YwWyg5aWrB7q00QzjqrxZJ/GF46MJdqZXqlAi/ICC37RkzTudiQ
 vfpHVOD8HPhDBrJc28p5bvMcfV02XkW3EeDOBDnGBxKtItzv0hwwyHOLxN8Ju4pc2QL9NAIdr36
 mv+jfasAWvXD1UuGyyhranyY3St9adKWy0gQCSA==
X-Google-Smtp-Source: AGHT+IGAZnqcJ5RNccv4A6agW8eBJGcDX4KYzqfozayQzmYtafk0pn5k9f2xu5wfWrcrc5qtI74jJ1qh+bFpHhB1vkI=
X-Received: by 2002:a2e:702:0:b0:2fa:d67a:ada7 with SMTP id
 38308e7fff4ca-2fb3f1b764amr79485471fa.23.1729157512018; Thu, 17 Oct 2024
 02:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241016212407.139390-1-shentey@gmail.com>
 <20241016212407.139390-2-shentey@gmail.com>
In-Reply-To: <20241016212407.139390-2-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2024 10:31:40 +0100
Message-ID: <CAFEAcA93N-44Xi5hDgcA2iOJ=RD=4jRuJoHkZJ7ViRnaq55zeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hw/resettable: Add SOFT reset type
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, 
 Guenter Roeck <linux@roeck-us.net>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Wed, 16 Oct 2024 at 22:24, Bernhard Beschow <shentey@gmail.com> wrote:
>
> This is a preparation for the next patch.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/resettable.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/hw/resettable.h b/include/hw/resettable.h
> index fd862f1e9f..0f25beaf21 100644
> --- a/include/hw/resettable.h
> +++ b/include/hw/resettable.h
> @@ -40,6 +40,7 @@ typedef enum ResetType {
>      RESET_TYPE_WAKEUP,
>      RESET_TYPE_S390_CPU_INITIAL,
>      RESET_TYPE_S390_CPU_NORMAL,
> +    RESET_TYPE_SOFT,
>  } ResetType;

We have in general been avoiding defining a "soft" reset
because it's not clear what the meaning of it should be
or how it applies across devices.

If we want to define a new ResetType then we need
to start with the documentation which says clearly
what the semantics of it should be and when it
will be triggered.

You might prefer to avoid entangling that with this
lan9118 refactoring.

thanks
-- PMM

