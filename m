Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BFECC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGkQ3-0006zz-QW; Tue, 13 Oct 2026 17:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkQ1-0006z1-Vu
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:52:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkQ0-00056B-H7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:52:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DKQBDi1999291
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u8wrTdL08qi5gHMTQzuURLy+WerI5WDy+qCnvhhHUqE=; b=o5ZbsM2sa7NS+zv8
 S9bqaaf4211WzQforD7fdzb23L1ZdeG3vFyl8PXu/Zx/Yh1QYoBQgdZUwkkQBHs8
 suWRiNvcidY7Oqt85bNoADE4cBh0YoAFc3W9r+RLkfUP5tEMcG2SQ2Fx1P5iBcoS
 x2Dx3y3O6qUQlGuObxySSBZjrswfW5PEr/+MmFJGFSdoy74ZK8Xtgt0QiZXFmRzc
 lQspBObtPInha1CX6gVPdOjxvFXb9bVursp6lR592ErRyRns6uDJ3VUpx1H/51tD
 J/jwPrRb6Y9PmwMrAEUm1vKI6KeZPtj5aEALquFNwtRALSDMr+J5CSg/O1ntQzfv
 Fc8NeQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9f62c18f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:52:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso5827511eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 14:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791928338; x=1792533138; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u8wrTdL08qi5gHMTQzuURLy+WerI5WDy+qCnvhhHUqE=;
 b=N3jzRON++VAVZlbiry/5oTk+gXTYV0rT7LF+cIpnzDk98Q3xBnDltpBEY+ja877ZQ/
 akpv8AtlH1P4Hac0oF4609FolMArmzOk3ajKDag1e4uSa4mv4aN4wigcicybbryzMmOP
 008o4ZAwTSqoKrMA8i4+3Wk6gFo5XXv7owdU6na5em61rO5ncETn/f+ciu7dxjb06GN5
 5rApYwkW74XKzsQkSrSbyhOVPzcMIZi9OAthl+CIw2C9iQhNOJzazh2xb3eA7gy98NBf
 9sEx3PJfjpVImTHmzMmlFDxx1queM0y+1/Iob9fSzUNlTYMDqYS+iicf/1Nw+sTniNWX
 6QGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791928338; x=1792533138;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u8wrTdL08qi5gHMTQzuURLy+WerI5WDy+qCnvhhHUqE=;
 b=Ddb0f5j8DULga79xJsKITSq/DAkW0rTdrb0pKG3Nco+GP5mm/469DVqfUZpsVcXIm9
 IRP4pGxXi9aO0cLzQ/VbLNknu+ILH5Qh15WzCrW42DT7p21dAnGPYf6oTnRP6X7gIuNp
 q8sTwxaCOmpqL/o+QDp4Gb8TMAGoAGaW6bpaqDX+TIE7Dihjzz27fEb9yybpmJfjje8N
 mQgBJAw1oqEKBMhvl4A+gZZ9jb3m0NqGtHfX+RTZGeobU7ayn+cAT2qjf7aaixqN/p4z
 +IJtKA1ZutPGEaU+ayGk6tfp4epo44s3uxfAa55XJdUp4d2GVPxmAqA6JslA5ZTIpQ0Z
 UAGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGWdmpliZwu+hCtivqOU3mGUDiR4PL5iEzxjT2pviM/PlE0H1x0iLvS7X5sSYKw7oJ+rTM94P99Y1O@nongnu.org
X-Gm-Message-State: AFq9FYIb2/RoiIHbkeYGnPxNtx7r4NSvjjo5Cj9Web5t18uI2ll7zZHk
 zJFkBspmP1bATUG2T24WQxmySOrSt75+6IpOIcT6+EYZVpAXRJQYUP3+P4lKq/fC+Gw+BBD8QQn
 39PWjiqCjfhsHrsuYwuMxhi6gNYCDFGkn+VJZ+ztTpNukLKohXsu4oYyxqA==
X-Gm-Gg: AYBFou1a/bnzZca+2Ge9XvSNxbF1ouLfVMXTrX/4VrfJPnmrr0MnXkRBI2sYf3jeuNd
 24axc8E7I3erkAH20mrobCWz9v85Ohs98CETCviN0n0y+VKOlD6xySBnPfqBcK0ITbxLaKdZ9hY
 8I0iJw0xMKdTT3MawIgY75H3dXO6KQOFp4wmsUC8HaDwNhoW1BhuIx5dEKqLr0R1hXnNj3+kKmL
 YqoIYn/cA0Nflk1AKqYq1vJIQKQcx8wUVX+03IEnn8f1tteQdk/C9LB9LCtvqXNNMv9+hN4sUdI
 IGQ7oXKxg2Lo9xWx7dNPd3D/25Eu39QJZLCkEm7QPsi516WtPrNjCJeHEwMI8N/7Gy8WrkRe9Gs
 K5O0i6q+6Q1U+uvJOtKFaw227dtBlP6/JQXuMSI22Tq1YSlplxXXjDRA73O+qeXL2Oix/3Q==
X-Received: by 2002:a05:7300:fe46:b0:35d:b44:a52 with SMTP id
 5a478bee46e88-35d0b440cc5mr2376055eec.24.1791928337992; 
 Tue, 13 Oct 2026 14:52:17 -0700 (PDT)
X-Received: by 2002:a05:7300:fe46:b0:35d:b44:a52 with SMTP id
 5a478bee46e88-35d0b440cc5mr2376027eec.24.1791928337422; 
 Tue, 13 Oct 2026 14:52:17 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b19c6c7b4sm19881129eec.24.2026.10.13.14.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 14:52:16 -0700 (PDT)
Message-ID: <081ca069-cc7d-4bc9-87be-48d55c545e21@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:52:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/hexagon: fix stale PC on k0lock wait resume
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
 <20261009192541.4163758-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261009192541.4163758-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FOKOVOos c=1 sm=1 tr=0 ts=6acea813 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=RqYQaWtoJnHAv6lanLIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4NyBTYWx0ZWRfX0t+u2NX5JZhb
 IFhURO9MGRrleQwPp2EHhFfLyeiR9p2jdsgVcIq53R35CsKiN/aRuqDWrDSZHIUgVRiYaLmpGKG
 wreMy5NBfnB3PLUBR7DmVzyD2yK51tc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4NyBTYWx0ZWRfX7ewvtR0egrsJ
 AeFPl+8SluGwTRCFHClRUJ7izca/e7GN3KyytqjthtNPMxwfUXJ+BPIwB5FdcweCVdyYrgdH84Q
 EzCrqda7oplRF9APGdVL1anYr6USLBF7jLIrLUEfsPrxm1zLsq22W1Mu2X9R1mbUI0Pxp8JUpw5
 fXXhLk9DIkyihsCuPkX57rg18qbf2Baeqp54HriFmTzv29+ueD4Uv3VVWVG/VLet5/wE3SEl4F6
 7DkETbXstwqXBcRtZg955GgjgioJbJk7ts9l7uC47Wznkwar8kWlZjLxqQDj/MeHdJ2xt42GIMn
 neeCLwuIOgFGFNYpfjEbtjQp+CA+rLtLMjjMPBiB/in4BJRK0vpHAoblKtHI8wFiuwJzvs/KrIE
 6iP8IGK8+tcIYS2ZsM5l87G+RHimJVNAVB8mQsxWKwjPetBqn5zNEHnWKrNsD/75F2UkIi/cX3R
 PuwkTNu1gE1AuAJDetA==
X-Proofpoint-GUID: WLfOCEc40ARYZrg2tlbC0vkDMxJxa7jT
X-Proofpoint-ORIG-GUID: WLfOCEc40ARYZrg2tlbC0vkDMxJxa7jT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/9/2026 12:25 PM, Brian Cain wrote:
> Set PC to the k0lock instruction before halting a contended thread. A stale
> PC can skip the acquired lock or resume at unrelated guest code.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/op_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

