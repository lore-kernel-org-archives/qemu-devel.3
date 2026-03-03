Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6F1EC1451
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQcY-0005dJ-GQ; Tue, 03 Mar 2026 09:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vxQcR-0005c6-NQ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:21:05 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vxQcO-0004AZ-Of
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772547657; x=1773152457; i=deller@gmx.de;
 bh=TumcxEpp3AF51nmYrJht4Hs5cKKG2fG5U3luiZSZwgk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VulXKiuXlV7Qk3iq40trF6LwYFbmFaGl0zSls93+n2k0wYpecMoOICdBmiTatIoU
 wc5mBcnl4jfoApuL5tCQglIiIziOr3plH1ZdGQAlj7Ur4ymy3lZCkSDgTlE0i+xQo
 cSb1yJV4jPvJ5Hz72VmYverku5+D0jOcxjQmP/FXgWVUZzQHKmF0PHEzWV2uB7tQ2
 WTgAdGt9B5k7iSIx3ZbYXt52hq3uhYkUALFq8C46gcGWxT9F2S+iich9t8jb14Adl
 jNkuIsLWye/Uq4uMxEInFh+le110rdbYID5caSo3nEgBDOM3FqkrScPl1Xo11T7AR
 ngW8Gr3uT2iHMwt8CA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9Bu-1vI1L519de-00ZvGl; Tue, 03
 Mar 2026 15:20:57 +0100
Message-ID: <dae7e40f-baeb-4f26-b86a-49effa5ae1d0@gmx.de>
Date: Tue, 3 Mar 2026 15:20:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] hppa: Use 44 bit physical addresses for PA-8700
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260302-hppa-c3600-v4-0-447a800da8cc@rev.ng>
 <20260302-hppa-c3600-v4-4-447a800da8cc@rev.ng>
 <a61583f6-7be3-4c7f-94f7-a21a69eba5d7@gmx.de>
 <aabLOU6RXx6sioi6@hive.localdomain>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <aabLOU6RXx6sioi6@hive.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5sChXMHNv1fGVo3VsbSMJf49zqXZm0PHLsEBfHKC7Lf/DoQiCEm
 YEQvXoWYTssUOHlJ3VxclOxGp3ZJ6/c+j/ydUbRpKC9+mZ6yYYLUctklQSGo/oRDBuP+agD
 F1RwpRBltxDASQIcT+8oAwlInbzxxGt1AeYoZo3/wVUNCq/C5+R23Ylh1uKTmFlKcOUHwRM
 YcI185DFlzMwauly7niTQ==
UI-OutboundReport: notjunk:1;M01:P0:YLwLiOcvrno=;e3aUARN6RBbOnXXJumejfEyHnwo
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On 3/3/26 13:12, Anton Johansson via qemu development wrote:
> On 03/03/26, Helge Deller wrote:
>> On 3/2/26 12:56, Anton Johansson via qemu development wrote:
>>> This is in line with the PA-8700 specification.
>>>
>>> As the SeaBIOS functional tests requires a 40 bit physical address spa=
ce
>>
>> 44 bit physical address space?
>=20
> Hmm maybe I'm missing something then, the 44 bit functional tests still
> hangs.  [..]

There is (maybe) a misunderstanding.
In your commit message you mention that 40bits are required, but in the
patch itself you change from 40 to 44 bits. This might be misleading?
Maybe explain in the commit message why you put the 44 here?

          .class_data =3D &(const HPPACPUDef) {
-            .phys_addr_bits =3D 40,
+            .phys_addr_bits =3D 44,
              .is_pa20 =3D true,

Helge

