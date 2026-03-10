Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8241FCC9D1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 07:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzrAe-00017w-Nu; Tue, 10 Mar 2026 03:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1vzrAc-00015n-IC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:06:22 -0400
Received: from outbound5e.eu.mailhop.org ([52.28.168.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1vzrAa-0000q9-Na
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:cfbl-address:cfbl-feedback-id:from; 
 bh=v/JBIAuR3rz+9BevGSQ2nYhqZWgI2J2lAMXSfiqFFvw=;
 b=Favz8GNxaH8moKhLb1wi09Zi0UossFXaja2se12IpvbS68mIcaEdllt/9VMA7+xQk4YrMvyomvhwd
 6PBkytzVlYtVoJKce2OMgG5+SNlMTNN1/NRB3KWW8oZlmpEBZPK/IHlZBCSZoAzZp7m3bk9qECBPbd
 6qHGkpVTGycfgObw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:cfbl-address:cfbl-feedback-id:from; 
 bh=v/JBIAuR3rz+9BevGSQ2nYhqZWgI2J2lAMXSfiqFFvw=;
 b=f0bS//QFgWSDJ1EmNl1c76Qyz3/egIEYWfBOwmWyZWYsGxCoYwXT2MgOxnlhGoljk4D7a2ipSwGNy
 1pFvuTEiC9Lt18DF3pVTF/aKFb3xrB93lvNWWr7VWHnC6DsNimoVFVNgoEVGCoK+OtMGwXccFilXWr
 ryAbTjT/8XAWzK/iC4qZ2RXnX48yFCf1H2TdMDYKHWbCrBBozFRW8y9gATP1V0u7nr1u8WSr1ReIWX
 WoEdKNQS1Hv5gswwUQkq3GBvXLvoQLRsGQN40f5Pt33m7n3H/P2ODNbTQAzTE05yrGhdvkKTjXSdi+
 3w9sHiezishK05uhaeGG8BATPz4nslQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 9f8e8d27-1c4f-11f1-bb42-754228886235
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 9f8e8d27-1c4f-11f1-bb42-754228886235:13
CFBL-Address: prvs=0529f992e2=abuse@outbound.mailhop.org; report=arf
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 9f8e8d27-1c4f-11f1-bb42-754228886235;
 Tue, 10 Mar 2026 07:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v/JBIAuR3rz+9BevGSQ2nYhqZWgI2J2lAMXSfiqFFvw=; b=V7hKNHnXyxG3jxcTgR8pC93Byk
 Rdou3YuPF43BC/mnJf2Fffxr6b+DY3jxlsHwOP7lLUVJ9j+hHN9+kO8Sv8CjH/pkpHdHQ5uGzFcg6
 Z5/o5ZEvLi1Ffme4OvTRgADhu/Xrd7EeSlMVmu3aULCXC0AXA1eLLPIgOQD58zLOrAIkhDHCsLAFo
 Jx/D7BrypJreNo17KmKtid7kwo0M6ISitHB1kUv5RCHjMrfw/VJDy0o0cvj0ExEcmUZUH3BDtQj13
 LrdW/Sj5eWZpAbWtlqC1ZeudvnGJRb3Yp58iMt0V+/1G2JmJY70P+fqReDmy/mOd6KicaMMymvH2G
 xS1RwqVA==;
Received: from [134.3.93.166] (helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.97)
 (envelope-from <svens@stackframe.org>) id 1vzrAS-0000000Ay4x-3aRk;
 Tue, 10 Mar 2026 08:06:12 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: deller@kernel.org,  qemu-devel@nongnu.org,  Soumyajyotii Ssarkar
 <soumyajyotisarkar23@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Helge Deller <deller@gmx.de>,  Richard Henderson
 <richard.henderson@linaro.org>,  Fam Zheng <fam@euphon.net>
Subject: Re: [PULL 12/12] target/hppa: add 64 bit support to gdbstub
In-Reply-To: <87cy1cb2s8.fsf@stackframe.org>
References: <20251223155031.7110-1-deller@kernel.org>
 <20251223155031.7110-13-deller@kernel.org>
 <52cbaf6d-f7a4-4984-9561-ca31418cdc0f@linaro.org>
 <87cy1cb2s8.fsf@stackframe.org>
Date: Tue, 10 Mar 2026 08:06:12 +0100
Message-ID: <878qc0b1uj.fsf@stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=52.28.168.19; envelope-from=svens@stackframe.org;
 helo=outbound5e.eu.mailhop.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Sven Schnelle <svens@stackframe.org> writes:

> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
>> Hi,
>>
>> (now merged as commit b2c2d00f48cc5f4486cfba33b505ff86d79cb137)
>>
>> On 23/12/25 16:50, deller@kernel.org wrote:
>>> From: Sven Schnelle <svens@stackframe.org>
>>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>>> Reviewed-by: Helge Deller <deller@gmx.de>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> ---
>>> target/hppa/gdbstub.c | 62
>> ++++++++++++++++++++++++++++---------------
>>>   1 file changed, 41 insertions(+), 21 deletions(-)
>>> diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
>>> index 0daa52f7af..777f4a48b9 100644
>>> --- a/target/hppa/gdbstub.c
>>> +++ b/target/hppa/gdbstub.c
>>> @@ -21,16 +21,25 @@
>>> @@ -133,24 +142,35 @@ int hppa_cpu_gdb_read_register(CPUState *cs,
>> GByteArray *mem_buf, int n)
>>>           val =3D env->cr[30];
>>>           break;
>>>       case 64 ... 127:
>>> - val =3D extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
>>> -        break;
>>> -    default:
>>> -        if (n < 128) {
>>> -            val =3D 0;
>>> +        if (hppa_is_pa20(env)) {
>>> +            val =3D env->fr[n - 64];
>>
>> Coverity reports:
>>
>>>>>     CID 1645613:         Memory - illegal accesses  (OVERRUN)
>>>>>     Overrunning array "env->fr" of 32 8-byte elements at element
>>         index 32 (byte offset 263) using index "n - 64" (which
>>        evaluates to 32).
>
> Yes, there's indeed a check missing wether n is < 96. I'll submit a patch=
 later.

Looking again there is

if (n >=3D hppa_num_regs(env)) {
        return 0;
}=20=20=20

right at the beginning of both functions, which returns 96 for 64 bit
mode as the limit so n should have proper bounds already if I'm not mistake=
n.

