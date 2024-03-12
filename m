Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FF4C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 23:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkBRe-0001A8-Ti; Tue, 12 Mar 2024 19:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rkBRU-000191-EU; Tue, 12 Mar 2024 19:21:57 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rkBRS-0005GX-S8; Tue, 12 Mar 2024 19:21:56 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a45fd0a0980so480308566b.2; 
 Tue, 12 Mar 2024 16:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710285713; x=1710890513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tJvLcJuNxj2TeQ0WszubCEgOWoynQhoXA7HGSlK2zw=;
 b=BF3f8fVrxGIf+Tiy5zAbiE7VG5b8yRpd3rzzcfvDYe3alBWQlJ0n0Xv7pYl0+YRBqU
 pObdBt8vlVq3Wossx5k9pCVfC/aP0rmYr2ABnFCNXfBabpF5YAZycWGKI8S23/Gg+6/f
 zayCzzOQyabTE77yKHKS/JYrgq8YJOxIFMXbUNzWR+zVcsv62csd53LliEMxCRlCaYju
 0I8aTVeCrL/kqFm9grZIZG09COM5V4PQRMlBStgzkKPZsBDlDpx9LWh2RT5+01McjOAK
 7j3r7C/piF5/yshhVKiwBQypT0aMi6mkMOe2ra12qpUbcbvfVoefvQk6MnCuhh8OG4bx
 MxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710285713; x=1710890513;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tJvLcJuNxj2TeQ0WszubCEgOWoynQhoXA7HGSlK2zw=;
 b=e2x/Wz1xwuLblwioXd6R7gzCxDarp9t9RiLJGHpzmA9ABDthvpvelm/GCnTQoMsIDV
 vl78eZHux7kuMw5wLoaPRDRc7RKYn7xa7Zl1Lpy8Cf8s81YOeSNMEoaJrv2aeuMrDmRI
 i5uL5NwGfOrRwbgbo4PK81/LSr9aL21Yc95HtrehllUYx0nYnqwNTArjTsQmxyKOWsP/
 bH9epTktNoVqrLt+Gr5Ikt9r7FvW+c/Zm3lFVgGcz2RNwR0qKp5udkknDmdzi5YvibPj
 QvJ2+rG+PXX7Q7L1BgFdSyDMuhlIzZIb1edkbh1FjAXoce9y4H4XJn7R7iBrhvGGp8u/
 lIlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZewU62UvtdWSTIV7uTYEbV34ioQdn8ZKLmSmeOq993G7IuVRYClFddF6clzYF40z915JKWR2cqfjidiu5TsmPFQXf6mx6Qaw6hy1NZQmqYo2VTzimej611zM=
X-Gm-Message-State: AOJu0YwWKJaawZHgLIFV8dJnxUzGUZ0IrK/eLgOxZzjBNhr+IkFqYH0q
 2eELsp1MJa0YYNLsKKl7iNZYnhNF5LOvRma0wMqnZ8XvXXM2vH+7
X-Google-Smtp-Source: AGHT+IG9R+18UlGhZX6yZbASe/hgFNxIcgzv/OdIaQF/4UGSBhF6prbIvQ7GSXHYKr/3saY0A05ZvQ==
X-Received: by 2002:a17:907:778e:b0:a45:b36c:55c8 with SMTP id
 ky14-20020a170907778e00b00a45b36c55c8mr6751793ejc.38.1710285712692; 
 Tue, 12 Mar 2024 16:21:52 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-078-038.77.13.pool.telefonica.de.
 [77.13.78.38]) by smtp.gmail.com with ESMTPSA id
 r9-20020a170906280900b00a45cd2f2939sm4281233ejc.25.2024.03.12.16.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 16:21:52 -0700 (PDT)
Date: Tue, 12 Mar 2024 23:21:50 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
CC: Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_docs/system/ppc=3A_Docum?=
 =?US-ASCII?Q?ent_running_Linux_on_AmigaNG_machines?=
In-Reply-To: <CZRUH5CRDRDU.3NS44E5KB0SSY@wheely>
References: <20240220232200.042DA4E6005@zero.eik.bme.hu>
 <c9dc84be-c7bf-c676-491b-2c6b1164d502@eik.bme.hu>
 <a9814b1b-98d7-29d8-36f9-228f20206917@eik.bme.hu>
 <3E4E29CA-AE91-4C8D-BB51-B3759CF3110F@gmail.com>
 <CZRPETJSO62V.5YV22F323JKC@wheely> <CZRUH5CRDRDU.3NS44E5KB0SSY@wheely>
Message-ID: <687364B3-41CA-4B85-95C4-69568160C252@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



Am 12=2E M=C3=A4rz 2024 14:34:47 UTC schrieb Nicholas Piggin <npiggin@gmai=
l=2Ecom>:
>On Tue Mar 12, 2024 at 8:36 PM AEST, Nicholas Piggin wrote:
>> On Tue Mar 12, 2024 at 7:28 PM AEST, Bernhard Beschow wrote:
>> >
>> >
>> > Am 9=2E M=C3=A4rz 2024 11:34:56 UTC schrieb BALATON Zoltan <balaton@e=
ik=2Ebme=2Ehu>:
>> > >On Thu, 29 Feb 2024, BALATON Zoltan wrote:
>> > >> On Wed, 21 Feb 2024, BALATON Zoltan wrote:
>> > >>> Documentation on how to run Linux on the amigaone, pegasos2 and
>> > >>> sam460ex machines is currently buried in the depths of the qemu-d=
evel
>> > >>> mailing list and in the source code=2E Let's collect the informat=
ion in
>> > >>> the QEMU handbook for a one stop solution=2E
>> > >>=20
>> > >> Ping? (Just so it's not missed from next pull=2E)
>> > >
>> > >Ping for freeze=2E
>> >
>> > Has this patch been tagged yet? It would really be a pity if it didn'=
t make it into 9=2E0=2E
>>
>> Will send out a PR today and I'll include it=2E
>>
>> >
>> > FWIW:
>> >
>> > Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>
>> Thanks, always helpful=2E
>
>Oh you are Co-author=2E Sorry, took some time for light bulb
>to turn on=2E=2E=2E In that case it needs your SOB to merge=2E
>
>I will have to leave it out of the PR if I don't get that in
>time, but we should be able to get a doc improvement past
>the soft freeze=2E It's essentially a usability bug-fix=2E
>
>Thanks,
>Nick
>
>>
>> Thanks,
>> Nick
>>
>> >
>> > >
>> > >> Regards,
>> > >> BALATON Zoltan
>> > >>=20
>> > >>> Co-authored-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> > >>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>> > >>> Reviewed-by: Nicholas Piggin <npiggin@gmail=2Ecom>
>> > >>> Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>

In case it helps:

Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>[=2E=2E=2E]
>

