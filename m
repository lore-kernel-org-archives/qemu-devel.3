Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8447FF8850
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGP97-0004K6-L6; Fri, 24 Apr 2026 18:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wGP96-0004Jy-N7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 18:37:12 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wGP95-0004Zo-2I
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 18:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777070228; x=1777675028; i=deller@gmx.de;
 bh=358uwErqpmQf02N2QgzdYGe+8WxN6zs1hZf8W8Eltko=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tfolgOVBT6jmjzscIpZldk3lWXbhTlbdP1SBlYuMH+AmfE0T2pkflh2GjAxWwtw/
 f2RGEyTIetp5pwRU1ipCaqH3fkO86khCOFWLkPjbw/Y2z+X55yaLb8F2qFs2l6Nbm
 acE6mnFMqtOU83/9LHF32jTHvniL8W9dbhYwYZq0nXpDDR+GRnMmfgd2J40QQWfuP
 nGJ9QVudj2kQ2h8+tLWmklnkiz+uj8W+vwtFPhaBs3BzzZ/fsZaEmFATs27mWVG57
 KMEf6W75h0D2STe8j8U+s9yaCg2FwVU1AbO3pNSrQIyS5F4noi10+lkAKZFXu44Ln
 7J2dK1Uq0f9/YS4FNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1wIK1F0Si1-00HOSA; Sat, 25
 Apr 2026 00:37:08 +0200
Message-ID: <cd1f833f-05c6-4a17-8a37-4c548d5ba476@gmx.de>
Date: Sat, 25 Apr 2026 00:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] linux-user: Use int64_t in target__kernel_sock_timeval
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260424091024.23495-1-deller@kernel.org>
 <20260424091024.23495-2-deller@kernel.org>
 <3def1014-3eba-4778-8be7-cfb473a536d0@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <3def1014-3eba-4778-8be7-cfb473a536d0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mHppp9vM//oqCN6i0fYXO0z0Qzzww2SND0Y8aAkoNh1+SPFkCWl
 bD4RmDicWEGSlR+/5UqVNzsmD+ZU3InXCh4HlXFdFvd6g0ROkDyRlliiUhTAAjWJEmoYVhu
 OP9yPAKmFh8a2b0Kf7sUd+Epd+rO/3xkyBP6NRjM4NQu0EtH/L4H/6JzQLQ3s2rQK8Rnh8I
 75EOJyQ8o3SC2fTcebmKw==
UI-OutboundReport: notjunk:1;M01:P0:efDeTOEA/zE=;Ly3X0CF1XVfbx/AZ3u+PAh8BH4L
 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
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/25/26 00:14, Richard Henderson wrote:
> On 4/24/26 19:08, Helge Deller wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> The Linux kernel uses the __s64 type for the tv_sec and tv_usec members=
 of
>> target__kernel_sock_timeval, so prefer the native type here as well.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 linux-user/syscall_defs.h | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
>> index 6967306be4..138ce6abb1 100644
>> --- a/linux-user/syscall_defs.h
>> +++ b/linux-user/syscall_defs.h
>> @@ -238,8 +238,8 @@ struct target_timeval {
>> =C2=A0 };
>> =C2=A0 struct target__kernel_sock_timeval {
>> -=C2=A0=C2=A0=C2=A0 abi_llong tv_sec;
>> -=C2=A0=C2=A0=C2=A0 abi_llong tv_usec;
>> +=C2=A0=C2=A0=C2=A0 int64_t tv_sec;
>> +=C2=A0=C2=A0=C2=A0 int64_t tv_usec;
>> =C2=A0 };
>> =C2=A0 #endif
>=20
> Nack. This has target alignment implications.

Oh, now I see:
typedef uint64_t abi_ullong __attribute__((aligned(ABI_LLONG_ALIGNMENT)));

I drop that patch.

Thanks!
Helge

