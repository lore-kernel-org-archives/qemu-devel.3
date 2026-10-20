Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB28606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UchP7kg+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MMEXn1o7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFg3-0006MY-8e; Tue, 20 Oct 2026 15:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJFg0-0006LA-Go
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:39:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJFfy-0000OA-SH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:39:12 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI6qwG2224129
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ppHxf5KXdasFgxk8lScXrUhvP2vGdG8qageqW9K0OMM=; b=UchP7kg+xhiQ8A8p
 gPaEv+NEG4NCQBD0E59B26MY2VVXjc3+uF6m/+e+r79Pe3Fuxpe/8xDFxZrh+lzT
 OVelpqBmyS445y1XUXMVAH6OxnD7wn418m7Fi+XcAJvjEPmWr5tE2hWFgWCYcB7i
 AUHeiuxLCle1alorj/syYcI9F8eB/3ufULpyxDr/A7+6OrWzMsR3DD7OxHSjwTMX
 h4Jb5/YaQ8imHgLh+FQaUDWIVY2fTF/GG/h4HlPu+Lvp7gMB3yLA3xQPYvxv5z43
 x0MPi+uH0KjY3UWRRS2xEfaKIDhIRn7YUBKsGpLS043v7y4nXKyy8YJLPgbbO6q6
 cHyzdQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v0axb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:39:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb6391e89so3363885a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792525149; x=1793129949; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ppHxf5KXdasFgxk8lScXrUhvP2vGdG8qageqW9K0OMM=;
 b=MMEXn1o7BuYrsFUrlOyS41b/4fCoo2wN9sI4VvwvI7bfwd1/9YtYFSke83bn62uAoM
 Yk7KlNvQCP+dVXnKHKfRLujp6yg+TfTDyJ/sr4cPBFg5IuFcuJ/N3AsGL3vZc8vjg6eA
 4CqOZXfHE6ix1p3LTa7/RBryD2wuVHAS/TySxzhxOSXsqo0EsHmDWGLRrOk0VZw7Apq0
 WgPaQ+21uS8VXBkIuZBKEQECFZ5aF9BZFrT1f+P5IkKfBW4HM3r2CsR4T1xPAyUUQzOh
 /Clat84HCzj/Br2RkCC4DDoHxOhmcCyoRMtDXjRFS4yc8H31v4Oo/rXuU83YpQbgM73C
 BMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792525149; x=1793129949;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ppHxf5KXdasFgxk8lScXrUhvP2vGdG8qageqW9K0OMM=;
 b=OkmVKNkFG00+LAYNr+527ZhPc/fP4e3hkJ0rIPBg+XwmObgWn7aRG8TUeP8eRpstN/
 PskAN2Nd6EjvtRBEhYgtvhzP8fZ/2mAJ2XG0KKGnXBdDhVBt8pe99r0Ah8JcxBNkszGi
 mOMsx8DlZNbEqbmPN9WyASxWvzo2cftPFx9NK4V/2r41fdYEg06Yya3hANdmom8wyniu
 V7L6lJycM6cBrR3dyXl9bHMpsFIkdBcKO7NgmWEl/xMFJ1sLiHhAfkUutYnRVb4lwST3
 l5Axs0QFhT8s7Wr7hGkSA3rP2LqRuOPFu1AHkXmECRU2vqC7TXYhgrrN2kvHdV/97wpT
 tk9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWxyI/TBgxkivfpnXy8HFNyAyJwgG3pi2nStbjGx24/49/UN+QWQrjYj7LoJs5h9A2HUBwiB6I1z4V@nongnu.org
X-Gm-Message-State: AFq9FYK9PN42HyKPszz7MyRmX4MZUS/8H6sl7rXMuqSXSRTqfg6LzJJ+
 ZkSmBhW/nRuevgzbkklCilQn8wPxJC4tOWQIfnUW4U6ID8EcT3jD9i7sfMSJhpDoTkCaN1WcqS9
 mYI7KNkB62T5QbNkC1GoN3RvMyUnIExeDoZ6Dg4vI2+zN7WBo0QL6Yox9OA==
X-Gm-Gg: AYBFou1aarchptKieMSMWSlqgqLzA0yV5ZgDot0T0NJBiD/U+EOQPgvo6ps3lJahrgJ
 e/97GEah4+TZT6nHIpOvWsyWoQmkQjSOX54yuDnv6D9dvPOzdAMNRaWmUbhcCvs7Cvjs90V/+Mq
 8S3aFgwcBDLrUoR2jPS8+YEp4VUwMXof8YBUHZlECmdw0Loonx3zOoSeUo+m0tFfsoSsh/EPmIL
 fnVvZJRuMC1c4ei/q43Sx5MQSHuyxh/13PbPahyAtDae/hvnngLxiiYUHMQdz8A29tpGb5zmHj9
 dT/gLhyyX6ydGiCSIZkFs8pDPqdlbQQXuY9Uw78DcyXmyLcBl70nfKLdahMgS+abtAKU26WMU91
 1uWvKcKHId1vcfVo/tdC3M2/HrmuV/bdFqQ==
X-Received: by 2002:a05:620a:1990:b0:93f:2d10:ea49 with SMTP id
 af79cd13be357-93f57f1d8f7mr48293885a.45.1792525148790; 
 Tue, 20 Oct 2026 12:39:08 -0700 (PDT)
X-Received: by 2002:a05:620a:1990:b0:93f:2d10:ea49 with SMTP id
 af79cd13be357-93f57f1d8f7mr48289185a.45.1792525148331; 
 Tue, 20 Oct 2026 12:39:08 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0aef8fsm9134585e9.0.2026.10.20.12.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:39:07 -0700 (PDT)
Message-ID: <372f00d6-35ac-4a8d-84ac-ce329dd90ae7@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 21:39:06 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] target/sparc: Add the eight AES round instructions
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-4-stian@itx.no>
 <e6017bc0-22b7-4caf-932b-f9bc64687b78@oss.qualcomm.com>
In-Reply-To: <e6017bc0-22b7-4caf-932b-f9bc64687b78@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3OCBTYWx0ZWRfX/Ajr9EVRLl1d
 zOxsSX9lzeOEHH8LIMFWnsveK9xx9mP7v2vxBh42p1kSeBs/+DRP2WechrdY/891I30xZ0Ya8id
 newsIMpAOFM1otgL4GuidhMyz6v+SCQ=
X-Proofpoint-ORIG-GUID: t0kcmlL_wU3WkDW0K9JyMkoI8sOQtecO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3OCBTYWx0ZWRfX5t78bwUThEyJ
 wtzZhuwzZg3xNjQAkbXINc2aCXzBeOxOY64oDYMQ9PRZyzZ3YkKnMSDyftm1DPwb42DPQjYO9Wx
 YZyWsrw1ut0oUceCXGtjjDUg06lrmU0TaxflP1395FViXRKqeBY9+5jepiZdMYdQECJxxjHMUfG
 pakSXt1wLB1gSEswN5TXdInsguyZqSJeR7YMQoSWjCPK88QFDFC9I0n26IOoXqagW6HUg4VIN3l
 GE1jMKRWPjsoGrvu/OBX0wUpJCwTocQQk8ZnQR5FfFstY29D/uUAJ5xRjgw7LPzsSkFzFm6H+Mp
 08Ja5P4qmGtzy3ht3RL0fCyvgmOmHBK73m8Mrng7WAA886eKHdWAw8HhTi4jRyQ7/eiUxCApfUL
 VHzTG63ntu6PztQGyetsdQNJwMUNfpeU6HodcxUfZOjAcbkqU6hE8g68MVrssfSYuTndm1PntTG
 k0ABcDQ6DVqAPv0LrCg==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad7c35d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=tzrikmoJzQgICnpFMzUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: t0kcmlL_wU3WkDW0K9JyMkoI8sOQtecO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/26 21:30, Philippe Mathieu-DaudÃ© wrote:
> Hi,
> 
> On 20/10/26 16:55, Stian Halseth wrote:
>> Implement the eight AES round instructions by using QEMU's shared
>> crypto/aes-round.h, gated behind the crypto CPU feature:
>> - AES_EROUND01/23 and last variants
>> - AES_DROUND01/23 and last variants
>>
>> Based on OSA (Oracle SPARC Architecture) 2011, section 7.3:
>> AES Cryptographic Operations (4 operand)
>>
>> Signed-off-by: Stian Halseth <stian@itx.no>
>> ---
>>   target/sparc/crypto_helper.c | 85 ++++++++++++++++++++++++++++++++++++
>>   target/sparc/helper.h        |  8 ++++
>>   target/sparc/insns.decode    |  9 ++++
>>   target/sparc/meson.build     |  2 +-
>>   target/sparc/translate.c     | 16 +++++++
>>   5 files changed, 119 insertions(+), 1 deletion(-)
>>   create mode 100644 target/sparc/crypto_helper.c
> 
> Could we add tests (in tests/tcg, following commit 57b484e2d23
> "target/riscv: fix RV32 fixed counter accesses" which uses the
> debian-all-test-cross image -- where gcc-sparc64-linux-gnu is
> available)? Actually we could put them in tests/tcg/multiarch/
> as generic AES tests.

(Can be done later, on top, not a blocking comment).


