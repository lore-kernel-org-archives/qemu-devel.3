Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CA5D6E2A4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3ua-0001g7-0E; Thu, 21 Nov 2024 04:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1tE3uW-0001fb-W9
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:55:41 -0500
Received: from out-171.mta1.migadu.com ([2001:41d0:203:375::ab])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@linux.dev>)
 id 1tE3uU-0005QS-Rq
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:55:40 -0500
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1732182935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNTwZu8G3KkUisAF20aNUD9jX6/98InzR3X34hs28mU=;
 b=JmesKRrQ0PLGP8tBuDhdsGcGwKS1re3TQtclOXbvvj5mPg1N2cCvcPtJwLzchbbPJFGSY5
 utqi+bZkOtu8Sk7XP0G8whRtl7+s6LC/ch/CLBR8y88eyC75RZGDXmom3Jhqqh2XCLvjgw
 D2VEo9Dlp6SbmmBNrVFKQFwYaFN8tUE=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: New "rme-guest" QEMU object addition
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
In-Reply-To: <Zz8DMob1P-ip0qN8@redhat.com>
Date: Thu, 21 Nov 2024 18:55:18 +0900
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A08FAE0-3712-4EFD-A39F-3D39D92B8B07@linux.dev>
References: <9FF5EDFD-6026-4C3A-A6A1-A66521D837A5@linux.dev>
 <Zz8DMob1P-ip0qN8@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::ab;
 envelope-from=itaru.kitayama@linux.dev; helo=out-171.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On Nov 21, 2024, at 18:53, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Thu, Nov 21, 2024 at 02:34:24PM +0900, Itaru Kitayama wrote:
>> Hi Jean, Mathieu,
>>=20
>> I=E2=80=99ve been using you guys=E2=80=99 ccs/v3 QEMU for some time =
to bring
>> up an Realm instance without a major issue, and as a one who
>> is making changes libvirt to support CCA, I wonder if you
>> could merge the v3 local changes under qap dir first so I
>> can query the feature from libvirt?
>=20
> Is the CCA host kernel support merged yet ?  As a general rule we =
would
> not expect to merge QEMU support for a feature, until after the =
corresponding
> kernel support is merged.
>=20

Ah, only the guest part. So now I understand.

Thanks,
Itaru.

> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|
>=20


