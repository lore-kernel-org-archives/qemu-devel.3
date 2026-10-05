Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E9CCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 04:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDaYe-0003i8-QX; Mon, 05 Oct 2026 00:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xDaYV-0003hZ-3f
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 00:44:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xDaYR-0006ur-8L
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 00:44:00 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6951086A3242506
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 04:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hO9t4/w0U6pF5TNn8jluXiC/a05ooHCZKtC0DznAhmo=; b=QgWgz6DOPToYhJbw
 egzQE7ka5vI8n6IZDAFP3z+/VQGq2VQKQ3aAxyA46NgSuWvRqHDm0MTabgIOJLic
 /xv5sgE4VocC2EtXNziscMn0NT5YhXJjD7J4PD7vqxaz0gjWtC3bzelhVr//uyG1
 FDkDopqMcV1Q2glewRDgOKHUPCnWISolbvKqO9ZKYz30FsGuej6khq4tPhXGAVqJ
 ikPMDpzR85LWzZ2txJnPIxrX6gReUjjtXVHlCrftC+XaRCuY+KvTyAsUVdPO/Ft5
 OtFSFO3eiRV61HzBqrhnvK3tPwfiyALg11de7VAscWglqEKU4Mb7hzjFG2W3mNRj
 W0xgzw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2tvevanw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 04:43:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9308eafb465so313927385a.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 21:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791175436; x=1791780236; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hO9t4/w0U6pF5TNn8jluXiC/a05ooHCZKtC0DznAhmo=;
 b=gddJ2QbRGLyvLN6SBUsr6mY3Ehd9BfqIHCUo1fSllb1d2NDCj30pHd4D/q7Vz0QRrE
 rS/G92bWwzgUGaX98Ets+INu+5yU6sdUkVz3x8foY3DZ+BcZvxMRANlOu0MVkCR3SwPN
 ARpVfdrVF3gLkfiS/QRhEwH46LuubKptxS0nwaAh1NYz5iJVjUXV2yoCvwVVSu/3zjBd
 a4A50Yiz+F+JcHoV/ANHn+HJyE0W/VGrsITGhc7PFmbMzxU/AQ2CuSRDupq6AioFlqdT
 dsMkQlQW90m8JCiVAAaw9lhaJ9u391BbqsLQdP3JHNh+Rj/p99UuNx83XwQZ8oHtMxwT
 eCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791175436; x=1791780236;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hO9t4/w0U6pF5TNn8jluXiC/a05ooHCZKtC0DznAhmo=;
 b=FD81F6oMd08WVOLdRN4korGPCAOjH15/adssLCfAEbCWoZy8dRx7pW1YWIqpaccuvr
 1Cq7YYgzWQ7QB5bhVGW96OzDJPALSSznyFR5e0n9meHAeQ/z0b3lSYY2/zO2HYOPZShv
 HZX28ml2UKCAYAjnZZfejy5TyAemQjoUBU5NVYJZ8slzbm0+b627DH3MnOUSWIuoZs1q
 QNgsrGmw+cvbBzhEZAaioSKdNR6lbBuGdmVkqlkNar8PPgGJTeTY1pI43lwACd0FfZfA
 DGVchXXIUj9IsfMz0EdPCH4zzLEE+VMkhB2bBjOouyNHjF1MloiIzX0knCljFooXz914
 F2cg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCR2sUCk3tMJYMI1lGZSgrgti+U1bfHxiSgDuUe+HOsWp+TPr1XYLEqE8XVXsCF+T+4Tbu+Rasob3C@nongnu.org
X-Gm-Message-State: AFuF++mUlAnw/SpgWadIechd9gXtLm80sB1ba94yB0lHHl7p2X6DrNdr
 LLIML60M3Yq23GR7vEHIrEpQZ00PphHCZtZMrFviPMEDPIriJNUWBAs0KnFdH5VaEUPiCnmimvu
 46xjdOHNMQ/Ce/AB7Rz27uGrdQ5M2xx/NQGgolCT3R+F+4kLJLOFcfSPEDQ==
X-Gm-Gg: AYBFou3szOprtWo9GQZYy/B3/mW2J/LdVVwTbLYYhz+LEvpRnSnko+9r7TNDz1j+JLX
 Bfl3n1PMKkcQXpy8Z6jH0Nq/JjUBN/cbm9NsV5BRvNEml7TPIT33jUzeTTjTauRcGfX2I0snpPK
 oTdJF8JVl5MjOFkk1L2BQd368qP0+Q87opnmXaOHakVHIdSgqAPrXjbRsySzWzkAm4Bpgz8S9ZW
 cIgdPn2XvYSYTqdAWVMLAb5yrPtQC0jwlgI7lOTuJ3+Fn15+iuc8BhtbWHq1snNmHsR9TT/kqdA
 P1yPjPwKaI6z+Hi0VjbHnHIEjsJO8lqZZmB4h5lKkFGgqLwVxRtQuKq0BE/WH853z3soF03nFZ5
 D4icV5BgVWkIHGPoaH8isnnzd55Ya+ZyHqe46
X-Received: by 2002:a05:620a:d96:b0:93c:a468:2db1 with SMTP id
 af79cd13be357-93cf18acd27mr1870814085a.58.1791175435692; 
 Sun, 04 Oct 2026 21:43:55 -0700 (PDT)
X-Received: by 2002:a05:620a:d96:b0:93c:a468:2db1 with SMTP id
 af79cd13be357-93cf18acd27mr1870811185a.58.1791175435099; 
 Sun, 04 Oct 2026 21:43:55 -0700 (PDT)
Received: from [192.168.10.208] ([185.243.168.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca209601sm796946285a.20.2026.10.04.21.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Oct 2026 21:43:54 -0700 (PDT)
Message-ID: <b1dfa965-809a-418a-9afe-2f2685abbe5c@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 01:43:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/qtest/bios-tables-test: Allow changes to
 riscv64 virt SPCR
To: Rick Richard <rick@sloservers.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
References: <20261003161248.38903-1-rick@sloservers.com>
 <20261003161248.38903-2-rick@sloservers.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261003161248.38903-2-rick@sloservers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AfinrbpbOliLt4gSz45uo6ByqmT9kFCo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxOCBTYWx0ZWRfXyxXcRjB0NgjB
 MV70iz7IDO5WaYuh8ppRy2zyB0ChOOWE+GxyMCKG430ElPme2yeiRAqEXtdSUSi1HjA+a6hUSfQ
 JU2OpbdkeIQqW+BP3zxY2oC1F0v1sTc=
X-Authority-Analysis: v=2.4 cv=YoGa1IYX c=1 sm=1 tr=0 ts=6ac32b0c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Adc43iEMMYzOb2FTIT2GVQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=F-tV29oOAAAA:8 a=EUspDBNiAAAA:8 a=s8KuVkPV-ZGQNvTNGtoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Y2dezMJzicAI2PZykhZh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxOCBTYWx0ZWRfX5QHAS7REBFHx
 jBTiiHA2pSzc/y+J5uM/qoz3FCUl2IqRiKXZ8MPGaEcDirRqrIlUx/ENx5Nzu6gT8Y7HGKnvJsd
 fsrH+jCoOkGzSpYqfocQtFwyoTX+/wvWVlYq6AJdLDJsHiv7TOEoy6QvJ3rvQPrrSSwfd8gU4Dc
 Pc4NQSPIL9X5u4WeRZN0CtAJ5jvAap88ixrmx2l3/Z+nQbwZCkBkkl9qa9zT1W8wYsJDNIEGhsQ
 0ScvPTOum4L3WF4SnDKpuOAidcyWimHyu4BdfGAqO4ArBMstcjJ8KMSu8L4OcdkQzvFqJzIEz4M
 0Kk4FuLCHbVhtmAEFE+hCYm01ZrTz+zRy79f5RlaBZuKpVOm0MrFmGK00z7sYpp9qgtI/yIiEDe
 R+MGUVhaXy0pmGeN11M+5uCgJDE2lQWlvdujqW7utmKn1mWy3N8yDmYs81TvuklMsI4frel0J43
 0MzVvhKw+ZawAH9hRZA==
X-Proofpoint-GUID: AfinrbpbOliLt4gSz45uo6ByqmT9kFCo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050018
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 10/3/2026 1:12 PM, Rick Richard wrote:
> Allow changes to the riscv64 virt board SPCR -- we are going to fix
> an error in the UART description there.
> 
> Signed-off-by: Rick Richard <rick@sloservers.com>
> ---
>   tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c..aae97304 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>   /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/riscv64/virt/SPCR",


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

