Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212D606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hndp+sFT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aue9Nk79
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT48B-0005Dm-A8; Mon, 16 Nov 2026 16:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47s-0004v5-J5
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:20:34 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47p-0003OX-Mv
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:20:30 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLCDLK2710438
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iCT6PWEUXoRJGkcT7+gepw+davK5XDsUv8W5oV0cKFo=; b=Hndp+sFTzmha1Jny
 UqiyDNqw7YleJAH3vOgHmFmhMx2u+sxnSg+IKbcKOs2ZYsWkqaqKFkeFy6yTv28l
 7OM7ClsyO9iI5LsbJs4mHph8RSf0dRN0AYaVSY+sKSnKI3Ru389ZouBAhd6dGDGL
 XbtOB2i9BSLVFFiP49udN24YCjDwtcKRA8COme033FNm01GUJ0xrSMvPNhszeW7i
 VZNYkUFeM2a3Dr4izEUmG8hCfYDvqddyn9wLEsFfair8znomCxuGJnrLGEbI9Jl8
 IvchT7usDmjphcLTwhL9YIYWLSDrjQuS8zSsmapbNsDgVU8eY3RYDcMq15bL5acD
 AhTKeg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09htg0t4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:20:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso3564330eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864028; x=1795468828; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iCT6PWEUXoRJGkcT7+gepw+davK5XDsUv8W5oV0cKFo=;
 b=aue9Nk79fyp+kamswVRPdriney7BcN2RVMV4XQumcnIq7t0XzItZ+VOPalSTFVrXVb
 hFtqTZ8kj7+l5lDhaKfmoJk1crhTZvOfcB/O5cMcHm3AWMx4Ja4I3VZix7o30ZTShotG
 fucFnWZ2QWeKtiAPsk2MZ4sg1YzvJfp+b7ndlhZ2GDWsidOAdwMfasjY5s2w8fdG/Y0l
 RV8IxA8w3Ao/1HpHxtiow2FQ+45vuUacDwQS/v0Y1wz4lbv5nc2J9zsGMtN3y4A16JZP
 p8SBsaU6Bg0Wck5tWFbF4fb97d/ucR/WIHpr6qaj+fBf4qqBB2PsrhbHm+wQHTwDVyN9
 2bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864028; x=1795468828;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iCT6PWEUXoRJGkcT7+gepw+davK5XDsUv8W5oV0cKFo=;
 b=22htQyGzQsVRC/V5QX+uHQygse3PUUrEJf8cKOtj+31Fv+3KdZe2IspMzcEVwk3tAw
 n5f6MElAzAL6+5tCA9s8L6wMbdq2UmGpaFjPphzpaDXi3SkSLXuPF475o9lGWzbtc6vJ
 EVl+90VLYvSMc4NW21noTneubfbolAGvtnNOeX/nCN3jpmxqHyF39kdXmhBPokgFcixI
 TxItmZCaFTbuEbjsoDPb4ODsgPe5mgF6p6t7A70a55+wI04T0+PU+Cp3AYXcBOVfnby2
 hJPsx63ef4Pp1mDDIyTdnnqQ2vpIYDbaVbpFVh63QhvUo0SK7ljscxXRa0OALfrfUF7b
 KUaQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHyCSP73pUnOv8W1cPQWb/mdTkqLDZsw9DG/B8u1AbdU+S93PkTU+dHAyqPzc7LD8fptbtTHxirDW0k@nongnu.org
X-Gm-Message-State: APuU4Z8+VAA4LEjLVvVjCGpJtVUf5OVm/lOGCFTPYIbQitSk1yCHmcw7
 IRK8ktIneFiZRfqJAeDw3bBxnsWB8qPZrSI2dLUsHKKnJwVu16uR4x7VwWjcs3C+2fzcPnsml6w
 jr3MWrYDbDHOaZw0JNbOIJk+Av+sCSqMr5S6Y9eQl7y6UsDweNjde/dzqBQ==
X-Gm-Gg: AZFdTZegmd5TxbgHC/atZF63lwt0WZ+zTR3wK1Z18ASYMlWCqC4Dw9+xqZrqlPlX5ED
 pid3rKpS5StLaqDNRP2tO2emJ7DkqbsQ4dQXuciLVLhLU/qXKez8lJar1vAxtmM5lxJzLx57+ro
 JWNtUtoe4yEvb/S7Fcibl+Ei641g5Q46WupYKdEvJoHoSEEch3dQmgcs6Nr5mUnrsRkojrEBBjZ
 W093F749fKq5Z/4pzI2Cuz3AJIPNCNasglY+O/CHE5H4d7TfuNPUmgc6LGwt+UJG51jHsyXzvVz
 sxWazZ0sfnIAc39/8p4O2CNmTqqFHLZZj2xpKXRBSTjfdwmX1A7qfSgrHO8bhm4LrR0K7fL24gi
 5+xJhBkfrewinao2yy6EVGtVuQz939i8TMfnZsctIA0Lc2dnUbqFFPG0zcfYILf6W1SUIgQpuW3
 mvD0K5KmTaNOqRn4mkBtr+1Fc2eNJi+e53KPd872HiRc4=
X-Received: by 2002:a05:7300:de01:b0:369:daea:812a with SMTP id
 5a478bee46e88-379682c2053mr9703284eec.30.1794864027768; 
 Mon, 16 Nov 2026 13:20:27 -0800 (PST)
X-Received: by 2002:a05:7300:de01:b0:369:daea:812a with SMTP id
 5a478bee46e88-379682c2053mr9703262eec.30.1794864027226; 
 Mon, 16 Nov 2026 13:20:27 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d07b3sm35450830eec.22.2026.11.16.13.20.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:20:26 -0800 (PST)
Message-ID: <33572188-5b9a-4848-a494-ca1163a307da@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:20:25 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/48] hw/or1k: rename the 'virt' machine to 'or1k-virt'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-28-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-28-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX7mepGDSGVQa+
 fqvMYjmxAvYQtR38qfsgbSYx+fs6o9pI/f0QXszU7F4s6EiE6wZ0OqbRtdCOJdRpbmb5S2ch79T
 IhJkaGcE3/2CD+mCu7E6scKioVD+4+Y=
X-Proofpoint-ORIG-GUID: FixLzb40rDnLGo8Nrr-uZnBOjateV0gU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX0mGHYI1uWHCi
 al88fUqvAWut9N1QTh0UWritRKHoQzYRaaC4avEI+Z0jjxBxg7qSdwEaB3jcY85C9AQUPLqF3Wh
 vrj3/7NmiTTFhAvrtc9BsPV3x1JM+YoYAslekKdE2fRW3eDEYRFlFk0BHoj8Y5Jc+smwA3pY11y
 PSh5mBLSy3teTR7L8PjqYuP8ehgTT8BJWUMdMcCp7wvpioYx0HEMhPJrwsM7F6pjKeYcl4K5m2I
 liM12CzJXTt27KgKfeCk/fIlv6SN5mjwbMcBGVdwd0BIwY6DZOlpSstFow8yeO2t8RRwF8GzcC7
 p+av9mO5rJ0f2iSxy0oLBRCZxOQDmrt4vamTUJmVBPXfDxaavZqU01d55sijLQhnIyt4/8cPXhP
 xoO/KgM+O8s1xlCAjCI4BnrR7sUtmQgkxIszM9xDcCARfWiMm2rg7QwO6vPjzC6UwwGO5ImYSem
 r/8gw41OC0UImiyY7LA==
X-Authority-Analysis: v=2.4 cv=K963jCWI c=1 sm=1 tr=0 ts=6afb739c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=vX_OHtA2jq_LGBKDobQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: FixLzb40rDnLGo8Nrr-uZnBOjateV0gU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160084
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
> This introduces a globally unique QOM typename 'or1k-virt' for
> the virt machine type.
> 
> An alias is added to resolve existing convenience name 'virt'.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/or1k/virt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

