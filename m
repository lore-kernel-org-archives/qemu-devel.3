Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4731DC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9xH-00070O-GD; Tue, 07 Jul 2026 13:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh9wx-0006PM-JZ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:51:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh9wt-0001WA-Uf
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:51:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTM5K011715
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 17:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z9aPUYJTS4TJs5K7/gx05W93/GuyQXbGt2SAjh/CY20=; b=SkthppefxIXehiBa
 wCQmKFIUI2CcnKZawx/UXPEXpmW9aqBEzVda500MNEiEj/DKr4O+zK2j7aQNUX8U
 rRR270m3H0xLXpBehJFZBtybq/7XBdCLXxoC3OeSx/f3haMPqGY8CIK3ox7nqGmI
 Ydh0gKaMH5W43Ky/81vjBDgKtmKGNa4hA2BS80eik34pv8+fraq1bCatsUQLKj0v
 wmObdppgCJyFRmZb+t9P7lctb1mT1Dt3tD9UA0qFj8yVwXcqahSAvW/joFLELIHG
 4FNnNdh3eJyUiyTfeV76plDO956pmG8hkOR150Z0vgSNi6p/CHQzbyQ6IAS5ZLD+
 rQPlCg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdjasjk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 17:51:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c8018f11fbso59203395ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783446668; x=1784051468; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z9aPUYJTS4TJs5K7/gx05W93/GuyQXbGt2SAjh/CY20=;
 b=O+0dJyfpLSAVUtAn36mdXhc6+Xg5k6XVgh6/GizaBOmsHJFh8p7ouSzhqp42Uteye4
 KP1/9Zrx/2JITbdbnmUe5olo9KyurDlQI581A3sQ4to2ddQ/z7hzMsQ3YmUhsfmO1kOE
 NTME48txspLKY0a2Eih9TGiw/OxuDRvcd3hXHDJS16uiF0vA7ZG6YfCC+8Pm5fQeiEAk
 nVcXlkhsw8Uv2Bn3Nrqm0lOXxlj02UtO5tmJ/KY7fuW1o6fGrO6gdW23lifr7wjR/0iB
 r2h9/D+m1PHRinl8YtZLfhqg0W3duIVm8+GTLBl51HYfR22Eih4VrrkiHRUkuizp2TYp
 knEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783446668; x=1784051468;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z9aPUYJTS4TJs5K7/gx05W93/GuyQXbGt2SAjh/CY20=;
 b=eS3Sxw58jgAeKu355qgIX1Eg433WxDDtmddihBEHZ8gvqxIzUUlznFXez9aMK2MpT4
 pmQHug6FZw75kDzrksecRxVi/2tx6SMWCAbfupgD8wyuH7ohaWJqksvR+wpxZEXDhy/t
 CUHiWD3ILQhyZyE3PcC6nqa4j2c5sgok8zAv8bKpnay7j73zsOCbCORUvKuubOuJcYaI
 1PHe4wF+Evk5D5Yayl0BmB3znimMVif4ySegw+auEDysL/X/sSSn4t7maQn4t6BCMDXL
 R3Kp14Z2L6W+MNrcnB6J672RypeYnvpNggJxR974z7UKr3nL7fiAN8ORpo+FVNqaa21t
 T0YA==
X-Gm-Message-State: AOJu0YwbmshO98Rm/zzo+96gHAWLBWncoqeTF5bOigSsDWZzLW359MPB
 8UKMOzv2yjSKOvlA9KWjdnvzE+UmamblpLICZ0nW5Oslg8/7ZlDhAmR5/rb+wyruxfH4IMOTk9b
 2sjnQ9McKTuNAQrChAhAlyqXEE6s0Zhipn7Yj0tOZeJWsmeoHJsXdn+olwKtQptGjNA==
X-Gm-Gg: AfdE7cm7J5Jz6o0Dj5K/NbQNGc4n9+qf8/6FE16jWQFXxd8qxbLskEc6cUlHyWPXsA2
 ver2yNyAxfMCz/dfXyU+GJVu5FLsmJrAJ5O2JJr+KKv36AFCOxHpIKmMnnLTCMVB7rGcfTL1hb2
 TTWptFWPQNX3iHDcPdmNHBW3fchxGJrfnqfGr900pmYZaBDlgIJfwQMRxmnjW1vh4E6E5+BZxwo
 pBYVchFPIBPuzhmjhwHFs5mG3Fw2ThrZ7g4b+k9nCMIzdZH9ARF9wdw69yO72WSG3QQdATME7LL
 VrmTJFvO+Zu4/c/2VbUAiE5M73+GEKL0izNwFCiK+YB51PXxvGpvM+Ri0HBlh0b0mZyzVAUMtYq
 FUcQVoXP0wIXjZ2r67M6YphyAlnS4bBKVthTvJeOB2LG3KXHwyXcA8W1fJ0246tVPOYuHQeRA2E
 VG3a4=
X-Received: by 2002:a17:90b:2d47:b0:381:9b7b:35e5 with SMTP id
 98e67ed59e1d1-38754ea7773mr6100694a91.4.1783446668017; 
 Tue, 07 Jul 2026 10:51:08 -0700 (PDT)
X-Received: by 2002:a17:90b:2d47:b0:381:9b7b:35e5 with SMTP id
 98e67ed59e1d1-38754ea7773mr6100668a91.4.1783446667534; 
 Tue, 07 Jul 2026 10:51:07 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accb0esm11769174eec.30.2026.07.07.10.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 10:51:07 -0700 (PDT)
Message-ID: <81e1e861-566e-4a58-8a72-405f5a79f90b@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 10:51:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tests/tcg/multiarch: Improve mutator randomness
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260706165445.57418-1-iii@linux.ibm.com>
 <20260706165445.57418-3-iii@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260706165445.57418-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4d3c8c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=WjqLZ8Ns_Oi47TyG86QA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: S5ClXkbV5B0IeeBDDa55i76p0S9KF474
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3NSBTYWx0ZWRfX0V0Y/jvz0Ah+
 Ecl1kfqc2L/3usrKaGlzT+bBvmbpHKLOyBkoXcdSjt9Iidr2ZhLUqG2Dlp/BS/aLd4Bw5L6maE4
 GHzY8BEGGhRCdrE7mFM1W3w8rqEv2w8giE1nh0hOFoTm2vLEniyOc/Nat9zJEu1tz9xKWldtPUZ
 4siXK8P6broY+pwG8gMWqfgcg7Zhhgr0rl1pznHRD4jFEdBSzS7+dBOTy3qwtnp4OMTGoDRpw4v
 d4yTsFS1koidj09yNOKg1n/6ywCl8p8+KFMUY3gNlI631FcP9meca9e7g9n1AuUk9S7wOB81lRB
 CsoZJHSEU2YdqyktWJXdDfFmAAvoVpASJWywLL0ZFAhWW1McqQvIN8+oYm39Yb7a19oxRfehcMv
 p5JJxTWuKpB+PLTEi1Tx04oAgmjwJb2VCiJaDxpvuzKUlUjBzrtKJyKp0BbtnORDYm3aOCi0I+a
 kaEtFwcf7hS5JJAQMdA==
X-Proofpoint-ORIG-GUID: S5ClXkbV5B0IeeBDDa55i76p0S9KF474
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3NSBTYWx0ZWRfX8u8kAP2vWptd
 HkF+/jlKDLlYCav9CGqZufRrAA68EOU79PBLq3OioD3HopusaM8HGTBqJ0jMoQEJdRE8TtU1s6g
 ca260RqJQYBA6CZDGJsK6JDd3NmoLYc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070175
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

On 7/6/2026 9:51 AM, Ilya Leoshkevich wrote:
> Currently mutators perform the same actions, because the RNG seed is
> derived from the current time in seconds. Mix in thread ID.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tests/tcg/multiarch/vma-pthread.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

