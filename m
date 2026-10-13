Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F744CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGkQT-0007Zk-G1; Tue, 13 Oct 2026 17:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkQS-0007ZT-8W
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:52:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGkQQ-00056e-BG
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 17:52:47 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DHQAJw1591709
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Go8FArEDa4dSG+WD3itBHBajnK16Zs9ORvp2682ZTjo=; b=ADwn16PvBbzMS1oe
 boOfKw9hr7V0hDGX/BTPBdFEcLO8bCDZubQEDc1DR98b1FxrtG2g7HbWk/ax8+ym
 FR+r54H1oehQ1CT6vtqgtKXr9LjGFFUhde35ZfSIY51WkKgoHpmiLuTXjSoHun+d
 5UlFDXwEO2MiE1SYNepB9BG+aCBuiKmiOBRBRRH9pUSFtWTo2do244jjHi259Pkx
 zzt/82VGKXdT5pOYQd2F+6H5RVZPud/OvsGtcD3shCSXhgCZ55bqyumU+OddqR7O
 BqbdSYjoaBu073RdIDab0mvvDY5cy9lt9mBj1UpmxA0G1CivvzvxiLU8nWB3zwjf
 39rCew==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s1th3gy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:52:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso7753650eec.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 14:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791928364; x=1792533164; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Go8FArEDa4dSG+WD3itBHBajnK16Zs9ORvp2682ZTjo=;
 b=Ks1u9KeTsWsdRttZJHhcjvRn+h85NyajHfgNk6HzJPxhn/qdbVSID1cbcr7MWrhzxZ
 7WNxY7UItskalgJA8IkwC2eeXD727Q8JM7Fxau23RnaZhD3wBvNDe8BgUlSE6bWhrB3z
 hlCazZIZTsTsurFzY2Z5SwmfoaNflBAhm7dWm31UWRqkZE3JDxo65q2mVH/0WSuqANkf
 vsqKbTPjhWeUF78+GJOZd7mx9OUK7AIgPu0q0bTJCXhTabvG0C4cI3lGYO4+yPlSTOwT
 57Q5Gry32e0/Af673VPDRMioIqEj09CwCvhlqrpHJkF1z6YQBbIlFCfVY/Oe1pZ8FjRa
 lssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791928364; x=1792533164;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Go8FArEDa4dSG+WD3itBHBajnK16Zs9ORvp2682ZTjo=;
 b=JmjZaHGjH1gCm820MDPQzE5JzIsVL8+o7bi9LiRcMUDn5slNJm8IxNRBMmcEuVUfBB
 7PBtmujavSqHK7sNYTJsKEU12EZy6vO3gKJwK7+mRxhV1Xyk1lJstj8AFFe/oOp8NfxW
 J3pJNFvO1SJOOobDJc2EkFIWPgxi+dL0pdA/VYOOmluiaunOZg0m7C5jmcvmULMc34Aj
 X0nTpfQx/jVPn9PVbBw2gIdxGGhIVjOrQqaSLXcHAQSE0hNpbqn0vxVRg6dQmy+8Qxbj
 JrQb3TbSt19MuVaf82ezhGqt+5r5Hg5vdCwPDWUY4IR9/uEE+b9Qwy7lD4oEM/AjE5Mu
 3XMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxw9a/yfQi48I9RlSVOHSqU1EKUECypNveKe3xbi8ciEQMmBs5W6Zl1A3UG+DYuADcnhOtHASAIsesU@nongnu.org
X-Gm-Message-State: AFq9FYLr2dgvasHsDmniiVzf7hgIW8+Bt/eS7po+U8F4Hq+DcNP60jRc
 +i1TWovS8fxNaASmGh4Y+zH7M+oVGRbkn+3fSvmD9/+6IfTkmbu3W+gqyxFgQmJpvaaOcUrWlQJ
 DP2IL2PKV3Vo+p4PSPO9F2dDmV64S3xOiNzleF9+C/Jb2rsWV7xhR54N9fg==
X-Gm-Gg: AYBFou3qOOqkb2g/e5GYFOe1mRWO8+6kBycBu2ZSV9W6b0cy7UzN/kez+6Fy1bvEAST
 G54Djq+wqbX7dToiyPQr/efMJG6bw7osULR44h4eGjktepXoPF802W/RW4fAUQvphyDDNHfwyMf
 kTp73N/yO7v7Uw62io64sZQsugQf4XZbBybgdJjYCmo7SqRKny9OIwP1zgcKNqtLpd/dO2+p+lt
 6muTsnqpzJaFTt4D5WXNq0UpfVOVS16Iyp365iUOFuJnfmsWZf0gP6/+om65rvX6mu4VuVLSd1u
 c8NyKOG4RxWuxZMnifakZYWDQBnBZ6iCgRxrxR+DCNhPHJB4ACqXHCWsGAFoAX+N1pSAl8RfeYC
 3LLbgcmRyrZRJDI2jCf1VBLsUs9g9aWrhu7zoRTOQ8xU1VdQW8RKDZCsohZF+4a3twHjDNg==
X-Received: by 2002:a05:7300:f408:b0:359:525f:74cb with SMTP id
 5a478bee46e88-359525f817dmr12089302eec.24.1791928364119; 
 Tue, 13 Oct 2026 14:52:44 -0700 (PDT)
X-Received: by 2002:a05:7300:f408:b0:359:525f:74cb with SMTP id
 5a478bee46e88-359525f817dmr12089271eec.24.1791928363537; 
 Tue, 13 Oct 2026 14:52:43 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb2fd33sm44795290eec.28.2026.10.13.14.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 14:52:42 -0700 (PDT)
Message-ID: <ad03ee64-daac-4d6f-af16-aa831f35b4e2@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:52:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/hexagon: halt on tlblock when the TLB lock is
 contended
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
 <20261009192541.4163758-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261009192541.4163758-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IpOL47/g c=1 sm=1 tr=0 ts=6acea82d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=oP1zb_y3CnxUQiUU1FkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4NyBTYWx0ZWRfXwT5mYCdQAHpg
 pe5J32KPteef1Sk/TU8X2dgygxWrnhWdLUpS+8cEyPl5XJ8nIfWKo11WcRcwuZncTKuVK3cXfZZ
 6UVRGfxMgdK9QTVmk5xF4rPNLTMQHBGGLi/Om/78Iwgc1vEcwWsu0ZjetLFQ15iqAQWtmfzJEOR
 mVjE7xm4n+ZC+FD6vF9cdGkK1I3bXOVcesMlTyCGPAPXQY5mp3n0v81RDDsafVqa+jiAYuE0BMj
 f3RV72Sawupd6t2dDBWwBgI0+dIwBu5Ipj069DVC9lIrP/MzbeYNbtHv4AlmKPQzplMJGvElj0D
 K5rgJH2rDIFlS/92RcqgG4Ro0ckw6J3fYRfChr7dwY/4vJrtXyOB5kRqtnt8yE7Su7yhCaZHFOp
 Y2yzFxjEOUvokIGV9FD94GtSAlIr7fE6lmClFgxkVB4es3ZGvJA/XxJuZ4qIkZOHdR3dDLruTUd
 /7TrFfm4ydoBx9oeaJQ==
X-Proofpoint-ORIG-GUID: qCPKxXIbvURcTVPGVlbPB7uZF2sDzLVd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4NyBTYWx0ZWRfX8lwsDDuSSVcz
 hLiiv5NaKT5HxMBqeBGfDPowg4AJ7IPRgnd7HQ0oqFhQxhyd6Bvkxcnen3mxoqAYkj3QiP4pcAz
 APjZ9Zc+ZmQ1K0m5aUASs+O3jIrZPD8=
X-Proofpoint-GUID: qCPKxXIbvURcTVPGVlbPB7uZF2sDzLVd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
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
> Set PC to the tlblock instruction and leave the CPU loop when the lock is
> contended. This retries tlblock after ownership is passed and prevents
> execution without the lock.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_mmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

