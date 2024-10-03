Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C601CF6D27
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 05:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swEp2-0004tM-Qq; Thu, 03 Oct 2024 01:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0+0/=Q7=kaod.org=clg@ozlabs.org>)
 id 1swEoz-0004t2-RF; Thu, 03 Oct 2024 01:56:18 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0+0/=Q7=kaod.org=clg@ozlabs.org>)
 id 1swEox-00025O-GF; Thu, 03 Oct 2024 01:56:17 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XK1Bb4YZQz4wcy;
 Thu,  3 Oct 2024 15:56:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XK1BY4Vr1z4wc1;
 Thu,  3 Oct 2024 15:56:05 +1000 (AEST)
Message-ID: <1d7c210e-d7a6-4233-b555-c99a41f3c4e2@kaod.org>
Date: Thu, 3 Oct 2024 07:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] ppc/spapr: remove deprecated machines specific
 code
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com
References: <20241001092910.1030913-1-harshpb@linux.ibm.com>
 <c39f54de-65f4-42a6-bde7-b5a4ea0c2056@kaod.org>
 <9228ccb5-ee38-4c66-aa54-667f52aa33ce@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <9228ccb5-ee38-4c66-aa54-667f52aa33ce@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=0+0/=Q7=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Harsh

On 10/3/24 07:16, Harsh Prateek Bora wrote:
> Hi Cedric,
> 
> On 10/2/24 12:26, Cédric Le Goater wrote:
>> Hello Harsh,
>>
>> On 10/1/24 11:28, Harsh Prateek Bora wrote:
>>> Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
>>> deprecated with reasons mentioned in its commit log.
>>> Removing the arch specific code for the now deprecated machine types.
>>>
>>> v2: Addressed review comments from Cedric
>>> v1: <20240917060300.943496-1-harshpb@linux.ibm.com>
>>> Harsh Prateek Bora (11):
>>>    ppc/spapr: remove deprecated machine pseries-2.1
>>>    ppc/spapr: remove deprecated machine pseries-2.2
>>>    ppc/spapr: remove deprecated machine pseries-2.3
>>>    ppc/spapr: remove deprecated machine pseries-2.4
>>>    ppc/spapr: remove deprecated machine pseries-2.5
>>>    ppc/spapr: remove deprecated machine pseries-2.6
>>>    ppc/spapr: remove deprecated machine pseries-2.7
>>>    ppc/spapr: remove deprecated machine pseries-2.8
>>>    ppc/spapr: remove deprecated machine pseries-2.9
>>>    ppc/spapr: remove deprecated machine pseries-2.10
>>>    ppc/spapr: remove deprecated machine pseries-2.11
>>
>> LGTM, I had a few questions.
>>
> 
> Thanks, I shall address the review comments in next iteration.

While at it, could you please also remove the pseries paragraph in
the 'docs/about/deprecated.rst' file  ?

>> Please be aware that the next QEMU cycle will have more machines
>> to deprecate.
>>
> 
> I realized that 2.12 had also been marked as deprecated earlier which I
> can include in v3, however would like to understand the rationale behind
> choosing the remaining until pseries-6.1 for deprecating in next release
> cycle. 

pseries-6.1 is not for this release.

> Please enlighten.

It's in the docs :

   https://www.qemu.org/docs/master/about/deprecated.html
   
   As a special exception to this general timeframe, rather than have an
   indefinite lifetime, versioned machine types are only intended to be
   supported for a period of 6 years, equivalent to 18 QEMU releases. All
   versioned machine types will be automatically marked deprecated after
   an initial 3 years (9 QEMU releases) has passed, and will then be
   deleted after a further 3 year period has passed. It is recommended
   that a deprecated machine type is only used for incoming migrations
   and restore of saved state, for pre-existing VM deployments. They
   should be scheduled for updating to a newer machine type during an
   appropriate service window. Newly deployed VMs should exclusively use
   a non-deprecated machine type, with use of the most recent version
   highly recommended. Non-versioned machine types follow the general
   feature deprecation policy.

So, since the tags date are :

   refs/tags/v2.0.0 Thu Apr 17 13:41:45 2014 +0100
   refs/tags/v2.1.0 Fri Aug 1 13:31:29 2014 +0100
   refs/tags/v2.2.0 Tue Dec 9 12:13:37 2014 +0000
   refs/tags/v2.3.0 Fri Apr 24 15:05:06 2015 +0100
   refs/tags/v2.4.0 Tue Aug 11 15:30:34 2015 +0100
   refs/tags/v2.5.0 Wed Dec 16 16:10:14 2015 +0000
   refs/tags/v2.6.0 Wed May 11 16:44:26 2016 +0100
   refs/tags/v2.7.0 Fri Sep 2 13:44:11 2016 +0100
   refs/tags/v2.8.0 Tue Dec 20 16:17:01 2016 +0000
   refs/tags/v2.9.0 Thu Apr 20 15:31:34 2017 +0100
   refs/tags/v2.10.0 Wed Aug 30 17:02:54 2017 +0100
   refs/tags/v2.11.0 Wed Dec 13 14:31:09 2017 +0000
   refs/tags/v2.12.0 Tue Apr 24 16:44:55 2018 +0100
   refs/tags/v3.0.0 Tue Aug 14 16:38:43 2018 +0100
                                                    <--- ~6y
   refs/tags/v3.1.0 Tue Dec 11 17:18:37 2018 +0000
   refs/tags/v4.0.0 Tue Apr 23 17:32:17 2019 +0100
   refs/tags/v4.1.0 Thu Aug 15 13:03:37 2019 +0100
   refs/tags/v4.2.0 Thu Dec 12 16:45:57 2019 +0000
   refs/tags/v5.0.0 Tue Apr 28 17:46:57 2020 +0100
   refs/tags/v5.1.0 Tue Aug 11 17:07:03 2020 +0100
   refs/tags/v5.2.0 Tue Dec 8 15:55:19 2020 +0000
   refs/tags/v6.0.0 Thu Apr 29 18:05:29 2021 +0100
   refs/tags/v6.1.0 Tue Aug 24 17:59:52 2021 +0100
   refs/tags/v6.2.0 Tue Dec 14 12:35:02 2021 -0800
   refs/tags/v7.0.0 Tue Apr 19 18:44:36 2022 +0100
   refs/tags/v7.1.0 Tue Aug 30 09:40:11 2022 -0700
   refs/tags/v7.2.0 Tue Dec 13 15:54:59 2022 -0500
   refs/tags/v8.0.0 Wed Apr 19 17:27:13 2023 +0100
   refs/tags/v8.1.0 Tue Aug 22 07:13:44 2023 -0700
   refs/tags/v8.2.0 Tue Dec 19 09:45:04 2023 -0500
   refs/tags/v9.0.0 Tue Apr 23 19:14:06 2024 +0100
   refs/tags/v9.1.0 Tue Sep 3 09:18:26 2024 -0700
   
We can remove up to v3.0.0. v3.1.0 could be a candidate too,
I will check.

Thanks,

C.



