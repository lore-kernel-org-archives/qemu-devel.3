Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB15CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 22:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIDaE-0001q9-2o; Sun, 09 Nov 2025 17:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vIDa9-0001QI-PO
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:08:22 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vIDa7-00068U-Iz
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762726096; x=1763330896; i=deller@gmx.de;
 bh=HcSDIeYaYKDnEf/c32vhZhnlOtrSkfkjsoY43TglQAU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Qs1CvFiYqFI4tyRxZKSnKaBJlBbg6eZhf4gotCG8Wx78K5okkG6C1sWABiF5nkoD
 eK/8X/sW01Q+zU6Mjobr7FH1qmyFZdQCYi+UkmxQdozmG5YIq6DOHaPaCYyvovm3D
 CxcqPlVP0cP6GeVn8WLy+iZHukSaIJWw52iJZ74tGSIczZMQXoNwtQOhBKBDmF1d5
 L2h1XmYh7fno+Kq/GiengXCUxHSxmUDMYP1wQjha7wj5qinPvK1tC9F70jHJpQFUG
 G/XtvXYh+OzpHIoZAdXw0OFgWcFS9/8fgOod55EIdCtIEP+0+ay+2wjr55U5WYlEa
 wyDyB8TAOAKBBpNBhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.171]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZkpb-1vfgWN06QJ-00OQci; Sun, 09
 Nov 2025 23:08:16 +0100
Message-ID: <2717ec21-25ce-4aeb-8dab-2ae1069cbcdc@gmx.de>
Date: Sun, 9 Nov 2025 23:08:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] HP-PARISC: LASI's NCR710 SCSI Controller
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: mark.cave-ayland@ilande.co.uk, sarkarsoumyajyoti23@gmail.com,
 peter.maydell@linaro.org, zhaoguohan@kylinos.cn, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20251103184031.22118-1-soumyajyotisarkar23@gmail.com>
 <CAJSP0QW4Egf2iJMjUVBi9iNPvGtEUMN=ULwM4+ntsFLDC3otHA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAJSP0QW4Egf2iJMjUVBi9iNPvGtEUMN=ULwM4+ntsFLDC3otHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ASTB6sIdm3xz4gSso4PWbTSsS51Igsh36OMB+e6d4Kzu5nDmZjw
 GRMAtHIVwELeoHcpTOJCT2i3BKeCze2Y2UQ8Xn6ycj6XiLt/9xoR2nThQeUN40Jt4A0/uk6
 WQJGSepQFW2UY+Cs2pG/rpV9bRq8ckGpp/CsyAKoGP5dptiWeBtMSW2tpi1dM6BvErJE/AH
 TDNwjppkXiPl9EmeCUJ6Q==
UI-OutboundReport: notjunk:1;M01:P0:KXUAa143NJU=;gfjv95cI6HIqkh9DxyMB7neuAQB
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/9/25 21:57, Stefan Hajnoczi wrote:
> On Mon, Nov 3, 2025 at 1:40=E2=80=AFPM Soumyajyotii Ssarkar
> <soumyajyotisarkar23@gmail.com> wrote:
>>
>> Fixing Defects reported by Coverity Scan for NCR710 SCSI Controller in =
QEMU.
>> QEMU runs the Coverity static analyzer to identify potential bugs in
>> code that has recently been merged.
>>
>> In view of the above these issues came to light.
>> I would request you to please review the fixes for the same.
>>
>> Reported by: Stefan Hajnoczi <stefanha@gmail.com>
>> and GuoHan Zhao <zhaoguohan@kylinos.cn>
>>
>> Soumyajyotii Ssarkar (2):
>>    hw/scsi/ncr53c710.c: Fixing null pointer dereference issue.
>>    hw/scsi/ncr53c710.c: Fixing Incorrect expression  (IDENTICAL_BRANCHE=
S)
>>
>>   hw/scsi/ncr53c710.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> I am not familiar with the device being emulated, so I have only
> reviewed this for C issues:
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks!
Btw, I just sent out a pull request which includes those patches.
(but in it I missed your Reviewed-by)

Helge

