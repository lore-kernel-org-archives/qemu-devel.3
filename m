Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5BEC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 12:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugjGe-0005cX-Do; Tue, 29 Jul 2025 08:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1ugjGM-0005OM-RP
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 08:17:03 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1ugjGC-0000b6-PH
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 08:16:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c1c:2f40:0:640:b89a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1128D883F2;
 Tue, 29 Jul 2025 15:16:40 +0300 (MSK)
Received: from smtpclient.apple (unknown [2a02:6bf:8080:47::1:21])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id cGYO7f0GqeA0-34nhxF02; Tue, 29 Jul 2025 15:16:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1753791399;
 bh=wvdaCRAXi0GZyh1SIe2k7hsrrOxKPtUt6wv1GzfKFto=;
 h=References:To:Cc:In-Reply-To:Date:From:Message-Id:Subject;
 b=TnfXl83b+jJNumZYJ5axJiueUfbmmau9qMjqxU6LyHW92Hohkm/UaR834K5lx49W1
 CmnSoCsvEkzrEik8xjJXwQ3Qp4jaPDduUAkW2dCxM4Q3ZKq5lmW/BbkNaeV+sKAm3g
 9BzYG3/hpfYiEvuzoTs4AIpcO4VB7v5WYjObbPx0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Kirill Martynov <stdcalllevi@yandex-team.ru>
Message-Id: <D31749EF-5115-405F-AE24-B982F5070D77@yandex-team.ru>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_54FD05A5-3D6E-4880-BC16-7E238FE24DC6"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 2/2] target/i386: Define enum X86ASIdx for x86's address
 spaces
Date: Tue, 29 Jul 2025 15:16:28 +0300
In-Reply-To: <18da82d6-39e1-4dc1-848e-b64cf40e0d49@linaro.org>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250729054023.1668443-1-xiaoyao.li@intel.com>
 <20250729054023.1668443-3-xiaoyao.li@intel.com>
 <18da82d6-39e1-4dc1-848e-b64cf40e0d49@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=stdcalllevi@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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


--Apple-Mail=_54FD05A5-3D6E-4880-BC16-7E238FE24DC6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Tested-By: Kirill Martynov <stdcalllevi@yandex-team.ru =
<mailto:stdcalllevi@yandex-team.ru>>

> On 29 Jul 2025, at 10:11, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 29/7/25 07:40, Xiaoyao Li wrote:
>> Like ARM defines ARMASIdx, do the same to define X86ASIdx as enum. So
>> that it's more clear what index 0 is for memory and index 1 is for =
SMM.
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>  accel/kvm/kvm-all.c              | 2 +-
>>  target/i386/cpu.h                | 5 +++++
>>  target/i386/kvm/kvm-cpu.c        | 2 +-
>>  target/i386/kvm/kvm.c            | 4 ++--
>>  target/i386/tcg/system/tcg-cpu.c | 4 ++--
>>  5 files changed, 11 insertions(+), 6 deletions(-)
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20


--Apple-Mail=_54FD05A5-3D6E-4880-BC16-7E238FE24DC6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;">Tested-By: =
Kirill Martynov &lt;<a =
href=3D"mailto:stdcalllevi@yandex-team.ru">stdcalllevi@yandex-team.ru</a>&=
gt;<br id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 29 Jul 2025, at 10:11, Philippe Mathieu-Daud=C3=A9 =
&lt;philmd@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On 29/7/25 07:40, Xiaoyao =
Li wrote:<br><blockquote type=3D"cite">Like ARM defines ARMASIdx, do the =
same to define X86ASIdx as enum. So<br>that it's more clear what index 0 =
is for memory and index 1 is for SMM.<br>Signed-off-by: Xiaoyao Li =
&lt;xiaoyao.li@intel.com&gt;<br>---<br> &nbsp;accel/kvm/kvm-all.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;| 2 +-<br> &nbsp;target/i386/cpu.h =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;| 5 +++++<br> &nbsp;target/i386/kvm/kvm-cpu.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 2 +-<br> =
&nbsp;target/i386/kvm/kvm.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 4 =
++--<br> &nbsp;target/i386/tcg/system/tcg-cpu.c | 4 ++--<br> &nbsp;5 =
files changed, 11 insertions(+), 6 =
deletions(-)<br></blockquote><br>Reviewed-by: Philippe Mathieu-Daud=C3=A9 =
&lt;philmd@linaro.org&gt;<br><br></div></div></blockquote></div><br></body=
></html>=

--Apple-Mail=_54FD05A5-3D6E-4880-BC16-7E238FE24DC6--

