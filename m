Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABBBCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDk2e-00052y-LH; Tue, 28 Oct 2025 09:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vDk2b-00052J-NP
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:47:13 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vDk2W-0005yT-DE
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761659221; x=1762264021; i=deller@gmx.de;
 bh=2Vy7KTc/EJBrSg1WY9e2cayk5oFaX7raxUp6ds5zpFg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=f8kh1ELoozmprWog6O4XbyNYjITnDoo99MY5brHfeiFbgeVUCj1FbBT4uWkSPjTD
 uI0y593b6t4AACzdtxmIHgRFSLvKMXDAq2opUiZj7YVw8bsIkFcRHE0K2AZFad/0P
 nb6l6d18+wUhdnD9JlLoFeNW0ry8vOi0M3gbFSXpJ7JpoplzDjsBa4SR+pmATGjxG
 JsvN0F9H2fSXtbF0QHJz77MVeHRI0KxvQd4rNELejUWTtWlnvXydHNVxLBNzuvDrD
 j8UtzaML0An3R2iT6q72ZfoKaI/SiPmg/uSpwuA64jEhAq7SsQrI4UZPhl9Due6Ww
 D3jo7kqVpLhny+n+BA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.74]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTNF-1vb4Ay1LXB-00M1d9; Tue, 28
 Oct 2025 14:47:01 +0100
Message-ID: <db1bad07-30c6-443d-9123-2205da3d14b1@gmx.de>
Date: Tue, 28 Oct 2025 14:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Use correct type for FIBMAP and FIGETBSZ
 emulation
To: Peter Maydell <peter.maydell@linaro.org>,
 Bastian Blank <bblank@thinkmo.de>, qemu-devel@nongnu.org
References: <l6slswtmabktu6g23so3sldafschilwbp3kqolny3lppjezosi@hn6ptmklek4q>
 <CAFEAcA-FdX1OwY07QSWfavJ9vQuyOhf2twOXY1GCREfER1_qHg@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA-FdX1OwY07QSWfavJ9vQuyOhf2twOXY1GCREfER1_qHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bPYtNyfONkqvwF/MfgPnqLvzo4qiRIrvcA0KPzG3EIYalLGbLZg
 NHQHYtp601sYRuuT4rDSVnkI5kVDPsGojHdM2mrCAgNQM41Hb6HZk2+NZLFUEuGZj4BAxq4
 A/NMVOD1D0qBuTpy6zws6glGablHiJIbjvAWxynpMaK3wbfR4tgFa2g52P/dFspMmHnqPGT
 +Hx2L1yHoo2evfW02qgqA==
UI-OutboundReport: notjunk:1;M01:P0:P+T0UlkA8eI=;hJ62vKG6cdJ+kiAyi7VCAhoX2t8
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

On 10/28/25 14:11, Peter Maydell wrote:
> On Tue, 28 Oct 2025 at 12:58, Bastian Blank <bblank@thinkmo.de> wrote:
>>
>> Both the FIBMAP and FIGETBSZ ioctl get "int *" (pointer to 32bit
>> integer) as argument, not "long *" as specified in qemu.  Using the
>> correct type makes the emulation work in cross endian context.
>>
>> Both ioctl does not seem to be documented. However the kernel
>> implementation has always used "int *".
>>
>> Signed-off-by: Bastian Blank <waldi@debian.org>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3185
>> ---
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>


