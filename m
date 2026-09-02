Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFB6C624D6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ndh-0007Aj-Od; Wed, 02 Sep 2026 12:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1ndg-0007AB-3j
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:16:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1nde-0003ef-HQ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:16:39 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682FZYw8770198
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 16:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XjhvrtBdCaHuOUg/HgQRraDJ0Vi/2vEkNBjCh7u+hVY=; b=eylf9BcJERIXDCy/
 Q2U8UD0aRsL0fyBCF7Cniu3wbSz9J+vAkdPuv/9djlBAxNKiWBp4kBsLtVgIa2j8
 AXtoEFGEyNSM44eZMlWg5aZt/UHm+z7uOwBvDACKq4MlFlsMW+TReutVsa0A39S8
 rlIoPFS6XLYmXhvzag8OCF4Wld+X1HoE2/TAoi+EKzBoC77jF/pxZfz3jO+aD4hn
 nynZOCidMkDcAwi8PTnIR2bj897M36+rBv8dBOCOdfdv6cWzwF3gZskn+vm0UrNa
 6ZCGY525Fw6y/PUdGu6RAWYhQYbCrkpXQpHEBBJk2zFNDxb6ilgiO/g5c4YxVLuf
 OYirkw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemja0pkb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 16:16:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1cade6b71so42466a12.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788365795; x=1788970595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XjhvrtBdCaHuOUg/HgQRraDJ0Vi/2vEkNBjCh7u+hVY=;
 b=JK0DWYoypIp5Yfqi0UGpNDCMSDqOQK2Fd43tWmIAdT6lMDTqWVkdAHyIF6PzxIps7O
 RVAZvoKgFprEVOpWgveDo37iwTQ+VtQ18LAwW60Y3i6NJ3uDqFArWlYn1vbI5n8fh5X7
 2nqstzZcCGC7BhzdgPIqYff66dVXlMH3AHjOtYQrOr+3RwIZ+LLrYT/D1mu1BO0kOuod
 hFBeQ1hq4sg6LuyT0zRzvcKTt/IRfuAf7ziKVyE6WxxD8ST8tlQBx4xukVR0iaOITqTa
 LXYYhUO827CJ0VManMfpPwCwa27+YeJYu0o+7pxMJ7znHNsGVEui/6saM9S1pb7RRX/Z
 hkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788365795; x=1788970595;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XjhvrtBdCaHuOUg/HgQRraDJ0Vi/2vEkNBjCh7u+hVY=;
 b=aytdnep932Hd9C6PKvXO8pD9JYSDvQQNIbOikpGd/cd1cEYI4Shg/jMz04IGvLQt+k
 tyYAS0AsuBdZ69cKWrkr33GMZ9BSKJ+KU0kxq9x2wSxV1dsZ2mvQ6hhWgZ52NhZiAZEa
 Z1nSvlKHlHyQLumnqYzEbm/1LNY0u6JmIuS865R+Bm18XYMXRPgLyYOOp7sx/BxuvyGL
 0mEMbPA+cK9H2r6cr6sG0CcqqQJIZoZIc6aj3w0B4kdzR21Z69Y8iJVGov4bjRiDqMtm
 KWenhx9610uUir+twlIJvn3zwkOqozSSfCJ0/rWu/lZ6iysiEET6tc11k/FTAfBzVidP
 h9BA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2NX6Gkz0URwtjc26mfQW7oBck5tKcFUQHRuzrGfbRukTzI5tbqTR2vxis8ZKp3z4oAIP0zoDLvJE+@nongnu.org
X-Gm-Message-State: AFuF++mMVdIHdQUCOv/GzA3u0/ZSJCMFUnK2xIIS+vvcF5ONM1TtZIC6
 sV4Mk1k5zIedkIjGTJEZVdKYo5Kxvb52sodo+rwYI6hW8Cr+bCJz0Ivrd3JCc5rGUgc/aeC32e+
 5zC2oHHwOlUNeHQ12v55x+LZgmNnOsOIcKJzqp+vkgrBPXhbm9zxxVPh97g==
X-Gm-Gg: AYBFou0upP/XCMx1r1TkkODWidni4JDjIKJVX5sPRXp8mZIkbfjg+jg2/aQByHt56Xi
 383sDiGpxq4HYCq7b6e51/saKVqHMhI0tpHlkliX7rOYlEELftJY1k+TyLij8lZG3DLEy8bjyuC
 OSaCZ3bbqTldWGQ8bz4qSpbWDkyMJPGnaJwh9paz+RJk1Gs222Imz96cRYDQ6WfdP8VKv9mx7dd
 jmj1fqVHATAGoQNBjH27kD8Ib34cxe+J7E30UaRXRLdJFSuGMOqIaKbBRRNHi/kWH9iWpYjW5Oe
 Rxvv8I07JLjjX0/b+0BCubhMGrbFRpvPyxers2h+XBV4qvtGjihLjTAL7oHRXYac/FRK0nG9Zxo
 8Rze/Z5K6tYbVF3dj4WHYTCuaDMnkmIt3scWBgZR4gespXrG3ZQUrSe4ewzPP2oLR1x1W
X-Received: by 2002:a17:90a:e7c9:b0:38e:9784:dd47 with SMTP id
 98e67ed59e1d1-39b07f2f51amr281014a91.1.1788365795183; 
 Wed, 02 Sep 2026 09:16:35 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c9:b0:38e:9784:dd47 with SMTP id
 98e67ed59e1d1-39b07f2f51amr280958a91.1.1788365794611; 
 Wed, 02 Sep 2026 09:16:34 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07b7a175sm8344492eec.17.2026.09.02.09.16.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 09:16:33 -0700 (PDT)
Message-ID: <c7da39ac-81a6-4af7-a12a-42f407c7916f@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 09:16:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update PhilMD's email address
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260902155211.32399-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260902155211.32399-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7Ig5mQ46w7rnMHQci9S24Wlo7sWkAMCp
X-Authority-Analysis: v=2.4 cv=FeAHAp+6 c=1 sm=1 tr=0 ts=6a984be4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=S56xvJB5AAAA:8 a=EUspDBNiAAAA:8 a=gEYG6VJPI3qldbtsZncA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX0mPlOgtvTm89
 PPakWvgF7EuBoYNxmDW6SX6Dm6sI0xWhFaRbnWiuWOLrwDBVLPgfjZrmz0sKbwdy6wKipVC5oGf
 nvfT1R1rWOr2dOXN8ZslM362QUMZ64k=
X-Proofpoint-ORIG-GUID: 7Ig5mQ46w7rnMHQci9S24Wlo7sWkAMCp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX+Sz0iUXZVz9G
 NKgn1VjVTmPyQx6WNDI6zq+33L7LQHeQOsR+HBvFKyuep65EA9bNZULkLk9RRid07DVMRMbtY2B
 ngl+ExqTqiUYwG+ILZ1RmJ90tWUIJ0D6qZI4YGEWLocek3DFo7zbDlVeuWSC7nr16AZbFyM5H22
 vzPoz+4hTNkE0yKTimKd2690/vdLp/3wg5pjnX6/0A3wJKgJfdtPTpC+LwK1ZRztR1CGxyrWcIL
 /YJSFSI3yBUqZ6uMf8s5bF1lrnpLcv/vllecqha12zvmlR+4FFBG724IK1jdc2DBHOX3//OwVYh
 0AJd3pDRsZLugw/e2EmKguHxMA8quOHqlxYug/3fl217LJRL50R1eqb9ftdagYc9fQ+7XIYq9Jc
 jN/txPrJuQ+QDwieLJcUyL0FsHeWvzHhN41AnHLm/NiaByojF/lW1eS2efkJSBLpeYtfITAj0bv
 QEJQMoFA9aXg25Ys9Lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020143
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

On 9/2/2026 8:52 AM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <philmd@mailo.com>
> 
> My personal email free service doesn't scale with qemu-devel@
> mailing list traffic, returning distinct STMP errors. Dispatch
> to work email instead. Update mailmap accordingly.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@mailo.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  MAINTAINERS | 58 ++++++++++++++++++++++++++---------------------------
>  .mailmap    |  9 +++++----
>  2 files changed, 34 insertions(+), 33 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

