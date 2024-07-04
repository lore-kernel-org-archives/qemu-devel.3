Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AA1C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGsb-0003Yn-9I; Thu, 04 Jul 2024 03:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGsY-0003S6-8m; Thu, 04 Jul 2024 03:27:42 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGsW-0000sO-8N; Thu, 04 Jul 2024 03:27:41 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fb19ca5273so1541275ad.3; 
 Thu, 04 Jul 2024 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720078055; x=1720682855; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6KDgEs8NWfNQqNJkgsJz0g1XF6fk2TaeRs2xLx8WdI=;
 b=f9Ci3V9TV0y+bio+ITqo7ZseQTf93uTHNwFOfZnyBpOjulVoU2aR16HfaAzX9xrBzO
 WnDGKwY0q8c6rVY+oaeICMt73xojI2llTwf3NEc6oDovLIOksEG/8NIZjz/QHbcHrnq8
 TkjqBUYlosOyx8MQELrEh3g5VS39yJEb78kjRgAuLIOeizTbKKVwE2gm5VqZtbt6jZMJ
 L5xppsLgUCFRtBqElGXksDCtrMBKiuepnqDe1UKnX8dkUDHxj8vTPxTkYG8ocaWACFyS
 Hc/gtcoVSXEkUfDPGLbCYiwi04RusdMZ6Bjr60KWxLQiPJ8M+X35Yv5/wITp0Tsg4uF8
 h92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720078055; x=1720682855;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s6KDgEs8NWfNQqNJkgsJz0g1XF6fk2TaeRs2xLx8WdI=;
 b=AJpuJjW1xlFSoz2ZUVQGCRzelJ5+cczXh7ywKiMvwv0zPSHydDyUQXhHTZl29QLMLu
 1U5uGjSS7ONw2aND/qh/Nss16m/o8OfpTib75qlMEt4zL78unypngkFGoqrMW/998g1/
 h3QvKMrhfkbvrvUej1AuxtKTmhvcmimMFR69fw+wRCMrR3HEIZ8WEZ0CcQIUCEC6CnVY
 2jHGFb4AlLfCKaSZuoFcCBuGSnv3qmKJE8ijxAu2t7CgavIHz8hHn+Agt3zpTNViAg6b
 iyKf0eBOu2+dHkwNOOMQPIfDRUia0RQMWeEgm5aAQYeDxReV3xp1+vgyaQNGY1v+urtO
 j6eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjuGnbKgG+pxk1nJ1sI+bTmCcCHY55oO6i1gbWdZtD1IjOl8nqY5J1RB6IPfB5EOtD86+wMSZI3/KQqgZd98nAapA3gK9Q4oRNC+KkkyshBGOV0D5fuozBzHQ=
X-Gm-Message-State: AOJu0Yy9H1+ybvvR4CilDInphjri9dIrVOGcdVCX+JHmTYaBhQXoQf0e
 kbupPYpHTubjuMauoebSBRIQBs0auGqNrhtx9OluCYzFJlTWLtMh
X-Google-Smtp-Source: AGHT+IFgjgop80QiWN92SU2yp0FhdjRTfiRARekEkI2qSoigU8taRdPwOM9f5/UBZ1Rd1JUsj1F7Rg==
X-Received: by 2002:a17:903:22c1:b0:1f7:2051:18ba with SMTP id
 d9443c01a7336-1fb33e1244emr7889485ad.14.1720078054865; 
 Thu, 04 Jul 2024 00:27:34 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15691ebsm115252265ad.213.2024.07.04.00.27.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:27:34 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:27:29 +1000
Message-Id: <D2GKS3DJEU2F.164AFPRMIA8T5@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 41/43] target/ppc: Change MMU xlate functions to take
 CPUState
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <3e26fb6adddef0804adfbfb2fdc0fe664555ef0a.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <3e26fb6adddef0804adfbfb2fdc0fe664555ef0a.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
> The callers of xlate functions get CPUState which is then cast to
> PowerPCCPU that is then cast back to CPUState by most xlate functions.
> Avoid this back and forth casting by passing the existing CPUState to
> xlate functions and let them convert it as needed.

I guess. Is this faster?

Thanks,
Nick

