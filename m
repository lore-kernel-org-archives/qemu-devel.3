Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B7BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgpm1-0006VK-Np; Mon, 06 Jul 2026 16:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgplz-0006Uv-I3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:18:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgplx-0003UD-Sc
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:18:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE3QJ1665118
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 20:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bIkdpltWKv95pYGs7me4olszH385S7tcWyO3XlTrw7c=; b=POxfhGtpCTopdJch
 iq4tzNQo7RjJY2rVZngUYczdE+ehjrsDd2CtFXqRwHL+bZF4hPcg5uPj2P56t2t6
 Xa/lSrrllbND8GwEm/zLnPTHvOupC/Hd8aiXexiEiEr9/6geN7SiDoqMRaiEcOeK
 r8JyqD0llsqNgaf+aCR2AhpbYM1ucFPTieiFPtRvAe8FJ38eFyP2BLZLQ0hmEaKG
 lHbdu7tzvt9hMVcpqSjSXOworYb4u2XXPi9+KuHodZZNA8dDptS6tIoZhtS+WrU5
 iFVBaf2v8gb+hdr4PfJuM1vNIyIr5XoNEDkbvEd2VRptPxGG0fXUSniPASbHhNmG
 nzrbbg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gtrxr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 20:18:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91ed0e140c5so625551285a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783369110; x=1783973910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bIkdpltWKv95pYGs7me4olszH385S7tcWyO3XlTrw7c=;
 b=HUA1Fyfo5gVp0YRqfjHS6jNLvqxMUWRE21GTG4IhkJ8lu2539C9kbb69cTOVYw2Dbo
 KlSYzJI+BeGaXGkHaqBX3CWmvUpr7hj4tWAAE4bF1Wa/RPGBhRRHjM28ZH4J/MNB8L9j
 IfuuR6C+Ikntg0m08dF25oFisynFf99D4YQEknfztstaONLbHyYFXDdpjycXBJ/0AMwz
 P/ry6kJ3r8hGE//XkCgInuv+7e1+myf04m+JOyWboxEtbzsQCumXYvoqon6FNLt6vHfR
 8ZJvV8aav10x0Fzu1T88N3AwEBtpWEoxLrtQbrDD/ifp+VZx+bcRvfZTHt7mcl+cC6LH
 NSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783369110; x=1783973910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bIkdpltWKv95pYGs7me4olszH385S7tcWyO3XlTrw7c=;
 b=heKMAtSxq3aGmzc0wl3xqbjZxfOL7oAbHgpMlm2KTZNtzEZlrOtNGnFtMAvZvc6FS/
 1xVRAtn/HfZdd6uVsY49B87ZbdOZA5XRHAp+zTbfN4tJMAsxos5rMB+0j7BP+1PpPOwc
 ZUWJMMdgS+lzvBnzmb+7okt+LzKPu99dYfFbXa4975YedVLts0TG7XxsFdZEVxwb2nyq
 VAb7qHMo3yJmriU56gDpCWatxKvMRboDZW7dQ4YWl3nc5450p1EVSfjTtXW3M8Mp6utm
 F48ZLYEm3JphWLXtO1PlCM8nyA8gfLQ7v2KoJyi6quHrwmfIwSBkBDPV0vgMR+QQ1S4X
 f69g==
X-Forwarded-Encrypted: i=1;
 AHgh+Roqani+k0KLEyQ6MuVVmI+LpMgmyCNnP6tVVoX0yrwmEbgdeiupPAGeUxzw86lwzUhECZjLq8iiWdZB@nongnu.org
X-Gm-Message-State: AOJu0YyAJ9pi/VQugIZeF3gRbiN1+zAefKI94cqa1bk0uc7AiSE6ESHv
 jcX1LjcRHKTC/SHflXwfhYomMWOXXfBoxQpbUFvL9F8ekTikUs2D4bBwfPHA7iL6liHV/Ts8R+m
 XlENXxlEzphtDd2ytO0R98YzUSfih6b4lBpLSN3NIBAlAliU638vT7NymvA==
X-Gm-Gg: AfdE7ckkcGzHlk02HCLtvwo/fajuBbkwheIk8GSuIbb4ELXdkI2A5aY5RleU1pMzlEJ
 OP+pWou5Ftaf6YSJ6X/fqjkFEEyRYwv/Pjb7lM6NCFQr3nftQtwp7+rGuBdPC0SS3U0rG0MXtH5
 lGUHiMTPIzXdiIxgiifc8SvsgxGcXkYtUTD9PgDxb3nRXVE4PR7L8wLlC8EbjJeRSv4hz0kF9Za
 QZ/Sx7pgkOD2TJvYugUTP67n9d6N3jzsw6DSJv07HDZkuWsLCl8FevKPkYgUkLqIXUi6GjWO94P
 Xwgg4dm0E/rD/C5PczBKMHoadlfysytcTUKzspbTjX3Y/6tbNSvkH3beFKXflVZtR5DjWS9KRpT
 WMVtGSFemn1nSldYf28OdUBDEO7Hax6Rg7SbVfAja83NUF9fhibSSBF+Xm2YOew==
X-Received: by 2002:a05:620a:618b:b0:92e:6b16:6a02 with SMTP id
 af79cd13be357-92ebb55df00mr280610885a.35.1783369110551; 
 Mon, 06 Jul 2026 13:18:30 -0700 (PDT)
X-Received: by 2002:a05:620a:618b:b0:92e:6b16:6a02 with SMTP id
 af79cd13be357-92ebb55df00mr280606985a.35.1783369110141; 
 Mon, 06 Jul 2026 13:18:30 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8cdsm29764267f8f.1.2026.07.06.13.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 13:18:29 -0700 (PDT)
Message-ID: <904c66f4-9291-4eaa-bb87-45e7442bab4f@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 22:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] target/loongarch: make VReg aligned to 16 bytes
Content-Language: en-US
To: shankerwangmiao@gmail.com, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>, b4-sent@kernel.org
References: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
 <20260707-loong64-be-v2-1-8634f93c1dc9@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707-loong64-be-v2-1-8634f93c1dc9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wlNB842ll3Toy8gWHakKKYI153g-Urwo
X-Proofpoint-ORIG-GUID: wlNB842ll3Toy8gWHakKKYI153g-Urwo
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c0d97 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIwNCBTYWx0ZWRfXwS7LJ99UYXuC
 72SrQXvWiuhvOy0uwKT3ApaaQFol+evi8ucLUQIeHe9Sa1UUYrhjoO8ufgE7BJsneH1VtBjrhdg
 ePk1anzyoXrAGlRGJNHCjplwrEB3G+mXzCWkPKfH/hKiGT/e/6p9kYcXhbURLLF0kNgseVvMXSj
 1/oBIntSvXZJHA5XEcqXseVY17Vquyj+c/lM8ifx+x8cTDC9hYYIm8PsNx4P2dVIvBbcVUzkY6c
 7RIfJbha837kWZN0tfwYyjK62hs7mWRyWl5PACkP0/lT6iailNiY0mIumMOX/G9yp1wx23SkONO
 wXiZWkdgYHohI1cVhIeuLzDqNReYLEKnXV7AjA8tOjSJgNgmFbOGp2wGnIS/NbWSTE90pQBcOMN
 gG7Vb8npBuwkxoNuRB4th7SVrDGyaZLhxeasAhEk4slcq6ayX83dIgDzdmjoMt6IKVYqJLNiQko
 ZhWKSiqc/JRSDbm6QOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIwNCBTYWx0ZWRfX1bNTY4VzjrvG
 ddD8LRN/83nhfyAUlDtuP1D0PcC/B8wZAFcSPHa2YZd52+4gcoUnFGfYaN2iqrf2FtO5qAXs6UO
 YUd9gBfRHVXgKwWf96HurdUQvmXR1pU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060204
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

On 6/7/26 22:02, Miao Wang via B4 Relay wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> When tcg_gen_gvec_* functions are used to operate on 128-bit
> vector registers, the registers are required to be aligned
> to 16 bytes. On some platforms, such as s390x, __int128 is
> not aligned to 16 bytes, which will break the requirement
> and make tcg_gen_gvec_* functions operate on only 64 bits.
> Explicitly use aligned 128-bit integer to fix this.
> 
> Fixes: 2d5f950c054b ("target/loongarch: Implement vaddw/vsubw")
> Fixes: 16f5396cec23 ("target/loongarch: Add LSX data type VReg")
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
>   target/loongarch/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

