Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72D606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nEUMwo05;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BucA+NEH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJWBs-0006xs-H0; Wed, 21 Oct 2026 09:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJWBi-0006xL-EK
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:17:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJWBf-0004WH-UF
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:17:01 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBg47s325091
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MFMLOU4cmP0CyfZA2OslwYY+g6yA1v2k0IIgGpUYFas=; b=nEUMwo05QwyWURpz
 4ojB7TY0L26Lmqzg12PnQ0A01wfGBWV2PCpbGpOCWNsI0oL+dBvBdOdGpdOkHD+O
 s0YEel01WkXwZaj2cY66Vd8eiqEEiKySAFfUJLSa4W3Tbni9iM/eJT9hyQXWJVKP
 2/v/I5xHuElug7D6pD1WqUd7TRxO0ojKiTXz9gKkNxxfGV2iAT3nr2/leAmq1Ect
 tHtwlQhT4ClLORZxxD0Ysxjsb+6ndjnY8mQFZ54xp3wJwauAFy/Kr5GxIAMey352
 yH9KON83fhwfHvN/XeNrE1afr3JQLK8T3QU4Rmf8p4GnpL6xyT8l6J/NXfguMyCW
 lJPBmQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v43xr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:16:57 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7bf3a6cf1c8so458003137.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 06:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792588617; x=1793193417; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MFMLOU4cmP0CyfZA2OslwYY+g6yA1v2k0IIgGpUYFas=;
 b=BucA+NEHTW4BTBpZdaCgHXc4qPoa80iUka1gh0DO4HwWVbCOXzxjZmtmtrzW6V+oxf
 5qJVwWHSZH/h97AgAuU1G8gNUD6uvv86/PhSqlQuvT8wEJLk5E4mAsaZuWypAwnCCq5z
 TdAkBFanguq4ZXDbCWl48hQpXeFqn/TyUKe9CaaCTkQKeSUZr2U2Et1CpAPcTKp6nCQm
 DAXv/Xpaj2z9j51MDPTrnk02t/8CO+14HhE6EY6ZvuUpeH/XaiHqW6gQL+to4Hm+Zg/M
 A0RrC+4CW9jbGqLhpsqEomFlCcqYHXEY13w9vCXuBzK8HwT4/haSm++Bdox0rQPctoEV
 euTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588617; x=1793193417;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MFMLOU4cmP0CyfZA2OslwYY+g6yA1v2k0IIgGpUYFas=;
 b=ss7nHZC/M6zc66GixSkEhQjwSsy8VZIkkqXSHmPNzQrxQmAjrJY3X5sHGfdE3rsKe7
 vQ7U7+Da3Nz3NoXBbrr/0LM4f02RIle0A8f6R+Fb1XnztyCxS0X3RUo4R/NYUSYbqsr7
 rVIDFMyl1jcIGqwEM+IUq07hGKKkcGviOawy3JemteKIro7fd7F90nQvlwSloBvNuR86
 ElpFioDyIZtDrQfJ5/9ZzJBcF7uzXJyitIZe6cLc07vLskj2YfcovivCjL5ARMKhEQAk
 L7R59W3mWy73qYR0eUbuDT5PifA3k6l6Smys2OyHBl4MYafOfZmpaeMWiE2cJZ3l/cjI
 OQ3A==
X-Forwarded-Encrypted: i=1;
 AKwUvByTFqFkdkzg8BmmDltO857EJwJVkGhIIvFQ1Cry7z7mVYaRje8gIVB6XK3PWP/MrSQ/6OiWJjZRkhJt@nongnu.org
X-Gm-Message-State: AFq9FYJMWIv7ImLB/+Om+qEhQDvbb6bidLYuc6CbDMKs3mXpq9+jIhz2
 xGEqXff7PtVC5p66x7ZVsx+uLporpMI5v+mVqyPBilN8l63yBS2zxvo5/GH2hJrTSXIgDgERFFP
 u+oIYMoxR4g/1BS2RF8cJiLlfJDXxglw407IZeAvipC1XvN6lXIh9zaTSsg==
X-Gm-Gg: AYBFou2bUiH02YWHxNYa2qbxZOZmHCoYViD9A13vIt1pgN4uxazoVESFdmokwoLyU9B
 V769Rj28ogPPXmQIdq+xQoyHaE9e/V7NnRW4zuEk0L3uYv9hu8KN6wn4/83mFTvhWBEz6GwjRU6
 riIedVFpaLFM4QGjO5wHWz3pK05w0/d8GOrtCpY5wX7lN486eX/ztYGf5egGHxxx4HR2hN2j+Kv
 Dvd/P2RiRG1sbVNqO7rX907v/m1FapN4yke4aD1iE7dDjP7SnCsE1MinbRS9gWX9grB9HMxBIYy
 EI7lWvqO5D8UiiCCeIZ8I2ElXKl8VpKc4xfjwHzc/4NWA/kPW5bzl7AmMinwXtoHiI0kT3I72VM
 Xl8o/cd+q68rIJyOQqCiJmwngK8eLW/h63A==
X-Received: by 2002:a05:6102:4191:b0:7cc:1dbf:a4e with SMTP id
 ada2fe7eead31-7cc92764e8fmr771882137.34.1792588617260; 
 Wed, 21 Oct 2026 06:16:57 -0700 (PDT)
X-Received: by 2002:a05:6102:4191:b0:7cc:1dbf:a4e with SMTP id
 ada2fe7eead31-7cc92764e8fmr771854137.34.1792588616704; 
 Wed, 21 Oct 2026 06:16:56 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583523asm5489145f8f.37.2026.10.21.06.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 06:16:55 -0700 (PDT)
Message-ID: <963636f3-2eba-46e0-a19e-0a85598ee0c4@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 15:16:54 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-system-arm dies on introspection of ast2700-a1 and ast2700-a2
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Anton Johansson <anjo@rev.ng>, Yonggang Luo <luoyonggang@gmail.com>
References: <87qzhjmft8.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <87qzhjmft8.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MiBTYWx0ZWRfX6aj+BfDfaDZL
 /seTO6dTGDXmtwsfG5IVmuG9n2gXxQ6G1ABlucyNYuqLR0li/fBchYAM3D6Ha7TMoivpruwugLW
 Sy7IiYISV7NzE6FiVrvwQroTiQyPvzo=
X-Proofpoint-ORIG-GUID: FEjnSvnSsoZdNaNSdCqgatNwStlpHYSc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MiBTYWx0ZWRfX7eSAkN6BQo+D
 6XZ4QYYapJgWjyk4M4SmipcCXL4nSzcTj++lxw1q3sEwV67TSxS+VhhdTBNKPe7gHZJ02tUmXIr
 aSgvWm4muv2f5LjD6eLpQFDdbF7cfexp3vYhQJG6rvZiwgP9ICSXFPt1TGHKVi13qGGZLRmH5wC
 MUf/2jz+EJHh6R9tmxliwfeBjRgCNLbjVeM92MUSUoYLocUz0AcTS0Bu77RwyMaua5uD3pZL/kw
 8fFkCIcnfj/SrUfEpoRZGKpTMqmlYuZ+olG9IKvC4hvq4TZlUuGv9J9fA3TqVzSL0sPOYwJ2jI1
 nwNg/iotjmQ1h0s54D43hWq7DepFEx2kzH+Qd0AAWegtpC6vD3l4joAtxnE8bPFxajfjiDHFcyj
 bRApBaLPs7Z/2FwyLpIwQvE6fv/XeiA6fzVqnUMRNj8YP6o4OEZ0dD6xn8RBvRHh9bnR1AuwSa4
 3CAekf0ZBVDD8Fsq9NA==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad8bb49 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=x5dM4pBRUn_V6qr4VpEA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: FEjnSvnSsoZdNaNSdCqgatNwStlpHYSc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210052
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21/10/26 13:52, Markus Armbruster wrote:
> Watch this:
> 
>      $ qemu-system-arm -S -nodefaults -display none -M none -qmp stdio
>      {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 11}, "package": "v11.1.0-2545-g2d150b99ce"}, "capabilities": ["oob"]}}
>      {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
>      {"return": {}}
>      {"execute": "qom-list-properties", "arguments": {"typename": "ast2700-a1"}}
>      qemu-system-arm: unknown type 'cortex-a35-arm-cpu'
>      [Exit 1 ]
> 
> Same for ast2700-a2.
> 
> I found the folllowing in their .instance_init() method
> aspeed_soc_ast2700_init():
> 
>      for (i = 0; i < sc->num_cpus; i++) {
>          if (qtest_enabled() && !target_aarch64()) {
>              /*
>               * Introspection qtest just want to create this object
>               * without realizing it. ARM_CPU_TYPE_NAME("cortex-a35")
>               * is not available on 32-bit binary: skip it since we
>               * won't even realize it.
>               */
>              continue;
>          }
>          object_initialize_child(obj, "cpu[*]", &a->cpu[i],
>                                  aspeed_soc_cpu_type(sc->valid_cpu_types));
>      }
> 
> This seems to paper over the bug so make the tests pass.  That's wrong.
> 
> .instance_init() must not fail and must not exit(), regardless of
> context.
> 
> object_initialize_child() exit()s when the type doesn't exist, because
> &error_fatal gets passed to in type_get_or_load_by_name() in
> object_initialize_child().
> 
> The narrow fix is to make type "cortex-a35-arm-cpu" exist, or to make
> the two bad types "ast2700-a1" and "ast2700-a2" not exist.

The ast2700 machines are hidden on 32-bit builds with

   .is_available = target_aarch64,

but the SoC types they use are not (see commit 89b5f1ed43f
"hw/arm: filter minimal set of machines" following earlier
attempt a2239a87339 "hw/arm/aspeed: Do not realize 64-bit
CPU types under QTest").

Pierrick, I thought this pattern was solved, can you have a
look please?

Thanks,

Phil.

