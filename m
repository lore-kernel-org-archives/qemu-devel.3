Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E95C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 02:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XDo-0002Lz-E6; Thu, 03 Apr 2025 22:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XDm-0002Lc-Fo
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:55:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XDj-0007Is-IV
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:55:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341O6vD012914
 for <qemu-devel@nongnu.org>; Fri, 4 Apr 2025 02:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TbU2Gnzpu4CqRvGVTxMK5UxL2w2aLjrGyIJFTXNufY8=; b=aG6k90kfzY81ZOYB
 4Ykl1fo7dDHU/vFY3VQF7r+G3piScwvqlQfpCOuOqRbRkEs9u0zDrQheSRgJUa/i
 lSjan/1qyTGtetwkj3re8i07mYrZZWKAvbrP118Kkr1NyP+H1gYPcLXsemEBRjnS
 T6nSN296dAyaTJGIUVFGD2+Oa3x8KxNHToJ+MybHiLD96+SW5Q/21sG0KMO4pjp8
 XD0QJexgf10GPL8afAODRygirW5d8PTAqi+DSSgMV1LLw+dkllqC6Dg0emVJUbPj
 xXCsJ60qtCrBFimxAmPqK5uBiXmhopGsOkuBAa6WVS6fpYX/dPz/nVPGGTC+8MYv
 0YHcyg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d88g3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 02:55:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-af2387f48c3so1105287a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 19:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743735349; x=1744340149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TbU2Gnzpu4CqRvGVTxMK5UxL2w2aLjrGyIJFTXNufY8=;
 b=Ez2hmF4d6MojtCpSXCeiqiPGPwlacqM2UkZutyLCniMStKz0D/SEOqZyismRPw4K3u
 +w0szDDfHvOpRzYgLVtrDNsJYLrBDhMJFkIvK7P1gu3EV7DUZFFfAHquHCPI2O766/P3
 wIpSt0x2me7Zo+0ckyILOhMKGOofNiVMIZAIPpxsberpiDSDMMzshiPbwvE8PaLqJ02B
 j9mkbKPjctWexJVnvdnCWqzGbXYYX+Z2QyBuV8f3JUpTdxpDw2qY+q7KZwSBoxeqJZy8
 wEkUSW2grJQaw5IukIM6gRkQ2DoFekxDRGbBf0wkNdlYLJ/D6LJNbPIGJ3YlbxTlvVsA
 sZJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6UgnwbV7enfTXDsUcIO8R6rhqRlffcIRXUzsJ6g6ccOpK+chKeQk5Nj+k3PmK3rVcM+4jj7IVMGT+@nongnu.org
X-Gm-Message-State: AOJu0YznIcb+bSDCDFez0CbQdee4chqRGedv+oDz1AJRkKqC/mIgU1al
 xPg6zp7nyQVv6ItWgzn68AhprYwMT8DeiHtfzjrDmuH/SCLOKsfWw3iOCdis9PjqEPStUQeSzV1
 WrpnMYcLSQMpK6BKpN0+iMDyrJrDoIOcibgmjPbgE/6+ak7ShGhf0kA==
X-Gm-Gg: ASbGnct6xfryIUq1dOmUcSSOTCejLGQ0VjgfY5rvJdWld8Uj+8WCp9kYnsO5Wy7vLTH
 YD1K3snWT43SiRZTlgyYwnAf12YxSMLR30fxdVNftzZNSoMqHgtsL3hx6CYU3sH61NTILknvGHv
 VTpkIy74+Hs+2JE1RRdxHMtCYyIK5Q8Aiu7DAyX9uhuCcpd1FT54vKFE1D6jCXb0ShGkS4jCbMi
 UeuVT7SPtGlsviAUQ4Ko1nvtyfSzGAL3jEwKyzxJw63mQcvwA9widHpDaD7jI6JHH2rdWd/uN0P
 Q3WjUm3TNSq2amg4IKP05cdEp8Ajf5rcBCejlhzt5+HALm1wOmfiAYjRqfDrXrYwknMl3VPd3xe
 wel2CKgzjx+bYgjMF
X-Received: by 2002:a17:903:98b:b0:223:2361:e855 with SMTP id
 d9443c01a7336-22a8a8cec28mr17671675ad.39.1743735348968; 
 Thu, 03 Apr 2025 19:55:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH3X2m+McrWuPYHSb0mqHvtja7rWrk/dugEipOBhw1LlpNSXyjMutNpXEOeYvvpp5pP1luaA==
X-Received: by 2002:a17:903:98b:b0:223:2361:e855 with SMTP id
 d9443c01a7336-22a8a8cec28mr17671445ad.39.1743735348579; 
 Thu, 03 Apr 2025 19:55:48 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ad869sm22109035ad.26.2025.04.03.19.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 19:55:48 -0700 (PDT)
Message-ID: <6e44b39e-9c2e-4046-a9c9-987cc80d25f6@oss.qualcomm.com>
Date: Thu, 3 Apr 2025 21:55:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/hexagon: Fix macOS build
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, philmd@linaro.org
References: <20250402114259.21953-1-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20250402114259.21953-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PqmTbxM3 c=1 sm=1 tr=0 ts=67ef4a35 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=NEAV23lmAAAA:8 a=oupC_iOEFXF4q81Qu3IA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: iGWz_1LJeQLa46X_-fSl6XHvlKYOhl8o
X-Proofpoint-GUID: iGWz_1LJeQLa46X_-fSl6XHvlKYOhl8o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 4/2/2025 6:42 AM, Anton Johansson wrote:
> A default macOS build with xcode cli tools installed lacks the `indent`
> program needed by the idef-parser postprocess step. If `indent` is
> installed through homebrew it doesn't support the `-linux` flag.
> Conditionally run `indent` only on linux hosts.
>
> Additionally `cpp` used by the idef-parser preprocess step expands into
> `clang ... -traditional-cpp` and doesn't support macro concatenation
> among other things, replace it with a meson custom_target running
> `${compiler} -E`.
>
> fixes: https://lore.kernel.org/qemu-devel/d95ebf5d-c1f6-42c5-8aeb-65764fa87125@linaro.org/
>
> Note: default bison on macOS is still too old (v2.3 vs v3.0) and a newer
> version needs to be installed via homebrew. I'll take a look at
> supporting v2.3.
>
> Changes in v2:
>    * Don't remove the indent step but only run on linux hosts.


Thanks: this series is queued on the "hex-next-express" branch at 
https://github.com/quic/qemu/

> Anton Johansson (2):
>    target/hexagon: Replace `prepare` script with meson target
>    target/hexagon: Only indent on linux
>
>   target/hexagon/idef-parser/prepare | 24 ------------------------
>   target/hexagon/meson.build         |  5 +++--
>   2 files changed, 3 insertions(+), 26 deletions(-)
>   delete mode 100755 target/hexagon/idef-parser/prepare
>

