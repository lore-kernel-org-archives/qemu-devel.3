Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888E606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nBvobkIL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQoDK-0008Q3-Rx; Tue, 10 Nov 2026 10:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQoD6-0008P2-Rd
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:56:40 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQoD0-00085x-Vm
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:56:33 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6767d92cde6so2411493d50.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:56:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794326189; cv=none;
 d=google.com; s=arc-20260327;
 b=oeF+TAN9y+EzpszstE3xcZ5F/pgiIMJ8ZM9/fXpybG+e3wFOt0nN8SXgjBxO3qt0M7
 OeBwiouEE1OvpH4zVKX/8n9f3JKSlsoBe5/tqMZ9d2Wbv0e2Aoo4GtyG938k3hQCKIiR
 1DVoCvmbk05W6ladk95flG9b+2U+x3NHPK/7Z3zKYEdN6y80oojsqW/aLeGkyD9wXYvC
 8sft8YymbuTiiYLgj/sn6mZoNfKF1qe/FCws5zpPfH/fPbo23KDmEbLgaEK4twm2UL0q
 y9jIDs8qbWPjP+j5Qxnqcod7QaPZWzMS9ehfjMZNJiGHvIeH5eSiy2gXtIy9CJY8aZPG
 IFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RfZCPrBslFN+xUUQ6z9xz1gNgYNBT9NLEj536PZOg8w=;
 fh=kcMqnS/hJUwNpfuCppCDf3FNNhF2MmmzGCBFK0eEBhU=;
 b=Jd8A7JdWZAXGKFEY+mltoqvueXXR5hlsz6NpJicv2bBV9kSR+j0qHNUIDtR5jpxCFJ
 1gqbHJ44ynf+aIZMB99Y7wWD3ZRTCAbZnH92346wDBaHn1LlH2/xSJCWdEwjCDl4cIZg
 ZTwWtAquH8n3Arxo8eBuOknz2tvJP4SPq961WV6Gj4H0rRRgNoysTSyyA4+/b4/Sy1Ro
 mra4I1LolafTkDRWAWXdUWaELgJATFoNIoMW8h8o+vphuVme/p3bZYp9dcrXQFYQa58Q
 Gt7cxJS5BpxqCT8WHm7uYwCWKJHQx8xowB5IQBb8vVFou3FoGYBidrDjP5dGHmO62BNE
 ylzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794326189; x=1794930989; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RfZCPrBslFN+xUUQ6z9xz1gNgYNBT9NLEj536PZOg8w=;
 b=nBvobkILJo3kOwVrDXNla4Sk3kpqkql8Ed1cMwiZTtovmpfFDFPwBnMsMzUJqY2c9c
 8bLvHoxz6+YEQvGzEk4Ds3/61GVOX5uEJfPG9FSMqHRby7ZinRqS4cdLSRuyLHIXIifx
 HPduiryyHb37o4c57EVWLOipTTWkvzNJf2nARuo6OjFsVIM2t1419ZBOwPCpOL7dMWhp
 BVD3IgJY8C4l8DmG8Zp4oh7nR8p7611G2N9vQCXP8VnaThyH++nfyZNILfnvJ/Y30Dsm
 UTrPwf4zErV7yGBFjFd22K+kSPIhOC2XShHz+yRHRZ6a2wbRRTQI0z7XCSj74zQ/FOv/
 hKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794326189; x=1794930989;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RfZCPrBslFN+xUUQ6z9xz1gNgYNBT9NLEj536PZOg8w=;
 b=Mi/ayNuDEhHtddhI9WGvEkR+b+onuKJE3ezflla3e7hcyE7cU3vOYtBlcFGRNeb0vY
 +hON28aMtaxalYNQpZw4Itd7JoBcwFBYc3aO9kgO9JYJCB2QWs7JJXRDjxmZ7sn7qivY
 iNnesCFa2luu7uPgPZJXb4/S5WjjKy1lKShqU0t/IgW4qX6VY603TSqD2sxM9PRkdBYP
 TnwA4s7pi7HJ+atkj7Q9yGZ0umaQ61hZ7zdZ+GguPFgFjQcizbrRdwk6EQy3Qn6Uicp0
 jasSwGyEFpg7hUg6tHynxSDyZ1IUT4SZI+QWJjm1pXMgZxQwQBJv/0P3/IfKClmUtPMO
 Walw==
X-Gm-Message-State: APuU4Z8WygTMT6tD8Dy8ZCNCQkV6pRMb/x/Y6Mjl0Wpw/MGg5iDY35AC
 zpNaveZv/981t1psXiyFFjdIheT2mpWgO35fcxe2gRFYJh6olqRGaDn3GfEHEM9lD1n0DmSDu4X
 lHth4EUfjhWCo36XLD3dbHhurAAXm+DqWmnr3xQiT+Q==
X-Gm-Gg: AYBFou0B5VHwS0G/k9LBSTuCUfzxEQ7QAI3aIpd2Kd8diV6FyCt6uY08YQkVv46a6K/
 qmr8Ad7nc/60ylcd+7KBuQ6vfHhrrnR1jz5ZQ1zoaIJ4F+/nkDn7RxyYeO0dTe/hxgUoADuL3k1
 N8ZwxT2VKZMsx4fqUakk2+vBHcPWXovfk2itd8EZcPoxs5u5dY32QCB1tRRht/Vv/xekUBrsRi0
 UW3IvHHjBK4W8R9ChjevLeYGuKBXIBW/Y7JAGgKUFU+rtK9upuw3FRFhRFAtBBeXp4ZCTliEuhf
 wy4SbOB13UM0KLz8Yj/xE/vnZXstNW5p+u3vGCVWIkX/uL0By0AeupWuoiBz5xAne296xN778Xh
 9qANzWicdSxAY+LOkP/c9z6fbUkh6FiXzhZveafnQf/Q0YDwjeoxwOThjWrvik0DCZs1dRdMBuE
 WBIAwCSJU1MuDAIGuS04PT
X-Received: by 2002:a05:690e:4401:b0:67c:cab:bd73 with SMTP id
 956f58d0204a3-67c568e7e9fmr1121785d50.96.1794326188637; Tue, 10 Nov 2026
 07:56:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Nov 2026 15:56:17 +0000
X-Gm-Features: AclHuK8zi3YlpBHmuaYsWSEBlEz6GUZV9M-S59L4L5WwcIHF-xpaLREytFk5_SY
Message-ID: <CAFEAcA9ue4-0DacSPtEB0BEP6HyG7nHtCy5vnsuxoz32xBreNA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] net, hw/net: Validate header lengths and harden
 packet handling
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>, qemu-stable@nongnu.org, 
 Lazymio <mio@lazym.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 05:31, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Supersedes: <20261102201828.1879576-1-peter.maydell@linaro.org>
> ("[PATCH 00/11] net, hw/net: Harden common code against bogus offsets")
>
> This 14-patch revision combines the IPv6 parser fixes from v1 with ten
> patches from Peter Maydell's networking hardening series.

> Both this series and the igb patch series [1] have been stalled on the
> mailing list for a while. Jason used to submit pull requests for
> network patches like these, but he hasn't been active recently. Could
> someone please pick these up?
>
> [1] https://lore.kernel.org/qemu-devel/20260623-igb-trl-v8-0-c9b1fc6c3304@google.com/

I'm happy to pick these two series up via target-arm.next if nobody
else objects.

thanks
-- PMM

