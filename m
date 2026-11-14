Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B99606A327
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UukwlWuz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UQGQZbVE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSFDo-00069a-VR; Sat, 14 Nov 2026 09:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSFDk-00069G-47
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 09:59:12 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xSFDi-0006bo-Fq
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 09:59:11 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AEDjsid3173363
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 14:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jDUwkgEpWaGqE4dX1S/21Eud69lr8W+Vks2CT4jVbIk=; b=UukwlWuzBGSAthdj
 rM4bm1ZfdlRv3udg95zHY8Gd8A0AQd+aZApeYu84Uln9GNz47LYRHQ8aMHZwUddw
 610mr4f0xZ81LE8OwNt5XhfZP99D7qT91D9FzM7qcBq9No4NPtewVVGYsuTptlZG
 5zOSus+LO24k4UlhKKjzSMjZf+0SaPsyoZv6X5V0YQaQh1temZXnW+UYX9Kjw3bH
 Wn+4sfhVrUReWhUPtY5YqSMssW0iIYMYe+EcWof1V69ArZN1LJGM/zVn7IgJNiKy
 rG17vPOnrn7nvL13+9UoixNOYhKlg0X3tHnmKVv8g5ufWXLnOCSm/RjWkl+ovHsa
 2r9m0A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmhh0rn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 14:59:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b0a528ca65so1545967a91.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 06:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794668348; x=1795273148; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jDUwkgEpWaGqE4dX1S/21Eud69lr8W+Vks2CT4jVbIk=;
 b=UQGQZbVE0CEdG7UBBzggJXIsMFkisKGDlNfqPkJNYtbl1O9hmhGHjQLTEpLG++WhJE
 Yr/K8k88ntSOKhFGgBRPi8mfWvxOzd7Hawg8QNsGWULGK2J0ErQzqyT8XLEdIpW4CMrp
 8BcCQoGUNbIBEyI7sZ+GUFgIqPm1L+8SyzitPpd5OAdMlpJd3K+iUuBvU+k1LAYA58dX
 j9UHFRWn+aI1X0n35auBKHnvdcoDVAmf1lMaJBqvOc+9FkiSwtrGD7g69A3diLTl6WXv
 WraPEfsoq6KAs1jARP6TbQ3Rv8oGDGa6KlsLzYfl4Ie8B6aKNUaJvDrxVg79iuYPYN2O
 OfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794668348; x=1795273148;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jDUwkgEpWaGqE4dX1S/21Eud69lr8W+Vks2CT4jVbIk=;
 b=vzkDba1mlgp6V/IIcPG6iPYDc8VXzaXvQul2Rteay8o1fBOX6bQEUnB4/QeUrSaFU9
 wnV7glLXiRRjzOq68bgIBXv6//E33MmHJzPe0xp7nxQf3p2ThwNBHCB8tmtCb8Oi5d4H
 rpaXknHAcMz9jry0lGu1J5pug6Oko02oyaPTMuEN0/u5zKU8vD5GrkOP0QkIgLKiEFCU
 SduIoMfF9qeCitaJiVLvZP0RFmiHHq+xe638ZGqkeOBnP4fMm0G1Uor0+zV8iAS9uKJs
 mMf2cBXziA49dgIiOLgPSyfAiUOFRzZqhbJPXRXVJBxOxjb4g4Ieh42rtj76Zt/FHWZ7
 yK8g==
X-Forwarded-Encrypted: i=1;
 AL+hErG4oymJ3Qqt0gKhBdKhiozZFh7iwkj6+tqiKkMyi8vaqkSSrgB8IToXEEWk2xqFVAwkSD4JB8RXZXRJ@nongnu.org
X-Gm-Message-State: APuU4Z8APPmQEypwKxibf7MBX3r5PKDysxXbk2MA12VAdlNF0lYS7FRY
 Df94A9v64uaBs2FJWhCg1Z1ItpvxdTCV98odjRwiF6D6fmJ2gKqOOtFKLC02M9PPEk4Ss3QONHM
 5gOL4p8f1dCbQjZ9LRU7w9f1NVGx49MNX0xxbY8LR1zts/HcHgA1ZDHgITg==
X-Gm-Gg: AYBFou0v2b07es1XKkv/0W53Y2B+OMx83ChPL154DK1dvFc2XR4DDwbw19wb/6pOPNX
 NW1l4pbkzA96bXVZrN8k4gHL9zsgC3tcPtp2mZFEgnCzkzZ/ZPKeLSQ+Ejn6QSO2zrG4kdNtX0r
 fTyHcaQf6fM3oBgZ357hVjDh0ix+e38ZfbbO0JiKJXC8bYSkuvlFBccVAS+1CSqi5foJK1U08n5
 tdHL2NfzqVuatbkkd8YkXZvoDmbZpDna2mz2Rf5cD7bpK1iJ3ZWf/qXeMFxdYFtUifqnNswr4O+
 DpukTXBQednfWOL2A6D57u7OIRQPHb8JJO+J6MC0YMEDTG9A3DnoWjqV9F6G90P9o9B34M6yHLE
 FLk+POcpeZ1pBzk+cKsOfh5RMotIZS75fkGmVfYIByRdxY7q0UtTyFQ5d7y7yRTOsI4hBWkshLd
 Q+qx5x8QJeHur7CU15dAZ1jK9t623fQQ==
X-Received: by 2002:a17:90b:2783:b0:3b0:af68:77a with SMTP id
 98e67ed59e1d1-3b1b07ef475mr5424511a91.6.1794668347740; 
 Sat, 14 Nov 2026 06:59:07 -0800 (PST)
X-Received: by 2002:a17:90b:2783:b0:3b0:af68:77a with SMTP id
 98e67ed59e1d1-3b1b07ef475mr5424496a91.6.1794668347294; 
 Sat, 14 Nov 2026 06:59:07 -0800 (PST)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d0f497sm14328185a91.8.2026.11.14.06.59.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 06:59:06 -0800 (PST)
Message-ID: <e4a7622f-d87c-42c3-9a36-4e461199fd4b@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:59:05 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] roms: record the H2 commit in a file
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
References: <20261112173901.3748880-1-brian.cain@oss.qualcomm.com>
 <20261112173901.3748880-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261112173901.3748880-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OkYoylicb1VIU57-vdvQnT2_r74Y4kjQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfX/T9vwSNq8Df9
 dTwRSWQF3UZGwTFVhyAFDKOyEpHo18xA/JOvYX8Q9wEn/XBHn+FHWrNhfgBB3CZvsi9G8eGo2dL
 nXvytykXfP/TkI7EWkVY5lYbSLtH9dg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfX9v9HO1R8QkFF
 VTDIBzqh3rDAh8VHZgEaU0mdgT3ynz/G1NkRCDXm76wtCiU7xCgKUElHK2MpydZhQ/GZEnt2SqZ
 Cz5cO4FPBQQF9wnedLSgtWjnY6tABkaMj1ZAzjUe+OPpYom3gcb2I2R3MwYlphgTftRvquseEZz
 24li0MWdWkOXhuuVy7Kz7wvmcJus1cA5fCqIuziyij3tkUcBWSTRZoGJ8LSf1WYNEa08O7SGJco
 PUyCiIk7X1esJBB0yOvyKeXK/MOegxmxkQ5r2b5kTrdf/9KQORy1+OumQrrqOfbP3hlH4ynUf4h
 pz6TVIfM5IGOk7Vcq8/xkZjnJ3xmHMECt9uksBnt4Ztlg8cruOwTBa8/XpKTQVnByEgIXlXeMfw
 YqBGT+0zI1EonaVXolXWGGDI9eFBg95GIj8QnUKuENw6nM2bCShpzn3ZkZu/b/55kbrwcR6++m5
 0L9d8XyktEFC//djsGw==
X-Authority-Analysis: v=2.4 cv=e/2T2qp/ c=1 sm=1 tr=0 ts=6af8773c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ffpSfegR4-WdZWGtI_QA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: OkYoylicb1VIU57-vdvQnT2_r74Y4kjQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
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

On 11/12/26 10:39 AM, Brian Cain wrote:
> The H2 build ID was derived by running `git rev-parse`, which fails when
> building from a source tarball.  Leaving H2K_GIT_COMMIT as "0x" does
> not compile.
> 
> Instead we'll keep the commit in a tracked file, regenerate it when it's
> a submodule.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                     |  1 +
>   roms/Makefile                   | 13 +++++++++++--
>   roms/hexagon-hypervisor-version |  1 +
>   3 files changed, 13 insertions(+), 2 deletions(-)
>   create mode 100644 roms/hexagon-hypervisor-version
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa0c6d0c9bc..df264c30753 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1399,6 +1399,7 @@ F: tests/qtest/qcom-dsp-test.c
>   F: docs/devel/hexagon-sys.rst
>   F: pc-bios/hexagon*
>   F: roms/hexagon-hypervisor
> +F: roms/hexagon-hypervisor-version
>   
>   LoongArch Machines
>   ------------------
> diff --git a/roms/Makefile b/roms/Makefile
> index bae8f3b766b..2cbab2d1993 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -226,11 +226,20 @@ hexagon_h2_booters := hexagon-booter-qcs6490-cdsp \
>   hexagon_h2_loadlinux := hexagon-loadlinux-qcs6490-cdsp \
>   	hexagon-loadlinux-sm8975-nsp hexagon-loadlinux-sa8775p-cdsp \
>   	hexagon-loadlinux-sc8480xp-nsp0 hexagon-loadlinux-sa8797p-nsp0
> +-include hexagon-hypervisor-version
> +
> +hexagon-hypervisor-version: hexagon-hypervisor
> +	if test -e hexagon-hypervisor/.git; then \
> +		echo "H2K_COMMIT = $$(git -C hexagon-hypervisor rev-parse HEAD)" > $@; \
> +	else \
> +		touch $@; \
> +	fi
> +

Maybe would be better to always read from the (existing) file, and 
compare content to give output. With this, we can catch the "updated the 
submodule but forgot to update the file" situation.

>   hexagon_h2_common_flags = USE_PKW=0 TARGET=opt NULL_ANGEL_TRAP=1 \
>   	HMX_HLX_SUPPORT=1 \
>   	H2K_LOAD_ADDR=0x9b800000 H2K_GUEST_START=0xa2000000 \
> -	H2K_GIT_COMMIT=0x$(shell git -C hexagon-hypervisor rev-parse --short=8 HEAD) \
> -	H2K_GIT_COMMIT_LONG=0x$(shell git -C hexagon-hypervisor rev-parse HEAD) \
> +	H2K_GIT_COMMIT=0x$(shell echo $(H2K_COMMIT) | cut -c1-8) \
> +	H2K_GIT_COMMIT_LONG=0x$(H2K_COMMIT) \
>   	JFLAG=-j$(shell nproc)
>   
>   .PHONY: hexagon-qcs6490-cdsp hexagon-sm8975-nsp \
> diff --git a/roms/hexagon-hypervisor-version b/roms/hexagon-hypervisor-version
> new file mode 100644
> index 00000000000..4aeabdc7d0e
> --- /dev/null
> +++ b/roms/hexagon-hypervisor-version
> @@ -0,0 +1 @@
> +H2K_COMMIT = 23d5bde4313c1e63ba64dd5d7f542b1055188ef8

