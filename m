Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07B8C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKCi-0003uY-Lx; Fri, 10 Jul 2026 19:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiKCh-0003u4-0f
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:00:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiKCf-0002yL-H7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:00:18 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3iil1648591
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 23:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hs2KvNk+AVu23qtK4vmbCMRrf3HCFLV+y09b0F0eoh4=; b=QtaKEbBDuN7fCUcU
 usykEM+ALqhRbINHPH80mnOU/pNEsJuv5g4sBG4lr/UyFlnLkwte656Jju3ws3nT
 NB6emFRlnsKX8Ex2DmbV3GbxW6se911IciStmOTCQkStm/HFImK4mv7MgAyU+S1r
 L9rDMrNMgciWQG9FlgOwaTgmi4QeQaG+hjdDAKU1f6JXR/U+rkf5xu5ELXnb/YzM
 DMzoTT4P4nVlfXaiJWH0nX5/K3cY7TMKm7x5zB+ifxmfruwVDGTbFCqFABCIw3Sd
 cABK0tMV6a4GdVBxrLRybvKopQDAyblJJcnuV45GSh+HkOCD7UGmmHTXO5Y+PD/u
 YTEEVg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txhjun-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 23:00:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c26012cd0so15995191cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783724411; x=1784329211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hs2KvNk+AVu23qtK4vmbCMRrf3HCFLV+y09b0F0eoh4=;
 b=cZAlrKezk9QNHKdfGyfJ4kMhTgtCG5fPL4ah3Ihj/RbIaSwSrQedV273Cs7xHp3fhJ
 ieR+G1wEUPuupkbJjx3kbiTbOvCK2kEQPwPi1eSXSuKEJB7c6CuPtuwVwc8yDEa9opiX
 um+nUGVhLFodgCIbFf4i77ewTc3ca27BGRJ2vEJMqoGll/PWbtFFzP5NtzV9iPhs2G6r
 ORVwF2euF0eB7OJjtkYcurUiCfLx+07LCq0mNQfjYpure6yksMZmr3msg422cU2wp+Us
 i/5qXuHHfV7f860NTTWNd/yyxlQPLwloOX+l2JBmeRq2gjcPCg/EhZNgcRs7V4dhIvjh
 1a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724411; x=1784329211;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hs2KvNk+AVu23qtK4vmbCMRrf3HCFLV+y09b0F0eoh4=;
 b=b9vrQjS0yxqTh0M0zICmEz432PPj8KtZRLsE5nsUocfJk1WFC9oOAJ9JrffbMEFOS3
 tX5fBb21BnsUq/lgDdKC3WoudWiYaJEN+5y1Ef0/eSltW7d3yy4+fCvNd1iJ/QVGdbCH
 tuvS7LZ5t3ArdyDq06lv9KGjvSMa7OfHPgiiDztsCblfs5ReW7DdbDbH9CaoQg84Pqko
 +ZJwoea19EsyhRft+LNrvr65TN9juYFPfP4GAjpY38/TL1wJsL2+Vxv1XHQcMiAZ+Pte
 uwd369JGs0rls+iC6w3vf59L8lZ1WtovPGrh6zzC/9Wqoh30BCR07kZ+3/jUYrlqfC9s
 E+Uw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2NBgfR0UaxVu8I6BcjjAEDY7Hh3OWVWX7+wTaMbxQLeGUVRXeUHRQaJkyyKFbb6jj1Im2RtLHzKf9@nongnu.org
X-Gm-Message-State: AOJu0Yx0G9ZaKaadFaOBqLvHiXNyp6JZLiNAUZJeap0AjgjpgbYuoRTS
 HkPkFIiRVI7FFbXNyMnMEARSi91NYG/7VCOFdIr60qSS8UIHjt0boUeRZ+/fXoCBeuL7NGyGwty
 gtL8WMnRJT00CsQ/3rT6H8uEEo0sE2i8UWZwAnC3OwoTQtU9D3unY1xJHcLysYQbf/w==
X-Gm-Gg: AfdE7cmSXoxDvx5N5CJZpl3YJOppEkxHC5x/rL0mCROpIm4oxplK39pGOTmo3Emx0Ys
 4ANUj2Kig1QRrkDxGowr2YKu/k/cQnyjrnV1WkzYd6rzZLN2T6LQta9l2dQb+FKnOfAIr/sEct7
 u6vqqHFI+BedDBs/Xf7xyRLFEVFwVKM16gBv+g3LpyMeb4qL85mPibY9aauGkbDomqIGnZw2aNJ
 ALAk3e7bhRiHOULE9sTSej0PzrsUYbaFMQ90USa/nS6M7n9r/uNLrBhnIPZC0b7uatwdlE15aTa
 tHvnzEBLZ4CpX2P3q1aWYOk+s/XFAropWrFZ3ytIu/Nsemgl2geNRVrQDqMsh6PQ29z3FpJUkOs
 9A5o1k4K0AENt3yi/AN8nuLFN6ncwv7Ew5XrGzcW5nbnJmuIwKkSir4ehhkLJZg==
X-Received: by 2002:ac8:5f8d:0:b0:516:e062:1a83 with SMTP id
 d75a77b69052e-51cbf212d67mr9922971cf.51.1783724411213; 
 Fri, 10 Jul 2026 16:00:11 -0700 (PDT)
X-Received: by 2002:ac8:5f8d:0:b0:516:e062:1a83 with SMTP id
 d75a77b69052e-51cbf212d67mr9922441cf.51.1783724410768; 
 Fri, 10 Jul 2026 16:00:10 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm103005665e9.2.2026.07.10.16.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 16:00:09 -0700 (PDT)
Message-ID: <35853abe-8df6-48d4-84cb-4248850c8a30@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 01:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 31/98] tests/tcg/meson.build: add top-level 'tcg-tests'
 target
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-32-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-32-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a51797c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=VxAk22fqlfwA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Z6ucRhhP9bsNP9drML3rQu7c7jSLo6rd
X-Proofpoint-GUID: Z6ucRhhP9bsNP9drML3rQu7c7jSLo6rd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIzMSBTYWx0ZWRfX2VrJUAP1w2v9
 uPAY4QtWnKPVJ4huwJh96fffe4OqN8D9fX4B7a1MBUxsHqLWPliZ/ivO5xHx7W+eipGHiBzQc1Z
 9wG8I9dfn+pOTb8K1SifIYA8MrH9nUWCXSO+Kec541KKVSuvkXV45g4cwyMwKHFZGBC1R0S+j9y
 yB48jsXVWyC9XaGTweL0GNufiuAd6YWOvb2xQR9UX4jkSyb7n3jRKUUqBUejmDEy92d2k2/dlGn
 ELdxLf8CzYWvO106Pz/jn2htt8SE+iYlLnjaZa1GyzRsFRAmSAQjLHlS33FpT+9NCuFwei1F0iv
 782MRYqDSr6k671GyvfR9T7eGCXrNGCQqE/Wpae1D7/GG0FMxYeXB8ZNYwXfuwjVvehDpzdwGZT
 sQlcgYGv0ZG7ZyOv/e7TtD8CO9djgJtkWGXl64R6zoqPXKcfrvJuhiko9gmplVenYsWgbzqmHBh
 t0HrmU5MwGM80wR5c3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIzMSBTYWx0ZWRfXxFUm9CdyVr9J
 U8B/AMcJurtx2JtfkzuYrhOSXPG3mgNNlVFrtQvn4GxlPsEJfjQB6IFLHUd+T3u3K5kkqEO/HQx
 r4lvlQNEMwXC/BGGE439owgnBLDsMHo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100231
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

On 10/7/26 23:42, Pierrick Bouvier wrote:
> Add a target to rebuild all tcg-tests at once.
> 
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

