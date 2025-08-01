Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E4AC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhuBb-0006Xw-VI; Fri, 01 Aug 2025 14:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhshy-0004rA-N3
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:34:29 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhshw-0001yb-Aw
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:34:13 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71b6703ba32so14248287b3.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754066051; x=1754670851; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3z9Wrfw4NuTiRf8Oyp3PHEGssVHtcXUdItyLJFVvBw=;
 b=t+DxhgIzY+cf727NSzCcel1TudFBZTg8Na7AXRYiLP23rdj1//+27oF6XAdD/FoLCV
 StcAQ9vUgJnnMBiPF9p0EoQJhv4QTtOZsabg81d4Y1ZDx+lvLJeFrxO4jGrJYEDijDkn
 bxh5pCoxc+01th0OkSQa9c3T+khfWZcdXGkg0nn85DuF6R1Ca+fZ+uI9ZL5mMNg7XBvS
 qcDg8bsWt+FjyYc70lTieIomPhjS3dYUdxbevTlM4VnohQi2photCNNr/7QXHJXffPoM
 98Upvec7dh3kcpRsPBu51+1zGpNMI7H8l111xeUIInLT+UWsfYCW0RnrfmrUhFjcVz3n
 2/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754066051; x=1754670851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q3z9Wrfw4NuTiRf8Oyp3PHEGssVHtcXUdItyLJFVvBw=;
 b=dzcgi8QqSrY/Vj0YU104ZANd1vm5r2I6y8r0L+nM+iiaMXHB8cQuS6YhxuTZrUF0bL
 BB5i5BGx0oHs0zkYPulVgZuxeOZXnS6HwnpfzzmDLdIMHhu8S5YFx09uWuyI8Wioc3Ou
 KasK3rg16H/rJKEWV+2a4pYIUa55vez1Lo4vC7wBEHsGiOkHXJ0A+6iL3qe3lPK3N0qe
 XK46RGrJGjdIavxXNmGE+IPyyQWF+cy5MhcWEYph+vbOE4W0bYuAej5WAGcC6CfeJkxh
 9OdjP8mAW3ZWI0ckhZzUQzhYySFVy8tsjZSpF+pgHVf9QTuN5Ry7rqXVlFbLnUD87imG
 WfIA==
X-Gm-Message-State: AOJu0YyCuhaGQQlMnpBIEJza5UeXPkcgvUZ/NVNBWz1b9vfY4vcTV1hJ
 ApBhnak5SfB8tyAYoi/Zl56tYhSuNJ7I9HBwHwc3N+kPLsHoogJGUq7lTt9CWJVk1/6po853+B/
 wd7ggeFWhBUBYyyylic/ae/OUr9QhxdrW6cnBe+sUM2/OswyB4NDd
X-Gm-Gg: ASbGncs3jMfE2uhT9qdPnf2O7Is4py9z27Ncqgr4bMU2s1SlsYpmn1nbLPIswXNxJ3X
 YqbuSz3r+1/YhDn8dtGtalcPkpzvf3xjFfjoahozARW1XSZ6ojyIxm6+vLpJTqTLWF22l3oH15h
 1v3YvIaKx7K0WvIGGB0PF42yMx4sl59naoRVgS3Na0NRc6B5BZGIP9KqocW3Q0w1LonqMaTcw+a
 KJCZG3V
X-Google-Smtp-Source: AGHT+IFMMMRuiR7RIynaaN5iBn5zk3H5OS+SY4d824ZI0HS52lAEsvYc2TcJhGnVTJrMGYmsW2u8Z9TrXMI1g+TPaTM=
X-Received: by 2002:a05:690c:6186:b0:719:5d76:74b with SMTP id
 00721157ae682-71b7f5c2060mr3312807b3.33.1754066051046; Fri, 01 Aug 2025
 09:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-26-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 17:33:59 +0100
X-Gm-Features: Ac12FXxtzJ3SH3tJEe8X80VzEjt66gWj-rMPohFnr8PYoy8p4quw1lmfWzervWs
Message-ID: <CAFEAcA8vbcmfWKAH7Wkp-GFPrwFztFiCQTXtJz3LmpBcVJ6qfA@mail.gmail.com>
Subject: Re: [PATCH 25/89] linux-user/aarch64: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 30 Jul 2025 at 01:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

