Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AADCA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 12:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuVI0-0004AL-3n; Fri, 05 Sep 2025 08:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuVHu-00049V-An
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:11:31 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uuVHn-0007cL-IP
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:11:29 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b0472bd218bso366351466b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757074277; x=1757679077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1nQyTmXjVxTZ/4eS6mGy+xrpmacy08q5/7ftfMaEFM=;
 b=pyg0+KqAQjnqKec1K1reqX161nF7hI/WspnEXPVvfxbS0PcqGo4L7s9gWo1Yd/Xan+
 A+V4STGxp9/t6LSIdEE26zih2y/g7iflRs5aop4MyVN37vqZS7tpZA6oWGT7kSExJepT
 j06/3qwHNAeFt0n4MjLfNmaWghpR+vb60M3frzR/qxVM7Oc5UtTsd67Y5AjpbzGrql6/
 aa8JBrp8Wdx5XXvjGh3CAav+gOwOqi82DnAbR3G+YyhCibAenPf6+028sPajGVYyiIcb
 9knCJBgg8zxAjJsN3c5OBDLXh8toS11L62B9gywNIX/b8mlHasKMvRZ7mesw4L5iDgVX
 N0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757074277; x=1757679077;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M1nQyTmXjVxTZ/4eS6mGy+xrpmacy08q5/7ftfMaEFM=;
 b=gNpPuVlU0I/QE3iVeMTzT5os9GazoxhXEgiVwcvZE1JDpDsdDVvYn8A+ANulCj7Zxt
 oVObETrtWdBrO9eMIUOBQbpg4eqqEouAybMQ0GqD+Rb/oHAexpmFyiAWZZAZejXbK08V
 rpzm6xfluKvnx4pyM8Mhzs/4At+07Ao6rHMCMoJHOdpgC9x/L3bNKxFP9tG3qNGKtU1A
 pyWssmcFYdbAKkO/g3E1tlCC+0Tm7odOCLcgmMd9yuJOu/RO03QH59Q3w8fRBgvDdKsg
 dxsdqOeA+cuCkIYHu0KDj6akomstgNutntS+igjDUBkvRTQV4ayDy8Yza5WCUTpEj00I
 sIQg==
X-Gm-Message-State: AOJu0YzUCtghO5bPvMV3/jVBp/3GHjr7jgEaWdT/gBfWWGlCvmVGnzjg
 YhQBTSZ1E1hZMSyQOVUW87UwdhJyA62qfNxIGoLHIu5p0zY3IeiSiJRjzadwqz7XYjyzvFBzgSv
 73jkzeWWjZA==
X-Gm-Gg: ASbGncs8yuc1vSoicUEYiPW5QOaj5he7VZyl6sjMyeqdsXzGwrTVFFjhq4VGuGpb1tJ
 PadIxRhp/4ODCBU06zvrbsuBAoliPfhXkiSP7hc60n06NaobPePeVbiJtEctgxD0k1oyFHQo2Cq
 XYyumMtwYYcApmOuXJSxJlRsaVoiU7y+/eLHfvZm+DIwP2447r0QEvGlQzU2CFV1NTM/Xyk+YqV
 HMpmIydfDl51Rhh6S4TPyVO40h+D91sZ9FyC2yDWBb5BdsC7Q560ADyz/N5h+6RspLXYhuqrVJb
 32NfzTYlSaUCONTpAoL8a9J1zHZV+Utu86SOJLnQAyuzUYSZEAPdqWS6/7qJDe51M4nGSWRwKcW
 mBBMBse2T04DC/eA0xiNHdyc=
X-Google-Smtp-Source: AGHT+IHC2RfFG59X7sYsug6KIuyGRaGQu+aEJt2SNrCiE1v3VhR+o0nljcXyrTYFTZU4p/kuiAz95A==
X-Received: by 2002:a17:906:c14b:b0:b04:85bc:a90c with SMTP id
 a640c23a62f3a-b0485bcac67mr561413166b.48.1757074277435; 
 Fri, 05 Sep 2025 05:11:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b047011daa1sm572502566b.79.2025.09.05.05.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 05:11:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC7705F879;
 Fri, 05 Sep 2025 13:11:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Failure of func-x86_64-memlock
In-Reply-To: <7ceb8d59-be3f-4dad-9e2b-9db62fbf92cb@linaro.org> (Richard
 Henderson's message of "Fri, 5 Sep 2025 12:26:08 +0200")
References: <7ceb8d59-be3f-4dad-9e2b-9db62fbf92cb@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 05 Sep 2025 13:11:15 +0100
Message-ID: <87ldmtw13w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Hi guys,
>
> This test has been failing on my laptop for a few weeks.
> Any idea why?
>
> There's nothing logged in tests/functional/x86_64/test_memlock*/*,
> which itself seems like a bug.

I wonder who actually is running the test because:

  @skipLockedMemoryTest(2_097_152)  # 2GB

means it just skips for me on my beefy desktop.

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

