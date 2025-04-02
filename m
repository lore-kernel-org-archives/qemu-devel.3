Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9EBC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 16:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u00qz-0004N7-Nh; Wed, 02 Apr 2025 12:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u00qx-0004Mx-SH
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:22:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u00qu-0004Bn-U6
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:22:10 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532AtCAt032650
 for <qemu-devel@nongnu.org>; Wed, 2 Apr 2025 16:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wweRBBnlanTkT3JY/i3GH8wc+I/XSFhUcAg07aET+Xw=; b=dZoItik5wdOTRXQu
 LqlR1Xi4M2MdC2Fl4ba7cv9i8nWObYx3hUD9gtvGeR4PqFrbMpH4xLjV0bzubzQQ
 0UIT5Cd9uKnKISf6RPCm4hd3r16JZghJ6k1DHT58O6H9yKuBRlsQ5O1KERQvuEJY
 sS+jgGz9DZjoR/04rqlvNC+A0MMnz86E8buRt/UDpRl5i6r6KlSy2jNRqNo1e9sw
 28ObVJ1wleSQ+pDP8rWQqpoO7dqXPShyagrpdWaBzp3/szZrTtDESJzCSejdM+Gc
 Xvkzwc6HPp6z413CgVSiL2u2zo5GE+UYWSPiwvGT2Q1s4ap0luNd+08ScpHG67dh
 9fcqZw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qmbmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 16:22:07 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7369b559169so194498b3a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 09:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743610925; x=1744215725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wweRBBnlanTkT3JY/i3GH8wc+I/XSFhUcAg07aET+Xw=;
 b=wmLNg45ZqfutSqN4vUpEtjI483VXa5CGGYm2DuqbQHKjr75D8+A1sMMdpFW0SyEpOi
 ZWF9YzXeyh/Anszcuxqv7n0U1iUQzY4nc6fn6ocH2XBXeE8kJ9bIiIuek+tcJIXrAF8J
 3o6DuB5WNxGnWqeMTDcF5r7tbeF+JDj0GM2UOilBKOqZdkLHTw4xeoVyeluyCSPYKJLG
 KHOdfZHKGAGIxUUPgKpiHuvjgoc500imIFfDYgj3R38xftPo87Fz8wQ7ozt4gL0f/YF1
 2sAiA+qtUhF5DEkoPMjThEziJIIK/Kj3bhthGMJZvOEoMu06d7g4k/qLRBC/ZortqPtc
 Miqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl+we3OnGI6Ik8H05+MNQ2SPUTEWNBe13CzLA8XVCe5OBRPIsiKSsa1Rpyv98Dw9KunbRYIFA34ytF@nongnu.org
X-Gm-Message-State: AOJu0Yzxmtf48b34JWMerfA2365fu+WB5L5nQXPnxAc5HtFmXdGPGy6T
 AWD0SivsY5HyFkSdeRjqoe2r/i+pdI4MfkUPx/1JBn6TEBQLyb2Y3k8qrEUvz90Ox+m+TpEP50M
 lR4DbTGBbJIRuSCZa3J5sLGPJAHjLF3pDT26G/2onNvy25w+xCXm1nw==
X-Gm-Gg: ASbGncv91GYcDVEWgoZGVE2ljPItZ4jUTFtjsMdcSzRlj3HXpSobj0NR4eW9JC2P1W4
 FIFb7SDEmFQXQyHbGfq2pxK7mnIntEvRH1fAhidwLb3LHTQd3/aynG94ZLEdmHuFyVRElUt4j4D
 jxdSBbFxChX24LiyUc6/bhc0uU2GJgdw64gH4tdxVIEAD9lDHVMcLQGch8AW1rFVlEoPPLNt1E9
 W2hyTpsjZxzp9yAiM/5tZT2UJFmDjxpuupTKE+d0dof1dmsYHT9yrBOdoYMncMI33R9rYj/SlFj
 9ruWAS329NeXu+mNQGMHfSxyPvfjtqgUmigejyp1e4hLB/qjQax/1UjyU+kix6u4PeOU9+R+bQ=
 =
X-Received: by 2002:a05:6a21:9007:b0:1f5:9098:e42e with SMTP id
 adf61e73a8af0-2009f5c4aabmr31110499637.7.1743610925523; 
 Wed, 02 Apr 2025 09:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQtv/8OHXV/CL0NecOk821Ojkj/hRyroyWhEFXye1XFE+qRTfttwtTYmD31V9XPidX+9twHQ==
X-Received: by 2002:a05:6a21:9007:b0:1f5:9098:e42e with SMTP id
 adf61e73a8af0-2009f5c4aabmr31110469637.7.1743610925184; 
 Wed, 02 Apr 2025 09:22:05 -0700 (PDT)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b67e754sm10115510a12.6.2025.04.02.09.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 09:22:04 -0700 (PDT)
Message-ID: <008c502b-149c-4e2d-aae9-662972252ab4@oss.qualcomm.com>
Date: Wed, 2 Apr 2025 11:22:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/hexagon: Only indent on linux
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, philmd@linaro.org
References: <20250402114259.21953-1-anjo@rev.ng>
 <20250402114259.21953-3-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20250402114259.21953-3-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67ed642f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=ROwaXN-vyRnR6IyvWhYA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: IaDxjky87L3BvoevKFB4sz4Dr9qfRSSi
X-Proofpoint-GUID: IaDxjky87L3BvoevKFB4sz4Dr9qfRSSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020104
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 4/2/2025 6:42 AM, Anton Johansson wrote:
> indent on macOS, installed via homebrew, doesn't support -linux. Only
> run indent on linux hosts.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index abcf00ca1f..d26787a9b9 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -324,7 +324,7 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
>       )
>   
>       indent = find_program('indent', required: false)
> -    if indent.found()
> +    if indent.found() and host_os == 'linux'
>           idef_generated_tcg_c = custom_target(
>               'indent',
>               input: idef_generated_tcg[0],

