Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7721C88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6VQo-0005g6-He; Tue, 15 Sep 2026 11:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6VQm-0005fy-SD
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:50:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6VQj-000118-QK
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:50:47 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAqq7125500
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 15:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pLwXByT+zcOHqj85Ez5iyUeV9ZoHzQ5dtLWfcaFerKc=; b=glz+qa4dyxI8Yrq7
 icW3xMQWNzvYUlL9lNDQFjmaD4LK9pjUFONRyzqgOyGhRshlUihMewPVpFxkFQFo
 9PlQxXxAWTxCZkuziOMRCfA3+Dmvp7In2BWAQPYvqon+gogIui3zV0VGp3la3lD1
 6UvqWB9lAlVcD2O58EYLc/4k9jiX5mEOy9i7azYNufWWWY17pXj8S81Z+hsY+S4B
 Q1RkN7XHNQIXkP6lUBQ0ho6AzrBJzc9+pq5ysya+bKqfq8V0Rv9FDbWjnTo6rYX9
 cejZUfk1ehazMP1DqMt6ZT4W0YY0otS0SEykFVK1JbzZ3CfWpjs1RzL4Lh+M+ple
 P+7zaw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3xtswru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 15:50:43 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c82c2e9761so1276351e0c.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789487443; x=1790092243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pLwXByT+zcOHqj85Ez5iyUeV9ZoHzQ5dtLWfcaFerKc=;
 b=BJJXRVrg5uKcvghLW0vJEvQgPxcKpni/OxnkA33bdjEXpOIny+iDyNu8/SXUnbYnqa
 ZhVk5AKqNXE3qKefZY39dxXiJzC6j852Is5iyrLuqp4IZ3+nJVAfPz6CF3n+eeahpGJi
 7CmNHSBJet/5wp6rLAK1e4JkelegMhPKyc6Zaqsc3UJsJAOwR14dFeSKo4iTrQw2All2
 QLA208DMc/hoKVVo2XuraRxpLjBpUdWWokpqZ3+P84JnOc1JFVnUWkMFfviBZg0gWuM8
 m6aZyuT5ap39Hgw/cjrAUYb5ydUPUrNeB0ERJU5VB+C6oRSHExnNZ4Nu4HF5k19SZnk3
 3ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789487443; x=1790092243;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pLwXByT+zcOHqj85Ez5iyUeV9ZoHzQ5dtLWfcaFerKc=;
 b=H2JqodFZWIyoE9AExrHL9vd2bxK8JdK6CFm5iALN1qIdRtB/DSpVTdrxhDNxIIHXTX
 OMBWWqwDaIbcJAbjvsBYV0NTyD4J/5BTht+B77jkABL3Euu8I4rba9VyS91mV2UErzsN
 8i1bOXKW+KZ0SjODMk38DxVnoNOL5Zcw1Rp1kB9f31QHlZp5l667xm8Pj4lfYadvYDmH
 SAdwEOB4TLzA4aclBuRkMYIWA2G1/JkTf9PxEStTppM0DaKfLJqYfXa0Kr5GEe2pICmA
 9mBpJPFa2J7gZZRW6Gr6IsyhKcrFFtXFSmMfwy8wLC8MNJi88SXLLxH8oC7E+z+DO4Iq
 4lmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9N//cHoMqZ/Hz23bzBsWjGnZzMaY6eliOoHUNvxvkEMnwX2rNF9dQOENGNP+LI2fQjsLGNKCydLO7@nongnu.org
X-Gm-Message-State: AFuF++l7A9mBqsJztLix5y2Wj97jkdSh5N1rpI3+b4SYnkFYH09STwgv
 v3rsKdj/WOe/tipCDnRyLeOP2xcMnjHhOcXkvzKSHeW/048XMAi1UEufiFB98m2KtFo0b0zmacu
 lAXd6qIxtd8lld1nYSyEqgFVLaqMZyCJeqNKSNM966OY/3gussf38hrGz0Q==
X-Gm-Gg: AYBFou3f2g+AfickKij5tiDKgwu+eiKBcBAGvZLnXXR7HADGEoQgTWvleAeczyc+KK7
 E3i6TGGCqVMLjDPWJ101MPv0erlX5RdyC+skGrheNfYKerl/+L7b/zehxfe90lLjxSeJPKA/CoD
 DeRJNkKtzOxq0+YFabKL2BVFkQ5vluYkxxhtIZtmfemTdFY1ld77XAUasks/2icaKSfNjvAv6o3
 jWBlYI6h+mUlnubnO5rDq+V/4cIiLJdgRqPKcKA0+O+LGXT9wOqnNBxfbpNt/MwBolGp7bfbwe8
 IUeb+7RKBweYXsS3T6UfngNbDb+C0A9VU/U4fdUBtwHD61rJhz+M8CYSoOVCHQDndwrNDKI0wO7
 tdNonRvJ0YTp0cWC5mDOAWC+XAFMb7djFnX2QWhqWJ+iG94zQETi+nZ+TfXrlzD+H
X-Received: by 2002:a05:6122:4f82:b0:5c8:4bd6:fe with SMTP id
 71dfb90a1353d-5c982101a10mr10280223e0c.8.1789487442948; 
 Tue, 15 Sep 2026 08:50:42 -0700 (PDT)
X-Received: by 2002:a05:6122:4f82:b0:5c8:4bd6:fe with SMTP id
 71dfb90a1353d-5c982101a10mr10280106e0c.8.1789487442416; 
 Tue, 15 Sep 2026 08:50:42 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530f6823ba5sm82665811cf.28.2026.09.15.08.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 08:50:40 -0700 (PDT)
Message-ID: <f7bae12f-a76f-4388-bbdf-246bb8ddef4b@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 10:50:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Hexagon (target/hexagon) Check for multiwrites
 in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _JNOG9cZGFzPvZDTu8InL8PBFqdk6KjD
X-Proofpoint-GUID: _JNOG9cZGFzPvZDTu8InL8PBFqdk6KjD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzMSBTYWx0ZWRfX7geefxDlZ0Wu
 cI5xV9PwnLWduDY605tR+VDfGeMJ6Hgc/uSkj0dTQPseWr4Uke8+4NNmBXfrnPw6yO38yCPOzK0
 GwynVJEP33zdHDAj8aB0UuJgD/jGYcs=
X-Authority-Analysis: v=2.4 cv=As97T+9P c=1 sm=1 tr=0 ts=6aa96953 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ALIrzmpGmEqWAeGa1xwA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzMSBTYWx0ZWRfX/DnHrz0YBUmB
 ZAWkFUBQmDNeR26fzfPGx2FEJ2Dzz00NsRLpVvVSw5bd9MS0NmjE+tXJer6CzYB5aSIuJ05cprp
 EcFCTzNAe9FuH/wlvDPN7Sg9vqYemrCBBpy1qGZxieJZdulsj3qQ28yRw9D3y0QBO+4cI4tFMI9
 vIZ/2U41Zd4DS/FYmXPpbTtQ7NYhAY8fAwKWS4OvglNf0Kowe42dRWYFNKr51XJ+k/a9Xzpv376
 mnFbeo5x6zMxT+6IJ89GYJAPpFOzYzv/wWbUClesHKgCTBahtnQyagv/oZU3CVzZSvx4KtapbFL
 J9+By7sBxxzMp1jjSAdP0/FOh+bwBY7xD+hMsXG7b0sjJod+nZoH61scf+cGEVq3HK2yak6PRzb
 DbAxU/NaXbhV2Xg/FdyT3+zm7ZSOgkpT0BauhBTpo4q1Sf1FBDBf7RPFLeAApp04lsUTA6vuTX3
 waWDjGULbiLdHhlbZZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150231
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 9/14/2026 4:50 PM, Taylor Simpson wrote:
> Currently, we check for register multiwrites during packet decode. The
> downside of this approach is that it only checks a single destination
> register for each instruction.  During analyze_packet, we can check
> for more than one write per instruction.  Further, we can check for
> different types of registers.  This series adds checks for HVX
> v-registers and q-registers.
>
> Note that multiple writes to a predicate register are allowed on Hexagon.

This series is now queued for inclusion in an upcoming pull req - 
thanks, Taylor!


> Changes in v2
> - Rebase against latest sources, including Hexagon system mode
> - Add checks for multiple writes to system registers
>
> Changes in v3
> - Address feedback from Brian Cain <brian.cain@oss.qualcomm.com>
>      Fix check-functional failures
>      Typo in commit comment
> - Address feedback from Marco Liebel <marco.liebel@oss.qualcomm.com>
>      Add test for mixed predicated/unconditional writes to vreg
>
>
> Taylor Simpson (10):
>    Hexagon (target/hexagon) Move code out of gen_start_packet
>    Hexagon (target/hexagon) Check for GPR multiwrite in analyze_packet
>    Hexagon (tests/tcg/hexagon) Add tests for multi-destination
>      instructions
>    Hexagon (target/hexagon) Check for vreg multiwrite in analyze_packet
>    Hexagon (tests/tcg/hexagon) Add tests for vreg multiple writes
>    Hexagon (target/hexagon) Check for qreg multiwrite in analyze_packet
>    Hexagon (tests/tcg/hexagon) Add tests for qreg multiple writes
>    Hexagon (target/hexagon) Check for greg multiwrite in analyze_packet
>    Hexagon (target/hexagon) Check for sreg multiwrite in analyze_packet
>    Hexagon (target/hexagon) Remove old way of detecting register
>      multiwrites
>
>   target/hexagon/insn.h               |   4 -
>   target/hexagon/translate.h          |  47 +++++++--
>   target/hexagon/decode.c             |  54 ----------
>   target/hexagon/translate.c          |  90 +++++++++++++----
>   tests/tcg/hexagon/multiple-writes.c | 149 ++++++++++++++++++++++++++++
>   target/hexagon/gen_trans_funcs.py   |  10 --
>   tests/tcg/hexagon/meson.build       |   2 +-
>   7 files changed, 261 insertions(+), 95 deletions(-)
>

