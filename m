Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD80C0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 01:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdJ4W-0000KP-CL; Wed, 29 Jan 2025 20:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tdJ4L-0000HP-24
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 20:10:09 -0500
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tdJ4J-0000I7-Es
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 20:10:08 -0500
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d8edad9932so2340976d6.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 17:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738199405; x=1738804205; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ibb39tr0kfr54vB2kryGpHcq66rmFUlE7qJTDpb3uBE=;
 b=NRJS06Z6KklTZAGVpKzYCMyQMfL4H5Bjitfi2XAA1resD15V6ORZyw/S5Ha1EDMKUg
 iuGsEB4GRofeuZId8Frfoa4ieRhQTIOYDd1VDDmew6XNoRrXfCBDM/6jHFpZ1bggZN30
 6Tq0atdd9X1hrn6UsDF9/xyiN6jpsojVijYaR0RiEP2tOqgBoMgttPshp/5BNtyl0QI4
 L1vDnFILoh/xF2kY8KaQpymNAFAEn9mCmjN1Q700r5uImQw/H+369W8qHX69Sjk6hl0p
 3wau7xryrvP6ZHk3qkHF4bJlFx3vPz6Z4vO76V0KGRwBHGniFeevyjk/I2HPVYFpWr5N
 murA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738199405; x=1738804205;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ibb39tr0kfr54vB2kryGpHcq66rmFUlE7qJTDpb3uBE=;
 b=VN4P6SqsXJeSeKAXylpfgNFG6r9ws1nDV1KKt8vBWFoLY6k8pCxCoAc+llsi70UsMv
 rPpHWlBxjm/Byr9fLADybwWt9A3lx2kvnlcS1nOPx06+JktjTVY5R5hqm6k4WO2+0CTx
 6JDXBhPSQrD7surGYQ3IpInrzvuTP7Sggve47+P4bsUERSOZvQKP5gJFVyS75steeFV0
 p2X2dQoAceA6nc/uRfJnKOagLtH5NDKqH0S9a6NDJ7Q++/0mIlkZP48s6iZVW1ERKr1C
 9ndxXHmcSyi+8UYOy9YRiazJE95kuPXn1PvxNXdAA+ZJSLULSAJzjSF+fjWrnltfBj2M
 P6kw==
X-Gm-Message-State: AOJu0YxUa6LjlX3x6kNp9jg2E2Z9bQaT0pKAf9m4Frdn+y25GwdfFC90
 0+P2OgRgKcQjTKH/Cu+OTTC6FTgNLP6TYZ3Il91suuyzKvP/DqQOBiLtqMmtH5A=
X-Gm-Gg: ASbGncubbO+gvIozBrCZ8PrR+3TmY+ar0hzvEoNHgym/fzBi3bdHEa3oe8X2tTPP3R+
 +B1H9BPbknp7RPAE0ZA6eKyf/izWUje4TdomVpod6DDd0I1KYiqpmfXpyvgGprB58GrGMlFMlMd
 1Uixnmi8ir6nY9FMmcQX0ObZGuLbL8XrZInWX1oEFgzyXT5nN5Gi9oDZMXVbfMLvJFXe8h/UnRE
 nvVd7oivYcEpEdBDbe3yQagnunWDOTWqetzAQY6XFRLk6KQO6BKYRmvcYdnPkYe6iWuM+8bALCO
 GyRZDdlLdZYTKSpm2c6eZ5dYYoZENhc7
X-Google-Smtp-Source: AGHT+IG0KJXBElY4hyFKODiV9WQn2mZ+SWxjoK7Z9OEhvdXkoq1gWmSTXbuaWowdXpbIi+du4i0pDQ==
X-Received: by 2002:a05:6214:412:b0:6d8:a84b:b508 with SMTP id
 6a1803df08f44-6e243bb84e7mr71133726d6.12.1738199405591; 
 Wed, 29 Jan 2025 17:10:05 -0800 (PST)
Received: from [192.168.163.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254814007sm963146d6.34.2025.01.29.17.10.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 17:10:05 -0800 (PST)
Message-ID: <479d543a-7fcc-4729-bb77-3027693b97a4@linaro.org>
Date: Wed, 29 Jan 2025 17:10:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/hppa: Implement space register hashing for
 64-bit HP-UX
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
References: <20250128224817.24715-1-deller@kernel.org>
 <20250128224817.24715-5-deller@kernel.org>
 <34f4e42f-b08a-42dd-ad11-f720f6d8a440@linaro.org>
 <6f445eb1-2626-4a08-abbb-580cdd7fe682@linaro.org> <Z5mph0gdQHbCsKit@p100>
 <ccbf7be1-db49-4eb6-8ccb-32bcfd3b380a@linaro.org> <Z5pJmQGsteQhMQtI@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Z5pJmQGsteQhMQtI@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2a.google.com
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

On 1/29/25 07:30, Helge Deller wrote:
> Subject: [PATCH] target/hppa: Implement space register hashing for 64-bit HP-UX
> 
> The Linux kernel turns space-register hashing off unconditionally at
> bootup.  That code was provided by HP at the beginning of the PA-RISC
> Linux porting effort, and I don't know why it was decided then why Linux
> should not use space register hashing.
> 32-bit HP-UX versions seem to not use space register hashing either.
> 
> But for 64-bit HP-UX versions, Sven Schnelle noticed that space register
> hashing needs to be enabled and is required, otherwise the HP-UX kernel
> will crash badly.
> 
> On 64-bit CPUs space register hashing is controlled by a bit in diagnose
> register %dr2.  Since we want to support Linux and 32- and 64-bit HP-UX,
> we need to fully emulate the diagnose registers and handle specifically
> the bit in %dr2.
> 
> This patch adds the code to calculate the gva memory mask based on the
> space-register hashing bit in %dr2 and the PSW_W (64-bit) flag.
> The value is cached in the gva_offset_mask variable in CPUArchState
> and recalculated at every modification of the CPU PSW or %dr2.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Suggested-by: Sven Schnelle<svens@stackframe.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

