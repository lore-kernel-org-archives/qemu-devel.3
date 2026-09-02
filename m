Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B15C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ng7-0000Nr-Ft; Wed, 02 Sep 2026 12:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1ng6-0000NJ-2N
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:19:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1ng4-0004PL-4S
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:19:09 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682FcwPc1807240
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 16:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tCLBl4nUbNsvzwa6S3t/iWdd7cO/xjh7GWJEwtAyHfw=; b=hvC65Hyswm4oFmt7
 Saefxkzz7nqo0exRHg+rwdIrC/d+fSsdAG4IxZW3/UmaNYaT7pubgMMQKCOSVNLh
 +mxe5d9kpXG462qcb8V/ZB9mt7uY59EIYBdfCzLCKgK/ZvK7BpRmpbXULavVeaRn
 AoX48IB4u7ON4IYvsBeoVZxkkDyUsxtw+8dBe893ad1N3q72dgksThlaRtA/VqF+
 9sZHAXkTsjdRUbHDeCx8YbyNt2YbVKeKXlYVHbcSvhXfxxpkWbgDy7jJ3kaP6LgF
 t3kLFgpQT6+tG6/665xLUvzPDcCcBcH9aZGgFuBetZPuSoCOaWlj8p8Fu6Fmabfm
 NMnoww==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdrc8g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 16:19:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so59163085a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 09:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788365946; x=1788970746; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tCLBl4nUbNsvzwa6S3t/iWdd7cO/xjh7GWJEwtAyHfw=;
 b=bPWiq/7DJLGtFMhRIgyaWyKzko1pPn6Yww77fcLmHiaxHkowl35hCRs3mHHuBd+6z3
 qzRNB1W+JL4peIgeQiQStqZy9/v+v4A4T7aTZw7+NgHHMIx133PWqeKBpq9jLi5IzDIg
 BE24n3s6uVL3NmU9d/X9DTogDOxB9PnYTeG2Z8TwN3Xbf6swrkFa1m8mAUhRPeLIKKPU
 xNjwnLdhu9SrwwZRy57WdHKaQhSV6Mm5VmzAEnzX4MORmgiFUC8um/0PgotZgRC7zG8n
 Y+fGYjrRoYkL4KJEfNu3t597fiSrIc0Ps+32nFtadViNe5HGDy9UN48OiC3mdy8mOKU0
 ms7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788365946; x=1788970746;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tCLBl4nUbNsvzwa6S3t/iWdd7cO/xjh7GWJEwtAyHfw=;
 b=Rs8JM1kjFax3ItSmqoTtkLc3xlHz/+iH2zeXQrIzyi1sYxoRO3VKihQjKE8NiS/CzX
 1ReOb1cvVdVixhPFxNWU0oIlHHrgPVXnGZpdHqFF4fwXPsJPWi/a6A0aMYEBb6e8Bo+l
 CX8PInAE2PVHHDkfgXDJMf/ZO5+i3ZYmaX0B35AmcSB0NHOv4tBTAnwGqGtLKh6xYZVa
 Pt55BfOZGkdJlNwLvrsjXOsc4cAPW2TkPBtf5UpgR+GKPntZJkU9s58XASmAjsU6Sm6a
 8+VRF7pStlg2FvdCZ98m4A3PB6Lkbe5OitpdF+/xjiL5kLgERurEhx/U7n2qyHs9VubF
 ElTg==
X-Gm-Message-State: AFuF++kVpTa/Rk6TSBJ2Ru/Ft2TQWMl7qkyJKIzw11njEVPtSTPvWqyr
 ehnnPJw9AAn7yN1LKPWOkor4S7BllqQaIIzm46sr7SrIh0xEvkkyjpRASzVSNRJa5yNIvW8tNm0
 pDEQL+Ulj6AFNRfun1tB/ThChLnjDX+4FEGEdy7+NLaIsDwwaDvDCNbiq/xrvY/Yxqw==
X-Gm-Gg: AR+sD12hNBqJ3wsUdSIpSnoxfXhTQaeN/aRjLrF/QmgPsNPh4VfpHMHFQMDISFmicTw
 yg34q44QeIc6+lmosSvLEbbamc+AfudRZ2Z7pbsQjE52CMEknrodS2wZjIy8I/O2MIeiLohOzLF
 p/yb5UApFKQFfqKKuVBwOP++PdO9XFwt3ELF8/t+GYZAQqpLy5VgMLrhsELoFEiocbXFvOaH7YK
 9243iXEcibeFqJ4Q/WeQfjJmgZ96RD+PXtdCWsS8+GBDcQfjZ8LarPeWi3L7fSIFOj0whlrosg4
 2fb6Mksdmu4loNsEU2jPGyYqwKMjwbRRCzy/f7G7JuZLK5CAqtwSp6Vd4I3pe2CfzVa1OuqQlEQ
 G+06WDn64Yt8MThwHu0JyOGv6cfFcpndgtQ==
X-Received: by 2002:a05:620a:6498:b0:939:4a47:932b with SMTP id
 af79cd13be357-9396e10d8b6mr37497185a.36.1788365946068; 
 Wed, 02 Sep 2026 09:19:06 -0700 (PDT)
X-Received: by 2002:a05:620a:6498:b0:939:4a47:932b with SMTP id
 af79cd13be357-9396e10d8b6mr37489885a.36.1788365945628; 
 Wed, 02 Sep 2026 09:19:05 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5e686fsm2733175e9.15.2026.09.02.09.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 09:19:04 -0700 (PDT)
Message-ID: <e4b97424-bf34-4bb2-94e9-835d098b55ad@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 18:19:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Cover pflash QTest in pflash section
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Thomas Huth <thuth@redhat.com>
References: <20260820142212.27537-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260820142212.27537-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a984c7a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=e-VbxEty0J_jwR9jtaIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: R2jtE3cimKFRsg-ojYy8WZmdtn67JQeo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX27zV4xBSNjnc
 x8FYiOZBM9f9rT06K819msWP6F7GpaGfgj2dKR46ppS5QD+33j7wlV9Tiu5QbhAshqjHcSRSjQ6
 XH99ARnut2Ggyk2NfZu/hPP923GDoxtHpbNGnIjvgQgdjgIhpKX+/Tjoj+uG1NYopiEuQCQzB6i
 CTddLvHwdpXKj4YV+7TcQVcLDBjxP8kyjULOXFBgt+Apv4FIdqZ8abEBaoRnhTpZyL550gn/BJA
 ZnjLtjRw0d0z1GgIvWGlLU06nQUaVg/LQHs2PmOJK6VSsJWAS+c7kOvOwOxG/JOtnEZtt1LTP+D
 srEmcaSyvt0BNidn2R6FWuYUTJtEqxCYWn9JFBGUSugIgwE80bQTzDXwmxC0FMUmogcYGeubKb8
 ZCFGURgZXudyPwKgXNO/VQxCDT6gs3rjay3UFutfJMut0dEcmQLhUkVqcJlkUbT5pHGGmoh1FpM
 YmzJqjeagNsgsqzGltQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX0UdEVv2xFF5l
 aBxAdC00gjG3WdM8tqKuKzWzeJCD6r7RFqAYF0lTKZ9h2t6eLGns+3y6hk3eJlrqrHs/ydLiRvz
 BeyXwUPWzyGN56VU66DJQOEP4iD+SbY=
X-Proofpoint-ORIG-GUID: R2jtE3cimKFRsg-ojYy8WZmdtn67JQeo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020143
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/8/26 16:22, Philippe Mathieu-DaudÃ© wrote:
> Include the pflash-cfi02-test.c test in the "Parallel NOR
> Flash devices" to be notified when patches modify it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
Queued, thanks.

