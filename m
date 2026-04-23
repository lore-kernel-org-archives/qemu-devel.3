Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C0CFDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzMB-0006G2-3n; Thu, 23 Apr 2026 15:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wFzM8-0006FB-54; Thu, 23 Apr 2026 15:04:56 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wFzM5-00048a-RJ; Thu, 23 Apr 2026 15:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776971084; x=1777575884; i=deller@gmx.de;
 bh=uPNUGyeAguREPo3wWei1cGJu+XuNayCUZ4QA1IXi0Qw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BQ9SVLKASsLe+YBKsaYQvWeblPRLVyT9DTChiamO357JejB7pMM3lMsZ1d4G5uDk
 OiSRGUnAo3Ux8Zb/eDi/Z1o/TLAQI0KNFBFv3rWyCgeZ+jsrAcvsLWiGayDABsDW6
 4ypm53Vpzq3IdY2AEo2ZJ1M1Z/pRyw25uNVWTWs0f4kyLIHII5ZW+Xsly4M/ZjoXQ
 Ie3N9ElfWYoCYm02XeIpyUwkjHAm4g9oywLZ3hYnNm6UAeQz65vC4i+5kPzGfO4V9
 b8sMucApY5cY/Isj3G4u3r4kbpjnognYI4Eld1kH7GAWmuiEeqx3B7SG1Za49/dji
 V7zUGuhPFNR/cFsFEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6llE-1wIkF81x54-00G7MD; Thu, 23
 Apr 2026 21:04:44 +0200
Message-ID: <f6dfd6c4-2182-4ff2-9838-7d6458f04d97@gmx.de>
Date: Thu, 23 Apr 2026 21:04:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] linux-user/strace: Use pointer type for read and
 write values
To: "Nutty.Liu" <nutty.liu@hotmail.com>, alistair23@gmail.com,
 palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260415233740.3027321-1-alistair.francis@wdc.com>
 <20260415233740.3027321-3-alistair.francis@wdc.com>
 <SE3PR04MB8922F4F93B35076CF01F87A8F3232@SE3PR04MB8922.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <SE3PR04MB8922F4F93B35076CF01F87A8F3232@SE3PR04MB8922.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AinV9mjnxFotoKmpaZjgEDpUMmpyE7r39P2fL/95CbXf+WoPZUU
 FS0X9vDMyaQmDmBCMNW+hySmSziVvmX4g5AlFSWAfD6C6117dw+ffIJXe4l5ce9+Ki+zQbT
 n6M7pGj+CG0nNtVY+m/XwBQMNXj2Nd9mqpbCVlsH/bOBjwoaxiDv2+2N1MWDvD9HTMc+nuv
 /PyDGh4GyyFpfC3XXE3Tg==
UI-OutboundReport: notjunk:1;M01:P0:bDeBinqeC80=;R/e6MazKWpcJ7hifkddFot2WJ8o
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

On 4/16/26 09:02, Nutty.Liu wrote:
>=20
> On 4/16/2026 7:37 AM, alistair23@gmail.com wrote:
>> From: Alistair Francis <alistair.francis@wdc.com>
>>
>> The stack pointer is being truncated as 32-bits for qemu-riscv64, so
>> let's use %p to print the syscall pointer argument.
>>
>> Cc: qemu-stable@nongnu.org
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3238
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

I've applied this single patch (#2 out of 4) to the linux-user for-next gi=
t tree.
Please let me know if I should drop it from that tree, e.g. if you want to=
 keep
it with your series....

Helge


>> v2:
>> =C2=A0 - Remove the custom read/write print functions and use %p instea=
d
>>
>> =C2=A0 linux-user/strace.list | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/strace.list b/linux-user/strace.list
>> index 35f001fecd..6162a407f9 100644
>> --- a/linux-user/strace.list
>> +++ b/linux-user/strace.list
>> @@ -1114,7 +1114,7 @@
>> =C2=A0 { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
>> =C2=A0 #endif
>> =C2=A0 #ifdef TARGET_NR_read
>> -{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
>> +{ TARGET_NR_read, "read" , "%s(%d,%p,%d)", NULL, NULL },
>> =C2=A0 #endif
>> =C2=A0 #ifdef TARGET_NR_readahead
>> =C2=A0 { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
>> @@ -1674,7 +1674,7 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_sysc=
all_ret_waitpid },
>> =C2=A0 #endif
>> =C2=A0 #ifdef TARGET_NR_write
>> -{ TARGET_NR_write, "write" , "%s(%d,%#x,%d)", NULL, NULL },
>> +{ TARGET_NR_write, "write" , "%s(%d,%p,%d)", NULL, NULL },
>> =C2=A0 #endif
>> =C2=A0 #ifdef TARGET_NR_writev
>> =C2=A0 { TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },
>=20


