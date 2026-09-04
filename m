Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D65C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2REk-0006ba-7j; Fri, 04 Sep 2026 06:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2REi-0006b1-5l
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:33:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2REg-0003TD-JS
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:33:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AIZb13783251
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 10:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pd6Wshv+Hsw6Cr7swhXbwYb8OaPGzzyJwNsYKTWK8tM=; b=H0f5NmcWnGM2WFeh
 OC0gc1+YmYMhhko8Y4esNpY2pib4PGr0rLIzLwN5C7cGhWRBBZEFBuvHG+tKtffQ
 8UAeCPsSdbGNg+B58Pucm+8LkChVF4u/KIcQvqNLJmsuSgQwl6D7z+hSbC06uPm0
 zuuslzRZpGZ92uN+QJkbZ7L3FiiSA02dfhyDjJESWpVdTCpefDJif4cT48be/YT/
 o+vBF8tQmSaAMWIKQQs2QnWnRIKWh3+ptdszZFffN6iSFdjQsml4kf3hVTx2PRS6
 47+gA+Dtp72wk23ZAgykKPXZiq9Eg5w1JDU67xqb5tMGjimTT9sXdW2pjwvRGSNJ
 u4zpBQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfhc9t7cx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 10:33:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939694871aaso147584885a.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 03:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788518008; x=1789122808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pd6Wshv+Hsw6Cr7swhXbwYb8OaPGzzyJwNsYKTWK8tM=;
 b=bWu07b4wITyARkIImRSW004Bflw7jjbw6JPSmVc1RnWIU5in8UdJHAauSgGHWKVFd9
 j+/qqiw4sB+zTtMsC2gCTn6mLhck1Zb5LfYQ8vmi3zA3zIokGKNjJZS2Z2wiAUe1ptio
 omR5qQmXwS/QcqZkfWlQKz6Qc1dFrtmlz6lQ2MkhYSdT0KB4H9KcZE5MJLE0bs/dLBJB
 PcaGAyjypd2ZaBrkfKBKGwFgUd8f4oovSkCZ5HBNy5xLo8CFvc5x5bYF7as1mAsHMA06
 9i17Tqh9JY3u/lzMskYf7ZhJneJtV0Xcrsd46va1PdIWX5sJAMlDkUDJOwkD3hk3tmFZ
 6Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788518008; x=1789122808;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pd6Wshv+Hsw6Cr7swhXbwYb8OaPGzzyJwNsYKTWK8tM=;
 b=qHi88dyhaRGQgOG/q0EJosgrCDRK74L0+tBsxf9qcy/SqqCVLjfURkM+P+03tMCqvM
 h88MVCGpHjGsLDqb1/yAKZSyq+Eshbal6mZhtvrVDHOTObOLRVvAcTfkCok3SRoVcVJ8
 fyI+R+suDYHKKPt4lew0kUvzKrIg2qTnAqqNUlZpK4W3vItqiLCe2daXiTAJeTRhe9Mx
 mDi28/otIlYMDiBFYqXojUNZ0uiuCTTxl612Z5yQmfKLKFkAKyatLfQtoSD6wlwDD9gX
 o6I5I+VQRZSappXkRXlPjzXbdyp+KjpCmzUG4Hwkn7hI7c1bJEDe+HJDvADEmQIi16EJ
 PkgA==
X-Forwarded-Encrypted: i=1;
 AKwUvByxayfkHPElXREC5RnGoU2pf4tM830HO3isyC6rMenUtt6eW0Wu38Zs6/ZwtEZYiYz7F9wwpdoppOEe@nongnu.org
X-Gm-Message-State: AFuF++nmwS6zdZNufTpWByu5uUOBJ+jtYJKV879Egu4HmPMOb1SFA8oC
 FEQ8QptNl35md+5opqqzyNu/kJB0PST/GSRYCnw4CBoiFo2ocj01k+TuCgardxJesaJ5O2Pkw/u
 APXd1apH2RSny9brkYP3O8nSnuMH/AfZrqLf3i6++J7RCZn8Ze4FgdEAa5w==
X-Gm-Gg: AYBFou1SVJ3Lrq50vmOlAKKh/k4j5FzbTjl6CJjzmbRkuXQ013D+c5RiMP537B9wRD1
 dKBKomAOPtpQGZH2humNHKjE7PKoSHGlg6FJ8zLpIvO6TzxtgDhlRui6RsqstWNiITTpEWoPAz3
 xauGfs8W+mZnXCndPhUZp+H6xnn7aefR4NZHKWPdr0dMPJJKDdHVyVNVOA3JM3ujY6CorteS7AF
 1KLbQBDwD7ZSgm2FT/1+mko4SRzdejQYs5TI1JuKjLpGn1n1sk1Ti7m4vEeuh3kZAQkWPCICFKP
 +tIz1VU/CZ1jHhFOkyWR0OuYb6CTpAtPYnNCZtfWZn+8R3r1DQdIKX9czykv8KunTpn7030QXft
 xeXEZ26pQ/Dcj/iE5pqyIGmQZVmFHSHXx3Q==
X-Received: by 2002:a05:620a:484c:b0:939:df7:6ce3 with SMTP id
 af79cd13be357-93980407102mr379383985a.26.1788518008301; 
 Fri, 04 Sep 2026 03:33:28 -0700 (PDT)
X-Received: by 2002:a05:620a:484c:b0:939:df7:6ce3 with SMTP id
 af79cd13be357-93980407102mr379380885a.26.1788518007687; 
 Fri, 04 Sep 2026 03:33:27 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cc7sm62560965e9.4.2026.09.04.03.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 03:33:26 -0700 (PDT)
Message-ID: <63513430-7bd1-486c-b693-49d1076562ed@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 12:33:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] target/hexagon: fix HVX scatter/gather
 region-length check
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
References: <20260904012233.3607547-1-brian.cain@oss.qualcomm.com>
 <20260904012233.3607547-3-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260904012233.3607547-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=afdRWxot c=1 sm=1 tr=0 ts=6a9a9e79 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=2bFn-c_Ah4cCAZ-Ly4oA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA5NSBTYWx0ZWRfXwWvKUjR9Gnwy
 nbZj6sKl3R4WDd3W47H3ZF4JsnJudAVNnjNj89EF6AD1NvHFU9JRoksKlkGpwbzHSSEa/nJ8uaZ
 Fw0RWaBt8efut495kugDJWaCVbzVO2Adj2baQTLIDnEN2w283sINm0tvRGV+w+GwwH+GI6pYP0u
 PM97QRPqSxcHNAzcHw3RhxxA6NH5lYBPgXSo0Xu0W63zffikdOLeq3My6RvExJWmvDbFri6LHKp
 hG3iZ+PNNZIH17n3Soc4wwi9tFKvrE7JQMhuqdj0WuL0MFHNEDOhXSxrHRFbXNi2EdzSyI3p40p
 dlM5H0FJokWO7cSex0O6f3QXQEhLpNX1k6ZhmrKreSzTS8FyDlKSGESVBMXKDJ5NXzXDchRNANg
 eoATTdfYEQpQWwP2sgaToWeieiWfUij2CGmiaTmWFe3h+MqcgzEvKaESALw47bfxekuEhMEGd8B
 gyOomyhaCDf9OqIy+MQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA5NSBTYWx0ZWRfXwn9hyOUCERK7
 2myeI7b+hE7fUYf/BiZwmB0/a5G+J2leQWV5UawCnxoWnirWZTXpklXlwnZ02Ga2vbStgp9nFUQ
 ccSmuuVehS1kYQgiViLRT9izLLxiIFo=
X-Proofpoint-ORIG-GUID: jVNDy7BNVVfVmxaYlh-6z0fJi9HUERok
X-Proofpoint-GUID: jVNDy7BNVVfVmxaYlh-6z0fJi9HUERok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040095
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

On 4/9/26 03:22, Brian Cain wrote:
> The region-length bounds check compared (EA + i0) <= (EA + LEN),
> which reduces to i0 <= LEN and never actually depends on the region
> base. This let vgather/vscatter keep elements whose offset was
> beyond the declared region instead of dropping them. Compare the
> offset to the region length directly instead.
> 
> Only load bytes for gather lanes that are kept. A dropped or
> predicate-false lane must not access memory and raise an exception.
> 
> Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/mmvec/macros.h | 31 +++++++++++++++++--------------
>   1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
> index e85beed3387..858afd995d9 100644
> --- a/target/hexagon/mmvec/macros.h
> +++ b/target/hexagon/mmvec/macros.h
> @@ -130,9 +130,9 @@
>       do { \
>           int log_byte = 0; \
>           target_ulong va = EA; \
> -        target_ulong va_high = EA + LEN; \
> +        int in_region = (OFFSET) <= (LEN); \

I'm a bit confused here (and hopefully wrong), shouldn't it be
(OFFSET) < (LEN), otherwise the byte accessed is out of the limit?

(pattern used multiple times in this patch)

