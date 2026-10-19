Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C705606A320
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eLWH4cmj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gznr0iN9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIveR-0003gp-FJ; Mon, 19 Oct 2026 18:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIveM-0003ZV-Nn
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:16:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIveL-00024A-0B
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:16:10 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZN763070775
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /7BGAN2aKP1jR479XqjFwn8hxW71fF2zZ9x6xHhpESE=; b=eLWH4cmjquW7/b+U
 zvs/+Ojm696bs1pVVSduDZWYsKRtSUIj2McJdt2nppaHKrZ5xa98CH++XNk5b6ZZ
 NPS68zDxDo02BBIJ95Mb0cYmt7+uKw/G9tx9zn23TSE7ssEoZvqvVr4ssMntJBxI
 3tfqDXcUg3JXBrWWujCpvtIivXDREpebjThu7yZcV5Ef/Bl0X7oXNvphtmRpBVO2
 Dyx2dTBErpTgig7/4hc4E4qtvBAvjM2bQtn7xgbkjW8lwXSTTreqS+TwHurJnLxe
 abjXF7tpDF0jTjCVxoTKgWP9kmEt59E/9V8IvkZJRKyPign7aa3tN4iQHDFrUijs
 8x1tqw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr3p0vyq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:16:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35cbea41088so4338982eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792448165; x=1793052965; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/7BGAN2aKP1jR479XqjFwn8hxW71fF2zZ9x6xHhpESE=;
 b=Gznr0iN9IEQUSR85anDcWyDVal/b2bOlssbhBIDdEF/xFY9/k7VWuOKKPTLRO5UQ49
 uDUoOvBJ6mPh2Z7txyTIUXOlUCX/FSjDyO8iH3D810x12mEfKZrTTHCP633kZQn2EDJa
 Rok9UAbBIFN4Crwjs/SI0wGo8g/IA0XRsoSIM8C6wJZC2AyDU7GFpyGTux9KZTTV5Cag
 YQ6fU2kviA4YvJj9ofcdKKBi34yvcStf2z2bIHVPUIsn58bqO/3s7GzHmMfOm/10H9B+
 kPBiFJEVnANdv41doAehmi6eEeRMsdSHCvQbBKM4A638vw5TazBS5t23ns0Pn1IhllRL
 IxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792448165; x=1793052965;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/7BGAN2aKP1jR479XqjFwn8hxW71fF2zZ9x6xHhpESE=;
 b=1SKF7ptfJq8VQxcG+7wHNSimAKz5luoEJLJA6SdonRl8RVQOUusRpIbbvG+GB422TJ
 A4eUzjbJ8hYVwL9UVy5q8uWsUOXGX5HIjUp1W0g5FwC20ISjwkrwW9sJPPoWy2HMVWuN
 ZylfxfZLt1QhuvmIBXfTtNrMGHTVi71ZjeWJcRJtoa9orDtMoRr/KoK0h6i3egzH0Kin
 ayzMgoTY8EZyyKN1loc6bQSSP2ffqx4Mt9K8U4SWPXwmctJJbZJWfUw43XVhwpmx7Rj/
 znMq3yJwL2Qas5vhaySDKA3D2TkABq0H1qPH82xwF9DizLbkTMHf2Zo7CclyAtA6K1Ky
 eOwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBylzfEBNXmOExFinwhtHPGa1vjO0rCzuqhtpnxTIgQmSZb5gecAQkGEGbCJleLYHV9hpEDzqKCAA1a3@nongnu.org
X-Gm-Message-State: AFq9FYJpKg7CIRKEw/LfHHXg8pyLTxzCgBuP2JhqGVotAYBJeNOj6JGY
 xuLc5+0DzbU5c9OngZKg1IOF6j6G9MYaRiN2AvDJiVEXE+P0VYCjWIB9CGmrVh4WGLQh4774E3s
 EUyPEGG5YK6n/L+cq3VknlyYoCSBXX1GkXcEyq1HE7c5e9h202iZhrLDqBQ==
X-Gm-Gg: AYBFou1rRHWXJXNPNnok4yzen9o3iCF4CjdC/h0rBiZ7d9WraPo6WE1LjrEytUOio52
 Djx854ozDxJ/46W9YgWFxEoxuMSl93BUrATwL8YSZ302QYo+AMF1CGLSMjj1pfKQwfQQGsfCgzy
 /cctXmDSGntj6lLeDC64VMBw67dAE+xxtfe2WOSRq4BMbu5xMdXmwPMENKztZx3PYvPa6QZho1q
 MWm9n0fdPUeD+Vgl5BRPcI58Tuda4l4tvmtYFBUl4t1nIbXzR1G7c9elN+WqOQXkuEXwbz/sdT4
 RnJwr1PyFLshh5DnceclkPABn5miJw6eOFWQfG2QjdPw0pr6D0jkHyxYRmcab40Yu3MMYaQSrd0
 xbVTSWzXlJjxvA+8SfaV0xbX6+C4qniybnBO9IEiZD7uXTsIy6s23NMwpNyuLOrj3sj8TtQ==
X-Received: by 2002:a05:693c:66c2:20b0:35c:e696:2d4a with SMTP id
 5a478bee46e88-361a2548b1dmr13248051eec.24.1792448165397; 
 Mon, 19 Oct 2026 15:16:05 -0700 (PDT)
X-Received: by 2002:a05:693c:66c2:20b0:35c:e696:2d4a with SMTP id
 5a478bee46e88-361a2548b1dmr13248016eec.24.1792448164720; 
 Mon, 19 Oct 2026 15:16:04 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm58453842eec.28.2026.10.19.15.16.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:16:03 -0700 (PDT)
Message-ID: <bb95e026-5ffb-478c-a937-35e878230844@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:16:02 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] hw/hexagon: add v79NA1 machine
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-12-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019055245.1457795-12-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FXvq0MLFg2cscfQW2DkRS3xXgiR8tA2A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfXxXu1B+dp4Qmc
 X3gi4zG3uTwVAVNCTSeS3ciYfPS5TmgyHdBdfPxP1aj66UeUgWahj6Wb0fwHnoIOjgfNUbLE/kb
 E7UXiPIyZDQVaMBAjDV47l6fzIEFrBpaof5ha5/823YwMI2vui+YXlat7sL3sQXWqH5ZQUR2Hz3
 3+G1x3uczSlTeoFQYbUnMDulnGRiNZdjga15dIqTkyUe/Frvm+I34bMbV747/XJ7IIj8O9eokho
 4JCgS8UWhNC25tBQfHgTJZFXGteuNYdeE1JHQsSyLOK3T2ODFO1Fuvmzf2yR8+YLYZdDTmvvYGE
 JvBHyMxeAvk9WXwNrryhWArTow0zPstYTwa7cTjA+POtxNSsNzIi9CwL/ocpUrFyXma5/O6/b4g
 XtwLtspGHqtolv1lZbHRJsjrnZ1Q4W2kdGE3vhcU3m5i9FKq0t6yxi/mWBDJdeiEMjxJ80I8KMb
 Py52AZ+yZPqrGtuRSpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX41OKsVrkVoCJ
 m4amamrcdUzo+GflYaRY+Gk4jZI5zUuEgYq5onrLVezoywodaxPI2tZ9art6fxfVRy3rCrmeniK
 LPaRI9d/ZqEGu6/O/4AokQZ7sK/JW68=
X-Authority-Analysis: v=2.4 cv=HLxWhYtv c=1 sm=1 tr=0 ts=6ad696a6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=pYoj84qLBHbwk84hImEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: FXvq0MLFg2cscfQW2DkRS3xXgiR8tA2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190088
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

On 10/18/2026 10:52 PM, Brian Cain wrote:
> Add the Hexagon V79NA_1 simulator machine, with the config table of the
> v79 core and eight CPUs by default.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h         |  1 +
>  hw/hexagon/machine_cfg_v79na_1.h.inc | 34 ++++++++++++++++++++++++++++
>  hw/hexagon/hexagon_dsp.c             | 22 ++++++++++++++++++
>  3 files changed, 57 insertions(+)
>  create mode 100644 hw/hexagon/machine_cfg_v79na_1.h.inc
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

