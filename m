Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mvj9Ir9v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWuDW-0000Ow-Ji; Fri, 27 Nov 2026 06:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xWuDN-0000HY-Iz; Fri, 27 Nov 2026 06:34:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xWuDL-0007rJ-Lk; Fri, 27 Nov 2026 06:34:05 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARB4giM2907934; Fri, 27 Nov 2026 11:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mcdnyU
 BkFlLRrQeD+6Mc8BibFkfNIVs/bZyei63zG7I=; b=mvj9Ir9vdFQthNo0eE3pds
 3yhtozEklPavbM7Kchd/O+TZ6rAHRNWMms4xGutKoeSLyKgqjizkYqt6+Q4E/3tX
 NS/qYUc0v6M4KyMjHaQz1U6Yd47LjAaMzpLlbARsh8hoOHDhIf7XKsYCwK9p/hz7
 ndcl5pQDGh/zzzCzwleyMOBFpIJKLqNRtypmYNT7E+7yn4nDSzcehTk8rCCU7UVJ
 iDosYFatcfEnVCUZC5hOjrW1A9fgKva3YXw2kZ5Yey9PB5LfqbTDj3BT5f23UkC3
 n89lpTcz59fduH/40AP0Eta7AZjwxNxTYI5GdDf5Qtcz+gjfYy84qfcx/wkQYNyg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkwj9y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Nov 2026 11:33:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARAoPUg973610; Fri, 27 Nov 2026 11:33:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6rhck23f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Nov 2026 11:33:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ARBXtlw34996708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Nov 2026 11:33:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8727520063;
 Fri, 27 Nov 2026 11:33:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 310682004E;
 Fri, 27 Nov 2026 11:33:55 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Nov 2026 11:33:55 +0000 (GMT)
Message-ID: <ee367d92-91d1-4b23-bc63-ba923878ff2a@linux.ibm.com>
Date: Fri, 27 Nov 2026 12:33:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: performance regression due to 0bd5a1b3d60c "block: Fix corruption
 from broken RMW atomicity"
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <5fa22932-3a6c-4b77-af53-a2d187e7603f@linux.ibm.com>
 <awldLyF7qI9lRPft@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <awldLyF7qI9lRPft@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NCBTYWx0ZWRfXxPRjHGIyXqs6
 9MoQabUJkO1s6osmqHY5w+Qi1wFkzsjutz2VeraozfydZyU9QndpnXR1BAdee1zsb9g1LUWfXMo
 cKZ2ZrLM27ofAixizrumL1TELHNXCLMInVVEgOBLg4aQDq2vg1IA8vIjcm+NQA5GR/53ITCplss
 GFSm3eP/Ke/xccliE2fpG7Z619ICabp3BAOJVPPEHUOqwlYkJc7uhbobhoz76C3PrFnMp1Od3K5
 9PYX5xCRlnQjt+fLfMuOwxiNaX0g5YNNyPl0WacV8BJvQL1LsklqgtJmSSQDCf229PUGJPWuTT7
 a5zWC2MO8zImLYBtnabGdGe3kiONAwtsl8FtmBF+DxO8VzhJdBcnqGertKFNXpH2WVc1K4dHhOF
 bz3C/dsbbdKyFUNlJnVJiYRtPknLjuZxI6TOHAYrwdzMfyz8qZS4SQLDEIWYL9rL6jMQ9nVzREw
 CnKWmxEaneUn4LhqYmQ==
X-Proofpoint-ORIG-GUID: lY8FuEuPg1C5NSipTaQH6OuZx1H8dfdB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NCBTYWx0ZWRfXx0lYf4YuP5Xs
 jtBMtG9xshv6jNnfBc6E2ylp0JY5Nm+sCb7uwzGDpNkIUEJbPXQMIYPdBhwWdVB0xyKl6ahZfa6
 PMIGcwo8z0PnMhMCfkiJMLhD1KMcI5I=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b096aa8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=H3Ugg3uGsnZbVKVStIQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lY8FuEuPg1C5NSipTaQH6OuZx1H8dfdB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270044
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 27.11.26 um 11:36 schrieb Kevin Wolf:
> Am 26.11.2026 um 16:43 hat Christian Borntraeger geschrieben:
>> the fix
>> - 0bd5a1b3d60c ("block: Fix corruption from broken RMW atomicity")
>> results in a pretty hefty performance regression for my nvme disk via virtio-blk and
>> multiple iothreads.
>>
>> I uses AI to analyze and summarize and the result was seem legit from what I
>> can tell, so I paste this is verbatim.
>> I verified that 0bd5a1b3d60c is bad and 0bd5a1b3d60c^ is good.
> 
> Do you see any difference after commit cf4f672c (the commit right after
> 0bd5a1b3d60c)? Some checks are temporarily duplicated, but I expected
> that after the second commit, there shouldn't be any visible difference.

master is/was slow so we found this. c74f672c was not measured alone
but I guess it does not make a difference.

> 
> In your use case, are serialising requests actually present?

very likely not.


> 
>> ## Description of problem
>> Since commit 0bd5a1b3d60c ("block: Fix corruption from broken RMW atomicity")
>> and the follow-up cf4f672c11d6 ("block: Remove now redundant
>> bdrv_wait_serialising_requests() calls"), tracked_request_begin()
>> unconditionally calls bdrv_wait_serialising_requests_locked(). The
>> `bs->serialising_in_flight` fast path that bdrv_wait_serialising_requests()
>> used to provide is gone.
> 
> Yes, that's a good point, and we could simply add this condition to
> bdrv_wait_serialising_requests_locked() if the walk is expensive.
> 
> In fact, I suppose we could optimise even the case that does have
> serialising requests by keeping a separate list of serialising requests
> so that we don't have to iterate over all the non-serialising requests,
> too. Though maybe it's not expected to have both serialising and a lot
> of non-serialising requests at the same time on the same disk.
> 
> Anyway, can you try out if the below patch helps? (Only compile tested.)
> serialising_in_flight doesn't actually have to be atomic any more, but
> it's the simplest change we can make for 11.2.
> 
> Kevin
> 
> 
> diff --git a/block/io.c b/block/io.c
> index e4568d4d244..5e2734e540a 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -703,6 +703,10 @@ bdrv_wait_serialising_requests_locked(BdrvTrackedRequest *self)
>   {
>       BdrvTrackedRequest *req;
> 
> +    if (!qatomic_read(&self->bs->serialising_in_flight)) {
> +        return;
> +    }
> +
>       while ((req = bdrv_find_conflicting_request(self))) {
>           /*
>            * If this request is the active owner of the data blocks it accesses,

Yes, it fixes the problem.

