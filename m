Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4A2606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=VXI+8F3j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmOa-0002tz-Dj; Fri, 13 Nov 2026 03:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xRmOV-0002tW-0l
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:12:23 -0500
Received: from 2.mo15.mail-out.ovh.net ([5.135.90.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xRmOO-0006FJ-O0
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:12:22 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.109.231.224])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4jQqjk4xtHz43Wc;
 Fri, 13 Nov 2026 08:12:10 +0000 (UTC)
Received: from [10.15.146.202] (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 13 Nov
 2026 09:12:10 +0100
Message-ID: <ff4c1e4d-cb1b-4c61-ad2e-537131c45dd9@ovhcloud.com>
Date: Fri, 13 Nov 2026 09:12:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] NBD patches through 2026-11-10
To: <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
CC: Richard Henderson <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
References: <20261111035200.1751734-10-eblake@redhat.com>
 <820539b6-d161-43ff-8889-cb40c1ecc6f2@linaro.org>
 <avYRrN7--EID31IM@redhat.com> <878q2xz3i7.fsf@pond.sub.org>
Content-Language: en-US
From: guillaume vincke <guillaume.vincke@ovhcloud.com>
In-Reply-To: <878q2xz3i7.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 14293017842437275915
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFEwGYJAR9i7HiWX46iNZV5uK/BFswr9KiVxasEC4h6Cf1m4YFotI1MOD6KFT90BfV/O/ZsaMTUbTDrz3EF1ua1GCbJzxBj/RcmKzt2pwRR9GSOhsmiWCcQNWFly7XFNGPuW/j7MY2Cvw78U9s0UDlckCXk8vg1APL3nSZGf3tlfbrLYqFbhXipMRbRaqwOBFvnZvFXGrTrvZIPu2VRkFx6VEax+UyJtLRd88MvOcx2ezF+BZOyyX6LDIZ7d7EI7BGlXasX8tRscpjiroag8rTTSVWFEPdYG+1M7xAmuqX9HNxiyzhY32gO8uZeMaju96/c7shjCYf+haUjvGL7SPLAt0kH9xkGqmzZgNp7H/msEeTvnrBD2Ep9vA7OLltz1ID7+rudXliU02w3SzZ/7CWJKcivqEdyzvWLZ39FkqSI+3b/o2KASzKPjp4EqplPZrsZHD1QedEaA9ceqvD7vhVXyFGq3rimvUECtaO5VNt/BfroLacGozt+Y+jsvb6k8I1TPLWqLpKuY+9cLLqoR3d8O6C2cpN12YzqNeF5ZLfaGHVg6rjM7CZRtsBElymi99wOq6xmkeQZ7s7T7GcCiRwoWFy21CH+BERpGbrSfZYn8x3tQ5sPuTDfzVyO0EW8DGBqVMcp6oxxkmzahy3qQwkFlCppcMIl4fRmMyYItzrn/Q
DKIM-Signature: a=rsa-sha256; bh=vUIcYD/2vF+6Xqd6BetHY4lMrq/z//GVfZWg4dppG0s=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1794557531; v=1; 
 b=VXI+8F3j84ijeworVZXCzqgzPbd04pfds1YNRoFFE5PN6RxFw0BDwuoCeKUkRR+PXaEz84Sn
 kM6l63hzaqYyee5lZoGJQ4pjFmTbMeEBmXUv0Bqxy8RcgBhcSzqDyU/V3T3sxhZMb9tmg4VzzSk
 g1TfxrtNi72wTY1Yn+dpWRGM=
Received-SPF: pass client-ip=5.135.90.179;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=2.mo15.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 06:47, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On Thu, Nov 12, 2026 at 11:16:24AM -0700, Richard Henderson wrote:
>>> On 11/10/26 19:51, Eric Blake wrote:
>>>> The following changes since commit 723622bedb0b423de7d1c61ebbe6e7a71934949c:
>>>>
>>
>>>> A few bug fixes:
>>>> - Guillaume Vincke: improve connection retry if NBD client hangs up quickly
>>>> - Eric Blake: fix two low-severity CVEs with non-compliant NBD clients
>>>
>>> New failure:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/17979973534#L298
>>>
>>> 137/150 block-qcow2-optional+block-slow - qemu:io-qcow2-nbd-stale-connection
>>> FAIL             2.37s exit status 1
>>>
>>> {"error": {"class": "GenericError", "desc": "write failed: Input/output
>>> error"}}
>>
>> Shoot - looks like this hit the CI timeout despite our best efforts,
>> which is why Guillaume is working on a second series for making the
>> test more robust [1], although our initial take was that it is really
>> late in the 11.2 cycle to be adding a new x-debug- QMP command. I can
>> respin the pull request to drop the test and/or give it a longer
>> timeout so it is less likely to be flaky in CI.
>>
>> [1] https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg01941.html
>>
>> Markus, what are your thoughts on a QMP addition this late into 11.2
>> so that the test in 2/8 can be stable? I'm torn on whether the NBD bug
>> in 1/8 is severe enough to need to go in 11.2.0 proper, or whether the
>> bug is weak enough that it is safer to wait until 11.2.1 via the
>> qemu-stable process.  Patches 3-8 fix CVEs, so they definitely belong
>> in 11.2.
> 
> "Only bug fixes" since soft freeze.  The closer we get to the release,
> the more serious the bugs need to be.
> 
> Including tests with the bug fixes feels okay to me.  Test
> infrastructure in QEMU proper, like a QMP command, is pushing it,
> though.
> 
> What's the impact of omitting or disabling the troublesome test until
> after the release?

In my opinion, the 1/8 fix and the associated 2/8 test can be postponed
to the next release. That behavior has been there for a long time and,
as far as I know, nobody but me has complained about it. Taking the
time to get a robust test in is probably the safer option.


