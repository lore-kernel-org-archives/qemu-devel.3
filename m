Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B039606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C1ZAYooo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S5kJSb53
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIv6S-0005fQ-6j; Mon, 19 Oct 2026 17:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv6Q-0005fF-2i
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:41:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv6O-0007Vk-Hj
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:41:05 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZVWO3389798
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4qZfyyMbAFWVnUL97nEZsqWKfuLZ9KhO+eLlXWyCnUA=; b=C1ZAYoooe3RbsWaK
 44EWEJ8yMRWAFUD08AgyG92lN/1gLi5WBkCYBXIcHYPx5kAD/Ff2eXNLTwsjOLzN
 98qhFNC3BS4lB3JrcExmFy3njJ8lGZv+n7vUTIY+11pNjyvngyVAcvcCFel1KvRI
 5VC8c6xrfNJJowXgDPPW5aA+cVUNAo0q6RHEt5DOsYXv8vUt97KMdYXcEJ/aJ9Tr
 QM3AZ4RBPTegsUeUKHecY51IgpAy5d3QkP0mjVqBTGmln3lI53W6OMhK9c8NZTOa
 yZA6HyihS4C+CZck0+I9qD4fYVBiZUrGsfVnrf5UBkig36YjV6As2fRgToA5BOQZ
 NswXKg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4q0qnd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:41:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso4949353eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792446062; x=1793050862; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4qZfyyMbAFWVnUL97nEZsqWKfuLZ9KhO+eLlXWyCnUA=;
 b=S5kJSb53L5hC91n1VFiOumumTDZGQydh0NxQSbt+tjh7llzhfy2YWUxXYllAmABfp4
 kJzhLHKSJ/ktLOK0IgH2/ChkB/rfPWpZQZITi2XlUi7nOmnUzAwKHlofDGDflxu2p0lE
 WcXVZ6niqwQvdd19vebXryKesN3n/6rTBRkKhDelPJbyISpD3AqKEUtm0rIRL+UnjKTv
 9EgE21cmWxDYnGD1gRyBtXUTCbZKIlgAxJ06cpEAYprb4qkPJFQEF7GPujDRu933Wsd8
 azaibe7ypVJ7s3EHLaLi+yHo5P91mXRy228XZOYpPaNNRseN2K2/atSx8UdctxeXBMK+
 1cCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792446062; x=1793050862;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4qZfyyMbAFWVnUL97nEZsqWKfuLZ9KhO+eLlXWyCnUA=;
 b=Q1vbKoCwP290JX1bTJrNNRVXhZ/Fvk3LEbwizyzJ5obnXrKLIF+yY2KMRbH/jlvMoh
 NP56o1Vhb612nf+Vru9DwxVPpTWHqDuU/mIanoMmeiPXyBoHxMLyqrwqm9uQHkJi/5s3
 EgdkKxf0C5wsHx0QkY84NL3ypa8MGkkPvwKq/gTIaoOIDodRYzvD2G3CTniC8m376fKt
 icJNFiPI/1ErX8rTWtrT+lvv3k15chDniZsKX1Wsoh+7pb2Qmq8LJiHqrUi/D6AU3ZTi
 Qa/i5Cdt2SaujIbkHQykdDp+uh8vb1LSVnd6v3S6K9IBtpduxdzpRkG+Vq0LktYE6woB
 Ifyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYdkpyKtgLGRhyT1ZFLQwoQORyoM7hlBFo/zXISkdb7A+m11j/am59oq3y6ljqj28YUN5L0xq+41af@nongnu.org
X-Gm-Message-State: AFq9FYL8DZz/RPLnQVXHgNgFXobl6h7eIoo09Ry/8vkCK1zv75iRxnoj
 wix9OmIdt77fN2J+r08qCrfqrVYYQPsIbiqyL3+Pf72cvPWCC6q2Cw4cmNwW8K0HSSSImW0SSgi
 ZDsvC5hR9FzC413ogjiOaFj0S3/LvNfkomauhP1W7RslzKy3uWZySlqC5dw==
X-Gm-Gg: AYBFou2FGCUO05GL00bprM/znQg6WS/tlNxCsPltdOoy9mu++oeYMP+XKX80plKNE++
 A9f8LlspwogTR9ZWTRD5ZGYHQrvlCw3D1dUFnhlvz09B3CMmVwggQPu4S8NV8wfqVfqDFZfD2tT
 tAly7oIEZQge7+JyV2TzxnvuIgtqDgyipXkHY66Xy2q/YDXWq4e3HDW5wDDLbpbl41hK0Lbx+Hc
 VUJE2mGbmrWNIkR7PfZsgTDHhGvmXg7QVZJ/QbtFvQc94Tzdv58sRXgMzigyfSoaJiIQYpkTN8O
 FRnz1WmOFY16Bmx5R4PNU5yL3EsVmw3wOpQ4+LBIosFhjAoyCaqgwqQ1JMQ5YvtWSA+63u6/0Uc
 +fc1ou2NIibS7B+bqdWCuGGfMRehXI1jS8arsGvs4E3OPwbVmUOgmQBTqnwcMaijvXMAgcg==
X-Received: by 2002:a05:693c:39c4:b0:35e:cfe7:4c5e with SMTP id
 5a478bee46e88-361a284a463mr12897879eec.41.1792446061924; 
 Mon, 19 Oct 2026 14:41:01 -0700 (PDT)
X-Received: by 2002:a05:693c:39c4:b0:35e:cfe7:4c5e with SMTP id
 5a478bee46e88-361a284a463mr12897853eec.41.1792446061374; 
 Mon, 19 Oct 2026 14:41:01 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608219f838sm34901398eec.19.2026.10.19.14.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:41:00 -0700 (PDT)
Message-ID: <430f533a-8029-4b8e-a5b5-9f43a13b159e@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:40:59 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] hw/hexagon: convert virt board to hex-board
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019055245.1457795-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4ZD0aBokC5XjZGemaTX6RaBRxbMd0gOS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX1iesm2idaS1V
 GY/hUQZ0tPOL/q3/MKOhDe8A65sWP5ELGjJXjCQJoBwjQHHWONZMC98hWzGXUoITQY1lXjnhWpm
 VwEuiNN1O3Hgm2B+k57C/9SDUMFLIR8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfXyHUKBecC87+9
 fwwyuc87mWGeTkXvX3XNQPwhNrMSIGJjV21/LeEmV+2mw36ZgrUoCiDwkDga1xRjdtNJ6RKOjdq
 fGZKB1ow9t3K4OA7r9WDFRpTNf7lxu2pURp0Rx8FwQMkEVR5gpTC8+CpmEbvylpb9dIJxl/Zvtn
 6cXv6BghZUBZ2EHeNvXCd2GIwJ9mb1jDIkfYpNl5nc49C5lLdA0Pu4KO0XDd35UCJH1HSQG9ExU
 600hPgX4RqOCSUN6NYMJziB76sM2oTCTMNmDezz/E6JXvM2k01200Fzl3Ob9e6kIuIhCJYWRnP8
 s5Ptq76Fd5AHpxp6L9+t4n5w9S52w2FFEHYqRERGfuSjxTu364hblYL5P+gM54Z2172ksWbrsOF
 34qC7vJnsJaFGRlFcyUBEU1smEG4mIvogN8o4goyfvHQ6iHFKUgrJ/D6I4rNxqOWkVOfQuHbgQe
 DxvzlZroxESap7YR4jw==
X-Authority-Analysis: v=2.4 cv=aqsnmiZV c=1 sm=1 tr=0 ts=6ad68e6e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=qYXX2ZwjeG6IFCmtEZcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 4ZD0aBokC5XjZGemaTX6RaBRxbMd0gOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190086
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

On 10/18/2026 10:52 PM, Brian Cain wrote:
> Build the virt machine with the hex-board helpers instead of its own
> copies, and drop the machine state that nothing used.  The machine, its
> device tree and its devices are unchanged; virt writes interrupts as the
> bare line number.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/virt.h |   6 -
>  hw/hexagon/virt.c         | 309 ++++----------------------------------
>  2 files changed, 26 insertions(+), 289 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

