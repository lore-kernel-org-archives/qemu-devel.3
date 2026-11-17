Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B28606A335
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k7FnVHU9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BO5GtbQh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOIn-0002AK-L3; Tue, 17 Nov 2026 13:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTOIl-0002AA-Lg
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:53:07 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTOIk-00012I-87
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:53:07 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIETNm1033075
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AF3TFYOUA3tF/MACNvQ9vBbJ8tbs9Xhtjzaj2A/+d0w=; b=k7FnVHU9Pcyw4eCt
 jitKZ8ov9wDMj94KF8XnaBgFqQNqCZsfknqY3idAV3d2/x8k1Rb8NGjfjBxLcGFF
 RqzjRB9nE44Axz/Z5MAj0Oh17W6FoxoCMQF/F99UDlJ5HtHPmcwxajdJhvaaDJZ6
 fSGcdxygJipye/3W2avfJtnx1ZiDDnVAK2eH+mLNrHoUsETXaRLdbmfj8AHYtCaB
 AOocQSYmfe10Akazyp47Nkjp1RVqVVWZ8MI75978IDQAsM0OVqXx9zf/XYPwAnkZ
 0eT96zyDVkHpr+9f6rhIPhC9RTwX/F2enFfsfdmdNTYWWI0GLIJarqtXGERvOtyj
 3zOjSQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0v1fg56b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:53:04 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-14373747468so133843c88.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794941584; x=1795546384; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AF3TFYOUA3tF/MACNvQ9vBbJ8tbs9Xhtjzaj2A/+d0w=;
 b=BO5GtbQhgaHaXQoQlsz6vXli8k81q7fcARbBm058KxuaNivY5ilhO2ej998dZLNJFS
 XNsCHSMAze7JRyYaMxxsxRNPGcLU0QSFFInVXZcbkoDCNpgqL30C3inXfov9MzlEiJC3
 LwqZ9PeOttJv99l7fPiRHKmeNhrhJSa03TzYny/N+eWgpFfoqQ7CGkNBxB77jT2P6Q3c
 tqh6yapjKeSwb2kHVF/+NDt0Bih+ncI4dR/exztDKPMtYLVu3F+brz966OQkoHwMVLtr
 TdkGfmWZkXhXE/wU9TbIHZ4ID7MtWm6O1m6ntdGN7/4JO6eklvVTnfGoxUYjR5lxpinM
 kwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941584; x=1795546384;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AF3TFYOUA3tF/MACNvQ9vBbJ8tbs9Xhtjzaj2A/+d0w=;
 b=DsA2TQ+RAMoMaj0MX8MtCCig9/2263en5+ZYp04lZSajPmDDkntNSphKoV9TKUFd/c
 Hc8M0aRTGDND/Yj1pwHKcyn6fJf6ik0Nb1e2Ut8SSF+W1hSfWXe1indRXK/SjQDjXDND
 0GPZwNLw5SYFopUF5xvheCYZ9uiLA2BrFnbnSV3MFKtyBYR+Keh18pMcmbEdsbiuizOo
 /Op/g9F7LjR4bGocY1lR27KVUc3qalWYDFxnjUaZRllM0SuOqtYe8GDRYxZF6j1yb79l
 SY7jkXBK8MFtD0Zt2mztCGT1ytGJ+7Wl/HbdHhQ+n1Gc8d70Dp4mMhy7XNCSglZaEhM3
 +PVA==
X-Forwarded-Encrypted: i=1;
 AL+hErHO6pCkDE4n2v31ECJ6C4Ibb3bMEEhSMCLQMJWRq2d0bTfiOnWa2A7EJnjQkY1T2oaIZBtUGJrWzEVq@nongnu.org
X-Gm-Message-State: APuU4Z9c+fTiCjiEBcDI7tpegA4pdStGS2IM/FED05CivygUKVoqoiof
 jf8VFVhif63B+Y/UKj93VRHpG+fXcd4LmLfWB5gOigB3em5ujjXRwDFMq1Pa5R8DpUnyDnM5cSm
 jvXtt4UroFf8SVbyCybPJ9mwoPux6nWwCiMMx3AVYNT8rBXH+grWl7WqzqQ==
X-Gm-Gg: AYBFou1DCbaw8XGJ7CkFilk8Vg3BUjB9XGajq+6tVaMQYD1h+cSYSACaGZOES1BB2W/
 9seMIHX8PEDSatU2xOIbjeSLAGFmkqwYdP2WO/ayPc85hmPS4cR9LrIEMpVjwg8B53pZzHyI7DF
 PuQkxX7qS1gE22gYpAFZraNY+uC+tl5Gq5FFW77NwRc354FUiTKP5aStmia1II8h2S81QWJoYFY
 F45bEsxdkFjbv+9nvla3JPM6bM9cBTnl9yaHzdt47Rb58P+4dMpo0+8ZaRgPc+fyCHr2Qbgfl0J
 LryhtJGOcMBcFBu79z7Q0d59dt3OKQ4ko506M8fudnQcj5QxhE1t7MHNNKyLstV21L5Gf+jC8gt
 puQwddDk0kk2M156fzvDxsBri1O+y2dTitx4VdAnqYuOmcu+e/wf9hACnoidM2X0Gne1ZTNYH82
 IhWFRz3IbfhCuHpv4Vm8K21L22ZKqO5F+Q8cetaXqrywg=
X-Received: by 2002:a05:701a:844c:20b0:1b5:1ee6:b6a1 with SMTP id
 a92af1059eb24-1b543d3ed19mr355086c88.38.1794941583818; 
 Tue, 17 Nov 2026 10:53:03 -0800 (PST)
X-Received: by 2002:a05:701a:844c:20b0:1b5:1ee6:b6a1 with SMTP id
 a92af1059eb24-1b543d3ed19mr355069c88.38.1794941583313; 
 Tue, 17 Nov 2026 10:53:03 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5446f589esm182670c88.1.2026.11.17.10.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:53:02 -0800 (PST)
Message-ID: <9be38ec5-80ba-4a6a-b038-c66e29babaf7@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 10:53:01 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] target/hexagon: bound packet lookahead to the
 current page
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
 <20261117183629.2002840-8-marco.liebel@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261117183629.2002840-8-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0DRV5M2s0tCTyRbi_0SlL62Af14owpmn
X-Proofpoint-GUID: 0DRV5M2s0tCTyRbi_0SlL62Af14owpmn
X-Authority-Analysis: v=2.4 cv=IbgSymqa c=1 sm=1 tr=0 ts=6afca290 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=YHqdVtTeOabZ1ThQ9-4A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfX81tI4uqv+Jm8
 7hEoxGytJbXD+w4hVGLE3IWbV5GPljv4mvcm3Y8kBmbYEj6MF+rYoqJ9YMxrlAKgqLK8RSqzPy6
 lmX/FT3LuFnt0zV6m4VFROpuxmqDvVcw2hSIWekYcqfy1sM4HVldaWBBo18DpaoDztrLJ2aRdxs
 7PSen2CcViOThec1+95W65rWPPeWBcRvwo5ecyY+k9//9XiH4gKvwhsvDKCIHMG4pDcdongkmwA
 jEOrML1nU7i2JazZnV4BiOKJVEPeduNQpgZKPxCsIEx35z0xKjvz5ZyMrIyyLcK7hnIJXMUWw9b
 FjLj7tu1zS3rU3BBkIBwZIlNpH3/qKKOUcX3i++WCjie8Q+5whlk5jHfMry71wuXeUfNINMpLgy
 VbP2qrZuv2QwtlKK8O8HWK4bdJNsipA/KlddMHZsHDaisZfVCq7+Wqvr0pMrd8Kw1qy7/LURM7U
 fycNF2bkJZ1Ck63v9WQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfX4DJsMAVOJA6E
 /SC2nTZeNSh739xxsyN5mjHWA45Vo2SjH6FzxTiU9dDUYca9XaSrbm+tePk/4iQrdB9C43zcGSp
 wSusdEZ+o2+d5WjYce2d8puJ4E5fg3A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170075
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/2026 10:36 AM, Marco Liebel wrote:
> Do not fetch an unmapped page while deciding where to end a TB.
> This lets complete packets retire before a straddling packet faults,
> and preserves the correct packet restart address.
> 
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>  target/hexagon/translate.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

