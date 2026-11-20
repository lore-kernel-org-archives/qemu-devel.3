Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1638A606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=bqdxtcfz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUJwl-0002t1-1n; Fri, 20 Nov 2026 03:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xUJwi-0002sS-02
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 03:26:12 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xUJwg-0005mP-2F
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 03:26:11 -0500
DKIM2-Signature: i=1; m=1; t=1795163167; mf=PGRlbGxlckBnbXguZGU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=; d=gmx.de;
 s=s31663417:rsa-sha256:s5SuCctm94uiHWbuA0joFKRxMRcD
 lA1/Ai9XZyJOoMM1nQfurNLGUQQRjKYCopW4abu3VkKRVELaVKFjps/TgWrcTjLRQ1jze/1dEOz
 7ueOngUddBMJcV1fcZR+2wzIYcoT1+qJTQzTwRLymdeFh6TjcRkuiVH/yMIv4YLu8URnw9MYiuI
 79e5Jpgmz+gSuc5hUSxjfigAGksKdOqJ4YzF/yPPhaKrFEiL9McSAqeCtfxQfvkaux5cP01xMBI
 IaFteSzmQUcVn0zT1My2DCLQLZf3PDt4k4Ry3WbHca5FNi3SIxRFOHcUVl5MDcRS34OKyiddj/6
 fb1qrWlHCEEFwQ==;
Message-Instance: m=1; h=sha256: SqINxkaU4ZdHPGVx2sGFQHAeF4SDDsI5vgyzjDZC6Ms=:
 GxO1BnqEPGPunpjqXAGVOW8rWkj+PgjSrP6OaoGCQME=, sha512:
 7CO9PxaJWztkn8+GdCmWZP3ordJusfInL0jAJVCFoikc9JQJXOjLi3VUMHGyCAchXeAAytTecdVqQNoCttUoPg==:
 3GyeL2YymNqOPjQMUyANeK0+iMspE7LriJuWwuAz6xD0WtYC7HvyOueGEpQQnHDURcm/hbiDiHDnT0bYKIuS/Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795163161; x=1795767961; i=deller@gmx.de;
 bh=LSODZjnHhXQPCS0yzUD8EyO8oIb9ZtzsJwgAe6wc93A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bqdxtcfzXsTrGoCtG6ok/7Gifp2iAaV375k3acK49nS1ttPFRwV1veIyIPzfilLI
 9J1104PQAkQl26cVT8npdweDkHQNBbcgghC9fzHVK2pSSLWB5LwG6jnMll4gja8qq
 FiBtUwj3txENzbqL7hEyhtGfmRFMqNvxgXhu7VaBuCCF44icjlLATUKAW/2MdryVP
 XrRbLtmAPYv17SRYYIxzQFiaQKXTIWQq1yYxtQCj65s63w7D+YRbTqy/RXB4WTNyM
 e2ZmCFsVF9345KyuNofSCRBhonYCH0b2/HtNPW505F97YnhUfScVy8Pky40AUUbH5
 UrIZ2yHc95pJxVEHyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1psI-1xWWrh238S-005XJL; Fri, 20
 Nov 2026 09:26:01 +0100
Message-ID: <062a8d3b-44a0-4938-8fcb-9f755d92c21a@gmx.de>
Date: Fri, 20 Nov 2026 09:25:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] nc53c710 rewrite
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Keith Monahan <keith@techtravels.org>
References: <20261119233235.32808-1-deller@kernel.org>
 <37f422f9-bb94-4eae-826c-56fed883812c@oss.qualcomm.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <37f422f9-bb94-4eae-826c-56fed883812c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KuSd5LWwnTktXkYoG6qMm1mOzYXDFsTvKabA7AAEgkNqjpZQCQJ
 p/MQ7Gv3xubWAf84pkYCJdDa1ABIn1nOa8NAMHCVU8+5+WfsUTtI/YzomIt4Kg4iPab3WtO
 S7N59xr7v4rrffsMNQ87mWYhbQVUBgnIifdycTwq5viKbypeh3c9V434hs+VPhFz2Nn9aEo
 OcX8jr5TjVzx+iTKALIUg==
UI-OutboundReport: notjunk:1;M01:P0:pVLCW+73ZPo=;j7t7E7SKEKd19m2Yb2vq8NZ3KvV
 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
 mfqeHeJGitug/Bz0m5OC3E=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 00:39, Philippe Mathieu-Daud=C3=A9 wrote:
> On 20/11/26 00:32, Helge Deller wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> This is the third attempt to replace the existing 53c710 driver by
>> a new driver based on the code of the lsi53c895a.c.
>> Patch #1 is not meant to be reviewed, as it basically just replaces
>> the existing driver by a new one.
>=20
> "Please do not review, simply accept".

Well, I agree, it sounds quite rude, which was not my intention.
I basically wanted to say that it's a hard lift-and-shift patch which
makes no real sense to try to review, as it is huge and replaces
most of the code.=20
>  =C2=A0hw/scsi/ncr53c710.c=C2=A0=C2=A0 | 3042 +++++++++++++++++---------=
=2D--------------
>=20
>> Please review.
>=20
> .
>=20
>> It would be great if this series can be included for qemu v11.2, as the=
 current
>> driver does not work stable for any guest OS.
>=20
>  =C2=A011 files changed, 1426 insertions(+), 2215 deletions(-)
>=20
> IIUC even v11.1 driver "does not work stable for any guest OS", right?

Yes.

Helge

