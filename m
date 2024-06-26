Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A11C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 04:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMKOQ-0002b5-IW; Wed, 26 Jun 2024 00:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sMKOO-0002Wt-VV
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 00:36:24 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1sMKON-0004gy-Ep
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 00:36:24 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4W88671Lcnz8PbP;
 Wed, 26 Jun 2024 00:36:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=+T8IVboqETIprlLBdE6KtAcC1UvwB/XObl6DvrIbrmE=; b=I8Tyrp+Hcv30
 VETNld01zTmV0OYyrbnZVdaFBc/RgniSVEDcoEY69rfDNyNNv8A1i50FIm+7Zub+
 3JXGToSu6IUKNqnxVPyfXGEGbdiIG+XSdqn53l/2dZZ2v8JFYg60S3ElXTSrTiMx
 1nIY5eYN80arDorOi5T/ZbZu72pC2B0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=XYw
 XziCC+6sWVZGBs7QQa+y7ZyiUiOrpiteh9fm2pMlslnZkB6z5tfjmAExz9hw4HiM
 8GoybZUiIO+Fqh7RF1PdNmF5G9OepkADTD5huP7ICXWXRVBquCo6ma2RqVsdOyEa
 7tO+t/ShhZkX3OAHhqxY+8Lp5u3O/cQA/WIs2+io=
Received: from [192.168.6.81] (172-97-210-189.cpe.distributel.net
 [172.97.210.189])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4W88670m51z8PbN;
 Wed, 26 Jun 2024 00:36:15 -0400 (EDT)
Message-ID: <a12e896b-7bb3-436c-a699-8c3658b55292@comstyle.com>
Date: Wed, 26 Jun 2024 00:36:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cpuinfo-aarch64: Add OpenBSD support
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <ZneEh51XKhxgZKpp@humpty.home.comstyle.com>
 <99682aaf-935a-4986-8832-dd2f2415f4ef@linaro.org>
 <169b725e-44f4-4fe7-9049-174136c393fb@linaro.org>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <169b725e-44f4-4fe7-9049-174136c393fb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2024-06-23 6:08 p.m., Richard Henderson wrote:
> On 6/23/24 10:55, Richard Henderson wrote:
>> On 6/22/24 19:12, Brad Smith wrote:
>>> +=C2=A0=C2=A0=C2=A0 if (sysctl(mib, 2, &isar0, &len, NULL, 0) !=3D -1=
) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ID_AA64ISAR0_ATOMIC(isar0) >=3D I=
D_AA64ISAR0_ATOMIC_IMPL)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info |=3D CPUINFO_LSE;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ID_AA64ISAR0_AES(isar0) >=3D ID_A=
A64ISAR0_AES_BASE)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info |=3D CPUINFO_AES;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ID_AA64ISAR0_AES(isar0) >=3D ID_A=
A64ISAR0_AES_PMULL)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info |=3D CPUINFO_PMULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mib[0] =3D CTL_MACHDEP;
>>> +=C2=A0=C2=A0=C2=A0 mib[1] =3D CPU_ID_AA64PFR1;
>>> +=C2=A0=C2=A0=C2=A0 len =3D sizeof(pfr1);
>>> +=C2=A0=C2=A0=C2=A0 if (sysctl(mib, 2, &pfr1, &len, NULL, 0) !=3D -1)=
 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ID_AA64PFR1_BT(pfr1) >=3D ID_AA64=
PFR1_BT_IMPL)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info |=3D CPUINFO_BTI;
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> Need braces for all of the if's.=C2=A0 Otherwise,
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Fixed braces and queued to tcg-next.

Thanks.

