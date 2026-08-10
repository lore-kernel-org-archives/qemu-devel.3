Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C4DC5AD5A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtFx1-0007ys-Ou; Sun, 09 Aug 2026 22:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtFwx-0007xO-Ss
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:41:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtFww-0003Zi-31
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:41:15 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679L7plM3779917
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U9HoUyML3IsiL+ApcHnL6Xn1gCnmykqyZZBLi2ByIic=; b=Ugh8iS2DijuSK8Kh
 iH5X0yhN4LKZqWKeXZMyyfLVIRE5FhHVrNGsSK0TfnbovKS+pPtz3t6SvkA3KKJs
 vN9rAmHBOTTksFmYz9aD1sPCPGvd8Tfm35r1WtaCPCzFjRHOXHJt6Lc1AEmfMDqM
 RNroYby75uPHIuoTDXSE4YK+o+Mt01T4m9FF+QGYwtnLVx8jekvi8LmuTl+Y9ZnI
 lcbi8ymi2/SfFnpdqilQ+NmaIfiJUsa1hLmPyeBvmvNTIaiotrPSgh8+Futccy5u
 eJ8fj38o3VDG0i/5X8cyfi6DapYb1t2TsW1huXuRopdKR9LwBBfKq24UhglF0ESk
 4RFumg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwvhvc1ux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:41:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso26007151cf.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 19:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786329672; x=1786934472; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U9HoUyML3IsiL+ApcHnL6Xn1gCnmykqyZZBLi2ByIic=;
 b=EVnNjyFkz/Rvd01ExeCxLvJEiG0j0NYDMU3tkuJ5i2oUduLQTaCSOxYRL6g71KzbgG
 WbQoyvQT2UgfGU/AHDeDb3tD3WhAoLjU34vVLvlS/qlLXuzxBhENt/zqgR4fno0WkVa6
 X/RnjZDZcq4MMynTHvYfPR1hefylp7aHwy5S0MnSu8ltIar3pp61JIMll0crVn6fo5Bw
 kD228fc0THSDxrABE7qLXoXGx/bCvI6UcJtorBEibuiy0bI1oZpJlTre7m9KWOIe/w5+
 /wk9UmQd3QSS7AlsKp9IzYteBfst0AY6StVpRZiqK0lBgfTjMH0ZTljZa9ZANNQJzkWK
 PiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786329672; x=1786934472;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U9HoUyML3IsiL+ApcHnL6Xn1gCnmykqyZZBLi2ByIic=;
 b=Au7US5C3sOOCDR+OqlRtu2g1Wgx+/nZtau5+oe4210bOIZwpJdJsOhxSxYZXO0U8+5
 ToYXKqqK/ORqq8C2RpRYFHOIpT7u7aejfPMe43D0AHtD4dUMqxRRzD6fItD4orB/kFRR
 nsM5IkAw0tfj6+aoJ3lMoCEV+WIZEyPnASv2Lw8ZRV7bK3EC/EAB95wm9NnmWeOFnjjP
 QKImWaZJipx1kN8F/c06o6jKrZIJny8w28iwG0dDTht8PmpgQ3JgeneBqoEFSyLsSLZH
 5xAHlPF0lvYCnzrUhqgH3iY0+/rwR9/l2f9kcQj7ZCMuX2V15QdUDwyJxk61fom+Mwx/
 HqQA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp169MvDx2r8xoyW6xsY3zx+UR26va1G2EvE919nyUUziQ8lratgboPgCLU5DZsY39ImAM/DD2Gw8FW@nongnu.org
X-Gm-Message-State: AOJu0YwDdYO+BZ4MKmAwjlBMCnXxa5sM86MV9HFoaQt/AF3xlGqR/YIB
 I6KocvhpAQ4bPm79rzChdAlO1QGWm+jOUDGXClG8djsbziAAPY45li3VNo9wmrjSBIEqSGSEce6
 OnG40R4z5hQNWkh8EGC9KpSOXWhcFJw5yuL6ZLG46eM57EZ1bCgTxn2RleQ==
X-Gm-Gg: AR+sD12+6DbbnlkSPyzi18ufytnuS6FfgHDqn42LwGShKVlifZyhh1HKeIyDZPfdH3I
 lhUM6uJHPEKMUNS9vwb4IzeLCkJVrZ8aCs7cZAabXv4/mwxWnEQYdUfiN0mL9Z3FYSXxSd1MJqj
 0U4p1C9kGgy1dguDohPVI/v8gNsGbr6rnOGbpHhYr79DsQJXMLkxvbOGpkjNAbSrD40TvFQLo2M
 FI+pC67hHeqSAzz8tBRNIu89suloe3343uwntG4MW2Z7g6qRX9R2yewAanLXzNbB/5aoYjqyr7l
 xjlq0JZlhWeoEhiHIINmSPwpbH9B+oTprmOFVaHUX97xmIwycMz6MmooDk4MV61IC05jx5UbEvu
 KKJPmNSfouEMrDyfbEAazwHYm/BJ3XjkniiA=
X-Received: by 2002:a05:622a:17cc:b0:51b:ef2c:7bf0 with SMTP id
 d75a77b69052e-52d0b2227aemr292514531cf.35.1786329672323; 
 Sun, 09 Aug 2026 19:41:12 -0700 (PDT)
X-Received: by 2002:a05:622a:17cc:b0:51b:ef2c:7bf0 with SMTP id
 d75a77b69052e-52d0b2227aemr292514331cf.35.1786329671943; 
 Sun, 09 Aug 2026 19:41:11 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea27b29sm312986395e9.11.2026.08.09.19.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 19:41:11 -0700 (PDT)
Message-ID: <d2a22df7-07a8-4cd0-a234-a328a1bb3f98@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 04:41:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/s390x: Update capstone disassembly to v6
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20260809013343.664966-1-richard.henderson@linaro.org>
 <20260809013343.664966-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260809013343.664966-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eqbvCIpX c=1 sm=1 tr=0 ts=6a793a48 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: pqG-90poHUI7qCiEtItSjFHf9X7zxNCI
X-Proofpoint-GUID: pqG-90poHUI7qCiEtItSjFHf9X7zxNCI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMSBTYWx0ZWRfX0J3397sAr5UI
 3QsM3NjOkJ05xV60je5bg3vqBxVYWJb92CiH9RPf9Lphz4kS7Q2Luh/ATmWdrYoZmiOAM7xmchp
 Qg0niK73mpX9MUKWBLTWyH1C0DuMZtkbtbQXoG4XFut2T6sJAGzHRVNBxNhaxVLArQq9JgpE8/z
 AoohSYSf+wlPlTH0MyVC7uGVIhAyuHBKbT/OQ0I5WWSimmRNzUNLmIl7srn3VojDAweP2qabbJ3
 83PD3B0fWANwABOlRU+hFqnIe3+eofnUQJQSMJwcZcXB/+3yaXXhXcuToP08jpbr7Ufr4hu9z0e
 Fs40qGTy3b6iEgLnXu4YP0qe34jjPg0Zn2vCfiIHz3lybsMm3Urc3cxBYr4qG3BklW7JcsjaHCC
 bhxrseVNJJGOOt6tEI54AWU/mub40l4P4y61fqX3H7q8s2x+zyJ7J6xWUW0A5ihmnkL6r/lysOc
 9C1MgdAQov4F5g3qETQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMSBTYWx0ZWRfXw2CIewRzQzEU
 AHR0Dr67fcVKgk8kba3xbZ3flK/0YH7GTsGdm9ysrsitl930sPkSfMjgqW4u3cfi4wlBPEoiprF
 EulqeGivLavPyv/Xv05ky1lmlJcVSe4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100021
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

On 9/8/26 03:33, Richard Henderson wrote:
> In particular, this enables many more vector insns.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/disas/capstone.h | 11 +++++++++--
>   disas/capstone.c         |  2 +-
>   target/s390x/cpu.c       |  4 +++-
>   3 files changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

