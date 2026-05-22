Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C1ACD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQYOI-0007hO-Lu; Fri, 22 May 2026 18:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYOF-0007hD-3m
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:30:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYOD-00052N-6b
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:30:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MKVJvs1959117
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1YgScxLnzOH+TLOBaFW1Jqh+Lq/PuNpPhXRs6CqtCuo=; b=b9Thf2Boa9VMV7Wl
 rI4yxTh0WQq/SYGSRw0oYaBso1vXPZ2XIloul+ysoBA3Ckc3uZhLUGi91xO/ZSIR
 IaW64mR/xaTLoj56wKQSHjFlESQhkqnx95xoO4lv4I1LAdusLXIClXfNW/f/7+vn
 oNrXwtl/MxML5x2h2XwBeX0iiy1n1SJwWXXHq/XTy8i6ZgZJCaaKZKdufkPpRzCd
 SrY2VVrU50a87rd/wEdI3eypuFLkrUo1i20ZdgKGvVWrxuXAJ8GhnjOtBtVk9Tmg
 1ir2JyPpSjYnbYMhGT3yjaKPwymLTumwow/wP1vpsVMQIn/+bIsYZXQ9UlZwe3tG
 qeCDig==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eahxeuhn7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:30:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ef37c3f773so8155070eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779489043; x=1780093843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1YgScxLnzOH+TLOBaFW1Jqh+Lq/PuNpPhXRs6CqtCuo=;
 b=CjXllbYgWqwS29137xlFxc3F+vb5r5L6iQomA+NVG36e2ILZBFdVb7ZDxs3qT6XoaZ
 5xGF+VEIVfjumUK8UqyhbVmCMXkzLe4jFjZlYyEfi6EVNLcGQMpH+3eONLLuak8c4026
 TjbZdSnwrP8S8aKuoOl8bT1WZeTotoQnU8Mo0gvqKHcHahkyO4rxoP6lkUWANAyJeCW3
 PkruZvEJWq1Milq0NoPU9tf5dnR7R13y5uW+dg+GvBRKPKCOcgRi0rSF2sps82+FiApE
 5xFycdfEEiLxfWENewG+BcSpC0NLm7hCm6clLV3v2gXouhMdnWM2TH53yr72aq3htFun
 5Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779489043; x=1780093843;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YgScxLnzOH+TLOBaFW1Jqh+Lq/PuNpPhXRs6CqtCuo=;
 b=G1BeJ/42ESHNANCDf73/zPLHjVVmLmoTE0Z44Ie4yXQUDD+mNamafWfjCxN5xP7vZ0
 DF7smp3xY9hNLLei8usD7M5NTSHdVkyX0YK3KYBVVV8YcWOw30L2sei6kjx9PX5MhCHS
 Titcs5c4mEyIZa6vHeFb8+48DLyVGlrmP95/w95g5JL5zJu0SPDHTwMHZEFbVwSP9B+M
 WzpR78VyVe6Pncw7r8q9cg03MDuoaC+GNlCQ2/fXo1bdryaq42+gYEDISxnn7aDLn5ZM
 Rm7sN3LDWYkhMtR3HCQZ3Y+//9Q89ntKxT+DCbWVuQVhP9edvsvPAAQlOLLXP1JhkRrF
 Rpcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xsxa+Lyb5yvP4pTk0j8dI5MAh5JDVNIK1EpqrQ8pkp1z5D7SrsAMyMkSq/bEPdcE4UdlxL8xsG8Cx@nongnu.org
X-Gm-Message-State: AOJu0Yzvw9jr1/rnXbcjZ1MmP1Jegg6had5fvSaK7UuxV3fOJex4fzwP
 QrjZS7ZM81QrZnJ/r/fC3R7RnjzHdnUxfC9gmq+ic4usa1tiDPuqy5wLDS4ENekcSM6QV5PChxw
 erU6VqCPLJF0eiRmMw2Oe2pL/Y3qJ3DfFq3cjmOsTT5CAWSAoH+tqKNx+LjWfgwfoWPHv
X-Gm-Gg: Acq92OHZKwtEczsY8fQjA3XdZd+x5uyZiRFkg6A9bNWsZ7nxwZ0IEKKx8wOWvK2+r5S
 ZVfdcTw+HTyXu4s470U7BrWAhwdiwqS25s/wicKtxP4DP97b9FJdIS1r6aiy15bUsi7c7Swe/6P
 PA3uJagb6UFAEFP1tOwaHEaF0bSg7wv2jhMuZ00/VseRkY7GW25yDUQcEr/6W4RWDtk7EwT8iNv
 ACXHNRKg9G1AoJRqQu4gr8JYnwdfuQVbas++fVAp0ykAYBPbTQHvUDSHnd2DoDJNM21kR2wWsVe
 dynpzP0EBRgGXb2ddWM91YT1AOTXnIfX0b+z9uoTAnTVDwYDCu7lkZlbTCzrzoco2MJa/oORzGV
 8U06QxhG9v4OyMuVFzjLCRbV1ZjeHtja7RrrNj2AWqHKKv4Te5YCP6/BmKwGIY1Q0gMsarrXAoa
 QGI/yQUbT9J9JbRA==
X-Received: by 2002:a05:7300:e605:b0:2d4:94cc:eebb with SMTP id
 5a478bee46e88-30449001e3bmr2756306eec.13.1779489042638; 
 Fri, 22 May 2026 15:30:42 -0700 (PDT)
X-Received: by 2002:a05:7300:e605:b0:2d4:94cc:eebb with SMTP id
 5a478bee46e88-30449001e3bmr2756292eec.13.1779489042056; 
 Fri, 22 May 2026 15:30:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f1fd1csm1956537eec.8.2026.05.22.15.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 15:30:41 -0700 (PDT)
Message-ID: <532bd22d-b2ed-4e28-808f-ac7b6a20ca6e@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:30:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update qualcomm git tree URL
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com
References: <20260522222827.3239334-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260522222827.3239334-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIyNCBTYWx0ZWRfXyP7Muo43lfVQ
 m2mpL/pgctMz6h9JimlUmJHmkwV6mPUralzhYI5wiIUil/9nfxAxM1GlfPPvwpCgYWdXnPpMHG6
 vKARwOW1TDv9I+FUyztlSV+1CCI232t7oUBrEuaUmyqteGPtzp3lhxJXbDvuCh75vaLeFSHmjvz
 cKpwW/un/9TY2emn2upY8C1JRBRR7pBnmFpYal/SyIj7Fo1CgjSQ5qmOSWIR6KmI9ZQNh+j7XrW
 UiqXY3T6fF19o25WLgX1xXehQve+rpNUSQ8GtzlAPVJ4rfMu/g/0SJLRubYuRUbJPZHc1y6bY/x
 x1cM31U5VFHt3gdr7n5UDFjJSXP/9ydMHLA9qhQWvVh76Y0GO98uClFhGWD3Khb6Xbv4SBGkeMz
 T+Fnr+nrG6Sfs8NEOP0wbv1h2sxOTV9O0W15KBhS52NSS67Gg5nc+k2ixsFf5+N0TQtUisAEa8Z
 z1Ogfh/0doL2PFci4vw==
X-Proofpoint-GUID: 9OBXUogBicft3yS_XdUf6kRHZAHA3coJ
X-Proofpoint-ORIG-GUID: 9OBXUogBicft3yS_XdUf6kRHZAHA3coJ
X-Authority-Analysis: v=2.4 cv=ar2CzyZV c=1 sm=1 tr=0 ts=6a10d913 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=MUqWjfrbLBPD0Vv0UtEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220224
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/22/2026 3:28 PM, Brian Cain wrote:
> The git repo has been migrated to https://github.com/qualcomm/qemu
> 
> Note also that for some time, https://github.com/quic/qemu should continue
> to redirect to https://github.com/qualcomm/qemu
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

