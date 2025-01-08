Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDF6E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 23:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVfMW-0000AY-1y; Wed, 08 Jan 2025 18:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tVfMU-0000A6-Jz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 18:21:18 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tVfMS-0000cj-Qo
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 18:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736378474; x=1736983274; i=deller@gmx.de;
 bh=+s2gJNvCSvjWo/+bXcKO0c9BfhqmfgZN+otJ+RJrwj8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Nww6n3kwEb5YTcqWqDdaWVx1Y6QbJmAZyoMlX9aQ285kkwyj92xoum6A6Tcb4kq7
 rxTTndw6IOFjYfUABBHeRNUFv0+i4TtbY48kGQebA3/wNcLfMFOHFO9fSUG7Ld3iY
 DWMSY+yjFiJIhKvzuq5KEnMrKAl0aB3W6+H5uBdOoPko+xZ33sx3AVt7KxPucGtsx
 992nZ6QVNsjhJfq+Mj49N0TkzUNJiFaxrlaW28L34HJs+EgeXffyxU+YY9eocugY2
 gFlu/xlpr3UoH7iNRD3Pz1LhJ48RBIUqClhYUFd0oEsa2p7LAkVyYaPv+kih6kIml
 y14A5qf+5f2hW/UYjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([83.135.220.169]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv31c-1tnTII0L5s-00sQrg; Thu, 09
 Jan 2025 00:21:14 +0100
Message-ID: <b8ce1a5e-d239-4c4d-8515-171312ebdffb@gmx.de>
Date: Thu, 9 Jan 2025 00:21:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Add missing /proc/cpuinfo fields for sparc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <Z37rL5jVYpOk6ufc@p100>
 <f36ec87d-d384-4671-a80e-27d4ad4fe7b3@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <f36ec87d-d384-4671-a80e-27d4ad4fe7b3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rGxBeOlOeryCS97olGDyyKR8/x2feWe6PdKJeS6w6pHnPStVMK4
 BJ0ZvDaRI9ECKyIeKcazAHyr5EWhpwp5zhNEMHo0p5HdLEuFuKoFQxeZsbujaIEJwjufqPb
 opGuO7HW6V0HnZ8WPgE4tvgc3Hq71CAYJ6m5OLaksW/oI5wyPLUqYoj3EPvKBSty4qqGlcO
 twQfnNqYrQrEUMnhdJM0w==
UI-OutboundReport: notjunk:1;M01:P0:FfixvmauIKQ=;K9N145ktzjnq4iTGUIrjNyYZSi0
 6RWVnj18ktkOoReW37FJOtLqhDXduen21WDk/Mo5M9YwFMcGP6/A/vD/aWvwRm1sTyIDaF9QO
 iQFjERvCcOTCfTsv2kXveELHowN7u8DielCauTAa9yYmb8nxrYM3+V5apBcuyh2TGFlV0oXkN
 XpjgEUNH1w5qIO4MD30YCAgNmNFhLycwtTBxeV5soKNgoF6/fT9Twfy+lZY+npMZtVh2R1k5V
 C6y5DU0mLJ7dvMVK0u07ivn8A4J6wcQTQDGQk3qLAfbOR2doSXLOyQUMYg9PoDwmNthUp7OvO
 wAA1qYGkGCW1qDTTCpyBWeavlEtvaJw+GtbgS7125ScjSApM7CrrYVEHWG80Xu025snIlOIqU
 2vKLl1xdCV/uZGMgldvvNluvLJoEhWKq8X9Qtw/MDrzTZaObuIiYy999bVDdbUAs0p7U4drbz
 RRIev9S1/qezcePmGfWouYv97ecRzfvp0bJ2udV4YQeg26qwmInFjhLNGu3ZkB8ktRKGQpc8Q
 Eq71lVF34BV2dfdwNRbJpqpSwcyqZ09rH20EpZBtkMNb8D97K4IMN8zu0mY/zjlxlj1/zlMce
 fy23tMyzyWFyUFlB+O7vMH6iGHY563uNgqFw4dPHG4DO3qc6/hyX4ZojJVA94nuY66849rMvK
 J7AE+a1T5OHF3eMzcfBIjOiFcmz/9iOPboC6oGJHUijo9jKQ3dmGMlmvgCiAppoY7hC0f7mFB
 1r19soDKI5J3vIqBjy4vl9yeTCaakZe6sKP122wTwQUj926eAaPZHrSdz1Ve6RXSUNxSuNrdj
 Iy5X0uE/GOSjbV2+FewKuJSNzBLLW7xrOPifEapp85aoE+bBNmo/makZCovuC+uwfwE7huVZQ
 gU8ZnpTRGKQuC/1A9n70DOu0XvcTP6lV6KkTQCon6Lvdf3AR8mKYnOCN4POZEkq9S5w4pz6DC
 plUZ2QLDS+Rp7VoM/diOcNJ/R2tTzft+OWI8Gi+yc7ilgdTgBol5+bniO7p5WyXe1q/crV/Tb
 DYNRuyV4baXudMhIiTB6gk4yMti49ibEpJnpwCwL3vC6Oi/Ydzo8cbNUfbylWuGtXPC3CuXQO
 gfMprHtgDFianGYKmOJvyiR2djviEB
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/8/25 23:59, Richard Henderson wrote:
> On 1/8/25 13:16, Helge Deller wrote:
>> Add some missing fields which may be parsed by userspace
>> applications.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/linux-user/sparc/target_proc.h b/linux-user/sparc/target_p=
roc.h
>> index 3bb3134a47..172d089fed 100644
>> --- a/linux-user/sparc/target_proc.h
>> +++ b/linux-user/sparc/target_proc.h
>> @@ -8,7 +8,23 @@
>> =C2=A0 static int open_cpuinfo(CPUArchState *cpu_env, int fd)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 int i, num_cpus;
>> +
>> +=C2=A0=C2=A0=C2=A0 num_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
>> +
>> +=C2=A0=C2=A0=C2=A0 dprintf(fd, "cpu\t\t: TI UltraSparc II QEMU (BlackB=
ird)\n");
>
> Obviously won't match with non-default cpu.

OIC!
Well, this would need much more coding which I won't do now
(and without any benefit as I haven't seen a program yet which
really cares about that specific CPU info).

>> +=C2=A0=C2=A0=C2=A0 dprintf(fd, "fpu\t\t: UltraSparc II integrated FPU\=
n");
>> +=C2=A0=C2=A0=C2=A0 dprintf(fd, "promlib\t\t: Version 3 Revision 17\n")=
;
>> +=C2=A0=C2=A0=C2=A0 dprintf(fd, "prom\t\t: 3.17.0\n");
>
> Do we really want to pretend with any of these?

I'm now sparc expert, so I don't know.

My suggestion:
I change my patch to just add:

+    dprintf(fd, "ncpus probed\t: %d\n", num_cpus);
+    dprintf(fd, "ncpus active\t: %d\n", num_cpus);
+    dprintf(fd, "State:\n");
+    for (i =3D 0; i < num_cpus; i++) {
+        dprintf(fd, "CPU%d:\t\t: online\n", i);
+    }

Those were the lines which I was mostly interested in since
I found one application which wants to parse /proc/cpuinfo
to get number of CPUs in system.
Would that be acceptable (for now) ?

Helge

