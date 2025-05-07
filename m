Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB57C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCmJT-0007WN-GW; Wed, 07 May 2025 17:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uCmJQ-0007W5-M0
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:28:20 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uCmJO-0000FR-FR
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746653294; x=1747258094; i=deller@gmx.de;
 bh=oUvH8Qubh7mswsPQV9nEyxjWbLQ2VDIyCAdH1Jlav9g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gh983v6DnDbxpeqvcsgbOEiq3PwjaPX4zfbsTOL1y1zSgXKCsiNsWOufMhEdFTYe
 kIv3nVkqlSbYZLg19jO7IjKa4X6y5ox83+frufQ1Pjqemd3Je1U3bnH7erqUIUU8U
 ZVtjkBh68Udd+HlWL4cu9Jd0aLBwPkeHj8+WiLL3znpI/g7h1VUkPmKRcImZgbDxt
 zhWD9G4XmBDZHOPeMO5C18yFgg0VJYbQkUYxyt8Yknv7xJUq51y5jovyJZdv2Arfm
 ueU/evtx2tvyXAGouuaD0jLqXJr51w+brbC1dTl1AWsQsORsmgDKujCZrGx0YENfk
 8epNVLocwsYKKY//9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUYu-1upAWX3CyS-00enKF; Wed, 07
 May 2025 23:28:13 +0200
Message-ID: <14e74771-f887-4e7d-8fcd-78244a3f0d08@gmx.de>
Date: Wed, 7 May 2025 23:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/24] target/m68k: fpu improvements
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20250507211300.9735-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bwOBlrgAKKYKKTS7zSQTTlY6uPKpXhFZjfC5FyyF+D78BtjB+YP
 x+YRJ3jM1FlF6QMOYK6+hc/71EPGEnZt5cQUiy0QjLrjBvrnLQWyvrD39iQHmbDJchgSBNR
 9Y7FQ5F9PMT/hwPAJlX8JmYU49DuATN6j+rVDCDWoF2VlDKMNrVKgl9+Insk15seBVpFVH7
 u1ApZ32gVQPZ7E/2nnCPQ==
UI-OutboundReport: notjunk:1;M01:P0:AFLyzb9nul4=;Etr8Ld760mhTwZ1bolZuhmbqCp4
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/7/25 23:12, Richard Henderson wrote:
> v3: https://lore.kernel.org/qemu-devel/20240909172823.649837-1-richard.h=
enderson@linaro.org/
> v4: https://lore.kernel.org/qemu-devel/20250224171444.440135-1-richard.h=
enderson@linaro.org/
>=20
> Changes for v5:
>    - Rebase from February.  :-/
>    - Use ldl_be_p in m68k_fpu_gdb_set_reg (phil).
>=20
> Patches needing review:
>    03-target-m68k-Keep-FPSR-up-to-date.patch
>    05-target-m68k-Update-FPSR-for-FMOVECR.patch
>    09-target-m68k-Use-OS_UNSIZED-in-LEA-PEA-JMP.patch
>    10-target-m68k-Move-pre-dec-post-inc-to-gen_lea_mode.patch
>    11-target-m68k-Split-gen_ea_mode-for-load-store.patch
>    21-target-m68k-Implement-packed-decimal-real-loads-a.patch

Hi Richard,
I noticed that the FPU emulation on hppa has some issues too.
Any suggestion, how one can test the runtime FP emulation (inside the VM)?

Helge

