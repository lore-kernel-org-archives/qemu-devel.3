Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1C606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ca5LDS5B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OLKLN26Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHrq-0005Pk-T3; Mon, 09 Nov 2026 00:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQHrm-0005PO-ES
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:24:26 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQHri-0005bP-Nr
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:24:24 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A93Jwi2120490
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 05:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9IJu2Wf5HZE0Pxlx/3woO5mH6UzgpsYfdz7SV+KUu5I=; b=ca5LDS5BLEyRjX3N
 mxud/XXCVQN2E9tWLLewxUsCnZoHJ4jTrCROQBvkEHvZcySayDm9D2dWyfdr8G4V
 6b3PermQAw0eG5AaAy+0OC9wczOuZGy62s1qTbo9cty/LcshkcgSXrUuLHfQ2nD6
 qVat1RSpgW5WjEakYpMlXY1cyBacZD6MBIHloxyKcDq1fv7TDrBfvbLUs6uYWRaK
 Bchf3bkf6o7ar3yCTQPzcLpxjS6UnT0XzTyMXIc2qcMCad2lj0d/tB3qKtT/tjCl
 oKsEIBNFvbxtDXKMvZdNKZXulh96Vh5Y/qKzuZONyO07zhYoAjWFPLSsMtTviJWQ
 fnhv2w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hstxscwn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:24:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso1390012eec.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 21:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794201859; x=1794806659; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9IJu2Wf5HZE0Pxlx/3woO5mH6UzgpsYfdz7SV+KUu5I=;
 b=OLKLN26QWnkPQZOylUujLdHTvIPDhkKdsEqMQZNkuNRZnWbSD9LF9xVf5Dx5KdcYjC
 L+AIQPHX4u5XNOT1OjS5BDAGVHIghDAnxv89QIQzR7mZA0hSMZFFU+59gdmCriGo4rOg
 9k1CGdV/sIyEqvRi0ftlBeCaNvYBCvRLvKW6loiMv8B9VgEIx037swN9BsxAGnTMna26
 j1PqM0L8sZ3+3ZMAhmREKO9WINZlM8Jfp4JlhZsMabF81qnYazC/4z5eYSlwUEcrHI2r
 ywp3Z8jFVxFCGKV1qEKYj68+OTmU8cXpIOyCqP6V3IaTkLcDnxBvx8LwT5lnBuHUHrbm
 h71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794201859; x=1794806659;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9IJu2Wf5HZE0Pxlx/3woO5mH6UzgpsYfdz7SV+KUu5I=;
 b=rNYht3BliZatYsNEf//NloUy7kGF577+qGVeP3Jm/NDvAKeaMx9dyOG+d905/t341z
 t2DW6V5Nrf3Jp8fOzCe86L4uG/ERnUfU8wjUDpJYu+J1bsv7mttnIreSiF2Da/Sm9KIa
 2wL7+f82ClDFENAFcd/uE7ppNGotQt2OyVJYdwEhc/RzMMOMvt6N6tmf5IINph+98rpk
 29bJNX0vcRCrywyLNc3wpmE2mfhAqUv23bD0ER3iy/FTy7yPLq7UimrEehDsfZlqiKrU
 c8QxF8en5NCCH/jbMb9DqNpvFWnMhugDXRCRb6fAk0ktnfnF0kzaXvEKtVkLXWF3j1to
 VJUA==
X-Forwarded-Encrypted: i=1;
 AL+hErHer/VauNQvDq8Zf6/HgfBrTNWTXeecWrIH2T1M5phcPIY1pOYZRc5e1MHdsKuTmO7/AqsiAF9Qengs@nongnu.org
X-Gm-Message-State: APuU4Z9jqrOjpXExEo+7nPQOUrPQocxNfng7hDMGAHPiXNvx3gjALw+U
 jN3XA8DcZ6NuO1LxflMr1OKXxo1Fdnw2agXYBs/gD38QwlVjQhtra6S1Lgmyx+fn8oFUGpmsZQI
 T9GsgngCIlyxbBcaeMsRSaBKOEFK49qSIp3rkDaoE6bNjw/aZnFiXTAqbce3DkyT0gA==
X-Gm-Gg: AYBFou3KLgtz9e2MsjB9kg1uVFx0yjLviV2e1Dt6tvMql7ExIrUks66dYdO95ViuCBB
 P4Fchtv9cb/UZ2/UCiJ5JqkCq716nTmreQ5SgOLwkyF96oKn3FcslcBjBkyUyJ9fyZeGapHVw5e
 99vIWly8By7ORIFQB2HODDeTIKxBt6T8OLSfFWby+Gkys7JjTSX6qiyn+1s7jmWWC79wvSfiLR+
 KnJpgY4EwA/xGjDYaCR6UsSM7SQOjRLFTE8AEdM02mUtX2VL4MhMnfehn0rcnvHKbD6GfNnzJND
 nHcyHTkqAXHmBIMo4wghGx1XfVu8uOMpYuw2ulR+UgKm3BrvtNGl65nySSJKVfQYnk4TGTuJ9Ro
 hziWbEMluQtskAlMf+8Wl4hWsMkSmOraoH9qJOVcjHpsDAFkhsfjZoAD+Ba5Op6DfKg4YV3HP0l
 8lWJBpXd/vRB6nU+iTBQvoqpOCryKWW2H6eIQEyqi2aQ==
X-Received: by 2002:a05:693c:810d:b0:35e:5ca:e0df with SMTP id
 5a478bee46e88-372571dd75dmr5850864eec.35.1794201858979; 
 Sun, 08 Nov 2026 21:24:18 -0800 (PST)
X-Received: by 2002:a05:693c:810d:b0:35e:5ca:e0df with SMTP id
 5a478bee46e88-372571dd75dmr5850829eec.35.1794201858385; 
 Sun, 08 Nov 2026 21:24:18 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372632d7d62sm15405426eec.3.2026.11.08.21.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 21:24:17 -0800 (PST)
Message-ID: <be31c30e-c3b3-4b90-a760-f47e82a2340d@oss.qualcomm.com>
Date: Sun, 8 Nov 2026 21:24:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] docs/system/hexagon: describe machine models and
 memory maps
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
 <20261109042307.1301438-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261109042307.1301438-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EgQalEP_lYGoBAhJeGo2ItlLbh9IgeaK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfX4U7GSvwfB7Pt
 vSTRF1kA4PMCTxONURcZv1fzbgX1SsNVWSF15G15lWJNCD3osX3XBp7o2h7sV37r4nkpCGntFfa
 Y6Se/8HHz2rKq6lO/afz6uK9Q8H57ug=
X-Authority-Analysis: v=2.4 cv=dZMVTnXe c=1 sm=1 tr=0 ts=6af15903 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=75vm2KtsV9dCPAymN_EA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfX9P9+14rTj3zW
 8WaWj9JeNVUIPB7tGaQthFWUVbmzD7U/2qRhxYsptCTEheabmsRA0mxkupvRCMOwNuIsTf8Tx7j
 PA8TXwpmgWIzjrCDe4fsGZbLk7s0Q4WykXCMgZnBOdRDm/xWxSGpyFkFOKlyKq2oepUBKP2GyLj
 X88+t5sMsWATf3DheE5adtOivUjD87GtslTxemlBQSmlg3wfh2pktqmeH7VcABw0ondtz3cxayk
 Fte9iYtDuykdxEqYx8prfi/4uwGEWAvL+Y5kIYzR5DWHq8KgAGRjlYn56HDNzFZxOkFm79lWJg1
 NGYHgv8eqlQTGEF5G/y5I+I1QHIc+rfNsJp1g+Shs+jk6qfivmJDb6eKuNh2VyVP0MvQTSLX0HH
 Z2CxH7A+BrFLieFDMOgAUgONYaraZrOwtSjATIAY4UK95nzyjhcZlzFFcIZWJ1gED+4lwYXSE5y
 SV3+n+HVWrCIUdt+DMQ==
X-Proofpoint-GUID: EgQalEP_lYGoBAhJeGo2ItlLbh9IgeaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090020
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

On 11/8/2026 8:23 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/system/hexagon/cdsp.rst     | 41 +++++++++++++++-----------------
>  docs/system/hexagon/machines.rst | 38 +++++++++++++++++++++++++++++
>  docs/system/target-hexagon.rst   |  5 ++--
>  3 files changed, 60 insertions(+), 24 deletions(-)
>  create mode 100644 docs/system/hexagon/machines.rst
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

