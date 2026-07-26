Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418BAC53200
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 13:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnyhf-0006ek-Kd; Sun, 26 Jul 2026 09:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wnyhW-0006cw-Ni
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 09:15:32 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wnyhT-0002FC-6X
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 09:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785071724; x=1785676524; i=deller@gmx.de;
 bh=oPQcmDijHxheJ5lYQBWoYxziYSBDDNCik11NimST3E8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=c2HGPjGHouEgjgQBS0qraBoNvEuqbvbwYphLO9BLErwLm2Al2h7zPQXJM3GNUZtf
 IWKARUXsE2/1tFzeSUC0r+h9S5i5KQAYkDzAXWJgUfsj5cdsRHcPOYcMwd8j37/WP
 mUqcHOcmTBWgU2ZaPHuS6/oi5ghgacVdDbeHZS013Ko1yIRmSdWlQFyu185dSIVOv
 h/MCjfORetFK7VSEBlqsaCBrVs59qY1+U1Y60+Z5zvVVV18IUBnrcwW8eT0ecFLXI
 edoV9XGXyXQh1CQEtPqh2fwoq1DheqcJO4WN84IItrb59G90DkpMLo9W92Loaqi4s
 CYSfpqU29c5k2oxMGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1wOVRz2yZL-00OrRh; Sun, 26
 Jul 2026 15:15:24 +0200
Message-ID: <5770213f-7332-49a7-a606-9325bcecb349@gmx.de>
Date: Sun, 26 Jul 2026 15:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix guards for the fsmount(2) syscall series
From: Helge Deller <deller@gmx.de>
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260726005527.2513254-1-mattst88@gmail.com>
 <bb368e28-c009-47ce-ba74-83104a9e6af0@gmx.de>
Content-Language: en-US
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <bb368e28-c009-47ce-ba74-83104a9e6af0@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ATnXivmm9laUj0bzdRvSRdzEVkrDDayB668k3Lxkv5m8UkibO8x
 dGnPVZShaaVHtepXjqec9wCGtQQsnIQPtmxUqFAmOTuA6EztgSCPdiBb1zUdFBGgHyt3hm2
 1+L7Y10M1E79A9bSU+vzEJuCsMVxL/PgeGBAO/E+f0oju/TuheqLZHoGjeQWPK8HWL+AmBz
 BnWnngRjzMJ0LWb5LIMEQ==
UI-OutboundReport: notjunk:1;M01:P0:DbUEA02bQj8=;oK2iMgJYZLdYLCLIHJ0BSrYprcP
 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
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/26/26 15:03, Helge Deller wrote:
> On 7/26/26 02:55, Matt Turner wrote:
>> The fsopen(), fsconfig(), fsmount() and fspick() implementations are
>> guarded by defined(NR_fsopen) rather than defined(__NR_fsopen). No such
>> macro exists, so the guard is never true and the entire series compiles
>> out. Guests calling any of the four get -ENOSYS, which for example make=
s
>> systemd's credential setup fail with EXIT_CREDENTIALS for most units.
>>
>> The strace bits for fsconfig() have the same typo.
>>
>> Fixes: 767c32fe6983 ("linux-user: implement fsmount(2) series of syscal=
ls")
>> Fixes: 6e0aa9f6c731 ("linux-user/strace: add fsmount series of syscalls=
")
>> Signed-off-by: Matt Turner <mattst88@gmail.com>
>> ---
>> =C2=A0 linux-user/strace.c=C2=A0=C2=A0=C2=A0 | 2 +-
>> =C2=A0 linux-user/strace.list | 2 +-
>> =C2=A0 linux-user/syscall.c=C2=A0=C2=A0 | 4 ++--
>> =C2=A0 3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git ./linux-user/strace.c ./linux-user/strace.c
>> index 3a81cc95f4..d861f311f6 100644
>> --- ./linux-user/strace.c
>> +++ ./linux-user/strace.c
>> @@ -4344,7 +4344,7 @@ print_statx(CPUArchState *cpu_env, const struct s=
yscallname *name,
>> =C2=A0 }
>> =C2=A0 #endif
>> -#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
>> +#ifdef TARGET_NR_fsconfig
>=20
> Your patch is basically correct.
> But I think instead of removing the (wrong) NR_fsconfig, we should
> instead depend on the (possibly existing) __NR_fsconfig.
>=20
> Reason is, that if __NR_fsconfig doesn't exist on the host machine, the
> constants used in print_fsconfig() like FSCONFIG_SET_FLAG aren't known e=
ither,
> leading to build errors if we don't check against __NR_fsconfig.
>=20
> I change the patch accordingly.

and pushed to my linux-user git tree:
https://github.com/hdeller/qemu-hppa/commit/4fdc24696cbf1ac6d97075d877cafc=
9fead4c475

Helge

