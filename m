Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F96C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 14:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiuxv-0007Ty-Je; Sun, 12 Jul 2026 10:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wiuxt-0007R2-UM
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 10:15:29 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wiuxr-0000B2-OM
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 10:15:29 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id C3041240101
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 16:15:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1783865723;
 bh=AN83zGD63fQKKDSFerL4jvCFDFzXOPn0b1Aa17q+/eE=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=b4DVq5T/vQllOslk5IjLWZT4LQLEdDnzSGQ6GA4KID/lPPqg+zwAxKj/LfUtpPDGd
 dddtlDYF0YXcIIzjhTZpDNS4wcg4cdk+A4KRUpkMzdOWL43r5QxqYd05ZTm1w3TG4Q
 6BRbwlwuIXc8HNTHSH86eNvRv+JPhQ/FW9q2/pU4KSY1Nm5N78uFWIHqJHyc7Z8U4Y
 naQIi0pcgcYvbjm93F8fcj39ei0dPqjezMc9LzPdq/0hm/MwJMJF0NwF8hml20hmQ7
 e9OJNlUOQri9T9M0OhhFmXMmn0K/AtyT8mxvqHIdhJDtclbYbXnHN3bBkSgOxES6Nc
 /BBAvB4I72dtw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gynf25Fgnz9rxD;
 Sun, 12 Jul 2026 16:15:22 +0200 (CEST)
Date: Sun, 12 Jul 2026 14:15:23 +0000
From: Thomas Huth <th.huth@posteo.eu>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] A fix for functional patches
Message-ID: <20260712161522.05feab58@tpx1>
In-Reply-To: <CAJSP0QXkNYYxEcPFnaKdtcmtapGchXm=f9R=Ou+27Vdw5=zvjw@mail.gmail.com>
References: <20260712105301.35409-1-th.huth@posteo.eu>
 <CAJSP0QXkNYYxEcPFnaKdtcmtapGchXm=f9R=Ou+27Vdw5=zvjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am Sun, 12 Jul 2026 15:43:58 +0200
schrieb Stefan Hajnoczi <stefanha@gmail.com>:

> On Sun, Jul 12, 2026 at 12:55=E2=80=AFPM Thomas Huth <th.huth@posteo.eu> =
wrote:
> >
> >  Hi Stefan! =20
>=20
> Hi Thomas,
> This pull request is from th.huth@posteo.eu and your GPG key on
> keys.openpgp.org doesn't cover this email address. Please update your
> GPG key or let me know where I can find your new key.

Ah, drat, I pushed the key via "gpg" on the command line to the server, but
that's not enough on keys.openpgp.org, you've got to manually verify new
mail addresses there. Should be fixed now, please try again!

 Thanks,
  Thomas

