Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7805DC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 05:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wukjJ-0005ek-12; Fri, 14 Aug 2026 01:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wukj4-0005S9-UL
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 01:45:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wukj0-0003rw-UH
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 01:45:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4iDdk291875
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 05:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M56de8k84TxEmO0hrYouRRFTJOdOt7mdshtL1vdYdl0=; b=jpHupwety6lMHemA
 +kjNJKYIrKha6vl4F19JSFNpcm3rVrF79Z/+IXtsZK811OEy7RfSHgDFtj20U8If
 NnZWtrj5e5/P00zk/73X2dN7gQYuypuxHT3qJQhyTvpx6UDckVBsIF8KkuJlkj2A
 7NwtYM5D7eP2Js43pBDWgZM99in/zOFeNf/JGexnAqvm5ahpJZt8/F4xRqACHvMK
 7JhUqQiwA8wuTN52lsIXeeEvbv/KXrQCMBJLrXTuI0OdA0GKiz6hVA7vaBDLKgs/
 sT1QHwPVfhLPgmYG0Vf2z+/oaaDNXilRyreWrsoMlyTO286f75CrWmx2MaLu0jCV
 Q0+gJw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1v8pr6kt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 05:44:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c01ff996dso10570281cf.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 22:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786686296; x=1787291096; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M56de8k84TxEmO0hrYouRRFTJOdOt7mdshtL1vdYdl0=;
 b=FiHu6/zos0L5cOY3hHDNvDzLPtkuZM6ELbf82+ljqf3i4zCvxEYXEsqGSd41Z6NtWi
 y13+Y/6WoxX9ISHk9fUacAbECjUG+HOPtXuh72kzj+h0Mgvg2oPfWxYyXe95+wf18zM1
 /yghKf2vkWTtLVlKYT9B64O1ZDfiLmxTG+Y73/1B0HtHlX7qiJ9UObPABVhyX55gBSEO
 pmJ8Pe95+hdViqgYKtunP8KUlwqQmK1z/9K4K8dyfE4cu10TaK9UkAySBFe+7yKKqRrn
 He/5UskJ3kzBWFH6dbDQtfERolY8o2GlofJc+M5c33YN/oyIoEloBaYBcNhQW43w3Mux
 JlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786686296; x=1787291096;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M56de8k84TxEmO0hrYouRRFTJOdOt7mdshtL1vdYdl0=;
 b=D/TWf6/92Jh1PBUGxf2u5LPQII76PvFgd5DWny4/5CD/HoiS/W4npVxaPejhN8awqv
 8Q6hU9Uxz3srU1tnVnLoddRpVP6z2rEx7+c3hmTk7Ck7HxlDALQeiB3uC81n8Zc/EDbh
 tbS8ebn0DdrIOWL+pg51FcE6phO5dDlbuwf9lGb/4+WlPsfJqgN+aAi/kHJClOYYhc7p
 9tvwDZ4mXjmNLoMeLPJoc4L0DgRczYcgt6YY9FUS5u3W5tBXAPvQ32VH47zMqiJKs/u8
 gasxpZLFv5uZD47KX0D1/cBUKVAsbf/yFO42QRnaTEvx/lDSNITyWMZlXoI1T8oEJiM5
 +qZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfjG2VDVLJT+CCsPJHrm6lSNvAO40sUcsu6bfFBBriapMFA1ut7tGtgQL/7JaJ/Yi1YzxqddPgFyWr@nongnu.org
X-Gm-Message-State: AOJu0YxLre6fNPuYIxXAoGUGzHutWR0Ktjl7Jlt/PEVZMu81huluAbEn
 iQRgQu1EyCQxhNEtay2KZz0CdoWhHPe+U62M5t4dNHe1yilnZhy4sTuIICaYqvVc+nylms7JqT1
 FGNeO3lpNr5Ftm8A4eL2TikoRBKJEXY/V2y+kF6E3dUr0zL16DwL04hNexQ==
X-Gm-Gg: AR+sD11o2SmvMWKsjJzKGkGLoJ25lbZF1Ak07sdQIV2TVHZZ44I/NYzACzuLDJ5lGnd
 7nAufkh4HsB8BINgSwVtdRpmKBrp3GkPVW3XFQK6HFzWNXPm3eh/IGZBKLGqmHNUo7zK36+EvOW
 iXohf751T21N09VZW2e7dDesh2ViqWi50KbNXFWiQ8U3hkEWX8MRbzaiqtPUa8+BobbCUEvQQNp
 7BnAHOHhhszovKQWs66baeB6qAt5A037LdP4jDkNVNyWUdbv1HdUVDOmjpkom3fewa4T1qFe2tQ
 kazyWCx77cv5qjXBdUb4jhfHSVZUlo9s/wfWv8IyvW/CAZAXLGRtDLPEBB8abJysTnFNgd916AD
 nn6Dn0Bhq6q3rEsgWV+p3yvGZaGJam5zmkVE=
X-Received: by 2002:ac8:6104:0:b0:528:3c2c:5c72 with SMTP id
 d75a77b69052e-52d854a4a51mr44616581cf.32.1786686295750; 
 Thu, 13 Aug 2026 22:44:55 -0700 (PDT)
X-Received: by 2002:ac8:6104:0:b0:528:3c2c:5c72 with SMTP id
 d75a77b69052e-52d854a4a51mr44616091cf.32.1786686295216; 
 Thu, 13 Aug 2026 22:44:55 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d33asm22968415e9.10.2026.08.13.22.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 22:44:54 -0700 (PDT)
Message-ID: <7c5a0b1d-12db-4be2-b20c-9d132b027a76@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 07:44:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/10] build: add optional librpmi dependency
Content-Language: en-US
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260814045315.3416169-2-subrahmanya.lingappa@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260814045315.3416169-2-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K4MS2SWI c=1 sm=1 tr=0 ts=6a7eab59 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=01anJWeQb-5wN4vR1WoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=0lgtpPvCYYIA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA0MiBTYWx0ZWRfXwWGHIQs20dy6
 oednNAkrBsg43jBWK/nhDvD+MJVDgS1FToSQmGCrL9M8Q8CJRKePtlRTXblsyC37fwzDk2UtdwT
 l+ZEjumfWOQ6W6EFd3NUyIGhqVxP9JAzjCl6BXCqJWmckg9RwZlV6lJfVGUubAHAiz30IBcrOft
 5NEHXnD6WGpUWWFURwGSLHRuvQCR7LVvEVQsd03z69LheQPHCII+ecgi8U9WfyAe7na+sd+yYc8
 QXXHNNvd9VcDu6VL9Rabo2R74ParVRIIdO2bijNM8q3CfmsZoChFcpqKPQxuquOXL3qf+pdIa/K
 4dfy1FaIJ9kDgYy7SoOhLOSngB4jjMEMAiuNq8X2brVJsng+fhpHFZkBLqgkaQJ8KcRSScwP79c
 HjPJ+hxz8Qw8OyTuyFN8yrJsjuIHCHYC4Cvm9Cj86SZuuv6MFN5OUv9OxoVx14wb9h9+PKHVwPc
 pak9GVnIK7Y41YGfLzQ==
X-Proofpoint-GUID: PV0Fg0-F8U-jizHidRwC6BJ5AIuq9v1o
X-Proofpoint-ORIG-GUID: PV0Fg0-F8U-jizHidRwC6BJ5AIuq9v1o
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA0MiBTYWx0ZWRfX3goKTP2Cultb
 LftNC6eVeoYEKsKddCSc9Ee4kWg/LIO8jAOychmj18Z3zi9JFmSy0XagF7MJZPH/3fUvgijBPSx
 X0MCUlNQCkWWPwR7kQVMjWTb3GLmIgo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140042
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 14/8/26 06:53, Subrahmanya Lingappa wrote:
> Add a meson option and config probe for librpmi so RISC-V machines can
> opt into RPMI support when the library is available. Keep the dependency
> optional so default builds without librpmi continue to work.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   Kconfig.host                  |  3 +++
>   meson.build                   | 14 ++++++++++++++
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  3 +++
>   4 files changed, 22 insertions(+)

Could you provide a cover letter so we can understand the changes
with the previous versions? It is hard to figure out why we are
at v8 and what we have to review again.

Thanks,

Phil.

