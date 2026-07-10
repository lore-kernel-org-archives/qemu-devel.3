Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF21C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiH5j-00044m-98; Fri, 10 Jul 2026 15:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiH5h-00044U-Lf
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:40:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiH5f-0008Ne-TK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:40:53 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AH3lIQ1502267
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 19:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /WGoY/WdrXOSWmASI6N/oNp+MhmFTxdFmKP9K9aE6m4=; b=UafOSmL6A3MPWKge
 Y8sJq2SrqV9hJSXczDXxTsJuABXJpwf0aRhodbrjTsq28AzAu2Ij6MCwnIcpZ8cL
 9qNeE42hHIIUt5TyQ7DbyiZ9LpV1Fjzlqdm0YzECkRFTgHYZWup+Td7XHiALlIys
 bU1IBKtWq0N1VFJQAe0bgIQVTleskbFijYGEFuQ04MRUIZRX7Z6rw3SWL05CRcOf
 HJnIG+b4eAJxUhkhBo9sIRWBnWf6uK3vo0YVvU/EGadEfuTuc01hS/3zODZqeSQ7
 gykdcHVctfoiLPtWGuuwyC7iAYRmtqjPORMZ6tLs3uP0DOgvDu6+LOElzI4OBcEP
 9QBT1g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xvrr9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 19:40:48 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8952346bb9so917866a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783712448; x=1784317248; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/WGoY/WdrXOSWmASI6N/oNp+MhmFTxdFmKP9K9aE6m4=;
 b=B1OAXzKe8I8CgkJvK0INQZatvvArT//L8wBVT2aiUVvbkWhevDT4ONtMWNydM0yXmj
 ck8qfYjf2Fq9zI9McQHARVbiVwyCEw+yDS+15Id7eNnoDwFFTy/NDlfYRY0aXA7HjAfD
 mzbd9P0Ge8npINRLrebbJOfIxKmMusIeHokGsLaIqQkmhm0LVlSO4+9SbHTm/pxvzH6w
 A6W70vS+MmGAwND332XCNb1zU7hMT7BYw9I+C5zEvSk/tgCN6KmhOdMUjBNN8R8L8GV4
 gAhDqeHyIBndnC52lknEgGumhtYhULX0uGiASVPLSO1okm91KfWceR9Wl10+hIRI8faW
 RQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783712448; x=1784317248;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/WGoY/WdrXOSWmASI6N/oNp+MhmFTxdFmKP9K9aE6m4=;
 b=kDVKveZRezZX13Q/TjMTW1m2DPRg0jLZ2/9y+5kBlliQjI2QMVz5JVLfwOnOCqx5WM
 ZABfXeHgH3d4RdLt32ZZ4zE4ZJppxuR49TGVncdzu2tQRgnXGZmjpSmMELf6DGKmvwPp
 mw24Ts+Ih7zIKKwz+c6TjOiBn0QBnwDkLCuhicSiOmdp5SM77rB4Oy7+zjxRWwW3DgOX
 8HRn6USOQgYSGJ4CpZF/pvuIYUqd4IkkdVmj7/ieFOU7sQ3ENL0hjXzYYoRM/0PBApDC
 zg6nPq6532ae2W/9KvzA1ImgRGNllIEC3w9git8siBLi7xEO1A7nX82sOOYWa0w9fMS4
 Q39w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrx40FSREoTv0JXBQL7vL3ls82CtPfInZMsYYxyn/deCQS9ShkPjKY1YHiypR1wJHncxmv5j1g2/Lf+@nongnu.org
X-Gm-Message-State: AOJu0YzoyOBJwJTYbhtst7de1SLcY4vFMSZyyevs33aV86zgvcleNRx5
 DuUEQApzK1HGhCu1IUtPXsJTAgdgpHyhItVwAiDzNTDKGzmfJz/mWU16ojO+fgSlX9S7x5bCllO
 KEsFAsWPRU94D2awD1HwaUliCGzyk0hQNGjne8wjZYZpZVQQ+Ql3RQHf6nQ==
X-Gm-Gg: AfdE7cn0GAP4KtFJXlXCxML0yNQi9WBDcUHeJSvbnzXYFIQ0m5jyFibof23jT8E6a+3
 6tuAUjHt1XxCz+ScpZe+zIA2w1dPvFD1jdJVxpTKZzspqAFEZHGIrPA27+NzNTsZCa1jo9qEMD3
 OdKEDoEteSeNXp9jtiApiyRXDc2AQ0mMmmTCZw/3bCnMt3NkDPc8jOwFO0yKDXsMHrYy0xX1vai
 b/CuyGwu9gcghoPoBrtFT49pjfi5RbM0fCOufAbzVGOAS2Jp/MhZ7Lf7VJgfr6k5t2QbFwjOgWg
 GhAniI5NWGRHRlu55PdIgDdFNs36QZZy0YKBkV1hu6MNSxilytjBZio59hDUgmlXhnsHDmyz3dm
 I7Cc7qVAOTTIJMKt7TcLTuRDriQXxuPCFfu7Y/RH2RZeBy3/fICWVVKhCapR8GGufR3JomvklbK
 awIuw=
X-Received: by 2002:a05:6a20:c98b:b0:39b:d937:8020 with SMTP id
 adf61e73a8af0-3c110ad2d68mr354118637.42.1783712448178; 
 Fri, 10 Jul 2026 12:40:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:c98b:b0:39b:d937:8020 with SMTP id
 adf61e73a8af0-3c110ad2d68mr354093637.42.1783712447725; 
 Fri, 10 Jul 2026 12:40:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483dec6sm44416717eec.11.2026.07.10.12.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 12:40:47 -0700 (PDT)
Message-ID: <3e251594-4194-456e-ad75-3e70c2b7a9f5@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 12:40:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/hexagon: fix PC not advancing for non-COF
 TB-ending packets
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260709230645.3033240-1-brian.cain@oss.qualcomm.com>
 <20260709230645.3033240-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260709230645.3033240-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ztRicUbHwToPglHyRyLxxN4r6jAtxmbD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE5NyBTYWx0ZWRfX3bdcXnmqJ2Pj
 fsqGVU99d2+TumXMp6kLNo0eGtwm9G27AT49sLEb9YLokn7d0aotIQ3a9RIWs3JtUPlvwLH5RaB
 4Fuyuo/0B+/DyeRGbyUBi7xVb79yGiPfy2iElbQmBWVVkgadcP2ZlLGUNzBKdfab+Iyj3r7aFel
 lngAv1uherx1sxXfMe+gQecY26pMZOaM0RLfMrUkRUJ+84e6XUViUpN58bZ6/q/OEa5pe5JXwvA
 izwxdHBl549ziqgOaDFdBZD/Ats+6kESb69uYOLl4LPVE02odS6efJ6qq5Xw6lRClx/ndwWnnSP
 v5njLJEnSneWOBAzk18XJiFxEX7DaRC9inB2nmLn7K5Eo2YqiQP8df6xwjWwdeDtEbEFxehAbbO
 WrVGu1S4omNIh2M9XGpxXPTIWrqT7o2fXdiQqlAdQrm7I3wismXHRbZOkRqsHOMvBlsBy1fIT/n
 /36DqKnOHwgAcjkmbuA==
X-Proofpoint-GUID: ztRicUbHwToPglHyRyLxxN4r6jAtxmbD
X-Authority-Analysis: v=2.4 cv=HInz0Itv c=1 sm=1 tr=0 ts=6a514ac0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=SYAwJpJR29QFIwxsTyoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE5NyBTYWx0ZWRfXwy5Xa7WrYKkB
 Jud+AHzWr9B+lTbGYXSxBetZqhydl908c9UuIktiXpYd9dN/2Mp5RETUPw1hbaGwx1X5OKH3Go3
 cJA756hAiiIWB8m2EXVd9zI+kMX0pP0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100197
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

On 7/9/2026 4:06 PM, Brian Cain wrote:
> Add hex_next_PC, a global mirroring CPUHexagonState::next_PC,
> and ctx->need_next_pc, so that gen_write_new_pc_addr() can write the
> branch target through hex_next_PC instead of hex_gpr[HEX_REG_PC]
> when a later unconditional write of PC is expected. gen_end_tb()
> then commits hex_next_PC into hex_gpr[HEX_REG_PC] at the end of the
> packet.
> 
> Previously, non-COF instructions that still end a TB did not advance the
> PC, since next_PC's value was never written back into the PC register.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.h |  3 +++
>  target/hexagon/genptr.c    | 14 ++++++++---
>  target/hexagon/translate.c | 51 ++++++++++++++++++++++++++------------
>  3 files changed, 49 insertions(+), 19 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

