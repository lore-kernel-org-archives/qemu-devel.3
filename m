Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDEA606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fow8EiKw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qkdy8l0k
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPCW-0001nD-UE; Mon, 09 Nov 2026 08:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQPCU-0001mp-Vm
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:14:19 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQPCT-0002nY-4J
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:14:18 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A99us49550740
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 13:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xxBiQnnPlojfXo4JeIrzg1fqDknZtcy6Ut/elt4ntq0=; b=fow8EiKw6HAqNnDf
 pW05AWKrJC4lGZoTAvPtOYjX3eMtWblI5Soau4EKr/UF2BbPeO0R77PGRBoG/E27
 9e1Eb1LinSQZbmCbXKgUnEtZgDYGszrX2ZpEUK1Vzh3JMtJT2OExeHsDAnv05BA1
 QhXIhmH6CwtKQbs/0aZO69DsAVBnHf9CwTjPfzHTjBoY9uVAOsSt7g2sRBuHpKq0
 OFKvs5ukFetV0fbigC9ADLVA4zRpy4m1hqdFSBRQYitGZOBa4HQ8rfC1RItf7eJh
 Dzhpk/W8ln+vFS+FUytXPUhvxkPCXsvJhz2MzUenHENmNTDuigZEGkR2DErvxhgL
 N5/GWw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4htuqm38sr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 13:14:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caf7856ffso203523285a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794230054; x=1794834854; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xxBiQnnPlojfXo4JeIrzg1fqDknZtcy6Ut/elt4ntq0=;
 b=Qkdy8l0kwjg7cgUJqv0ELXVnIBCjSXz+lt48OPa60gmEydBi8BtbNi93H5vOjcpPZI
 0SwPXfrh5GFieAPW9cZqfBjh0hfpbBWmyv+LgzTNIcsLf08oJojf/bUXavE6F7oF8SD+
 8Rr8NhnK1Ztcnzl4MyE/el6KWfBpPKFlxibL2Tb4E5f2d7jwIx8LGHrJ60/DwZcfPq04
 9h2tgStLGv9iFeDbAVFUD6K/ckCHWVq64j1EIriSvT3FRoARoPhqCaew09t0zx1ci5nW
 n0mDtLVYv+Ph5xYx4gJht/XRhDxdoYpShZgZ7f1cEXYSpBEVqtvuqFraSWNdjM7dOAhy
 dz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794230054; x=1794834854;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xxBiQnnPlojfXo4JeIrzg1fqDknZtcy6Ut/elt4ntq0=;
 b=vn3y151vHnJGHus0f0LocxBawk5E2QgYWXZAKJMUdAeEc6dgJHf6WUcbYT9LBHOc2W
 Th7cIp7JZTBemIB/BFhO4DdWkdr0RqShO8dYAOqXep3taiMEzCakoV8QMK+hMVRMEplY
 jfQP4/B8VMEXQT6joLUuaKYWFfkMav2oYR8yPdr5SJ0pXTb2SU582M7a8Xz5l0EQ/IPY
 HFu58YMeEBvyFM3aBx4fbRkq+BTyqgexOIlC1w2soZyJWMi5eu4VoL5d2t28qy7M4DkE
 M/40vAHN1XPXt0knL9oVIGEXLOuoPsXQsCh/vNFO7Hdbgq4bcFMHzv0iJ+j+fBg/eEMf
 Nzhg==
X-Forwarded-Encrypted: i=1;
 AL+hErFBRGOgxgB8kVxPUf4sPLEYaEmWMRaqANCv97Qo4pC6tKZ7fpLRaUaL2GFFWgXNBbGknt9C/gq8sjO3@nongnu.org
X-Gm-Message-State: APuU4Z+bm1yWrgYtmY+fBoTxV28HZ2WffO1iEQjk/PXrWjT9vdoazgOs
 9nrSWoHCVecNkU188GRc2LP9QxMyf0SO1LAX0jW2ZB//Wnsgc8nwKSte6xvfNM8vOeEvokYJSo9
 BNi73QFBCCY4M0l11S4uqggeGlnXD8obbFRCz9kNOdD5lYOkbnB8F/ZHOrg==
X-Gm-Gg: AYBFou2zx3N/sSLxconCwnaMJeatFf2DmDOIVxGL+HMdcpnx4grJVsuDGUIFc4z9C0w
 Q+fQh8ZUDkqZo0By9IBFNgtjPIoWG1GgyvWXsA+3t7HhsG3SOLgPjICIimJyUMn/9lRMQifNW23
 ZeyTtY93C1rxPANNaLqmmslMsAXe0wiD6c9q/Ur6iQWQ1D+ocNsQ6LASwGYWl9rHaG3GRgKOVIa
 1sflM8I/M3KEIrHR0sGFUKYIkAcJ7Q+XlfzkQUxyQZ7RlHruBTKP35hJoQMspCxyO7k+0nGxtjm
 L3PDh74h8Ggfeaq5SLvdmUcFvU+GccI1ufv1LJdr5hApyAzlJwhAbs33O8PTrOiTj17EVuvn+gf
 H7mXDR7s5IkYb5H/hM9kqVKDT76ljPKbGK7OOSpWImYaRhuNg7FDZViyCLq5QyFABBy3YGucPRQ
 0TxWDOxWp8
X-Received: by 2002:a05:620a:4156:b0:93e:6f65:de63 with SMTP id
 af79cd13be357-947842378a6mr591571285a.47.1794230054010; 
 Mon, 09 Nov 2026 05:14:14 -0800 (PST)
X-Received: by 2002:a05:620a:4156:b0:93e:6f65:de63 with SMTP id
 af79cd13be357-947842378a6mr591566385a.47.1794230053488; 
 Mon, 09 Nov 2026 05:14:13 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94782ccbb7esm468412785a.3.2026.11.09.05.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 05:14:12 -0800 (PST)
Message-ID: <42ca8735-f4af-4c6c-9086-a230766e059c@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 10:14:06 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] hw/riscv: add CBQRI to Kconfig and build if enabled
To: Drew Fustini <fustini@kernel.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Patra <atish.patra@linux.dev>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
References: <20261101-riscv-ssqosid-cbqri-v7-0-92d1aae43e48@kernel.org>
 <20261101-riscv-ssqosid-cbqri-v7-5-92d1aae43e48@kernel.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261101-riscv-ssqosid-cbqri-v7-5-92d1aae43e48@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1MiBTYWx0ZWRfXyjgtnWdf51dR
 B05aYgMiLfoRPNdAg1Og0HzXR5YHZ4HSvVTw8oyXqgr4yA71iV4E0WAv8fdoy3Y6ShvDLZWePGZ
 WlB+xbPzXsnbE568/Qu1/XPvkPx+nbI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MiBTYWx0ZWRfX6EzrPE1NIJUJ
 NVULqhtjz9Wyq9pz2IzTu1GQLLJW5ZIkwLyFmzSyPFs1PpEGc4PH4vlODByaUmQ5WDbj2dmF0IX
 rJwZRMEoLpRVgDjO2szTWX5GndN6Yo6wxf3y0d9slGKT0rKNYAq21HMzHPXvXDV5OAbJMv2FR1X
 lWMSp+/61yoqCGrioLuk+NovhkRLvRHiQ0Q1p8+G+nwKo5w2nkh41NMHcYCS3pFWj6EUu6PJ+T4
 8qGUbKZfIR87hMF1f6f23ut7L7Q/ioOHPWnp82XpnTwUe4/yPNla9V/nJWnPN4dCoxBFjuFi8HA
 yeVXphx3S9jqMLO7eA6Ub1IOuoePMYrR0hNdE2OOr3CSRDGgwJSqp0HGbSEVv71ePfDipeeaOtP
 CNbD3aDhBmImWqnNSZUfILS6DmmhPKGrXu/GNJZ+cJevYBsxJhY/Z8DDa5AaS+b+49rXBavRCTe
 F+ZFFOERAc+u3KsR4Bg==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6af1c727 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LOtvnj7bimGLbINgQU0A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: vRgxh1K-HE8EkkOiK8wsVO0_PYUPRLPh
X-Proofpoint-ORIG-GUID: vRgxh1K-HE8EkkOiK8wsVO0_PYUPRLPh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090052
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/1/2026 5:25 PM, Drew Fustini wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Add a boolean Kconfig symbol for CBQRI and imply it should be enabled
> for the RISC-V virt machine. Build the CBQRI controllers when RISC-V
> CBQRI is enabled.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/Kconfig     | 4 ++++
>   hw/riscv/meson.build | 2 ++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index d89fdfcc8671..98bdebb4b814 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -1,3 +1,6 @@
> +config RISCV_CBQRI
> +    bool
> +
>   config RISCV_IOMMU
>       bool
>   
> @@ -68,6 +71,7 @@ config RISCV_VIRT
>       select PLATFORM_BUS
>       select ACPI
>       select ACPI_PCI
> +    imply RISCV_CBQRI
>   
>   config RISCV_SERVER_PLATFORM_REF
>       bool
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 6bdabb954473..c7952d67755e 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -19,6 +19,8 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
>   	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
>   riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
>   riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_CBQRI', if_true: files('cbqri_capacity.c', 'cbqri_bandwidth.c'))
> +
>   riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
>   riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'))
>   riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
> 


