Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EC7C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 13:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXhEK-00026G-In; Tue, 14 Jan 2025 08:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsu@peterdavehello.org>)
 id 1tXhEJ-00025p-62
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:45:15 -0500
Received: from mail-4317.proton.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsu@peterdavehello.org>)
 id 1tXhEF-0000Ae-Ov
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peterdavehello.org;
 s=protonmail3; t=1736862307; x=1737121507;
 bh=amc/slHbGDnfzHw/Et20S57RdQEPM7ovgUGPMfFrcj0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=GjZAUWPISquJHASIsLKBLg2//7CLnI8ahCf7qfVDl9wNoQOnR4ykcorirXmasC3pq
 sd2YrK8F2JNCViWYRtJjnknemHQYWXODiuUINWEwMuA7XIr8uJeSDyqqpFAS/QQX9v
 MWStAiyO3szkDO9xA+QlouUNQ7aU6FHHPMByIrCwSRSThFYt9d+Ay7Y1ZwG855N9Ss
 1gfu6FJd7sQSloXOG00N1PPEyG4dokYCjWu3oOmKiL/pgwBz+exLwOh/7/BClOuN7n
 WDL9kcN2sTdvOZj9HO8U4oOxnO4Sy2wvFO7xWCs7kSuUhpOr1jaWURbtLmbOm3FZ8Q
 pd3WlCMpjGm1w==
Date: Tue, 14 Jan 2025 13:45:03 +0000
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
Message-ID: <w0C7I-STdtazH_QTikLVqdGlKEDYBJd-xCkX1BXBPY-rRhhU6E0ARjv0_t9QiJpptsNzSJeGpotLRYaBMa2VGyucNEE9zOaCQ8YKWhGPlYk=@peterdavehello.org>
In-Reply-To: <Znmnr3XCiPM89Xag@redhat.com>
References: <adPv4goMCNmjeDRUK1LGCAHIZdOxvMoFAqlU1bCnvTCPsCTUFRQnOQnThBC3oIzU9IczdS6aw1vKLQ-w7Zk9CRo5FfvINiaInut_U4VwbeI=@peterdavehello.org>
 <CAFEAcA_D1+BUk01mXNwRehxYqyXQU+Zu98sWBujauk5L2tHh3w@mail.gmail.com>
 <Zh6qLCvyiSk6YkVy@intel.com> <Zh6oIH8Ihyn-9RwT@redhat.com>
 <pTgk5-fHZzZe_qQn7RdevQ7Dg9Yz_-I4jWPpYknkgbiStJvLCRlTj9EpfRY_K9GCqdSABB_s_xzuGBCxxRqDfzDIoO6AVcvP-onYk8yRiWI=@peterdavehello.org>
 <ZiCDzzFDRmQGPtDD@intel.com>
 <Fu0jQm-Z4E7D_J11oxIlfRJ9ZYK_QDKMYOs-9NNVX_jH9_aS5_9cyysois3SaVVtuTqR-H77MiwWLaa5RkPTEnCEdy0NvUmOuwqyirCbdhY=@peterdavehello.org>
 <5qJ0Q0ZnUCu-VdtMQOwzj54wLBfeXb9ozncO8PjFiOlXbu4RHQeVCZyn7ZMWq89yqqE7GZX3Bsuk9YqWugHmx-Wu4Oh1GZ5wboTuZ-QUk8k=@peterdavehello.org>
 <CAFEAcA8q5O1i-EDviKf-yN5DAsxsSofA3xa9ChMbn_tC91iNuw@mail.gmail.com>
 <Znmnr3XCiPM89Xag@redhat.com>
Feedback-ID: 93059541:user:proton
X-Pm-Message-ID: 9ff2e542aeb214a115b71cfe3ca1479e7a646477
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=hsu@peterdavehello.org;
 helo=mail-4317.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Peter Dave Hello <hsu@peterdavehello.org>
From:  Peter Dave Hello via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tuesday, June 25th, 2024 at AM 1:06, Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > We can't give legal advice, but the QEMU project doesn't do
> > copyright assignment. Copyright remains with the original author
> > (or with their employer).
>=20
>=20
> While we can't give legal advice, going back to the original question
> I have an observation that may resolve this.
>=20
> IIUC, the orignal question was what to put at the top of the .po file
> where it has:
>=20
> # Copyright (C) 2024 THE QEMU'S COPYRIGHT HOLDER
>=20
> I don't believe the QEMU community has any stated requirement that every
> file have a "Copyright" line present. Entirely omitting this line is a
> valid choice from QEMU's POV.
>=20
> What matters to QEMU primarily is that the file has a declared license
> statement.
>=20
> Any Copyright lines present are woefully inaccurate in most places, since
> they're rarely updated despite 100's of contributors working on a file.
> The respective contributors still retain copyright over their own work
> regardless of what a 'copyright' line says or doesn't say.
>=20
> IOW, the contributor (or their employer) may decide for themselves
> a policy of whether to include or omit such a "Copyright" line, on
> contributions submitted.

Thanks for the solution! So, to confirm, I will send PATCH v2 with the
other metadata fixes but without the "Copyright" line. Is that correct?

Best wishes,
Peter



