Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BFF606A331
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zUMEu0EO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFl9-0007Wu-JE; Tue, 17 Nov 2026 04:45:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTFl6-0007UG-7r
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:45:48 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTFl4-0007h5-RJ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:45:47 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-67be9601f31so4400975d50.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:45:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794908745; cv=none;
 d=google.com; s=arc-20260327;
 b=GjKsQay2mUeutWf8IdeEn6izw3IPFy5x0MJo8Mt1B26FhQ9bh7RBRMJrLD7Zs3Gm+A
 wAq/ol8w/OB5iwy0xoGmW+vwgVbrrAqKM7HMCyMZz4O/F1YFGOSzeP+TYSYXEW8hr6TL
 F83KI9HmzQZoeVqTL4/86IKj4Zzi9dDwkPBDfPDQJGs97nR1ipzpDENygNV/iu7V2ny8
 zUROw3pOGUvXeVu7JwTjXEXqyCzPJjJGxlxZN3DuSk86YEWxqvps50D6kOlly3O3QSSS
 ZWM2Ot9AaKczjbPBJzR7bMDBPFpAcxyHvl9kCOwqVF/8zfo7D/CRqAKGWlcFCKJgKdfL
 INxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cXLW1TFTqk6QzYowNmlYguXRHAYGMCOKg9RtADANrwg=;
 fh=aFzTTXHANK0AyGm34Uzcfq4NFB8Fzm4oQtoxllDyHJg=;
 b=Z0m9Fwag+QTuRoLdtZxP5MxCjQKpgu+wFUr+AnSZkS5KmfBKkmw9PBlZ9UMiTY1t9D
 yJLwotwG2Z9plod4TvAclU/pdwXfPwC0Y7uewNi4znVK658kUnH4TJXqLoFDU9dnXkI6
 wS1ZjCaeaTURmOZdZGvsRThkKAc2sUynXr8XzqCud/hfQ6MH6Vj1CoFQvPs7kellwQGx
 7yHdSijiCbeWZM2R5OVyeTbhHQ6Dw5F7Za/ZpFhH9Ntu1iyApi/i2PSj1BbMr6ok3Nvw
 tczWNZGh53p0siQgPwnRTdkVX6g6hbEMjF+0Uuec3fadpM6R0NkZ7nqox3wu+n7NmCYk
 nLPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794908745; x=1795513545; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cXLW1TFTqk6QzYowNmlYguXRHAYGMCOKg9RtADANrwg=;
 b=zUMEu0EO5OPH+pTzYt5OI21e1d5SoJ9tzqvD8kUlF7pRnzZrh0MyyQyEaxSCRW1kzR
 UQcj401/45dIsNW/uI0DvvjRv82Ccc0E5MhFqH19BTIeympqqLrJ53KIlIylYswFs8xo
 24CVHCd4ny3Nq7KYOPYkz+n3OTTCc3JEEAyL+q2k2zEnTnb9NUJhmDlFniGjcU1ts9yH
 tyi9VmBl0Cqzwz0VLq3ZgpZBqANJDmuCa30yeCrQy6/Hx0H3HzmhbRkYtI7BRp6TVIdP
 1sNAtklSgQaCqfOPPp4y5OKbHnSb4mI57iYYZDHDc0LgLAyaHjtuGpuFxrrx6Pat7OJB
 K9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794908745; x=1795513545;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cXLW1TFTqk6QzYowNmlYguXRHAYGMCOKg9RtADANrwg=;
 b=BCHRJi8McyCyt3dXwEzx6h0BbyZ/g3i5drO27ECpUyqHottJl33ywmn0PDKwNou1+4
 muS729Js0ZDEj2H0nVMesWxEOLCSBsf5RiljJIWcbWrlBl9oNMZykVmQbZvS3j4hD7Md
 DDEK/5eTc5llDfLz950btNY1WNmJwuBmAIvZPy1iu/3Dvv7VPUV3O4Nuj9+/2Di936m4
 RieuFiT7bqYHFWLCe50rZnhF8PfIZqVgRZJ702K8h2yMtf2adr87dC746kDKWDbB0ebE
 Ro4Q51sltFQAnZk7xcHlNefpO6KF339GkQYghjNt9fJebMRMSWdpwL8uPuDxWH6TxAVe
 CywQ==
X-Gm-Message-State: APuU4Z8bJFrIpp2364XWPaqLBFbRkkTEtqcS1VSaHwBiPmlKsfi7bkmM
 up03bSeW6a6sQXrybXBTp0dUPY/lw5itGtgZbY/3kTw4Un8NeKe4ChGNin8SYXDzoxYxdUUKc71
 HyuOR4nbiugShOXavRoh/5imNEv9X9yCnuoViyZiA8w==
X-Gm-Gg: AZFdTZeVYDCOMVtQfjW/jmf7GcQD6E0HlAmVLrvWHi/42zq1uwRWhQkdCtW6Frt+Kdp
 Ms1JTDgVHaEnc4QoCiRL2qThaNx7hFThMPtWVWqXkPsHudHbrLpElW0fcyuwP0l1/n5EkiMEJQA
 f1ULfmBnwesc3HfFwQNXe/FQYwwcaXKDdE6HDIimD7A/U0CHJ2W+OJU+5grZ6eNpjC0IgY4DkHT
 f32ixvAMpCTGcONhBzxb4tn59s6ld8P+aGTT0ig7bxHpGQg8k7NjdasTxyLZa3CgpHJgNSoPMIv
 F21XgYeApgQr22R8ZJEINB8XgoMGgloEXZTGEQqFti1YrzoFNNMxetCMEH6zhngwOFHulrW9se7
 yn/VmB7eFC5HjVZewbBoSAoOjcCA0KC9feNU+LpS16NqB3bCKm5lJLoCUT/lkQkyTfhLEUwZWDu
 gZpIUUltbTKn+rVer448Q5
X-Received: by 2002:a05:690e:c8b:b0:67d:ae54:6efe with SMTP id
 956f58d0204a3-67dae547d5emr3170213d50.83.1794908745041; Tue, 17 Nov 2026
 01:45:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116205758.1340618-1-farosas@suse.de>
In-Reply-To: <20261116205758.1340618-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Nov 2026 09:45:33 +0000
X-Gm-Features: AclHuK9igEp0dcc-XV7mOVybkg8BJ6xiMupXsSSE7hU-dqpyOJb-u9SozgdnhnU
Message-ID: <CAFEAcA9Epdfh-=-mrJfGJtYEtsibnCBXDDvFWGSQ8eLUBTP7fQ@mail.gmail.com>
Subject: Re: [PATCH] qdev: Use g_autofree for visited strings
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 at 20:58, Fabiano Rosas <farosas@suse.de> wrote:
>
> Use g_autofree for visited strings. This plugs leaks for set_chr() and
> set_drive_helper(), the latter verifiable in qos-test. For the rest of
> the changed functions, it keeps the code uniform.

The set_drive_helper leak is already fixed in git by commit fc8bb17e476
(with the same changes you have for it in this patch).

For the others here

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

