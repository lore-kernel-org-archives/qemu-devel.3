Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2B606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hJXlsX6a;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VBgCa2bJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT57C-0000lZ-KN; Mon, 16 Nov 2026 17:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT56z-0000Lb-Da
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:23:42 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT56x-0007WE-UC
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:23:41 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfH982589580
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YC4v6Zew/6WokAUPz6W7Kan/LlUOmvwgNs1ZfUn0OXs=; b=hJXlsX6a4PxtBmdi
 u3ypYnTCd9JsA1S9lLdqNxH9JYjYOM/nt8bDNGnr+huh/GmCjxGCZry2IXMTR/ys
 2tUJkaiidByme/zrrFdzAqQOAr1bDcxgB26AUrCKVuxE3yvIRVa2wkGJTwwJqE0B
 e902J+eBgEjd8LdiWKWZxC9GgOgb9Yxm+qqWorUch4UqwKwJ6oIuBwUZZeR3ix/p
 6nbl04LWNIihFIhbdCOTMOWgK2uLwalWIADNtU7nwvKz/413QMgEdDYT8WRkI/wK
 RER9Ez4jWpsHqYAK5yycvci+GKgyA/m6PHsWyiOt125sAfRvtaR3snyz0BAkiJVd
 6n1Kwg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2k2bw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:23:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-920f97bcad4so9859536d6.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 14:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794867818; x=1795472618; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YC4v6Zew/6WokAUPz6W7Kan/LlUOmvwgNs1ZfUn0OXs=;
 b=VBgCa2bJJxv/zzhx1Uno/m5MWBhK1dWRMSCdnbdWyTO+aNvl2VnTOjd8RKFC6kRzLm
 c2i9VVAqoUhmD1oGvZunsuRwy7Uu/fpYbIPf+HEMCfky5Ma8o8nuf/G2w8iFtD+vJChb
 2YutaMrDQld6aeqDJykQH8ERHB2KeL9gKmYu51Ayg8TxFZDes+GlABCXiUNCtH51j8we
 CRgKqmsSSuE05q1j6LO2wRgMQ+69rniWF6j0S2btXk3Nx2XLVzYSWjpQh86h7fn/YMNR
 b1CjqSFdWVpSXZYXiOM+0aO9zcjk89OvOECzUeLixmdscv89FEe+8E4QlHnyWo6cmhl1
 PQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794867818; x=1795472618;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YC4v6Zew/6WokAUPz6W7Kan/LlUOmvwgNs1ZfUn0OXs=;
 b=bJdOviVQMhjy+YF1UMXGVvJT8SHRp3OLD8EKDKYYPWpTBIIIygMTNSqY0cH7C/mZnY
 Q74lQTtQiZ/yR2ozDxNh2zKWJ4B/jk8BkYZJzMe5AID640n5wkZ9Ggo8RUnPWeWycBgB
 8JuBC40QKTo4LuNHMNIA8gVJsNnxIjzxSZOm9QzMBXLoQ2CkwkOWOGGedMOuP7lfOKjt
 hqc6hiP7ePfdTiJCCVaIxqF+iEdfDSEsAxh7bgqouXriOxp9yY9M32hH7JifYUhKztcL
 +vHUR+jCMOXW98BEhLRsePV5v6c2VehQDqFfeUjvbW3u4zjPLUGH0CFQ4Q6q30NSWuPc
 YUxA==
X-Forwarded-Encrypted: i=1;
 AL+hErH5hiCnXY62Z5kT3a74Qnwp0PzEmyJstOmKief6m8ltg2n9gwbICju5oobQ1xcGmPMmaSWlvW5V+9rl@nongnu.org
X-Gm-Message-State: APuU4Z/R20K/fjuPqySaW9zPUHykdQlnxLG7BgVXFvBe1RqlYe8z/omf
 BVztsRfkz9ZKtWFutXN4LMPocWRZV2oW7gbT4tCwMaIBlrgwNchTv2/KWXqrm+zST1DLKGgweDC
 rvcBmO+U7WztLo8djkjiD73pHykf4d6PU5d34ZtyOILwbtOCnhyopFPn5ng==
X-Gm-Gg: AYBFou13tq/93Ngkn5Ms09tgIHY+4q2t4UdUekBDDLQHLYI0PpViDO2LaKaOxqv2ltN
 QQMfUxMx/COv8PNMRGKdPJj0oc4w3bq50bR/vkErm7rm1EtKqo2cyIRhw+VJXUz+6qFZpEDSC6D
 tjC25re0b42QNl+xP8jc69+LHsnMrLaTehAX0/ASPSyrtcbYuN1CF6hfl+Zjkb+Bam9tlSFIOIf
 VFLPqgRR1r7HouHLo4i+d768on1I0+Njg1TpmN+XhRGnnAoY9jSqF4zC6Y+xpQrZ5cVVhEeHy5e
 jaeCQV+WSK+AiCNA4qLhroFBMRm8dXRlqyDgXFLfvWzRFRancGMbLHSY70IUdXF2i91Yj3dtHCo
 brFc50CL27DiLiaJxynPtUTHS66Q/Unk0Sjwuh9GFds5ISmWrpDFFTJ9fE9av7kk1ZLq8OXBoXM
 BmC/B7DLw=
X-Received: by 2002:a05:620a:4611:b0:93e:c12c:f11f with SMTP id
 af79cd13be357-9494bcda704mr2056769185a.75.1794867818057; 
 Mon, 16 Nov 2026 14:23:38 -0800 (PST)
X-Received: by 2002:a05:620a:4611:b0:93e:c12c:f11f with SMTP id
 af79cd13be357-9494bcda704mr2056764185a.75.1794867817337; 
 Mon, 16 Nov 2026 14:23:37 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d03b104sm25199906f8f.6.2026.11.16.14.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 14:23:36 -0800 (PST)
Message-ID: <2c9704a6-b0b1-44b8-956b-d7c877621c46@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 23:23:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/block/m25p80: fix write enable latch after WRSR2
Content-Language: en-US
To: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, alistair@alistair23.me,
 kwolf@redhat.com, hreitz@redhat.com, clg@kaod.org,
 peter.maydell@linaro.org, jamin_lin@aspeedtech.com,
 kane_chen@aspeedtech.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, bin.meng@processmission.com,
 tangtao1634@phytium.com.cn, Chao Liu <chao.liu@processmission.com>
References: <cover.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
 <0c80a9c01452a8695b46a6d9fa920f9a14f4de47.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <0c80a9c01452a8695b46a6d9fa920f9a14f4de47.1794558546.git.w-yf22@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afb826a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=4p6pNRT08ujvsq3huYUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4OSBTYWx0ZWRfX32dNZujpvK8+
 98Fmu8gvBmfDDswoUIcZ9GoNNEfHlqhsHH9IioAi+co0kA6/u3BkzeEGpg0LPVAlmyBJWSyYjkT
 dDl/yCp2ysVYZBdoJeOua1MVbY679AE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4OSBTYWx0ZWRfXzTNGL99Fujx+
 iq/nZ1wPmoSrbLW1zMQFcqlke/hFNE0vnAhAQgr4BFRckeahGELMa+YHjosBaroe+MMFscYtjrE
 84MSB83k1YHvmFzYkcU+/cRXEJV81fmTwrUipZW5LQEBiMMkcZqKC7xmCn0/gKZGUFIOrogjd1X
 e+QMI1ez6OY+9EEmiMPKBVgrR/UN4HbXAOy5iyOY+xvgtcpy21TOfc+fVq9rrnBzczNaR5hhT2B
 LghMETSDWlhfj4CEzcWy3OXHJtWDNikDAHKNOoXxxUlxJ7wZ7KhXgXgN8SvVQ3QfB3IY6LFYvCl
 G5l0AmkXO4vKEyI8GwHjugXExqAW6vUE5BEI5l0K2JWBTOgr8PshKHz8UaYgw/+7mxAMipaoNoU
 fKhwVlAr5/Ryhh1KLkGUlJDp6DtqLMsxyJvv5ZFBaqb9xHtotFI1JUAVGIcV7Rht9oq57MBq8g5
 qaTanvXhcis3tLiXr0Q==
X-Proofpoint-GUID: Ep3iPjPrCxqxhV6JiQaQzYzr9eXKtShO
X-Proofpoint-ORIG-GUID: Ep3iPjPrCxqxhV6JiQaQzYzr9eXKtShO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160089
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 13/11/26 10:41, Yifan Wang wrote:
> From: Chao Liu <chao.liu@processmission.com>
> 
> The flash clears the write enable latch when a WRSR2 command completes,
> just like a WRSR write; otherwise a following program or erase could
> proceed without a new WREN.
> 
> Fixes: 9785731ec4f7 ("hw/block:m25p80: Support write status register 2 command (0x31) for w25q01jvq")
> Signed-off-by: Chao Liu <chao.liu@processmission.com>
> Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
> ---
>   hw/block/m25p80.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 2a882c392c..d0a8ecf1b8 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -853,6 +853,9 @@ static void complete_collecting_data(Flash *s)
>           default:
>               break;
>           }
> +        if (s->write_enable) {
> +            s->write_enable = false;

Directly assign? Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +        }
>           break;
>       case BRWR:
>       case EXTEND_ADDR_WRITE:


