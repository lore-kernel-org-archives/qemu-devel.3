Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24179CD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ4gX-0006SL-Lw; Mon, 15 Jun 2026 06:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ4gV-0006SD-Ao
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:36:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ4gT-0007Qz-SS
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:36:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAM9QE071174
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6V9P4HoK7pXHiQy3ITAKjltEkhZyFv7CIU3ho6ptFUY=; b=NcS2idD1fFdHNbOL
 v2IlCwwX+ukQqrXhNqFel8m/ot1jVf208XL48/h0o016wA2XaiS/Hz5xw8dmGZh0
 yjRp4yiISMLvCV2xi41d6aKTMDNuwsEpZAnHdO1AtbkMautcNe8YaPKNWatuCqBQ
 iZz37dJ7yB3EeCRlzURcXpN4oGnmtY8iIVgLf4Dh3H/4GBJ57BnNBvj8wiMzAdHB
 sQ6+pfIA13CowjLOmfWrJwZhU4h8Nh4jVqrZHo9vekemEtJJFOiI2kRql9eWLPuq
 Gs+elPSqWBJCHdfIPU84eIezXzfXKTA2W/qhpktiumb1J63nOfjIuQhjr/uUGg6k
 +luaBg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx083u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:36:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51787404d3eso68866611cf.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 03:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781519807; x=1782124607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6V9P4HoK7pXHiQy3ITAKjltEkhZyFv7CIU3ho6ptFUY=;
 b=j/EUwJ0Gj3Ty7jrx8oW1rIGROqcSNWBGg8NPqUj80v5FGCEtAwwQv0ArgQBBMCpuLU
 9OcEunDTVo+eIURhGP48ObZnzLCg9e2W6oyQ5a2cHrH2/QGO5EjDpkvmegn7vF7M0LJ0
 FZxJXuPEbwj5gUyn0KGKSFH5E/ug0PUX8XuXV2RAU1/R2Utzh+EXacZU0BVikPeYd3pW
 h+M/oi3m3gj1zjDs6TzZZP6VZBrFTcPpvSK8AbM5qIxx+/nBKIUsoOkrCgO0gRjHY0+D
 qmMqtY11+fVCJ88yRG9p7G+polgXtxOW7bSZtk/cQ2bSbWRBzJ1E9k1bEHK208GCSTLV
 S/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781519807; x=1782124607;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6V9P4HoK7pXHiQy3ITAKjltEkhZyFv7CIU3ho6ptFUY=;
 b=fAU3WeEARwVWo1JV/XLdYtrUkUzo0iR/OVt4oys6QZU19J+1xgr6IbgAb4CcBq8g8Z
 zQBIkqJfIdUFIfx2wa+1Dg8r6ADyn5clzCJTLtR/ii2QEsxtUGJjQqb+THsMzlS6CuzE
 YSYzSlTsKgIs3a6z1We/sSjrxfeJzN6qSTtSQWuyTX6Zu1oY+TlrbM374ww6rtGFWkaj
 cGWIOocl85RfLVQR5t7VMvZOUwg7ByD5PAZ4tGAU0B6oXmfXoB5l+Mzyk04/wC4zdVPJ
 QBg/Sef44HQkJzQlEKO8tRk9uHMeIunHGi/wgUcGWVGNgvsvRujE/0KbwXZd5vs4ro+e
 hCRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qdBIO6L3wl+1wydfEEkvOyw13jm8JEcdDxpDW3r1Ar+NlOUjs8vzLj0A/u/zeNX1X3kHAe1vaaFYt@nongnu.org
X-Gm-Message-State: AOJu0Ywp4R9hweslugDZtc4sutnZ0AhJt0iVPYLxP+Xuahieg+e8bsKQ
 6JaGX3Qf4oZJW4UusouUV5Lhxlze+WRYDtVEi7ybYdh6eTfKnA1zGKdGvM2tqaFKMel1rxZnrzr
 LbEBIQx8z6P7jQNAt+VCPQHrYvpcYpR0jkkGHE5fhkDR9VeezxFttPx0pCA==
X-Gm-Gg: Acq92OH7BDKWKfOk1qOL+4uUZci5edysOetp0cKB2H3PJnmZpVgvJMgjgOT8CdnVlsw
 gdMwyhQw4uxBfIMtyLxkAcQP3NkItWXxfmU65596fCdcTAsuq1mRWM9o/+eiULcBk6/QHlZnu9B
 whKigt2vfql1CFhpd8FDHFD+koAqUrZoFlouMA1mkWmhpcJ2Mlm/MADdVMdgV2Iq+v+tWb0urfg
 4CRQwuhfLaL+n6gBJ/Wm2yf+176ZvKTaDTciF08zo/BBdeYG/O10WBoqs2T4dQoI0D0IQ8PZAne
 Guf9W/fNKcdZzdZ3mCvBObaHPj0u5anjhbALOxHJPu4ehl6OAIJBFfyxBu2jIaviF+J3GdKvsmJ
 xetrDSi5H0La3QL5pI4Tov924IW9BnJJ/FH4EZEfjhaJmp81f6Gur888siXFD3ReZiksVWdI2
X-Received: by 2002:a05:620a:f0b:b0:90f:5da3:950e with SMTP id
 af79cd13be357-9161baf48a4mr2041022785a.9.1781519807426; 
 Mon, 15 Jun 2026 03:36:47 -0700 (PDT)
X-Received: by 2002:a05:620a:f0b:b0:90f:5da3:950e with SMTP id
 af79cd13be357-9161baf48a4mr2041017785a.9.1781519806911; 
 Mon, 15 Jun 2026 03:36:46 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb4b22b21sm443911466b.16.2026.06.15.03.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 03:36:46 -0700 (PDT)
Message-ID: <b0de2ea9-071d-4d48-bbdd-df6ee9fc4a1c@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] python/qemu: split arg between base and harness lists
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260614100902.885698-1-alex.bennee@linaro.org>
 <20260614100902.885698-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260614100902.885698-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qf0dDiWem6ar442qJhwg55mUu0nNE_4D
X-Proofpoint-GUID: qf0dDiWem6ar442qJhwg55mUu0nNE_4D
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a2fd5bf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDExMSBTYWx0ZWRfX9f1elqSl+ww+
 5ZmT4NZBiYrjYpCNHg1EMT4KkbGasIXtTVPVyDxJVDyZKZw9tPc9wcgLE742FT58zk77o3I51go
 LHSe5S7xohkK4WXJpVL6XuI7OKTPOZc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDExMSBTYWx0ZWRfXwroSLG3IE6Z/
 VMOA3quduT+a7UqB/C0ycChFE3LLFXN8UqlT+d51zBO4QguRVVW+MvQRjGcZH875gY5mGf4ZvNC
 Bb+7MhZbPndyf5x2Q1MO0J9uYvskGPzvLFiC9CjKc/CTn+PPEusWaFVQOW+byANFWJ2cT8wwEI2
 XlAnK4zh00KL44plAUN5KsTsg3e73oOA7deFhCz6RD3wl1zssoKDPaLs/eDOYMjScusYGzcHu3K
 uNpJlgfkhM+IpogB+wEveHkapwMqwJRdw+Gygwe7AIRok+f2WvSJmuXfejbPexEXrVL++THyFoA
 nN4Be68GG6ldJTERFun/MTSfjaK2+bNfdhTRPsrURqVZBZwOZ/DzEZglwm7sNY9uAjzhJ8z3FPG
 1t6w7kTIUHqHWC0cfwrNOFMPnRMkExQGxA+RkNzu8PV3U6usqveMHfAk+121GEyUKObC+5hHNXo
 oE2g3VvhKz9j4eb2eqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150111
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 14/6/26 12:08, Alex BennÃ©e wrote:
> There are argument we add because we want the test harness to control
> QEMU and arguments we default for handling the display and machine
> type. Split the obvious ones between base_args and a new list called
> harness_args.
> 
> We will leave the complexity of the serial ports for now.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   python/qemu/machine/machine.py | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

