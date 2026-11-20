Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B984606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=GvvkxSgl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUKDJ-000512-Dm; Fri, 20 Nov 2026 03:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xUKDG-0004zT-81
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 03:43:18 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xUKDD-0007o1-It
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 03:43:17 -0500
DKIM2-Signature: i=1; m=1; t=1795164194; mf=PGRlbGxlckBnbXguZGU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=; d=gmx.de;
 s=s31663417:rsa-sha256:dUpsHBnxK5P6PaPpXDqI84acSQ31
 71n8cel4Owgvg1AEoFlTwTmOfYPo0T/2aIuuVBvwTpm9hdioOUlvNi+0vYi1F3DUiA+FjqOPlS+
 aKWC3f8q1kuI1DjRi0a089Ki8+IX/2kLs32eRQ2omg5WsoIv+lLTYpK/hhUc6DzW1XJHX0K41qB
 ZB3/lfMu9iQ9OvF0Z/kVg3Rze+2ZRu8J0bJdLN0Tm1oW8ImwsijH4T8VecfVg137mnMFVLdNpcZ
 qCNmeeotM7TYbFteyv1Oqj2Ap2TBDbYz/nEcfVRjzjJH/7KU42gflasnuSzET51cY78XIyTbyxM
 GTXQGjoSSqfXtg==;
Message-Instance: m=1; h=sha256: MdPsw2yVBeQhdOFdASwkRPWhIcvI370WfiucSZZmE7Y=:
 Itml3qRz4i39Wa4p8XhJyj61EvmAAYaxwoJSSPitSwU=, sha512:
 ss3gyN/Pl5EEkxHA5tiudwOpRnqpPC7TvzqxolYWvqTod4sDgbtYiFl8IUIRBKsiAz6TAbAuTF3Fy7Wc87NVWA==:
 uI6uFK9eyuwlY4R8Bwvd6Bfut7QxvJuZ+8rEhdm4OvhctGPijFTZVKtujOlt5Q0U72NP1CwmcekpGi9BMuBhTg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795164185; x=1795768985; i=deller@gmx.de;
 bh=LKcQP/t7LQZiw8AiVoUn91OXAM4JUYfPLqLhSh2jSFA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GvvkxSglF23zBuyXaKOOzRs7qIG/FhKX/F4clU/7ewdNvhou3wKmoFDc3ewFOH17
 Km7k6/wkam6CWGarqNSmxeezGFESWCAR8bvovbDAQcu3WFdFirsTxA9EpdVfsVyua
 kkR15s3Xt7kQDYb8MDAtCv9HVG4s8Of/DT9P7hpHn0UO/Yd8Asf1OcU+GdB2OqOSP
 PX+wDbxUqpDPUo0hGE4amg3U3tvGsP9J1dCRVxs1UIq4OyvFPzRYCUgS1MM6PBDCL
 o+fs9JbRBdZmrgyr+0Le8BdntYNl+IIzjoPf3UuHesYo8KeekmtFkkElh1D5Zc+XM
 vH1NyQsYTc7Tp9iuTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dwd-1yZxYy0UMf-013cmw; Fri, 20
 Nov 2026 09:43:05 +0100
Message-ID: <76ff52a0-6cc6-45b9-b7e3-f9532c26cf57@gmx.de>
Date: Fri, 20 Nov 2026 09:43:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] hw/scsi: share NCR/LSI definitions in lsi_scsi.h
To: BALATON Zoltan <balaton@eik.bme.hu>, Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Keith Monahan <keith@techtravels.org>
References: <20261119233235.32808-1-deller@kernel.org>
 <20261119233235.32808-3-deller@kernel.org>
 <faf7c973-3c97-9899-7a46-3a518634603e@eik.bme.hu>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <faf7c973-3c97-9899-7a46-3a518634603e@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NfacQWh63Vcgg72adJOVfK75gMZ1MAQlBrZcBVARvLihb6qDv/D
 kNwrjKMCW2YTvtWbdEqkoU5CDeBv4VimBRrf1TySpazDQQqzIYauTd8ree5BiK5QN1xEGfh
 iypRjhgWmy0WEQQEPWZ1BB0dq9YX1C5MmawXcKyEeujBM44jUIKm+tq0wsqwNu3shhMGqXY
 AVp5XIolYHd9CkEG67q4Q==
UI-OutboundReport: notjunk:1;M01:P0:PXtlV4xq6F0=;J7qcyPCpul9a1OCYCUhhcoxXgUc
 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
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 01:58, BALATON Zoltan wrote:
> On Fri, 20 Nov 2026, Helge Deller wrote:
>> From: Keith Monahan <keith@techtravels.org>
>>
>> Move common defines and structures of the 53c710 and the lsi53c895a
>> drivers to lsi_scsi.h, as suggested by BALATON Zoltan.

> We have Suggested-by tag for that instead of putting it in comment
> message.=20

Sure, will fix that.

> This patch should come before the previous so it avoids the churn of
> renaming what patch 1 added and add that already using these defines
> and names after this patch.
Independend of in which order patches should come, please take a closer
look at patch #2.
Your suggestion was to "share common defines and functions" in a common
header file, with the intention that both drivers share functionality/code=
.

This is what this patch currently does, e.g this part:

-#define LSI_ISTAT0_DIP    0x01
-#define LSI_ISTAT0_SIP    0x02
  #define LSI_ISTAT0_INTF   0x04
-#define LSI_ISTAT0_CON    0x08
  #define LSI_ISTAT0_SEM    0x10
-#define LSI_ISTAT0_SIGP   0x20
-#define LSI_ISTAT0_SRST   0x40
-#define LSI_ISTAT0_ABRT   0x80

Now, looking at the result, I'm not sure this is what we really want.
We rip out single bitmasks out of context and put it in in various
header files. I think this is generating more confusion that having
the defines per chip/driver as it was before.

I suggest to keep those defines per-driver as they are, but instead
share the lsi_request struct, LSI_* enums, PHASE* enums, and
lsi_* functions only.

Thoughts?

Helge

