Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9248ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snerz-0007WE-GA; Mon, 09 Sep 2024 09:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snerx-0007O4-FB
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:55:53 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snerv-00014V-Qs
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:55:53 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f75129b3a3so40737371fa.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725890150; x=1726494950; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5BxBeXZz2FWzqMeH7kaXfTqMjcpeEgc86RDfAgkEzlA=;
 b=CJQ8QraR4Y+UK8calhiyJ7bxSIv3mEdca67r9MG7maENXT/1nb10k980znw/X4Cqds
 7M3j/Dh4yVh446ALclE2eY9T0TxcoV8Hlu5Yp+MfRYrKC3XBgTvxpPZ6jT3HVsa/yK9P
 Qsvx+xPWb42+vMN9JD1O3tVdLxMoUXX5OM95tUVn5yAqHPCUW/vZ5uuCsVVOvRi4LKoV
 jfiFDq9xagrU4JUr459GTPBHcQ3LKBFtsuwVyVRBOHHZ0vv8IrkQ0vymnpjX46heg+LY
 09z7DFt+KaT0GlfvbyE0XugfS7Wx9t615gYsd2Sa2ub60nfTGKhAvFAkdKi7SAm0nlb4
 zj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725890150; x=1726494950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5BxBeXZz2FWzqMeH7kaXfTqMjcpeEgc86RDfAgkEzlA=;
 b=pIqc6wNse98qsv6hBX2sQjwqo7vbtS2tYIBaa6vY5WC7+B56eYhi/F8MgffLv8FER/
 yIvJADCcHS2CY/pkvBAnc352LXgN4oLL2gkZdQHCZ1EYh+l/PuNFdlNl76eeBBZHRZmu
 sNkfIK41peSIw4MDCNdOXydA5+9BXw8qwKiqxfRE6f3mgOI0CjCcNJBiqml7vzwOtuka
 XuYEJwYwmzBVOH0UdvV27k+NXRDiCtEavDxJrHy16K8+NN5GumvJuxCd+kSbM2dQaL/q
 V4+btQAzB0QwqvSsPhh+YjU5C+xrsJQ6gsi5C99PNAa5t8GHwvPRwXL5S0VLgBByzskU
 IipQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE95/MxQ+cMo8WCpyzlJ2JBXDzXMwOIV1KoeQEqq30RZsSg2xR7zaFQFCGL4On6KJnhIECe6SQTjnt@nongnu.org
X-Gm-Message-State: AOJu0YwTK3Pvn9VzXzIS3OFv/zEyeMRddHhCMWz6SWox6/XPBkrFyoq4
 rCLCsazmXUG1LC9/FIR5nUZTbCOPrQyvmjs3ZtV7JlrnpCrS9SJyqTKU8e4eVW3Gu6DBocbG90H
 Uz5QyrKjgpX2F9H1GAOz4Rv14bc4RColQBpimiQ==
X-Google-Smtp-Source: AGHT+IHohn2kcDP3m6xvgDWXrE2h0Th2bP9EyVX7jYgEp7CiFxi1paqcAh3O2PHqtikAPGveherSZ0anAmI4a++FsXs=
X-Received: by 2002:a2e:801:0:b0:2ec:637a:c212 with SMTP id
 38308e7fff4ca-2f751f854bamr66109981fa.39.1725890149668; Mon, 09 Sep 2024
 06:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240827034927.66659-1-doug@schmorgal.com>
In-Reply-To: <20240827034927.66659-1-doug@schmorgal.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2024 14:55:38 +0100
Message-ID: <CAFEAcA8fsrOm41GnC3SBJCrH-nhWuXNssMCOqaA+0U8Sne05Cw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] hw/net/can/xlnx-versal-canfd: Miscellaneous fixes
To: Doug Brown <doug@schmorgal.com>
Cc: Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Tue, 27 Aug 2024 at 04:51, Doug Brown <doug@schmorgal.com> wrote:
>
> This series fixes several problems I ran into while trying to simulate
> the AMD/Xilinx Versal CANFD controller in the xlnx-versal-virt machine
> using Xilinx's v6.6_LTS_2024.1 kernel. With all of these patches
> applied, everything works correctly alongside actual CAN devices.
>
> - IRQs were accidentally not being delivered due to having a level other
>   than 1. The IRQ count in /proc/interrupts in Linux was stuck at 0.
> - Incoming CAN FD frames were being treated as non-FD.
> - The CAN IDs were garbled in both RX and TX directions.
> - The ESI and BRS flags were not being handled.
> - The byte ordering was wrong in the data in both directions.
> - Incoming CAN FD frames with DLC = 1-7 weren't handled correctly.
> - The FIFO read_index and store_index wrapping logic was incorrect.
>
> I don't have any actual Versal hardware to compare behavior against, but
> with these changes, it plays nicely with SocketCAN on the host system.
>
> Changes in v2:
> - Added handling of ESI and BRS flags, ensured frame->flags is initialized
> - Switched to use common can_dlc2len() and can_len2dlc() functions
> - Added fix for FIFO wrapping problems I observed during stress testing

I've applied this series to target-arm.next; thanks!

-- PMM

