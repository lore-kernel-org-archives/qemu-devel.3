Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEF2C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8s8d-0003PV-Jo; Tue, 22 Sep 2026 00:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8s8b-0003P7-KR
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:29:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8s8W-0004mC-6W
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:29:47 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M00kmV2579570
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4iRiiyPtwE3xxDxSr713ZUTrLpqZO978SgahELscAMs=; b=dsxzZDgLaNClZ5Sx
 KiVhEvwsHSv8dGZIWkDBlQX1DbPSJ8EcULJ4Sv9RUASCFcnuK373dtakVSNUHTtG
 TEWtaDLaRL6wUxlo0CBiPL/eoT3RO+ITLvCWzqh/c6ZzCGIpYMj1yo9V1LBn7DaG
 p8oWXhzJ29vcOsgOsX0hZnzSm7eLA5irLjPlqTq4a7MYo9QhWtUOP7GVaL5Jom22
 PdX7z1sXyo6Y10tzO1vfrzDtLllY7HeuFpyMgccT6qn4PFQM61SCB9B5FRTaOIkk
 5hiP+hlrr2hjv3Dv63mEDjlNhedDBTP3ZtadxYXN0tr0XRj8Dpg39CIIZMDPETpb
 Dv0jYA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gub329jcd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:29:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936aa34873bso657613785a.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 21:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790051376; x=1790656176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4iRiiyPtwE3xxDxSr713ZUTrLpqZO978SgahELscAMs=;
 b=RkyD/EFUgpPmBs8M2nZ0jFyHpmGthGLjWGSpkPoRce/pO7yNYdgLc0P7sudkw5TOyY
 SYd9FMG9a/fH7ZC2E0kUsFNFPpEC2/V/hktTlNmcRLnnX0KgV6LcLON7c7BRIj2MvzYJ
 BfBUU8MWlAqQrgPd8fGI5yt7Ypfli0+nQvpU329x6OSP3e8F07heKIasvIXXbve3caHu
 PJpA2OXOEAohxXFcljvqqfDyJznA3Wb6ohBLpTO7120axHfUvpuS4SK1ednpqRnZKgvd
 rlvn2ehnx2eAqHsz0UsC5mWXDmdO27xYQr34qexd4FtjK7bfb0OO0Lbhh2NT+Jwu6lUm
 q/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790051376; x=1790656176;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4iRiiyPtwE3xxDxSr713ZUTrLpqZO978SgahELscAMs=;
 b=XcebVOboUvvf1eDktpmFPCOcntgCTTUiNPKVTzNG78ja1mgfcK5qswAs0Y7VtbcIiN
 mtMo1f5rgtNWQqWt8qrBQMxkBmINykHkgujAYmiI0H1izfVa3Ra7o+xsi7vFDhsIKKE5
 75S5BiYlGcfCTECusEQ4ZiP6ai62Tv/89IYTZSLDSXzlPj5XsQu9wEa9emlQ9q6+26pC
 it7cFoc9U4S/QdXWlpLV7WX0hEIb11bFiAC5D3/JMRCGudux61xxYjkEpU8z9zk7vjHW
 EJXZgYc53LRSkKAE57cMHCqzqEA1zV5J+Oy5Nho3qq65wgG+EzthX+IILlHrJzkZWHj6
 3lFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwd9o5lBOf0DOzjZ64MVlc5KNO6e85a064d0HkUqeEt/+O1XbgjYVggi74PMb6LkvlyAxE7iYFFFE+n@nongnu.org
X-Gm-Message-State: AFuF++lbigyQ1dc1vPDNPJA5utsl/BFqXk5cP7njkNVs0flPf3Z2V21Q
 T8FOotYEgedRQVEcscH65Srn9AlYUVY9E1Q+DXe5JaoMh2bBuGkG42jYLEPX5J822WUVn6WTKGq
 OrRALIc8+BLRn6kwCNxyqFOIv/2G44vYXyvoF0umtstVlk7SfTbB+K4A7AA==
X-Gm-Gg: AYBFou3ttK1cuH0bLWF45OibXI3DR/Vltzzh0NLwvPxqvZI+Uq/kDDi8NVq+C5NUPkx
 fVB2MkJmc2ib5yFyF522gSVOSASwW3iPpv71Uk4EAaSELCsEjT8g7mz6UDL0sKp0CjHvOemnvPr
 HDnbXkqh6FLtR2tb09qEtxB24YuYOLAv7J219gHFk0uMpFcZYQGr8DYqru49VS3qj/blvDfXMRl
 q5VFQ5E8Jf8q7BknOegy82DwLVBH5VCAaYJM9QnL+n6wfl5WekEbwrojW0AHJFqNzWBohN6zfyU
 zd4X1fB8wXyFj0rkB+7NFbkhgeVakq0Iv8x00wJknDZj7orx0A6LS+surqyh+iwPr07HmXRsea9
 i62FyfNpTtf2E3r4cB+fgzEHE993t/Y1dxg==
X-Received: by 2002:a05:620a:4083:b0:93b:d7a2:83cc with SMTP id
 af79cd13be357-93c15ece6c1mr364901885a.59.1790051376096; 
 Mon, 21 Sep 2026 21:29:36 -0700 (PDT)
X-Received: by 2002:a05:620a:4083:b0:93b:d7a2:83cc with SMTP id
 af79cd13be357-93c15ece6c1mr364899285a.59.1790051375582; 
 Mon, 21 Sep 2026 21:29:35 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8cc061fsm41738535e9.4.2026.09.21.21.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 21:29:34 -0700 (PDT)
Message-ID: <951f4498-0092-41a6-9e74-7206d9f58ec0@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 06:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tests/docker/dockerfiles: refresh images
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921231458.3369-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=B8ssQ+tM c=1 sm=1 tr=0 ts=6ab20430 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: UVHTPHvR7VbHH3jnhTWYsInOiwiPir71
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX30QdZ5etDBWq
 PCHgOXNbmuh9EPqO1bgV9TKsdFGKOEwRT33TchvD7WlfWcCfybun8FPgItmHbnPYXUOKBlVO+G9
 m5BCF0Z2+Qhc8CfSFBvabiKfxrtx1mjgjhNxqv3+yUot/5sHL+GEkW4yRsnzE21n2fQSK9xAEnE
 N67Du8YnbJnUqST/cAzc7KEO+YKFw2oOFQvkdBW5SdM2vL8ZlK9mK2Yyu2xNV/hc0d2qZCi3+E1
 biGGOXzFXfi0xLNIGPHH4ivByF7pCNYjtMbzXeqdTt0bvOm5AtLhsFWlChsjJ75ia4QRR9+Ab6t
 3ppLq2nS8F2K6IPizqcSA2XBCM8Is4AJ1dFFVGslV6Qg6ZieE+9Ajs0bt35/qVhB48/9dvg/Y8z
 GfRizfoDcKTSRO+8V30LJRFhFMMn0aHIj6LAYmOIC1whhRCfMqsDKjnUYg3DMpEiXR2/DF/ycRT
 ANAJOaQNPn1tuP+QSNA==
X-Proofpoint-GUID: UVHTPHvR7VbHH3jnhTWYsInOiwiPir71
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX4CgkR39f5c2s
 +AIkyyOm47pA4n+cKuAl1sx1ryIpXGXviBEL6eHp1ys1g6USIhwcvz1zXLoBcWHK/vqvaU9teAB
 2rem/AyzmSnNwsxMHY0cKpFj8Y3b8gg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220062
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

On 22/9/26 01:14, Pierrick Bouvier wrote:
> latest update of libvirt-ci changed packages, but images were not
> refreshed.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/docker/dockerfiles/debian.docker     | 1 -
>   tests/docker/dockerfiles/ubuntu2404.docker | 1 -
>   2 files changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

