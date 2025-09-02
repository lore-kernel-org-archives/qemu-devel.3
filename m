Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E37CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI3A-0000ec-E0; Mon, 01 Sep 2025 23:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI38-0000Xf-8w
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:51:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI35-00055m-Uc
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:51:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S58p025153
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YGzo6LVnLAX4oWosm/gVZAaC7s3Uegjaja9SIL/KXdE=; b=VR49quwvS1umJEQE
 dxpNj6UnbYug+ErtasSNZ4XbFe179nah+Qp02ZmzNN+OLhKvqlQ4AaV06hkWm7lQ
 t1x64Ct1C9DIXcHduLDmDxeLVlGabXeijLJ5XTlGNecUkRJcAU+77+uSY+QkZ6Xv
 TB8qN4m6z4YEP4oX84L9Kh+iY3Wj3jUt9bIHgHInAURzMgOeaXh8izu25g23SnhX
 sTmoYJoUn8SgYk+Q+m0L7UV8dgcO9qOr2P17MoQb+guJyCD5DSw2AeH62xyAZroK
 8s2pEp0IifCT3STz+b/PGBbsKtuRuV6Cjt9hnMD/AUYDWFcWnBdpOMHqh1gCL2T7
 1c9VLw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxefm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:51:00 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b4e9b55baceso940407a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785060; x=1757389860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YGzo6LVnLAX4oWosm/gVZAaC7s3Uegjaja9SIL/KXdE=;
 b=UzBcACGFsLauBnyo6I8aEvQsIFofBDhPoMeiSgDPUywHSQsPif3TXNp3qqBSjynZ71
 ebVJ24VvTHTKWaM4HHh2bytNFy25k3cQVEy7tkMF28CO18GYshIummnlF4AFQCvAUvUk
 vKxShXSWDYJQr3SFl1vgw92qguRKn3elIZyl+ueNTK2jYC/s52kvvr3psm+Xpo+7IFfR
 eWuOgeflg22TIxm4YcREmWhjcA3tAh+iekqaYfuCavexAzMob2cqLPUXt2Md5PnNKyBE
 lx/m+WKoYSf5RKTNf4JcaD5rzUCuDUBa9uqxomO6IPjRmM8qvdBJ1PHeCNC3xjE84wjv
 z6LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs7Vd3o8mof2H7+2B3PWg1zqwxE2YEcBFoYA/wzuZ9V5cdOl1s7Q2TfA/8ffnfwn6n4Bspb6hlPQN3@nongnu.org
X-Gm-Message-State: AOJu0Yyp3YpzynTQ9uAX02soeAgWF/T7UIvZqlzNv51CT98Sw70TRQOu
 V21nqhewg8gAcfzLzgBTS+Hs/+iXyzOx+UPdPWG8niTL3RJ5ILvpeLzWsBT1y7qlYBXlMjhGmQL
 zW2BHA5M6njxykVwX6kDMVmPhcf0yvMMaM8ty+9wF3sAjGdpJV5oHvLCRog==
X-Gm-Gg: ASbGncsMFu4lp1s4ktplkRztZUjy9Z7zSwnNvm8jcfFXbDToIH+SvcvHjuDhJ4y7EVu
 PIiu0opK7aobM/n9q3OtaMmj0K76uMoGDC48Y8/dpCI/v2Nc9VU/CQv7TWkjb7lt4idG9f+6YEo
 kzp0+QGQYKId9osN7tRw9ZqnKm2YT33Y9Cs48TwQ8JYu5P+T8sS0tPgEVIw+fYhhMhBTWST6VFJ
 C6FMAVbyuRBb+PUAPWs6ycw1klUjOjM2ycDCjC8uSd3WQyfPOmM1hzkN5XjI6KhHMxOgk7xz4QB
 onu0Z4gO3sKZMEAtP+iqqL/VkI8I0iZdQY7Joqb+KPsO6ecd1z2CTnGOjIjXCQ==
X-Received: by 2002:a05:6a21:33a7:b0:243:b965:1bb7 with SMTP id
 adf61e73a8af0-243d516a895mr14099935637.19.1756785059605; 
 Mon, 01 Sep 2025 20:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHnyGb+7EiYP1MeKviGr6Y8SIqqlMNvnZDK/kZ86SAcy0ALFU1/24n2QSBZHQsBSIhqxCDJg==
X-Received: by 2002:a05:6a21:33a7:b0:243:b965:1bb7 with SMTP id
 adf61e73a8af0-243d516a895mr14099908637.19.1756785059168; 
 Mon, 01 Sep 2025 20:50:59 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006c340sm10903626a12.1.2025.09.01.20.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:50:58 -0700 (PDT)
Message-ID: <a8a4b94a-7092-47e1-9373-1a6eae402b96@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:17:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/38] target/hexagon: Add System/Guest register
 definitions
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-4-brian.cain@oss.qualcomm.com>
 <079301dbaef8$91e8ff10$b5bafd30$@gmail.com>
 <d9b21bcf-cf13-4a4e-b942-2a61f71bbdad@oss.qualcomm.com>
 <07a901dbaf1b$3160b200$94221600$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <07a901dbaf1b$3160b200$94221600$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXxAz0M01m86bE
 SrsDfOoz7JW/6rlBZ1fC0ZYgyHdWKLB7ZmRRiC5T16DUPDVNGfiHQO47ukIjCuBzJPxD7g0eIsU
 WfbFnkunodeHaBNgC1v3+GKgjTmox7eBGGuqTt1Yk+xBjY1MfcVsXTB1kH7AZ00Relcj/l5d0tQ
 9yFQLxAJyInGIzZP+np8ocalaPcdvw8Z10ZStbLgSB76VKXLBrlODw0TvWllqsQaTWsydEYwEs2
 rqB3vwCGh3Yk28UskRbO7JSl7/D+F44awiRjzaLJdAWmayFEWExqiRggWpEiQs58REKVzAWzkaH
 TZyuth7Xf91nx5FDcVAgzvb4hTHTIegF8j+2EzarTUateGW3DWaBolbZTXsncQPmUC7WM+6tWda
 WbPbGDFF
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b669a4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=HIagiNpmguaMnP7ZulYA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: KSf-eciV0BcHo6qucxWVBNMPB3cWSieG
X-Proofpoint-GUID: KSf-eciV0BcHo6qucxWVBNMPB3cWSieG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 4/16/2025 5:02 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Wednesday, April 16, 2025 1:43 PM
>> To: ltaylorsimpson@gmail.com; qemu-devel@nongnu.org
>> Cc: richard.henderson@linaro.org; philmd@linaro.org;
>> quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; alex.bennee@linaro.org;
>> quic_mburton@quicinc.com; sidneym@quicinc.com; 'Brian Cain'
>> <bcain@quicinc.com>
>> Subject: Re: [PATCH 03/38] target/hexagon: Add System/Guest register
>> definitions
>>
>>
>> On 4/16/2025 12:54 PM, ltaylorsimpson@gmail.com wrote:
>>>> -----Original Message-----
>>>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> Sent: Friday, February 28, 2025 10:26 PM
>>>> To: qemu-devel@nongnu.org
>>>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>>>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng;
>>>> anjo@rev.ng; quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>>>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>>>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>>>> Subject: [PATCH 03/38] target/hexagon: Add System/Guest register
>>>> definitions
>>>>
>>>> From: Brian Cain <bcain@quicinc.com>
>>>>
>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> ---
>>>>    target/hexagon/gen_analyze_funcs.py |  21 +++-
>>>>    target/hexagon/hex_common.py        | 163
>>>> ++++++++++++++++++++++++++++
>>>>    2 files changed, 181 insertions(+), 3 deletions(-) diff --git
>>>> a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
>> index
>>>> 758e5fd12d..db50defeb6 100755
>>>> --- a/target/hexagon/hex_common.py
>>>> +++ b/target/hexagon/hex_common.py
>>>> @@ -33,6 +33,41 @@
>>>>    overrides = {}  # tags with helper overrides  idef_parser_enabled =
>>>> {}  # tags enabled for idef-parser
>>>>
>>>> +
>>>> +def is_sysemu_tag(tag):
>>>> +    return "A_PRIV" in attribdict[tag] or "A_GUEST" in
>>>> +attribdict[tag]
>>>> +
>>>> +
>>>> +def tag_ignore(tag):
>>>> +    tag_skips = (
>>>> +        "Y6_diag",
>>>> +        "Y6_diag0",
>>>> +        "Y6_diag1",
>>>> +    )
>>>> +    attr_skips = (
>>>> +        "A_FAKEINSN",
>>>> +        "A_MAPPING",
>>> Add A_CONDMAPPING to this list.
>>
>> Will do.
> Great.  Also, make sure tag_ignore is used by all the generator scripts.  Then, these won't show up any of the generated files (e.g., opcodes_def_generated.h.inc).


The above should be addressed in the v2 patch series (arriving at the 
list Real Soon Now).




