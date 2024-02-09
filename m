Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DF7C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYNGo-0001nI-81; Fri, 09 Feb 2024 04:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rYNGl-0001n4-Ms
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:34:03 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rYNGf-0006mo-I5
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707471231; x=1708076031; i=deller@gmx.de;
 bh=552pj6Oxo48KKTX4oCC8zcj8p3RVz34Jed5wLlRBaJI=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
 In-Reply-To;
 b=oDrA1j5r4e6Y7+2XHxUtZRqaxZYjiMrlBwV27YVT2WEMhXT3xVcMyf70AOCJ84Ey
 Lw5RglP6LnWgWrRbIeTNghXkJiL99ZpLx5Ks6UsQY0SuCz0axuLiQj23U8t2TaAUM
 w9UgpWPguOGITaYZ1RJydg5VL0UUqb4nQtZlJ5XTjOv3l0SjiNAtEQigW43HWpsCK
 7pCJc7J3UNcHGwm5F2GNCt0mEbN+m+1PII2pZ7/i9egcUMABn0P5zfeGKx6uP1vB9
 cR3WK/rMLzqzZx7x6ur2aihDHmoqqMh1vZILITGSdhM/PoemwK3MlqmjgiKK4Uvwv
 hCUFmESXOm29QoUdxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.154]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wlv-1qs4L01AS1-012LPu; Fri, 09
 Feb 2024 10:33:51 +0100
Message-ID: <209f0e2d-e7e7-40c3-a4a9-a3428b504680@gmx.de>
Date: Fri, 9 Feb 2024 10:33:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/tulip: add chip status register values
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>
References: <20240205194717.2056026-1-svens@stackframe.org>
 <9ac454b1-a49a-4d57-ad3b-c0849bd789ea@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <9ac454b1-a49a-4d57-ad3b-c0849bd789ea@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PGesJQ7yn3sYLN+qFw45MgBBeWW6yIetbiJR9tVr47xUJ7RYX8U
 8PpExgEExMGNLqRmziw9XaLYcWx4nS4bNOrC39FCy6VX9358oh9ImyNq6fJms4owxl6XteV
 iQdiNTTPT6Gk0mFsOR9Yahys+divRc/KR78Jj9/1D3IKwkL88RQI4ftB2NZbGzZt3vY8TCI
 dwkkZ5PN2GRMuejbQeiPg==
UI-OutboundReport: notjunk:1;M01:P0:H6sxJfDtkoc=;6VJRkO+vpVuaZuJhZTk+xWdce8p
 RbIYs8Hmg+j0ZJjPNmQ3/ry+nIIDk1L+W0RJS8Ub+DN7GAW0576hG1pNeFkSAzw1lsOEqHObO
 b3zkf6yUk+0G3b9rT2VrfBkTJnenycPQciNPqfXSU4jPo4uJ473JnFGizcI+ZyMeLc28Eb5xu
 falbGkPNPq03JIz9y6Nb/FBsSnwBOGEia87se2+hkKPxjYdcXECsZLqHqzK8bHxdsJbpkppV7
 3AHaEUK/OsChjLPGDrPyU2J4sLOSx4ygXSLuL3Pt/CKbSjbhNst2asECpzKG5weRwhM0pS3yX
 5d1npvr31IkV7BNwqGawKhEB1zahcoKvpW5QMoDJQpmNLF+oAiwf8xfRJMXuot6mKDYb0vcAs
 rxtERAdySuQ4kdPFIcL+AHtx/wVxVsmDAZbR6mtte7ILMRBTeNBkhr11LDaK/1ulWvB7iam5m
 HnEH2aGJBbphOOQpFQAadQeZNJunOnqW+Gr6nQElZWSNIa9UKVVC3bFB/5KdNCAYCMSDErGJf
 pONIvzopqdyvPni1giOhaugrbo+PWEzgqbibEXREHfv1tmmGd327/LlZqTOR9DIJQWpDiUaRk
 vxvDtILWnMrQhpjq8FqGFrOKRLGKUFPfpE1OUaAbYq7ApSWBoO2uqA5ghM3U9VJWZ2Pg6sCuC
 lQCwjfmUT7qOWPYx/ID3tWd4VW/Fjo1b93ZKEEFFsG/5VNeEbdlohowEVam4mDuCHq0Rh2Xb3
 rvE+f8JOYIUmuwTOtVRwo7ikwwHpZCfnyUsfFgIhJsJMrKBflIqkE6GQHXL6z4qgyaZbm1d3M
 PrpDCOhCoElEFGn6zvWOGbaKejEIprGtAS3oZ2mOKUhWk=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/6/24 23:33, Helge Deller wrote:
> On 2/5/24 20:47, Sven Schnelle wrote:
>> Netbsd isn't able to detect a link on the emulated tulip card. That's
>> because netbsd reads the Chip Status Register of the Phy (address
>> 0x14). The default phy data in the qemu tulip driver is all zero,
>> which means no link is established and autonegotation isn't complete.
>>
>> Therefore set the register to 0x3b40, which means:
>>
>> Link is up, Autonegotation complete, Full Duplex, 100MBit/s Link
>> speed.
>>
>> Also clear the mask because this register is read only.
>>
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>
> Reviewed-by: Helge Deller <deller@gmx.de>
> Tested-by: Helge Deller <deller@gmx.de>

Unless someone complains, I'll include this patch
in the upcoming hppa pull request...

Helge

