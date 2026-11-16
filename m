Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B7606A337
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LFGuQa9m;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FQXjSrHI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Vy-0004YF-IK; Mon, 16 Nov 2026 15:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3Vw-0004Xi-RS
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:41:21 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3Vv-0005Ab-5D
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:41:20 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfE1h3504897
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JBGGwWJXHzjExBl+zr5uBvmj6D8S3smmwEXl7EobVso=; b=LFGuQa9mQeYJlb6i
 WRsfMw4vCNbYGrs4yWOSm49PfL9hxOS71APvGC6iJ9O2ZMBD3MfgUw7mEZ1auMdf
 d/BVoYuzwAlxNzSiawMUWC45TtNLcUF2LPw7WXD6jgg1lmSiWo5LRA35uzMC0fb+
 IJGP6zaq9dPiYctLUN7mugpX946J8xfg6O8UcXRt+G2EsGLydjG0s47P0ATQTNQT
 nlf10xskDz3tOhxxg64zqlRibjjX+zf0b+Fd/FRrna2Nn4ffv+BGmsW2/undon2a
 0fUBn/jVhTK7QGbjFsr/IY6e3wjaS4ZcK5AZyUvWtrYDn/oj9/6sOn5mw7EL3rPS
 /xIPXg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j038m9m8m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:41:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5588524eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794861675; x=1795466475; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JBGGwWJXHzjExBl+zr5uBvmj6D8S3smmwEXl7EobVso=;
 b=FQXjSrHItWI8qIVr2PoIoM4qai7cfvzaZbLZfK+5dxB5DeZhLCPzNNmiJpzwsDXjaP
 ryOAZgPyliMk8hfVYAYGnvD8XsiGa7M9y0kYzoJu91tXlpF6LGsGs9eCsY7wk+zCN7cv
 DWYUg7ZaBUrbMp+YGQV7Q/i/OQoJNYuZTOsvUlv44PjttPDAy5kj2N8eQoqsV8eLdlLW
 /Kczowd579R253yYue0B1AJUQ5NNJqo8AYln7vgM4idnLRMDfAJyCOIj2+AKwHNoLfDn
 sAi6Jfp6PGw7V4Yo4LGl/AvNpq/ZVdk8bef2X2StgxmfV1l/WBcy6WctyRh+fN09oH9s
 udrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861675; x=1795466475;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JBGGwWJXHzjExBl+zr5uBvmj6D8S3smmwEXl7EobVso=;
 b=ViukQdnQqb7lik5FOW4vZH/5InIs79PbiJS3GNkHW5cHbsfM7aYbgcHY3oGq1IWtpE
 GSP7CINnI9fx3c9HYezLjhZyV84gB7eZQrOZoz9YPsrW+WEPIQO3KQ8uhEiKcuf+GwYZ
 MrNcX5fe3DvrU++xBFSjgtjqHcOJM996sli4v1NNDSmWUnkP5GLPvFUo+9SLdKEonUIe
 ZDt+avej+uDN0wQmPCvWBz5LMU4TvLLZGWPDga/k8Zjk0N/sesH51sxokJ+XIYtv0C0k
 9RIZTiKs490fc4Rqicn1SWyO5C2w/vhWYuHM6yYdkjyHT5RWe/V1/FtiP2pZCHHgiejY
 DDrw==
X-Forwarded-Encrypted: i=1;
 AL+hErFivkQD16Xa1FhsXjgvC1NezOsh4Swa86OMxEV0cgpBQiEFbffWg3jPkUFYK/C53HdLfCLNI6j6DdlK@nongnu.org
X-Gm-Message-State: APuU4Z9dz4AJOju3v/UI9FJ49XNHZo9B30sceRf347lSlGanP0v5Kiy2
 S7M51rg+ofPvObG3q6sg4R1eCT4uI9j8h2gDztqgTgVKl8Xj6dlOH8QmNkZs5OKhiyEFxivfhXF
 w/VoOAaJb2zKgwoC5Jw9ACxCZUnddnWnz1XiYO15S2XeaiN6cDvYYv/Bdvw==
X-Gm-Gg: AZFdTZdtH4ffGzpLCkRtHSjgHxvYYDQJjF/TYjHK0dGlLFq204dT8Q2ijHoQwCkMA+q
 yvMhFRMg+vAbCvhcnQulJ6x+k33LVoHgTswuKxWJZmukC3g16tYasX2LDI4i/6wOAJrTG+Sj980
 FvU/w97Ebze+o2rhvxacwdU51E8VEMCHeXOW67yq10WWIQPZ4E+zqejvgQFRAPDcJDAlm1VOeG7
 hCqZc2LshiP6J2nkggnMTla+fMgsr6SowrUf2dJD4UME9yoj8XnORiCiIhvgKSqE8gx3sVy+Qyy
 CPzHmtiodEIiykLxQLPDr7k3xVbhXX7OVBpi0utOtGICzBFuo+0LTvMFaZTxOF1r2dzcEij03nm
 tubuDO0cL1F5TbELDLSaIc485lOMaKYrr6U6hb9FUInDZfyZE+Whb938AO0OEUBx/fBbANxTX7R
 IihG2TP2/BR/0A7md8DlF3ojSTd02RmVRVJOye/aKsLPk=
X-Received: by 2002:a05:7301:fc09:b0:36e:b3e6:ebe7 with SMTP id
 5a478bee46e88-37966a58499mr10877049eec.26.1794861675383; 
 Mon, 16 Nov 2026 12:41:15 -0800 (PST)
X-Received: by 2002:a05:7301:fc09:b0:36e:b3e6:ebe7 with SMTP id
 5a478bee46e88-37966a58499mr10877029eec.26.1794861674846; 
 Mon, 16 Nov 2026 12:41:14 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955a1c5c2sm37313029eec.14.2026.11.16.12.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:41:14 -0800 (PST)
Message-ID: <a6cf98a7-5a3c-459d-a811-a5f215056aaf@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:41:12 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/48] qom: define an Aliased interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-5-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfXysOls20d2X5x
 vDLDXQgWoqFjWezrWbbWJQwMb107bEH+7ZXfjxfSaczwmLzwXLd5BKTmisfnr9Jq8Suzok3GvmU
 W9XGsk2rDX4lZAnpVSd6tIKflatYOs3yfANEURZr5mrzmFmfoyinpVRl1DUYAvIS1haL1yNb48w
 TFDhi7PQ9B8qawWVf8qXu3O3t5Iwi3rKHWjpi3e+CmiZyggW/0mupbZ5dohkZ/Y1z9W0ZSQcemz
 LcuN0tm4/0TZPrkSIn7eLObth2PKa8Hkf8UdDxZ67C2katvdwlJB+BSwepffNfJ9BMpzCoXh5Su
 hAOz3dPk8EZBH8ppi/AvqJ+irkqBfvDTd2glQVNVaTyFh33KRYdS+5YxCo3LJDSyXUql6N+HAH0
 1+rCG+WTfjzrJF2iJNH92YeL99h2C2i79bSRc3hEmIey5SRwoLBc+nttnt3gw5HvgDXLxpkd/Xy
 UfbpPgPmwKVvZruVUVA==
X-Authority-Analysis: v=2.4 cv=TckDJhQh c=1 sm=1 tr=0 ts=6afb6a6c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=VCDAKRhZtt7bMQOswpYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: Qo4gL72z4dKQhCYNl2mA47fd57a_lgVJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfX+ZkuFXgVyt8T
 WTqurDKnEjoej35vns3GLCmK2V/TarV5PTQUvyjwkSziRqCY4fWzNjZNnmdTk89iHw9joYJegan
 M0CTHHsyGx9ivrqQk0VLB6iWjdwXW7I=
X-Proofpoint-GUID: Qo4gL72z4dKQhCYNl2mA47fd57a_lgVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160082
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> All QOM types must have a globally unique typename, however, for
> user convenience, some might also want to have aliases which are
> permitted to be ambiguous. Define an "Aliased" interface which
> can be implemented by types which want to support aliases.
> 
> When resolving an alias, if there are multiple QOM types with a
> matching alias this is considered an error. Ambiguity can be
> resolved by matching system state, with the selected target
> being the currently implemented filter.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/qom/object_interfaces.h | 77 +++++++++++++++++++++++++++++++++
>  qom/object_interfaces.c         | 57 ++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)
> 

Looks good to me.

Two open questions:
- Is that worth supporting more than one alias? When would we need that?
- Yonggang mentioned the possibility to couple this with target, I'm not
sure we should go in this direction. What do you think about it?

Regards,
Pierrick

