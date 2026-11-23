Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14874606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D+YRcYo3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVahV-0004Xw-Qg; Mon, 23 Nov 2026 15:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVah7-0004Tn-Qg
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:31:23 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVah3-0002IR-IO
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:31:20 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3b41e5a1719so1515069a91.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 12:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795465861; x=1796070661; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AHcxH/1OQqqU3R3aYzlePs5OSNd5p4QRc9OZ2UlyHBk=;
 b=D+YRcYo3eX5vUsGsLQtzS6+FDXMgJPMfajjPT7ONTiBx9+y3l1DHOKYk3xCToZ+xSN
 XVBpHPYHE1mFDPFyPISpa//a3jLRQTrN+VgVLTn3O/GJgz74ahac2MeN8OzryacfOTfK
 mvEOoROZYpTMzl7VOpTuluKkoNBaSpQMHQZuRH61CrShSV8nAC2eEZFWUHVLGNrKxh2L
 /EJ0K7vgTMoFBFXvM1uW9eD2VSWHcvYQoVmDV1UM14AtXrnhDE7oKONjInxy8KfwxJBZ
 eRY8VamMzmDKssbrzS5fEkDEbrsWIsCDKNAjkCn2mj5uU5HRp0HtdS6A7/RM8TnIIwif
 lO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795465861; x=1796070661;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AHcxH/1OQqqU3R3aYzlePs5OSNd5p4QRc9OZ2UlyHBk=;
 b=zdIMUO95aNtBmfaqjEOgViNozNZtgWYTmKsz2LPaSkWuP8h7AbsTpfHCnJoUKZ7oMz
 qpRLQPgaWJguuqJ02rKJwiyIlCUD7b29Fo/68BLRWoB7B/t9fLQXE1Rtz6YOPd7VaqIo
 m9RRnPQlYLL9LzOrpbRlrFyhSzbZ45MnH49fdDbmn8HiL8wR/Y7u8dt7aP6LmSypq3tY
 EDaeZPgEo3wyXuvuGVG53FRcyRJgvb9gh+sFQoLFJ8/WCErAyS5TKea6+wguD3wTJOCv
 fRJHULp9biOyODxTOZcGy/FUgIU0I1weLSJg4PNYp3s6uNV4CSmCCga96Oy8nD8co25r
 N+iQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGc6RybPfrsnnhVW2sOgF40FxjwzMqRF7x/Sa3P10LbJGF1YJTjcOokdbcADxNrekrJ1rEpM7E4NfAs@nongnu.org
X-Gm-Message-State: APuU4Z9H6PJZ/pARs7/plbG3j2+NKeBZ/bLTsZv5BmEkG9/C0JoFlD+o
 S/FfIg/kwggkBVLr3T6XCQ3XOGN6HbtuR8WWnJRNCS1YnWpLApS1NK1ymeDXzDTBlo0=
X-Gm-Gg: AZFdTZfALVTvooXwezJcuI4OCxdpPkqCBdwnd9CoUprbz+jsspo8TcFRFoaYU6hCWVS
 0G/0RFlJFispTPwKIqFPCwqn+388t7Hi1habqq9skkGB5EFiy0MxM/Mot9ulrHVAVaKBK6jhXDH
 D2OhrCuRWdq9Ft2ngOq5U0KxG2xYBKRw1tiAyt6taDjOjSUuPfpiFL2CtacOUFzWApNtqRsKt4V
 IhfJmCMyDoGwUXcz6nnwFKQAHA2pIGWqHsVaPMX2EH+8Zoil07UV5G9pIKUlFKpdgWBMSIN2Y1T
 Ak9VjMpWIQTi3f9rEEmgEbPyr6q6FsIrJNf0vUoFr+PT50Sw0H5HlmlbXgtvKPHQSJbpkRV0tQH
 DyDrgj7wdHzGQGG/JbJq0pZ7WuZdzHk1+89D1rS5JEnWahO11r9Crqei88ANZ/X78b73d+YmGau
 l+QgJgDqCSk4kcIOd3suqfcPY85LpIyDCe6fx3iPI8HCTt6A1+gyao9UPTn2LefQNs4BjnDwENm
 QsmWNai9xowO5pk/3L9pPaGoZtdHwezrwPrmOHjjmIvRpqWRh1BgcBly+ma1bH7qOUfoszLIxNU
 h7+LmMQi62tgDkZytNACIpBKMJCjElexbAdxG/98vMwt
X-Received: by 2002:a17:90b:57cc:b0:3b4:f23:43f8 with SMTP id
 98e67ed59e1d1-3b41c908fa4mr10461129a91.20.1795465861021; 
 Mon, 23 Nov 2026 12:31:01 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b44b6fe711sm7918152a91.1.2026.11.23.12.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 12:31:00 -0800 (PST)
Message-ID: <3bcdb958-781a-4132-a30b-8e1ef7ea8d79@linaro.org>
Date: Mon, 23 Nov 2026 12:30:58 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Switch the msys2 job to use ucrt
To: Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org
References: <20261123131427.209394-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261123131427.209394-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 05:14, Thomas Huth wrote:
> The MSYS2 folks marked the MINGW64 environment as deprecated a while ago:
> 
>   https://www.msys2.org/news/#2026-03-15-deprecating-the-mingw64-environment
> 
> Now they also removed the mingw-w64-x86_64-libnfs package, so the msys2 job
> is currently failing. It's expected that other MINGW64 packages will be
> removed in the near future, so switch to the UCRT64 environment now instead
> to fix the issue in a future-proof way.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   .gitlab-ci.d/windows.yml | 39 +++++++++++++++++++--------------------
>   1 file changed, 19 insertions(+), 20 deletions(-)

Thanks.  Applied directly to master.


r~

