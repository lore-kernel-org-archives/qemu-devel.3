Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF52CC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjPDL-0007WB-KC; Mon, 13 Jul 2026 18:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjPDJ-0007Ux-PT
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:33:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjPDI-0002Pa-2P
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:33:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9XfR2389510
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0+Q3hEuX6J3+GgqW6FseDoKE8vErqp0huU/OBhqj3j0=; b=X/G/53KoEWV+wfyI
 td0QAoea7bwP9xDQ1WumHDEEBI2EhUzTw3qIrj5+ump+/PN1Mr0ODjuiuKAvfM8o
 udNfYN4w+0P0je+/Od95DmaO5MLRFCnkJHr3tErEWxt2Ia39LSQdKwmJ98QEwuni
 cR/SsR4aL3N7a4Or8zJ3NPeEx6m5BWN96XxOTIwzSCTW+1WpTpFwl0UAasVfn+hx
 Sgvd1hi+huB92pETeo5km80laFRr9uBijR6YTB4Ran3o+8UaDx3LioWoUMWsNsjA
 70owdw2wqMQMCn7er+X+qqz9wdXXeDHFRWgVloX+rU6vejLdMvGv2PrzbxOm7zof
 Bgyx4A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44j11au-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:33:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-37fca5f21b1so380078a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783982001; x=1784586801; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0+Q3hEuX6J3+GgqW6FseDoKE8vErqp0huU/OBhqj3j0=;
 b=O9dxBcQ7BJ9S6u8VF/96Q3E1xGPIstYBNP4eSWhfqI2siT3Mb3DBKJTt1z8sg3bXCc
 Ms2wZMaFk9zTMKistYGT7to9MBjs6Ui4efUJ24/ZkehdN9shdFNZVvFPEhF9zVeeaTDh
 JcbxblVzj0og8wWB8zvShnSIQZhJHp2c/PchSU8KFg8fFwrPlL9L+arULXenYLEOdFu7
 kCG9qls5KMmyNCWzRxpzK7ln3mqOkVBTDpKvA1TkjNwZskTYCwnvTqnSrGlVGyRIgHF/
 wA493iJGxeQa3TkbMDhZVl8clOyzmVKPBKZ5zrXDufILHYdJID9NPhtopFT6fqcrEgzn
 w5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783982001; x=1784586801;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0+Q3hEuX6J3+GgqW6FseDoKE8vErqp0huU/OBhqj3j0=;
 b=Prtl2wRwNhpqqKOAx/d2GMXYFBeCzL+pAaJKfsJm/ODBPFwyOD4TGehicjrOlV1Cb9
 geGw9fQ4RVGDMJK9iYZqNyhU8JmWnd30T8OSyYTWn0jzWNRy50jAPFisZL5aCt1BMxXr
 DoQ8X6kMJR747ADlb/0rIa/uI6W94YxbHoc047pDrSlirrfI/3w1Lra7JtwkxQeRuxZ4
 K1zwXtNvcZCNryFJKXdDSoDlxKfX3EnL3DGUccWaqgkOBkZ+WaQvmeBGUj30B1+iAOPx
 xKFIfUR5Z1pchwdezOhxH6BVXWM9ANEuQU605GD8ylLH5mFs5oHPvrQwd6ZTBnq5WJgL
 BPpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpiA/7xIXRYGf4ESIHBneUti8l/DHDcO1nvyFouEmgkcCTu0s6PY316CSdvrsdGtiPZk/FpFerqbzjG@nongnu.org
X-Gm-Message-State: AOJu0Ywc54kibChiwE9F/BqXnr5sbAu5b72fole363gWWDSrxagSEeoo
 BzH7XbEErvr+OV3Pq6G3+/loL7MFYKAsBBX1mG737ZenWkaFjCvC6P6p79GlGtAS75CzFLq/zHx
 e1mxrJR45konEOFzvs4WUUgcIWKp5WeaePewEaabn1c1uhxHd7PkDiQW6EOhs+sWTIg==
X-Gm-Gg: AfdE7clKA2lBi3ROnbBYB+sPqgJayAoAZMjOFLFb0BMaQaiZk1Cz7iCh2Gg1WO5o8/2
 +CxcShM6TIUXjRXBV95965CZL3ky0LCZOUu2ApfvQfqdnvvNJwa2pRsLR4Z8T1i82L2XYiOfGYT
 /5SeIQQKuFeizOwHTvQ0xrFwXvCwMDveqwXbXnnbyxHvQZUoazMTI5AZ//l+DRgZkALdglNJY8g
 xWXb5vFQNmWOmi1zlKslPyhOcN6VH17vdqBTfl7sgW+p/Xqk1xG31ecx51BvkIuTgKuiPpbqrJH
 zQ5xg/78Olv7i1hL01DwcuOoND/H0SPfnpYSBNabI9ydEazWEYur3TXiG1Ua7rPsLwpSWXtWjux
 Spzohmn8FN5E16cpmpGWonO8rgL6Vzl3LJATqTAioWtA/Pz0E03kkq6u0NjJRhGyWgGBoZCDmhU
 SmycE=
X-Received: by 2002:a17:90b:5607:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-38d13c60530mr15793225a91.5.1783982001523; 
 Mon, 13 Jul 2026 15:33:21 -0700 (PDT)
X-Received: by 2002:a17:90b:5607:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-38d13c60530mr15793210a91.5.1783982001119; 
 Mon, 13 Jul 2026 15:33:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm62565830eec.20.2026.07.13.15.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 15:33:20 -0700 (PDT)
Message-ID: <b9cb8831-aaed-4220-a389-f3a8259b81a6@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:33:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] target/hexagon: add OPEN/READ/CLOSE_DIR semihosting
 operations
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <db95d3b7af7b0f64102866ce046ad773a2b391b9.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <db95d3b7af7b0f64102866ce046ad773a2b391b9.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIzMSBTYWx0ZWRfX3+iPlcjXoH4Z
 SPz6qroyFYDdRIxv66hDP1kEhNfV0zJpdflYN6nZDdq0i2gc6Zm0o1/TkU/x5j1CYBmzKynDUcL
 mvxX70jcGogoJ1XOpBzg6m7B6QaBWYo=
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a5567b2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=j-2ieXHuSseVZ7EA7hQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6NFGXtVsf0_EVIHhC0-xHDyKrStL6UUy
X-Proofpoint-ORIG-GUID: 6NFGXtVsf0_EVIHhC0-xHDyKrStL6UUy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIzMSBTYWx0ZWRfX5atcgyUCg5gy
 itsdhaHMYZWgNjEkhar0uWZys6Bsd37RcSYs8ghs3PVAFZ8baBqKyBhVSTVFTkewosDKzi634Gb
 HSsB1IKykXO7+KvC9uj+UvfPZKP/h+jDw44XB0piFXHJJ5soCqgD5KJ2kxgCAvyik/2e+8WdUL1
 zHCisTD4lNNiiJ/BzE2lkdtcsRVGZEEVV16HyL2wJxV4PrQycZNNb789/w1oyKECmPJG0hiyAhj
 45t9cki04IfDkya491//x5KcokrCl2EGKVwXCRLjW1KNwswgZB6zIqvVGhrG6xAhZxWrpIoMvxr
 d+AIvhFQ3pJw/eG/NyrVK7PkiJk9/deCOiEHBfAKTjAa1rDqH+/iny0shEz0zrwjAEEX8izbPqb
 ZivVp4MQpZzpn6jfbKZWWxVH3ownagx7Ae+5cEs4b4QRarH55ekW3/dlZ5yQmB7kTuyqZAzc9RT
 0eOlHWDgVOTAhtQM62Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130231
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

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> 
> Baremetal Hexagon programs use semihosting to enumerate host
> directories via OPENDIR, READDIR, and CLOSEDIR calls.  Track
> open directory handles per-CPU in a GList so that guest
> index values map back to host DIR pointers across calls.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h     |  1 +
>  hw/hexagon/hexagon_dsp.c |  5 +++
>  hw/hexagon/virt.c        |  5 +++
>  target/hexagon/hexswi.c  | 79 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 90 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

