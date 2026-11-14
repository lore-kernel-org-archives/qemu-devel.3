Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E623606A329
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RXmI7JTO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z0kQqPbi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSFA5-0005b2-Ni; Sat, 14 Nov 2026 09:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSFA1-0005Zv-6b
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 09:55:21 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSF9z-00039l-Lx
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 09:55:20 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AEDkwwf118002
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 14:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KF8il6VPHoIL+B20ag6mrMLmQ4AsAoPnLRfcbVT5+UQ=; b=RXmI7JTOGQQfqx0H
 aIfMxYnHHvLr8WQYaH4zPa7nRlCoSLZfiTto7JQ7MlYRXXq0cfPRUMwweTypdcLo
 13NBfbFNj/BS99gE9AZCUqF00P43+nWG5jVFDno7muCOj0CcdLyHoDWd4de5hoL6
 wLk3ClzU9t32OrP9sjSho7xTw4D/n/ukCfu6CT3+WXneUJgrEKCuNXJz2EMWmLTX
 JxY+seneOYF7q+SOJ94aGLCF93YkJhj06wGMb2dQKDifbj5arlhQLttGunHjslyN
 lUPYlg/dfKOhbYqb9GF3/sC44Z2sl/uONjU3ogTK0KmtMqUkeX7aQfNWvKGFdfCz
 4mAo5g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqh1rh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 14:55:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc4216aee8fso2342157a12.1
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 06:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794668115; x=1795272915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KF8il6VPHoIL+B20ag6mrMLmQ4AsAoPnLRfcbVT5+UQ=;
 b=Z0kQqPbiT8AseOrKG9FEvCSNlAzPA90VibQm2IqUckyuNVTxz4qduCAxT1JBoAXrgM
 ga9Snx239hxo3OiFWDn4ZNkZFh3bkCLVpCFHt0wd/YzkGSJedRvimP1UO8sSBO6SUQSZ
 ISIinorAN8iQE4LhoknY4l3b6HQX/f7dSAx4MO/V+tSwYRKQxvVbCC+eVpSYgjhEOAgF
 yuq81hPbN0zp0AtifyKGg8GAoQyLlyAXRjxVAZxo8HE5Aen8iZDyc/QOkk+Xn57zolEy
 0VrzSBrjhyZke1oap2SN9AC77edrlbLSI1QErZQh15/paAD/1lp0DLndvl5j5T16ks+V
 VBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794668115; x=1795272915;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KF8il6VPHoIL+B20ag6mrMLmQ4AsAoPnLRfcbVT5+UQ=;
 b=Qz/eop+y/c/ugZncemEyiCYcmqKpPSD6gC84rib4CdcaU4rgcLyvt8yAY6Eg9WHyVJ
 T7quc4ToU780K5C0VCcfCPSvvcpvFU6quCObSNPzy6iucQcfIrDPQiJ7byCfaBLqHljT
 NnDrKzo7fZuVVhaqo/O/Fhb9RPyiwCqvgo2Cw+lYt6mDSNmQ1e0XDpVA+IpAftJjv0FX
 ILvjL/jmpQ5PBAInhnmsZ7OK24c1T1wZpZswTyWC/9gFBeWxw4QjGKPI56W/TfzOahgD
 1c5DmpTXEFbcI33UVhyVlhp17IE5kP45upuKgCAcheuji8AcVI19m9SdrGVO2briWf8W
 CLaQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFOE6R+jryeizZQYyrc1GeZ2xwbMexTvX89n7odXZFkXZvwsbO8jE1f1lJY552MKk0eIoXayPqh3THN@nongnu.org
X-Gm-Message-State: APuU4Z+043Kqz4ysgI9ri07Wkl71oUN02On/a2rk5awK1d/PCirbVf70
 tY94a5Xn9tbiQqjMa7KtmFHaCs64dFvsUwzR4oh1vZAv9UADtNSxay5DI8FD7177ko7/S8SaWsw
 tp2k27moZxPMbm6TWRu6VsulDlzqNI7qWhenwMEYs6J+q2NVQCqikMRCmsg==
X-Gm-Gg: AYBFou10PeEvoi+tlN224ww23WlnPid7GfQIjz+6JquFCDCrqt+Coe0cIrjEkm0CIAx
 YUWHI9pQv0NqAoolWVHCpL+4gMmH/lAXWftK6qfLDt8V8bKdfSvEUnPvwcPMc+78khc5q2c8NyK
 0tQ5lRB5ZK5FF0i2g+HxLAtX/zor/jpn98/1E6SAbzJUVIaA2zNkbM9y0AJCJU5EdrW1w8vXvIm
 Cu4UF8ttR6vtfx/+7+7KHGOi039GZ+tAMfD6eUJye6ALiYQpG1hK9bLv4NYHYS0d/gEKXTXiA82
 VwMUlIMVi05PHuen1EU6Cn5b8AJFok4+/EsA8neZ5TbHpiYiYbLuM9IwLHDD6h2tCUgaJRgZy2l
 WnUVAAzyshGPjXfuAuX8XncHh7a4a8W0vVwx0VNxbV6MGy44p67rrVsm0ST2NemX2Cp9Gi9rkUz
 POM1pSApAunnJ/o0pYc7QWZ/GCOPyTsw==
X-Received: by 2002:a05:6a21:3d86:b0:3e9:290d:9774 with SMTP id
 adf61e73a8af0-3f7a74c350fmr4339584637.44.1794668115530; 
 Sat, 14 Nov 2026 06:55:15 -0800 (PST)
X-Received: by 2002:a05:6a21:3d86:b0:3e9:290d:9774 with SMTP id
 adf61e73a8af0-3f7a74c350fmr4339570637.44.1794668115051; 
 Sat, 14 Nov 2026 06:55:15 -0800 (PST)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8bed2d0f473sm2117898b3a.53.2026.11.14.06.55.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 06:55:13 -0800 (PST)
Message-ID: <5413509f-59cf-4492-86c7-4c5a5ccce715@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:55:13 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 0/2] docs/about/deprecated: minor fixes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20261112093824.2281467-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261112093824.2281467-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KvDo7yKaq2_BoHIUSCx4cfGx0QVx9cY0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfXwzXJqv0C9ewV
 yFaEPX8ZRWY9Ls+9Mc6Itm+Fuo8tiHdJ6bIertZz7fNyBUUxrjVnF28HZ3ur6/92nAKhPt6sfy3
 0HFOFHpCl06bwhSqstvjSl0FCuJqPukTtRvn1U+hNN9VQc2B2TNDLT/2Q2wiAYVoaWC451dCAEh
 vOdvf1/GI7V1oIYn/7mJevHuMfgE6uW1R8ofjKQZ9DvI5Mci7DTRgHH2me7vKO213xap3FmgPzs
 YuW+rsG10vhBwWC6tCoQL+AemzDSB9Tn6Hx0wdwJTWpWDsX/osOLSqCNdpgVCfZPy02DxuUQVSb
 yvjtFnr5iVWcMqb7v7l5Yy/smYCJ7ojHV+e8FcZ3OG4qi3fwndG4utfJM35tSUYP+0Av2TnDm8N
 6P/H/seXkQEhOGj97btCQMPrGclf4y2UX0xOxbbzLcN8+xT/fBlujbSRuQEPqECcn8G62MfaOPu
 jIzXC+fORubjpHqBzJA==
X-Authority-Analysis: v=2.4 cv=TqJzFzXh c=1 sm=1 tr=0 ts=6af87654 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=FBHOFjIeNngc2ybFw-MA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: KvDo7yKaq2_BoHIUSCx4cfGx0QVx9cY0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfX6EQEsffK76jM
 4fRLTtJsnJlPJySU8oaNCxtaUk3wwR6KhqEFv7yoLRn9MxiE9khsKFvKIpKRVsSUsjHwDTM5eIY
 BUGOs/MHtovaa3zrLEl6rY6Vm8Nxc64=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140059
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

On 11/12/26 2:38 AM, Peter Maydell wrote:
> We (I :-)) forgot to put in the "since 11.0" tag when deprecating
> linux-user arm OABI/NWFPE; patch 1 adds that. Patch 2 fixes a
> "wrong kind of underline" formatting mistake I noticed while
> fixing that.
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    docs/about/deprecated: Add missing "since" marker for OABI/NWFPE
>    docs/about/deprecated: Fix heading level for AF_ALG heading
> 
>   docs/about/deprecated.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

