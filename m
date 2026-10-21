Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5579606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bzcBMPIF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W264hJsL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJQoP-0000RU-3u; Wed, 21 Oct 2026 03:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJQo0-0000NN-PI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:32:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJQnz-0001eO-36
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:32:12 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j0pk165017
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sMmq4J+nzjq0QTDocE81yB6nLKRl/jHAgI5vukcwDew=; b=bzcBMPIF3RyeChw8
 vcRndIZaMD7Ek7TbGwjb3OopriCPmAiqR8Gc9JhmWfEYZ+tKJ2Pb/8u4FNOpRaju
 UwJc/T3KIKth1Qg+oaeMX+McBJ2qlJAJjjSPPGbudYyiBq/bZIDD+soGrJEQsKHb
 T+yE8ALx7J/dqlKpDed8G4uIvZ1GXrPOp8i6ruQbqg1eK21A3iJz0LB75NSF5yNk
 xe+d3wAUAvinvdnzMXPhyI5WtCfxZyW1fjxd/j+Yeb1LRNXTxQCWXQyCP+wwD9Mi
 R9XXnq1dJ3E0RTjyMIffR4FM1tfoxibLzOLTpBj7+zx9tEwtJGvJe8QCGylyXpvE
 SNIwQQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs01rxb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:32:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caf7856ffso114546485a.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792567929; x=1793172729; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sMmq4J+nzjq0QTDocE81yB6nLKRl/jHAgI5vukcwDew=;
 b=W264hJsLvRmcAJkaLUAS1rubsmhr0gAuJ0N/ygjb89Li3myFpC03lE/puFjITudjVV
 fFfzOhWY6kEVRozP6Nr/AgODgbBXfvM2XjJocTct7xQPg7Jdf8HQ6H2av3gVns4uvWm3
 axl9IhIJZGYku1QT8uoPknFA6DO9dapBgMBMDyOAcW51IQcCmyGl51+MOWpiIXZf1Hgu
 kNWVQ4DkIUND8OhpAs7BybQ+IeZLfBHXdLgBsorngjNi+pZiE0wuYcBh9n1SJso0OpXi
 qX1O0fIqChNDfc814zfHJd1gq4Vs6oSG+B1/aQPEGHGRk5USO42GhjzGYLzMtE4zFBa/
 0jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792567929; x=1793172729;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sMmq4J+nzjq0QTDocE81yB6nLKRl/jHAgI5vukcwDew=;
 b=Bp+yhDJLB985/F37V+2/zO749Jrxr6MjGlWVWKUzGeC61YMXwBrtDx6oHvF6qNSXk/
 T68TzsTLOeQNH+hlT2q2owWHAIDvmteEAp0Rq7daPeFS1G7eiWZcxodsv9RKYOysuFZz
 05UPybJ1GXPj8na5+flxntZt0wknoL7zLmp+nwTv5phTSbl3E1ZEcva3W37rrMZid2r7
 NaEqwzmi2XwV7s+tAvipeooxLce3ZZE6VZrMsqjqskM9kfXDYtIdkyZ5icFNTmU68cPY
 aXGye6r2Yj9MsVVPP3kkgV18XfSNW3Tlk9NhzBdMqdn7k9WJqDpp/8YOpf8rLoWqSTIF
 nC7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmpIyvMkV3is5CAl8TTzywgGokqhvt9HwqUPdNLQjZa5T3H8wCMautObh7mAHY1yTFTH/571CAjHnD@nongnu.org
X-Gm-Message-State: AFq9FYIR0+zG/enwxKRJxRUvg36SNfwl3OLPV67kEFQ87UfRiHZQtb7r
 VNubD0lnKZ3RVhyF/H0hEQfL+tHp0djhCdN3nQbB542LsyeLbS/wfTFHn8FZAbBIaAB9TbG05Is
 kA5bBIWyLNVATpvGaRLtP0meWFpUBGB0Oy/BIFZcj4hRdJtUHkqkrKZ0F0A==
X-Gm-Gg: AYBFou0RtQ2Pnfdi+bk4YNMJXb1AzPeRbH6mnRBlsO/9hSH7swXlED/fB/rsj89t5XT
 k2ujIUR+0JUnc/YnVKh637GwBDmK1ibfTzor5NSlprtyZEPQ2BdoNmC9BgtuReLR+28Oik3KEve
 gzsJbUmWYCO5zn6G4mae4QKB/2s1Zu9ySeNGtGI6VF7kQyYJZmq6yB92wmhhk8NF6Plr9Wj3mDn
 +qySwEtO8HpKXtjgDPWDIBFxFrKSstsNXnHPzRUvFX9LX3Ovhz2kE6MbdjF975ShHjwIok/1jDi
 l9jAopHCxYBAzKDe6Lblx8L1Aja2HvlocYZJnVf7EwwBN/2F5jb6vwrBcAvXc/6v6L8en4MQzhP
 B/xSNjtqC04RYgGcotuw9wp/5nW+VgG/kHw==
X-Received: by 2002:a05:620a:2989:b0:93e:e4d1:797b with SMTP id
 af79cd13be357-93f57fac2a1mr289453285a.56.1792567928940; 
 Wed, 21 Oct 2026 00:32:08 -0700 (PDT)
X-Received: by 2002:a05:620a:2989:b0:93e:e4d1:797b with SMTP id
 af79cd13be357-93f57fac2a1mr289450385a.56.1792567928481; 
 Wed, 21 Oct 2026 00:32:08 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd2eff9sm33231585e9.4.2026.10.21.00.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 00:32:07 -0700 (PDT)
Message-ID: <52ca3338-27fd-428c-8151-0c4a977b597f@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:32:06 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] target/sparc: Add the AES key expansion
 instructions
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>, qemu-riscv <qemu-riscv@nongnu.org>
References: <20261021064640.3591682-1-stian@itx.no>
 <20261021064640.3591682-5-stian@itx.no>
 <145a7086-d9eb-4cf0-a162-b3a44d51e9e6@oss.qualcomm.com>
In-Reply-To: <145a7086-d9eb-4cf0-a162-b3a44d51e9e6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad86a79 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=-GphNXiHlNH05gbp-AAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyOSBTYWx0ZWRfX1aDXZMiK7W60
 /GhAPg0nAYYUmJ0FoEkJXlQILVpT2lKe51n7z1HrEOX9Av/AfXJ1fxoiX9tg1FLE2DulOnPC2na
 wGZbR2MR+61WGjq4dfxRgvjFew9o5PhDdo3DqyVhyvFd6ZiMb1jJZKqCTJ6tp3aCrRZHuyx8ZRe
 XGwnOPoBo6OfjQocQ0Y14y+jsJElIisgIf5YOjgh1d5DuWigZt3+UhFuiRIfyk/FKDLuAfemtsz
 G4gqw/HgzLuCp8yunBp1vp33twZmoZY50kUbt9MMIbLatLIzvbkqHDqMcExbA6B1nLA3oSfdzuI
 FM6UP9rJABWG4YUg0TYSKS6PDYJXvBohAzmOD16WXARCVQ/eE0T5oU0oOmClgDlqN5ukhMZsQu1
 ysRFP+R4bhN+UsxJQwFAEs1MXvcHJ5+7PfCoG5oaYquaE3eGhiaOwGTeNfJSm931YGcyvFxxYsj
 5xBBtRqQb6BKWWem3+w==
X-Proofpoint-ORIG-GUID: 9Q64irKwqKAAfUAG_4ytUj9DH6Aq7P5L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyOSBTYWx0ZWRfXzkMruLTUWaF+
 i42kE63UHb6reUEce3H6Y0Dqd8si/LMTbwkAWjoqUuSw69Ss7x+XYVhgcQnzqQ7Ou7xujSpC+AD
 FqIhPJMK9lTy69TETFmmGVw63OJQUDU=
X-Proofpoint-GUID: 9Q64irKwqKAAfUAG_4ytUj9DH6Aq7P5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210029
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21/10/26 09:26, Philippe Mathieu-DaudÃ© wrote:
> On 21/10/26 08:46, Stian Halseth wrote:
>> Implement the AES key expansion instructions according to
>> OSA (Oracle SPARC Architecture) 2011 sections 7.3 and 7.4
>> and set the AES bit in the CFR.

        ^^^^^^^^^^^^^^^^^^^^^^^^^^
>> 4-operand form (7.3):
>> - AES_KEXPAND1
>>
>> 3-operand form (7.4):
>> - AES_KEXPAND0
>> - AES_KEXPAND2
>>
>> Like the AES round instructions, they are gated behind the
>> crypto CPU feature and disabled for sparc32.
> 
> ~ "The AES feature is now complete and exposed in the Compatibility 
> Feature Register".

Ah this is already described, nevermind :)
>>
>> Signed-off-by: Stian Halseth <stian@itx.no>
>> ---
>>   target/sparc/crypto_helper.c | 58 ++++++++++++++++++++++++++++++++++++
>>   target/sparc/helper.h        |  3 ++
>>   target/sparc/insns.decode    |  7 +++++
>>   target/sparc/translate.c     | 30 ++++++++++++++++++-
>>   4 files changed, 97 insertions(+), 1 deletion(-)

> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

