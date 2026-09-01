Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25720C624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1TBr-0005hY-Me; Tue, 01 Sep 2026 14:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1TBp-0005hG-1v
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:26:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1TBn-00030H-DT
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:26:32 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681I2mq03531033
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 18:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tsS6pqLizCBD+XhejGYuhJrN31PRTplBKYZ2cIvZkFE=; b=HdoUBrGEaP5jHSs8
 R8TmxtsrjjorBpgatWp8qK96MWu7RADIFA36hodHrBjP+6N4eiGgm2WgWk7mlo07
 CsFfk/Abjgd6TtKAIAuGk7KY40rQqyDSEwJW/DjRkgD3e7zHZYssIxmhYYLhXoOT
 NKDNO4yUWj173kR7iiGf0GSmoikOb9cZ9CnSVqmOTlVHaoMiZULXTJeqXvk/9zaH
 N0xQosm8NYI1SxwV4y+1caWrKrvhjWjTMdbLUpx2RRZVi3W4Lr676fCjbsD35kYk
 ePNadD2p4yqAdV+fxQ+BPWdorhXyWbdHmwC1vKqZsw5UFmiTikQ183hwTuaGxlkC
 ba8gyQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge3n0r3n5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 18:26:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so229332a91.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788287189; x=1788891989; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tsS6pqLizCBD+XhejGYuhJrN31PRTplBKYZ2cIvZkFE=;
 b=V4pHXm3W/IXNQpkFb0NVdLLJLctqjK9bxtfLclOG3v5rObuY3tK+GD5utAe+Dmn1Lf
 WpFCVEtH71UHEjRfZSE7mo64XOuEv8qL3XLKCMAMQqcpmqANH4CmyQxetZEzEJlGAVxs
 w1EdhIQIXwwaal/gocdgKYRSZRIoWoTFOklFs56DJoRsiuaA+TcJgWXt6Z2wEWYHAcQG
 VdDWEB57wno8Gti9xAmpl9R+aUuWaBnd3QIpci/Ix6blUabdtSBpgrPiqSQBOH0Kj5UY
 geA09Abb0lXUNm13Y+AeY8FQtr6BnT4sQDhvYPkin2TCnXSoquWLMfzWtsuQBmu5c+rx
 4q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788287189; x=1788891989;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tsS6pqLizCBD+XhejGYuhJrN31PRTplBKYZ2cIvZkFE=;
 b=gGO7IYtDrIa1JdYphEkvwDbMO1vf+/T39WThtugWgJyuQN0YlgUdLyS/Qcwmxxz+R7
 RyTKF4c484XAdV+T7Jym+V+WfxXg9EuTWcG8CMDxlEz3zt4GwyDN+bZb8EY488dsRAK5
 jq1rEsRmy1+MjbUSIaojE4boC2rmaSBqbeLbXY1NaaoPcdJjNmRk5v53SsJpmeWDaBzm
 PhSkQ7gWqwkr3xiReUjBNbUiQLVdpefMaybnkRGX2CCmF7k7AUZCN1fp3k6hZeo0Uqb5
 DLUWZdQMX5B9BFpvl/d4FnMS6gNHpvif8v9jXzbokJpMfvfUi6uSPM+xBcK1fRaGrdMj
 Ts9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkwA8HVIDnFQmxzoKfEcyEyNj6iOZxPZw7R05vupDtJqxARxEs2nlLjVEK1P+m0zZIMow1j7EB+C3+@nongnu.org
X-Gm-Message-State: AFuF++lunVb/F3fqOkTbV8TNdyQdIH9YkwoAoDtmUPGFBrRD6A1PFVHf
 bHYQ3QgQ/tpGL03g8aTMdBQkccTdClJ6oZ79xKsksYDWyiiW8OQVqkQ1pwcbBMvUOfQhR6RdIVL
 AEgSDgW2fIb3gGkPBgo+HpSmLn1ZxigX85JAFAdXxfIXOZhIfW9O9yC8MNQ==
X-Gm-Gg: AYBFou2yEq5NlzuPgd64h6Z7j/bHyST/32qkat8uPXNNv3xFyxH+AHRRDQu/O7c8dcH
 qVZm8P9cfuIUYikVKqfuPg2rIttrOnb29zMNI3AZYbKMMNHyfvOFiCW3uDtBO+ftyBcXgMNSgwx
 b+SzgkDW6Q6NPjIzKl87jm4MQIKdGEGxTCaarPwbll4AUCaNnB0hK+MteY0iusB5qlO3J8TxjSb
 TL8C9h8KzPwhBfW7EL0HUJMOpPSNN7YBmxEWg4iDu6iZOGIsoo5hw9zKiwjmogXdDYucSkXFB23
 HZ61o/seUfbdmezwKWloOABa7iqNhENbs9eefthaDg4SjP3x8FjITzhTV+F3HeEI2iQ/vc5ouaA
 1vnHEzdLzceaMa0q3J6UGpPNYbUtmsirGeC41T4ae5jOZU/rDf6ymaq7yhsgnZW1r726o
X-Received: by 2002:a17:90b:3d48:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-39ae826b652mr38455a91.6.1788287189070; 
 Tue, 01 Sep 2026 11:26:29 -0700 (PDT)
X-Received: by 2002:a17:90b:3d48:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-39ae826b652mr38386a91.6.1788287188585; 
 Tue, 01 Sep 2026 11:26:28 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1430e9eb4dasm664721c88.2.2026.09.01.11.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 11:26:28 -0700 (PDT)
Message-ID: <9c1900c5-a1e1-4f8b-9a1c-d413ef916d09@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 11:26:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] target/hexagon: implement direct-to-guest
 interrupt delivery
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
 <20260901173353.200474-10-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260901173353.200474-10-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE2MyBTYWx0ZWRfX3/p59gpm4+V5
 aC6krqT3ejVr4xrrvMTNiU+UeOqA1Hs5C/MbzIA0EIopcz1LnHO5Zxj1zKuezpYAd0po344wHu6
 1Qjneq4mDICc6RGlWs/o1YHfDt0dXQOSNOwW1Yq0QsDxMguezCxBo68luPX3WGtDPgRndbrujtC
 PRg0I55KZYfpo4LR0nBQ9lzX784clqZdCa5kvBNNHREuM3OGLOppl1dzUU3yboeqzywM1Rp2nvB
 yCoYFp0yXumDCQ39Rlrx9yqG2klAU6tIBULYIoVUi4ZmZjCw7rf9bZHU5jTeEUtVr474djSv9mt
 Ug1CgOgu55SNt7kQTbSLjcDw515clqu/OpDqrpOBd0vWOeQfjswO8+W8B3F4iIhd/e5n8Mr0jal
 bOSVowmaOEpFo1J5FzGKSXeeiDHdKsCuNuKnrqipX4Db+ozT1kMaVe3ZxqGJQuHTFku7g5h6eTL
 fPwzYQfurhF8McsRrWA==
X-Proofpoint-GUID: uwJsiUCIPR1GZMLm6qTmTR7Dp0n_RtVb
X-Proofpoint-ORIG-GUID: uwJsiUCIPR1GZMLm6qTmTR7Dp0n_RtVb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE2MyBTYWx0ZWRfX2M3TCDBR/0rB
 XcOysUQxMDpk1oiWxUeQCIrp7dVzGoM04BJaV62a4vnwQHVd+xZD9fCy0RNQbKYnC2H/EvsWDnI
 VSgbhsLPImhwOA1kiGXc5wl14Qhjzrs=
X-Authority-Analysis: v=2.4 cv=R9oz39RX c=1 sm=1 tr=0 ts=6a9718d6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=9RFj_TVZPX-0q0BI6RcA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010163
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

On 9/1/2026 10:33 AM, Brian Cain wrote:
> Interrupts 3 through 5 are routed to guest mode when CCR:GIE and the
> matching CCR:VV bit are set.  Enter through GEVB rather than EVB,
> record the pre-entry state in GSR and the return address in GELR, and
> read the vector ID from the l2vic.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/reg_fields_def.h.inc |  7 +++
>  target/hexagon/cpu.c                |  5 ++
>  target/hexagon/hex_interrupts.c     | 91 ++++++++++++++++++++++++++---
>  3 files changed, 96 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

