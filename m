Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC291606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KyGA2uzD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZgP7fJ2G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMcsx-0001Eo-5K; Thu, 29 Oct 2026 23:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcsu-0001ET-Sa
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 23:02:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcst-0007rG-6M
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 23:02:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U2K0sT1961172
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 03:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OqWBAFJ1Xv6jdfCEx6zo6ILKN8HzKkNWWXhu94TAQm8=; b=KyGA2uzDb3bZrG9E
 xJW9gMPsI6i2xqOpyCwegW0lI9pagF9qoJrxIuBM48HvFhSBs2uerPc0FoqnyymR
 fAlhChItw5X8gxQio0k2X69aSLZXGplICs3NEAD/tggmbkZBi0ZDWEMANnDwS5al
 17ayGsNF2DHQKxh9WHU6XptAqV1MWyeg49jzT6qm7Yq3Lw7wfLwwCLlqsnidSr02
 vy7PbJNlWHfuhPJMv2188RrIniSXPnyHsptapa9zdPBGUziG06PBJGdAsXJKb/Kd
 uDbugkoW9OAw7d3PYvXjIQj7MAEjvkoapekBpnxGIMkKaFeOKDUFcgXLku1ntPpQ
 bsU+IQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qgwc3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 03:02:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5375488b238so24156131cf.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 20:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793329344; x=1793934144; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OqWBAFJ1Xv6jdfCEx6zo6ILKN8HzKkNWWXhu94TAQm8=;
 b=ZgP7fJ2G23/giLNdkonUB4EDB6tJlMMHWHpXKK8jxOvP9Z/MksUaciu40zVeJIsR+K
 HiilmwmrcHPoKSpkirlDPwjMHRJS2yRu89e07hRrivTpjv33QYM3Yv5t+o7ByZvbzQ/F
 CG05m3KWlFbSZXb2ckC95gnFW7FIeydQuNR/qspaXiOLPhX2lEo6dnIYdhx2n2TzLSof
 GOXEfnQRbXf/L9zTywR6H/WwLVKYcIaeF7gPe5rwbWRAeo69atwCIM42OZgNhMLNFqar
 Pt1aXeshrjQiXJBgCkkrvOhENLAku26YwPEzUkNF9tlOU0DWPBr6CGpnkZXl0qRvFQpb
 xAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793329344; x=1793934144;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OqWBAFJ1Xv6jdfCEx6zo6ILKN8HzKkNWWXhu94TAQm8=;
 b=KVWqJI2d1gi/3kATD1q9ICvUsrLeEq+Ip3ONjH5/SUrmt0TU6XDV3KsBsYLFWY7Xi0
 vnZitTAeW9p+hzMzMnHZfLKbmdeDJj+3VrokLjcCFrVcpwQr+y+YctlCMLK4D5iWcJ+B
 2QwCan6wcUvrHRt2mWzybzj9vfdc+fCdIBn3C+fNbLZK0KtSjwvog/8JYdslgXDkhjkj
 qmiFQrbmJ3vwjEpGVVfRsayFQA1d12C/Fk/eR5LFqae4hS7/jLGCbzrt2Xuhi+uKvmDk
 XIeJXYawzF8skGo48tAAWi/F3GSIRRMJ1KAZi1hqiY/5LREN35gMnxCoJMHpt8No/HHq
 GBMQ==
X-Gm-Message-State: AFq9FYJVSNdOQi0INL9vgcDLX6TGfWavP+rxFbElongZJv15LOwNsRSo
 fpFo4+h5c+2e6+vcKXDNlL7boXw/nD6s+AeC8/YmWpWKk1G4rErxrQH+QdGuGImo4MQmeyFzOoW
 C6PIj/71BXkKw7Y58ujx8e3wtt4UcPnaBRgK1Us+aKbDYsQa/zZ13XTMuSg==
X-Gm-Gg: AYBFou1P3KnKJ8hvbbhT4IKKWFD54boQZ0XeohFcAZd6oZmSLlSDnoXFKcN1w3VwIec
 MTICN8cY/V7ci+t7cLyvQ82ggl1ZY1DqDzInoF2dnFmla1jNg0FEDJPQjbZD6YK+DEtYjTBQAo5
 vuuEExYknon1PJf5R4tdYFIOBGOxas2ZCpk8Y/ztNZ2d2Tm2qgjmCGHTQDky3pd72ZRJGsb87l8
 vWWy3+YrQudja99Fh11XTeXWPAhXDw8+cz9Fj57/nZKLbzHoVmQAjiDzgJnZqTVUV0azR5AHVOG
 tur/gzQPJLpv0lSJfiafDNwV+3MCCtbwdpSHWSE1fr4yml4Nu9zCFr+2NKr+wN0rzT5Ooe4emAw
 cVYmobvrKjIof1Kn7YCYUjV08txCKwMa9JBLgBmfQ9/z09ePnA4UKO3Hoo/jCKWg6KZedJo+oTp
 kzr1kTRCmuKX0bxh98zdUuCjFf/ZI5hyJfIjNAGiVWgKTAApfbMYnI
X-Received: by 2002:ac8:5d8d:0:b0:536:7c84:be57 with SMTP id
 d75a77b69052e-542b7ef4f3emr14936971cf.26.1793329344045; 
 Thu, 29 Oct 2026 20:02:24 -0700 (PDT)
X-Received: by 2002:ac8:5d8d:0:b0:536:7c84:be57 with SMTP id
 d75a77b69052e-542b7ef4f3emr14936641cf.26.1793329343373; 
 Thu, 29 Oct 2026 20:02:23 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54311995157sm2275121cf.8.2026.10.29.20.02.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 20:02:22 -0700 (PDT)
Message-ID: <c515e590-49aa-4cc8-8986-b43ab0b5b8a5@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 22:02:21 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] hw/hexagon: describe HMX in the device tree
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
 <20261029230310.1632334-7-brian.cain@oss.qualcomm.com>
 <CAJ+KCYP8FeOWd9ghCi-+vOB_=RRb3Tueo7n67pPRnpsNCJxPBA@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJ+KCYP8FeOWd9ghCi-+vOB_=RRb3Tueo7n67pPRnpsNCJxPBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: omJpULPPnegzRKAskLty2yRYb9qYmjPr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAxMSBTYWx0ZWRfX1RISB3PFczvB
 vUV1hSacq9blR6277jxZyfzKNM4W+fNT3piNP2Dz6Sh+dAQ51P7TtFsVZVbmrq+hmGKqhBaNk+2
 txQpbjk50cNIdL+OPkKaQKhed7+1sVM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAxMSBTYWx0ZWRfX56QQ/Y0by/ZD
 QSwKhwo+E0ZbBqwMmZ8PKUWq3Y+xSgcKb+Aaav+uyLQ5SCNhTiMv1v80wqTd0HNTOltTF6AfsvC
 oJtP9E92x8RYXUbA14NoVJO3OVB6w5HZInjtzGIY11fTNBQNz/YZPyx9K62WTDl7wJp3XaV/RdS
 d72+7HCWxCy8H6N51IeQPe5ah+X9S7g8K4tCbSP7w80BVRopCSOwX52HgLNSEJBokfcrM64VllZ
 VYnMcRdP+G6edoH5K/aM0jENJNDWl9l7jR2SLuvG7ds0YjjgP+3NHfq//fdkxm0v5FMT1zR2lyC
 BeyVI/sCGokarZu/Aj3DlY+FVL1DQgRK2h4NRnTlSMNQFGzyv2FW54DsO3Fgwjca+qpYfJRIP0s
 Psalc56UCkOYTAeHKc802fXkHKqsRoFd3V/Q9/T7+6lV3CxL/e0FqZCtkqJ4N9mkIRq9r5AYlZD
 C0PdDKF3fPbHiOGvKOg==
X-Proofpoint-ORIG-GUID: omJpULPPnegzRKAskLty2yRYb9qYmjPr
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae408c1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=4JwpjGQ1WGWj7_rwshIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300011
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/29/2026 8:47 PM, Marco Liebel wrote:
> Should HEXAGON_CFGTABLE_HAS_HMX check rev >= V75 too? As
> it is right now using it will change machines older than V75 adding HMX.

If it's present in the config table, it should be present in the device 
tree and QOM.  Regardless of which arch rev.

At best it could be an assertion IMO.

-Brian


