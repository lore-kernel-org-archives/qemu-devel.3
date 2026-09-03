Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F9BC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DFL-00026f-8K; Thu, 03 Sep 2026 15:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DFJ-00025b-Rm
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:37:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DFI-0004Su-64
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:37:13 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2uSl1698763
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 19:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RLU2Me016u71sW/Gciu/eLgifX4h0lAIitoZfYP/mdI=; b=Ho8/yQm1rqiNzPCe
 C0UMLIibfSVc9r0xTMWj9AZor6vfWnCK1pttQVyEAnNuMuyqeZm4Bb/e8Bl6pTLT
 EOyRRI6BPgjk3w6zMitwoTxU0Dilv0aTyOsIiFVslPB+4hGSL0t+vU4ncksyTFuL
 cj2+nuJLJFTSqQ8Q3xz6NHw51mP6lmJ6SB8B4oA/R6yRI+Yo+S0qdCZw+jBBOkbO
 uBafq20IyjinFiiiUoLNWUNv7kT3YzaqQ7DrM6uGSjBw2JfMvl2gUmZquKdyJ4+I
 EXjVTx2hiDRtvXS2D2/JX0R91gcuTR4VSTIKxrlPD5fOvTcHyUWXZNNOovU/yHFg
 hXrDpA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfbyvh45s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 19:37:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398e1f7d1a5so289120a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788464230; x=1789069030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RLU2Me016u71sW/Gciu/eLgifX4h0lAIitoZfYP/mdI=;
 b=Xd8SFHjLE+wwYFoqOfauj6iObcnuPAlYDr5hLnX4V/ppqiCXfAgPQYiHf6r6Prw2Un
 0mx5lNkqN5ywgiBG9JM7JOsAUaYRXgHM0Rk1W7qztHPPjeyrIalFoRRM2t51/6qN1jhM
 MFu77/yY7dZKUyvdQrbrdDDVp8eKI7csWgRChkLxwobYaH83UfKs/JEam9esDzwI+RDj
 dCKL5Rxav8kgJfx8qcR7R9YaHTXnn3IjiiQvWOjLQTCO0vogbo3gpHNeCB7FvlVsnuWt
 t9WogWrYRgRuWRcREE0Y0leON8lGLZGbq87Ljvq5S/TF3obW5aseVZ5ixYjDujKOuELC
 rwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464230; x=1789069030;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RLU2Me016u71sW/Gciu/eLgifX4h0lAIitoZfYP/mdI=;
 b=PJPkW6GCOph7lMWTgA+3UC/JqgC5NOSubH51d8e7qTX8KPpMXpO1RDc8qmZie9o+rT
 i+Gp38rxcXjN8ulgIrCN+yuKAQHJqo30YCyDosxd2853FZr3/OQWH6VuR8Wv/2JbtrXI
 LFVyi7EJgNOFtrKyyygej68NeEyncBOTwxf6mjqneeo3YB/SAcsp/Yzj/TxTUC8b4HKK
 wlCKFWwCvXpy3VzlcUtHaKXwVFUEBKu+AA9oyU/99gauG5KvlrJTyJQRWVjqjXePfZXY
 tM21Lwkdsbia6bYfjxOhjSNKNy8kyvrfbfBlmrMANwyF6wplEv5UC1ZNU0epyOty/zSy
 iMTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAdKTuUVYAXjNTXoiV1i/jiA8Dbh0aHlNzHd/nM8QJ4D/I5I9CcDVs+BVZYX/ANDm1OKCE01FYN63s@nongnu.org
X-Gm-Message-State: AFuF++lmNaLupTZYcfic+DROnwp6FR9+yPx6MAwCzT4g3On+FQdUQTmk
 pdTXbSGFNBzGKlVbomxi/xuWE6CxUBg9MR1/5RtKQ4AV6WLj+BqYvwpCPXoMApuB+fYbVEZQcKQ
 s/bhC7bPtwEbK9Rgf27dboG8IHrQt7HTpXQKkCPBWJIhMv3tk2g6yoD6Low==
X-Gm-Gg: AYBFou2xo2NWKaapd502DSlulpn40SR/WPygMuTTF0zP46vNtSuWQOrz0GDr/7Gzpqx
 4qaqh9Zm1lCzWEl363I21l/ZeQQ0A4YjydTRhg3Kh2UzEsZhBUd1MiGEBlPIy1MLgAQPf9HYNNY
 1AmM8H+LZJ1sTC8w93CZz245b28rRWAOTZgAFQ/3girWdQtEmBERhabpdsuH2GxYPQmeq6+dD95
 Tp/z7qaQIc+XHcS+MithhiGbsFyrcK9/35r230TNFlk4JKXZGmA/nr/Iwck4yyohDENlPNY3YpG
 fN9WI7l0cczdkrevCyR+SivP6aD6I8ksGvTard4lKGCiJ4YWI76VMm4lEFTsj+QLsdQtqlZ9k7a
 iTQ9IOHmEHWvFMEpN1RRIErwDf/AX9KlLQPCAB1zDx0nd7nJc447AXqfq1h44YzvbT4GH
X-Received: by 2002:a17:90a:ec8d:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-39b26101c08mr1212315a91.9.1788464229906; 
 Thu, 03 Sep 2026 12:37:09 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8d:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-39b26101c08mr1212241a91.9.1788464229489; 
 Thu, 03 Sep 2026 12:37:09 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a62be87sm828618eec.6.2026.09.03.12.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:37:08 -0700 (PDT)
Message-ID: <0b01032e-c594-4384-ad66-ffb7efa59c4a@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:37:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] hw/intc: name the L2VIC edge trigger check
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
 <20260903185622.3234171-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903185622.3234171-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oovpsy-uaim0gNTZ_ad7C1iA32m4szbU
X-Proofpoint-GUID: oovpsy-uaim0gNTZ_ad7C1iA32m4szbU
X-Authority-Analysis: v=2.4 cv=C8vZDwP+ c=1 sm=1 tr=0 ts=6a99cc66 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gHPne6YqgEI5AgDLG5kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX6O+vFQBqxzSu
 hqzHD6B5uCRDe4UReyG39j7WGRznKOw2qJte+N8GW6VM1c+ZSE7Wbfa7ltEL4a1GtZvtvSX3Ct8
 QTU4vwUNfrXDmLBrPKBejwNz7umqCPBkL7stSPEJHenSPEdHHUEjVxvHEfEKqACguJI7XWaL0Ih
 vjHvox0BC8276zEblmI9puw9RKi663c+U7jUscb3qelRiO2+pgBp2H31urElRacy7xM4gxOkl6L
 qzyE2CXkDJY6nMz4qVHZ7ZPdEmJsBucwHhRA1PYqu1UyxYFYq0zi4LZvrqKY4m20pFZKL5liRnY
 AtSyNl49fx5JkbU+uuQrSjry4zzZ+KbKxlmk8n0cecHPuR13c1wQO4BcZlJ2tuBWkYEG2TYALqF
 8bElkt5WemLy/BA6xoo2RllzluiKcLrrUxqqBMWKSyR3jwp87BUKKk5Cchb9/Ne4soVu+JxmoLm
 VxJ16erP5l6Ck65aVIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX6k4Zn/8IsY4l
 Ct/rWIeD8+AwUpabqN1rLLpiCWcvcPIwyF25P7neuk6qxcpF9+mv70q1bUkp8KIAAC4+C2Y+zlf
 HtsHL9LL0HX7/xjvTDZoDlB3cEVP2/g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030170
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

On 9/3/2026 11:56 AM, Brian Cain wrote:
> Link: https://lore.kernel.org/qemu-devel/c3f2f4e2-79e9-4b3f-8bae-88c669a34c0b@oss.qualcomm.com/
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/intc/hex-l2vic.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

