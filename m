Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72948606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EwjlA/hO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JtqQImpx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTQ9P-0003Ho-8J; Tue, 17 Nov 2026 15:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTQ9C-0003DF-TW
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:51:25 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTQ99-0003WQ-7z
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:51:22 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHKfYxX2620201
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 20:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rWOY+OsiGPdxU902uqEzS8Xew/jV8o17kgihxaouGJc=; b=EwjlA/hOURqYRTsZ
 QxYJzwDQ5XsAQ2R4IY0alBxVS1ldyZ+tPoM6kdVRFrcTV5Vm42kYrbD5hZ0eoFVJ
 KBvv6T3SRwxM8kuWgdgWPqjBJutd/CErFpgpfxsYwyLRaeiOqPBL739+HiEaDAVP
 2DKgmTlMjbcJZXLqfXmg2m647kqkPhMPPENoUsREpA1ykC7L74h27jLr2IedcLrR
 IINhfWYsCLLV4ozm84OqgIMpayZXSEFThxYDiREiuCKGB7D/RUZOnVYnBy6mzmzn
 +Z4kgw0fXDd0DV2ke77w81yBya4TU0/4XLxQJY2v6JlqB87bzRhn9w6HpGw2yz0g
 +GhL3w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0nc82nck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 20:51:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94967c6d4f4so40404285a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 12:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794948676; x=1795553476; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rWOY+OsiGPdxU902uqEzS8Xew/jV8o17kgihxaouGJc=;
 b=JtqQImpxQUdsI/SoeEQsbnWWTyQ06ZtUZlZGBZ85XVqnAHjiaOH6gE+OihsK/BX+BE
 /veKCBrHzYuUYuWs+ekCldfYOB8+mTwImsza8nAcStdU+lpmgvaRVVzmivVs5ZuvaKn9
 58fEnbXyixN0AU8ZF/2W8kXJcHxI/ljZ8YPYESHdhXOplVkGUWSDWwa78C5FOKgI6owW
 SZkHYUDn1LgfL5po+swCKlar4ZVXAcOB5llEgeGCjtGo2DK8QvUU/svlJYrUxkegdGtp
 cqz8IrZzRT0JJ1cKKWBwUPNbuwTEjAo20fudGjfhZ53++2klkRg5BscepBDaZ4Jv04RN
 y7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794948676; x=1795553476;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rWOY+OsiGPdxU902uqEzS8Xew/jV8o17kgihxaouGJc=;
 b=al9ge+olPaQjJPu7pyRCgsgfRLqrBJvAKHdMQwjXp5fxtK+8sgRpaukRKpwO4HD1rv
 F9J1wOHQ3Fp3WRSsNqEqv7sZN6YoooD6rNlZd2ezySyLZXFO6cSU927MTPzpN4+P2WBd
 t47TJRYELPu0jvtoHJAD6RDpVT+e1A/TUYdQc9gX9TBruJQSHriyP03cyaoxpWQ2TDpr
 IzMCJM5PYO0PZg0ZU9I521+ts4to1BzoolbVAijppO95odVorxQy6T6hNvsHFa+RKhrf
 3K36WScKnot8q6Y03gf+eoETZbApbRJQ89AdO/b8NLq2OqdmTIkiijHXzYHBn0u56Us+
 F1bg==
X-Gm-Message-State: APuU4Z88Y+4ex+JVnwnl21I2aZVtKkos3dHZ/IpIIYE1ze6yJ3pODjJy
 fXKZXIyGqa9EIQEOtv8RTNRj9zO6yXAx/rHz6EocK6mgCrPyokyvSgw6Ecz46bLAT2kNLak99jj
 ItuXZ/OemvipOVzgBbULCOxqSKAtVHm4Meq+j4ed1COo8Hda3KWfGilui5A==
X-Gm-Gg: AYBFou2WK2EHVhhlDsAh8tHLX3pCnAethHhVBDkkRcEuvBVymtGmFJOPDvLHZOESrCR
 CLaNGdD6btu/WUouBnaNl38V+EarFDWg2BmZbxAFkACPVmYaHlfA52+ut1vZSqtKKH60kBsA6vH
 6+r6MfVeXtT2nxBF59efeazYjb3X3J0dunP8doEkRHx6gqHpXZ/vuLZcspk5DEZUmTKsAZlOeeQ
 oFyqVY/bI9eDWrLyKady43iaveyyMtpMbk4p7rJF+DrPqzMHgvaQ6F9fSJTiyK8XLNGitN5C8sN
 IZbMDB/jSkkTO3608933oqT2DoFj+ecnR0SCgeQomSTomlJFRjXr2Wzq71ARg1MD8v6Akt9dhTQ
 uEA/tPJ9XsnOx7qxMkbDYjcUbsmXjyNFZYzJcYr3rBsNY8kVa7PgJHbpCODFHzGVDi9xDgoeTSd
 h2hQMmXMM=
X-Received: by 2002:a05:620a:700e:b0:949:698f:8be8 with SMTP id
 af79cd13be357-94999648996mr158034285a.64.1794948676164; 
 Tue, 17 Nov 2026 12:51:16 -0800 (PST)
X-Received: by 2002:a05:620a:700e:b0:949:698f:8be8 with SMTP id
 af79cd13be357-94999648996mr158030085a.64.1794948675466; 
 Tue, 17 Nov 2026 12:51:15 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2abfc4sm11879445e9.7.2026.11.17.12.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 12:51:14 -0800 (PST)
Message-ID: <a9b7112d-c0d3-41f7-9cae-39462ab10a27@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 21:51:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nbd: Add iotest exposing previous CVE fix
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 bea1e@proton.me, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20261113223742.2546619-6-eblake@redhat.com>
 <20261113223742.2546619-10-eblake@redhat.com>
 <20261117180601.GA391996@shajnocz.csb> <avyskW5PTOANZonw@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <avyskW5PTOANZonw@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LaipeTfi c=1 sm=1 tr=0 ts=6afcbe45 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=mDV3o1hIAAAA:8
 a=1lk-caD5MS19T83P-k4A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4MyBTYWx0ZWRfX6HCJs8cRK50z
 NUu+iK2zKmc+hf6KQKiSofpLYSW4uKIyqjo0Fh1NU24XWAjPDbGUo1HYK/KfmXd8kILd0GnPlEJ
 Bu+Jd/71Qf7JRU0RIYBuOXSbnpe0+HQ=
X-Proofpoint-GUID: Muzs1BT-OY1NRnUS3aL5tzEg9jO9bT5o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4MyBTYWx0ZWRfX8iwkaFovddGV
 /BHj3SOaBHx5wdZe7wBYPk7kTsdcsncuPWpVD37NE+Xn6Zuu+/hVCZRB6rZCgnAMd9YIMj22pfe
 4R27IyuFyF4uY5VxLhno54XD++V/xO+68C2Dz5EFHRsDX0jO9vsrnZQKMI2YNBnyIJn9eOMhAzl
 r82eLJUiJnEVNijTgZnqvbHgUOzYVDM5jbVC8xh5AICP9UMA95RIMA8a7p18ks4zH98SFMRjPcD
 UGwLUDAS/zFiFLYu7jCT7PaB9N/T3Fg/I7ti+UD36wm/TjLXQSPKJRwSAB29cXzICt6YJmHNJdE
 VUZgn+sxFQYTdTApHxcxdOs0uUQ1rkpSZr79IkLBj+oFozrWX+uOPV8U+S9A4f9IZhzJPRXOmPu
 RfwWda91OVRS3JZHCXTeG3GGZ/q0/UzGFssLzPC3hUP9WnAasSD5OBfGJC5lMWXtHQpuYs5cel6
 TWsKrXAlCHC7+IIx5Gw==
X-Proofpoint-ORIG-GUID: Muzs1BT-OY1NRnUS3aL5tzEg9jO9bT5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170083
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/11/26 21:07, Eric Blake wrote:
> On Tue, Nov 17, 2026 at 01:06:01PM -0500, Stefan Hajnoczi wrote:
>> On Fri, Nov 13, 2026 at 04:34:52PM -0600, Eric Blake wrote:
>>> Feifan Qian posted a sample script generated with the help of AI that
>>> created a known-broken NBD server that intentionally replies to a
>>> structured read with only a subset of bytes, to expose the leak of
>>> heap data from qemu as an NBD client into an emulated IDE drive. Take
>>> the idea of that test, but simplify it into a qemu-io test (much
>>> lighter-weight NBD client, and easier access to see what bytes the NBD
>>> client code is passing on) that more closely resembles paradigms in my
>>> recent nbd-robustness iotest.  Also, expand the test to cover multiple
>>> scenarios: in addition to the original test demonstrating a prefix of
>>> 20 bytes with unwritten tail, I expanded it to cover out-of-order
>>> replies, a hole-only reply, and a completely empty reply.
>>>
>>> Reported-by: Feifan Qian <bea1e@proton.me>
>>> Based-on: https://gitlab.com/qemu-project/qemu/-/work_items/3815
>>> AI-used-for: tests
>>
>> QEMU's current AI policy forbids AI-generated code.

OTOH nobody disagreed with latest policy sent by Paolo
(https://lore.kernel.org/qemu-devel/20260930085433.830743-1-pbonzini@redhat.com/)
and Paolo said he'd get it merge during a community call
(Tuesday, 5 or 6 weeks ago?) so personally I consider it accepted
and being processed, only delayed. I hope this isn't a problem.

> This tag is based on the ongoing discussion about AGENTS.md and
> code-provenance.rst:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg09158.html
> https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg00110.html
> (and elsewhere)
> 
> At present, as of commit 1915e810d, use of AI-assisted unit tests is
> still not approved for upstream.  And it appears that I started
> writing this patch before that AGENTS.md change landed, because with
> that patch in place, my LLM should have tried harder to dissuade me
> from posting.
> 
> I agree that my starting point of Feifan's reproduction script, which
> already documented AI assistance, already puts this patch on shaky
> ground, no matter how much or little else I further did with an LLM
> while polishing it into a more complete test (while I can attest to
> understanding every line of this patch and am not blindly trusting AI
> output, I genuinely cannot state that the patch is free from AI
> influence, despite the differences between here and the original
> reproduction script on gitlab).  Therefore, I agree that this patch
> cannot be applied until that discussion results in an upstream patch.
> 
> I don't know of any other easy way to prove that the CVE is fixed;
> nbdkit does not support out-of-order structured read replies, and
> intentionally writing a known-non-compliant NBD server is grunt
> work. In the past, when fixing NBD protocol corner cases in QEMU, I
> have resorted to including reproduction instructions that could not be
> easily automated into unit tests to instead occur as part of the
> commit message in the form of a quoted patch that could be applied to
> QEMU - certainly not as automatable, but still strengthens the power
> of the git log (see commit 6e280648, for an example), and something I
> am capable of doing without LLM assistance.  For the sake of getting
> the CVE fix into the 11.2 release, I could repeat that framework:
> amend patch 3/4 to call out more detailed instructions on how to patch
> QEMU into behaving as a triggering known-broken server, do a pull
> request on just 1-3, and omit patch 4/4 entirely (saving it for a
> future day when our LLM policy is relaxed).


