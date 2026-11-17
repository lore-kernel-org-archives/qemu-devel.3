Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E063606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CHUcLU7f;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MKPpCozV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOEG-0008Lc-8x; Tue, 17 Nov 2026 13:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTOEE-0008L4-13
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:48:26 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTOEC-0008GR-Iw
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:48:25 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHGJItn3327499
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7smhmIaLo9WfxUwpuTkjgldthBiKct7MBu+CaVmxUYM=; b=CHUcLU7frDMFbLdK
 G/gvERhX45PUXl9TIUhG4dNvGbQZp7a1igGeaym9uPe+M6SnKyY0WpiCOsb/SQb5
 8y8wxMOOEGS8zMDEqxfAbKJIJ7OyIvGwiTK4k/i4baPmg5HqK0fP8Vpw9mSilQeL
 4VIHOO/VNBaok8v8/TrMywLRUPovlqRyakwFQuI4s4eUbW6PBSws+9HGJo7oT73r
 0GXmoujmeGG+nAq55CMrdMgayajzfUY6PuF1bg0YqlpOeHJzNJJirbE8Xwd0laNV
 LWD8vgbLLmQS4LXsr+RL9HUMtqikt4EBQMsIotPkq2mcbGMrpkgF2e1JPuDS8qIb
 IaaBxA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0tbarngu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:48:22 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1af203073e0so124629c88.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794941302; x=1795546102; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7smhmIaLo9WfxUwpuTkjgldthBiKct7MBu+CaVmxUYM=;
 b=MKPpCozVLy6/tBZ3RyBuKBv986saGXqUsVQaNIW03d642R/T82WXRKeDrT1tp6chMH
 GRPdZ9lSLaYYLLYtVwDJQYZOgfJKKztcMYGsVfG/xF/3JCIOrMG8TwahEwIcg88X0xIC
 i1cMOKSw8FoOzbi+d/W4E1cK9uBWgXSVChCvbM2XwLjYcY54MwmbSHN7Vl0Kumh5yjmQ
 EzJgNN6Lh/7+sbUFaMorIEXEsnvJn9g4j+cnLbwsJiNTD5k6wKdhBCZQ48B359jKyuJQ
 5Ujg/wBL3FAW5Q2Ml96jhvVHE98G9UOIQ/oAqNaT4W2JmI/OAjCfnwLzesKp1cvMN7Bq
 e1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941302; x=1795546102;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7smhmIaLo9WfxUwpuTkjgldthBiKct7MBu+CaVmxUYM=;
 b=Y2HPmwreOCSAcEnNWT2lXpUBvFzsyXpf3SUZG7yp9j585PYOmaTzUooh7H9bF4d1zs
 NIIRSeaWtlj4xbp6atNCbbWe1QCjMPyNvkDr2IXyOckrEU9hOtMw0HcndVKIvuuV1BGG
 vo3cn+eOOzidjvCPwGsf/+/s0yqAGn5ivSxMAV99ZIbYRKHiw3LyE9dGPbh1ZueC5dzy
 HMpDHVquuf9hXDMmlB8Sqc4ajC+4/yxHl6EVpl+TsJ1UJngFT7Wkl0S0rekynZCOFRSH
 C4xTriv5id7iInvH/VOB/gJ9bpTIfLr9P4f+VzYUIvPQti2Ev6sZ4Oewe7+nYVZMmy1m
 FYGQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGU6Er2lg0XxHs1KB5fqAMx2MimRhNhcXKuLYB3gRSHfHiav0gKVLf3p67T/amGz16rXS7/U2OVRGzg@nongnu.org
X-Gm-Message-State: APuU4Z9VruUM0OakqRKzo9QGgQ+GSFwJ/o6juh0U4tQKR7GdHpvJRJnP
 feie8p6FtWK7OPztvO8ehmROzvVFQWVtlvp2anI2dWT2V6LPqS9HUtJog3/bftLrOSq52xWq/PE
 5cTdS+/lqsg+l8+t7N5M6vBxFN/kDK4kznnV0I9H4j+8ctwoJiMcydSyRWXaEq1tF5Q==
X-Gm-Gg: AYBFou1NK/kRflgh/9bMep8WhsWN7RrJZhEpokgRLzO+DZtFCWLFKlC1w6zUSNfpWrd
 MT2ONwG5vjncbmHM+5D7JJRqRYCDgsM8dZdp0aMFr+QiVz3usGoRygWB/wIGGLmadQD2uHPaFo2
 6WbV0w73+mMhsfnrwuP32HupgPFBIHbdfV4CBEaHhw0q7FmFDwGYZW2Jecd7XvxLDzKS3RV9TfC
 Q1vPAdbHBp7XEyrL76J00ppW7H0Vsio6vzuGqodI36VL5yKsME9KOampsxwL5LMYG/7t3JgTHQS
 +PNQYvwaVtgXB/lgviYESZQ9ga7gCSZ60tOlM75+ez/4lXRASIkRysvuWS9rEStqfBJs60riYo9
 4rkdM24llel59Hz7GDHEljEgmXH/vpJdcmWmnbqxkD42vl0TEMV2020enXN/oFZ05UMPWJqgWFm
 BfidJkWpoVanjm8PnjcmFPGkTM9OdKKQAk8UZixuuCIq8=
X-Received: by 2002:a05:7022:e0d:b0:1b3:8814:8383 with SMTP id
 a92af1059eb24-1b543bb6158mr517238c88.9.1794941301693; 
 Tue, 17 Nov 2026 10:48:21 -0800 (PST)
X-Received: by 2002:a05:7022:e0d:b0:1b3:8814:8383 with SMTP id
 a92af1059eb24-1b543bb6158mr517191c88.9.1794941300853; 
 Tue, 17 Nov 2026 10:48:20 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5446f954dsm163200c88.2.2026.11.17.10.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:48:20 -0800 (PST)
Message-ID: <d7520d40-8912-4711-8eba-a91c0a1e5adf@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 10:48:19 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] target/hexagon: commit coprocessor results before
 context changes
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
 <20261117183629.2002840-6-marco.liebel@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261117183629.2002840-6-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfXyfqsLbAXIDsd
 fvmCNdvFYSFvCbmcL3k7fATVpjZYiUSK+Sxjzi3Uf1shz/hqXfHGvsC1vR6lnawS7aqwElu3JFw
 niEa+4sVbS99HZ0UXUix6J3vQ5rRsW88IcM3EqRNgx41zZ3OaGC7oH1/vRm6FfJP0lIQmKajXwe
 ogz+mMhIW2A+peev18gFDRVjR/PO+kh59rWSivBVtfXSYod3C+EOtDX7ad5zIRgTfEj2sJaIsYN
 DwMIgScYQ/tAOaRtA+gTSdLhOud3GBlFBvWkl0QQjF6L3dymh44q+WJhnw361YlMDggCVqSMn1U
 8orLv0jK2DqZFBZ1XaTBNwehN955/Hrwe8tQVqMJn2O3E306jijMwFAVOKA1sdODQuRD+53DxjN
 8qFGrnE6Vf3gd821FBJjIubnGAnzEzWofN2XK0S5FquQvqJ0jyQw+ihfHUt17W9sDCcq9rnQugH
 EnT3DJbsRtCdMWSHAvw==
X-Proofpoint-ORIG-GUID: PwcHewFM6E8v6JK1aA2G25DT-rH5--UE
X-Authority-Analysis: v=2.4 cv=Vsy2kO2n c=1 sm=1 tr=0 ts=6afca176 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=YHqdVtTeOabZ1ThQ9-4A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: PwcHewFM6E8v6JK1aA2G25DT-rH5--UE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX9JRMQ6UC1tq0
 8OsW8xDqjcKnuoSkE+zucTjUBwvdOzWkQiX2LUlSP+r0OYqlm3Z+zrL5c6AZlU0FZIu1BAmzpGi
 eeEjf72izkw59/6Fq4kOuaOwqdDjqYg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170074
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
> A CCR write can detach the HLX context. Commit packet results to the
> old context before applying system register writes, so clearing XE3
> does not abort the emulator.
> 
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>  target/hexagon/translate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

