Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED7606A89E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JLtBNIAA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwXZ-0002N3-NC; Fri, 13 Nov 2026 14:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRwXM-0002M1-8r
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 14:02:16 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRwXK-0006ty-Iw
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 14:02:12 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2e9ae391a05so8076085ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 11:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794596529; x=1795201329; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nK5dNfi2wW+menjvPweGxKkSG7Fk0qQE94xB0x/3Jx8=;
 b=JLtBNIAAwenVouaThh+AVoWLYgKf3yEHm5uqnwNsPvCpCjgY56UPAdMsC44N53hxho
 lFyzZHavBjs6W8oDewfd+aoWHnVwKGckI7C9Uqjyd/Np4CtKgC64hSmVGf37QRyfbM+F
 +9cFyLmonJYmuY7ySIHqO3xj7hJSZ8eWU0YIX4kbPXiOn3mpWznXJNSE7JywyNYEMown
 WNNQyvZ/xmXTWLdqh3AaILQzptOoaJQL3yWZI0A0w1BZ9f36mLqCfPBxjscSIMLkbUYX
 sYgca5pr0izRzapZO6aNN1273n2qPLrouo00mrH/XfHn/3sF0G4wvxE6fKpftbevzub/
 iJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794596529; x=1795201329;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nK5dNfi2wW+menjvPweGxKkSG7Fk0qQE94xB0x/3Jx8=;
 b=SIrtQVEJRKfWdhoYdxJMIPAPifpMioSFV2Srirs2lJ9SbH1PVabIPYiDKZ5ymBTuQU
 1tSIKVfPACFB9w4Y3VtSlcunyXlrco4xAeITsVwFHMS7tc/RbMmuvcW6vAOUMbBecJbl
 U2DV5XJ+lGk/Rbirp0If3JBc9bW6vsfXdNukrfd7F4Dx8j3LhaTFDOFoWKxl/Qp1Y/qc
 +7uKWPJWCvvyID3a7HAIoXBOgUOinL7Mjoo9Bum8krWGCA8ROeVDLHolwG0J0mt+RxFl
 5MkgrYx0Yd7htt+uGjSGYHUR+xVZ3/OXQUUW6Nksh/ufpkiu65y7nZ9oaHEf9C81QTvq
 RoHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGnMbClpAKhtEDMUjzlW7bi16dxr4lP+BxVF+k7nRhAkuDKN0fa+CwxHb6wEKVaImIQjss6uxhgv/7l@nongnu.org
X-Gm-Message-State: APuU4Z99g4ieLxqPTM++V3h5OxTEId12pW88Dg62ApSyVkU487QQHbnZ
 X/zouHdwtXJDrOhDY5IyW2dMfX3bDBEP6kbPViB36DC20AUDJj69ym/FGm6bxWNTF1c=
X-Gm-Gg: AYBFou3lBUxRDwT48Y5OGDT8KKCsAOdPLexqi1S/lCyyPUcBBKfHNWjgh6mHdsLzVmO
 wVk7yR0FUmCoNI4vjecHycPiBg0ZqAnnwrCWocU+ahKGv0NHjh2xsxaWwR2Qk1FUw9omruWDMOf
 Mara5nSmepcw9QvyVQrKufG2QHV7v+sJVYGWosspsoWMaL6UM9FsrmA97+2tuLRgbESDdaYeH4Y
 RBNhBZq5HUbMJCbIs02kFZgfEinP/qfZN+AZDRY5r1f7046LhvpWXjvotRIxoqcf5z1JqTlEp6U
 nGo0WVMY+3aznVnHWhiRuG3OIl4DVliZvOfdpttnFtOTha+XxBsMfKgYUBkXcGOu7+tHtlRj56t
 GMuvOEBmC1J/C3ojhN4CKmvDzV6PiEijDkMWb8CHNCxcWNbIhnG0X2F6fjnty1A+qhJMCfFr0pS
 VnntsYRfJ9Hc1FEO3VIgaVO167EkYATn0tRZfM9s8DVpArbu1wJLIuBoIdvK6IAaIDY/iBUMvkj
 CcLl2Qk5TmJg4iMT5zgyUKu/zJmMtJjTzfDgcmtJIzJPuoEPAM13ywL0rfHt8/RqxwfX5UwDKAs
 6ckW++nD3ivKswlkAa5+qrV4md9/a4sqGQbnJswkxLw=
X-Received: by 2002:a17:903:3845:b0:2df:b510:cebb with SMTP id
 d9443c01a7336-2ee0d9fd788mr26567535ad.6.1794596528588; 
 Fri, 13 Nov 2026 11:02:08 -0800 (PST)
Received: from [172.31.6.230] ([209.52.143.85])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f8d4612sm14575475ad.57.2026.11.13.11.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 11:02:08 -0800 (PST)
Message-ID: <3efcc609-7804-4993-b69f-8a768b9a3b6a@linaro.org>
Date: Fri, 13 Nov 2026 12:02:06 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/6] NBD patches through 2026-11-10
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20261113143132.2414774-8-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113143132.2414774-8-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 07:30, Eric Blake wrote:
> The following changes since commit 4bcd55a1f4b926ae86872087f7f3bc9f9e1d065e:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu into staging (2026-11-12 21:14:41 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-11-10-v2
> 
> for you to fetch changes up to e682c0e570179bd7fa01ea896358a8cdad196a3b:
> 
>    iotests: Add another nbd-robustness test (2026-11-13 08:02:09 -0600)
> 
> In v2, defer Guillame's patches (the bug was minor, and the unit test
> to verify the bug fix was flaky) to a later date
> 
> ----------------------------------------------------------------
> NBD patches through 2026-11-10
> 
> A few bug fixes:
> - Eric Blake: fix two low-severity CVEs with non-compliant NBD clients

Applied, thanks.

r~

