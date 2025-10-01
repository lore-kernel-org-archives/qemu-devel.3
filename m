Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF9ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 19:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v42YC-00046Z-5i; Wed, 01 Oct 2025 15:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v42Y5-00042W-1k; Wed, 01 Oct 2025 15:31:37 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v42Xv-00063i-Vm; Wed, 01 Oct 2025 15:31:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7D7C056F30C;
 Wed, 01 Oct 2025 21:31:07 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id vJdB4nzcbkwk; Wed,  1 Oct 2025 21:31:05 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1B7CE56F2FF; Wed, 01 Oct 2025 21:31:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1554856F298;
 Wed, 01 Oct 2025 21:31:05 +0200 (CEST)
Date: Wed, 1 Oct 2025 21:31:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 0/7] testing and misc updates (docker, ansible, .git*,
 gitlab)
In-Reply-To: <aN102hEBf6vny20l@redhat.com>
Message-ID: <1a86ebf2-161e-975c-1808-d8d960c4f7e6@eik.bme.hu>
References: <20251001170947.2769296-1-alex.bennee@linaro.org>
 <4188260c-e8ac-9bea-5e05-6cd34c3e986d@eik.bme.hu>
 <aN102hEBf6vny20l@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1217501070-1759346968=:12443"
Content-ID: <6d41d47f-3ed7-9033-a546-fa717bc157ec@eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-1217501070-1759346968=:12443
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <1e863304-b987-22f1-15ce-fa3b996b4606@eik.bme.hu>

On Wed, 1 Oct 2025, Daniel P. Berrangé wrote:
> On Wed, Oct 01, 2025 at 07:56:21PM +0200, BALATON Zoltan wrote:
>> On Wed, 1 Oct 2025, Alex Bennée wrote:
>>> My first set of patches for the development tree. Should be mostly
>>> self-explanatory. We still need to apply the upstream COPYING patch
>>> the u-boot-sam460ex code but we should decide if its worth mirroring
>>> or should we just treat the copy as fully "ours".
>>
>> Which COPYING patch do you refer to? I have the upstream because when I
>> submitted this I was told to do it this way instead of adding the u-boot
>> sources to the QEMU tree. It can't be merged with the official u-boot used
>> for e500 because it has sam460ex specific patches from the machine vendor
>> which only supports this u-boot version. There are some updates from the
>> vendor for real machine which I plan to add eventually but it's still based
>> on an older u-boot version. With mirroring I can update upstream and send
>> one patch to update the binary once it's mirrored, otherwise I'd need to
>> send patches for each update and rely on somebody to merge them.
>
> I opened this:
>
>  https://gitlab.com/qemu-project/u-boot-sam460ex/-/merge_requests/1
>
> but then learnt u-boot-sam460ex is actually a mirror of your github
> repo, and haven't got around to opening a new MR for your repo.
>
> If you can pull the commits from that MR that'd be great, or I can
> open a new MR, as you prefer.

I can get the patches from the gitlab pull request above and apply them 
the my github repo, no need to send a pull request there. I just don't get 
notified about what happens on gitlab so I have not seen this.

I'm not sure what Alex Bennée refers to as fixing up the mirror. Is it not 
mirroring now?

Regards,
BALATON Zoltan

> With regards,
> Daniel
>
--3866299591-1217501070-1759346968=:12443--

