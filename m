Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F49606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AKSdiQ/I;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=baeDho1P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVZK8-00066A-3s; Mon, 23 Nov 2026 14:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVZK6-00065x-D8
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 14:03:30 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVZK4-0002fA-Tq
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 14:03:30 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGuan2486557
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 19:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bFg9qC6qAlMtRL5RqKjMsPzMnyFORz9JXsBpm5TVbYY=; b=AKSdiQ/I45Nttd3p
 xyCy6L7BZXZIWwBvKRNqZNSj7LDf6Ks/Jo+PyopsZXtaA0gGFfI28MMSL5iIWk6T
 oXv4drk9OVuv2xP7gD0N82Uwnz0WHSaK68cOARoIo3iVJ5suNbN5FMTFsaY6zaU5
 s7ERv9zpX3lyKYbMd/1OO1cNhdZlTbjQxdVEwuCQwNF5Z3dXKFBDN5lsZCuJURJM
 XJgr+PKYHbZEB31JiNAs1yutNrwpzsw2wu5wx9cUSxvMn1Tzzj0r1SBHyJxITBr4
 9RW9ZKB8hrSfoEtP0n1C2j1WKznSIF3/k3lQCKoTbvxKunJlPWFxvYdrBs65A0Kl
 TOJneA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy031cn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 19:03:26 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9211604468aso57115286d6.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 11:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795460606; x=1796065406; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bFg9qC6qAlMtRL5RqKjMsPzMnyFORz9JXsBpm5TVbYY=;
 b=baeDho1PMIsBtFmJf++WDsttal7aXQzvWi+p1tjWv6m7eapfPj+UDRwuIAIdUziiwZ
 7M5HqT4je+FgTYQPEOri0fiXNxJxnhmVwHyZvF3Q246b4EhEk4gvl8CfO1D6tRCUtS2w
 ZLGakc4RnyRs6YqxJn0INSdTCa2hOG6TOqdJjDsun5MVVD0Ry7p9c7aycMxEUvff2wGN
 xyB2AQ04CAzSimWwWtPJBMyHPwnkLtbOStwmjeRN5zl+x2/uLJod8iMn1VHsAZ4MStz8
 sixLQ0GdEYeQjAsg3msGCC1EFsiTzAjI6aPq5UBvZGmJmVWoYkbg1Z6DuC0mmUlwjpO7
 S3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795460606; x=1796065406;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bFg9qC6qAlMtRL5RqKjMsPzMnyFORz9JXsBpm5TVbYY=;
 b=BkHTX3LOw8CYWYCOinPHQB0Te/Vny2NRJc8HtcZOkULb2cUYfdugfHvs4py1Xe9SNX
 kw1UXYIV/IB4Sos6emKmHJMteHWZ4JpyjAm/3n5NH8loOYWhwtPn3gKbIMePgvpTluWX
 U7lAtirg2iGEZewdbMbyy4pjXPNYmLoI+/UUwamJ7gjrToLtrknX93c0N4x9K/kPDH5f
 SZ+FpdbTb7QlmBaSGlsOicIL7KpTR5ni+k8R4y0xJampjqNLsuAcWHxSzJ9ajADTVUZy
 55A60+mtPya5Q/A6o+mNBIudjpfP+iXTwv9kHPVOU7t2SJczvOa3ElThZlOQypOnBGBG
 sbiw==
X-Gm-Message-State: APuU4Z/Yu5vqqKNCKdyLgBvWk8GGIZ8OuIOLBxE9p5nyl4dDact4DAuA
 MU2qguK14d4GZGy1gShoerBQHXuGPYWuQxiy2F7556DinSKTriJuEV14c/00IRlRdAfz92cyHCB
 htFa6ypwDMznO6wf4WMYJJSuF1HEewQ8JLz6VjDKEbDQKKK6NzgGz0gRvUw==
X-Gm-Gg: AZFdTZfZ4sK2sWUUitzymcPBMbeJur4jQdony/ZlDuIVwCVLO8DbvWwFTCJ+0AsqEEN
 KU3cv0cbKUajxNNBPbwhws6DRh1yo1JsPwD4mxaM0ZdL5atNne7iwvpqihI8SiwFYFy6DgBd6P8
 2Lxk8PYCMHTHvDhsPt8QkID3ms8Ci9UNs86N4HtZf9IPxNMx7mTy3qSh7gRqnf3AN9U2HxKPzCA
 tqowE8b1Pju2LzJKPjAXygpNjRnfnMPK5ABJobpT26VW1zSsjkhEfpwUrCBJ7jc8nFHfPzt6YVC
 0ZJhSrNjpaT5WET0PAf39hSvRXnLo8fdzTUbncXKLBfyWDDzbv9dxiOqep72jHaulBFVXS3Is7t
 NWA7Ajqf7Fy9v/PtJA45CKyyXZElJIQJFLtLNHd55ukrId3gxzaL8qihjVv46ltbcU3Z7pU2kHs
 hJEuH3RC9sYZlWWwQhBxz39t6QmfoNt/3zbX0g3A==
X-Received: by 2002:a05:622a:c0c:b0:533:42e0:a1ee with SMTP id
 d75a77b69052e-55d769f5831mr186560691cf.37.1795460605662; 
 Mon, 23 Nov 2026 11:03:25 -0800 (PST)
X-Received: by 2002:a05:622a:c0c:b0:533:42e0:a1ee with SMTP id
 d75a77b69052e-55d769f5831mr186559891cf.37.1795460605037; 
 Mon, 23 Nov 2026 11:03:25 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d78811fd5sm107086721cf.8.2026.11.23.11.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 11:03:24 -0800 (PST)
Message-ID: <e79b2a71-9e04-4617-9377-2027b77f3a27@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 13:03:21 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v2 12/12] hw/hexagon: version the virt machine
 type
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
 <20261120182031.560481-13-brian.cain@oss.qualcomm.com>
 <fea3ba89-b832-47cd-90d6-5e4c98c56029@oss.qualcomm.com>
 <awR8JgWoGvM6ubWD@redhat.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <awR8JgWoGvM6ubWD@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3NSBTYWx0ZWRfX2YC9CbjoGkV5
 cmyYE1LbIFVPWEJ8iayXRBrx4LskFaH9P2FVJ4VurBpiVsTz+PYyazaJ5o9+YtLpMzMOABtvipN
 xl7HkdDYq8Hmsd7TY1nTKLdG/PLoFiZg1Qr9ENqn9faXEweiLxPLxzQNGe2yG2T2n6Atz2eNxlb
 wVcMQZ13r0R8H9eot1PiD5/sm9ai9OOCkK2nK8je6fwhSmCc2DZb88fy1m/+8o4vBZ5EeMXEuyj
 8VUNVbBVvwNiLwgIDtLldgMSOLco78VKOXkaFuz/VpqSMEvwYvp8Cc6rXoyhsmQeLGgkYF3Hdhj
 9U5kpBbPTsHCLDugwuYLVTdiW5Ca2uyFxUVqgCFNfZAi1LqlZwQZBxMWYzRmettIB0e9wju3CLw
 vNp691HH0WQcmH5g7Ktg6aJ3i7b2YW+q5xEaWVItct5iPrk6U0ayRrs8bIntH5w+xmS+BeBB6YL
 oMrZGPMR1yLjldCt+NA==
X-Proofpoint-ORIG-GUID: 0eMscm6A8mEC-G39yBP0MYrnCJYtLNVH
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b048dfe cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=jULTX1Kfjk_e5g0jpyQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 0eMscm6A8mEC-G39yBP0MYrnCJYtLNVH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3NSBTYWx0ZWRfX4zx4/nG5sr5J
 y7pY2sSRQbXxlT897cCRlulXbMqrYknCHW2phDRgSNjwl/1OdNeCkuiDxmis2oH9y3CvpPzVFbD
 8VM8SkLIEuYmByKrw73kz8zeHdvmkio=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230075
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 11/23/2026 11:47 AM, Daniel P. Berrangé wrote:
> On Mon, Nov 23, 2026 at 09:37:13AM -0800, Pierrick Bouvier wrote:
>> On 11/20/2026 10:20 AM, Brian Cain wrote:
>>> Make the existing virt type abstract and add virt-11.2 as its only
>>> concrete type, aliased as "virt".
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   docs/system/hexagon/machines.rst |  3 +++
>>>   hw/hexagon/virt.c                | 37 ++++++++++++++++++++++++++++++++
>>>   2 files changed, 40 insertions(+)
>>>
>> Introducing this mean we'll provide backward compatibility for any
>> future release, which is a huge one promise. Are we ready for this yet?
> Aside from that, we're well past soft freeze, and IMHO introducing
> versioned machine types is a feature, so would have to wait until
> 12.0 opens up.

Okay - my mistake -- I'll drop this patch.



