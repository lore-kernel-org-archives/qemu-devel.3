Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B4AC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjf7Z-0007XJ-Ff; Tue, 14 Jul 2026 11:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjf7Y-0007XB-0Z
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:32:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjf7W-0006PB-Er
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:32:31 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EEcJaM938491
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iEL2tIQ8q2pOWCdrCz36qJ5P3+7fIDCn/Y+S+Axo2G4=; b=j1URdUhP282yfADK
 1d4lxpiN9CI4j7iN7ebT0avbpBzI0ZgLQD6PbEVG2x0kZg04Eng22RepQ89POsw+
 K6KOVKK5x3VKsiOix+N1OoGjTRNnPuK+Q8rdlA5HMno+21YRFvazlVe0DVl/CqN2
 e45UqMqYx6UTXiRJMxsOLKOLOHR1UUyEm6GQNld92W5c6aKtWRzRmh1U33bsHJAk
 T+f93VeUc7rJsYPfnWusBmvgUa+E6N8JzNJXhDBhmCTbq7jwtvcBzzf/CEqPttns
 59IDCAbWj+wDqvzknTTiKLJK0j3jli17piw7wj2kdlHd3WZurBInKPIb0VHClv26
 HtB0UQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnurmqh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 15:32:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8952346bb9so3771750a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784043146; x=1784647946; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iEL2tIQ8q2pOWCdrCz36qJ5P3+7fIDCn/Y+S+Axo2G4=;
 b=ZQDuwSv7uAlhAW+qIr5qPVmlhTz1tsUQdKWi9uJLBk7i20+heDLafyFUmAOXyuHu5x
 NRdJRZ4LL+LYmgpJ1o3DrPKmr72p/MS6U9650foiXB5jvvdG1YK+dne6xeT7J0rw5a+t
 Gn4mLNEw9aT3yCR3P8og9oyOjFdns8EuhgVWUc6swZJDWat39wu3bc0BnNJHobN12GGj
 JCQQybpFAITLwLtTBmx/1viGbXiIxtp/tFGi+eGJ9Ag3djg6GjUUUHnejQsdWHP1mw+4
 PxaaeFxXvELDUFxAyH1NK0K+pDS7sjpyHNcY8w+dyrzKWjxGsxDWDEjRF99I3hkP5n4p
 IfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784043146; x=1784647946;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iEL2tIQ8q2pOWCdrCz36qJ5P3+7fIDCn/Y+S+Axo2G4=;
 b=C8M4yIZgPRh3vXr3afnV/Zx4gGzERFSiF/6NC5BBTR+Diw1W/5pcL48Ymv7DIzbY0x
 xny39Te6Lgm4+qMLAUlTPGZBBw2jvMgXwmivCcorjhbvk6Ey+1s+YdOU3Ngui3KoDT2X
 qBjaX38Yod+SiKAgfiSV7+vjMBTH1NBsJafSjobb/fgT5RbB3PTf1DZffyGWw2JxnSs+
 4Acn6pIyMAqZAlKcBCfjrH4KUmdHjs77IBpFco0Gfsftrm3r6rl0i2BJ+YG+Av4BPsoe
 7tw3K2H3iL93L8QSObfEXHh3jA/XUdlg4LmZLvm+xnJmAHLjnkElNeUWrbevUZ2ZAwmI
 zoLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RopuPCLa3QlIwZWueyy4Q7gH6lwLy1ubsYOU96XutvkNS/+nYvfxonLlYPemEuAmgrd7fEZsnqU9mIZ@nongnu.org
X-Gm-Message-State: AOJu0YzfwqAYtSmfAqb+d+f5SJapgdkV6vVFZY8MO+U4fIXX6hBz2atS
 gYWsOAEv6R2LJykL9Tk4g+nZVXq3tsHibHRPhYuKySHR+jlnwVFhiPrsJSZMOsjsVhji/6z9E5t
 VEkBwDozxq3K0mEjrhRm3MgUHYPq0FemD9AnWXSa3mtPM3wqmobm2VEM33w==
X-Gm-Gg: AfdE7cmCvVtA/l9Uo3leoyo7z2SIg682Lpw/9QmWX2tS0f9XvHotKKQPr2jj6OsbZ9X
 wCUAPOrQz5fEtp5a2YHQOMMGbaaRQx/4ADy9KrFZ+5vUJ4LDMG5i6Ru3wIbzlESHpHRgDkTiUEr
 Sg0UIr9qv+AB3yvhINV263/92tVBf3GNJKWII0ZNyhnilKSbiOySXGQzzr4SD7ZRzTBaiFv1pFf
 69dALkxdJK71AMhPfTP7CUW9DhRJx/FsgkPcmR6PzEUayJmbENEc7L02apcaYc4fpFqigAD6w+z
 WzA1FW7jcf7ft3BVP8zSB+3YbrE/4kkDeiEixawTkTVNDvaFwUg9JtBTYlxVcNSovbiVssIUpl4
 8U262evaBMn/oT4855rwNiJ4hjDt7OpZi3g6A5HBURJgL8t7dxW/rI9+y4qZCfrlIsKEoshcqOz
 ACzH0=
X-Received: by 2002:a17:90b:38ce:b0:38e:581:3fcb with SMTP id
 98e67ed59e1d1-38e058140bfmr6251155a91.34.1784043145987; 
 Tue, 14 Jul 2026 08:32:25 -0700 (PDT)
X-Received: by 2002:a17:90b:38ce:b0:38e:581:3fcb with SMTP id
 98e67ed59e1d1-38e058140bfmr6251125a91.34.1784043145327; 
 Tue, 14 Jul 2026 08:32:25 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313f3ea883asm9270690eec.29.2026.07.14.08.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 08:32:24 -0700 (PDT)
Message-ID: <1c38e92f-4fc9-4591-9e22-79a213b638c2@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 08:32:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] docs/about/emulation: document the dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260711094523.622997-1-functioner@sjtu.edu.cn>
 <20260711094523.622997-3-functioner@sjtu.edu.cn>
 <2bd62d89-bc53-477b-8c5e-5eec69b344f8@oss.qualcomm.com>
 <fc17e8c9-9090-438b-b8bc-4eedc7117c5f@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fc17e8c9-9090-438b-b8bc-4eedc7117c5f@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0pm5rxwJ5OX_fhTuYtPaGFZZpIuBZc2v
X-Authority-Analysis: v=2.4 cv=E+v9Y6dl c=1 sm=1 tr=0 ts=6a56568a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8 a=AwrWFLnOOOPQQoq__IsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2MSBTYWx0ZWRfX81amuGMeQn0R
 2xsUZIkyisbKOe0kK4jchRujd4aaK/WcUz3wJwb01RRCJbnMM5BaU3UbVxpusuk+zqX3S5PdMVs
 8JT9GDA4dRCzATJs8W6vN+zsgHFjO01g6XReN4eVlmINmBRpbuBXRsCCitSWPd4v4QAraSCZ3/f
 p+abeKkTW/WFGawh+6ajyOY6IOChrrBqZp/zvpMDOOp8nstz0Pecrt51TFhX7q091P8iMEmtdHp
 pU4UiAYg/hNsIeuIX+At5sZKHzVWmZiiFGOSEhAnYrDs+RYwghBt6PY1cYZOxy0vCOifk1RULrn
 Rn4XhbhgKbYyfyw2hblBedWB75nBEwcDLflbqhM/omiaZSMIzokO5ygAY8YKQSlb7XXq7UQkOaf
 0+iprOKsHQuXkL00d0oPxtr9jtzOB6TgClfSVeRa1HZenzXNk12kEAVB/zPyhOpUIZ5rUeQE+2k
 3GpSyWrtH8nJTEQ1S+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2MSBTYWx0ZWRfXxS5oys7ylteS
 i17Bdv+Pq9ZyVXHSgaADqrYe4FrlX8k1t/Wm9Youry7xy+lH/IHesxmojLcibCNRLvK30ic5QWO
 EcJ1hPss1G51bUaXfohC8ilkZ3NTvaU=
X-Proofpoint-GUID: 0pm5rxwJ5OX_fhTuYtPaGFZZpIuBZc2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140161
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

On 7/13/2026 10:58 PM, Ziyang Zhang wrote:
> On Mon, 13 Jul 2026 10:55:04 -0700, Pierrick Bouvier wrote:
>> On 7/11/2026 2:45 AM, Ziyang Zhang wrote:
>>> Document the dlcall plugin under Example Plugins: what it does, the
>>> trusted-
>>> guests and guest_base == 0 constraints, how to load it, and a pointer to
>>> Lorelei, one end-to-end userspace implementation, for the toolchain
>>> and a
>>> runnable example.
>>>
>>> Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
>>> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
>>> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
>>> ---
>>>   docs/about/emulation.rst | 158 +++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 158 insertions(+)
>>>
>>
>> Thanks for your updates, this is now ready to go.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Thanks for your review.
> 
> The Lorelei 1.0.8.0 has been published.
> 
> - The devkit no longer ships a host libstdc++.so / libgcc_s.so on any
> runtime search path.
> - The guest side is unchanged: the x86_64 sysroot carries no libstdc++,
> so the guest copy still ships next to the guest runtime.
>

👍Looks good!

> Thanks,
> Ziyang Zhang
> 

Regards,
Pierrick

