Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EE0C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 05:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7R6A-0000c6-Cx; Fri, 18 Sep 2026 01:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7R68-0000ZR-Bc; Fri, 18 Sep 2026 01:25:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7R65-0002RV-Cx; Fri, 18 Sep 2026 01:25:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2VRoR042714; Fri, 18 Sep 2026 05:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jdOPEA
 TbwkgKzKNidqrzLfqSf0l8YEhArCf80vSCbXM=; b=UAZOTOn1wWRxSTupO8trYt
 VLQhYWkrOxHbcIWk+ixjhOD9OGeFAh4RdSTGApqW6JuOimum6AHOnsjKRfFYcHbp
 j1k92KKrWF1GUhNLwqUIe3fvBYwc/r85d2/Sdk+F0JUPb8Cusm+17eCVLBEbXD7A
 lmGrJlS7HCnca6H/nxQ3daU8y6k+7aGmgLtmRtchAFzfWfCZIHjBOqqkwTDyFB3Q
 Be1i7NeStg0wNfU4We5XkLVHNlQoV52O1uFgMpIpAXhwmFT89WyoL4fr1Iw/q4a3
 k5Kw7lFFQbfyOhX+8Hnvqmh2OEPFCfCU6LFFY+Qhi9W36f7x3/u0o3OS0T/MNugQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx846c5g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 05:25:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2Z44l4128813; Fri, 18 Sep 2026 05:25:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fcy9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 05:25:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68I5P6vi47841784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Sep 2026 05:25:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EB662004B;
 Fri, 18 Sep 2026 05:25:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70E2920040;
 Fri, 18 Sep 2026 05:25:03 +0000 (GMT)
Received: from [9.123.2.177] (unknown [9.123.2.177])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Sep 2026 05:25:03 +0000 (GMT)
Message-ID: <faa52670-30fb-480d-bad5-d2962aec9f0d@linux.ibm.com>
Date: Fri, 18 Sep 2026 10:55:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/8] ppc/spapr: strip OF path argument suffix in
 path_offset
To: uverma@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@oss.qualcomm.com, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net, avnish@linux.ibm.com
References: <20260817102733.605346-1-uverma@linux.ibm.com>
 <20260817102733.605346-8-uverma@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <20260817102733.605346-8-uverma@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA2NCBTYWx0ZWRfX9bDGM8Y/+K7X
 X245Zgq98niIqsz5C7RUiMxViT+ljDJV/Adju2xadJyv57bTZn1GuIcgRacHuXBcbWCscbDDy1z
 L4NkNy9re9Xwbut9y9XsQlVDL9eiQKzJE+EYiOxW136O80H/UTGu+QcPgyfqhA1g6nsIFo+D0et
 YJyh6sJ4TIqqvr2HX8s2ucZmgyhE6YyWMunkD6+n+0UTxSejz+gIVMU8DsCg0k5IAAFEVzMYisz
 BSWCjktFoWzwJgDctyJQyvv0d0bzImiIPcJOTLfYWwdiGUY/G22THiAXDnpjDRuDhn/FzbF28Pt
 XA/9YcRX2y/IbFCliDb2iHf/UsCw8Pd0u+rW4TVp4wnAE0YxgTl5/hzDBsBg1zEBPYUfHRuKUM/
 gm4dXJHEo2ti9EN9ZIFHn0mXGwkewPhCteKQrVDEGnRd1anqSb2wGf3Jwz0X2qsdcsQ6u/9f/Ni
 kbl5YAJGHxs0G1wsCug==
X-Proofpoint-ORIG-GUID: VydFpNziMdV1EnSHj-SG9FGyBHBwSdtt
X-Proofpoint-GUID: tfNyIAGDyEz9-495z0E1Dfvlg-5MZElp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA2NCBTYWx0ZWRfXyuODt7R5M/dy
 S3AZtobv4emwpTOFXFJqfnKXI7RlXMBf+xIc4Do+rxXxEHWnUV6AvwtfInwNk5Yt+T/Q52fo+WC
 ylI5pthV+REXZ/XAfLYApp3SIhvnocM=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aaccb37 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=gEfo2CItAAAA:8
 a=VnNF1IyMAAAA:8 a=Yvm-aczM9p3Ow2khW44A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180064
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Utkarsh,

On 17/08/26 3:57 PM, uverma@linux.ibm.com wrote:
> From: Utkarsh Verma <uverma@linux.ibm.com>
> 
> OF paths can include a ":argument" suffix on the last component (e.g.
> "disk@8000000000000000:0"), which is an OF path argument such as a
> partition number.  This is not part of the FDT node name and causes
> fdt_path_offset() to fail.
> 
> Strip any ":<suffix>" from the last path component only, leaving
> intermediate components untouched.
> 
> AI-used-for: code
> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
> ---
>   hw/ppc/vof.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> index b1c574aabf..d3b0df30e4 100644
> --- a/hw/ppc/vof.c
> +++ b/hw/ppc/vof.c
> @@ -142,6 +142,8 @@ static int path_offset(const void *fdt, const char *path)
>   {
>       g_autofree char *p = NULL;
>       char *at;
> +    char *last_slash;
> +    char *colon;
>   
>       /*
>        * https://www.devicetree.org/open-firmware/bindings/ppc/release/ppc-2_1.html#HDR16
> @@ -151,6 +153,20 @@ static int path_offset(const void *fdt, const char *path)
>        * suppressing leading zeros".
>        */
>       p = g_strdup(path);
> +
> +    /*
> +     * Strip any ":argument" suffix from the last path component (e.g.
> +     * "disk@8000000000000000:0") — it is an OF path argument, not part of
> +     * the FDT node name.
> +     */
> +    last_slash = strrchr(p, '/');
> +    if (last_slash) {
> +        colon = strchr(last_slash, ':');
> +        if (colon) {
> +            *colon = '\0';
> +        }
> +    }
Is path_offset() guaranteed to always receive an absolute path?

If not, paths without /, such as disk@8000000000000000:0, won't have the 
suffix stripped. Either document the absolute-path requirement or handle 
the no-slash case as well.

Thanks,
Narayana Murty N
> +
>       for (at = strchr(p, '@'); at && *at; ) {
>               if (*at == '/') {
>                   at = strchr(at, '@');


