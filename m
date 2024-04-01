Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B000CD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 19:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrNlL-0002IV-Ar; Mon, 01 Apr 2024 15:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1rrNlH-0002IH-Pt
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 15:56:07 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1rrNlF-0001UT-1n
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 15:56:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-341b01dbebbso3973966f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20230601.gappssmtp.com; s=20230601; t=1712001363; x=1712606163;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b67cjAq5fyonXOxWAmOu+89GTNYLT/hUev5pUAUcb8c=;
 b=twcvxrj3Dd8W4DAFS9u0DFUv8FekDhc+4Jmm8n6uNoi6bCRmntLeMWfLEvXI/fVaq4
 iypNCv8w2fwmB8vq9IbcAMMD2PDJrq1RRugryyfPQw/cUbCu6xPG8hjFxHvwOTKHsnc/
 qkH5L6Uui/eK2+IPKW5V6mfgSk6kGp/1i6/8DblRZRsFRUaKvKLY35n2i3rmUYMZV7g1
 WX6A8KjqKYbNUJgkP6SkKAX0v9yBHey0qXaJZQSLBvgo6SDkAjoEr5qcc9Nrx7ne2ph2
 Wzbx+exxGX+KuUCgFFFD3254+40+KpdwkHcbKIcMAy3fY+MyhAlAEHMN8lddQgEacZlE
 smsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712001363; x=1712606163;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b67cjAq5fyonXOxWAmOu+89GTNYLT/hUev5pUAUcb8c=;
 b=Ihn1LUH22Ke/TZaRp1Vvnpb3g8d/kAijIfTqa/8mCoRQjoncQKr/5VzcNaUGlQNGMk
 N2sAnocWlkCSVMn4k9AFRhIBXhko3vw3cMLOFETFWHlTQxJTHcLNAQvYcJtZb1VaInMs
 RShUYJspYyqYrBL2zQixdHV4r5uuPJNFG77lz4+nfmqIX7O0zxRzME4zlXzkHoTeNqIi
 Rrxg+DGr515GizuANDF85bJctLGp/A7qJBVD5gecNIpwcWQM0TwZozaySukA+JQgKtWz
 Aj7ds9jVGCtAfdlRiw5KMIQCJh7y6B45G+e12OrIZ98aM7q0wCSVHaFI5nXK8n+eClKS
 WHlw==
X-Gm-Message-State: AOJu0YwjFRLjdE9YImGy+VV3CqO+aFnOGN/7+am3kxXUk26aaxtkJmpK
 Ssd3LmcwZDH0vZNhiQCgD47zZ6XNk/PzypFjEm+A0aZIxZdUCDOIKURrZkx+mhJYpGzvSxax6Uj
 Z
X-Google-Smtp-Source: AGHT+IH5E1/ZhBHmz47Xa8RFf4LnEPnSq7hAh6uxNmioi0gOrDiBhh+7c9kQJkb7EAgxF9rlmrRV6A==
X-Received: by 2002:a05:6000:1111:b0:343:42b6:532b with SMTP id
 z17-20020a056000111100b0034342b6532bmr5235813wrw.46.1712001363464; 
 Mon, 01 Apr 2024 12:56:03 -0700 (PDT)
Received: from smtpclient.apple ([5.12.109.62])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a1709062c4d00b00a4df82aa6a7sm5566576ejh.219.2024.04.01.12.56.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2024 12:56:03 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: /util/cpuinfo-aarch64.c:58:22: error: 'HWCAP_USCAT' undeclared
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <47998747-e990-4c4e-be4e-d0d38b43e9d8@linaro.org>
Date: Mon, 1 Apr 2024 22:55:51 +0300
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <63E7268F-D9EF-4F7C-BDA2-469F0BED2423@livius.net>
References: <8386D452-771E-4E4D-ACD1-F871BA458691@livius.net>
 <A2BE1ACE-3764-454F-99B4-53FCA9127F0B@livius.net>
 <47998747-e990-4c4e-be4e-d0d38b43e9d8@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: none client-ip=2a00:1450:4864:20::42b;
 envelope-from=ilg@livius.net; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> On 1 Apr 2024, at 21:48, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> You were told back in September that Ubuntu 18.04 is no longer =
supported.

Sorry, I missed that.

BTW, according to ubuntu.com: "With Ubuntu Pro, the 18.04 LTS will be =
fully supported until 2028.".


Regards,

Liviu


