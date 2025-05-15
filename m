Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08849C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 23:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFi3P-00027f-EW; Thu, 15 May 2025 19:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFi3N-000278-AU; Thu, 15 May 2025 19:31:53 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFi3L-0007eG-Ma; Thu, 15 May 2025 19:31:53 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2302d90c7f7so19262255ad.3; 
 Thu, 15 May 2025 16:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747351909; x=1747956709; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mO6n1f7npP3Q49ument1x55qRm7Ys7n+Zx34VME88y4=;
 b=MHrbWWETjd7iuX0Xx9kOoRO+cxZlPf4hKcEPAJhZYTdKgTefpb8QPqwbH5p//w0gzx
 DRafHj4ZMUOaWMMPH+rYNMzJ3hiY3ysFkyXUr7H8h3eyhP02/fXpbWHm6EEYg8ebklnH
 UkCS3rZaKZ1C5TPJGbdqee7LkElfXAGj4UCgwOtjzoRElmXemGUhSqP0IeZibq6L1uPf
 nmiBpizgy4U8AkhuykrQLn0V9bh10Ga89ikwo+vlQXRPTFxTi4fC0BfKL/xi7p57VZtO
 CCyyxGR9f+BvX1cLQ8YP8rw8dGHqlMhfCA107cT4F6gCTwAh10LoejCKJGA+ikZQyunw
 pkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747351909; x=1747956709;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mO6n1f7npP3Q49ument1x55qRm7Ys7n+Zx34VME88y4=;
 b=O1B2/mwhkQ6RdS17Oa3sHueJyGk7NrIDHglCwf93unyMJ7/N07/90/hE35jzVtC0r0
 56ZN6mxiwjtKqxUD48r068R0VLIxOVlsWsGrnh7DZO2vV+G7nHxf8n8aSamcEcYaa0lz
 HTlps5CBuorvR/oTpPkaW5UY94hUrF03C4Klbr8E70jSj3qi2JnrAN20WqgzvrE5oFvg
 FHYrpPmFbxMpUwVwhVcWs3gWophiG8dscGAyZqLMICZ+cXHv/nr1molPmQ2hjzJTu9qS
 huJGPUXUXNV7N/tnX9JdTVj20rmC6fply5dqgRi2RnGoToS8BH7xkwrMS1QAP87PmhGm
 8uVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlAqGGw9qNCurHrhXu76lmaJyl3HxH2W3qHccvst7mLTrBDqd3BRIOTI1HFCWNqDcWncS/3VpHdg==@nongnu.org
X-Gm-Message-State: AOJu0Yx4psdOhrXz7dYO6FqqRSraEVex7lKlYTM0jIpFz8oQ1hIHPJH8
 bgUHl82cPHSAABUb31uuev+gWsd18da1csVJt3dWj4Ff3AomOC+5KJBU
X-Gm-Gg: ASbGncsQ/Clwn030T1wTttv8I191pRWYYvIghxdRl1qV0Zf0Crz+vcZOEg/z6OWQ1Bx
 AIFZhs6UogAfJGJ3/qZbnV+sGaFM/LqhfMQFemC2rHGtO1PHuJtJOQHOxd6Ym8bR/GSjrSsQKj1
 u19B9MiSFVlgWSe71u68NCH9Uxr/il32FbCDRRBbhx2nylOgGfktjpknRRaYvuYqMh8ayfFrZfO
 glWJ1DUZSZicYWkYz832RWfXMcUTV7M4Fjwl+FuBKv3XV2dEBlQ/ROFMG1JjK7MWlzQK8ux+BoB
 aKf5yjBCzlNpLFQodPDnzW+/0JNtYEj8UAzodYD5Po2aMdY=
X-Google-Smtp-Source: AGHT+IG3QCm1b4Z7zLrdGj50rIWA9KY4RYQs1FyaibCGil3NzxHt4c2Yn9Vap0LnP7i+40ziy0mS7g==
X-Received: by 2002:a17:902:ccc1:b0:220:e5be:29c7 with SMTP id
 d9443c01a7336-231d452cda4mr14567165ad.39.1747351908841; 
 Thu, 15 May 2025 16:31:48 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97de4sm3110235ad.144.2025.05.15.16.31.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 16:31:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 09:31:41 +1000
Message-Id: <D9X4JY22CYJ9.H7KKICGBL65P@gmail.com>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Caleb
 Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/50] ppc/xive: Explicitly zero NSR after accepting
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Mike Kowal" <kowal@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-15-npiggin@gmail.com>
 <ecf642af-4531-40ad-988c-27e55350f745@linux.ibm.com>
In-Reply-To: <ecf642af-4531-40ad-988c-27e55350f745@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Thu May 15, 2025 at 5:07 AM AEST, Mike Kowal wrote:
>
> On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
>> Have xive_tctx_accept clear NSR in one shot rather than masking out bits
>> as they are tested, which makes it clear it's reset to 0, and does not
>> have a partial NSR value in the register.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/intc/xive.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 6293ea4361..bb40a69c5b 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -68,13 +68,11 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uin=
t8_t ring)
>>            * If the interrupt was for a specific VP, reset the pending
>>            * buffer bit, otherwise clear the logical server indicator
>>            */
>> -        if (regs[TM_NSR] & TM_NSR_GRP_LVL) {
>> -            regs[TM_NSR] &=3D ~TM_NSR_GRP_LVL;
>> -        } else {
>> +        if (!(regs[TM_NSR] & TM_NSR_GRP_LVL)) {
>
>
> Any reason why you didn't just use the else?=C2=A0 Regardless I am fine=
=20
> either way.

IIRC it was because the 'if' side goes away entirely, ends up
working better this way I think.


>
> Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
>
> Thanks MAK

Thanks,
Nick

