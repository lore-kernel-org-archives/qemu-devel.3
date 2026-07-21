Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F0BC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5ub-0005zN-0T; Tue, 21 Jul 2026 04:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm5uZ-0005z9-C8
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:33:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm5uX-0003sF-NL
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:33:11 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L4T1j7527891
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i4rQJ1ZAUR6iYcNKpRsdX1B/dvJZU6OE3Iy2xgLp+3U=; b=KUS2q1oL640jd9Zx
 y0syLlr2zM5hVDt/pUwBj6nbdhsB8fdfLPsXBwCc7R3y431gMBrvlWfGCB6uK7G9
 GB5UZYQo+2pHmqfqJ9NIQyp5WQqxPRfSy/HCilfD1mttc5DB0dtAHV1zLHMjW9EP
 T0b5OkS9bsTvwgGa+FR/axt0ABCBBAJJFGdDb8uwWzvDdGcka+qfmK3BFEDoEzbw
 dcnzr6MkOut7XgMQGTq18WvkN3navTsLPzzddd+/MgVmHyTtBNOsL+tFziMd7iSn
 XjkP0keDbOFedzrHAaQyikPxgBU3WEgB3yHRubtUvspGcbo4sCHQIuqHUrDz2Zo+
 rhDurw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se0yh6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:33:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0ab07320so157951111cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784622787; x=1785227587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i4rQJ1ZAUR6iYcNKpRsdX1B/dvJZU6OE3Iy2xgLp+3U=;
 b=Qc/me/rungGOq/BDB/GdGdi9XCdfYPTF+jpVymOoLdllwdAo1zdAl0OVVxVbgDY+q8
 G97HAXaAvJfa75E//uifx6Z7blM+MpdV/OUkQlFVqdQ1hL+9Rv9MU8LA/SWjumlD9+Hm
 6bqB0kRevyS6bIAxM6KEvoFnmoNVqFJSZWtBaCmqStU9SLwLOBftL3GG4Zmk4HSW+IX+
 +AaUI4LX1y7JmJSL9lhwP3ZZdh+j2i1RE93BYxw0nIFD6wa/oZj89WY1c/ffyctrnSpS
 w0xH6XR3DjfwjgzMi6dw9z9LYMT3eDBf5P9BSQNrn7VLosZe18kcBU9fMOxYSz2XYMZW
 GMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784622787; x=1785227587;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i4rQJ1ZAUR6iYcNKpRsdX1B/dvJZU6OE3Iy2xgLp+3U=;
 b=hRa9wjwsmAxiUoaBPhPzGzXXJuG7kRUguf3xuQkhHPFkZbmtoGs28+nns9e8aWRLCL
 EADwacmd11hzZKTeUmOKKDWhY/PMAkbXT2puFXQiWXHA3aqVcYyguksuPRtx196r3Chk
 kfSsjbxLBptlgZoYk/DU7OTr9DNNcPCwURp0wcAofoilV9Oi/SMu5rvuzitfkJPxYL4W
 bPB5x6Ql3nB2dKkgikcYMRvXv/Y+xXnxeJ+CmM/ISx3i1tMZoqt8HBVtCUuAgnxeaNXE
 mUvVTitERZyP+2SrdSON/z+dfcHfxxRgiVP8YiWKzlaHAxjLErbGZgif174TuzHafbtq
 JfXA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7jiDePp+nGxMt7ILxbUUnA74l83du9To1Wj8WE/oPCsPldDM/x31jQCE8Oy0vtFxsjYoVmHNoGZZA@nongnu.org
X-Gm-Message-State: AOJu0YzdOHJe4uR2dNr3SQtyNnjCYEI/13ZPGiIrnNaXYbp/HmdaMtIJ
 B/pMzZhlE1KNwTBw+1t34f7xpd8WzINUmGaVRYr7Z3gf6iPc0nfm+VVdRViDHz2BWowhaOPBm0k
 7znMPJu8fq4B8ZqmfT4beycI9VmYgcw8faO1n9BmJ25pPgYcOLI9wTQhsOg==
X-Gm-Gg: AfdE7ckVvXVulyFpYySn3z/y7WiN9QMcghyEt25aCw1B48LP2865w0rNKwnveOJXjEX
 b+P6CubpKL1CMwwqvf/x7spUpfW+an53SykaLOmE2+vT6sVBHAzmQV+udFtk8mgn4I1zZaIP7Up
 +LvAoFBJcXOcvOIyyz8V6rcVFPzhnqwa72nDwmPgmcP2SXBthmoXN0Z7JlsaxafTh4yTab0StxF
 kSaWS6PYIFjF8W7bziWxEVWEEeEgCJG/0nEQIAVjjnzuZdw5s8XgbrdN9uROrDNbvCVAX4j8Vx9
 HXenAdbBWnh+FusMTNHTrowjqX10W2dQ7/RkABFhTIqbkJohqOjPt87Uk7NTAmTMNEzyNTsViYA
 jcbTApo/w7onEDfRGSz7hMU6xUlcjS+F/XIBrqILTdhD8hEAYMh8=
X-Received: by 2002:a05:622a:4d43:b0:51c:478:3299 with SMTP id
 d75a77b69052e-5213aa6cc4amr162576151cf.9.1784622787343; 
 Tue, 21 Jul 2026 01:33:07 -0700 (PDT)
X-Received: by 2002:a05:622a:4d43:b0:51c:478:3299 with SMTP id
 d75a77b69052e-5213aa6cc4amr162575991cf.9.1784622786809; 
 Tue, 21 Jul 2026 01:33:06 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653d38dbsm47634745e9.15.2026.07.21.01.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 01:33:06 -0700 (PDT)
Message-ID: <8b5a14c7-dfbf-4a9f-a568-86b3f22c1b82@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 10:33:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/listener: Remove unnecessary linux/kvm.h include
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260721062745.3793066-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721062745.3793066-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: f69-7-akDdWS97_cT-ytfsZNtUYYG8G3
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5f2ec4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=r1p2_3pzAAAA:8 a=20KFwNOVAAAA:8 a=9qUTvQc-AAAA:8
 a=wm09KQs9GwRHF5DUd-cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=r_pkcD-q9-ctt7trBg_g:22 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4OSBTYWx0ZWRfX9n5b3z1WeHus
 /xqZr6HDrumYs0Jv33tqy/Rz8HEUuer7hY8c+86RHan2t7+74JAW64sPd+qb9dX+X/W4+HIVkfq
 ivP2IklTyaoUW09D3maIpC8XKN0LQ60=
X-Proofpoint-GUID: f69-7-akDdWS97_cT-ytfsZNtUYYG8G3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4OSBTYWx0ZWRfX+/uMwunoBMPc
 4LGauU3wFppKxpNMKEbcIiVOkwox5TlKjEIsr6qpjNK6OBxA1dyK7mnaFcf+Hrxf1cborNqHMli
 oBnIf6131W6EYcnGuPN63xNcJNO8zOvINUH/w7PAVgBV0Tk/IzcigSGEllL16gUcFgTkzM2D3q+
 BEXb8sy7zqay+fRbo9S2ITAQOzY8B/W/JBWj4QhmYUW/bBrja3/y1G2yJ3qn9s92c5xLz9dtLDm
 No585e3xs25JEQMCfZNjM+Hyrz2c8Okyd3gT0l0wFRyvNzIPLtBzhqBtUHf1LkB1csyHfZMRq+X
 AjDLtDHYVpsqi9SXQnS4SXaxTqbdG2Oq8gWCPM4fIEDM27mMiyIYAJFo9SQ8RjTQBNP69I5MFIE
 deFHVjPKitCJMQ5K2gr1Ex4Fhs2lRvetzH82pClqs/+gOuGq4HRmgR77zg06pYKegY9y71I37Fy
 yekdX51Q2A/ApIcBauQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210089
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

On 21/7/26 08:27, CÃ©dric Le Goater wrote:
> Since commit d0e8bccafc23 ("hw/vfio/listener.c: remove CONFIG_KVM"),
> the linux/kvm.h include is unconditional. This breaks the build on
> targets that lack asm/kvm.h such as sparc and sparc64:
> 
>    In file included from ../hw/vfio/listener.c:23:
>    linux-headers/linux/kvm.h:16:10: fatal error: asm/kvm.h: No such file or directory
> 
> This include is not needed in listener.c which only uses kvm_enabled()
> and kvm_get_max_memslots(), both are declared in "system/kvm.h".
> Remove it.
> 
> Fixes: d0e8bccafc23 ("hw/vfio/listener.c: remove CONFIG_KVM")
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>"
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/listener.c | 1 -
>   1 file changed, 1 deletion(-)

Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


