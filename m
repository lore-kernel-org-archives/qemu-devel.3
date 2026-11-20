Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854BE60A260A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zbCV0zNY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUN1j-0005wc-Tu; Fri, 20 Nov 2026 06:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xUN1i-0005w5-CW
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 06:43:34 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xUN1g-0005LV-7x
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 06:43:33 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-67db23d8892so950930d50.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:43:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795175010; cv=none;
 d=google.com; s=arc-20260327;
 b=arl5o27o2e4wHpm9EEFayDSfktiV8YADt6V4p1bEJkZXGRnKkqNZVMMaLGFBAnzOTz
 bQQB7aXNxsbs/iEoxE6NJonPsIXT8mTVQTbm1QsAtMXgSfrKtdfBJJzERoZGQDk8vQ5h
 iiBXLx2c/GBJjDqt/Nkg632aIiuL7dliZ/Pwk9aYwotJK/t5ykAwyUqLDa/o+KAj1Cn1
 ySZzsikSnRPBuTN9caLsm7HbouZeTO/TaN7L9uDXq/hNYfGjI4IpFpeOQvROm7IymOer
 pOnmC/zCaPpeuteYKVY1f4Wr6YNfgTV2cRHWNfzFq5VsXzBXXzhk3aKeLMUr41hf1SHb
 aDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=rIAhL2QRLoNu8jSsk6OmKcyR2LzJ9Hd6xE+H84MiAK4=;
 fh=TLo6s5XeOncfV0CLBzAL1V3ipuhH5vok4YhERA9AYMQ=;
 b=g4cKb0a6zWkgZba1+S/hZ8ZHns+M+tZZvmS4As8T374QyY6rp/czts88MIoY/QDgzK
 WNZaoMFggAuyQdgKMTVSBbGBaKuHYuM/fARg62jmj49sm4ZTxEiTVamH9uMOJXAjRsYk
 cw8rTfgTzMW3sz9emQgAun6e6yY+V7+3jcm6zqc562IunQw73o/RUoM6O7jq8O6a9y/9
 hN1BUgi6oLTov/T5ShFvnz40Qas53RH9I1G8zZQp9gm7ZieVobsTc34ajee9RkjIyk8J
 H/SB7XWoKE0eUnhO6OyaRnVwT+F2W8nMx6uNiM7gOzfs2xY+o/O12uvnkiQZ66tBR/Bl
 mT7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795175010; x=1795779810; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rIAhL2QRLoNu8jSsk6OmKcyR2LzJ9Hd6xE+H84MiAK4=;
 b=zbCV0zNYLSJyalgViQ3jmuOVcH9hDZl4fPfOomTUQQzw8YYxA8SOt4s/1XCWFRZZgY
 CWx8og2UNAwD+ksVRHs0Ntyi3+4boQrp7O2IpdHxPSvkCnezDPcQYDCY3DfynBwM5Hdl
 jf+RwMsfV86YmAGLpmvrFwp4kGn3NHOKr8iOSZqEMseEWrfBcvBR8yL9nG3QRruIn83Z
 +6lGfMeU1B29qR3dCzHpUdfjThq0CxR46vlGLjD/HPAl5XLVnrXwh2jxgU0JAMaMDWtH
 mXDoqkRTZO34B1jx2jSolPH/Kxt6DHYadcAyY2bsKQ2FZ0xNKqWsJ9p713L0tiSTfPbB
 msCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795175010; x=1795779810;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rIAhL2QRLoNu8jSsk6OmKcyR2LzJ9Hd6xE+H84MiAK4=;
 b=DT5FCMDCvw3GcqU5eSxI5bfje16HJ+MjlO933hkuOdF15M0HWhJCEC4v4J1pXk/Gme
 zH88unn8YLUrQ+aEb6dpYkiTtvEV/6dfvmDHZtNcGPieKu1uRpfYUR+613ExXgEauu2M
 1tUR+rE5J7u8W+jRrwoSZ9gxDDB9rN7rKsSf8CKm+hfX6wxI7Abof/PBCHpnZnNHy6Ky
 7UGnPHNgxYW5OAruZcbUKmPGeOeNk7eVrSzptD6DN/IabQ9huldZNTYeNUP09iXpEO0n
 MhOLwDsQV5Jv5+ecx+jKAZok+GBtiBgBNZYw7iPGKjkzubryLQbXWcebjnplCyTTzma6
 t2fA==
X-Forwarded-Encrypted: i=1;
 AL+hErGryFNl8X9QCk5neZgvNQqElHAqLmYi8/ih4trDvoAvvgIgMT9OYAsbBiSsIhfuRbdEMz2AvI7rGU8l@nongnu.org
X-Gm-Message-State: APuU4Z/Vi02SmOUeSe/4Lj8tjKqavucUvqbvXXUB7Puoia19tlLRlGAD
 SkScLVbeqI/cDs05v2qEFtVoV6vZT/rMlw060qJM07vTdhQw+z5UQ6y8wLCkZJ2XnYtUUFUYKI3
 laRr++kHDzVH7oQincFyDavPgl9cI1wwUFhXwskk5nNAYn/+EBAGqClk=
X-Gm-Gg: AZFdTZen6iy7IK2IAX57znUglVIjJfGfUKmKI9WwWr/0DC6V5MpFFDLP3sZKvVrmDYd
 ql9CCrgb/aI4iTDRC2aS+39jeYhq9v/KKZOHigLrPeDm35AMVz00qSRqMwumQ6vJcNbxYSWqlKN
 TMJPoS+R96AtFG/7QLMuCx5ZIt4F+mYoaw8pu1LlEJpkPdpuyzUGxlSk8/bYJ+X4XUVMAv/sOns
 KSEsCpSRNtuW2if3aetcVC9GQUNGCisxrA6dCuwxVg8yntt+WBv5iy3XjF99ejiTsYwClsLMBCQ
 ycllt1KTWavulK2HLOM7giO/NDaxE3JJmrf/8L0dZ9w7e4Cyynuo9ZtckH2+aoiNGfRw7R6Qr2a
 nEhdxw41hxWzZN2wuvgDBf/J6xSRkVqU4qu9UvUHMVCOw5m2jKReNcXe6wxixxwyUnSb2HzUEVg
 UD6OPWGYZqig9hTfwWwCSH
X-Received: by 2002:a05:690e:439b:b0:67d:b729:eee6 with SMTP id
 956f58d0204a3-67df448e155mr932899d50.85.1795175010397; Fri, 20 Nov 2026
 03:43:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Nov 2026 11:43:17 +0000
X-Gm-Features: AclHuK8RBBchCvZA2BhzAKeH08qHmMqRGGesUMJD8ZwQAs0IQ_PH0soEx9Ls3HQ
Message-ID: <CAFEAcA_He4P=0n2j_DL7P+gDd14jXgba3jRmE_1uBC976iFPTw@mail.gmail.com>
Subject: Re: [PATCH 00/86] hw/intc/arm_gicv5: Implement virtualization support
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Tue, 13 Oct 2026 at 09:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset adds virtualization support to our GICv5 model, and lets
> the "virt" board use -machine gic-version=x-5,virtualization=on.
>
> Virtualization in the GICv5 is more complicated than it is in GICv3.
> This is because in GICv3 virtualization is mostly delegated to software,
> and only the CPU interface has hardware virtualization support. In
> GICv5 the hardware does a lot more of the work, so virtualization
> support is needed in both the CPU interface and the IRS.
>
> I've structured this patchset as:
>  * initial preparatory and bug-fixing patches
>  * add virt support to the cpu interface
>  * add virt support to the IRS
>  * remove the check in virt that stops the user enabling virt

> Peter Maydell (86):
>   hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual value, not 0
>   hw/intc/arm_gicv5: Ignore low bits in IRS_IST_BASER.ADDR
>   hw/intc/arm_gicv5: Ignore low bits in L1_ISTE.L2_ADDR
>   hw/intc/arm_gicv5: Regularize spacing in config_readl() switch
>   hw/intc/arm_gicv5: Use cached IRS_IST_BASER.VALID state
>   hw/intc/arm_gicv5: Free memory in finalize
>   target/arm: GICv5 cpuif: Use arm_cpu_set_irq() to set IRQ/FIQ status
>   target/arm: Only allow GICv5 on CPUs without AArch32 at EL1..3
>   hw/intc/arm_gicv5: Pass CPU index to CPU interface
>   hw/intc/arm_gicv5: Pass cpuidx rather than iaffid in gicv5_get_hppi()
>   hw/intc/arm_gicv5: Use correct type for value in lpi_cache_get_hppi()
>   hw/intc/arm_gicv5: Relax QEMU_GICV5_MIN_LPI_ID_BITS to 0

Just a note that these first twelve patches are all now upstream. I
think the rest of the series is still fit for further review, but I'm
happy to do a respin of the series if that's helpful for anybody.

thanks
-- PMM

