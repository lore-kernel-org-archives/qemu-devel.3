Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DAF606A6F0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HOTTu2Wl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CvCdXBdV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP3NE-0004qo-NZ; Thu, 05 Nov 2026 14:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP3N5-0004nf-TP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:43:40 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP3N4-0000Y8-G0
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:43:39 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5JLNTJ597529
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 19:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Hila3885CZM6NsBVhbfHwWG5rcPPwzZn/wBsnZSxIS4=; b=HOTTu2WlBVm5V1a2
 ZTV13lTosDZpfk+VcKcCzr6il3EpLMQMb0BKgb4a+5uo/gyPWGSbnS1NYx/A3sl0
 vwo1PTo0bV1LG3iAmK1h6u5cpgkbywCaafxteP6Gvsvx+iecBSrL51qJ4pu0WQRr
 5V5/n/5sjRx7Sp6w5hPwUcYth2u1/Hu8aniK90lJj86VPjApJNhpU+xKElVPQzWR
 PdiII6+92Zqh4imetvbZPQGiggZDIzz2wYuwzItjrAKudIzqlij0GyRu0HUk50Oq
 v/YOQCdYPweIdFOFAvZL13+QqYbTVgZe1XwLR6O59ACrNLCsFpuJIDg19R1yp9ZB
 BS6n8g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hryvv0365-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 19:43:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3552883bd19so4086706eec.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793907816; x=1794512616; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hila3885CZM6NsBVhbfHwWG5rcPPwzZn/wBsnZSxIS4=;
 b=CvCdXBdVEceqbpU3sVJCl3DkT/GXHws/SYvBr5dMaaCdrifDj118DcyDVcQL3gHfYD
 dDyc46ZzwBX3gsKBJXPNSlDSLSIjOLyhTNgV8Ly+j/h8m8JqzugwC21HdbgmZNNqnvpY
 ic/0o/KSrtvafXs7JQmV1AW9sn66luTsJBYfinLFJIh2tl8RomTlLqh/KiyPkzSF25pL
 7VRWMd0xnly1PZV2kU89nfWb2PuHbQpZ/YDTH1KQgvrXgDgcas0bNRN8HFI/PQfX0HtC
 6lmE8sh4/zeR2bxPOMN+d7QD8I1AN1Y4ma2Qqr96CiC3rgqTbJxpX7rZpKl3icc5DGq3
 D2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793907816; x=1794512616;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hila3885CZM6NsBVhbfHwWG5rcPPwzZn/wBsnZSxIS4=;
 b=be++dbOQMG2C2WBZ3F8YcvY3ph2GzMPNXpSciHIxqmwfzfhtB/+ANstAUrvCwGrj/O
 11I8o5gwpiW0VKstheKyJ68x4GoSc2XnosOBLXq/yxKQtLrLUdFmcPIwG5bzNIF1yhL/
 9//US7OTeVO7onJAAf/mad5mse8Kwn4YtuMhxzucF6tJ/KCuy7w99xcMe0Gx4BtNIwSS
 THbyss9/DstqvA7bm6uey66lrPXTfjgGuYohLO3SlqGvQjkZ8TYLWyZDvqr+p2VsUpNt
 uuzsPV7hAIQaMuq2P1l3Uaj/i42b6endmFd88V2wIL74LrlXHY9ajUIHcIBGurW9vmz+
 ZFcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxROmu+r1f1mK0xBBe053CR6yqBB/UECPxs/20BYv4ZGmekBD/I4WKCGD8ziMNDwydoVOlUhpuxMOrx@nongnu.org
X-Gm-Message-State: APuU4Z/L7P7hR+UYB+2Z6sW+4woJFgJDXfNrSR1TIV6JxYdiM1SZx4P0
 PLTgaA91Q1gyDhHAGu21aKPf/qZsb1JPCqmW5sfET+kSsSjo6jhbevgGUMCMn66vhfsSiaMMkje
 iWNvdcpSoyJ7DPA6iFKyvGwZHYvPpDSEWUgiD8btI9Tbi4Nf0XZ2q01G6HA==
X-Gm-Gg: AYBFou2q8NpL32ChbIlhx4pPeWOVss3IzMuxr1SpDjliibeXryrxgUm8+/uyGu5kOXC
 jpka7IJLanwFjXPSyJQc3PbE1baZi7FiVla0CmdEwd12a2d/WQf1y1pYDgcO06rKagP3ySM4qBf
 G8FI8AZfkWoXjRp+A1WPUSzF2jDRVZBMhNPGpI2BjWf6wdm7FVrn+Ze6alVr5LTib7VASDhFvin
 PJcIx9QS8Td1sgNudFNxs4N/PDimgmUKww0SoOhcCdQpcCBBhTy0aOKaqh7iAgcxzktM64baoPv
 rRhjpD/dPY+6AODDyGJuA1B6OS7s6qgUk8VFyQJHgrkXIFcI1nD1u/kuVIDEEpFvz8yY3HXy5KY
 vmqRHSkQzp5UoHHBqvHdiY4ZmVX8hgBluC7eedmXx3VrCc6PqbQYo2e4GGQe/LQ29oXhYzOzWba
 I0Ko3NAi9laUqZ1eLDwYxliIVwGgTDtpC8nu0Tv3GLWw==
X-Received: by 2002:a05:7301:4e44:b0:366:dbf9:32bd with SMTP id
 5a478bee46e88-36f76023af6mr151215eec.9.1793907816490; 
 Thu, 05 Nov 2026 11:43:36 -0800 (PST)
X-Received: by 2002:a05:7301:4e44:b0:366:dbf9:32bd with SMTP id
 5a478bee46e88-36f76023af6mr151163eec.9.1793907815983; 
 Thu, 05 Nov 2026 11:43:35 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f722ed274sm329297eec.18.2026.11.05.11.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 11:43:35 -0800 (PST)
Message-ID: <4cef2c5a-9b5b-4793-9af3-106a5d65cc5e@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 11:43:32 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] Revert "target/riscv/kvm: restrict
 kvm-accel-riscv-cpu to riscv targets"
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
 <20261105183310.1614-3-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261105183310.1614-3-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3OCBTYWx0ZWRfX/wzPIgjkNFXH
 x8VPJsGcBqC5LVAqUWpzwDMX8oi0Apl1hnxPwtcRoH1PcVzRs+E1M6b4sxJG2lvUntS/DI6P/gQ
 d654vxuHgTdg2d+M6rlvf5dsKhwvP00=
X-Proofpoint-GUID: CgVqg4WhZgnQ60b0x-oymBjJK5tg1xlY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3OCBTYWx0ZWRfX0DyyFBLey5Jh
 Nh/xnJ6in7Cbc1c+NnA0/RE5Z1bShDwJ+2ofNmTEp/rhtvLhha5gIgkgZ9ZhLo1YZzXalNYxjuO
 vPlJl5lc9nMYo4DofivN4l9aATDAW/6zEqBV4RZXI/SaLxGKwVvIG7ylla8e8z8e6cQ8ViZ1S71
 iwLx1/QdQ3jeAz+wSt+0Oy37L7A0W2VZB5946tEY7Q7IC9LGOf8b4zyQ4T1UREejtYSCepsLd8m
 Tvg/HB8ZOAMZ4F0izQjvUb3Ie/Huf+QgQb/gzK0eqHPI5y2Bj2Si41bGYdfqlgEYgPcvU9NY14Q
 p32yLBnV17alHGgDVs1k5g0kWcUpgbaa/0T1dpvBEGI8D8vBDNKQVUOyK5VBZCD29oY+Md39Gu9
 XhR+79ffHUeXnZyF2NSZJC1mrYWK4tE1J5KsHyNfOEIPeott3lGAoT1O6tBp5U6+R5eR/83cHI3
 s6AzJsV5idpWasr6q9Q==
X-Authority-Analysis: v=2.4 cv=dKUzC+Zb c=1 sm=1 tr=0 ts=6aecdc69 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=6iAvmC-XfobcVWHkfosA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: CgVqg4WhZgnQ60b0x-oymBjJK5tg1xlY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050078
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
> This reverts commit 2d3e6b4003d5380c245ce8ffac4b8866f6d10a33.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

