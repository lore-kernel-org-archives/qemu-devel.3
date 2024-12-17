Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F97FE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 12:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNX8a-00023N-M9; Tue, 17 Dec 2024 07:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1tNX8Z-000235-FE
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 07:57:19 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1tNX8W-0005pF-O5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 07:57:18 -0500
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0E8F03F637
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1734440233;
 bh=Rhi7HFzE3FornoPkY++ubVfWbvJGQt7urPEmXmbiH9I=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=I0swwLNQaw3zpx3KmnlFYGTUTuX6xR7upvQCcvkmqRE0Ol4W51Jkhihsn93vqPFlb
 5YNP0g/3m9Op1Kg1qE+7jHT94zJOf701n9NfsLr/kJEGveeriXBWqwg/RcUNTtuzo7
 7cE9cwuRp+VBMXEvxm1kBxJgKURIVn1+MuMz/FmrmZ0tu4VNt87IcSGFp6R2PnpihQ
 CD+fjLNKkI2BAnUfaU8E+gf1Ktahtd5yJBDlSXZgBSDgSsKPs5brBylLNmebkE//du
 RTR1+OOzrIo8pwlXFguuhijw80ouAqWei0hZKaUC6VhCePKyZzRrAHc2AtJ3mMw0Pc
 47cQ7gAWJkb4A==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa680e17f6dso367904466b.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 04:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734440232; x=1735045032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rhi7HFzE3FornoPkY++ubVfWbvJGQt7urPEmXmbiH9I=;
 b=qoAh9x6CG+zaCsWx3uUNeSNVcZTlPiPiWa0o/oHFSTQ28p6m3jr0Id4ped6w+S3kxv
 4BSjtTJ/Q+u0oQCNgMAEpcRkH4Nq9tYFXfeVn0QxcsLUJNiMkzknF6kQlNE59z97owPT
 OGp6P/JFXla+oE9RoscB320w4ibIwwoXPXeqyOKkSJNz6iJ5axq3dv/PLOoELIgS6hx/
 6OtuFJRXT67rEbo13Tx7YX9zBQx38hYx/MOSaKt4ulv8vqjGh3f+m4LVgQ9Eia4TPZcn
 83lW5EdLLj1jQUtjbHUSJS2F5jL+U3h73snSNs3fJSX4Ex13gQBVvx7j7yPCtcu64Acp
 HNFQ==
X-Gm-Message-State: AOJu0YxfLFu7gVZVGDu08ce3IJJoF3lmS1HiVDcLhvomwEZgbo5KCKK3
 SULRfpcO7iLMfBgFeaviBHqUtQbryujQ/SoLEgCyj11/n0X2a8w9WWq0Uc1Shtmfps1bt0nMTqV
 MVvuhgtSp20y6HS1BQD2GICVvvhD1SdvTkLqQBUm65/3LZqPoaTETn1Z6a7rA1qjX1tNX
X-Gm-Gg: ASbGnctwhC267mGWh9kWQlM2R4e0miWwjMAIQr6UB6307SS4JxTGmQCB/w32tvminv9
 gY9EgNZkykHNe2hywHeIVbc9Awlt58Lp1atye+rj9Cj0wYM/MsGXokM7FWP1DhofU94ekoOh45t
 jsa/hQhdzXUhOf1JW5aLWX31wVsxsXWojaoD9tmLqWGv6pllI6P1qzW6gkDSFmCUdeGgAu4eglR
 Yyg4Kxxo4AWI59TO5KE08VAvQEOXPU00EjdfvHHxlWILdtzewPL+hJSqBsuB6znkpxYlUsLBsNq
 7S46kiS+ER0Ck/dk877nLFYNDBGbkRDy/Fvus6P+s+Fqydy+KvvOeg==
X-Received: by 2002:a05:6402:40d4:b0:5d0:e73c:b7f0 with SMTP id
 4fb4d7f45d1cf-5d63c405fbbmr42102945a12.28.1734440232437; 
 Tue, 17 Dec 2024 04:57:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7SHUQGCStRoC8LvakOy6u8zaCN65EXejY1KM+xHIiICg2pgg0INnIQYHZ42nfMHfCpwtQgQ==
X-Received: by 2002:a05:6402:40d4:b0:5d0:e73c:b7f0 with SMTP id
 4fb4d7f45d1cf-5d63c405fbbmr42102899a12.28.1734440232136; 
 Tue, 17 Dec 2024 04:57:12 -0800 (PST)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab960684fesm442291366b.56.2024.12.17.04.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 04:57:10 -0800 (PST)
Message-ID: <830d04a3-04ec-4ab8-9485-baa88ca9f855@canonical.com>
Date: Tue, 17 Dec 2024 13:57:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pc-bios: add missing riscv64 descriptor
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20241212090059.94167-1-heinrich.schuchardt@canonical.com>
 <1108ce53-aa02-4909-b974-e90d99eb67fb@tls.msk.ru>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <1108ce53-aa02-4909-b974-e90d99eb67fb@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 17.12.24 12:12, Michael Tokarev wrote:
> 12.12.2024 12:00, Heinrich Schuchardt wrote:
>> Without descriptor libvirt cannot discover the EDK II binaries via
>> the qemu:///system connection.
> 
> Shouldn't this one be picked up for qemu-stable@?
> 
> Thanks,
> 
> /mjt

Hello Michael,

Yes, please, the patch should be backported.

The relevant prerequisite patch is Gerd's
b0494f131ed4 ("edk2: update build config")
which appeared in v8.2.0.

Best regards

Heinrich


