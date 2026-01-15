Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E6AD46602
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 17:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQuf-0006Rq-1Q; Thu, 15 Jan 2026 12:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1vgQuD-0006H1-KQ
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:13:09 -0500
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1vgQuB-0000mz-DR
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1768497188; x=1800033188;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=bQ/PL6HXflF+UsoHip2OxH7ej3RtCm81s6Srk621xMs=;
 b=rCEdZjP4eTDYhXhct9tijUg4YVJcUxp5HVxHrqHRNqjiqwL0hkWJY/nl
 Ex5Yio+UjUMXNVzUXEmr/8yFSQDffpTKwv8RuCHRgvZOiHJPnbwywTMEU
 x+qAQOCmhsXeFaXFg0Lh1vlalsTiaD/X/CXBG5t96FhvBOPt/3EZbAg5D o=;
X-CSE-ConnectionGUID: 3YqJIUY9RAyWBX8EARtV4Q==
X-CSE-MsgGUID: 5R+e4ycvRzKnLmPGCQBD+A==
X-IronPort-AV: E=Sophos;i="6.21,228,1763420400"; 
   d="scan'208";a="4234217"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 15 Jan 2026 18:13:02 +0100
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <aWesz4NEj0gCiU3D@x1.local>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <aWZk7udMufaXPw-E@x1.local>
 <3e46b0-69676d00-4d-1a5e27c0@252361837> <aWesz4NEj0gCiU3D@x1.local>
Date: Thu, 15 Jan 2026 18:13:02 +0100
Cc: "qemu-devel" <qemu-devel@nongnu.org>,
 "Romain Malmain" <Romain.Malmain@eurecom.fr>
To: "Peter Xu" <peterx@redhat.com>
MIME-Version: 1.0
Message-ID: <3ab1a6-69692000-6dd-11d9eda0@9483395>
Subject: =?utf-8?q?Re=3A?= Call for GSoC internship project ideas
User-Agent: SOGoMail 5.12.1
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On Wednesday, January 14, 2026 15:48 CET, Peter Xu <peterx@redhat.com> =
wrote:

> Logically, maybe we don't need to forbid migrate=5Fincoming to only w=
ork with
> a clean QEMU, because internally it's the same to snapshot load.  We'=
ll
> need some special care on zero pages but I don't see a major blocker =
yet.
>=20
> Said that, IMHO for your use case I still wonder if the shmem idea wo=
uld
> still be worth exploring, or if you have explored but maybe found som=
e high
> overhead on booting QEMU every time?  That's what I mentioned here:
>=20
> https://lore.kernel.org/all/aB4rhlVGCSk7IwoE@x1.local/
>=20
> I wished that would work out already, or maybe you've tried it and it=
 was
> too slow for you.

I haven=E2=80=99t had the chance to test it yet, but we plan to have so=
meone
evaluate and benchmark your approach against my dirty-tracking-based
initial implementation. It=E2=80=99s good to hear there are no major bl=
ockers to
supporting `migrate=5Fincoming` on a dirty QEMU instance. If your propo=
sed
solution proves effective but restarting QEMU remains costly, we may al=
so
explore implementing the necessary changes to enable `migrate=5Fincomin=
g`
directly on a dirty QEMU.

> Your use case is indeed special, if the dirtied pages are normally no=
t
> much, the most efficient way to do this is only record the pages chan=
ged
> from the snapshot and rollback only those pages, plus all device stat=
es.
>=20
> That's not a traditional "snapshot" concept, more like a "checkpoint"=
 and
> "restore", where now in migration we have CPR taking that term alread=
y..
>=20
>   https://www.qemu.org/docs/master/devel/migration/CPR.html
>=20
> But your case is slightly different from functionality, so that it wi=
ll
> happen completely within a single QEMU instance.
>=20
> So far, it sounds like a new QMP function v.s. snapshot save/load or
> "migrate" / "migrate=5Fincoming" to me, because it shouldn't need to =
record a
> VM image, but VM diff (for rollback only).  The bitmap you need here =
will
> also be attached to the VM diff (again, not VM image, because a rollb=
ack
> doesn't require a full image).

In most of our use cases, we would have a complete snapshot anyway, and=
 the
cost is a one-time expense. However, you=E2=80=99re right, a diff/CoW m=
echanism
would be sufficient.

> Not sure if that's what you want, though.  Anyway, IMHO anything like=
 that
> need to be justified first with above shmem idea not performing as we=
ll in
> the first place.
>=20
> >=20
> > I=E2=80=99m not sure if I=E2=80=99m still eligible for GSoC; otherw=
ise, I would have
> > applied myself :)
>=20
> I'm not sure how this will work out yet.. if there'll be a student wo=
rking
> on it I'll make sure anything to be posted to have you in the loop.
>=20
> Also, if it will work out, I'd expect we'll set the goal for the stud=
ent to
> start with the very simple, e.g. no multifd support and maybe startin=
g with
> one type of mem (anonymous?), we'll see.  There might be gaps to what=
 may
> start to help in your use case too.
>=20
> Anyway, feel free to jump in anytime to share your thoughts.

Sure :)

Thanks for your inputs!

Marco

(Adding Romain in cc, as he has been leading most of our downstream QEM=
U
modifications.)


