Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60979606AA42
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=z1Ej490I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOuOn-0007Mk-V5; Thu, 05 Nov 2026 05:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xOuOQ-0007La-Fh
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:08:29 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xOuOG-0002Et-DX
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:08:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1144106f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 02:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793873294; x=1794478094; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ErmNKf4j2LvVJ8SmsDq8jcDpx4L+lNZx2tgIVrNporM=;
 b=z1Ej490IEAuwOB65SAzHY3OeE/GbQ2RHHIM0UPZpK/k1i3P7ClCRN873t0PsRzDYiX
 dvsMyhJl5tlmwxXDpcB7vUH7/F1N5QiiWpNC+lR1cyZEv65lwdfZhS1Li2U1cwFrx7s4
 ie0tcCkWeruKVXhhRRtgTBvGreOr8gyWGorx7nF/COZF5+e1Cjbr/CQ5dOVQgTSS3Us7
 lU3kBfPrGjxNWwRtMHvOMShXqY0NrR2djkz8WKKIvHSiA+RPx0eI2/OessrkmF8zxlHO
 HCfFgeE2vIBZYPBnxCaeR+hum6QF9tkvv5mF04P15E5Gekc+hmjZlNbbmt42vIDH6nu1
 CZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793873294; x=1794478094;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ErmNKf4j2LvVJ8SmsDq8jcDpx4L+lNZx2tgIVrNporM=;
 b=2x2DuKKBWeUh+HnwTqxaCE4uknk5Yi8xN5UgrTZSd0OJNV96W/X+DqgfHaJ9WVMmfE
 rXgNXDafFa+hcBAR1/fnTfZscF9inLRBJNJhKWPpMXkLKOdJKp6lcoXrrdRh1QruyW6M
 A2abbjhViNkMMBfpYc31tBuiYDKBMH91KURac5mnZ/okbz2d/+S9L8UryyKpV4T7ctJt
 QrLqft2yJ9Ba7vCEDxrsqe7ZKiATvhot6Mbn3iuPTCUModr3sjOUBuwrkMIYse/LBoFQ
 8aWvzwz0/Qmm0DTcya2OpOaZ29zBm9DFIQ0yZ5Gy/s9MeOd7q2Y0uiTxn2jVoJZQYjXt
 k7eA==
X-Gm-Message-State: APuU4Z+lmc3iE4Gy+NgzEs3DrQwF9n2C1HdrWOl3MoM+jSg1X9Nr4lqf
 hsw4dqW9e9R3pS9kUNRaxgQQyM0vjdqyjAz/I7jhk5NAW6DhtwWMJliLF0Y8h2khYx4=
X-Gm-Gg: AYBFou075hUKEPaQz7dP5Odii/q6AlwEkiZD6FTp10ksDg/t6t7m0zaXerWq4T40AwT
 g+0kwCuje8chfTN2ptVAgaOMm9n8yXAbaMIvDb9pFa+NKrftacYqBNcmMi23EeTCIXhPwYrIWGN
 KValqrL38HQYTh+IDhNeNtNCfBudGuBehO0mgRUj0I8qoifyVtNQ+z1Hkpj7VgSeD+aKsM+SsK+
 ENJQR5Zd6GuhONsVlGGrurfgUCuGMVyu2Tc5V/NnoEKs+nIhlObP2atKn9mAjkhCl2Y1P+QCe4I
 ib0d9bfxkROGZe54s6OwTb8jqJ2DrOOSiQZWM6GYVY75bF9uJwZ/phsY1mR105xZWsIgNatE1k6
 EX3uvtf4ZOrT9LDdeesRQyAjyFDtbbHAW/Kzsw17gZFixfSgRkjrhYZXp9VtNYZpOi+rl0704Uh
 RRqTYlWABteBu+cRO6LZSt8SxkQvfxHXgCaEa5xTD6aZmWMTKQHOsLqYkE8QUWXnTowVPUKS6Fk
 sLcSz7cNTpRP0dHYOxTD2aWAL7eLPtYaE7lfVj/KlwN2H3qV/qNmctK4MCENkMfRbdBGmK2RApQ
 5nVWAVyo40i0Hgeqt9GD/CeI4Zga6g==
X-Received: by 2002:a05:6000:4814:b0:491:96fc:9f0 with SMTP id
 ffacd0b85a97d-49196fc0d44mr1829775f8f.15.1793873294370; 
 Thu, 05 Nov 2026 02:08:14 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:2acb:1209:e24:c9ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed45d2bbsm9489645f8f.33.2026.11.05.02.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 02:08:13 -0800 (PST)
Date: Thu, 5 Nov 2026 10:08:12 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH 2/2] hw/ide: add SPDM + IDE + TEE pci support to ICH9
 SATA driver
Message-ID: <auxVjETdY1OekFOA@linaro.org>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
 <20261104-ich-driver-spdm-v1-2-60d361bc0417@linaro.org>
 <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x436.google.com
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

On Thu, Nov 05, 2026 at 08:12:38AM +0100, Philippe Mathieu-Daudé wrote:
> On 4/11/26 17:34, Jim MacArthur wrote:
> > From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Rationale?

I'm not sure where the From: line came from here; b4 may have added for
some reason. This was originally Pierrick's commit, hence the old email
address - I'm unsure whether to update this to Pierrick's new address.

<snip>

> Which section of the ICH9 spec describes that? AFAICT ICH9 predates
> DOE / IDE. Is there some amendment? Otherwise this might not be the
> correct place to add that capability. Either use a Frankenstein ICH9
> with a distinct model name, or add at the SATA layer, possibly like
> a class interface (we only need the SATA_CAP_OFFSET IIUC).
> 
> Michael, Tao, what are your view on this?

I agree it's not great to add features like this which weren't in the ICH9
spec. We could certainly add a new device with these additions, but I think
we'd end up duplicating a lot of code from this file. An option at the SATA
layer might work; I'll look into that.

Jim

