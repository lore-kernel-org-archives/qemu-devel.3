Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D74C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzB8D-000139-Bg; Wed, 26 Aug 2026 06:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzB8B-00012R-7g
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:45:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzB88-00087a-79
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:45:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QAHrHk3649646
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IUU33UVOgyMlJOGxZvH6gLbx6seBPGSUWs8RhHUxF7g=; b=aRxlZrAlDeidxRZS
 VMmLrDe34odmQWtHa+34i+QQklccnbIM/Rx9ldQIXsEvc5Ua8Pj38p9/DS/xWcSV
 B+2L7bVFs2wG5q2JqY/WVuv6TJJVdNHkD76axsTWnPLvFukBn3TgyG3s+VR+C7PW
 N+Gtm2JIcK1mBmVCoBDj9IoBqqt8Cw+1F0HuaCtVEgQLTNNhR0e4JptBTmcEiPWc
 KbZAiDhtb3eNT0tdVu0KkkHCvGohidrmev5q3Yob80I69P8JFmejtUQmhvtW/kyJ
 lQdGDboL6YEFnxsgXXEAFfVo3IFi+wYOQ9pu7IVl+0vZ1d7Of/S/0Gms4zSHQ0hq
 d+DgHA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uthrr8c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:45:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52ce64c41efso13742121cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 03:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787741114; x=1788345914; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IUU33UVOgyMlJOGxZvH6gLbx6seBPGSUWs8RhHUxF7g=;
 b=OP6ZhYU4Q4MhR5LKSRf/ay7hZ+jE0hQtPgVha8K/r7Ndlcm7vCYTN+5G+b/Hcmyx1B
 sPUF3ZeLtuwWJ75I5fGn4/NRU1dfLVyaVqZ4Hlwkwk0Wfo+/CLtBr01mY7V7YNKzh99A
 wKgUhk0bDBkyqDg1u3pW+pG0E3tvo7IHr4pdvXRsjT3DOaS2ML8ofBsAig305uEk7lNf
 JwBT9B9Exc9YVWCBf2vpYDoqXFqKEm0lkppq3uK02gguc4Bu6rLZX8A5IOGChPR7TULK
 picmDAh+VSIStElvmXkPVi9fgEvaDfwa+PdrMpAFX+fSOtwWZFXL61miH3uQgXZ6orTf
 5sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787741114; x=1788345914;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IUU33UVOgyMlJOGxZvH6gLbx6seBPGSUWs8RhHUxF7g=;
 b=mFtY/0wrGSOAfeLPKNFJzzCSOOxpbErXsbwMe5/Z92vWfNEu6GzmSErJhFzuCLEW7I
 ZXw2tmYIXKHcejK1TWNvu/JGyK26G7WEgzn2Z3nBdhzoKi+Z7PG75njXRQo5vvVmePOL
 M5QrIm+aytuLpVm4o1AHzGRofehdXjz91Ip7bWcxnlb3uNRSjtpybwojbTuoIFr4A7Xq
 4BZKmNJU1hqiCJuMKxtuXlQBjz44uaDsjPhBvaNb7Olh6q+FJhSubMPi13fO8u9AKpNm
 XGRdObKRcBQ5a95QBIHAdW1Bd25eROw6muuV8BhTS0Lb5TWW9sZnGQE2guP7mXqMAszh
 dqvA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpuo7beRQGwKuWl8kROV7UBseSTr3emNgv/V+Du/sim7C/MA2tuVzy/bqi/sTVVDOCaR+9rS7CtUZC4@nongnu.org
X-Gm-Message-State: AFuF++kVqLQfpq3nsbXn3LXkrCDBz689IzVXyb3MJ0eBAl0zUMAUFzvc
 uBZEKVOBB6oDDmjlMsL29GFRvkyjkFogMQW8WXPG/lzKc6rNlB++Pkb2fuAU78Dhel/NIGFW+9f
 B+R0qyDlnLUhjZN79LtfP9yZFZj//Ei5Ge5p/67khWhCK65WuHjTOrS1yAaMfJ23cmQ==
X-Gm-Gg: AR+sD10WEMkNZpvxHPWajlhxeLbwKwGJMOjJgiwq5C9UjDZNB9xvRibx4Yjz60pXe5I
 sQa7hoAIIJ6/A/cRpmU4dZWPcbzpkptyQJnxmeUDOE5kXGcv3cI9PsiNl+LpVE3VFDycpn4z1Wt
 36gQVutY6zz9nJLqiWu0d5sjp5/4N9f6u4LLPAA5zN1gkakC9kuM5fhor68lMq1+m0gTJ7LFLod
 4ZzQtDwbRsF4e6lbxAD/LJpYlO29qB2aVWaB663pCDnFNgX5vyrSsX7xkdVvh5Fgx0VY8VPo6iv
 b4kG6WQTafeFuxByhV0q7x9h4gaBW+AiBruwwMXv56irONvi4k5CFJsyfxP2iPdxeuvuK9SOCGp
 ZmAWXkexITtmq0ItvcgxKoO9P59R1nvj4ucuKic3Dduqzvsk=
X-Received: by 2002:a05:622a:550e:b0:52d:918b:92e1 with SMTP id
 d75a77b69052e-52e4222dd83mr63469181cf.5.1787741113827; 
 Wed, 26 Aug 2026 03:45:13 -0700 (PDT)
X-Received: by 2002:a05:622a:550e:b0:52d:918b:92e1 with SMTP id
 d75a77b69052e-52e4222dd83mr63468421cf.5.1787741113426; 
 Wed, 26 Aug 2026 03:45:13 -0700 (PDT)
Received: from [10.254.188.74] (31.18.205.77.rev.sfr.net. [77.205.18.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dc960f24sm23812535e9.3.2026.08.26.03.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 03:45:12 -0700 (PDT)
Message-ID: <127cbc97-6d47-4b2a-8697-47c015ad3264@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 12:45:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] scsi-disk: refresh the cached capacity from the
 resize callback
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20260812121500.1034178-1-den@openvz.org>
 <20260812121500.1034178-3-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812121500.1034178-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8ec3ba cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=3lFKFk2zyOZBiYL4tutsoA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=6rqHouBjAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-ORIG-GUID: XbWLsgQoEFBRopR2vGvfYxPMlYEMkFox
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4OSBTYWx0ZWRfX1anMrDZuIoRh
 wnWu71GFywrUlG8mS590HZ6MpclrSQg/8OFu6/cvUEfHXrLjckdnuHOJSIAyZgSsTlnJ0zPXGt9
 ucTkQsM7tso8WLcO5V/JSffcY7LLwZBTDezpTGkncZ6Kz9Rha24B6VVRaGpeQOjxYowddpnY3G8
 RwFwknBPX/2U4x9DiptE85z/Ut4zahMvkdSvcLlB/jsqCM3JLczf7kRbXO8wHZ7ea8MC3fbp3c3
 FNaSu2G1Sx00870LAjMAsMjD8feXTytlQUdimnUtdYsnDPqJwX+gNutxtECMcUaVN3rBgI1Bzit
 6B+vFgp1Z/79XqTr+mUcgnqlTh9GTmcokHrPCXJBhoZLg+D0tGAFUqMr0ondJPTzyEjGFTK3hQk
 Zt+ZcVyHNw2rpDljiIQA0mgA0SC9rKQFjLxiDm4M/OKpUyHEyVI3lgqH356DxZrMEnUeENfasFP
 e7Zi/mE1nCaZ+u6zZOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4OSBTYWx0ZWRfX/6I/aRVb1pZr
 bANziem5LfiJTI8B2OwROt1kfxfA6ZXkguWlJPCP/mWaVRLMyU4Q0lAaS4HeJ7fpFdLdjgePXz6
 7wWi+nb9oLD7dvapqfgoWA0HzrniI2o=
X-Proofpoint-GUID: XbWLsgQoEFBRopR2vGvfYxPMlYEMkFox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260089
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/8/26 14:14, Denis V. Lunev wrote:
> scsi_disk_resize_cb() reports CAPACITY DATA HAS CHANGED but leaves
> SCSIDevice.max_lba alone, and max_lba is what check_lba_range() compares
> every request against. Until the guest reacts to the unit attention and
> issues READ CAPACITY, requests beyond the old size keep being refused with
> LOGICAL BLOCK ADDRESS OUT OF RANGE, and a guest which never re-reads the
> capacity never recovers at all. A guest migrated onto a device whose size
> changed underneath it is exactly such a guest.
> 
> ide_resize_cb() refreshes its cached size along with the IDENTIFY data it
> reports to the guest. Do the same here, so that the notification is what
> tells the guest about the new capacity rather than what unblocks the
> device.
> 
> Factor the computation out of scsi_disk_reset(), which already had it.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   hw/scsi/scsi-disk.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

