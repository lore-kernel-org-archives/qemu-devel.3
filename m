Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6202C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5Yx-0007rP-TM; Wed, 14 Oct 2026 16:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5Ym-0007ol-CL
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:26:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5Yk-0005p3-Qx
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:26:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbQhP3813076
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u37xyhW8v05r9LgAje0iPqa7yDp1LoOkxoLLao8V8Bw=; b=Jzrol2rob0Orlkxt
 cD4lbK8pucD0ndZxLYQ43+9rL1YRQKO4a1GW6QFdcO6JC5RMmzcaIQQ1V2EJM3Io
 y3bxhx9mGSh2OBB3QLbEUdIys3X+MFRlbyG5hoWMUHpqg3kdkpsGd6CnIrj7DSGe
 o2o6+gynBDFfmjuQr+5Tomh7OXTzWvcV/Mbf+1G5sX9xTG1BzhnP8lKcgF0iZvLS
 PHNDYLBPxAc6Q2QmzGf9UqarOG0Ee6NN99DX9MMFxS8cYB+8ILupSh9k+W5vCjCn
 LTqf3biTmXkfcUdR3ZSxnwyBRPJ/7RqzeA2xVJMMBBdyoIPjNEMoYhj7vs+isTlL
 kWx/Kw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46u3dkm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:26:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3592749a017so1341414eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792009604; x=1792614404; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u37xyhW8v05r9LgAje0iPqa7yDp1LoOkxoLLao8V8Bw=;
 b=EcGAHarWJxVgs9G7Y1gtc32j/um+GeDnFSMi+vD8Gh6tjMeUfCr6aq8cegzqcCW5hk
 YlC84jOFIT+MDIuLAB191Y4QbisZRjSAJdPXiN39f6eVfmT4cqgWwuJ1JCrpyB9QMF5h
 VY6/ygem+vxNb66VeBW2Z4VLtwK2wvpoE4CS3vaYTlg6DDVha2iSAFubn6LydrnyM/tq
 jT6T/w9qSwhBDn8hwxexMhGaTxiJUkWXHRGwmv0FO80iHc6HeWC1jwCeiS7xvgcRNrGJ
 LSgt14Ekg8WOp2LDkd24bEMsIKd+mGfN5misgQMkfmk9gFVVU470kt0LUkUkjkB1vlMt
 SafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792009604; x=1792614404;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u37xyhW8v05r9LgAje0iPqa7yDp1LoOkxoLLao8V8Bw=;
 b=ZB5wPqwtLwq8I/SYt17hERQri7CQQB0WbS7lQQyvidFgbmnE8XOT2DgLvPmJxydHN4
 73FzWyE/gpFnKS8DiwetggIk5p2e2Ktc8cuxMWyhDLmuWABSgA8Em7TTx9rwnkdCWEe7
 mVNjkQkZnTgHlVav317K+7eOseB2Ayoe3QihL4aqKEgMpgq3mQrMIoUW0Hnw9etnGpdc
 T+s3MIekWPEKfpw3IDbPDAIIs2z9I1y9J7evZdD/cjYO8NrxPIDBWD13DB1brU096u7b
 rspCRlkluBPeHyXExugfl9gEN5P+okZWG2I4gutnPbIQhNN9c9gw/AqIJY/7EVPkDhex
 WomA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+NSQgSxsiU62GmW1Asz2ooxXDJxowIx8P5yWPkyw2oZle5tsb31cA70XPbg09J66yP0P2TunNCGmb@nongnu.org
X-Gm-Message-State: AFq9FYJeKhvtzLXdtF1SPHbtVM0uAb5Q3/9l4K/cdXrlWf7Aqhk1Brde
 f7hiwEsZHRYN3Z4mrQGSwgqNBakTxNvOGs0cIdslU1wkwM/B+Gdieqp7VhtlFeA5AP3bUB4KDHO
 +O1UFQlQM5MqRsRL9jm7e+nNKGWsTKGctXLjOIeZz2mo7Dasz4azSl4yGPennekyZ4g==
X-Gm-Gg: AYBFou13avz6dI99mKrbJaKIPz5D/gEKCTzDZKD5vMw5+inFVBOc2jiNuIBYMXJWQFw
 nbSGBRkuajCS2TgWVGP0EiDz9MNfCoYXroPqXtwqUfU1WBV34gbyKTbiTJ5rfosd6OUpVSPhPCM
 ewl322jKyvlKOzrFy0oEFLN5FDFxxN+RmfRZEo/z4+6ovDKO0iAyMej3hQNwY2ePYYBCxvGZLkz
 SYEJCWbAuqZf9MiaYS0Y7T+5X6Gpb///0oNwYWLNeBYT7EBTZZEeFq8WKwXa8Hm98P9Qeund5Fa
 7EfXRnmrF2oC7N8oLox9UGd/V0JETIYyamuKBwgRj2FAc4XVJ9JZe4Zhvu0zR9j2OJMVbpb0VTD
 bGTKsssE5hIOM4rZiJkz2yCC+L9wRc9yHjl5uFVnnPFk87s7v5xosPe91n8N+9IWbZMwmXg==
X-Received: by 2002:a05:693c:87cd:20b0:353:5d7a:cabe with SMTP id
 5a478bee46e88-3536c53930dmr25486149eec.13.1792009604272; 
 Wed, 14 Oct 2026 13:26:44 -0700 (PDT)
X-Received: by 2002:a05:693c:87cd:20b0:353:5d7a:cabe with SMTP id
 5a478bee46e88-3536c53930dmr25486116eec.13.1792009603671; 
 Wed, 14 Oct 2026 13:26:43 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb2fd33sm54701651eec.28.2026.10.14.13.26.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:26:43 -0700 (PDT)
Message-ID: <d231e5ba-d21a-416a-bc2e-947c446b8295@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:26:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] target/hexagon: remove packet-count PCYCLE
 implementation
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261014194106.3205338-1-brian.cain@oss.qualcomm.com>
 <20261014194106.3205338-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014194106.3205338-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX/q+7vY9goWvr
 AP7sU2SMbQMPAVwJ+KCO8GFcLBZbzlaAOJH57pKInjoerUdptuhnwZ616eYj8WGHabK27APr5SY
 3RhHri6888kO8YCmtc3NWOYas0Zxak8=
X-Proofpoint-GUID: u0fs9Nef8LpAq7rAFiB2AiNr9hvgqEW6
X-Authority-Analysis: v=2.4 cv=Y6ttIReN c=1 sm=1 tr=0 ts=6acfe585 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=gvU4FTLwXV5Q6B_JPBQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX5C5JPLxtwF4x
 KQtl3/6/cs+amuwjRcHsbwCo8BSPp8eRolmjR+5W80jwgge9eCLl4VkzQ2fsF9BgVA8JDEL+/wh
 Z/QG0s5q30Dqz0VC/aVE3CmYwe7PYpNKsRmWDAji9S9T7vaDwenPuNe47Mj1kBGHNPmbDH1aC8S
 Y/TAvqoYDNXerZdM2JFoLd5kkh2CIv6Srx+iR7Tm9mlt5LWrh0zw0PWw+kDu9usdyTX1oH6o8+u
 mR13VuN8Vo4dGBKkGNA1VqL79aXWBHlaxp5QbJ9cylRAheEkVulsqF1bNm6fLhkpdCLTuu+GWxC
 sumVx5qgjNL/cRR2ohVEdfCW0sdDkSU8M8xPHf00f5ZqYE/jyMhJ9g+jNBZMAYLhJbEOJ8G72fQ
 DgohsX/6wfOTT+iN5V9GNkCBPIaBTp/ttskBPeGXw335eBuku0ZQOtRtwDpP2AGsaMwBm8SNblW
 7Hv/3R4IuneRnS00Uzw==
X-Proofpoint-ORIG-GUID: u0fs9Nef8LpAq7rAFiB2AiNr9hvgqEW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140081
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

On 10/14/2026 12:41 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h        |  2 -
>  target/hexagon/cpu_helper.h |  6 ---
>  target/hexagon/translate.h  |  2 -
>  target/hexagon/cpu.c        |  1 -
>  target/hexagon/cpu_helper.c | 79 -------------------------------------
>  target/hexagon/machine.c    |  2 +-
>  target/hexagon/translate.c  | 21 ----------
>  7 files changed, 1 insertion(+), 112 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

