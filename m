Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53446FC9EFB
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 11:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyq2q-0001wQ-0t; Sat, 07 Mar 2026 06:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vyq2o-0001wI-6j
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:42:06 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vyq2k-0007y3-Cp
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772883713; x=1773488513; i=deller@gmx.de;
 bh=eweX2flbXrPDhR3MHDd7Oa7iiLqLVh1UxieboRlpu/w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=H9D42OcBAC8l88jUblPSCX6hdb8Du8fS9+Um2WAggurWcQlmFeJ0ZiyZ6wxm94UR
 HyvjBwH2nHyB1bcjES84yPaLplCgFq1wPYbbOSDCrhMgPmN+r7ZNRbdx20ufMwNsp
 hnESEpOUewW390YgGO/BrclW/06O/Eb1XygW9NU9spVGKUeEtSaOv458JHYTeptcf
 bWCeIPoFzsiFnE3ZGLP1uCSDZC3TPH2nZ12c/Nh26K3TkaHxvKmOy40lvIJan1y0Y
 KEU7HUAXlyykKML1mYJ4C+ry/Bj3d0d4x/dlGJcgeV4lhlpObhrug6SSYfduIOO/D
 IYPd33ZMeAlrWFb4KA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRMi-1w4Qdo3lNs-00OKO6; Sat, 07
 Mar 2026 12:41:52 +0100
Message-ID: <9ad53895-e340-433c-b60f-bb4901aad668@gmx.de>
Date: Sat, 7 Mar 2026 12:41:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/6] hw/hppa: Wire up Diva GSP card
To: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250207210540.24594-1-deller@kernel.org>
 <20250207210540.24594-3-deller@kernel.org>
 <CAFEAcA_VWSYYE+GdDRwxpWzOX6qVYptjYOe--azOzo4_pre_+A@mail.gmail.com>
 <aasZKZ1FQY5ytrb2@p100>
 <CAFEAcA8MLNYfDe_0chBmo+wwwNJoUHWj4Sg1nhCNSjodCzTOtw@mail.gmail.com>
 <aaseBa-3GVyjKGXh@p100>
 <CAFEAcA_g4tT2dTyWHoTn0hVZ_Soy7W_exh2JEE-C9U+PN4LGPg@mail.gmail.com>
 <aas7xpjiDx5Bhrs4@p100>
 <CAFEAcA_Tcarx1+EbLfrZxVpHFaKQkfOy_pTLc_T0FdNFRDfPTw@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAFEAcA_Tcarx1+EbLfrZxVpHFaKQkfOy_pTLc_T0FdNFRDfPTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wzLhKXceiMLcxEeK2+IQjjIRJUccgbp+2NsB9am9LGPiqdDjct9
 AfltRAxWVN3iG3Rxgp/TeUBEzkZS6cpABb3arfnGK9WwZqiEKQspueB3XWtugGCK6cXF4T3
 y1Pg7B04Ts1d8tUslUhjs1LrmC0Eb/1MRvyfjT/Hy0mrhewx1Mw08Bv81t3WwUkHAKTKAPw
 mGcxG5nqve0qkiJQBsHYA==
UI-OutboundReport: notjunk:1;M01:P0:Va5di6EabD8=;eqKwyM0nJzm+BQfPBoMm5fJTxK0
 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
 s+bvp1Tuieq9y2h1Q=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/7/26 11:46, Peter Maydell wrote:
> On Fri, 6 Mar 2026 at 20:40, Helge Deller <deller@kernel.org> wrote:
>>
>> * Peter Maydell <peter.maydell@linaro.org>:
>>> You need to increment the version_id and minimum_version_id
>>> to change the vmstate. Or you could instead replace the line with
>>>             VMSTATE_UNUSED(1), /* was "disable" */
>>> (which keeps the migration data structure the same, so no
>>> version bump needed).
>>>
>>> I have no strong preference; I would probably just bump
>>> the version numbers personally.
>>
>> New patch below.
>> Ok?
>>
>> Helge
>>
>>
>> From: Helge Deller <deller@gmx.de>
>> Subject: [PATCH] hw/char: Drop disable property of Diva GSP card
>>
>> The "disable" property is not used, so drop it.
>>
>> Noticed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>=20
> That looks fine, you can have
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!
 =20
> (You should send these to the list as proper patchmails.)

Yes, I'll include them in my next pull request and then
they will show up as normal stand-alone patches.

Helge

