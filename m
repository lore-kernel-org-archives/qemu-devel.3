Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A112106FD80
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 05:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0v8r-0007kR-1F; Fri, 13 Mar 2026 01:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0v8e-0007ji-4h
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:32:45 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0v8b-0000pG-L5
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:32:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439cd6b0aedso1350994f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 22:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773379957; x=1773984757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SBp6TvBYOX0QujnIfc+IS/FYTHwiBYw/bDwUWOwoxvQ=;
 b=WQSJy6TNn7OWzSMXyXT3l9e6z0E0NB/zzTorIUfQC+toy7uhMUqA483HYcw1nu7xoF
 3wtt7tFDtsMXMgBzvMg7ilp0Hci9qZH7qBBZ+MOHB5wxNL/ciauWp735KAZWUsjQfkas
 bWi4ACvX6x4eNVbCb+J2nK4VeaDdrmMX3UG3jVMAjJsqezv6O6gOPmODe4o/rPfD4AIR
 0EbKrTnyWN8cOicNx8Vs8KZ9w+o1SsQ1Asn/q+RdicYh4v/NleuieRLqlVDAYyJNCeDm
 vovt6pGJRD6CgBrV/UyII61D94qN3/93NH48m7SmNNJ5bLt3unnM88oCyEUhimWU23ew
 P1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773379957; x=1773984757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SBp6TvBYOX0QujnIfc+IS/FYTHwiBYw/bDwUWOwoxvQ=;
 b=gQhdXy4rGtpfMmEd8pt/XlKAh6bE8TIqNKodUkZOe5L0bzJwoOsRTNQUwQA6GyA2hx
 bjoTcgHOfiWWdLzfB4mdrSTNMKjrtAj0n50YWIYN8gGtMZJHW2On//Rm1VhKYOywqFr3
 t9IAHnyWdaSebR+5gDMfkE4PGMdjmXOQ3t09fWX+Rwqji1WgZGSXKbNh3Bb82OX8J0u3
 dodWDfRtR7O8Ih2GZ1THYw89DXj8rLjE2N/1qOKH3t7lSd4JkX8jBnbT7Rkia0tCQdNt
 4Hki1OkP/XK2s9vS0JZY3OSYbkWKEhsXkJjTjh4CmvgGuGHV0x6bG8wWr9cBcK7IppCj
 cRTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQoVklNHLdntQIMDUlL+OIR89enGn2nUefegyIxR1ALGV4RJ9qjOUTS1EgZzPOe/YIh4UKUplVXX6v@nongnu.org
X-Gm-Message-State: AOJu0Yxz9E3X7tgZjAZuLoxmuIHq4xMQOmblFn6ZQxoeKWQ2rlVPJYMZ
 raymn8aLOwyC8zDG8sm1pxi2pJYwKdqSh3mZsJAY3ARQC2yzopoJ1Pi4jduBuuszCnc=
X-Gm-Gg: ATEYQzxOGg7klVIPi3ZSAJmmlRF6NpjHwA2jBthTmHT8eB/SBk1XK32G+AWWCTf8YHh
 Phhq4S2J4dBLe8gi0vGsfSwLKnjYMBfPA48iSvpe1Nxt+Hvfy+11+MUJRXmmhztXer7jMmS2EIV
 u5N52AqmnrgWfXH03ttaQNuRBJTHsauPX5briFoFyrQ6brofZ0Dgl0y70lXb7fE1VMugJC9DmnM
 oLD7Yk5i/uV2xMnjK6IsCAzs9Njrp+s4RTGHoW3JXc7rNj4k9USc1aEg32WPrE61TAhu8LEH5wI
 ehm+NzRvwUymaHT+t8tmi7g/c7UxAXq29AlVSp06PafGgNSXdA8uM62Co/o3sLpMKUzdKJ7z8Ka
 lRnMZ+e/nJUBRTDTbrZQs3M48X5HompS9+QRISjuAM0adXqkqZfFXK0BYBk7oHPNAlT5kXx/+bS
 pIlHZ1NR+so/e5GNjJf0SGGzrMzoF0gPXTY3xKvx+erPm2e+4p8hL2EYtSrVmoiwz7yw==
X-Received: by 2002:a05:6000:178d:b0:439:c279:32df with SMTP id
 ffacd0b85a97d-43a04dc0527mr3669038f8f.35.1773379956773; 
 Thu, 12 Mar 2026 22:32:36 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1affe9sm14031698f8f.15.2026.03.12.22.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 22:32:35 -0700 (PDT)
Message-ID: <c3e743e7-94da-4395-a757-396aa5d334e5@linaro.org>
Date: Fri, 13 Mar 2026 06:32:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] hw/vfio: single-binary
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/3/26 23:44, Pierrick Bouvier wrote:
> This series makes changes to hw/vfio to compile files only once.
> Changes are pretty straightforward and are mostly extraction of kvm/other config
> specific functions to proper files.
> This is the last hw/* subsystem that needs to be changed for single-binary.

There is another file in hw/s390x:

../../hw/s390x/s390-pci-vfio.c: In function ‘s390_pci_read_base’:
../../hw/s390x/s390-pci-vfio.c:153:52: error: ‘TARGET_PAGE_BITS’ 
undeclared (first use in this function); did you mean ‘TARGET_LONG_BITS’?
   153 |         vfio_size = pbdev->iommu->max_dma_limit << 
TARGET_PAGE_BITS;
       |                                                    ^~~~~~~~~~~~~~~~
       |                                                    TARGET_LONG_BITS


