Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FECE606A6C2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bCZ/im4/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EvjE2Y3+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP3NI-0004va-93; Thu, 05 Nov 2026 14:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP3ND-0004pj-HL
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:43:47 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP3NC-0000Zn-1D
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:43:47 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5JL5ft751618
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 19:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UfGDMgg0aBgK+FBPFViJLaI3BUcvW4oHoEBLdvTQESk=; b=bCZ/im4/RICm5xPN
 C71s555UCxGJdLdT75urNb1t/FHRstcNPjXG1KZKg8TaRG8sbcsIU8gyPUkOmg8P
 ZaMIrjBwL1afKAYkHKnaM02no31HZY8kfhtY6Mp5blFxZ3SAZm3N3KM75MHQO6fE
 D7/VEPul33+rU//Ml5BwpS+Wu3xTa1auwKKDV1+ro3ThqxZ12PZt9nx+b/PKzayC
 XIdMqDQWQF8oO+k01409tqbMxr3gwor6jE1fYvN8XLX/lqSpx6OkVvo70kfhwMfh
 0I3qKW1TzXgd9LGdHkdWHwYWreDaMlzFBnDkgzcM/5FOPrn2tfH8cVoJMbcIVW+5
 OheRYg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hryvp82ty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 19:43:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3552883bd19so4087074eec.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793907823; x=1794512623; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UfGDMgg0aBgK+FBPFViJLaI3BUcvW4oHoEBLdvTQESk=;
 b=EvjE2Y3+W/vUL0aEQl3+dpApgtym6HMyeXw3VyPpi7o2Uiy5KelKmzDeXwLLzja7Lh
 2Sj+GwK8+OABif9ZhyJPDNjMO74mLX2FwCEwEZnFymFNg2SrwKgtncau1vUwiEsIH7Nm
 0wz5aVRUNqY3HKfZzmoqWWMqAXXyRu4zjd8JIIpaxHQJ3mZJGoKP8N9Zf6/r/mS7uj/b
 ryuKkPs6uev1rMNoxsEdO9RxqyGkcxgnoThD6xdGBoWO6q4cH3sHiAo2So8X+ViSqz5x
 zFV/6abBL0bR4SvmzE0z8cYGHwswXJZ2aJBC10/XJzyOSVAKHlPlkBYB58YOVhLFbBz5
 FNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793907823; x=1794512623;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UfGDMgg0aBgK+FBPFViJLaI3BUcvW4oHoEBLdvTQESk=;
 b=eYIecxLrlzwmlhSKm75F8b9RRh2TwLcZrbj9dWl4C4sM6pVaEgWddgKS8Hzd1m2NXN
 4od7Q0Z/UV7H2nnme6RxyHvwxWVGK8rSPrjv/WV/FtDmfO6M6pN0ouJm7xJvtNMeUPF9
 2ftX2rZLBQr85cwPjBmOjxySDq5EPYtBq/47R6/fALxU6nb/lxP4EiWvk0kEyHLvhHqc
 +3YDUVYpU0bCFXjZ8a7kMq9mKSznF/jOd16EPWrBRnE/hYOtjLjxzWnpmm+Y1cSCf4bA
 YdiMo2EytO5rDPgF55421DcMr0uZzYzaqCWYElTT1de1ACG7vFghr5IGjM3AcJxbfU4B
 RERw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuC47UP2+EcmgIFD/CluxQmwY8stwB5vxUJVuc7DNKi4GWccG1Oo65lEMYGN+npJpPYEstSo+j3nog@nongnu.org
X-Gm-Message-State: APuU4Z/LcXGWx0RdJ6xfKm5pXsgfSRzGEFSKp5zlkB6/U0v+gUHJtTpz
 bqRu6HAcmzsXlx4uKhhPFAHoYqKDr8FcZNAaZ8v9E0vpT4HVnYRfxBEczY43/jna5Q6/OVOnjCh
 zE2iwRA5CFKsz5/fGsPe9SeefHCFyjpKnsLtbvvqtAuJ9ku5eZF4vTIyRCtg8BbBC3J0w
X-Gm-Gg: AYBFou33NwZ39PbTXLM6N7oIpgyk7dympA2ULK7+rsU99AIgWU+rdVOrN909kGLRNab
 MSSrJRJhbyWVbulVVghIRWVaaMgRHIxWDmm0CLM2FPqArZFhFx4Btw3XSVWKNFDIliurSMbTrN1
 TLDnu/4rq63fB4VX/OCDvxjer/cC643xhOr/dkfJcv+dUUi+d3oakghzxkKr+I6bfvsK/2MsZ0c
 zOHDWmLiyN4+CfSflIcNCqbqMsBotdi3q9P0CVzoNvBW5SguKLuIGEW8RYgSShhscExO3ZJTG13
 5cYFDSwoiTbTn6wHUwmlvIagY6j/s+lOBkXlc76JvOps383A8j6Y/JFTf4V74rWyHe9ZOJob+1K
 doOwH7d8Wn5d77SQXKqBYCOqQzOTEEfDVTcFYTTEoFY0dBrUh8WntE2RGcsBrUsW+UCZNNHJcxL
 02JSh/lGxVBBGnjHUfGEEYri56eCdY4f0J4/XRbobs+w==
X-Received: by 2002:a05:7301:5158:b0:369:fbc1:89c2 with SMTP id
 5a478bee46e88-36f76023a5fmr191838eec.8.1793907823034; 
 Thu, 05 Nov 2026 11:43:43 -0800 (PST)
X-Received: by 2002:a05:7301:5158:b0:369:fbc1:89c2 with SMTP id
 5a478bee46e88-36f76023a5fmr191799eec.8.1793907822539; 
 Thu, 05 Nov 2026 11:43:42 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f722ed274sm329297eec.18.2026.11.05.11.43.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 11:43:42 -0800 (PST)
Message-ID: <e4f157f5-486a-4871-9ec6-baa680137250@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 11:43:40 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] Revert "target/riscv/tcg: restrict
 tcg-accel-riscv-cpu to riscv targets"
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Philippe Mathieu-Daude
 <philmd@mailo.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20261105183310.1614-1-luoyonggang@gmail.com>
 <20261105183310.1614-4-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261105183310.1614-4-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ib4Symqa c=1 sm=1 tr=0 ts=6aecdc6f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=6iAvmC-XfobcVWHkfosA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: BjyD6Cr6HAGMnv6S7X3ZzGTsqRfyGWJy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3OCBTYWx0ZWRfXw44urk55M9Iv
 t8NAAJ77AwUkUw7lTyloJ0yVVzqmGW8eY9Uvy77JLT/o3z0iER1f3oYyCkfL8X+NNgTzy1mk2OX
 wEl2Yl6qd/eBY6cxfXBKXQuKs32LY34ElyNlYK+eKREXfAkDWXozRvzXny1Ry7ilHKr3fWTQnyn
 SlbvJfNMgjLOUKFaonggkjbJIWJDCs0/c0PWzIrMahGsYNIc9tJOUBCjlm7QOvgKo6epi9IHmD9
 UZCUtIxxeVGz4b6wIRBhU0n6TpEYKeE3dM+vUWie8/fqmeqqL+kK5ooMFUf0fhFFOXxw4EmuQsC
 Oq0Aa4m6C2Ejkj5sBgMfSgGE40wejrI1CZYsv1htQBmbTRHA6yLUjCm30K3IoIFr2X6YseQSHUj
 SLaNF1mnUG3rtOR7EIgpoJKj1k+xRwjimaydO5Vxj5im4upMu29xgn2qk+Z9O/v3wCX6yOGZ6M5
 EvzH8eqJOn1i4gYiF0Q==
X-Proofpoint-ORIG-GUID: BjyD6Cr6HAGMnv6S7X3ZzGTsqRfyGWJy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3OCBTYWx0ZWRfX2Li+pxGlbK7l
 uqJ8jjHzl9sj66uCk+Dl6SlpCgDXPGmTupJuXsLVNHjwJVCPOob+khC9a15Oo7pimX28EqnM3zk
 rC31tT0Rd+bF+zJsIPIWoU1D/8wScVU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 11/5/2026 10:33 AM, Yonggang Luo wrote:
> This is redundant now as all accel-$cpu_type parent is already registered.
> 
> This reverts commit ec65e16fd2ba012d57b1bbfcfcd04c31c4111924.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

