Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04326C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXyN-00089V-94; Mon, 24 Aug 2026 12:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXyK-000888-Ml
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:56:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXyI-0003Hj-74
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:56:32 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFmhY63994029
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zMqDco70yKrnYEXpuG//geLuAF36CHrsghnRTU7yOrc=; b=GAmEEKKMWZJaiS/C
 67tnX6DIMKKVWYqfUwFixxCy3soAzXz3Osz6LVws1NwJ0RlQG7wW6EQOIWkREG1P
 K2Xe00qqOtFK+N7y0M9acN13HUrSTKAXPZmzkehszYXQiMXJdKlSMCx0S25EjPCl
 +6b0HvHC6yvjyXkxUuOIIS9QKYosqJMvp47etTlOrtxE68aO0lCjKLuzKuYvoCvh
 qnUMyfGD293BQYJJekduF0YVsDw8wDfa1wYG1y2PAEW5totnQ+nKDsOQUV7U6wh5
 n1XM6QKiNlaIh29TI1mwCJLYBO86RdYYzgNmQU3YVvLSzgjmpMIMU3MHePnKecd+
 l9DTXw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8jgk2a5h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:56:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so1540798a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787590587; x=1788195387; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zMqDco70yKrnYEXpuG//geLuAF36CHrsghnRTU7yOrc=;
 b=KQ5mg0CJLrf2X88ePPLT3rGRb5yMEG2oDLUvcfg/hFGV9x1BLItWNGYVOgWWPvQyrA
 hUGE6wCldmPyrjm7NC6Is1xpQv/+CZKPnxL20nUEfotbDoMgdJAzwC2Mr3lJG1/b8VxH
 nIiJ58BSSBizdrO1/Rm9zGgrBLESpNA+WqQwU+GjiE83XAOVVZA6KAdJVUkwlMSdisDa
 x1aRtxT2vN19IpdSnCpXSOfMS6u7gQ5UW17p5pI4pG68EdKQ/0qeOUYvmStDKiNTEZmA
 jmx0A0J0EuCbRchdqblzbcpwsc8IbXdT1nr8Vq6UJgg1FmDbUXx4EAkGeGTj3ulvpIb1
 ur7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787590587; x=1788195387;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zMqDco70yKrnYEXpuG//geLuAF36CHrsghnRTU7yOrc=;
 b=sqMlXYbsyK//FtcljfauR9wJ6igyjGeiU44a9jdf9897/JVPyDOENe+gcQkgC5dbJp
 4ZVAACeWa6nlmaU40NpJVI4AYuyUIZ+HwZr4EVVr9XjWm4l2fOQVPTstlHrCwmTMoxa8
 GDLlWs9nZIrFBFFTJcrTWTVSSYT3NdpuEwrGXQoXXpkzgP84C+Vx2PkbI5P91Zrlfha5
 NoXn44MxHh5ltChIq3XqFMpR3rjaThwivZWLaU0qS6q7+lJYK1PacprWerNOy2yUXgLo
 VD6SwfS217cbjKSBL9GWX4jWE+AkRELUEhxfy6atd067N+E8uhP4CY+kx1sjxDm2NUPc
 Vrjw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4KA0/xg2M70EArWuPiYHCErG1hSA+8V7G4g3UataL0U/oQxb1GO4sImfRQwzZc57kG0NiGpD0IDiy@nongnu.org
X-Gm-Message-State: AFuF++mZ/bqtnbdPLCLORkcqtrmm6DD2VLQrzu75IGEmyHH3kH0R924V
 UKpPklcFHg3ZPKNzP9mszHOEXmgmYTYd6e6JAbS/Ea85c4n7uZdXVqJM3OPTGuZA2q2KeWzzVtr
 SAYBFX7I+D9g07Je/1OwsIB4KDI4y6XMh1dgOBzRjmsKCxc3lpaFhHSw0rg==
X-Gm-Gg: AR+sD12ueCl55QLzBhbmc+AMiyQq7IE9OKxaW0Q5sm2qqFHVyDezdwiAdFah7RZoYy9
 plEO9n7IjXzctWgzt85gNLCPhLRJ78tRU3JtVHgajIcN5tYx8yUjLmod4d8dPCuwPmbEJIH9Shv
 e4jYFgEeUnAPF5dfm768YXeKlNdFVcvVZdiH9xvJ7QwI2oNN0YT7OA9GM0whiUhIB6DJURnGuY7
 NwoGVHGOUF1r8x68mdtbyoNyS5xfepSIAW5oBmjFtkdt8Hx1xy7y/+Cb76WwEK8NMZaa1YxGMGu
 DSSTlQy+6TC5KCTV0QWN+2Xwa3apciMJripEBNy0oqn9gcBvTUY1TC7UsTA8Zz6L24xvix8kuG4
 PVd+OvGxwtNbyRnSB8QtV/465QMoKT9D4k7RCnfvoq6/Q80JK/bG8vp2CMo2iDM4r7jEb
X-Received: by 2002:a17:90a:c107:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-395deee4081mr39551707a91.8.1787590587059; 
 Mon, 24 Aug 2026 09:56:27 -0700 (PDT)
X-Received: by 2002:a17:90a:c107:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-395deee4081mr39551624a91.8.1787590586651; 
 Mon, 24 Aug 2026 09:56:26 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39642437ce2sm157565a91.1.2026.08.24.09.56.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 09:56:26 -0700 (PDT)
Message-ID: <3404a763-4eab-4316-b67b-71b8875829e9@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:56:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/40] bsd-user: Use target_suseconds_t
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
 <20260818-misc-2026q2-v4-8-09bf5647c98e@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260818-misc-2026q2-v4-8-09bf5647c98e@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 533dQU2_t5cCqrgLDVLcBrbwttIKTRsn
X-Proofpoint-GUID: 533dQU2_t5cCqrgLDVLcBrbwttIKTRsn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE0MyBTYWx0ZWRfX0rlWSBeJDDeD
 AGFRod/99cUbsk4UcoMm063MBq5Pc84MZVDHucqLu4bi8xnHc+nOFLwZ7aVi75LgSrZ1gIWF/7f
 g0vUY+b+Z19bbUu3dC/1GgGk5T2/Vv8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE0MyBTYWx0ZWRfX3grlnKp9c28d
 0wC/uOjfCQ+xx+0t298ZsyKyhy8oEEx+fliUviGEfTr6rrD+0efEtlc3JmgcCJ8Mjme6L0rCbTK
 nVYLCI5a3NIIiOOXIBFljmVahSawNRGqTz+R7Cz8ngJE049VnOpCR2GbZ0FSp2MRhLhJ67mGrZq
 aE7MJ46E45VXedP4wNeNcxIm1wuhO5lAw7TEfK7H6rp61DylVrfeGFLVMtS22T3hgNgYRNBQkEn
 Pc+4Nvq/JdXzQ9XqwJiJ1ccgJHTv48NJ2iNczJQ0G37yvfNcsIjKr1qH2TS2LyaRwzBFdSePwhS
 ZfXJUTxo+6378dE1cx9xbVipNyBIZTa1s65elmhSWexmoTHap2bh5J1Igrj+o4hqex3THksajRo
 lcgvMvdiH3uQrSVTHGZoVZ1kNbZXdOBvqzU6/65IssAVY9OUHgYegfUMYoR7X7HpuhLrmVbO2/A
 5fWFcoB2uoQXKKInKJg==
X-Authority-Analysis: v=2.4 cv=KcvidwYD c=1 sm=1 tr=0 ts=6a8c77bb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=dI-zEK0uZm7GbzRXY4gA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240143
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

On 8/18/2026 4:56 PM, Warner Losh wrote:
> We no longer need target_freebsd_suseconds_t, so use target_suseconds_t
> instead.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/syscall_defs.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

