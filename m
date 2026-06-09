Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E55BCD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 03:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWmmh-0001fV-4h; Mon, 08 Jun 2026 23:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wWmmY-0001f1-N5
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 23:05:39 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kirandeepmaan45@gmail.com>)
 id 1wWmmX-0005eJ-5j
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 23:05:38 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-36ba0ae0daaso482747a91.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 20:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780974335; x=1781579135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X9AuhcAM1be/OM54/90kpBkw4MPDnVPNK+6/HbyUvkg=;
 b=ZyMpdQsE2UFuOshRRqyvUO+QAwVMKoQeitZU9QSHVH24ZPyzHZIpHjSKeL6Zlcfzuh
 z0ftDA0OUa/7iL0Tek+zzrM/zZ/VnZ+zEqKmyG8LpvsmH8q6OB/zf6d6iZIg255M8eIG
 S58uLlB8qfc5ZQta19bOcts6FRsADAnmNTWVmk/oYlnKL4f0nYMfH8EJ1DgfsrvzuoNk
 o9aIrc12M7r4c4R149oCu9kqx1VQChjAploDagQq+FFZDkBflB2ZlThlJTTA2PqFJ0cw
 CXZM0Xkix00yAjU2tClPYYJnLsdE3LRPc70S5dxIvGtdRNuRkjmgxyOwpY3Oy+OyPTuU
 n5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780974335; x=1781579135;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X9AuhcAM1be/OM54/90kpBkw4MPDnVPNK+6/HbyUvkg=;
 b=AyaPHpQPmmBaQmcLFHfHHiTZ3f5sSzl79x+bKI8Jl8fnOsBqQtPH+tI82aRIq3igZK
 fVg8W6uuh0MjBv5Yy43hwAafilnWisTxV/k8aA7BaFh7AzqrzibsQj8QjpdQzb9yZTz1
 HJ4QtjXaFTv9hvVWGDjCDjHmmCic2zpAakBtXjefOwXf68a3mXS22w+hqA854euBOzqd
 xU4gn7V5DbIkvcnhOn97SMRTZd6UiXO197qXgRW4JUyYGRWi3jK9LdIoQ3p5DOW4n7e1
 2/LDlbJouPyxZqzEHMbDyIkqg0DjXOW4mUL9NTaty+L/YOW67dGBzvMMIHdv7gw1204F
 SAUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xx28Smu5AaS7gaCxwGH/vICOdzTka5J3HDkCYlzH/KKH7YM/FiWwCGA/y2IJPOSm9o5R2nS2UHUWh@nongnu.org
X-Gm-Message-State: AOJu0YydbsXccHiuteFdwo1MvyCtJXPUdqFuwt/DRKN+Qf1+4vlo2bHT
 En/37v+9+pELBjA+iIjmdEPfrAZlc+jFisy2MZeaJskl3MPX7m3xTnYw
X-Gm-Gg: Acq92OHf6W8xw8vs1RL/TAmKJopjFcXgawYvCSfev4oTJ2Nw7SsyJrNH9qhwFqV0Bs/
 5S94d08ZDpMla9qvANc/LUE2ObPiGJTP7n3e27DkqGMHqQVs6hB9vafQPlaD88/54ix6U6GDhCf
 lQaCmz0GmffYJCvkNwacoNIZmEJRKAgHkAOsB8xXiiIgI5+dNAsW7UfEr5kh4qj0UaWfdHQp9q/
 lmGYKg9hcns7f7Bjv5NkSYEn1AbnTe1HHMaBo1R4k4m1on4kuIYZZ/t3HsUDCjO4XQ0L7i8RDk0
 RNIpoK+M2IZVz0KREKRQMtTFVVIx39YMpcasDMgG1JgKhNcgDO7QofIFA6DJdgDnHtdDprqrW/w
 8VyTG5uvDh0xQ9sk5RdkquJdXDfpMxLXWWc26AtAo84QozHw5tkzjez+6rFLD62JN9TsqMtcILY
 72z57Mub8UAaoFtWBYevWtq9xrE8iUH2UAN1vxCUlO9t7A0kFQLwwpuQIcV+2SIjGZMA5xA7hBn
 AU9sG07hMcUFO7ja+Q=
X-Received: by 2002:a05:6a21:6f89:b0:3b4:6f05:8301 with SMTP id
 adf61e73a8af0-3b4cd48fbd0mr9850157637.7.1780974335024; 
 Mon, 08 Jun 2026 20:05:35 -0700 (PDT)
Received: from ?IPV6:2001:4490:484d:703a:9adb:4176:bfa1:c709?
 ([2001:4490:484d:703a:9adb:4176:bfa1:c709])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0a624fsm16742619a12.18.2026.06.08.20.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 20:05:34 -0700 (PDT)
Message-ID: <e5927d36-5947-4c0a-a165-e07c426568e5@gmail.com>
Date: Tue, 9 Jun 2026 08:35:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at
 load time
To: Tomita Moeko <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
 <20260608134559.23971-8-tomitamoeko@gmail.com>
Content-Language: en-US
From: K S Maan <kirandeepmaan45@gmail.com>
In-Reply-To: <20260608134559.23971-8-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=kirandeepmaan45@gmail.com; helo=mail-pj1-x1029.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi, thank you for the fix i just tested v2 patch on Haswell platform 
with legacy mode guest where grabled screen of gitlab issue #3093 is 
fixed and regression it introduced in [Patch v1] for UEFI guest about 
romfile checksum is now ignored, so UEFI guest grub screen is now 
visible and no VBT table found issue also resolved, both Legacy\EFI 
guest i915 dmesg logs are clean now.

Thanks,
K S Maan

