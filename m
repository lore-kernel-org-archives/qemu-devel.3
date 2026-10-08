Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2961CCA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 20:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvAK-0000sv-4C; Thu, 08 Oct 2026 16:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvAI-0000sn-Nz
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 16:56:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvAG-0000Yr-HA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 16:56:34 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HVRpv3542635
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 20:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tTkxmI/YB8njtii1AJK8E3nyf//Zo22dDhQSp87zcY4=; b=KwuEQMTKwtpQzO0X
 vLsz1ZdiPZotZXhsx81mF0KCB6D2qIjRZrfnhcdgsGvRc2ZZ4Yd6QIsYaS1A8sWG
 K71qVMk7aGwUyS7Za36S8+INxzEWm+VfuChiD6Rmfq5Kg5LcmiF3I/belcZqrUq2
 elmBPDKLxDwibBdZG3kHn8A+Q6qwh8+ulg1PM2u7hayy3n1fxK6C6PvY3pg8sXKS
 LxwDH96p3DZkSod6KkF+Vt38xLEmKOdDOivXg070CPEAycBEv6BLEDsputyrBqm0
 B8NbVz9n1M76EYMt9A+Edc3gg+ghOeYYNZAgvHpC+T3TAdz5VJ4/9C5b+4Q1CT9Q
 4BLefg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6baj1tyj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 20:56:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so12088365eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791492989; x=1792097789; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tTkxmI/YB8njtii1AJK8E3nyf//Zo22dDhQSp87zcY4=;
 b=kK45VxQ806osTlwCi8idjdUeEn65AcQaGqpc45NNon+4PVRBzVJ2nhKmJc5kLDQC9Z
 jj6AjvqsLR3LdT0pIpvr2NAGZTS3qkYszAKRzkGIjasX6RBizRuJIV2xhfUmlOyNctHe
 SqMt8v6b5xg4FBcOPUkn5V5l0bubOuSIwWpS4hHmI8x6OVCSv+YP48JMHpfLI5mCrvIT
 6NznsQkq8a1G+tGcSwaZlhklMD15h6chgv9QuFsKNBmC2XsxA9XP1xuxMLogGWJKDYGX
 SoZpN4pyUnKJ4GfdKlQ5Egiamv3t9g/i9MEZmB4fMJQUpzNcJJVtre1dsezI2Tf8IyPV
 Vjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791492989; x=1792097789;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tTkxmI/YB8njtii1AJK8E3nyf//Zo22dDhQSp87zcY4=;
 b=ZStbhvR+22QefIVbZgZoBpdRqpA15UfYfw1kKkh5UgVMyllqqR9PDQo72gFHKmqkMC
 opeFGWR8OI/NObEObegoxoihFF42075QuUErhJNSTTUQO03lg4vbInODxUbC04vnaIjJ
 J/KaGg5VSyOI2TGP1wCZ1RLRnoBRWg6vb6J2eX4RlDTnDwX0OZHLIruQFu2fIkK17+u4
 oxLyawx3Gkph0PigJ9nPbIbprSFxd/k/L1cEwSDZLu0l5ZpGU3iG73tMx6oyYYk58mdk
 yJOTFFga1fDTvEyL+S17/xnXYWYWs2Hbv4hBOHo1Gh3wGHavHBPdRus+6iT8GNPC8wMq
 mAJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPuMAZAcd0cMd+TrXSP58XK9rw4hkNOLRGsq3fSYoYHGfl+M26Hujj63rUAp/HJRdIVIKAyCVnekyz@nongnu.org
X-Gm-Message-State: AFuF++kK/xRQ+IowLwUv5+H2Qklp6/7HFqTWHdrCiwwdylGFHAdFhjT9
 5joMQQyRNHYGoYLaqw5XU2dBUFe5ToGcIU5AXqKKHnkqUjgutC8kb02xk/5a+CAqvx4COB0Qtf7
 +qr1exhY3B+wfeoZeqWQ7TfZ6SyrBgQ8TqQkO/G7bdh3CPVe4DgsPdlKZmw==
X-Gm-Gg: AYBFou3LZ0k1imdqcxCaYC186GCgR5o+pmF83gnJlocIvkhoKW/FaDPqmN7RJWiGGvH
 J174Ji5w7AEI74zC4x0YyrEDF8ESz1+JWUNDeT6PQ1rmakFb7GTOVxVQN+3EJio8MRsZhy2Ai/Z
 10nMepqEvqvOSosDu9gUJi1LB74gI6F8vxpH3+a/TV8+aBT4UtU6/r4XLOQzRd14n5Mb3RLovc3
 Pq1IVs+VrJDW/IpzG6uOZRnjrCUlrpEyZJnzMIjexN0lT3by3fs6DP2VNqGeEwmjTEPseFcQUnC
 B3v3qIiriHl1BXEAzZGhO6m9sSgMBLlp5PurGHQwFOI3e3IJNgwYCz+ZNkC9kz1A1ex6v4CtR/w
 zFo5KOATjySEq+NZIfzfoKzhe4WLu02kwMN8StK5n2QGpGuPL61TuEQ3rIYpp0QfBuBJ16w==
X-Received: by 2002:a05:7300:b106:b0:34e:f948:d7da with SMTP id
 5a478bee46e88-3537e0ce190mr67051eec.21.1791492989258; 
 Thu, 08 Oct 2026 13:56:29 -0700 (PDT)
X-Received: by 2002:a05:7300:b106:b0:34e:f948:d7da with SMTP id
 5a478bee46e88-3537e0ce190mr66983eec.21.1791492988378; 
 Thu, 08 Oct 2026 13:56:28 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb6a279sm479831eec.30.2026.10.08.13.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 13:56:27 -0700 (PDT)
Message-ID: <3d1987f5-f918-43fd-913a-38e7769886f9@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 13:56:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tests/qtest: fix and gaurd PXE test build on MinGW
To: Eric Farman <farman@linux.ibm.com>, Yonggang Luo <luoyonggang@gmail.com>, 
 qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20261008184119.142-1-luoyonggang@gmail.com>
 <85d04515-9ccc-4479-a29a-aa63f6e85e6d@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <85d04515-9ccc-4479-a29a-aa63f6e85e6d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4MyBTYWx0ZWRfX7hL5kzJZhEFf
 CeS1eRkSpxQaZwE1OpIk3Nu7LotwYSpaeUiPz1QQoVsWS4IdZLrqMAzPwxJBTwxtlTKGJ5vjOSO
 8tKNWl7D3iP/j57eRpB75fwgYxIZZjipOjMfyoEZR09OI//tCfTLyMQy1bIjt1lAQejwoZvCSJV
 H7aX1Os5Dfdxg3NjlYqQ/G7KU9nG97o9nmXZ/R4tlOqmSXMx4IcsCLZy6JlIHKNnoyD2JZj6qNj
 CPWWVLHaYcaLZ91f5ILdpixy3YV7hMnH2QtX8tCwRIg32wiTfthsOG/B/gWx3JPwxIhLni1eDl+
 736OtJkrQWI6qvutkH3ZE5Izp6pdQUezRsKdJhpiOx7842oA9X2DIw62dYabR5XOdWGOS3dvFkZ
 tXoM/y6kA5Jmq+ntif7l02TCSR85lsadfCd3cbKTYE90AgZQqEby3OkDuoXrCPxULB7MtVTXIgU
 Sv61/aeqLU672OllAgg==
X-Proofpoint-GUID: Px-W6cDHM2_7U5DRm70oo_ZZLs3s4P5V
X-Authority-Analysis: v=2.4 cv=H/dOUOYi c=1 sm=1 tr=0 ts=6ac8037d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=-RyyT4NInEUNS_i0HBwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: Px-W6cDHM2_7U5DRm70oo_ZZLs3s4P5V
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4MyBTYWx0ZWRfXy8C8nTHrF3dW
 E4WhHq9pU7DfTCjlNlfUuuYby2YLV3fCtjn4Zdi2MgmKTkoyzKwGdpIy7bXW0Ov0GqZiw0UjuHh
 Pm41NZ5vxc5fynMrqq8tDQkdj4IrSHs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080083
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/8/2026 1:30 PM, Eric Farman wrote:
> 
> 
> On 10/8/26 2:41 PM, Yonggang Luo wrote:
>> Replace MinGW-incompatible memmem() with a bounded memcmp() search of the
>> s390 BIOS image.
>>
>> The Windows cross-build did not enable slirp, so it skipped building
>> the PXE
>> test. The series enables slirp for that build, ensuring the test is
>> compiled
>> and the MinGW portability issue is covered by CI.
>>
>> Yonggang Luo (2):
>>    tests/qtest: fix PXE test build on MinGW
>>    gitlab-ci: enable slirp in the Windows cross-build
>>
>>   .gitlab-ci.d/crossbuilds.yml |  2 +-
>>   tests/qtest/pxe-test.c       | 12 ++++++++++--
>>   2 files changed, 11 insertions(+), 3 deletions(-)
>>
> 
> Joy's fix [1] also works for me, but perhaps this is a more robust fix.
> 
> Tested-by: Eric Farman <farman@linux.ibm.com>
> 
> [1] https://lore.kernel.org/qemu-devel/20261008195158.289711-1-
> zycai@linux.ibm.com/

I'll pull this one.

Regards,
Pierrick

