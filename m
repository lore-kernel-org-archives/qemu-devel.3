Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4962606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=grcoF4xK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SAVftPVa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMup-0002SF-FG; Tue, 17 Nov 2026 12:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTMum-0002Rr-MR
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:24:16 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTMul-0002zA-2Y
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:24:16 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQMC6923333
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 17:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GR/5PMf9w/euLIYGskpF10EBFZwMTEnZCLBM55hmStc=; b=grcoF4xKRHLQvCAB
 80tIjh26Upn+rlDtzHH2D2IBNcMgiD4CdCF4iy994xUxaW9Lgl1tui06wALHNP7A
 nn2Iwi4guhzctBhTE9kPwwlOzMhNcEyxl62WW7wa2S9ruysADcPKwN1PGeuMOtA7
 NMuBteF5pMhkJCSEIea5NfHgNrRwRXSlJ7zRCKEAlizrBVIO5PvnmdGmFpGP5S/z
 9j7CzdjFYjPGe+oAayQhuMH2MLc+fY8XxEUOyWccJRJ3IzWXAiWBuKNKixM8+/Bb
 GZN39dzsrxyNghWbdz8QjnpJ/qrLWF48IS64+eFHGfhtU7Cs8nHn81BLZDU2o934
 FVQr3g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0qms15vs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 17:24:10 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-990835cec5aso848476241.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 09:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794936250; x=1795541050; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GR/5PMf9w/euLIYGskpF10EBFZwMTEnZCLBM55hmStc=;
 b=SAVftPVaNNrDoyu6vpbwjkcooVQRc3mMDJbe1txWy/dIR2DM55AWNI9kD7pE1RFDl5
 LVnRJ5BXWk/G9/ynA5YwI8c4ZiY9ZyqBO1UXtsId3amc+MlB+ZfO3PmnF/lPDqZAQZAA
 bVPZZsXtU1bbGXGPKl/Nt/6wUz2Y1zSi8ru13pyIIcHVnerFya1JhiCn18orLzZuHUNR
 G7u6ZBiCCVGASVzAsWAToyTKlFd17oRwkLlbFAMSb572ct2L/yrdNO6cVtQ14NxJu/V1
 pOPrGsfbFdD+6vTjidhdog5ug2ZrYtMefTJjaHq0NYX7tiTt50nLWwY1Pf7nVouBmduL
 GLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794936250; x=1795541050;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GR/5PMf9w/euLIYGskpF10EBFZwMTEnZCLBM55hmStc=;
 b=uPY6iJ50weIhQkmYnQoL7vOqMow5z2i323Jp7cp6Hoj839NV0LlrUUDMf/hr+Te3cY
 kq5Iw6Hs2zslQQ5OzXU6PFnayCHzmVrkRNWNBn23BY7GRLXxoIXb1/1BdQdDfVYwHx2b
 2MNJMN+lXC1SJVc7ymWT1/rLLvQWQ8RIxwwHHYETOIwcPzcGtT9gowoCMTJ+Av5Y4PSt
 VEqOE2l10970qJVn70q7rMONNSZ3Ev4hyF+ll6Hsygpup9YhTaKTbauRSpk06BGqyAw5
 BcfabSX0nIsg1uzKs8m9hUCoJ6VQvOS3Cn6L6VsyJ7yAnOAY/n1hJ/jTl9b8ZOYZehY8
 OskQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGel0WXNP8Qbw3o0aJptDbeov1Hf87myWLs3+Z/I0/hDYPF4rQHF20LgEH/D5qgDzVo4S46DRv2/g+u@nongnu.org
X-Gm-Message-State: APuU4Z/PPush7odrLGgFr8LN4ArUwuJw+cKTcM4djxOQCNhnfX3+3B13
 kYZGSaectGCM2TP5p2f9xaG6J9mkwS57QMMhe46kVwrr90jJ0z+wUFRXvy15e5J3FP/DGtxhL/S
 CVVufX+RxOBWuB1wVjQkMoqwliPECG2Oem+tQRYHnF0qiTFmf3ZjsdNCiTQ==
X-Gm-Gg: AYBFou1J6A0e56jMDkVZpeaq/6r0AoAezsbCfNOfzqjKWClHx4a6VS3oWecEmzBlI6f
 lFpHa8XPBknMXstNETT9SCPRgEq04+hG7WLN0NYCLfF3/06eyEVGZlzTT5k6VXhy87bgpZ1GThv
 KzLq4nuIFSdHN8/PpxMO0qVg6oHxuNR/qQ7/7GIXHB7R8sNOmp5N2FufT7Twl01bgyRY75R0DTw
 jyeApzKoEtPe7mJJCdlk/ZVtSG2IrsCQIlg29cHDRvzuhkQitdyjTVq6vFD7D5JbO9+AfLlTuHX
 ZXBM61j1EjBinKormrBaAoncxqqlFu4gnOjp2yYmxh+ui3fz18j7ZpEaw7wE+5YFoKMwLJWv3Dy
 nS5MB5xS1aWb7MnpSdKYyTLN7ASoSI+yIECtigXs8QZ0+igS3U9HMk8vzg6NeLGZAMHZxPialud
 T/xOh3Jt8=
X-Received: by 2002:a05:6102:80a5:b0:7a1:f2b5:6469 with SMTP id
 ada2fe7eead31-7d69f86efe4mr1012859137.38.1794936249618; 
 Tue, 17 Nov 2026 09:24:09 -0800 (PST)
X-Received: by 2002:a05:6102:80a5:b0:7a1:f2b5:6469 with SMTP id
 ada2fe7eead31-7d69f86efe4mr1012844137.38.1794936249087; 
 Tue, 17 Nov 2026 09:24:09 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783c255asm75968185e9.13.2026.11.17.09.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 09:24:08 -0800 (PST)
Message-ID: <7350477f-16d4-4faf-8785-e9eabd470bd3@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 18:24:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/docker/dockerfiles/release: use full registry
 name for image
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, pick Peter Xu <peterx@redhat.com0>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20261117170244.3180399-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261117170244.3180399-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2OSBTYWx0ZWRfXyBZEVk/BY5uO
 5/ncgmwbawak89rZ+3i2dc7qv7E3z4NHlbP0rcBQ9OqcKABCwrGYmNGjKdoe5fehksQEggrIEIq
 sGgq+MAztlnnC14YezT0ImERD11X5t0=
X-Proofpoint-ORIG-GUID: fuZDMoxQ_PpNeuAOlCELyTU51ZGTC7P8
X-Proofpoint-GUID: fuZDMoxQ_PpNeuAOlCELyTU51ZGTC7P8
X-Authority-Analysis: v=2.4 cv=BIEmP1QG c=1 sm=1 tr=0 ts=6afc8dba cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=4EhRD-E7odacndrnq0IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2OSBTYWx0ZWRfX5VmO+/JJMbvo
 nGGwBVvwST1Dbjlb9aa+ligPnXqUiITIeR5FXLM3x/2mZZnl9PFnEcN1l6cUm20vzXc+4HNcOQW
 vT3mFLbGgOWpE70uFqVlnryDDP6/ZQv/rlDukxLZbXTw3FcnCudsaeOfl/0QswX/lR0ccYjwMCQ
 G22/tYDc91tBjsPhXIG9+qFtfEgauephaLcJ7bLp3vyEA21RM9UagkwaQ6pgS8PEfxabEx/VqAG
 TFoEAhfvx8RtDmctSYIQtCtLZ9Tvi1xOvw8gXSkdZgI4333I4EWA7Y7tgFcyUx6ta2Y8/lszk3L
 0jHvGeYR9ftCzvxvwUngfWqZK/wWu4XN49v3ZuYmbisxsE3+2AQJqIuJrXQf455EiqTWNjTAYq/
 2Fc+V4p6iaMvu36bCe9zZhPjPQCYzF8rD5I7yLFd/za/nz7nhHJyoGj2wnN0jj83v8XMCo3eGmG
 L7vW58ji1gIgUd4p/Ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 17/11/26 18:02, Pierrick Bouvier wrote:
> By default, podman does not have docker.io preconfigured as default
> registry, so building fails.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/docker/dockerfiles/release.docker | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

