Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9D5CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCNsf-0001yH-Vy; Thu, 01 Oct 2026 16:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCNsd-0001xy-F4
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 16:59:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCNsb-0003qK-Sf
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 16:59:51 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsVBX2475306
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 20:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QvuPOEd0lNjbTP/toqJqS+HEy/fZmGFfWxg9oBEN51M=; b=IK06Sg42umxhPgrO
 DgU8mZaS1SmrMg6k1BAV2ZuMNbzaKYDyJ6SJ+5GAdOTwapxbpvNAbmIpX7MD5Y9S
 nlzt1OWblZ1uThIG3d6daLpP8BSGWL5RQ07XvdbUuA8wXg1Oee115Jb4rDDC70LU
 KJMR3sO84UlruLP+tEa/7FznZSkTsDPaKWatHgx5NgWyDOlCPg/q3b1tKEMBnSIK
 QbN87y7eY3iD6WB4/BOavIs/mvwqCKmh/tJko4Aa+x+8q1OUDjqpQoQ8H7YbwrSd
 KGKgAAmbkWqZ35ZWWbrxh0cWFMkLz8L2fukd3Bb4zQJUEHJ5DimoSlMnatnQRJDs
 WXdbZA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1tbg9b2u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 20:59:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34d80ca2184so2320841eec.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790888387; x=1791493187; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QvuPOEd0lNjbTP/toqJqS+HEy/fZmGFfWxg9oBEN51M=;
 b=i4Vc4KpBQfZpqeBGssjGq/uhWbim+XRsUVJMQa0xkoa22W7IUkQ2vbBnX/lugnBcMB
 4upUyU5dLbt24Au/YHBT3pxtLuR4y+PHu0B3d+ZokiUKRXKbvQU6a6AF4kbpbrYqPCeH
 gklGQOpNNg3frkVQ/gsCdMIK8X4P/3FccYxSNV2s+eTfUAHkIgrALWlG7IpqT/B5DeTE
 BbuyBsYzve+gP8ZIMVl3LsDnIjr0iXyuiXt6HZIuQQMZgelhsQGCp3VLxfuPPz4D9QGT
 6fwD9YWBUu9iTItqSh+QZBOn23ZlobI6oHfgB3JZ66VercXSaAffAydyG7ZM9nVmZObk
 pXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790888387; x=1791493187;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QvuPOEd0lNjbTP/toqJqS+HEy/fZmGFfWxg9oBEN51M=;
 b=CiSp0Q1FTz44pCXb6bl0j4HBLjs8HvQaBMtk/FdIJmmYw/dmp3V1riD9kCrkA7WYwT
 K5SeRyVG2sfU9rgLf/VXbryzIO37jL+jLh3Fk0x+RuBO+U6U/rEl4nG2raaToUtGPWDp
 uVhOyirbTO0wSPkXLw4dbT5q3lUQYuqxHZIlu6fToOUBFh+yr3xz74kaQZP2qiBVZIk1
 343mMpKR1r2Rh5410MvExCE74AazYbrx82CRsxGShzpwET6cyrX+WNAZUcZ6lAybK22k
 hxnpBu2GUAnl+0xS+mSXADyS77Ryl1+ERRyeLIxWJw7QPPA4PNRdYiaKccPZQPdL378l
 ksxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzk4mI7YPH2mKFM7YfD7R2Omo4hg5ptsfsAxFHC+mePeSMAZvSmCMVuzisUV50P1tZqkBUed+B8Ht0d@nongnu.org
X-Gm-Message-State: AFq9FYLyb0d5dd5VR7ZBvLqm0IUmZjaXPyyUbB2h22hwK8qbqmyFZrME
 e2N6CO6sgJ89v7alWaET86iNShfybs3ScKcGB8ThdqGuGAno9MJJoCeyTSX14iXue33XMMgb0Ej
 rs2CdqWUTPOSwX0wjeAl2wXvfLUSqeXRArKzD0lnxqbjeM5zRBKunf/VIJPgq00OZpA==
X-Gm-Gg: AYBFou21Xaw853XCU7ekTfh51QJf8cJNj5+dM9dlN6a/QqIfCq9Z3a0JL+eI1Npd1GH
 cI0e2F76rs/gIj+L4INW3bUxqfiqWhjZ9BJhZjT3M3fJq5WSY0WPluZr2gPxkPnFhJu90XAmOyT
 DpdskbL3EsDIUV/gDSYeING1ya5HcU9VqkZWpzqF+2BgSPym6+2N/yJtICEKYXrOLoWNuHJA6pA
 iUjpaY+iYt6fpSwQk8lmHudEd6gJh9J2IdQDA7QRhhWNHSIh3p6Tq+7M5MwHquQHZwpaZG40nbg
 U00iDF1dCz7ilOjm0UwLua1kD28Y84fbmBXh7WbtL2lgmGFU8n88FpSUe/MgsVBaAhSnd551zNC
 P6d1FdQXE5k3PD8ppAHi4PUzq8G51JQRO0LSEwe1nWh9wGgCO4gHRLuXEO63BRX4JpMF9zw==
X-Received: by 2002:a05:693c:8847:b0:34c:fedf:ec64 with SMTP id
 5a478bee46e88-34f2195f055mr386639eec.30.1790888386983; 
 Thu, 01 Oct 2026 13:59:46 -0700 (PDT)
X-Received: by 2002:a05:693c:8847:b0:34c:fedf:ec64 with SMTP id
 5a478bee46e88-34f2195f055mr386628eec.30.1790888386396; 
 Thu, 01 Oct 2026 13:59:46 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f98527sm726726eec.16.2026.10.01.13.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 13:59:45 -0700 (PDT)
Message-ID: <ed41d3cc-13dc-4d09-b0ec-57086f3ad007@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 13:59:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hexagon: gdbstub - Add sys reg support
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260930175108.3592113-1-brian.cain@oss.qualcomm.com>
 <20260930175108.3592113-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930175108.3592113-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4MyBTYWx0ZWRfXylGmqyvwQzFV
 tLDjZrk+v11JcIFyZazxMDfvbMtiFq+V0zOba5//YRu20QVEZy5zAsX7++9rIow2P9S6LjZQvMg
 PwuMklU00zAWVNpJfHG3my48rcFPoUQ=
X-Authority-Analysis: v=2.4 cv=QY7zLcbv c=1 sm=1 tr=0 ts=6abec9c3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=AwvoheL997GKtYW27tMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4MyBTYWx0ZWRfX+sW6moDLUnvg
 HKpCMCAQIEkYGAaz5Rn7OrLVcCr9g2uoLheRzOB3U3lqYWhsA39V2pRFySFveVd9454MD/QJEVx
 77cxCDpkIGTLR/VNIW7IV2rrVIoonY+PX5F25Juo3fvyxI+YvQJIFMCrAjPXcXIAV8BH6+/mIa/
 IzNy9ncZEVWF4PgfiQjj/WdixHo2x+hIID7YYE/hlAjSse0JoTohPpPbNx1ZzQUIqHaXJjfYmL8
 PRCQhsB0+2p8YgUuvE7v8uJscyaG5eCSw73gh9dPjgipsWnMKUGgU9QjNucm7Z7hiMsqADWZSgy
 zJOZFb/o5vVpSViKEKT5HjBeM/LE7pcYG+NWkxa/0t5Lx35TWmAIfVJf02Y6G1PphdHRolWkyO5
 aaR/U7enTz5Ef8q/g+C+xrvBzQxnz9jBuysz7uK0cycoKnjUXg2gVzyRQjMkEA2GklSCzX70l7Q
 Bcmmicv1EVURALO9qiQ==
X-Proofpoint-ORIG-GUID: wbou4tXxdnuMLRNNwaXWL_PfUb3Inc8T
X-Proofpoint-GUID: wbou4tXxdnuMLRNNwaXWL_PfUb3Inc8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010083
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

On 9/30/2026 10:51 AM, Brian Cain wrote:
> Add support for the system and guest registers to the gdbstub.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h      |  1 +
>  target/hexagon/internal.h |  4 +++
>  target/hexagon/cpu.c      | 14 ++++++++
>  target/hexagon/gdbstub.c  | 68 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 87 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

