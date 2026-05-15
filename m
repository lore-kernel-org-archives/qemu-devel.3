Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5CACD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNw40-0002E3-OM; Fri, 15 May 2026 13:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw3n-00029R-HV
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:10:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw3i-0003Ev-9u
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:10:49 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FAML0X4020777
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yaexKdP8aFOkNbSjtVSSIRAFv+nEuAO6vvgGnDE3ikI=; b=adCxhJjVIT49ZGaa
 /Ky7hOBaF8PKQGrYYLsri/tLr0CoiS0jAAk91uC84kxtAgt9S19BBbETpqkfAjfB
 rPumVCAHuC5FpXxv167O0bcDmXGdEKdq3KWIzGb0nI90hvBovhdXGz6Zy7zqlcaA
 Fl2X/1tGqkl6pYAG2xq0IP4rkM5tCyfTqj7hbSFSPNSAeeriGxkjRdtD9XER/2Hv
 qZ8nINL/mUK7ZSGI+8MNoY7cjavactQeW/a56OFymLm90LcKj0qMV6YMryuOto0o
 UPb/tmrvYA9GxsNQ4Wia6c69rme5Lk9X0lfZpR9PXgFE5a7wwgVbqw7zJ1I3P5Cl
 bxo6yQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1rv5jq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:10:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bda35eab74so988736eec.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778865044; x=1779469844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yaexKdP8aFOkNbSjtVSSIRAFv+nEuAO6vvgGnDE3ikI=;
 b=PWUMDrz+hT6eGeGTV4bzbU6UV0sHZxLEIYT2+GeYqmU2+pt0q4voA/58anbpV5yg+C
 vqYno+N6gx4YGHiVb0DEaQro8FlaBWCXzgC5cmgZNYJFNT9iHpH8hv7QywwrByjQP8Ox
 OiQM1IHv/QbD97Soz2PDXPZn5m6CguNMho/MjNTY8evGGseKmCvLa71vm7veR0GWxMYg
 YGOh/wT/rzckdlEzK2wX2HevxEJa6X5jLrRDTZsNYahTO+5TPiHIGjYs5TdD88SP7F/A
 GnssjskXA9qEUffm1kmwZsucyISctVgIfNxCD+BwiuvEtumR2ayXfN9Oi2iFu1IIXCPK
 zmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778865044; x=1779469844;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yaexKdP8aFOkNbSjtVSSIRAFv+nEuAO6vvgGnDE3ikI=;
 b=B80VBlQNi4fq5q9Wx+Z7fK46dV4d56Klz6Hu2WbvGFvnjhku4+kQVMbe0z5yQ4DpyV
 cEyyKl43qUdpdBlvbAUOM5BC7WcFfMQPqeddKs83POgJf1QW8GhOSKc5pWWVmUH3Lo7g
 RUtB8s/G/lx1nhqAXlS9WJhy9ZAzxdOQrWEkEZXf+c6OBwZkaOhR9JDAKEo5raX4li2C
 2LIXihE3Sy+dEany7Pq0th1KhzKHx6diaUEMfpMG/dpe1ChSEA/2HVlluOvIM93CJEd8
 3GiD3502VlCgo4fR6v+rIj5l2UTNdw1No0Z7+dvhgWf2IH+6iDuUaz6zfSuCbXHUXPdl
 twjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Dzzx4ww3nIdOBJDP+9mfxbP3FHKzHk+HV/zh1Qcdjsf44Qy3z/5MrKg9dtHjv99insa6leRVSCITK@nongnu.org
X-Gm-Message-State: AOJu0YyXuI6Jh3EytBFBiwg8c+dUiTPv4IGntMTBqtHSSkueyG9864iT
 K4F8R+FehdAsfskjkBNnfQ2omarocI3GfhYuex59mKgO6TVQIMDPbgS+afbDfChs7OTBvzS7Vp3
 VuIOdXYXkvc0kfPRBXDwXdCB9zWuJ7delWYfQWbN4ruR18J2RHbrqxIAl9A==
X-Gm-Gg: Acq92OHckry6odBp1Dizlj/DY7k2lZhOd9I9y0A/vcvn7hud0ydqPRR5+am6hzKJIIG
 iDVGyRHMf1DJFctCrM9S/RVSYHDZtnbHnFtxPtzwINQX45QZiliTZNHmTjGt7J9pEQVs6igMKU4
 zoRp4g1GAGTNOytP7u0kvjubygiQfxjn/ncyqa4pTjQnmha6hoVGtYruiYrF/l0rXw6kC3Io/lt
 7+z+au91ZDZ464fDIfOXmdfbMmFMCqjWo0EhY9ZTtcQclJKEi45/411UbZ7NXQzoOED5y5c+Nv4
 0xKUHJU1r6NGn8TJy+ixcxORe2fIGEujG+chNsHFaYZnVvXlLso/b8FveGmiS8IRpDjxVIhkPKV
 sHxcCTj1mp6X3WsVvkbdDfLWEIJxR1kiNEQHuK1lpEyg92LFXw96WB0JjWSgm6X4HD3FXx+a9bz
 ndEbgUHAjyCueU9A==
X-Received: by 2002:a05:7300:a286:b0:2ca:bd22:6102 with SMTP id
 5a478bee46e88-30261d786a6mr4012150eec.14.1778865043673; 
 Fri, 15 May 2026 10:10:43 -0700 (PDT)
X-Received: by 2002:a05:7300:a286:b0:2ca:bd22:6102 with SMTP id
 5a478bee46e88-30261d786a6mr4012112eec.14.1778865043040; 
 Fri, 15 May 2026 10:10:43 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6e9sm8892617eec.16.2026.05.15.10.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:10:42 -0700 (PDT)
Message-ID: <8f5c6dc6-9686-492e-89bd-cd90de04256b@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:10:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/20] target/arm: Use make_ccsidr(LEGACY) in 32 bit
 'max' CPU type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-14-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AUK8KpKz7izIYsY4Vh1CZznT_VG0TPgG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NSBTYWx0ZWRfXzcDlunKOc8bz
 zZA/JszVF9jto4V6TaTanBRRaW1L14R5BVP7Ypv/F3jQlVmESMoK7ZSnjE4Aej7Sll5HcRzk9g/
 +y1ILaHbRqvYgsB7tKDo+Pki0rP2KrA0FpAeUf78aIBWvZe5JFehCYPl+0FfGVQGRxf8Dvs5A5R
 8vD+GIPi1NdL0q6S/PJtfQsQIzhg5AKOqNdNzc7OlT6/9wuccoqlOv8qTeJg8XxwXgr/UYPVj5/
 oEz0HlhFTIoO698YcgQXpmg3uP8PCzqow9BAAVnPhhrVYq/wI9mGsrc6YdLzpPCd+LciboVDCw3
 T4Hg0Nors3M0yCmE8RNFslTbZ0dvw/BWl4xfzwKmp2CClkpHMtaFU6inY5198DQIPkqspWLdRPT
 WzoIxMYGsckYy03PBPb56Uj19tR2VpKGiRRqgQ9EW0t3ELfayXMdQZtTDef1h7NxVNZZi7Dme9I
 PpeYIUWGgGl+OyhbTXA==
X-Proofpoint-ORIG-GUID: AUK8KpKz7izIYsY4Vh1CZznT_VG0TPgG
X-Authority-Analysis: v=2.4 cv=JPELdcKb c=1 sm=1 tr=0 ts=6a075394 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ElV25bcJYSdYIwaG-RAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150175
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> Commit 676624d757a ("target/arm/tcg: refine cache descriptions
> with a wrapper") added the make_ccsidr() helper. Use it. Besides
> being simpler to review, it also makes arm_max_initfn() more in
> line which aarch64_a57_initfn(), which it almost duplicates.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/arm/tcg/cpu32.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

