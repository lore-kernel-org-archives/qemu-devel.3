Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFE0C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 23:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFiMm-00019B-MC; Thu, 15 May 2025 19:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFiMk-000125-Jk; Thu, 15 May 2025 19:51:54 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFiMj-00017a-4t; Thu, 15 May 2025 19:51:54 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-74248a3359fso1682520b3a.2; 
 Thu, 15 May 2025 16:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747353111; x=1747957911; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IeqTolUYEcyPtCgU/AclSC9PKSB4MJ0Mvmbu2vQLkw=;
 b=FlX3EjvRnRInI1x9QXe4fIbEt8ChJrUlFeym8cEnd7FV654r3iNzSQ89y968jolFcR
 RDRtzqSZ4/1y3DnbyBzxzz4DgvBsbyOYDroPZdM121QjlgVadZF6WKjL/zy1gxdwtHfg
 MsYVqM3UPx+LneUKhQeR123NW4FZ8+Lsy90NgLDXdUsq5/nyHSt3nYvH26CJ6RENTDKe
 hlViiSHS0j6N1bTpJhBFqVX1YTjLt5Zcbpj2BiXFclJ4wUsa58TCf1UDFHKCjbFLERSu
 EL+W+C95lkegG4hupboP0/VwhCVOv7zB28v58Cx7PljRuPhOB7R1FfAapB6WNPrYvY1Q
 jRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747353111; x=1747957911;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8IeqTolUYEcyPtCgU/AclSC9PKSB4MJ0Mvmbu2vQLkw=;
 b=SJuByRcbg/iODG28WBNNOadPhF4W9yAqQWHEfBQ6ELtQ5LKZmP4Qe/L+myjbYwONJJ
 Oez4h/OvQqfuQa4hX2Y0TM19947KnCi7XK4Se0ZOn1YstKzL1YXdVNobOrkXsCs98FxK
 y02chakTPpnwYU7Aabgoq9qW4zkpYaaDNPuaxOastY9beoqXmz+AdQryBaTmLiAzuN/t
 wVXt2Bb7HpdtKcStmptaLzWrscct8r4Ts5OnV6O0i17KVbQb23c1jiXK6h37jEsmYrc8
 njBpvP/OKgZ0Q0yx1jbOAdlbPkhFuAt4kyJzFVsyMqWXLyk1YH7Er7vk6hf+ILsj2WuO
 uaYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU8MGgu239Gt4wOfVys9IWaW6btqoXm6ycG6PgAtWcNM3w3K8IRXOK/foQGPqnScqO18VtdjMXaw==@nongnu.org
X-Gm-Message-State: AOJu0YyXwqbIJUIJvZErq/Y4sIcMb3JGsMlra8Xv/OH0CmjLO4S8tK6S
 p1I3jYCX41y1zDX94XQe6gt5i31KNJw/vfg+U7H9LAZEhulEKGaxDfom
X-Gm-Gg: ASbGnctZKUSJc5Ia0zgBpPEY/p0Ve6eRz3VPGe54lieC+hleGcNFPrRWWxpvBHYillY
 dGCvLYeCuaUV3ZIiNmqZZ/YpTpIshn578xJdzI1E/QwRpKonx8OdVbqerd1IDOLgLM2kq8IDVSn
 wHnk4rLsSUOjjJv4KC+LvfWbK6pLB4AaaZocRt1Pohgu7m2eCt1C7+wVT6jGz+7QZ9/SnXVAyHD
 jkhsVLqDirySljz/7yZYLDsydoxSYa7HRXhazi09e9/7w1u9Rf2CQNlJgHQHWK9sOy86jyJdy1+
 hXC4D3Ulbsar7RujdcfpdP73NXLFgE1f9I1304GV1FKp5UQ=
X-Google-Smtp-Source: AGHT+IEblnfyup8JgM7sWGZCKU5FijTsQuAuj6b5iKxXUxA5N2ZUE/LzX7AUevdzyWgZosg4bO9rhA==
X-Received: by 2002:a05:6a00:2387:b0:740:9d7c:aeb9 with SMTP id
 d2e1a72fcca58-742a98c140cmr1571599b3a.21.1747353111065; 
 Thu, 15 May 2025 16:51:51 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a987677dsm375355b3a.132.2025.05.15.16.51.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 16:51:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 09:51:45 +1000
Message-Id: <D9X4ZB52WVOD.32518NEI6XBON@gmail.com>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Caleb
 Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 30/50] ppc/xive: Add xive_tctx_pipr_present() to present
 new interrupt
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Mike Kowal" <kowal@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-31-npiggin@gmail.com>
 <0ed60dc4-0986-46be-adda-0539d356e2db@linux.ibm.com>
 <71aaca95-08fd-4d99-8a96-412f795e1020@linux.ibm.com>
In-Reply-To: <71aaca95-08fd-4d99-8a96-412f795e1020@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

On Fri May 16, 2025 at 1:21 AM AEST, Mike Kowal wrote:
>
> On 5/14/2025 3:10 PM, Mike Kowal wrote:
>>
>> On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
>>> xive_tctx_pipr_update() is used for multiple things. In an effort
>>> to make things simpler and less overloaded, split out the function
>>> that is used to present a new interrupt to the tctx.
>>
>>
>> Why is this a separate commit fro 30?=C2=A0=C2=A0 The change here does n=
ot do=20
>> anything different.
>> Regardless, taken this patch set as a whole, it's good by me.
>
>
> Okay,=C2=A0 I see the rest=C2=A0 or this is done in patch set 35...

Yeah, I split up the old API in several steps...

Thanks,
Nick

