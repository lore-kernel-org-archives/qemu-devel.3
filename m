Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985A7C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpr8e-0000MF-Dy; Fri, 31 Jul 2026 13:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpr8U-0000IC-Lo
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:35:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpr8S-0006Jz-B3
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:35:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VFOril489629
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dYoLXFtakHeHSiVwql8DjeJtvf5/mn3fAFRb4i+Ht+A=; b=DYN0B+sw1uP3SbEA
 l7EjUIGDpl8LUXtlGnyESktTmjNnQVMgbN6hH2JqB4yuyQBwDsGJY5tqcm2Xmsd2
 9+3UgKj/TbngKha+Cl5lf0yiPkAMtbDz44i3hal3mGfwQubyqKLJRs+DiCwkrsKD
 MjxdRMnBqb7ICZFVFXKyPYirzVWqSEzDcJwYQBfvitiVVAbiuLphZencYx7IHHeW
 btDnI6/o0EvhkRTL8XF/yfSmhy8u38AQBecl0VLXCMOlAMzc4YWWRF5qbbqD3TWg
 22Lvi0phxk5oyuXhaJLYuJ9zP4pGYM0bRtANeYw3Q1sapk8Ovj+nZo12cJ9Plhdk
 IIMoCA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fruk8shyh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:35:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84842381150so2376934b3a.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785519302; x=1786124102; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dYoLXFtakHeHSiVwql8DjeJtvf5/mn3fAFRb4i+Ht+A=;
 b=G/dYlLSfCrZVl9Um5iid0z4rHOwD+RhKlZANiyeDH/j25vovYhalcU2BLAt9kcqj1A
 3GyCWBgMfz4dUh/DZ2jTreMk36g1hLySVLC2/x3zgalcvz6Djq8hn+I0YgJoi3nYWP1p
 eo5OWFtEyXVVJnpgADFN9SeBsN71cOLPbYGEKLscAa9KgSSRhNFYjoVDVSsG8AgDE2lT
 J3zm94fDY7OUgC8K+zuBGOT+u0S0XJ+j2jPQihDRDxtvazUDGCbzlv5Gro1AKJTBfSjI
 4Zv9/CMY6tGEiFbwahAoHE2QC4Uen7LfnuUulT/XbP1lDDZqJ5K70CGFlDdBLgnarazN
 BLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785519302; x=1786124102;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dYoLXFtakHeHSiVwql8DjeJtvf5/mn3fAFRb4i+Ht+A=;
 b=Zjy98XOZwqqoONka0ZgeykeFW/6nEhylNC+npayO8t2UysQaq9jSEtHAFq6r8WINyR
 +qw9z5+1x7BdjODd4cifn0bXCE0fCQyNWJ0pbh5ctJWDSFggXcGVwZDlK2Qi4ef7hojk
 3XjGE/3cwnFA28rqpNJmr0ubIH0rG/3VMBx1LgnMrFJ0Ol5iQ2HKq+2pB777UyEv27jc
 xTw3Ox3GmKrfum1cZ/GeirZFgtoJzcHSkqedCnUHchT6032wVzl6ec7xiLYYvylM0Yon
 FybCrW1E0qxvH+tNN6vPQhEJGxR4sGLb5SB3+iNsuYDLBk27imxaKnPSgjdkPOXV3hA1
 9kLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXHAIfus+fmBW1xGuIo5v5xFsjv/UMR+aaHktDENpVVT08sGx9jfDKNFx2casbQlH2y2ikczOaaBkY@nongnu.org
X-Gm-Message-State: AOJu0YxyAAg21bS3K6+NjwJ4W+ZOTBVopBrUAH12nn027dB3YgQLXoXl
 fR967hpREo5tYONcSk2irLCwjpIDwdwnJQI0HvVwmmRqsK8EMy2E39Vw1aKf0OyqzkVY0BFJR4Z
 a/E8l+WHWC0LrSOcrG5ouNhEf89GaUijpFUDsiXE09nj0f2kz3T4Z8w8ZtQ==
X-Gm-Gg: AR+sD10FVuUxobsniRoCE+rgATETvi/ZsFHHLUh4sCkd+dAJwwClUIMUxYpdMUxq+kY
 6pgiBWjD3hmIAFtY768Q/AjPQALeYOTGVOMNCHz62qrpXr8OJZLzHhPeLTZTAm+oiEXuHBcSHiN
 ogtX0ovozYQk983pph3+gQE7EVf+RVyWSrQKQ2eF53NQoxXIlWHedWqj/RdMSJo9jG41xGqblwy
 55wI/rI2W4B+5yXVj6wg16D3Z/rpCZT3CjTH5/+nfhGlW8a5x0Qe7UCWoU4mKKVsMTlG+hy5Xkm
 uxVW4nYgjltDBQZavA5dY3KnBVg/Kw4zRCoQM+5aSCSrRHFZKz4SR+TANMa4L7eitkLnnwgtbxH
 Q7vqjnqUa3pGfdaF0D/VwhmhTOW34NGITQlQHsS/uKJdVFCX/uTa/tvC1UrZ3EGKQus/o
X-Received: by 2002:a05:6a00:181a:b0:848:7475:29bd with SMTP id
 d2e1a72fcca58-84ee4778097mr488326b3a.7.1785519301638; 
 Fri, 31 Jul 2026 10:35:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:181a:b0:848:7475:29bd with SMTP id
 d2e1a72fcca58-84ee4778097mr488283b3a.7.1785519301029; 
 Fri, 31 Jul 2026 10:35:01 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84edc29ebbcsm759764b3a.34.2026.07.31.10.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 10:35:00 -0700 (PDT)
Message-ID: <9138c754-ccf3-4c24-bf1b-b154a8e04114@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 10:34:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/18] hw/hexagon: group the CPUs in a cluster
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
 <20260730012824.1135905-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730012824.1135905-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=W8sIkxWk c=1 sm=1 tr=0 ts=6a6cdcc6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=V_P-aE4kZuN8eVbtC2kA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfX/mCYPTTIudpH
 trguVEgcCT6mIR3Wmg5Y9w3g18ci5WF+moVEuk+H3tvI0PvE3V19Y8+ETDMF+4+8F3jpzpKBxBm
 8bSXbQaSVVwoGYAOrqVh9KghpOwdW/Q=
X-Proofpoint-ORIG-GUID: IW-ajwy5xd7UcDznk1zIuZtTCyZrb3jY
X-Proofpoint-GUID: IW-ajwy5xd7UcDznk1zIuZtTCyZrb3jY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfX3tA+OTVDr/yU
 q6x9g7yvwta9XYYZvU2otLbai3sBfeOHOvuGawNPLR1hfhKxYB+xYxXTLp3qOAK8DQNQ6GMkgrF
 BDwPXn1wvbVT76j4K5McFXoyEGvsUqGHkWSjomqcyGwu4ne+qmuvEj/+Lao/Te+DIHX3R+0+Vgk
 +vRrYAg1ROxk9UVf7VoFBdNRt3q6AHb17dhV6/FWb6woDJJG21toBAUVQJU0pZnK7ASdF+Gq5qV
 iLc3Y1+HBpmIi26fyWCZlWsC3uoxxOmJVjAmTWmWFFfmcJ2xqc0yQ3ltp+UC9C+UKzx4M6i1y56
 oLFVgCsgCuPFJ91a28lYRuUGI1lPLYI9X2u3Kx1QdyFMif4BRf1ViI69h9CUGPpfJ6/B2s9APXt
 nZA6NRXXv26hR5NYWKEzVOj1D+MO7BoRapyNZF38kN64n/hUHxUFdOIsObsbPKf7xcxDvlAVaDR
 aA0hhXWX4rbjsvBbWDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310134
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

On 7/29/2026 6:28 PM, Brian Cain wrote:
> The CPUs are now grouped in a TYPE_CPU_CLUSTER.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hex-subsys.h | 12 +++++++++++-
>  include/hw/hexagon/hexagon.h    |  1 +
>  hw/hexagon/hex-subsys.c         | 30 +++++++++++++++++++++++++++++-
>  hw/hexagon/hexagon_dsp.c        | 11 ++++++++++-
>  hw/hexagon/virt.c               | 11 ++++++++++-
>  hw/hexagon/Kconfig              |  1 +
>  6 files changed, 62 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

