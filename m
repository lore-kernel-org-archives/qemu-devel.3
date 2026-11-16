Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE13606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U1sUaj/x;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Genws2gu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3dP-0006gk-Si; Mon, 16 Nov 2026 15:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3dG-0006fa-R3
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:48:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3dE-00082t-Vh
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:48:54 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfGbk2134908
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1HgopQ22y0smcdGVtTEcfktEyIB+8VEpult39Q0+DBs=; b=U1sUaj/xJZuOoXH5
 LkuIzMF5CPRhMUNiTiGWMg2tntNVudPsP6KifcAwbR7EKDDYIWSMvsULWROJ5pDA
 1BezN3kj14tLbV1obiu0kJXACfsS49EPfA6tXQzJQ5WnXDOSajH8U7R/um83mv17
 DdmlVQLit/cNkopo58fFNkGD7VshZb0sF7rsxnex/cQ74H6rmL18ZvuYjXo+9Qhs
 zBFFMaKYJ+YhaJlHbJHLRAg8cNtT2ulWtgeC7PaHOySaYHAmiki02PO0Mcl+9X2Q
 ZBZcL6sweDQqGyFohdMvssjvsaFHFuC1B+bIpsFQMC3IeorHSnqWeUFkYtOUWmFt
 GThR+w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0003jepe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:48:51 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a3451ea93so3924299eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794862130; x=1795466930; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1HgopQ22y0smcdGVtTEcfktEyIB+8VEpult39Q0+DBs=;
 b=Genws2gu68O2gq5B5JIJ0+DsjFxPykULtN3QUxYchOwK8AY9oQ9vTKcRaOEy9M7Ufv
 Fd68EQ/41aqyVmNUBqGK3wiqJA0ZQC7KjbcqEeqMJDsJd5LoAxt1LZjelDYL6DzVh+uz
 r1o0IeD3Si858wsJlChUQU1gGog3xGhEft7prmvYZmvmwst03oWdX/X6tMUNz2fK/maL
 B8piA3KfmFSCyqOM80+hBuJC+IjL4yDXZTnZFixkxyOwxqBDw6nx55aBBjTEGXpKgBI5
 gBi5P8Q9dQj+HO3OpBt0MIJCBEQWho5kt4Dc6GKYVcTI7OPwwghqz3ZxAHJWIfvwm6Ze
 J6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862130; x=1795466930;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1HgopQ22y0smcdGVtTEcfktEyIB+8VEpult39Q0+DBs=;
 b=sbb1llYTnqC3EWGcNVlqZDJ0Tkzt3chKloJ+20cqYCgkHZK7eYSKvgTQgnoGRU30iH
 wXmGJctFFz0mmqDLwKIHKmdXNuquOzD9Qn9ohvMSoVIYmTzq+WPCERkofYp++0n5CiAk
 itAL5KKZQDYgfRlKjk+u6mzoTEdaRwadpKb6s/lva5IRza1EBjjmvXzaVnHk8iUMPkpz
 Zv7/VmzZ+Y+w41AtBQrMTF46nzJmOV0Ef4xsXbMXYsT9daS0edieAPipNTNh+/ed6OJa
 6h3fGH0DCNDby3iwKnDh+M8+3s2eynaP3LGsnKMT5NqCWR8Gohw9yXbfJUEBokJW6dWV
 d4iA==
X-Forwarded-Encrypted: i=1;
 AL+hErESIR7Z9Ty7kYB+yFBPUFM0W7OVMFVilJSuiFBcIohh5N8RWOUXDlQzTPFfrk7nJAVOYD+lMcykCITk@nongnu.org
X-Gm-Message-State: APuU4Z80PjGzxeE9daYhwrPjUB2z+ekGpIdJ4K2aVlSGI1ff7tKfpHQZ
 KftuNlTvKdNMy47ihu6vP9YuiPiz18sOKDfkm2OKJvaBM3LxwvrPZVpg5mOt07fef1mUJAxUpoY
 p3t+7uJjMpVwePZyf5gWMwQ9AAV0OZAoV56qjRCsmiFNxsAC9XslP89Mk6g==
X-Gm-Gg: AYBFou1Pe6Kjuger3CaTYMgqsM2W5FmvGuKok2QnwYWr8CDoiECHG4D6Qc69lwXXZED
 rvlmEFAXRSoLzIEXyptDSY3hrz8+jFRp+GNmXDZgLyap+F+CCWazD4ikhje6wmCQ+By6Fr71TSY
 MKBQtI1kRLoDwwvlP2LG6uIuegsPyVcEbs3QoNAA1xe8d8783cDA6KGB+GtEDr6IDlW1cv4FQ5Q
 bizBA3ihC62E+swRKJ60/1TpxGCu9wCnRzLdVHv8XaIFChbgI+VnFq6D8QUm2CGPe3EfEXNCgxS
 XnrRrPJmmGsQCT5VNCEEklz7BiNEULGGj1w+on7p8Fp8w4IVtuPErNLkh3MIczqI/7X6x5nYiNd
 4JqG0HhR73Mud+YRkJu8IQDFVXNEQXZ6B+ycaY9MACjZ4rnJVgryzPl5hrf4W0I167WlHCb4YP7
 MOn9ka8mJ3NpQtsaEUV8CA0lVFYx67+nr1Ej0HaZ4Tr98=
X-Received: by 2002:a05:7300:7481:b0:375:c5e1:931d with SMTP id
 5a478bee46e88-37966e3aff8mr16173830eec.25.1794862130199; 
 Mon, 16 Nov 2026 12:48:50 -0800 (PST)
X-Received: by 2002:a05:7300:7481:b0:375:c5e1:931d with SMTP id
 5a478bee46e88-37966e3aff8mr16173808eec.25.1794862129637; 
 Mon, 16 Nov 2026 12:48:49 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955822d58sm36586407eec.10.2026.11.16.12.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:48:49 -0800 (PST)
Message-ID: <cb7bad9f-96d9-4a7f-ad40-ed19e14f83bb@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:48:47 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/48] hw/core: implement TYPE_ALIASED interface in
 machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-7-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Idpph_80OAh-N3ZNEU7Zezj6i1QIIIv9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfXwvbex1rnyx+4
 +XnfTszD2syJ0IkaNXlPXdr1k9sreLhRax7dQNkqllr4w5r3S6lGyCtANmyflyfZUKyIlReeGj6
 EEnM94223DVIFwynrkSn+RIrbiuTsB4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfX+lqJoRvRve9F
 WMJeay7VbugyC2dI8AR+5YrvvQ3uDGe6CvIcjIgzXJs9VQVr1FntYX48GVp8Sq/JtyZyb7gb1/9
 2Hgg1xYZZhSdbPg8NiK3hwb/XiBPrTbAW3CiNsAxp530hh6fHIh5Z7OtETcDHjXyEjwCmvCm+0u
 1fL4/AhkWFw2wzYhCaxo8enbt4A7pQqkF73fdbmRpC5ZF69hEfBUzjDyLcwXOJmMvb4rCrfINIV
 tZ0nDKLItIObtuq2shxDY5TvzBCrhNI2duWxXRRepHvbFxdAwJBPzj3yVh9BeikXIAbu9VnNz0x
 jEETQgvr4GHnxr9YBIxo9hnNKvM9dkwGMfym7If6OXeJwSD0BWu24Ni/XO8zyNcTcCj24fwsZqR
 Xz1Xm7trBbTZ6ZCCo8eD541eU6xXSapXceZJlelTFzg6xrqaQ7GUQHdWsjvfIlzNzzX7v7K6CVO
 jMyu6qpKQyD4o1PersA==
X-Authority-Analysis: v=2.4 cv=Z4N5j3RA c=1 sm=1 tr=0 ts=6afb6c33 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=P2TNmikfd5OQ4NgsLFkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: Idpph_80OAh-N3ZNEU7Zezj6i1QIIIv9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160082
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
> Make the TYPE_MACHINE class implement the TYPE_ALIASED
> interface which will replace use of the 'alias' parameter
> in MachineClass. The current 'alias' records the user
> facing machine name, while 'aliases' in TYPE_ALIASED
> will report an internal type name alias.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/core/machine.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ed9bf8f5008..f7406537aa7 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1802,6 +1802,10 @@ static const TypeInfo machine_info = {
>      .instance_size = sizeof(MachineState),
>      .instance_init = machine_initfn,
>      .instance_finalize = machine_finalize,
> +    .interfaces = (const InterfaceInfo[]) {
> +        { TYPE_ALIASED },
> +        { }
> +    }
>  };
>  
>  static void machine_register_types(void)

Since very few machines require this alias mechanism, would that be
better to be add it where it's needed?

Not a strong opinion though:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

