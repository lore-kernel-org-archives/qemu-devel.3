Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF91C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 08:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMkuY-0007DM-MW; Thu, 27 Jun 2024 04:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sMkuW-0007D9-G9
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 04:55:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sMkuU-0006z8-W9
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 04:55:20 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4256788e13bso494825e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719478516; x=1720083316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cKfvsTFu+0UUDxAsq0C7n6iRQV6bHlOTI303h5QEkpQ=;
 b=UWBZz7us+2aZ7cB1zDZxRoQNWBZSHX957ZihsFPaIM0Cna3rjFaU168N2QPSouoWAk
 uLldDohIVkhGh+4VVczhoe3it/VNgXBRRQNDo40/Oqv178RZuV79mo7DF3OiuzuHaPjy
 1FhSnvxQMZO03gtZvMDvGoJPxggxzPRHh5r+gRXVjClQ19asV3eukGnTjq+Ixjf9Fdxf
 IMvjkQNNQtsIi13Zma8CATgAYF+3Fiv3e6bOC62QBnMLcOqyi+4Bk3K8mBm/+eennfzc
 ToS54iky/iUXjiOSnXE6HDkTt5Avr6HRPDc0eLE/bRZKzy5o8HOPse/FVDC+juYX0iAe
 rHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719478516; x=1720083316;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cKfvsTFu+0UUDxAsq0C7n6iRQV6bHlOTI303h5QEkpQ=;
 b=KEQ3h1F+vDRGMO+cOMLrVtKdT1Xz53WimLyaIMk0ofu4KWaqIuWnnUZWrSbCZ9iOg+
 FgQv7Ob6IiVzrQWdNCyEHYgxt00jFUnxgVX6vxTuEnxJRDMoCFba4AVGE+K4vhTWkcNh
 RE5MfSfElAdl0Te2tFezJJfv7pxRcf5GKIk8nnWsUszX7/obC1kmfCDMEhIslnhoZWs0
 YGj8wiLqRyxP1ln+l4hS156To6Y5nNbA5HCjfkPqH61xltIZuOFvG936ZCyIQA1+buqE
 w3TIj7sd3h4gTG33jF7L7xaCO0Ro5CSx8fAKHemzPS0/EW58kw07O2A9qRr1tLHR2zpG
 JZBw==
X-Gm-Message-State: AOJu0YwM63a1oXdUtFOZmTV44RmtyVH+/uJ06kOviJV1qmdkr9Ppr0tT
 qRzJJsSsl2KTPVK00mRPA0gBqZctH3crsoxcOUfIoLPW0p2XhLEPeJsGc2Yyx7o=
X-Google-Smtp-Source: AGHT+IF9gTpwaOqtqL/63HPVrWsp8KwUD4QkCdp/uOJiEXCW/q1fT+KW77IQ7W9K4M6BXdT1XPrqig==
X-Received: by 2002:a05:600c:21c4:b0:424:ad85:2004 with SMTP id
 5b1f17b1804b1-424ad852267mr28888805e9.14.1719478516488; 
 Thu, 27 Jun 2024 01:55:16 -0700 (PDT)
Received: from meli-email.org (adsl-241.37.6.160.tellas.gr. [37.6.160.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4249b133b44sm60677475e9.0.2024.06.27.01.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 01:55:16 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:53:24 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, flwu@google.com, berrange@redhat.com,
 peter.maydell@linaro.org, rkir@google.com
Subject: Re: [PATCH] include: move typeof_strip_qual to compiler.h,
 use it in QAPI_LIST_LENGTH()
User-Agent: meli 0.8.6
References: <20240625111848.709176-1-pbonzini@redhat.com>
 <fnhkw.xyx5xkm2lgb@linaro.org>
 <CABgObfaK+CQTni9MQjTADY-Fode9Fg3hTqSfm+2K8R9DCRJ5cw@mail.gmail.com>
 <fqdc2.8zr6z4s9qcnm@linaro.org>
 <CABgObfYuf3Bbu_VZt+6Me6HpPhMo04hm_dyFvQwTCKdm3uEuAw@mail.gmail.com>
In-Reply-To: <CABgObfYuf3Bbu_VZt+6Me6HpPhMo04hm_dyFvQwTCKdm3uEuAw@mail.gmail.com>
Message-ID: <fqe42.gkfmy6zhei1@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
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

On Thu, 27 Jun 2024 11:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>because if anyone ended up using [..] C++ [..] the error message would 
>be very very long.

I thought that comes with the territory 😀

