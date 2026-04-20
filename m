Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7247DF5A8C7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 21:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEwQ7-0007X2-Pp; Mon, 20 Apr 2026 17:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Christoph.Seitz@infineon.com>)
 id 1wEwQ5-0007Ws-Vv
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 17:44:41 -0400
Received: from smtp9.infineon.com ([217.10.52.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Christoph.Seitz@infineon.com>)
 id 1wEwQ3-0002qw-RD
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 17:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1776721479; x=1808257479; h=from:to:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=tptC5O39Fvp1PZTLUE5bJePQtpX43tjqgErg0lHRRkk=;
 b=jJvCNIZnwU+iw/8/2/lDb0Pb44C3H6Lf2TV/CYHnEJTnmk3gGn59XMNU
 Sq7V0W4021np4ICOD3+ePfHBQ6dxmI9pJXey5HXy4buBDGCxydd+zYFPM
 AK0r8DDhj88DE+26ss1R1t0i2mZwpqc9OQRqCtzwVzOQSK8CIU+a9zmx4 8=;
X-CSE-ConnectionGUID: vMuEJ2vuRd25pXTWNDE5eQ==
X-CSE-MsgGUID: ZCKJONy1RWGuKk3dV49nZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="90506312"
X-IronPort-AV: E=Sophos;i="6.23,190,1770591600"; d="scan'208";a="90506312"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
 by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 23:43:36 +0200
Received: from MUCSE810.infineon.com (172.23.29.36) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Apr
 2026 23:43:36 +0200
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE810.infineon.com
 (172.23.29.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Apr
 2026 23:43:35 +0200
Received: from MUCSE804.infineon.com ([fe80::79dc:fdc4:4a16:1093]) by
 MUCSE804.infineon.com ([fe80::79dc:fdc4:4a16:1093%16]) with mapi id
 15.02.2562.037; Mon, 20 Apr 2026 23:43:35 +0200
To: <philmd@linaro.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 11/28] MAINTAINERS: Remove Bastian Koppelmann
Thread-Topic: Re: [PATCH 11/28] MAINTAINERS: Remove Bastian Koppelmann
Thread-Index: AdzRDhSQ8KtvH6cNQXeUbwdm0pwa6A==
Date: Mon, 20 Apr 2026 21:43:35 +0000
Message-ID: <4b5c41ec7fa24117a88384bde27594c7@infineon.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=217.10.52.204;
 envelope-from=Christoph.Seitz@infineon.com; helo=smtp9.infineon.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  <Christoph.Seitz@infineon.com>
From: Christoph.Seitz--- via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/16/26 1:35 PM, Philippe Mathieu-Daud=E9 wrote:
> On 16/4/26 11:16, Peter Maydell wrote:
>> Bastian Koppelmann has not posted to qemu-devel in some years and did no=
t
>> respond to a query about whether they still wished to be listed in
>> our MAINTAINERS file.  Remove them, on the assumption that they are
>> no longer active in QEMU.
>>
>> This makes the Tricore TCG CPUs orphan.
>=20
> Cc'ing TriCore users.

Dear Peter, Philippe,

I would join Parthiban in this effort, as I contributed some of the code to=
 fork. I'm working regularly with TriCore devices.

Best regards,
Christoph Seitz

>=20
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   MAINTAINERS | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index bc7c9b61da..7817a1c97d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -446,8 +446,7 @@ F: include/hw/xtensa/xtensa-isa.h
>>   F: configs/devices/xtensa*/default.mak
>>     TriCore TCG CPUs
>> -M: Bastian Koppelmann <kbastian@rumtueddeln.de>
>> -S: Odd Fixes
>> +S: Orphan
>>   F: target/tricore/
>>   F: hw/tricore/
>>   F: include/hw/tricore/
>=20
>=20
>

