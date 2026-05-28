Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB717CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSb5F-0008HE-4Q; Thu, 28 May 2026 09:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wSb5D-0008Gx-Ky
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:47:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wSb5B-0002as-JK
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:47:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8wF5q3204751
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EP7QITD39M08W1QRA9krMRY/SRfVzM8KnUtwBYofGgA=; b=MCem02iy6w9UZqsJ
 FlW6tWpwdgSLSeWaStpVrw4ERUoCaC5HXG4PVEd/8jXftOGCc8uaRLeyUqsRZ0bR
 muJNZcBwX68wefQ4/B/vsHmwOSw2m5FA+d04Mlaav3eS/PrYcGK7NoC5PI5USSHw
 ipNncH9NdWv9uwOGbyMe5KWoWrCfRJkvbFMvaStoEA4NsRN1RFddJfF4pmTT7e7E
 /eea9j3cikYS86nm8k5inFKwQPxBLeIbhpwFolrOLt783hmArawI+6KUvYrxiIUK
 YR/viUsJXDtntERwmCLhYRmQFNMEzXK/zflfRG9zHbMinhobNA0Dtv8o6HQf/SsQ
 AjrSOQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynjy32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:47:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304e4636205so190031eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779976048; x=1780580848; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EP7QITD39M08W1QRA9krMRY/SRfVzM8KnUtwBYofGgA=;
 b=DwuaJQgL06K4wxQHWZhrnEvH34d8mSnwnpG9eVsEXLopAcAnq+vZYkRDFElX/VPtXH
 gkHVFhvsnmjthVWmXUdw/1o4tFUki8bjuBPu6XH4PAtzYN5awSIvTNgvvGbinf6jV8zo
 EyZeI4tjUi8ecf+Ft8Lx4UDccHyRcoN6gzRCyoJPYKoFJa3ahrj5r6Brhn5XK+koWqCn
 MEWt2fqcEPlHwLiYaK5pn3BunnvZqjMCek8XoG+JBt0qtNLV7dLKiEtc0A1a1oZMmuDF
 VrdNivQvfmDyXSuDp8DXmo4NE9r/51v9/HhzPvYruONmVjPLc/VNh5IxpeAkSVvcaOGM
 Jukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779976048; x=1780580848;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EP7QITD39M08W1QRA9krMRY/SRfVzM8KnUtwBYofGgA=;
 b=BXQ9dFs6mt7jsPUZcayTA6pvleJ2Nl2QnycYdxnq9oG113c3OB/stHSBroWDgUnv0k
 OeEAIhSCQSKBh952mi9/NICSzk2K0dY8bRwMb/tWAYaCUOw4pnI+bsrwJ1FRqlmbveH1
 S/Ok7u/iIDqpHy10WPjcB0JroPjbnUKdQXNYPe7GMX0/XJF9oHiLRPdX4A3SrB2NfDfa
 tRxbFJWabl7lxp2ijYJMe14h1z0vZhnTnt9jM7gEoYNRhRaSVKz6JMCLViaRKSiLHHa3
 /8OWh5laJjxPNsyk3HdR/DXPMPeztSilww9TWYPPKwK2g4H6NKf6QBJBbTkXshcT+yfj
 LSVw==
X-Gm-Message-State: AOJu0YwDvmIRX+npiUeCPA7P2NsDgCN5TYVDGm29gNWpJBBwuJO+T7oP
 M8z9gbEc5gPBfJwcG4coU3C599Rq2+gSJrzBZV9wvXXBlLj5tkRo1KDo+xpw7EVqaqlVX9A7/3k
 E3EdKpix5IrWrXsZyakLLvKzRY6iF6cB07PQF/aW8A9wTbt1VOUbFzgtbqA==
X-Gm-Gg: Acq92OFOUtxcwP0c7ZAS1uCo5tDKFTyM3F+6w0uyAZvxhaVfah0J1mUbPcK9nEA9WDs
 9PS3MR4U2kBAMLDRIFCBEYAb5LgAyLc2cJa0ySdziBbtR4VHwXeuKDhd4CwtpA9kuujDtuXsK4b
 uWrDOhd2kXutjoaNMTpjGRr7X4d95o60unl7EzVdC0IpUDRVkfX4EvbS1BaDjT7Xb2XmPiphYzC
 CMW+q05r6RkLTSPQoehOUN7M07W1YjekuH3TNfL6dEwhGgk/NMe8ASivNKGrDVhfGWmXFfZBo9M
 L8zSbqFDdAuZj0sJmyoRu+hB2QIo8eqJwPCZRIUe43VOtqVLEbQgGW5jtlaegp94syaucaUf1ch
 nRi2mPrwhe2B/LFpkW3KbzdehAsheZhVyIygtaYmTjA==
X-Received: by 2002:a05:693c:2c92:b0:2c7:3a7:c7a7 with SMTP id
 5a478bee46e88-30449193190mr12416563eec.25.1779976048267; 
 Thu, 28 May 2026 06:47:28 -0700 (PDT)
X-Received: by 2002:a05:693c:2c92:b0:2c7:3a7:c7a7 with SMTP id
 5a478bee46e88-30449193190mr12416550eec.25.1779976047753; 
 Thu, 28 May 2026 06:47:27 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230b25sm19518013eec.15.2026.05.28.06.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:47:27 -0700 (PDT)
Date: Thu, 28 May 2026 08:47:25 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] mailmap: Update email addresses for Andrew Jones
Message-ID: <mojx2suobu4ebtmvof4qzjidemjwa6i6imvu33dqfhcpqj2jhr@md4jdj7fqzl5>
References: <20260528083920.33105-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528083920.33105-1-philmd@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEzOCBTYWx0ZWRfX8W0sp56vhNCp
 ytaO3fuI/5YPLJ5cy6+cDeYC6GGMi2Z+zRYE05pHMJNqcFUnTYLgH9RL93vuhkECxjANiYW1AGM
 +kmKg8OnWmGISqkGtnxk6jfW/2ZLYhHxeTMO/EFZsu252UTZxG9bDWeSc4vxhebcwinDF5/Zs18
 8H5hB9UXPjg0JwOn3iCix/5OEplRqlk7z7VcQYUrlerghdQ345M2yJRSKfPd2QhfYK8E1MbAaZf
 VLQy7xXF2Cp5oH5GjqYjVBXvEbh+h5yvvlfdGFJQhWCuUCNfcyerXOJ+MzfImvbaPe9OZa3Aogd
 RbUjcSHyFP73hhZa3h3id1gFuJRQKd6YKbjPzeNyAFd3bmzTTA4om9Je46JE/KEp+v7Eg5UmRZ8
 LIa9Fe7YTab/ihZ4Kao6Bf57VKRcuMiphPxpKgTqe3N24ye+ESCY/mv44pZhBYN8mNuG7lhte7C
 F0BArYR67EsaQvgjKbQ==
X-Proofpoint-ORIG-GUID: 1ESDJ5QQiDdETZJZD5h9cbtZNC9U3-0P
X-Proofpoint-GUID: 1ESDJ5QQiDdETZJZD5h9cbtZNC9U3-0P
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a184770 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=TMBx9dqlAAAA:8 a=FyogFE7hAAAA:8
 a=wT45_P3iAAAA:8 a=r1p2_3pzAAAA:8 a=20KFwNOVAAAA:8 a=bDdBU3oEAAAA:8
 a=9u_AbM2CAAAA:8 a=1eKTAI9UAAAA:8 a=VnNF1IyMAAAA:8 a=COk6AnOGAAAA:8
 a=f5LSU1h-bTDU2LUjJnoA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22 a=hD-SeztmQn9HBm-AZg8e:22
 a=p2WyBLmlf5vdw_nX_QRo:22 a=RJRP_u8kRGsxlTjV8B5_:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=DN7SgORnOiO7RqxRx1GC:22 a=BKQHd7vISpuzHE4vo7dZ:22 a=FhXx24_v1u2AaGXTvht1:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280138
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Thu, May 28, 2026 at 10:39:20AM +0200, Philippe Mathieu-Daudé wrote:
> Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  .mailmap | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 6335fbd6c84..1ce5e6c5a14 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -76,6 +76,8 @@ Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
>  Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
>  Alex Williamson <alex@shazbot.org> <alex.williamson@redhat.com>
>  Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
> +Andrew Jones <andrew.jones@oss.qualcomm.com> <ajones@ventanamicro.com>
> +Andrew Jones <andrew.jones@oss.qualcomm.com> Andrew Jones <drjones@redhat.com>
                                                ^^ is this a name field?

I see the same format below for Anthony, but it appears the format is
usually just <name> <email1> <email2>

>  Ani Sinha <anisinha@redhat.com> <ani@anisinha.ca>
>  Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
>  Brian Cain <brian.cain@oss.qualcomm.com> <bcain@quicinc.com>
> -- 
> 2.53.0
>

Anyway,

Acked-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

