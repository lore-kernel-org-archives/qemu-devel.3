Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ABDCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 16:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wacYW-00057q-Ui; Fri, 19 Jun 2026 12:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wacYV-00057Z-NN
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 12:58:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wacYU-000837-A0
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 12:58:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JDCUnA593405
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QcuD8OwojcJEe57yKnnbiXG7IOI7GRDjQ5npFesDZGk=; b=BxH1r5+Ma6+RvAXv
 L9crNYJXAP25ITuAoYfURoXf/i2zSpFrbmEHOC2VBGF36DDb9uae+kbbnrYF/+K6
 pqWSV81f2NboGAZuXtVhHt/ZQpuWfVmpjFfsTcZq9XWMTWL5uMXYj8/Qmic7JDmS
 0g23BdffQnkHzL0eszdd6gecoTBKuypmNmfzDNKWtj44aQYVxvx7Lw+ENmD/DYzX
 tu2ej5rSuuLaQR4zR/5CeGAMw8cPM13KNgsiFi5KRkXoc4rQWAvw0syefBojPN5q
 y5FatWjSOmGGFrLmybdcclP12Eg/nST8xNshiPh/+mNuR1/7E8bmAe/UvcgFPFqn
 NeuOfg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6sc5sw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:58:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso4041978eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781888335; x=1782493135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QcuD8OwojcJEe57yKnnbiXG7IOI7GRDjQ5npFesDZGk=;
 b=eVO9nUryJ+GZzXGxUObMmVfAVOwgagAOxWGTvFy4q241JzMya1tjNZTm+Sp/ABnwvz
 v9VKTqj7AFADzCWhJRpa7Qa/fxZPYe/NKi8400LHrGafZDY1YE10zXY4ab3DCPxHg5ua
 Z70cN64V/ycGV23+bVn9b8dFg2bavGPLdHWFvtPaBTWXNPla/+fqCSoXsK+YNCffqy6d
 O/t0dlHynEbnJUKilpdZZlXC8TZzs4OXT19agms4IUmHzeDboJO2TpShoR52l7fbuaZY
 U5y0C+quscLEUupS5BPR7IdMQJ0BCCngkgBrGAs3TiZZIN1g0Ggalm11ocsfudnv+pzv
 m2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781888335; x=1782493135;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QcuD8OwojcJEe57yKnnbiXG7IOI7GRDjQ5npFesDZGk=;
 b=lK5I4p3ASoqLHJIk0/q0HaUvaCqiWXMZB2FLZjCBED25ZrwlWdEA+3Xh0xf4RgLvke
 HvpdrnpIV8yLOvgIqjIEYRKoXlYk3stb7xrOH8AF3dJSPUviDnCQkW+0qTyljS5lRLRR
 GEpSGB6yrL36bb8jgs+CN4LJhBh/2LrQgbxfNGCBl/WTEjwElRI9ZT2CmCk8kuICE3hT
 rpL7gsDzN73nQh4ZT74EoMOm3xf9uS0S6k3SFuXhQCu97mOPX0YYvbJuHLULcAqEnOAR
 x+gIgSmddFbFOo6Gv0aBIyts1vC03niBUakMpgU7HI0OK2Z0GlhvJuP95dUtLWb74UIt
 61jw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hnyX5CDsq3REeC5GXeADeAdB+5YioAPDJzGftpdRU21DTUfCj0+ll8L30/6sOPzrnHe4Bhj4jW58M@nongnu.org
X-Gm-Message-State: AOJu0YxtpsLuQSAb4Eq+Vk9qcCNwYzbSWDN4T/O1AEGK3rvBXhDFya76
 YEr2bH2GrEXCRdxbBVrJ0xBMe03B3aJdmTm05ghkrTtaFatHprCGB/mZiYVAPCJBmdKq5RAQln8
 QmviTNCKOizg2mcfpc2Qoy6RQPmnQsz/oErkNAA1rxKsLrFxtJHyVh1A9gg==
X-Gm-Gg: AfdE7cmg0mdUxb9Y3xIL43X45drRokIWkZ0zUQWC1LHEakTkplHi39dqK/o23Fuifl8
 ZH8SxccU4+ForCBlOXqXqJn/WolrC+o0GlB8dC4LkmJI3L1DBgdzT0tm8UHCCog1oHr76HR650M
 fEfG3mwCq/tkRrTu1p0CE02NoCkvxYVECXnDNuunL6c91Qj5OQbtxs9we7L8tT/yb+ujITvw6tk
 CDInp6/7KmKfhqBcNe+5zwT8bEXVdYdSU3MQeCXqU7effigQJHpopdtDRRVV9C+oV+Tg7cxDfcS
 3EG8d2HYlgxdJZ4eOA//tRxAugAzGi25MaqhdUh/Jfeq/LPXKpPDbRa9lh6se/xpuHRNP6ZbGhv
 zQ8aUedDtVQIOMOFWSedvOC8yXePKJj2cOpAcnsFZUU8OFqqA9Rt4xeZjYc35upZEKlHxtmNmLh
 rZsCY=
X-Received: by 2002:a05:7300:fb83:b0:2ea:edc0:4fbe with SMTP id
 5a478bee46e88-30c0d014cd1mr1736757eec.14.1781888334837; 
 Fri, 19 Jun 2026 09:58:54 -0700 (PDT)
X-Received: by 2002:a05:7300:fb83:b0:2ea:edc0:4fbe with SMTP id
 5a478bee46e88-30c0d014cd1mr1736744eec.14.1781888334341; 
 Fri, 19 Jun 2026 09:58:54 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba57db7sm315732eec.7.2026.06.19.09.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 09:58:53 -0700 (PDT)
Message-ID: <2bf91ea4-6e03-4f7b-9fdd-c60507e61516@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 09:58:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon/idef-parser: open input file in binary mode
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Alessandro Di Federico <ale@rev.ng>
References: <20260619042840.2169504-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260619042840.2169504-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lv4wqJGyvEvxX0zpMCWRIRcVGu_I6LpR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2MSBTYWx0ZWRfX8O0SAgawdtsO
 Shvdvnr0k2+7scLqhE9KEZFb0BU14qDA+m82fog04FQBdwpN71tZz0JGtSM9YELEEw8zc6Stofp
 dbWI14KYRdIIQXjhx2/XVREJ+/AGJAXDkZjxv6cP9UJGWaEl7h2BOLWzNewzI5EvTVP4mIr8+Zq
 GoiA0NlSlEzZKUABymdXkOrAotaZ+ryYDV/s0BoPo3lez39rfxyqY7C3g1vOmwz417JfkCLT42r
 FodYNuYM67PEsHKM8utB+3fTN9QBHCSUcPPV+2Q0LZNosH8P+Nk9p5k3cYRywvL7So518IYAZDB
 bYZ86f4PHms1kA1iZesAXXoPflEB3A9C47+0boJhT+bb+HfBkjFDl8P0XKzGpQgxv8vZLwvoOpk
 kFylo6LObfAwa/6YNrcDFmDnwEAtV36le+SBV9OaAJkZIxWgv5pW0+E61lzttHfoCYaBluO99vd
 KPIc0jkezsibolVFGzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2MSBTYWx0ZWRfX/b0E3MS5wZLf
 W/A25V0elZ79wDmQ16VcGAQmFwbsczUCpCMBuPoUXQ5VQolKhfh+7vfCMy0nE/JHbf48SvlMGkH
 tPi3vhgGybPKrywCVNoWXmkOINjpWa0=
X-Proofpoint-ORIG-GUID: lv4wqJGyvEvxX0zpMCWRIRcVGu_I6LpR
X-Authority-Analysis: v=2.4 cv=KbzidwYD c=1 sm=1 tr=0 ts=6a35754f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pE0qSxkZkNyi-Oj3SwYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190161
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

On 6/18/2026 9:28 PM, Brian Cain wrote:
> On Windows, opening a file in text mode causes fread() to return fewer
> bytes than ftell() reported, because CRLF sequences are translated to
> LF on read.  This causes idef-parser to report an error and abort.
> 
> Open the input file in binary mode ("rb") so that ftell() and fread()
> agree on the file size across all platforms.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/idef-parser/idef-parser.y | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

