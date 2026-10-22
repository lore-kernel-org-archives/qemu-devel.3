Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB0606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AdeYAbzv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EH6iTJ3C
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJwfR-0005oM-EV; Thu, 22 Oct 2026 13:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJwfL-0005nf-2J
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:33:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJwfH-0002sf-TH
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:33:22 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MEFE4I4115470
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xi2fcNisy3AzpTgpGQZeRqSGeSqe41NBRHqw6hRoxPg=; b=AdeYAbzvDoknkgTO
 Y5Wt+UUTALFPduKXrQmSyL2BRkj6OTvQwsO9BgeLYdFEv8Fz3K6A8sMSQiR/8PPh
 Nzva19rSF2YCEGZJY9J66//MfuYIvYdOdtAS0/BLENC7L8kaHnO9NAWLq/G+wB69
 jMcLNJWCkI+OWVTF9tLwbZAi6w/bLfVaOWkvUO1AKaGGz7t8LxQF/XXyTawDfZCx
 e7LKtm02/Hn3W7CcuB0/PcnElO50H0qmYLH4ObNtWapwrMKCZj1jqj5bngtYDW0O
 gs6bo8mw3YOM1b9QWtte3fPZNMefYLPQlSV80rSpPI2o+nB6f56DgUuDF/BsuyZT
 pXYxNg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a4smp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:33:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso65408eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792690397; x=1793295197; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xi2fcNisy3AzpTgpGQZeRqSGeSqe41NBRHqw6hRoxPg=;
 b=EH6iTJ3Ch7lq2namYEMcBJDhrXjXvbKbYUxvnm7KvMOH6CRuZAtkHf/DLw/foRyrPL
 lpEbQcrFUGrXqwvs8qlWGVK0vNLm4FKBukh200lZBH2wY48R3zxPAjXS4H5HpypqCBn/
 hlTLAJQ9O3XH9QpXBPcOlazeadx1g1I1xP4hC+3ksh8XN0BlF7RIovxcP1CCRkMMv3XS
 KMpzila7jD3GfBaATnbf8GCN6cthQ8R8zKpmIdIVOA9s97SUYb6JZfm0OLYyWIGT1EVx
 qkvf+MR/e9ZtriKxISn0vewOMDqm8UqHuQi3ZNHQObYSgMQUhJ+jz+IcOt628P/7uXHo
 kYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792690397; x=1793295197;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xi2fcNisy3AzpTgpGQZeRqSGeSqe41NBRHqw6hRoxPg=;
 b=o15ZjAm/RpccY7TJ3cHp4SlWsZOPXsS4MakiVfsLuqgeWpCB+uapHhy9Ct881teCjW
 k5fi2u8SA+soziIgpRc6qXMasv9kQ3RBNbutyjM7vrMwfctQnKlp7v4i+w0bofOzC9GF
 VRbkHKloE4mhSf+s4QezHRz1Zb3/4XDKw3ntHHB7b6urzsgNDzsoYhOp3lPFKWnsStxP
 nboIyspqxdSiH+7bfoGjQbBg0h4YVmDKS1Nf7eCdpiErwRc71+Es0JIM/zd8D8TizSK4
 8YrGwYoJDPPifGxod+uG6ELTMWFfPnufLuWmJtLAQHG1ucCTxAuxC+73SXe3gaCHXRTS
 VxLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmk550Yk1qJEDaxFHeih7BiIkVgKr4vQGn6M9vvOctYXJEQxbotSeH2Fqz8BCRNRxgN941bA34R020@nongnu.org
X-Gm-Message-State: AFq9FYLk+cVvzsA2BslMs4xvBf9hJnmAH6ec2Dm3e+RO+vr127nqab4x
 a4gV4V10OCL9xVvSGJt7FL5EX7VSQd3uRM7E1lji6nlH2fjYL0Xw/SSck1v5Iz+3IIpmanSvQty
 QsxB6X3E1m5nRokoEMpNdE71keGKX3bi+CI+nNady6sQUN5UhbFgfb2TFlQ==
X-Gm-Gg: AYBFou1v7fic42e2RP1rnMsL0laKX7t90lR8k930KTf6XVVYPCRBxcWycuuKF8mZFRl
 8gfqB9bOJCdFg5dP89Rrx9fSKt2Nn0WkJI7k3ZC6KYiSCi2Ynfq0Ko03G3tNoK2WRDob0BCTl7z
 +52fqN37u73xBFW89zq8EvWS34glsGqngbXLbX/er812K6De1ztnfVkjYy5nZjBsA1eHCd+Bv0k
 OSpQo9klR//hPbOlM3ZoZc4o0/dOnsKchwYeme0AecWlTauNMVotG6Ymjr43ZDgyfvcFAyQd/5K
 1uAVOVsbUeKyrvxqLXMC6wDsC5aGAxJRNQsZtML9SEWzvFRv2ESy/igyu8tRwc2/lOyvPjhWDEm
 uioJrFSptst44RgrooSELdGlKOIa/uAEDMxjsapxB9sXDt0KajBPBGrujSkNVTk9TLqYYqg==
X-Received: by 2002:a05:7301:2514:b0:355:fdc0:a811 with SMTP id
 5a478bee46e88-3674f1150a1mr7403945eec.37.1792690396837; 
 Thu, 22 Oct 2026 10:33:16 -0700 (PDT)
X-Received: by 2002:a05:7301:2514:b0:355:fdc0:a811 with SMTP id
 5a478bee46e88-3674f1150a1mr7403911eec.37.1792690396242; 
 Thu, 22 Oct 2026 10:33:16 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3673e153519sm19035481eec.3.2026.10.22.10.33.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 10:33:15 -0700 (PDT)
Message-ID: <c0774bbe-dcee-489f-862c-f481e58c1d73@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 10:33:14 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] ci 20261021
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
References: <20261021181932.9555-1-pierrick.bouvier@oss.qualcomm.com>
 <9d5de336-72b8-43d0-8d6b-0d38118099d9@linaro.org>
 <869bb694-51ed-43c5-a061-575b9ba91ac1@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <869bb694-51ed-43c5-a061-575b9ba91ac1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2OSBTYWx0ZWRfX8qRywT6nMDOO
 Df+bbam0lRaH2PPx35OI4Fj69e9edRmUJRrEGflMLN/fZDj3/2v+0fTM3wVFcoYaUE1I/K43xXn
 aawKYD+8yetgue4Ht1Y84+yxyYIxJ59C+90TbIX3ezlNANFMjV6b3B9MrD8tVI740FpiIINvS9B
 VMnMqTdRxXGa16pNdh8J8J334dD69UdQRIxP7lbpQThjjEVupAnRTmFP1bs6WPJj96VSbi337FU
 ZqsB71HdhbW8fz5RjrAWUBB3v0BLfh+FTWbuqR55DqU1BVvDtlvEAXdvlJTlDohANoz8JFY+1Ok
 J402/NGcuLpw2lzmHoJdJq0XUwLSJURRSgYo5TUOXT1O/trxgluWmnKb3RU3cwSZUp+wXGmgs3r
 0JQVGuTGOOXmargJg7GvSHdXk6pzKuLHofBQf2fX4E+E17au99GriwK14IIyS2LD7vk/xsB4GVd
 1XUM4iDUKmo/xpFmUdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2OSBTYWx0ZWRfX5HzAbfitfC/K
 1v1DiywMQMCSh4QDLjePUuGORYaVz8S3lZrBo1W95WcVqgvzxp8vcqTfHIIc6reqvYIqhfGMVH2
 EYDl01qpV/Osk8jnTHHmGPuR4dQz2Sk=
X-Proofpoint-GUID: 3v0GBKv4hhcampM-cQVdJI221hv_p5gp
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ada48dd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=NitKUj-CfXRYC8kXEnQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 3v0GBKv4hhcampM-cQVdJI221hv_p5gp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/2026 10:31 AM, Pierrick Bouvier wrote:
> On 10/22/2026 12:33 AM, Richard Henderson wrote:
>> On 10/21/26 20:19, Pierrick Bouvier wrote:
>>> The following changes since commit
>>> 8967b2fe1b2aaae3c29e207d85fab901d580a2dc:
>>>
>>>    Merge tag 'pull-9p-20261019' of https://github.com/cschoenebeck/
>>> qemu into staging (2026-10-20 07:04:06 +0200)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/ci_gitlab-20261021
>>>
>>> for you to fetch changes up to 3a6d37c9883d21529a01e3615960696f91499153:
>>>
>>>    ci: add automatic retry (2026-10-21 18:18:33 +0000)
>>>
>>> ----------------------------------------------------------------
>>> Changes:
>>> - [PATCH] ci: add automatic retry (Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com>)
>>>    Link: https://lore.kernel.org/qemu-devel/20261020231602.24344-1-
>>> pierrick.bouvier@oss.qualcomm.com
>>>
>>> ----------------------------------------------------------------
>>> Pierrick Bouvier (1):
>>>        ci: add automatic retry
>>>
>>>   .gitlab-ci.d/base.yml | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> Applied, thanks.
>>
>> FWIW, the first pipeline containing this was entirely green without
>> intervention, which otherwise has not happened this month.  I don't know
>> how (or if it's possible) to see which jobs may have been retried.
>>
> 
> That's encouraging.
> Yes, you can see it from list of "Related jobs" on a pipeline (right of
> the screen, scroll down).
> 
> For instance, on this recent pipeline:
> https://gitlab.com/qemu-project/qemu/-/jobs/17378918262
> We can see that build-user failed the first time.
>

Wrong link.
From this pipeline:
https://gitlab.com/qemu-project/qemu/-/pipelines/2976077103

Click on any job from build stage, and you'll see the Related jobs on
the right side of screen.

> Probably it's possible to extract this data using GitLab API is we want
> to build long term statistics.
> 
> Regards,
> Pierrick


