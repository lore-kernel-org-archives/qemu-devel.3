Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FD4CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 20:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6aLa-0006me-2D; Wed, 08 Oct 2025 16:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1v6aLX-0006mC-Gp; Wed, 08 Oct 2025 16:01:11 -0400
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>)
 id 1v6aLP-00079n-Gv; Wed, 08 Oct 2025 16:01:11 -0400
Received: from smtpclient.apple (tmo-082-100.customers.d1-online.com
 [80.187.82.100]) by csgraf.de (Postfix) with ESMTPSA id 9B4BA608018F;
 Wed,  8 Oct 2025 22:00:57 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Alexander Graf <agraf@csgraf.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v2 2/4] hvf: arm64: add workaround for Apple M4 to run older
 macOS versions
Date: Wed, 8 Oct 2025 22:00:47 +0200
Message-Id: <19C5D37A-55BC-438D-951B-72A36FF67948@csgraf.de>
References: <2399E8DA-E73F-4B59-8E06-F989BA2B462E@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org, 
 Cameron Esfahani <dirty@apple.com>,
 Maydell Peter <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
In-Reply-To: <2399E8DA-E73F-4B59-8E06-F989BA2B462E@unpredictable.fr>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: iPhone Mail (23A355)
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
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



> Am 08.10.2025 um 13:36 schrieb Mohamed Mediouni <mohamed@unpredictable.fr>=
:
>=20
> =EF=BB=BF
>=20
>> On 7. Oct 2025, at 23:12, Alexander Graf <agraf@csgraf.de> wrote:
>>=20
>>=20
>>> On 07.10.25 22:31, Mohamed Mediouni wrote:
>>> Apple M4 removes FEAT_SSBS. However, older macOS releases
>>> do misbehave in such a configuration and do not boot.
>>>=20
>>> Use private API to trap SCTLR_EL1 accesses through FGT.
>>>=20
>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>=20
>>=20
>> These old macOS versions did not include M4 support, correct? So wouldn't=
 it make more sense to make more recent macOS work instead?
>>=20
>> Alex
>>=20
> Apple ships such a workaround in Virtualization.framework to allow older m=
acOS VMs to work

Fair, but we don't have to implement the same hacks :). I think from a user'=
s point of view, running macOS 26 is more important than 12 :)

Alex=

