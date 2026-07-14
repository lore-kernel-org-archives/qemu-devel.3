Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B05C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjf60-00079g-EH; Tue, 14 Jul 2026 11:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjf5y-00079S-Mu
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:30:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjf5w-0006Ce-Pe
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:30:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEcfHU893879
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7M85HDkUrIiwBN69QULDOK/t6+sj23G7KdE/knZwirQ=; b=NmeQ4x917eOstur6
 7lD4kfNzDn6l6wrQXlBuhcB1p9mWiHG+C6sSr80o2bC2DwQ9grZYkl4/OLH3v6qj
 7HWMyiyBoSQLZBjBm/uj+3bJVpa1EMQeMEPDJJafTRFTKppS+oGdvckHuwgM+71q
 HIXaIRP5sppMiIKY4mSuXBNtLkB+DDWg3j2lEsEqzyENbW3qLju1FH61pXyo4uwf
 ynO2mGDX75zVrgoqGpwasDvXoU7fsAyzIbVrpa+ZshmzuNe1tvhIJwt1tW7pc0JH
 N7APv6aLLACtGuCDtbBjvheXzvdD7yy5N2OZNIh3RZzRoz+Rz1LgD7Jym+UY72G+
 ZFDirA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnqrmsg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:30:50 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cab041eced3so4808607a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784043050; x=1784647850; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7M85HDkUrIiwBN69QULDOK/t6+sj23G7KdE/knZwirQ=;
 b=AwK9RbSOKCzZe9HcZaEPH3zqLHFzOcj1HgmFH6psW96n2Wp2u834yTNsMC1jtpdq45
 z4yPoytPpB2xxR8A/Wc6Zcs3KMZppJXAAOFydut6XOYIXMbXzn5qz0erGVL9k6m1KUoW
 RMZBzPkF4EgjY9M7juHdMmJmVwgHJRLf5NqAScoH7kHuvR/EQnimknPBL+E+XRYawfUq
 2k/UJSP/iqUVElQ7WlTbqdR7XFg3v6fMIS62DGGCR4wiwYco6CRTLtzvKznMcFtY5sdp
 yjjb49rcUKROAOypWFpOM0wpFwt1vt/0sekA2rfkJPEYM4Fa+pj1epQxRCivMWc1oEnU
 Nmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784043050; x=1784647850;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7M85HDkUrIiwBN69QULDOK/t6+sj23G7KdE/knZwirQ=;
 b=mJIFbrWK/pU4zAnTjzsnILL9U19uUwUYIMVkpF5rEIJdMb7IZvswo65NMGxiEg2mBh
 GMxxKGHy7hwwVFR8Oad961Bv08oz8mZa7YrkxjIqd618kvIhgcHK8bhIWyYdHyqOrwU0
 RK57tZeEgeSOxGoKS6Q+8XwHn6ZhBmXD/CpEOYforGEk0zt77RZSHwKydoE4NLRiqOGG
 N/CJPCORZVxL9W7hmcLpGdvtBYmxMKunn7PH2sGTA3RW70J5X6Gp9QySpupQUJyq2WL/
 zA079NhHBMtTyp9McDiFPA06BbTxUv79jBmk9CBCuKyr6enk/+0/veSrlRvez9LY7cYV
 UImQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSeeyZ1TV/jzjOH12c2BwvJ8JXtSgrx/v+p8BQh6WsGToxjkiGyE+wpdSUHQrgds2Cpx5pCLICHZkC@nongnu.org
X-Gm-Message-State: AOJu0Yy6h/hFIizSRZkaF31RevfrzespBYk9ZgdM4t5dPDyr61NpcMlf
 uwR1jWaltO5+c7bjPGXSa1yCpLMcG2OgnGYY0AKovt6htxtITFW0Rw7eH6lvNnI4IreU/GMjjf5
 3wsolZe+9IxFQvSlZJXuQK9qt1GAyrg+UIKl6k9NlP4aHuZ1hQVZZ5LWUag==
X-Gm-Gg: AfdE7cnzNXDD5JS+t92FMPwoLyOf44NHCUxLaRIkgA7fh61npxxgWRoW+Ylhwn9RSPP
 Bk1/Ei+NdDaCxZTXMq7+cAo2Wu0hO0rcQQhCVmCQiGK78kzrUeTuEXaBf1WMraY2k9wjR0KEMsX
 r/Jgj+qv20+rK3E649GdboVf9ZS5oy9frDeJpwiZiaOZYqhYM7zw7ZybjyfkBNdbKYP/nifAK/c
 /MZdqEXFGnqmQb+wMSwYTNUAmCg7D29XMeYs3LhlEVZt4cPALQ/W8eyXq2kFkky4pYQgMO1Rfbg
 FBRcOy8o/y5zYs/3JLfspb0GWPVnk77fZewo61fmCYlNvzNwgd+xW9x9c7AHVWs5TYvgf0aXb3j
 i9JxiLYEDK6AjpgSiT+MpqMmClACg83LXfmuY/7Fe/BEQbITR5wwLTMYL7cUhlqF913/dRYMFNu
 I576Q=
X-Received: by 2002:a17:90b:4a:b0:388:cf45:d72c with SMTP id
 98e67ed59e1d1-38e1aedd604mr2979716a91.15.1784043049639; 
 Tue, 14 Jul 2026 08:30:49 -0700 (PDT)
X-Received: by 2002:a17:90b:4a:b0:388:cf45:d72c with SMTP id
 98e67ed59e1d1-38e1aedd604mr2979689a91.15.1784043049169; 
 Tue, 14 Jul 2026 08:30:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313f3ea883asm9261711eec.29.2026.07.14.08.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 08:30:48 -0700 (PDT)
Message-ID: <602c54c9-8500-4374-8b7f-cb7f91a39b0e@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 08:30:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] tests/tcg/hexagon: add unaligned scalar test
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, Alessandro Di Federico <ale@rev.ng>, 
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 philmd@oss.qualcomm.com, Anton Johansson <anjo@rev.ng>
References: <20260714010955.2226493-1-brian.cain@oss.qualcomm.com>
 <20260714010955.2226493-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714010955.2226493-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2MSBTYWx0ZWRfX45fg1fLpnNiP
 4/8E5yjp3PVyM6Nv6uGlkb2bFvcORJhXyTcKGznccOQwfvGe1no8YUJAzq99BaKDGJPgFwP2lcL
 nIZtSpnPM60tZPZAfSra3rQwlKr36laI9aVD3RcHkNRGSqNlDGSrCy9HaGMzbdztLOaWcDq8IWO
 2AbT5umWmy4Mi7TEpb3zhV06KiLrSnmDNzs9/jazoJ7uVE8g4lseaZCjxyXYi6yAL7pXDfFhs/a
 TKioK9eA91AdQiPYzUhpfQaQLV9Bxb3/+8pcyyFZSrFXO06u/tHr7eHP0waZVNuqYeY4I+VauMF
 gZ7GERfQNdncraAJFt2jbt9NE3aCLySHEaQRYYqhRLfTTHalhC7v1vn0aCEL7p4D0YLjdBzAvQe
 YyCBwjd0h0a49u7l5r8Xb/qKKi9Sg94pSpxT1g+1M7dXSiJ/TvhI7kT482MZl+vsf6Q4HhCbqF3
 ChyJ0BB8zCqfIMcYtDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2MSBTYWx0ZWRfX/0Nyaci1LNtE
 7KvVikL848wRiV5kNyijH6u51IRexIDPz+IimNH9Bn8lqrPBiyBjPRUvbkzL06P0uZWRncqhpa7
 iSK+iL4n5iYg2pJ7hxnFNJILwnGQPDM=
X-Authority-Analysis: v=2.4 cv=U+Oiy+ru c=1 sm=1 tr=0 ts=6a56562a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=AofmZbRMKsTEkJFFCq8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: a6RTs6aaQxg0BnGBaI9w6TAXWfSrREWg
X-Proofpoint-ORIG-GUID: a6RTs6aaQxg0BnGBaI9w6TAXWfSrREWg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140161
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/13/2026 6:09 PM, Brian Cain wrote:
> Add unaligned_data.c to exercise unaligned memh/memw/memd accesses and
> verify SIGBUS is raised and caught.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/Makefile.target  |   2 +
>  tests/tcg/hexagon/unaligned_data.c | 118 +++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 tests/tcg/hexagon/unaligned_data.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

