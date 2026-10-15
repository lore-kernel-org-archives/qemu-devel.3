Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE51CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPW5-0007kj-Bk; Thu, 15 Oct 2026 13:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHPW2-0007g8-GG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:45:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHPW0-0007eT-PK
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:45:18 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFE2qa2678271
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xYt1rbgJV4txBMJ70NH39pTqNyrI31SPYSrAaQli44g=; b=JKkWDXoavY0nKDi5
 ZgZfFsH6En891hlh0hn57Q0qpv0pb2t985zoB8c6/AZ44rD/VbXqwIOesMKYD2Sg
 uPONOI9tm40todH3yu+ivko0+2BwkByUh1fjaK0tfPi6Y1Gc36YGIb53njayxViL
 LFA2RXNBTXYgnTnIdDLy9QjrwVEAO8LuDTFhSOjZzsrWTsfATwxfLF9Mw0TlHIsl
 YLSWsvPJHByzs1NSv9v03CCskgAGyYCUddYvUSrt7eF2/vh/3dgpnBig+Cq1EAYN
 ySos0JFkNeWiyvhPXfLJScnHGDTJk+3v7TTq60On6GMg/HyJ9QzQ4J91a+iyjSFB
 RRHG9g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19t8meb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:45:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so1235325985a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792086315; x=1792691115; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xYt1rbgJV4txBMJ70NH39pTqNyrI31SPYSrAaQli44g=;
 b=P/2a7wSoDKzYcnkNIpkMPxpCVoeoW47eV1JVAUy03ye+6vFw/G9X2BO9t9NbMtUwtq
 CUrsqh5mHDP916PA2HFt3XW0BsbVp2mDzqSLoA6TzIuSrw3RFy3Xa9uqx51ibvH2ZLF4
 1RuihDHZUI+kpfDmAVKFZLxTvhc4U+jexO8zJgliEDGilJisaB0DZiSKzLGdC6mChkUc
 NGCwHz3MZEfOEOT4MdVAfkGz6BwHCkr5GTZ1U+25iSsGG8T8lTIfT7IwejtvH1ZP0obS
 zhSF9NDQAGjTLGUqzk2k1UFwp4fIt+PCPOV2N+1B73FUWqCYppUWFJ85JJ0fODbf1Eme
 h6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792086315; x=1792691115;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xYt1rbgJV4txBMJ70NH39pTqNyrI31SPYSrAaQli44g=;
 b=nvt8TWUo45++aEGL6HMD2LlF+92HAmXHzScRXTAbtuNtiyknWIBRcj181KddpMCmJM
 7ZpKE1seJKICZoD/IJ81uwqMVcii+YZrwUHspKpwqBBU84m8kt22GToL5Pfrpw3kOcwb
 8faGdaFXFl7GnH7xbRAUi7XpF/LQxuhZOHqu5hJg+T1wb27Zyq7wONX/rA1jiaZpugpW
 5O0dyMXrAN5Yz66fiEZ59xVlfZKqGpSQ9vIHe2ybWoc5XCJlbDvzVtg53TCVF9tgRt99
 ZRrgP9tM/aPH/byanubJQQlQZ+a4cjAnLOxGSOpLlnFv5Pf0xMOwTpLsITA+gCmHbguu
 u2qA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbYsm1l02UL7uZF1QZKW71VJXE/e7hQCHK6OsvY3B0wG+hiRF4K7W2fXmg/nWWWvb8rydX29NXhEsx@nongnu.org
X-Gm-Message-State: AFq9FYLDVXFw4vkgOhVh4THzzGtMM6H7pcKNYQbB8kyna9NldMlXMxFT
 DStOhrQdXXHpUO8j/XiTJeTyo2vcdw6XKj+T70QZUbkhjBMTGMamCic0uIqL4bOtWF6ykmbMMOs
 ihSpdT5QyTL4wPkez8OOZGOLXMK/udFcZY4orNEjcti8WDmbYZe66BWNL2g==
X-Gm-Gg: AYBFou1qipqPFiNqx39fkd/djR3GH6sk25h6uTUhFIsKLXUEX8UD+t9OzOPk0/KUD6m
 2wdiEDWz6pvSUZSJT72prHgjus1t7R9Y8qBHdCTp3QydSApJyKjINou7QTYNN6+mzIZNAdPXzkI
 IvIO6FQPCQ+yJjGmkL+PjElMkPG+DW2RDMPdlHi6aPL8d0HgG1zTY4IU1pRGLSsuJmIfZS+ImHn
 +jdehSKU9gEZcYrnI90KqUBKl3DJgih/CDCJWc1Pt4V3/eLSv6mcsVwoLzL8KLRg+qaFhvK/Xlb
 JhJXQRKIAIvLUlG0DVM/mGJxAXAdJA29hIpnRSkm+rZWClecN61+eTzfgm00cy1WIY0hvPPmq+N
 7t8nUUDgH35jllIZASeE/b5VS0ZfCtX7rQQ==
X-Received: by 2002:a05:620a:7117:b0:93c:c96c:a5a8 with SMTP id
 af79cd13be357-93ebd27c2demr3180466385a.53.1792086315064; 
 Thu, 15 Oct 2026 10:45:15 -0700 (PDT)
X-Received: by 2002:a05:620a:7117:b0:93c:c96c:a5a8 with SMTP id
 af79cd13be357-93ebd27c2demr3180462285a.53.1792086314514; 
 Thu, 15 Oct 2026 10:45:14 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd733fsm20183261f8f.58.2026.10.15.10.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 10:45:13 -0700 (PDT)
Message-ID: <24473245-6cb3-4c87-bf62-ca10672bdf06@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 19:45:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] semihosting: declare semihosting cpu ops
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014210526.104215-6-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014210526.104215-6-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AGqrJd-TfswNnmLr54U5AtKX_n_9RSlo
X-Proofpoint-ORIG-GUID: AGqrJd-TfswNnmLr54U5AtKX_n_9RSlo
X-Authority-Analysis: v=2.4 cv=NqZE4MdJ c=1 sm=1 tr=0 ts=6ad1112b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=wWFjoQrxsOrDmYlg02UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfXzkqs2sWzSbK2
 pauqzabpMxOOV6fYlj+rVfueRin68IVmGHZUmwLYlLMm+HSKUKUxYAxFTI1E/PiBGFBA0i6l83e
 Ct6rMq1kMdR7BUIa7jzQby2u7awGJ8WYWDcSzZyJ8spor0ksu3ug9ZfwotUSiBHb9JzJ0+VLhy5
 U8OYFTenC7AHswxL9ZIQuiU61kRdSmABxg9zFT8HS5TbvdfdaEztqk1MIHtmfZZ/P8p129JyQiY
 6CMIQZkvPwbpVR3dDn1kkbU9DE+HZ8TzYHmnrIzDwf/8TM7H5kWCiqR3YAdQMJLCifZnu6GmwJh
 wLb5gVWiWKB6HgoNyJFG+N4gRuW0DMyDJYUKFqm0FkPGMaw+mpcfZ7eNNMpbX0YbeCHN0VzSCme
 Xt07oVUQ7uiQHQbmKIW4ybsg4XlOXACKTlD7Yi3XJgyKzmis3SmSYzNJkJNPyljJcamOpoXaE24
 fK+LGWqIfujlg8ER+3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfXw7z1M3EKIT2a
 IIAdtGue/G9qmJXLtXSYaT38AVEr+pg1gdFSiHgpbOlZn+ISiGgjQSy8d6FyX6siY+RpwsfWqln
 3kbAnfiBGhtt2n7+n0R1dDwm0Bs7Wk4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150070
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

On 14/10/26 23:05, Pierrick Bouvier wrote:
> This allows a specific target to declare its implementation of
> semihosting.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/hw/core/cpu.h             |  6 ++++++
>   include/semihosting/common-semi.h | 17 +++++++++++++++++
>   2 files changed, 23 insertions(+)

Thanks for addressing the constness changes :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

