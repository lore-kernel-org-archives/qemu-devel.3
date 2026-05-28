Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E820CCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgS3-0008Np-4m; Thu, 28 May 2026 15:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgS1-0008ND-4h
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:31:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgRz-0003LM-IW
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:31:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SH2bh8124476
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t1Jk81f+fiJoa3nnTexbHQVufOfsFrYedpgweaur4ec=; b=a6CZ+GfjzSSDasAq
 EwqSArT5OyymClaRagStid9lDInnHp9cF9gK49vL2BbqMUHK+yDOTFeIeoNCcw5s
 zrQdU2+MCwHqwMl+69z+dfx600yeX9NqElAH0vDvIHtFzPuK1PDcnXRqBE1J2ybV
 fXxoYVT4KOjsrCR/VDB9E8midyYIkvs6iOqHzyr9mITR8h3V2ayYDP5brnTYdq2Z
 syhx+C10Y9j+xFN9hH07MLqyGKhytE6pvyNOwVYMuOFD4U04H/qW+B6tpQG2RTjh
 MeK4uZc4mFIATgpMgauafkyjAjXo8pKTScL4Q3ZatYbX8n3iaeOi6nTRWTUfnd4T
 Sz7VVw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yccd9p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:31:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304448ab58cso10431421eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779996685; x=1780601485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t1Jk81f+fiJoa3nnTexbHQVufOfsFrYedpgweaur4ec=;
 b=EVSVxCRAu2CpReKypKCZg8zjQL7t/a/TzgZcaLkIRaaQxHUcp/dhM6hqi+DR+8XBMC
 mvJHSzhsO7jU6IayZu5lmCIsCWV763FWy+qMkDTxvrxuIk30lw+X8Q9UA5D2x7glpopO
 8Bg4qg0P9aAk95cpcWpcJZAi3OLcBb0+nBu+HI7l4z5S9wldgAJL3GcFYrpC20zLflWC
 +bT8df9I3ocq6ioNCcW/2OUXZNTIr1EcJNYMhD/NX5TzDwt+9/aEKnCcbQlWtifzgX66
 fXLKGTzhVM9Y6GnmQZ2A/XCHLAoJvqLV+BuZBu2ybxNPkRXfw8Vta3T+aFifJdbCG3zr
 vsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779996685; x=1780601485;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t1Jk81f+fiJoa3nnTexbHQVufOfsFrYedpgweaur4ec=;
 b=PG0m1bp2IYaHfqwzaMdpIuczaf/J+1+qbKWTNF7NMAGPFMiyV8kx28aQSDbDdr4Plq
 iNkcUmQ7qw06jcx9654PsCP2+8bTzxw2UR1mWCeySzCKZo/V6nW183Jh75eV8Jv1mKc0
 eo/5YZWCP1o+Yd+y0ynHJcaOnvJFHQ/YXUD/kDvNc798uCzJSOzmFrJxXWxUDO/iHGO5
 9JIIZzZvfUzWiewiDq6FpR4k0iqPEtDDNTKdoMVtyAlpTDNtkD52PVTzziefhR/vVSP6
 sfQy4tIYf5Xh6ero2RtezpyOZ9fpVUGqNajkAYVqTabCZVSfScnGYg76Ix5SGKWZfTLS
 ihvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UllftbD4hsEd50tF8hyoSRogMPV9pa6K4b2HjqVgZ0bZGuRN4H+WM3PJXQNJcf9prSRKgEXrZRQzA@nongnu.org
X-Gm-Message-State: AOJu0YxvwIleGbRBIPKLTk+k+hIOTq/zSJHV0WAF4mHsyyj9kLdGQnl5
 R5wuCb7Nwb7GnP+v4+72Q/ufbOMAZjNZutt9nmqp+o9T9m3abMAsJBjaI/wpEDud4UvDZC0bvQ/
 zvYTDluO5UhrJ5pfRjKKDOMN2zW3J9cUGLPiqZeaOjp6FYRXLuqcUJa8rPg==
X-Gm-Gg: Acq92OGijK8eV63mit7J3pR3yTpOn38L2UZ1acxRd1CtG4f5RNGK1aatOs/ptb/Ww5d
 ypJFKc/c+M5mGEZIzFNra8CFuWrsIerJ5N0yT4xaUGuCshT0VGHYXHdYnWX8Tq8GA8qAD4C2rB+
 DT8dFSnzB16/UPDwE60Cs2dKjIPOlYgei8qiX8yUaNv3pz8s+h+apFdTZ2t3mAQInMHJMfj3tVe
 P5fSueD8IK2skzN+GngRKi0vlOzBjvxkdCDvNVQ41YF10V0APJG2bvNCKIhnzR2I+8YJdTk51S5
 uHtgOnDzkrbJmnDKthO+/4FTnvtNUDZRNtbtXGgj6SqVMyJBPfqeXEbLcgVTPNLsbUmuJZPfh+E
 H7BcMTJ6ELSMQKuQgEktf9KCyd1YQFwPelBt7JmuUpEIN/hSLked2Ol+7LUsxqea+d8n1UIy7VU
 N5t4hLYrcyMis0I5xPX7p40EhO
X-Received: by 2002:a05:7300:6143:b0:304:e72a:d4d9 with SMTP id
 5a478bee46e88-304e8c38c2amr229930eec.19.1779996685366; 
 Thu, 28 May 2026 12:31:25 -0700 (PDT)
X-Received: by 2002:a05:7300:6143:b0:304:e72a:d4d9 with SMTP id
 5a478bee46e88-304e8c38c2amr229908eec.19.1779996684759; 
 Thu, 28 May 2026 12:31:24 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e98c7821sm98440eec.19.2026.05.28.12.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:31:24 -0700 (PDT)
Message-ID: <3c4177d1-398f-4710-b10b-4303f5e9232d@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:31:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/12] hw/riscv/boot: Honour data endianness
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-11-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260527201348.29511-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VOntWdPX c=1 sm=1 tr=0 ts=6a18980e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=ALku5c8DAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=4ggAUwVCEv-4EGQgTU4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=Skunnq644UPbuD6fT1yj:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jSXhL9NscR1G_nbMimox2dfBkKu6vEtO
X-Proofpoint-ORIG-GUID: jSXhL9NscR1G_nbMimox2dfBkKu6vEtO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5NiBTYWx0ZWRfX1/Q88sNSSmze
 3PyXWezBSqkw9hXRd8Odn3MdNuQRFNB+hGbRPBuZA0ukABTLmZIJ+Ozr7hc7BfaYf3uMVUG+pJ2
 sIL9869kddGoNlFNuu/DrLDpH3azPW7m2lotRN9jlbwGw0wSoVuDl1Av7VHm6pD4ABpCivYKswG
 aTPKgacs6OUv99hiO/ilhqBn2Ydp0pgqRMR7gydOkOMDSS7+1KQRpi3SVpFkUn8ADiMACzi1jLn
 3i2INtPRvZDEarrSferiM7uhMIcmvC044XosTXHFw1E2lUpruF1HlltbKZCnR+XMVLDVVcWZy88
 pZGOUcVUNJO3rXVHHle0eXohT7W7WXDlAULwDBErTLzJAg4XMHRebe6gSogbTTi8KplqI7r9EUa
 lMatzRF0H4I04HCi1EV+PDVxEcR1kIBXKneLTJs3raYk4rb9Hpzvue9rgDEK/7m/uaCpZ4ohhu0
 OQ+6CrsCxDUSnHEHXQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280196
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

On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
> From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
> 
> Check the hart endianness property and use it throughout the boot code:
> 
> - ELF loading: pass ELFDATA2MSB or ELFDATA2LSB based on endianness
> - Firmware dynamic info
> - Reset vector: instructions (entries 0-5) remain always little-endian,
>   data words (entries 6-9) use target data endianness.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/riscv/boot.c | 40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

