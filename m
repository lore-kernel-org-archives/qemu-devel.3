Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAE5CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWL3-00016M-Jk; Fri, 19 Jun 2026 06:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waWL1-00015y-Tz
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:20:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waWKz-0001JL-V0
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:20:39 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7OgGY3736926
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 10:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k5LtGQoQFQf4VqrRo2xXwzBg0+HbZFLTaHz43sZ8sfA=; b=SrDPrBMNVbLIE0xw
 2SpikVY2T5BQuttVceRuswUXvb2VFWQDE1O4H5JcdnyCoHatw55RcYvUHZuvpIbi
 bTKZfzjdRYW2DtXTNN/u+lttZDkc/e6KVzQO5Tlm65cHReJeOe6W6cfbVL/i5aB4
 t4IhMqS1iR7N8TxjPVRGpMuuw4/ABvBn862WJoeGXH7YX42BdRNRxUdUc0IrDuIf
 k21FTm33wqk7qkbBNjBekFnrOwSrV24Jrb9LkxuI2Q9TlMb1y08W9rnAB45IpjAL
 IBjrRby4prOrhukoPh3vHBnxUjSIe/60ReqtSWGd/EtPnt+b74cEkDC08t9qFARm
 KGgF7Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evm26bd6j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 10:20:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91579011fd1so294865085a.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781864433; x=1782469233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k5LtGQoQFQf4VqrRo2xXwzBg0+HbZFLTaHz43sZ8sfA=;
 b=WDO2FNgOZi934J8qJ3deFhEObbDehQgXBU8z4xM6WANfPNvXzxxqdsWx5YAbI5ClCH
 N8iOqkrO4zZ7ko/S3YGpo1P3OwrmIfJ93BwEHGlB3x/sxWSK85EytT+yEyDsK9dKliA4
 4bDViPfaXDh2aeEY1aTVFSMOSh7A3/gaCLHh8zI2yotWRTYMiVGRdXH01YRPXlfyd+Ea
 Llv1MVY4uS0fPUf26YStTx6WyESOWlXGqZ2GbNLHk8OG47kcCOw4WBY1Wjk7f2C4eVA0
 ZiqGmThSbc0MlY7syHVVOwdoTTwpXI/HA0P2l8b/dliNb6Ja5E35pQpsmMr1o7JAZzBZ
 qFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781864433; x=1782469233;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k5LtGQoQFQf4VqrRo2xXwzBg0+HbZFLTaHz43sZ8sfA=;
 b=NUHjpoa4nToJWDdi0gDiXHRvl2bY4YdXUsPwaSYSDDW3PWuGyIPInKjpIq5bbSkFaw
 1woOUcP92UTDskdH+YC3+/XEw+8UqpRNg/Qjpa2pfbSmqTNPlWlYC1S8UGPSKjNsrtiz
 nBf52H11RDkfrP+3gBH6f3sZ2N3SUsPq/wishLorkqbV7QIC39ZLRa9S+96msV88dqkq
 wLItxW/bCUgIYINt1Y7ktRlYTvb0VCKVrZz1kNq63B+jmGqFSzG2PBaCEp9XF0CMBN56
 FEcDm7FGq4U7nj2th84cb5yE20XC5xm0LqV/7CGDLZO0CpnoC8J4EQw248DdNw6hZy8Y
 iAZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nqtctFPkdL2/AgJFF324jbRWiais/ig4zT60fWDXuzVS+9U3+xYABJdnBQFzu+ezRF6vxV8taQU5y@nongnu.org
X-Gm-Message-State: AOJu0YykFS3RAcBCMpzFVpZUoXO0a4f7Bts5AcaD6VnHz1NL0Kle5e/n
 FC68Yi9vRQZg0rifD+7J/Amor0Rxljj/SFKl6bjB7Li+jJjb96GUDkyPDBtr6stumlNkU3pwgEZ
 HF6tsKyT/rt8rVs6egoc7LB995jfGGVWOOQbBgomWw45QU2DPLo2hjeQR+A==
X-Gm-Gg: AfdE7ck/J0ptVx+8ynCLZTehKGxFPbE5r/3It4FV8LLAE6Ce/5NvIsJsAbWyfJk0NSi
 kYf1RlYWZrQk5RkFkrLL7fh50XCm0DJhSN4/fWqkhB76jh1bE2GhQ83MS7WEd7BFOU/KW1XrHNk
 ZbC7JDmGb7s43ci3UFFcvs7yr4lo/rHRUDelFq7Ze8uHdwb5/TdCKUlrzDqRnUyzMKAU0VTdPS4
 Jn4/R9hAyp7S+NdyLgMtbcNHIA+dR2eaGFosrfBi/pKwmCX4RZ2KxvhixQ7Ufg5UR7r6ZGWM8Hd
 ye4Lv9qe1yDPef/x12m1phfWOHdUtm5oAFpJ096dAZbgpj8f6FZAzUgfBN09Gx0ugHRm6SkV3Tr
 XFnt9derE9Fq5Xhe6Hz5+cGusZUGAhTzWCNFI31BhdnUGdeRSaMnY/gPzIPn+GA==
X-Received: by 2002:a05:620a:2904:b0:915:c365:ffcf with SMTP id
 af79cd13be357-92092a3e624mr408438685a.54.1781864433476; 
 Fri, 19 Jun 2026 03:20:33 -0700 (PDT)
X-Received: by 2002:a05:620a:2904:b0:915:c365:ffcf with SMTP id
 af79cd13be357-92092a3e624mr408435885a.54.1781864433059; 
 Fri, 19 Jun 2026 03:20:33 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fce9590sm58737235e9.4.2026.06.19.03.20.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 03:20:32 -0700 (PDT)
Message-ID: <56fb8845-9968-4492-b0bf-333c8d8b1653@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 12:20:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon/idef-parser: open input file in binary mode
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Alessandro Di Federico <ale@rev.ng>,
 pierrick.bouvier@oss.qualcomm.com
References: <20260619042840.2169504-1-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260619042840.2169504-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA5NiBTYWx0ZWRfX+eeGK4xcDtbg
 jlHnxqPgucRSDWRix5OUaXyBeA4Z8bFm8evQc/zh7NmqjU7P0OLckVRI+ytH2fkCI6lDA3lNFft
 ufg+3rWLJcs1Dzp7TYmJBrYZmLnJIqo=
X-Proofpoint-ORIG-GUID: fNZm5uhMrByEJS1gYiVJ0QxviHRGzJ28
X-Authority-Analysis: v=2.4 cv=dL2WXuZb c=1 sm=1 tr=0 ts=6a3517f2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pE0qSxkZkNyi-Oj3SwYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: fNZm5uhMrByEJS1gYiVJ0QxviHRGzJ28
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA5NiBTYWx0ZWRfX6AKlaCT/fZJi
 wtDHlKH3SjOhyBAk/ztHdh2iOXlS04Gw84iNrvry01zZLV2OZCB1CpkkQnZXCGMhXmAHUHfObJy
 jmloQ4ZHPfIs+PvmU8UG7mUFbw3kNVWcDt6nIPQG5lkapIFIooHdgeUKRA8NQuz4Ue8neyKXeDP
 5f5tdv/p/kLc1dEl4TJJuAb8S/UQai0qh9PvQPmP6Y4MGkNHbeg+WRX6CBZ19fZiWQKTuHRNJiT
 78DWq+ZEnsQmHlCC0ZvxTzJjkXoLJbYMyTtr+xB64D4FGD7r/1UCSThCE8MbSBFLvV/3Ce/syFB
 oO9fjsX6WDHBayES89s1wzrEgv/xHCL0mxnc2NBo4RZZoDoIBwsJRU1HHcnZCyWLPLtM3ZVIMIi
 CJuzO3MeZ2YEW010QGpWymZz0GE4AZFdJLnK5edjZzzxRoQkNKHvyTqWki2T62+0nMm2dGMzdCm
 Pg/fNPgqhWRg3Cx3chg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190096
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/6/26 06:28, Brian Cain wrote:
> On Windows, opening a file in text mode causes fread() to return fewer
> bytes than ftell() reported, because CRLF sequences are translated to
> LF on read.  This causes idef-parser to report an error and abort.
> 
> Open the input file in binary mode ("rb") so that ftell() and fread()
> agree on the file size across all platforms.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/idef-parser/idef-parser.y | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

