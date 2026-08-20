Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BADC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7hX-0001mW-Eh; Thu, 20 Aug 2026 14:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7hW-0001lv-Pj
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:41:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7hV-0003GV-5B
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:41:18 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJLxN3706310
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J3yL6/uKVOBGGFj/mG9luJHgHUprTmNvNERnA7Ut8ts=; b=ndBl4PVwkTJhcLm4
 wyuv8DYnb/+BH7qIXbpnU+/q//LH3UEnXGpI+6jEGeEMAvxbPJo5GOAE0qbHnozv
 E9dn2ZJeZaBwWs/jZf9RICZl+IjRPO3DKdlIVXXYovZ9b++Ya9DvrVjw6702u1JD
 UOBBHkM4UmO4TovAZ1nDjaoRJb5BlspBz0jLdSHtk2Sav6vcDZXXQMiILTDc3PXe
 KZQtgDBGoqiVvdZnbrREwrKzEkGWokGjjxo43nNgzZNXZPpXvxm1EXekflkg1c8E
 y56LybcyMDN+RxlShR+UWfNFeUSeCjORQglNowrbnWhRA2M8XTZaN1AJOZDrNTs9
 MOtLmg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7u3qk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:41:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc11b5dd54dso410290a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787251274; x=1787856074; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J3yL6/uKVOBGGFj/mG9luJHgHUprTmNvNERnA7Ut8ts=;
 b=UEeRcnXTQIEnGuYcnwdqfERS50IwRR4tKYYgApnEn54GwX68GiMmOmZBO30lC5TZ0R
 kKzGIKpkMGDUt/lMrDgKn7goxKlu9luhq0esfq8cJXGU/rIcEc9PAHTRFPNZePrC9Og7
 Z5TJUjzKF6WyH2pwl3rQEM8GrkinpDQd5F4XhxzpuwXtJNjN9WDUw62eZvB6oYa/+pR7
 4G0ODAewfBAk7YDkuv6kS2xqDt8XDBUU9H2gKyXroAWNHTGEpo+68+BpQgg80oqyIcbD
 afOMYh02FA1gYdNpJ2x8vXbUvLPvOZFPkHKESaSBrvnnoJUv2sA4W9vru45q2/vr8dl+
 pQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787251274; x=1787856074;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J3yL6/uKVOBGGFj/mG9luJHgHUprTmNvNERnA7Ut8ts=;
 b=Wmrg1aAh1bNinN55PEezM+jxFw7kSAe0jqHu/TlsQ3oyZHENXB7A5voe5UMQMHK+eb
 P5G/VRGaneyK8GcSTSiAqbVz6rx5o9OFwgKsaaLHZWdVPXu9KW3abwaoIkHdDImhc5od
 ce3Qq5XqiG+UnTY+R+7xEku3LS55zkensuCHYKTJHwQuNASNfKFmECXU+0loNSdzhN8W
 nAUba+cPSbWo815nwgjL0TnqeZS2QHjY8mmnFNYCTrYki5FKfaq0R5FLwkrImV4F++6p
 Xe5w5zZ7m7cU6U4EuX+hJnEL0pGXzc8vJy6THxsouMydxduKg8tez6fyaZKQf+Q6QsHO
 Duug==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZm6Oc+OpNyfKQrtQFnWmRFF5v/YX4wP1ZfygBCBrDKyXXegFvnWYqYcbFBcrKqOMvQAN6rzlpno6t@nongnu.org
X-Gm-Message-State: AOJu0YyiRqqeF5op9dhQqlOOUiI2gQvNP4VFHJSO0ht9sLkY/DEVIhP7
 f8IHc3vAKysThWFpc0IGyy10QrxDyJlw8F9YkfJ/ORiUC6k5n02RGh/IAwZKoJ4KEQLnhuBsjHv
 sPJyuS00znfP2UJI8pQQgDo9H4Gf38fJ2a+jBWzmdMhaxcekLydt5CFaH0Q==
X-Gm-Gg: AR+sD127aYGdqlW9TAiyjZ0H1nk/vGEl/jVeCoGb6h7vXsPDtVxX7azGMzPxs3x691U
 xbQRGxqYyShJZb6mtkE8mo45V1iKiRZLSlSo7BoYr3TC23St6x4LCOsMdVPvlNbc1Q/5YxY8GIB
 bKVURZyNojTWeMl6BOiu/cnZnZqnoTJIqm9GXe/jpNy5K3zzT7IUeXQBFfWdP/lOBqMvkVRu6tu
 BdI+L7SRV/RwbZGOccq29miV8KjsLXdEeBCKfqiCfUfqPBoxYVFdnqmKTguBd+fMpm1zSD7nrDX
 KVwuMPQqh5YeDxZbdug68kFjuAl76PW6wqpCxUBkVzjfpcYPsOlH7s4If0aeg4TjrIo8othD9Nw
 BW/OsgVytfKK7sfZWoeqPbR9/QtVMnUoR2j3pw156RP3gHEKrt43rL9j+yktXPVIgkOzA
X-Received: by 2002:a05:6a20:2590:b0:3c8:e10b:7a9b with SMTP id
 adf61e73a8af0-3cd3009ca84mr734416637.16.1787251274316; 
 Thu, 20 Aug 2026 11:41:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:2590:b0:3c8:e10b:7a9b with SMTP id
 adf61e73a8af0-3cd3009ca84mr734318637.16.1787251273919; 
 Thu, 20 Aug 2026 11:41:13 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf14376asm19273548eec.24.2026.08.20.11.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 11:41:13 -0700 (PDT)
Message-ID: <b4f29291-08dc-4281-bb87-de57dc607e52@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:41:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] tests/tcg/hexagon: check priv instructions raise
 SIGILL
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819013144.3264096-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MCBTYWx0ZWRfX4xE9DaZ4qXwm
 Cm4Ve5Rmf/pwXEqLqd1dmeC30pQCqzcREPUPwnRDAWDDD/YBOYKoDHVV9CDKIySHLBtoRSW6IvX
 1JPa3q4ej0Lmofw7j32Dt8ksYqk6ehS2JwSD9PbmWikDAxIGbqnQiu8DdImfaRBxNGJSNKYIDOT
 Oh31yFKenmpi5JZDsCq4EvzNeAnwiiXtUKOfGe1lTO8eqIIQHO50jsdaXbDwRqXeVtKxi4B81xU
 1iwF468ZTOJRht0xGABT0ljI8NYd2/5BCjkaiSi/TRZSWt+DshVoKxWlWLaziEckLAjITSTK2Ib
 CxLeLBADvUKocECESY2uCSaME0TBKpJcDOiEEijtq6v4jzaKro5aAe7BHSW4ffezon7aposglwu
 sSPrm9rDiF6EXlNgTYty78Coos8xXOPYXcmivQ2IWOBgnxmyVRtf+j4Bu4tCTXoQ1YGPAlpv4SW
 KLNKz2GJAsag72CEiig==
X-Proofpoint-ORIG-GUID: CXEdrpL-DFidCr2y2qvdTdft92jytpXF
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a874a4a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Dh76fH27_o5GHOsQtbMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MCBTYWx0ZWRfXzto/VPrT4SaO
 ibkBXed0SgRMi9t9woWnN81v8vw18ylNO3odB1vlMo3ZHfqVdLCG5Fnp/vUixkzmB0RPpipnf4l
 jBTpq+Udb7zdSQWEa9xCLtN4Mztw8uM=
X-Proofpoint-GUID: CXEdrpL-DFidCr2y2qvdTdft92jytpXF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200140
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/18/2026 6:31 PM, Brian Cain wrote:
> A_PRIV and A_GUEST instructions executed from user mode raise
> HEX_CAUSE_PRIV_USER_NO_SINSN and HEX_CAUSE_PRIV_USER_NO_GINSN, which aborted
> qemu-hexagon until the preceding patch.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/privileged-insn.c | 79 +++++++++++++++++++++++++++++
>  tests/tcg/hexagon/Makefile.target   |  1 +
>  2 files changed, 80 insertions(+)
>  create mode 100644 tests/tcg/hexagon/privileged-insn.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

