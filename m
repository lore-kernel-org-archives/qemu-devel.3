Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21202C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woGHg-0003NR-PV; Mon, 27 Jul 2026 04:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woGHO-0003Kx-HK
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:01:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woGHF-0001ji-4Q
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:01:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R7SDW63004949
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V0JsfiVEcIwUtvwXqg5mL6blNEw+qcXQ7zZjwrMHLXQ=; b=XS1G/BdjNookyOWK
 GidREFNGSS2nRichx7sBABxOpxW1izucqTiwW9S3ZV6nDgtF51G9Zn08ZBR/kpYL
 InEni5Y4yxxLLOCZdMV4XuTrJKh6FFZamX10H5rTBgfoqHMB4s/X9V643MR9qoSj
 GHQGZTSNBzXBHLLaOzo5siB0x3E8B4AJfIOmlRKelur1HaFAvnxOY3EZ4lD2rRD7
 7nmpNxrXje7TpoqxQeBzdWlFnoGntQ7WcFk1AeE6qUi4y9MzCGJ2fJB4XnszNSYN
 SGED/4+iv1Jw8G8z3m9HUR68VhBfTvWIXui/QjW+PcoO6uk/N9FC/rpRpayrjUU8
 0Yh0Hw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fnsxs1eya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:01:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso48453121cf.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785139290; x=1785744090; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V0JsfiVEcIwUtvwXqg5mL6blNEw+qcXQ7zZjwrMHLXQ=;
 b=ID/g1uDih9iHKpYPT7kfKD552tUvVZD0yXpV3kke41DHckgihKZ2Q3t/aV96cdzzhV
 yaRbGa05OdTjdEMTLiE2hvIx91UTgRtpXFSpOG7MEeD866b5Q23hKmyYxRl6rdVrtoeR
 VZTyczrRWLyEl/nNHkv8Gpx623QZPEo+pGduYy9hiLyF8l32BxFF6P5M5srtW7OArIRs
 EAUXzWIbs05l71+nihXPaUJHRwG9HhdgP7M98TCTZIsqQFJBEo+ATeKNDCbSj34ejYAk
 h4R2cTMdNwhLw10FuvL8S7qTUi2Q+AUBwTK/vj4eFvwpDCnkyD6CVZyviDvdtKApsH5A
 DmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785139290; x=1785744090;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0JsfiVEcIwUtvwXqg5mL6blNEw+qcXQ7zZjwrMHLXQ=;
 b=oyzD1KGuSv45VKDTpRhwxoOfKOqFpmCkfiuoXrApzF1c/3R7hVJd3NVKngYs5MlRzx
 D3A4M/6a9082Wgyyc5h41Etls5+2nPsqToXG9zuPrwukdCipi/CpYDsRhJGZqcjzQxzg
 2fzg7N8VsrQQWp8REMKWWRWKvokskmelCjXdahh4D0wARsBZuODpewCJhcKloVZEW2JL
 FEWo0aIeBOW//mrIxyTVZZ1/GhIYnvnXwe9P9PiYIxAVIYSc0Cwwu2ZFvabxuGwNrtrU
 KUIS4LUs800TyvJoDG+jHdy3Ck8kruoOkyoO3Fe/WksQNd88d3aaiS6XI+K7fNXcCdaI
 yu6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYlvyC8nYbueI8jsbS6ATFjn6b3xOnKFAKdEp3AljAoVJ+b4Rt8nrwudcAHySOc/H/K6hb510AGGLI@nongnu.org
X-Gm-Message-State: AOJu0Yz2Tu0w3qzw15al5Ge6CJbZE1of/pkBz963nSHIcl+F+4mhsgsZ
 E/mUGU4eVuAcL9ifYIvi5iNwn3d24DaKLhZpcOqkLJVCTeYZ/uPmWo5A+UQzKcY1UmZbbneMl+a
 kMV+mz3ywhobKgV7rMh9a7nJuFau4adJq0l7Mqwtj01o5Ej9rtAH8iDMyWA==
X-Gm-Gg: AR+sD122pkhwgvLVqXDRwbFZY1lCigjsTQOKP6D6lJo9pK/6cB5BzkfBvAfMBASw22A
 KMQQhWiri2aTrVeJfINgNt1ls7ufNDpqjJNWq2IQ1o7OlRxnDeXp+zk37VE4+LbKbBQcvkVZ3E7
 E7cfAY5ZyVXBIgDNTdhpxmf/Y43D6N2dprsytC8yIHLtfykuokWVH0IxUv1mpZBtiB6e6A6zp8I
 MWMYWrAplZFsilUFNMbcHIDK319CVauNAIldj4KJAcW9nfL3pGYEJfCBvonkdBIQq2DBpaFu/Gh
 KcOjTrzYMy3Jylt+D2EnxcscHc+X+CCS5S7k2RussrzhmRG7On1WquZlER8XwVpLLM4lBd5nVz1
 OdjSglgV215nhdkdx2uKuKfm0Ht2VELvXQo0EV1JCAIL2BoTlYt8=
X-Received: by 2002:ac8:58c7:0:b0:519:e3e8:85bc with SMTP id
 d75a77b69052e-529a85f1589mr70534691cf.37.1785139289855; 
 Mon, 27 Jul 2026 01:01:29 -0700 (PDT)
X-Received: by 2002:ac8:58c7:0:b0:519:e3e8:85bc with SMTP id
 d75a77b69052e-529a85f1589mr70534491cf.37.1785139289448; 
 Mon, 27 Jul 2026 01:01:29 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4866813sm234571565e9.8.2026.07.27.01.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 01:01:28 -0700 (PDT)
Message-ID: <ebcff43c-1490-445e-bd07-ae497eb5af6a@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 10:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] hw/hexagon: refactor with hex-subsys
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, matheus.bernardino@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
 <20260724183648.190531-2-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724183648.190531-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3OSBTYWx0ZWRfX0yElRE2Lfqf5
 9V7r0w+gy4gy9eDz+z70YTZOmdc6IQS5APFiW2dWM8NQSq3V4kuxyfyqzHQ6pTAA3pTR4d2WOrD
 26aDDxqmGKHnj+4gIE+pEMIBQQj0/tnaq0g0ZV2WloSnRvuqfiBg+1JRMCSH6ATNgFb0Pm2Issf
 cUFugZKiFRhYA50R/HK9Ij4uhSperK58DSEocScrvR8j7Ttx6YSotequ+MMXz16X+eBDVgubI6/
 3DlWqzEb8BIUAQTJVnCJda/hyZ835w9GSnfddRnQibbrvn34BNePzv1+QMoFiB9uutM9O7Oycf0
 6arY3sIb0dnJQBxZswAl+vK/CfuSMbJ3F1rQw1HWjNh6lh1JLu+AK9X8bqdRdNZYT90HganMNmR
 9VccQEDLjCx6R0lucUViHka2Ln0plBGjycdP4ONRrfnP32w/1YTD2+DCgrzkYfrGO4c02i22bg7
 OSV+J57gi2xFcxgUDsg==
X-Authority-Analysis: v=2.4 cv=EYr4hvmC c=1 sm=1 tr=0 ts=6a67105a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=_atx-1y5uMUcDthqEDkA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: DjhRXQKD_SoYycY2RIgL3u9HArtuyp1p
X-Proofpoint-GUID: DjhRXQKD_SoYycY2RIgL3u9HArtuyp1p
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3OSBTYWx0ZWRfXwOUscUP1jzY0
 G82hu8IDWBLrGcDENWlNsysdZrJwiyvUDBT21HxyGrBItJ8gXiU6U/c8uz4V5X3q6aeno2Ydc/B
 UyrOh13VSNNkqceHZIxBhlsRpKFuY28=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270079
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

On 24/7/26 20:36, Brian Cain wrote:
> The virt and DSP machine models build the same core subsystem,
> let's abstract out that part.
> 
> The CPUs are now grouped in a TYPE_CPU_CLUSTER.

Too many changes in the same patch...

> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   include/hw/hexagon/hex-subsys.h |  24 ++++++++
>   include/hw/hexagon/hexagon.h    |   4 ++
>   include/hw/hexagon/virt.h       |   1 -
>   hw/hexagon/hex-subsys.c         | 105 ++++++++++++++++++++++++++++++++
>   hw/hexagon/hexagon_dsp.c        |  40 ++----------
>   hw/hexagon/virt.c               |  52 +++-------------
>   hw/hexagon/Kconfig              |   1 +
>   hw/hexagon/meson.build          |   1 +
>   8 files changed, 147 insertions(+), 81 deletions(-)
>   create mode 100644 include/hw/hexagon/hex-subsys.h
>   create mode 100644 hw/hexagon/hex-subsys.c


> diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
> index 1034b09c2ac..31669a829f8 100644
> --- a/include/hw/hexagon/hexagon.h
> +++ b/include/hw/hexagon/hexagon.h
> @@ -156,6 +156,10 @@ struct HexagonCommonMachineState {
>   
>       MemoryRegion ram;
>       MemoryRegion cfgtable_rom;
> +    MemoryRegion vtcm;
> +    DeviceState *cluster;
> +    DeviceState *glob_regs;
> +    DeviceState *tlb;

Each field looks like a natural separation.

>   };


