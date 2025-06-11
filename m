Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDB9C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 11:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPJuM-0007rW-3N; Wed, 11 Jun 2025 07:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uPJuE-0007qT-DY; Wed, 11 Jun 2025 07:46:14 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uPJuA-0002j9-RE; Wed, 11 Jun 2025 07:46:09 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7585255C1BA;
 Wed, 11 Jun 2025 13:45:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id f_baXMbxMlG9; Wed, 11 Jun 2025 13:45:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7DA2955C171; Wed, 11 Jun 2025 13:45:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7B9A2745682;
 Wed, 11 Jun 2025 13:45:56 +0200 (CEST)
Date: Wed, 11 Jun 2025 13:45:56 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 4/5] configure: Add dtc option
In-Reply-To: <aElCJnmjrB-X9M-n@redhat.com>
Message-ID: <6eb6aa79-33f8-57ea-5714-af264557f8c8@eik.bme.hu>
References: <20250610204131.2862-1-shentey@gmail.com>
 <20250610204131.2862-5-shentey@gmail.com>
 <cdfc561e-23a9-607a-d9a8-70e07e73e0fd@eik.bme.hu>
 <aElCJnmjrB-X9M-n@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1454390608-1749642356=:93329"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1454390608-1749642356=:93329
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 11 Jun 2025, Daniel P. Berrangé wrote:
> On Wed, Jun 11, 2025 at 02:37:08AM +0200, BALATON Zoltan wrote:
>> On Tue, 10 Jun 2025, Bernhard Beschow wrote:
>>> The next patch will make dtc mandatory for boards with a bundled DTB, causing
>>> these boards to be omitted when dtc is missing. Allow packagers to force the
>>> build of those boards by providing an option.
>>
>> I don't like this. This might result in some machines missing from some
>> distros if they don't notice this and forget to update their packages and
>> these are machines I care about.
>
> "Someone might not notice & screw up" is pretty much an argument for
> not doing anything at all. We publish release notes to alert distros

More like "if it ain't broke don't fix it".

> to these kind of changes which is a reasonable effort on our part.
> Distros need to play their part by reading them and adapting to the
> changes. They can also compare the available options with new and
> old QEMU to identify any new build features they need to handle when
> updating.
>
>>                                  Also what guarantees that we don't get bugs
>> by compiling the device tree with different dtc versions which might
>> generate different binaries? The binaries we have now are known to work and
>> don't take much space so keeping them for convenience might be simpler. If
>> it worked so far why change it now?
>
> Ultimately the DTC project has responsibility to not cause regressions
> in new releases they issue, as is the case for any 3rd party dep that
> we rely on.
>
> We have CI jobs that can run on different distros. If we have coverage
> of the boards in functional test suite that provides a way to validate the
> operation with differing DTC versions as a sanity check.
>
> Distributing pre-built binaries in source release tarballs is a long
> standing issue with QEMU's releases. If we can eliminate the pre-bbuilt
> DTB and only ship the source that is a good thing IMHO.
>
>> If this was using dtc from the submodule when not using system libfdt then
>> at least it would not result in dropped machines and we had a known working
>> dtc to compile with. Why isn't that used when we already have it for libfdt?
>
> Are there any platforms that we target which still lack dtc ? The
> submodule was there to plug gaps in distro support long ago, but
> if every distro has dtc available the submodule is redundant.

OK, can we then make libfdt and dtc mandatory and not build at all instead 
of disabling boards without it? I only care that my boards will be in 
distro packages so users don't have to compile and I don't have to provide 
binaries which would also be ensured if we require dtc, then the dtbs can 
be dropped.

There's still a potential issue that some of the dts files are old and may 
not compile with newer dtc and changing them may upset the guest but 
hopefully we won't get that.

Regards,
BALATON Zoltan
--3866299591-1454390608-1749642356=:93329--

