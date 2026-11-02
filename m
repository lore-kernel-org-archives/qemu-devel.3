Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F427606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 04:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zjCNPG9E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNjno-0002VP-8O; Sun, 01 Nov 2026 23:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xNjnm-0002VE-V8
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 23:37:46 -0500
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xNjnl-0001li-F6
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 23:37:46 -0500
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-369f33df08eso5246759eec.0
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 20:37:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793594263; cv=none;
 d=google.com; s=arc-20260327;
 b=HOP5R0YGrcLbJCtGZccvmOpY9bzlM0NoTUvTLFAuKuYhg6vipUrFQ55ePTb5E0CPbu
 i4jbdk7C4SdU7lo7NiqGYv2ZnQ3ixYFN2Rj7dKHfTcJ87HV7DXSpaj/JhJuUgj4swbZd
 aWUFwyC70UsNwUflPXzUMKMsS4CLWqHTJpYwkr/g7Z02iV8sTR3kUfpJRnQkDt6QjIZY
 UJm5e1tFVZ+weTmgM6tW/XFohg5FfLUMzMhghXAAoY+WCAXNLOSRaNSAAqs3+TawXsNM
 WvlH9A+tv+med+Zn7iUX7funtQCcTeWK0d8sK//vKNZryeU7vcFXQECKQUYJs0HU1nNE
 r7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d9xhA7mhp596/P3Akjgkw9ezQTZPw3FEjGMGcRwbmFA=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=Kjot5/ziY/Jh1WNfXZcPuAnO4kagNtKxTYYXDIGP712/++PEW7uBOek51Ig4zGNgVS
 pbhLvAi95J+IzBa9ADLi7Nr76nGL3bRrPf8M4J2KEPED85L8XirRgQctRMBoJB2lrWM8
 E1n9oqOzB4oBi/wFRc9d+gX8l8xhJvxBgfM3gbN248nqr1dDoGwE43Obqr9cxlNNIGL9
 dggAgNYjOhsebvRFr+8So5CsvRfGavIW7q1KDFx2/UcMdzPBR6lBTOiYBdtD9sEP8pZ/
 LJ+W1XBt2sxMo6Rru/TpszahRo9k3AMaDDGqeoLbtOI1M2IfQMheMbyouLH6QCFzhF4y
 Ib7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793594263; x=1794199063; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d9xhA7mhp596/P3Akjgkw9ezQTZPw3FEjGMGcRwbmFA=;
 b=zjCNPG9Ez3A+ZHzAyppYX1js3BhrO9quO2ZqsD8uIjUXY3KmFV2kUw6YIIC3f5atpm
 EFHnuqE8MQ+WZUOF3ah2oWJc3qBvJ1n87WOcM1GVJ3yQWtQqcC2g/EwhqwE5pO09GI/E
 8aXtKLKCiXHQTYNAh/e+4u8YS8eGz+XaCO7YCVV8J3ut/ZjTCWbj+DJLQmHlIfS21Lh+
 v9K5nLRF/zclMYdx7r+cQ/xD+1CeVh4FLlalCdr+k7pnT6fWf705JsKi6i1NcoOW2/Es
 eflgNVwgkaCHAYqS3NbLkzKd/f2O0Rp66oDN7CVwrc15plp3llRi5F2f5FMbjttik+xf
 8ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793594263; x=1794199063;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d9xhA7mhp596/P3Akjgkw9ezQTZPw3FEjGMGcRwbmFA=;
 b=kBqps+FgvE5NLIw7zC6LWmrYvwKc8v74bpVlkMQKXzRtNp35YilbCbFaylHEM7SCml
 9qov3/gqao6iBmsniz8Bw4ZtCW4HXjnaBjnu1hDGogTpvbX2IcYN0n2CGk8b3+CKgQmW
 C4DiYA4DVoGzygwVAOihSKNdN/q9ci+q6gS1BdKDpIWh0VsYYHHLSUd9UQEu4+eUqsI5
 9MZyP4PnQeme7+nogEcMeU8WEQt/bgddWegE6xEzbuxbbaxFVu8ZdXwqBs1OO42xwRJT
 /N0nVB+jaAXqU7PWB64KYVL/Gut8TXHHZOCdY2UbeakUEmKYEoWtPP2doEN3VMU8TfiF
 oYwQ==
X-Gm-Message-State: APuU4Z8YlLKfMPojlUTtylEFcTBMihZyzy/b42Jgcu1KZEvwZe0mjfoK
 ZvjlbNh/LILfIC4GH9yxwS2hzqNzcOWx5iLlseuGsfovQ5a6qyEX/vRx7wLDjkxMexPwPR3WgbC
 QxVdFXqXlxw4LSsAQB6fgTl6hu9YC8bw=
X-Gm-Gg: AYBFou0BVD6vYsRQNb2D2yZHGyM/swbo0h6pI6B5CNTm7XIlV5gXueDEGv2SRGbUJGz
 78dGuhRqNB5njv/nwSZvdHcTwwzF+Rf3mhrNvYrGEN0KeSNkpGsEHUH5Jv0SHBrQF8WCMzGBrrF
 kevfsMj4vpicopwZ11Ya3qXrzMjkk1TmNi4l8Go6Vk5lw/jolPPPpaiypotDJmQ3wX9+2K6iNmP
 mzAeV44Og2KIzrxMIlCMEhL8GJsozhHaDw/AJTBBmBT4Y6c2CZhqqvvC1DK69HDk/QS9KUxbgKf
 m3xwl9C3f0OF0Fh2vDw2jdcPlSlqA8cJB3dR0Ug0XI0zFXBpSPEzQzHiGA7RMSC2Mixp6rDfRsB
 cDwW3gaNy216HfXNUHjc/CluIlxEdmYHTlXPXRx6oxhv9ybLDsgPEHiNjDdfp4u3jKTCYlOtGfy
 6ULql9PL1SUTpwzcg=
X-Received: by 2002:a05:7300:e9d3:20b0:369:fe81:a575 with SMTP id
 5a478bee46e88-36a4243ab94mr16363989eec.35.1793594263225; Sun, 01 Nov 2026
 20:37:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261031082849.1306244-1-pbonzini@redhat.com>
 <CAGscdFu8E6q6CObDiMbxje1UOZpnO4CiQwFmABSgv3VxGhHqqA@mail.gmail.com>
In-Reply-To: <CAGscdFu8E6q6CObDiMbxje1UOZpnO4CiQwFmABSgv3VxGhHqqA@mail.gmail.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Mon, 2 Nov 2026 14:37:31 +1000
X-Gm-Features: AclHuK-VhBNvTpxxk8462POck0hFBZGIcVv2QW42LS3RNtnNcUZBktHwMOAMFak
Message-ID: <CAGscdFv4KLOcYgd-hY6wLZz=WEF=jTQcFibgU6nw7exxDShWSA@mail.gmail.com>
Subject: Re: [PATCH] target/i386/tcg: reject VEX.NP for MMX instructions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dy1-x1331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Andrey Polivoda <apolivodaa433@gmail.com>

