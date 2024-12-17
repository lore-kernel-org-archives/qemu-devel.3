Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3AFE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa1A-0006me-IG; Tue, 17 Dec 2024 11:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNa0u-0005t6-Ns
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:40 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNa0r-0002Fq-Pj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:36 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6ef7640e484so62915677b3.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 08:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734451292; x=1735056092; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6rvr1pDFmp2BQW3QOEsi6mwCNhkrwstgFWp2nCEUrpg=;
 b=GpaeFVcl/JBzRNlxe3dv7frId+SYH2wEj7dRcBVRCCHs6Lau6WmQNKziKZbqMjab3W
 dzf28AGPXg64M0CuZQtgfyz4cG8g5g/mLIIYblPsuOP3oI97UXZDbke/+zPwn0MIAWqJ
 4pYRhqFgLCs1vzzUe2LgdqX0WERo8985lf5Zj4vHiHP5iMe4B3XaAl1NeJSnhKpqxfY4
 u/OjmbVd8M5FS+p0z8OGpGd0QxoWxvCcy0ZdrYHZX6HIOI7J/6H+Yq3kFFTybMD9GtwD
 Fz3t/QFVldd131+qmi34Kc1jVVt20nmTDVIaWt9TxZxvoWZ01wz13vPTr9kak9Mfe5U7
 bcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734451292; x=1735056092;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6rvr1pDFmp2BQW3QOEsi6mwCNhkrwstgFWp2nCEUrpg=;
 b=KZx1xJOkuZC4+Yirx5n1l/MwK9Z3CFPzE+AwC6VHHEoPFdigHIvTmXMnIxxBMXCSop
 dFIx8De1s1X/A+oDOIWb1NhTuQ7afMvlFwVZfXhgePuKnsoq7AE2n445GGk8o7R7LitN
 Cl2nwwVcIrt4AnkdPApfT14SjNI7AJ4gu7nvlIq8z23s0gzimqMIPrPSGFrSoSB8z06O
 mUN/z//04Hvf2CS4YbIX0k4MaL3DRdjCjvyjTIvQBFIUqCoGsaDmKJ+RsfTzJw1L1ac7
 +sgY2ENJdJAkv4bXetoJLunSArsRSvUUR3Hp+/fOsxNtmz4koqcUG3lT9PN6/OU2ILir
 LJJQ==
X-Gm-Message-State: AOJu0Ywva3gdJsiNV0mURKVBq0vYtZKJFRwEYb723CvDIgrqebPfh3ab
 xNRVJafxWvgKOx5BLflz9OHjntzV/WyGqZdcsmGqZlrKnBqU/TInkrmNnj365zcufM8QUO+BOlM
 B62gO3ycfNHRaYVn80DzewLrybB72mghrDyNf9oNym2t8HWKj
X-Gm-Gg: ASbGncubfX/QwLQioERgIlODzXScUTSMi0RTDBHw3FKP2pHWUZkJOlKdQu88YBYbGS3
 JglY5Kkg5hcZ9IWqlfC9xQVRLhQ0fKBtdCuK3pXA=
X-Google-Smtp-Source: AGHT+IHN2I+zbFtCtrw5kE84f8aTezXrK5u+qrtIzidP4bsaw6mWEjDSR5hJqPvt7lrF24pZfUn3cQRQuGz8cMI0HzY=
X-Received: by 2002:a05:690c:317:b0:6ef:9dbe:9f82 with SMTP id
 00721157ae682-6f2d1c4b3dfmr773267b3.29.1734451291684; Tue, 17 Dec 2024
 08:01:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730549443.git.balaton@eik.bme.hu>
 <1bb0d0e91ba14aca13056df3b0a774f89cbf966c.1730549443.git.balaton@eik.bme.hu>
In-Reply-To: <1bb0d0e91ba14aca13056df3b0a774f89cbf966c.1730549443.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2024 16:01:18 +0000
Message-ID: <CAFEAcA-+-YRfYN5+RDscaaBr-fqKL0xKTBK5yG7SAJYRDvtOGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] log: Add separate debug option for logging invalid
 memory accesses
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Sat, 2 Nov 2024 at 12:18, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Currently -d guest_errors enables logging of different invalid actions
> by the guest such as misusing hardware, accessing missing features or
> invalid memory areas. The memory access logging can be quite verbose
> which obscures the other messages enabled by this debug switch so
> separate it by adding a new -d invalid_mem option to make it possible
> to control it independently of other guest error logs.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

