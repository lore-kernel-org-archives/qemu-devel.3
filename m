Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A91606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X8iCF6o8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJsS6-0004cL-98; Thu, 22 Oct 2026 09:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankushmondal1y2t@gmail.com>)
 id 1xJsS0-0004Zo-Mx
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:03:21 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankushmondal1y2t@gmail.com>)
 id 1xJsRz-0007kq-2j
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:03:20 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-368581df789so1057784eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:03:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792674196; cv=none;
 d=google.com; s=arc-20260327;
 b=keqnXjtWHZ15Yf/RZI9QIDbMNoimgpivvQWHS1THXcnOMa9tx0WuqbOpI92Ne+P6pE
 o19twNTYXgj2EMhmid32mMyhNswk3BjuKx7+AP75Eaq4dAp7nQfXMJQF2thognjA+Y4h
 z4dmIl4JYI7+vsnL4WFwxIo9OKcWWnO+gtCG7EPvBqNS5L79IUd5l3s+ON5F+yF43vVR
 JIlfpqZFfy/wAYeue9npXgBVxPiPl98BM+4y+mcgvTSlH8vECvkaBTLCiAL+DAXhxRei
 Vq10DxJg8jXp/9xN5Ma1nP/zV/YWXvtPANuBWMcgjyUEihSM5Um1IPHuPwWqbxCDNZz/
 C/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Vii3NcW6XWtmFozbEmi44nJqeS+3A6WFgS/dNCC9OHo=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=aty7rEdsZaWofH/HeNj3eltXK7bGgymyBRvmzP5gxV5q5ItKUr5tyWYBCQ3IbSooql
 Iero998mJeyPG4ZRymxRPW2eMSe6b54jtJF/i605q8bRoP7aqs9i4sN/THRml0W7GVoY
 0uhRZ4dmfKQj1LacSRKia0BjoaTqEDQD6Q2YCZ2MsaxHvCUFNhFo/RanPY0H9UuJ40Qn
 ZXUDuhshqj8zOcpD2PGzkYN3vOGry5Y7uUqRiLfX8sbqZ5kfB6mXwfPV1eiDBYkThoq6
 KUzYkyHT7CaOC0CYgXwVVyvbJlzsSKMuLv2d8yfxDNgM9UszuhvhIAotSp4UQEkd8j0o
 nMjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792674196; x=1793278996; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vii3NcW6XWtmFozbEmi44nJqeS+3A6WFgS/dNCC9OHo=;
 b=X8iCF6o8uHXFpONkl85Qkgn/tQ/W2vanILYdX1p61VsILM5jDIl4jMPyVRT8C8mQBP
 hZEz6/vvj4ElcqyF1F7jDr1MGo1/IhAv4zJjqtTTHMOyk8yUYShHJf1KKFNqRk7Bt3V5
 xr7e+vRTk6zVeYQt6wdkKqqMmdJ3rWqshqy7Gy0pw1wXSnvnYarwoLvnYCBuq+Po23Z2
 wELd47V/Q/VpuYFBRuBsow3Jf4OM0ylpC2vJwWHmcjwkDRRrP4uYATn2pccV6xii8Owd
 1Ua0fZr/Jn6NJV1ZZ+BTvnLz+DjDL3LO7yKei+ypi8SBED1PJxuOjYsI6t+4ZdcFBp5Y
 kQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792674196; x=1793278996;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vii3NcW6XWtmFozbEmi44nJqeS+3A6WFgS/dNCC9OHo=;
 b=ikG6a2ApV5kaf/Q6PHG1BSAEwiWDeVkP7qK2eJW57ax2VXH0mB8reeklF3Zqya9hm8
 FFUmQHHrYXKYWPAKPTduofvHopb6W7khYQeQSDGnTFupkloeM6NKWT0n/lCS45Q4nzp8
 cuARa7/vVh0FbLS4Zm6+rEk73WmTddINijpzrhdpNDCK17kQAKmBvgcQ8R2kDtqzRdhl
 M/v3WhaUhwg4O3eoaMWquKyRTUrXkxniPi9LU0dhYZ7jKb0FjD8nHRA86zoRXkFRLYaV
 by51yKrT0LVY7IDy0bmw37qzmGcRdnaAI7ps4V/u5MxSzuq7rOsPDog1x3OksTSft3RK
 fPcQ==
X-Gm-Message-State: AFq9FYK4Zs2GST/uriBTtmVTjCVZn85NAUz1bnIMmRfO+LD+YLOPNYCr
 GpZybvodyABytWeqtN/Z8kiFnSLsri1HogO6eE/dpcKjhVuZ87NmF24PRI0WLlkwjX0mVvJEWgP
 ho4bxdaW98xs2czZRgH/gGtIzXE95GepqOSdl
X-Gm-Gg: AYBFou3g1DfyPInaqZOA2VBuWR8hsUJcRGC5mCWCJaZ+i7vnnL5n4JKKc5xAPWEdLQh
 KclFTg9JNXsR9whk3ilYVqp1+7TKK6W2qvgPIDf9iLFpHrqBFn7w8M3nJgnUmF5LagG65V0MyTZ
 MsWaidZxewRsMFP6v+h/ZHor3xoqSmwSoTx+fmJYGGjr9zplK7UKMcEft0fuhBCmI6umv1ZlrCK
 r0O/lE7FzXZC7RzgyV788mPAxlnWJ4QlRFXokzt9BRdZDIMjctehHhpW990EJamqD+CF98XJSap
 90gOaB9ygs4xiFcmOE7/jL7KXEWg06vVLuNNp3K8ASi3ogse0Gu6T9yfgXgTHczzcaaDIMty4CH
 ymaxwJn5/zGdG73DqX+SNJiFCHvHpdF7nUXNRrkHjUNDQw2gWYGH7MU6A+qNhPdnyPXDJYy4tfb
 IRv27IBOg0iui/EHk6KYbd1nZwQycK8V6Vp6ZJGpMUaL8h9SzuVo63cG4EIaoopgZ5W1rEhDVvo
 xEikvmxOEPk+QquJ8w04IdDw6FJl5Zpta+44bqMdWxZevOv5knA77dYJymSIyzqQ8xIeFCow1a5
 OPnGrjwo2GtiNBMc
X-Received: by 2002:a05:693c:88d0:10b0:35e:2c6:d462 with SMTP id
 5a478bee46e88-368ab6c0a96mr2955492eec.0.1792674196202; Thu, 22 Oct 2026
 06:03:16 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Ankush Mondal <ankushmondal1y2t@gmail.com>
Date: Thu, 22 Oct 2026 13:03:04 +0000
X-Gm-Features: AclHuK9YAi8tOjEdPpP01n1Le9gvA1aHcH-TBP0Su_yMoA0WV7DGO6M8dNLoMXg
Message-ID: <CAEw80_3juSguzQARd0jLxrvRXi09-9A9pYYv-dm8Z0bc7LBDwA@mail.gmail.com>
Subject: How to start with QEMU
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a9a880065e6d7c13"
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=ankushmondal1y2t@gmail.com; helo=mail-dy1-x132c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000a9a880065e6d7c13
Content-Type: text/plain; charset="UTF-8"

Hi QEMU Developers,
My name is Ankush, and I'm interested in getting started with QEMU
development. I'm not sure if this is the right place to introduce myself,
but I wanted to reach out to the community.

I've cloned the QEMU repository and successfully built it. I'd now like to
start contributing and am looking for issues.

If you have any recommendations for issues or advice on where I should
start, I'd really appreciate your guidance.

Thanks,

Ankush Mondal

--000000000000a9a880065e6d7c13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi QEMU Developers,</div><div><span>=
My name is Ankush, and I&#39;m interested in getting started with QEMU deve=
lopment. I&#39;m not sure if this is the right place to introduce myself, b=
ut I wanted to reach out to the community.</span></div><div><span></span><s=
pan><br></span></div><div><span>I&#39;ve cloned the QEMU repository=C2=A0an=
d successfully built it. I&#39;d now like to start contributing and am look=
ing for issues.</span></div><div><p><span>If you have any recommendations f=
or issues or advice on where I should start, I&#39;d really appreciate your=
 guidance.</span></p><p>Thanks,</p><p>Ankush Mondal</p></div></div>
</div>

--000000000000a9a880065e6d7c13--

