Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08D3107BCE2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 20:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1967-0000vv-JC; Fri, 13 Mar 2026 16:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w1966-0000vX-9l
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 16:27:02 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w1962-0008Jn-US
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 16:27:01 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 44796596D8D;
 Fri, 13 Mar 2026 21:26:49 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id o7VTRFl8zTay; Fri, 13 Mar 2026 21:26:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3D12F5969EB; Fri, 13 Mar 2026 21:26:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3B2DF5969EA;
 Fri, 13 Mar 2026 21:26:47 +0100 (CET)
Date: Fri, 13 Mar 2026 21:26:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Warner Losh <imp@bsdimp.com>
cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH RFC v2] bsd-user: Copy linux-user/think.c to bsd-user
In-Reply-To: <20260313-share-thunk-v2-1-5b52cfe6cddd@bsdimp.com>
Message-ID: <e4bab524-1397-656b-2741-3cc9fe5235ad@eik.bme.hu>
References: <20260313-share-thunk-v2-1-5b52cfe6cddd@bsdimp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-138819698-1773433607=:21685"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-138819698-1773433607=:21685
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 13 Mar 2026, Warner Losh wrote:
> bsd-user's blitz branch has used this file verbatim for a while. Copy it
> verbatim, but update to the new QEMU standards.
>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
> As suggested in the v1 thread, just copy this file.  Refactoring was
> difficult due to the inter-relatedness of all its bits with
> *-user/qemu.h file. We couldn't move it to common-user and putting it in
> that directory because (a) qemu.h dependencies and (b) common-user is
> built only once. It may be possible to refactor this into a .h file, but
> the interdependencies have so far restisted my efforts to do that, so
> I gave up after a couple of hours of different attempts.
>
> ● 6e7455de310b: bsd-user: Copy linux-user/think.c to bsd-user

think.c -> thunk.c which does not matter much here but this typo is also 
in the subject.

Regards,
BALATON Zoltan
--3866299591-138819698-1773433607=:21685--

