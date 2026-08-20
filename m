Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58DCC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7mm-0004Ul-LJ; Thu, 20 Aug 2026 14:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7mj-0004UM-0N
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:46:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7mg-00069C-TS
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:46:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJL7D352490
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vZOU/ofIwAhYTh/N2eBBRFVGHqUMPvHkmk63hwy0Y98=; b=Dhq/cfA/eBuDS9+x
 0I0IC+gybnyYLjeT6HAggm5nHKSigFwPPOb0fSnOkXEcPbWdE+gD4vHmpxIdQkr6
 pljHTio+E8P0eX83OU0UxLZLqjpG/lh2ksaALyb1dKuRgjFri1lTL+bqZ+yvhQon
 iB+MLanS1SG/IUHv03Svooc6mjakV/3dXEo/m1MkzQssZ5XeaHGoE8k6JoPzEl02
 LV14LC/jdppzrVeBhHUNlehTxVqAX7IQju//yAEk0+om3HB/3kuWlrZt5YOSP7rm
 4lOOEUtHIC9B0fymBQlyWIf6PYvLhGHgMt/kzauK7yEPWa7ZUQdNjDCmjKpFf3d3
 e6sfeQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg8abbu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:46:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb5ea36f969so234362a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787251596; x=1787856396; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vZOU/ofIwAhYTh/N2eBBRFVGHqUMPvHkmk63hwy0Y98=;
 b=d4dnzH0M6GMTN2W/pZMu8T7ljykVTalC5igs2g7HkHK0IFL5FNvii4CJWC2jZir4hw
 JvJ+8k+wjk06++DyTmUAGULg/D+PMvmeGNbLgZpDO/GslbcE6C0XXkj4OAQweatjdA8P
 f8Kl6FeglC/nOrVXyX5TdKjrtqDmUeCLWTYavckwXXOaxhBJNENVgLbbiUayH9+T4e+b
 STaOyV0Xhg9U1+LNRM0VJMeg4EVscyBxiTaAckOzLBdECRkNg3sIFr6iqxfvgjiUCxgJ
 JmzBs59Uym0q+SAjxLteG69Ke+Pt2wZftqnOEOgJQFfqdmAeTTGzHY5/4PQeQPIPgx75
 m4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787251596; x=1787856396;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vZOU/ofIwAhYTh/N2eBBRFVGHqUMPvHkmk63hwy0Y98=;
 b=OWBeYkAXnlRS49plAT9rT5jT1TBfJJb4vjI+DZUu4wsEtGzqkMBpoZHMy4BUXJyfQL
 GgoXrqb4EfLk7+wTImvHgMeBQw2vpEhrcUduMhxfMJmCTNzcyvrYk68RiEhDo2VekzVB
 3C4dgz5N44E2Y+OMYqSrcz5et07GqA0KzawpMc1WrrLOE86UBpgVHUA0xdrpCipcXylN
 hXkmapALYyfORI44SAxH0TcKZPUw+UCNed96hSjxwKdF3exHNGEgz4qjkPt9Ctj/3lBQ
 e6VBjOKiv59ntAeXGokE2KyHqhUiUUoXuif20B9eXBtRLg2cCniPLCyvsOnjxx55IROY
 Bp2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpswDx4V5S5tj4h/6R3dPEA2M+t742mBekCnRff9oPps+aJ0CPx1iHFKhH6n0y1xgKq5JlhROdfmBIK@nongnu.org
X-Gm-Message-State: AOJu0Ywsj7XuAyUO9vSvfvOi3uZTVWESV/fsqydJVPpNVVGOXl391eii
 uYnqTdxzLkPeggchjjKYKtMuswNT63wF60oEyc6aFy0aLHjVL/L6v7u9vEAx6QpiQV7gdmYZrik
 aI+b01c0njT3XpVqIBCTjEjxsJkLFsDMm06Ga6b7j2CGxfHkeOt0zuXRZ8L0VyRAGaA==
X-Gm-Gg: AR+sD10auuLMTfKzsZgg116J7eLutXPT8tN91GfVLsHwsLZQBK4MqQiPLpGrmqqXF0D
 GnEZpV2OHTqDDMoxCGO1aC9uNViYlNrmp7PYVTqUyc31d8WdOZEV/B1mly9Azhz7Gu6XcWMzanf
 paFmYxP103fw4XbHub0B1eTFyN7Igo91EBhwojiLftqCJQGeTqXGZWLtf3fa7LGdcXsMZ24lQRG
 678rBlKL0bpgPKphiLHraJVuPK9BdJYIBAlNzW8g6S058OAEo3TUySvvXmYZ+B7iPa/2yhMzK6A
 9jVjgvSimqvdIvcmIAuc7W3dUZcLqfBgdHQj3YLWgfEblAIjnJsjFLZcsP3BRcH7Hctrnx2JLjj
 otPkM4PNhUk4wboItR+M4xvGGOam/v8pQb4cGOOwA+19AdrU1/a60uacGUnN/2K2zQahH
X-Received: by 2002:a05:6a20:c90c:b0:3cc:22bb:8911 with SMTP id
 adf61e73a8af0-3cd2fe7a2cdmr1063994637.6.1787251596178; 
 Thu, 20 Aug 2026 11:46:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:c90c:b0:3cc:22bb:8911 with SMTP id
 adf61e73a8af0-3cd2fe7a2cdmr1063870637.6.1787251595639; 
 Thu, 20 Aug 2026 11:46:35 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf175399sm33183171eec.26.2026.08.20.11.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 11:46:35 -0700 (PDT)
Message-ID: <99c5cf2a-268a-4e21-b7ef-18413387fa1b@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:46:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] target/hexagon: gate GPCYCLE guest register reads
 on SSR:CE
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819013144.3264096-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MSBTYWx0ZWRfXwnLpiHATnxQN
 NW0Hp3Es4xJRy5R5zMl7+q3vlC+7rJSabsdJXHB0TE0gm28KWmlUj2gWy1JmHif9LohbJ57Y0Ts
 qhQk2Lp8zc6fJFCXn5CvLJOXdsV5muM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MSBTYWx0ZWRfX6MmzhO+4Qv0w
 rIUP9Ud+SVjjIpc7wYCVp5ETC3Zu/bHZSKQKoQEvEIpoXSjut6xA6icyYZYUV0og1zOgIT9+NTo
 Bia8F/ddldEU2xZWLO+5nReyd1pshedlpqp5ADqNl/T5BHa3y3FSdiMFk6XjkbpIN9BVMoSUW+a
 BkG/froUWgr0eCbYmroWg0pSiX0ENOtAZTmWX90kgPMVmZptZxIO4wadlVuyt+DSCo1AFdRx4ym
 Aahq5IFBbPSrUFhiHKJvUU+byy+vahMo+p+ObfpqqPs5CORw1rImgzlGeLpkl9g14ywCselPVGP
 P7YkKakwnFNAsqS6K2+f4+LejQxKun5H89orUzEBNQgWhnS40TpCGxNTiFcAhVgHMGUDcQuvhOT
 NYvJaD/m8VWBNAR+zPuUZA4tHMCbZ6TItXR3aqw1heGQhqlsbTPDIHqOMiTVYhe/wfSKeNAORhM
 aFo7Y3ArmRefRdEEekQ==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a874b8d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=iTxZZLL1oD44ykbE780A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: mQFh_ZCBZWxnZ9ye9dNsJDRgU3Jjdmgq
X-Proofpoint-ORIG-GUID: mQFh_ZCBZWxnZ9ye9dNsJDRgU3Jjdmgq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200141
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/18/2026 6:31 PM, Brian Cain wrote:
> GPCYCLELO/GPCYCLEHI read as zero unless the cycle counter is enabled
> (SSR:CE), matching the hardware.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.c       | 7 +++++--
>  target/hexagon/op_helper.c | 9 ++-------
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

