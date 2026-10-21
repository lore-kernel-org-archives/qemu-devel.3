Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC0606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oXw0Okyr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A3ancS1P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZ33-00077G-36; Wed, 21 Oct 2026 12:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJZ2q-00070W-0y
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:20:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJZ2l-0004pC-Cz
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:20:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFTubb1045400
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7pVccf5x1st1Wtz5MHwGIaf6N9mPJdnj7/Zh0VgzTGA=; b=oXw0OkyrOdmSwXPh
 m3n47YaZM/INfwM8pTx/O/UshzmiuTlraIsVqrhSXC/tPRUP0LE5YQAs5CyiE0lP
 naTc4Mj/OPtR6OjEfT+oooUmHHExVJhPFdrOPgmpTUQM9BmUpNik/Mfza6PuyspO
 Swt6OgZj9dmVK8VyCMaSQkb2TG4wMOB5lBEFwdIenIirY7Q35dsqditz18vQeBBE
 vcQVauAdu6DgzqVEf0pQI9wRh5xkH1IABdfDCAUFVqdMX34ugNItI7z7Avuh/al1
 T4NylFBS0dywA0mYsbfLu6SMJ9MZoNzqLxJH1eqVQRmM6GBn+9k20xty1hjY+EWk
 O2CUHQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj49phs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:19:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35cbea41088so1643943eec.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 09:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792599597; x=1793204397; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7pVccf5x1st1Wtz5MHwGIaf6N9mPJdnj7/Zh0VgzTGA=;
 b=A3ancS1PAYZBTlIc6xKclH6wOcB6bju7z9DRvlKvJlnlAAjIIfnVMGMoHMQGDv3J79
 HiwpTtqoREzCccZEXLtBvrsAnm+EXbgU4RgBsOb/K1KZ9iTO8zlwyEuPOFke5+UiiAlD
 vWMVMbP95vq/OC0hSlgFyLf3uhLf8RKBmQJ8jLEHfo38SHeFJOY3VSOqIJYcCJgP/s/a
 +J51svtFStBnedIb8+nXln7ptIkCA/VX7DoaBnxZ6Uxs3LUDHZ3JiSDC1zH4o5r+1+Hz
 8Mr8ppJrp2KRqeryMujbkUSEPOxHaMfk2lFN4LKbW4IElCJf1RHwp2oxBsuEuMwUvuvY
 Ixnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792599597; x=1793204397;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7pVccf5x1st1Wtz5MHwGIaf6N9mPJdnj7/Zh0VgzTGA=;
 b=MxdI8ViQwLr6HD7H0dlJ8qTUc3s8tWJw3IIuaD3B6fU4Y6qiDVKyRy9TGlHUQqv2TO
 FEikS3bn9NUO+06k4XltLMuRiatNwpkxKMZ3h52h7ga84rO+qKAxJxYN5Nuzk+y7sYDh
 qi3EyUVw+/+al6jt/Ie1RjwJyZiLsian1o9unmUKTUcPjOJA/igBUDNFxqwpnNvpdACg
 v8GUFSlkdYOMD8YhfAqJj20qgAXsVn5nIZdQSiyoqJo67ACMspHcPGkwZpnVOqyvan68
 JxAHmpbbTzgoY9+DsSsjpoubPHtTd+pJa2rdR4tGdC9o73ftD3siADnp4JqBRp9/fw0G
 3ZLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxr2JK/1yVHxvppzs9PMp8iZYU3k39YstRYGsjO2OSkXdPRAtmFGhPxLRd/9V6V3qOz46pWr9loYx1I@nongnu.org
X-Gm-Message-State: AFq9FYLpmrIZoFmqsuJzKI+4bYQ+OduEVpAJI7CD6kNHcpO/5AbKi5ty
 1qvpXjFs0qBv5liIco/fF90M3UkLhAEmnkbMadZdqR4CqCMNKw1T7WKpwT66GkHUvQ696BsBT3d
 /KJ9NJF+hlP4U1MW2+gpM0cTG8DvEcNkMhJhClSJY49nKfXlF5buxmEs4Nw==
X-Gm-Gg: AYBFou3hh/rozf0q+LcZo6p2yblmRsC576VA+A6aUTNuZ9gx+Le66Unb4PFqg5XD/9k
 shV2TH0MUuLghcsnKwOjsINJUY9K82nXz8Frr/GA20aq8a2y8MxShxaoZFIFXPrYHs/vlp94ozT
 uIHeRXHuCmdotq65pIFdoAxeESJoCtmrgdQT39i52NA1e2Ev38W1soBz0adqxnivgWzvC3zVLsc
 qAFD/qDOFGUjKpQ3AuzrJlKS9kx9RaP200aoB2BzowMpr/PyPl3XxkNSU5OO5aeOjXG4gg4mq0u
 qxBxo7/CVk+XNuk+sjvk0L8vtxpDvEUMLwRAMuEiKJRAEsLRz8KU3SqPv8SL4GPiUaSNkmlYQ08
 OOr4m5nH0gcDubRzgoGi1fwkncjfMmkgP3JgzLpVSUxGuSXBXctUrxfq7+cKbfeC9sdt70w==
X-Received: by 2002:a05:7022:387:b0:175:525c:90b4 with SMTP id
 a92af1059eb24-190a50ef799mr3480668c88.20.1792599597105; 
 Wed, 21 Oct 2026 09:19:57 -0700 (PDT)
X-Received: by 2002:a05:7022:387:b0:175:525c:90b4 with SMTP id
 a92af1059eb24-190a50ef799mr3480621c88.20.1792599596537; 
 Wed, 21 Oct 2026 09:19:56 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903bf5d0a1sm7169316c88.14.2026.10.21.09.19.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 09:19:55 -0700 (PDT)
Message-ID: <c5c24e21-0836-4bf5-b5fd-848d276ac7fc@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:19:54 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/33] target/alpha: Use a static table in
 alpha_exception_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
 <20261021031407.24862-6-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261021031407.24862-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: upP38eUaMXkEkhysX_YdMQ3BfB2FJ3jb
X-Proofpoint-GUID: upP38eUaMXkEkhysX_YdMQ3BfB2FJ3jb
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad8e62d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=rpH6MXs8h_YZi1gZqq4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfX7c59aNa5+heh
 vpaHVt28GHjXGJrGVbRIKvLh4La8YGq79B7uO8bVEjk7syJI/BIvwdwt0MVMAQ2r3VXhpgfHyDM
 fDnFxKqYBR9e/EuhpcyEeiduAIeHc67uW5ehJuPNKHHttWEANVkKm+9B65EAZDdoHlxSQywz/Qe
 Doo2iAG9g5ay+bK1F25MwHZRdsmdudKNtBYkmPItgRpJ2iyeKsdIFnEILHVlJHEmjt9IYLXRtZr
 lKEDXGEc1L8RRMoVLB3OvXNwKZO9xdmvrWEQQ8qdqbd/XdArkgWYODhPoejtNqbxX6t6/uKMBpD
 WmVGpgL/XbWcaTjk6QnsyL4PhKrMiAf5UnOkycdudwCq5PSPMeJLqtyNLaSg6KUufeX8EFdjtcI
 mfr+fVuCnq+u/WojNNKMPth4mT2FvcOLACO/wiLaY/nN+6xAQybrNyZNeAKWM/qUG7q2cbL74d8
 QAjxFLLn49GFcrNWzqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfX5RBYeofLPr/8
 9VVoHxi/+Osmfv+cvkKReftEDCEX0/uHeksBS5lsFUE0/CBDMgnt07swc0ra895Fhmq9YfGIpjx
 zZe1rss1baic3LpV5Ps3aKU4st1h7N8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210065
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 10/20/2026 8:13 PM, Philippe Mathieu-Daudé wrote:
> Replace the switch statement with a static lookup table.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/alpha/helper.c | 54 +++++++++++--------------------------------
>  1 file changed, 14 insertions(+), 40 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

