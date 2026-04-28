Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF3AFF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHlTU-0005Xy-89; Tue, 28 Apr 2026 12:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHlTN-0005XN-Pw
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:39:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHlTM-0002io-C2
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:39:45 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SFsUXd1796774
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 16:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WdcEna9mnBH51rmACdpP9JNnw5U2jmIq2W4cuNBCUvk=; b=jaFGovVj6f+YPM7s
 yKPOVAv1kRMuJ+Mn39jGIZfJTJoW4jISRwtQqqoT3nYxWRo+X1e02fjAeHds/UZd
 9wCq+cIdAA+XOg/iQd5E8D0IUqOPaXJsOqR74zc64tpslQcMBlKK9OLlu440dhzE
 SAZfvPZNP2s3AyNSStx84S+l5riLkJNjDDEA6HS+yBQ9KfVTpHADau5A/9tGHlt5
 /k26rMQIgtNebONKGPELH/ZBdnqiNbFAFN8lZE4NcL0Ud6Osb31BeylMbCuZFyFk
 o0QIIYNmlUk6IC0AiuAdrU91mFDt213YV+C9KLhM5EvqGKNcqFjkmNcYEU431OOt
 TNNJXQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttt2snam-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 16:39:40 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c66fdd4aeso17456111c88.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777394380; x=1777999180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WdcEna9mnBH51rmACdpP9JNnw5U2jmIq2W4cuNBCUvk=;
 b=YzW8LIFke7q6z7ChFFRTGRxm1LB9TVKI+Ouq/kytfK4sF/jIPAj/hK3TC2imFeImXK
 pB8m9zPRvfF5rqEGACkZClSyQ+tJ5ooREQ7J5mK4u+oym8AUwlfa9CEU30iGZkA7Mcyr
 6mpX0zslOmVIZim6H5Q2tqhh0aQI36RPwXIHJXSY+erBb45Pk5Sr/1MN1hKuBdR12yIb
 7UCHqL8vjuTYAU0AUvpBG284Sj7BlA+x3TvJn6HUQSVpXl3oFUKBcIuqS5yse9+nVelx
 Ztb69HlFHedTrI7w3x2Vse6EIh/3T4ZL33S0Tug2O1nf1N9BLy6a7veJoSgHC0rC1AV8
 bhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777394380; x=1777999180;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WdcEna9mnBH51rmACdpP9JNnw5U2jmIq2W4cuNBCUvk=;
 b=Se6IclfNediVsAFrgwv5RA3z9Xou3Ohb64ezs3Rl9qxNDl+E+zX7BAQ348ourS4vAD
 KLptU+z3O9fR1MmJs2OHjv5RGlMT6RNUycuwgQavGIQc2aqWMlIAjE61iXWZTYcPi1fx
 6KKl2cczX8iaDPaKRpJJWp0ztrYktKmGHnuGhNWNoRCihNickNOoVzy+MMju3BZZHyXG
 RdBxpl/6SSB/kj9nxqLCpgzcxhGC9GXuaHR+ccOWEyLNdIzrDlZ/KDSUJtuX9T7LMlR1
 1lJ3hf5IY2sdkF3swJ4e0bL5E04Ee1QVInDeT5kDi7GhViiox2ob1UNz/TcM1ffVPl6M
 nc3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DiT8tvIdqiDAdHW5lRFS3JY0UAEWZoWGZRJdmnzHpOdNwiuhvGMRSUhAcVtOfWdPxv0IREF84BMUZ@nongnu.org
X-Gm-Message-State: AOJu0Yyg0V0hPAGjM7fipCcxXq5VtcrH5YQTLtcqA39kZV2xszlsvxdz
 AuHKtR4RJHn0MBkDVux1/cLiCTtUWpxtOWFKW4yocDNATQtWgErYBy0oJXq5Zc8gAZG9kdtcdBN
 eYEgIwpDHhnIYXQCw+ndxy8zGYPTcfeYa2geMBFgwA2FNpTT2CztHkFFDiw==
X-Gm-Gg: AeBDiet4PF+QW4wULx8Cqd55rlEigIuOlsBFwDidXsWMecsLyVPnxCox7/UU5tjKQ9U
 hQinYxmnt47i+ymcmDLybUFfNIaenoWDeVPnAHeN7boreWyh/J7UONezufnc/PKYKpRPRAygQ8T
 FbiHnCEMaXK7+ILvRu8cUEI2a0UgZmHPeK5yh7a4CV/YlA0D29e2hjk/VLj3AJQvzSUZjb+KvaR
 g5xllL63r14f1IbvLYWrWYy7rphZ55gnxah93TDbGsYQWtexMs/J7DWxr2y1tQqGhvaTY4KtJCC
 ycv8ZoJBI39PUGrVGQbjxg23bz0pE326CxPd93xfzcaRcvbSZwHMbFY54IA0wqJ4MLVBkbI+IPR
 E09Ta3NdvQuWs5897/l+kmGMYutQqw4Zhxoh0ONzlL0Ur5gUXMXEN5qfdXbQfY18iG+zY7OWzVR
 wtmFs/pYPBcXg/f0nFaTv4W6QB
X-Received: by 2002:a05:7022:128d:b0:12d:ca31:f1b4 with SMTP id
 a92af1059eb24-12ddd9e2a7emr1583534c88.24.1777394379647; 
 Tue, 28 Apr 2026 09:39:39 -0700 (PDT)
X-Received: by 2002:a05:7022:128d:b0:12d:ca31:f1b4 with SMTP id
 a92af1059eb24-12ddd9e2a7emr1583506c88.24.1777394378910; 
 Tue, 28 Apr 2026 09:39:38 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed09fb6b8asm2570105eec.8.2026.04.28.09.39.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 09:39:38 -0700 (PDT)
Message-ID: <ae19852b-a1b1-4239-8f93-e1f051b12673@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 09:39:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio: Drop superfluous inclusion of hw-error.h
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Tomita Moeko <tomitamoeko@gmail.com>, 
 qemu-trivial@nongnu.org
References: <20260428163702.3224323-1-thuth@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260428163702.3224323-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HbIkiCE8 c=1 sm=1 tr=0 ts=69f0e2cc cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=nNKS-znRAlsCiEQLjRkA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: 8_pr0vKZJ3DVm0qrELnZizVNGX_X5Dbp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE2MCBTYWx0ZWRfX47SdNDO+uFhZ
 WemIh36nlM3eOmkSBPibAgxd16ZXwwASwpKjN6L8PIA8zCeemz48V/3xCneua8zWmCMypqQaeC1
 hraG0TKgbSJqd1O/uCgZPH5hcxCm4UEPWijg8/3lMi8uKk0FpX9s2p4M7joDQ309GXH/KRJ7Y99
 oNLJLjBVR6iE1XaPsnzG6FNgRCU6I+GKS5cFppXRgyZyMuTNVzzumNDzepR8KxbHyC2w+I8CFD/
 xhEww/J8C08qP0P6upi+3J1b1GQZrD4OwqhK4R6r8mysC+kSd+fcexcLffNlSmEGepqBOAtIqOD
 E5kMwz+aXkJN6JKwmnP2vuoto9rnt6Rn2QlI/XOmG6c7EQCR1za7/xKSk6MsTQDgNs/1s/xA3fE
 wTouyFjoxeoFfjaCd5okNjH5aYpHxMgDFf59Lb2zvFvpN+JCNYxt+Tdbevc0YEbE/8/Vy7aM3z6
 nO2Fb1IqVdjJIIZxgBw==
X-Proofpoint-GUID: 8_pr0vKZJ3DVm0qrELnZizVNGX_X5Dbp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280160
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/28/2026 9:37 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> None of these files use the hw_error() function, so there is no
> need to include hw-error.h here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/vfio/device.c      | 1 -
>  hw/vfio/helpers.c     | 1 -
>  hw/vfio/igd.c         | 1 -
>  hw/vfio/kvm-helpers.c | 1 -
>  4 files changed, 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

