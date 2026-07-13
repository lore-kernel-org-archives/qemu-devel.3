Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ABCC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjHPG-00043b-Gs; Mon, 13 Jul 2026 10:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wjHPE-00043B-9L
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 10:13:12 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wjHPC-0007kb-Bh
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 10:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1783951986; x=1784556786; i=deller@gmx.de;
 bh=WKKKHm4TizsEx6QAdkEItM0bLHMfOSmRRd2sGPS2M60=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mtMlEvPVvlotW4pb4VVyqZzGc/Dsj0qC7grazb3+FQdx6qQHtPB6UQu5XHDi/i9A
 ppKuYL5eKPOFeM7F+LjHnkpW/QChow1eYx7ouJh27FhjAHZKQpymyWs+yX8EaENpu
 OX8GOx8Mik/7XWQ8/5FCbAR2Tz6xV6kujiiT8oHrs/hLC3IE67racMd0VwT5ETb7h
 5NStXpNDHCAIxeJV1QI4EX6Dn5BA+cSVfcpn8Ts47+vjNA0M04VW7Ng+gDaubN680
 x1wn7YgnNayvkJfdXLXuPCoguMr+go7aXAlUMOhfWtSJdfRD8mnMgUDzzWu7pAcN5
 gNd8f1TuPasiChItDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwbp-1wuWs702PJ-00GhO2; Mon, 13
 Jul 2026 16:13:06 +0200
Message-ID: <a0d3002b-8047-4fa1-b15e-ed4c55bfb980@gmx.de>
Date: Mon, 13 Jul 2026 16:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/alpha: populate AT_HWCAP from env->amask
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260713013610.2691128-1-mattst88@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260713013610.2691128-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qv8f2Psh4pyUcT1kO83RulBxCFdjYTbAlShfvXLyJXN8ghnCMUv
 iDB0v/H5HCeQupumr2d++6H99zF75lEFg2TCX180wTB3uf6WPNI3zMjatrmiyaLsadMEPPA
 v9XhTzey0O0FG+7y5gEOyF2/laxhXsxzVNoraggTOFUwNPVkoKqL7z3CZB5MGPKm7Zizb+r
 tFOZXBVBQL6XIzYr2L4MQ==
UI-OutboundReport: notjunk:1;M01:P0:chfoJYfOMqU=;kdVuATXhIOXyiMCEez5P+XAXXIV
 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
 g5X0sP8oCK4piq/RLaKZUsKjssHpsv
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 7/13/26 03:36, Matt Turner wrote:
> Alpha has never set AT_HWCAP in linux-user emulation, so getauxval(AT_HW=
CAP)
> always returned 0 regardless of the emulated CPU model.
>=20
> The Linux kernel computes ELF_HWCAP as ~amask(-1), i.e. the set of ISA
> extension bits that the amask instruction reports as supported (cleared =
in
> its output).  env->amask stores exactly those bits with the same layout
> (BWX=3D0x1, FIX=3D0x2, CIX=3D0x4, MVI=3D0x100, TRAP=3D0x200, PREFETCH=3D=
0x1000), so
> returning it directly from get_elf_hwcap matches the kernel convention.
>=20
> Add HAVE_ELF_HWCAP to target_elf.h and implement get_elf_hwcap() in
> elfload.c to expose the emulated CPU's capability mask to user-space
> programs via the auxiliary vector.
>=20
> Without this fix, programs using getauxval(AT_HWCAP) to detect BWX/FIX/C=
IX
> (such as glibc's memcpy or JIT compilers targeting Alpha) incorrectly
> concluded that no extensions were available even when emulating ev56+.
> ---
>   linux-user/alpha/elfload.c    | 11 +++++++++++
>   linux-user/alpha/target_elf.h |  1 +
>   2 files changed, 12 insertions(+)
Reviewed-by: Helge Deller <deller@gmx.de>

I'll include this patch in the next linux-user pull request.
Helge

