Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECCFC44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlu82-00067u-0q; Mon, 20 Jul 2026 15:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlu80-00066z-B1
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:58:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlu7y-0004Zl-Gt
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:58:16 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTcJP3663759
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 19:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZIX6eCg8w1tgZrSBV2l+LwmQZesdXYukL+3H017RICE=; b=fqgTZoKD7UOTKXVn
 /Takr3w9aR9zmh7hJgNrBzRaeIddsw6YYUW50RB2F0XJekpAqd8WE+TrPZsABgv6
 OOp6EH1YPkxsaX0yyAGtRcIKGjb01kqKvzsx9xZVatNmBlsdHrhIMqWOS65wMhKD
 s1Z/a5AuWX1afaCo1X/sbjvenK69d/JTQRobmjIqPqqSVrHMHh22AKaNaqKCUMIa
 G/COlXg3ypX+5OG5t1Sz1feqXAtyXS+HQgJmDlWF+6SVwVP04wFeM5rb9byTRHy/
 IeVUJJLhANR6SjuFPCl2mcz/wtindM5kEbMRrQTRaRdotNWBPi4S12yR5+mY3gSF
 tvdgvg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqff0uyy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 19:58:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so7351458a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784577491; x=1785182291; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZIX6eCg8w1tgZrSBV2l+LwmQZesdXYukL+3H017RICE=;
 b=FWEVheBS1zZFWHZ3D528pvbgkegc+ZyhCkg2Qe6rBTVFulgcfOAA45a4puWMdKVnB6
 wubKXcb8jdG/yknn9twrq2JlppL/9GtAQOcHpcewyASk+sBCd+CJNiDqLj5R1115kOJH
 sN8r4o9Gb8Iia0pYb1mr8ZTLC6zTUDMyE2eKXffQI3L3G5ZVqYPelCakEXKLYoS2Q3V4
 y2sPf/THlPHI5lem5f3KZqypPSq7HXrZqPGqFDiebOevzztNg1eBgDqeGBVI7EcBn3pN
 xuuocWqneLi1+7b7C45OHEr4kpctOR+2TSTom/Givg+CxI5BujpGjJb4WwC9hsXXPz0x
 ICzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784577491; x=1785182291;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZIX6eCg8w1tgZrSBV2l+LwmQZesdXYukL+3H017RICE=;
 b=h/E+PoW4xSYVWyYRb5NtJwuVCw+aFjGCM2wT1R0UcyoCINAxm3NQMZrEyQrdIsIFmV
 FoYAlCDZ/5Wf1L6AjMgSynILpnTDErS+8OpwulAY8MdFmmla0C/yMKmNwNcFviwp0CY/
 2YPZY2o2S1ZjSMqUf5Syu++3PPWshfi8rFOKy+qSVyviMX5ufuXDMOAtQ4W6aYG4alX4
 hWnxUTvADOfAED0/ycfCB7UfsDLfuen71wnxpBDoJ9RvSzvLGowKEntwOcXNrx/bU0rg
 MGZ6ABRkBu2dN76Ry0G79cV/dMa6dd3PB3HD3LE2FcnTdtP3/BmfPF7hkMoMX2H72c1V
 InFg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpb9OVoQ9ZfGcs9Msqgemat1dshasnYFTbKAK+BTt0Ti3sYphoVQbzUkEJRnK/+EsD0vz0aoHQjlaC0@nongnu.org
X-Gm-Message-State: AOJu0YyTIDfL8v/fIW/pNgCXF+MDDJDsgCy81kQT8lwVe7kYmVc2rTiD
 fscNwin7eS+Y2JAu8q6NCTp30aqLBgHZN+Iwtf16EtZSdCOMWE3WEjLtcN1KoTdFcuSLmd9Kkii
 0d4FWs0ohW6Z8zQ0p3g0GCdsQqgd5aAw59RZPbmhfPm5Vit12ElfR/aILiA==
X-Gm-Gg: AfdE7cnGkqxaqStafXPBoogPioU2VUlNyKLRdKh/J9J7fJEjL9M6Qf6JpMwQBsJRjMp
 SJvHCgpBmJRTRgbkjtLN4qai2913NDMTMckEgRnWnUdOShE7QuiazfS3svFNy5sO/oJBDampUAr
 V7CwAkac786YnPSk2P9m+vcnsVdLgYnADi9cx06JlTqNYlvVPERP4V+fCGVu0a1+y2Moq0cDLEE
 KQLYYuFi4fyt8sFb+Tw5gJ9msuGOlS0IuFpYSUhFjg08xVRcbPZzRtiwUzvZLVm16f1Q5DtHaS7
 0GpLZ5mqdb0HgQ3rkWNGe9maYfIe2jnCv9J9JM0GHuKhsZjA4WLBc9r1krZw4qLoTi01sCknRtL
 BGbHn7nOs0FRfaWwCxlKHEk6nl9lCZvpx1ZL+Ue/6zWP87x5YmC6yAglJNHRT95DG52E/
X-Received: by 2002:a05:6a21:610f:b0:3c3:a529:1e44 with SMTP id
 adf61e73a8af0-3c3ad9e7e92mr15955651637.57.1784577491430; 
 Mon, 20 Jul 2026 12:58:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:610f:b0:3c3:a529:1e44 with SMTP id
 adf61e73a8af0-3c3ad9e7e92mr15955613637.57.1784577490918; 
 Mon, 20 Jul 2026 12:58:10 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1bbaf6sm35565306eec.17.2026.07.20.12.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 12:58:09 -0700 (PDT)
Message-ID: <7bb06e89-ffc7-4d4c-9938-c48761b69e5d@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 12:58:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] contrib/plugins/dlcall: correct the syscall number
 claim, note the data model
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260719074730.1520517-1-functioner@sjtu.edu.cn>
 <20260719074730.1520517-2-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260719074730.1520517-2-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIxOCBTYWx0ZWRfX5Gwyz2aYIJZP
 sBUjTMJvYnkK8X2BlCKqMgREyhQgJ84Blilddi7O/HM9YzpHKZjA3gqFFZIaFiLoCdGnhmGMLR0
 6bxcqI9Hhef+i8IEkvrxzV3tDLuue9o=
X-Proofpoint-GUID: 4PSA7z0AAC7KxO4kksehpUon9o7F7mBY
X-Authority-Analysis: v=2.4 cv=FJErAeos c=1 sm=1 tr=0 ts=6a5e7dd4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8 a=io64dps14P2r0fVfe2UA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIxOCBTYWx0ZWRfX/NV+Yj5BB6j0
 nwOPcz7FTjDF6Nf5IAkI6UZzURJYR3GJSB3OEx3aepaFh0ODxmJpFq60wFTjHJJBcKq7ZoNKNMY
 JIPbRQE0fDg6UZxkmQI1ySqRN4Dl+7sLZU74UU6Gwzh0yX3CQ5mUdgGcgAok0f1xr7kTZxooIWk
 j6kt+7oXcTt3boeMjzrQG6OYBUCKalIbryIycZC6BrINMkbt116zLcgl6oaq6fo9JLgUIbFzbt5
 OCMZXPrE9jerJPnzteMmS83vQg+aocSfqU+0BN06E6yrubbR2OJKerWhyGQC2h5+RB9/qi9NBEX
 pe+FKRGTo4oxqYmXmPrvGYX+Hva+J8JL+31c/Pr9TNoUoPnfXuB94Udo642JYLBthFe0FnP3TgO
 EE1CgOejayC5bJ2g8KHr+9a1ZaDQCXSZ2wkQWCfQL8oY6iNuwRYJ7UZZbBJY9B+bduuVOK9mwqg
 Dso7gbOPP+dPHrGVR4w==
X-Proofpoint-ORIG-GUID: 4PSA7z0AAC7KxO4kksehpUon9o7F7mBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200218
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

On 7/19/2026 12:47 AM, Ziyang Zhang wrote:
> The comment claimed every Linux ABI keeps its syscall numbers well below the
> minimum, and that the minimum is all N has to satisfy. Neither holds.
> 
> MIPS O32 bases its numbering at 4000, so the default 4096 is its getpriority.
> Raising N does not rescue it either, because O32 answers numbers its table does
> not define with ENOSYS before the filter runs, which leaves no number that is
> both free and reachable on that ABI. arm32 bounds N from above too, with ENOSYS
> or SIGILL past ARM_NR_BASE. Say all of this, so the number can be chosen with
> the target in mind.
> 
> guest_base == 0 is not the only requirement either. Host pointers are written
> back through the caller's out pointers, so the guest must match the host's
> pointer width and endianness. Fold that into the existing warning.
> 
> Also assert the two out pointers that lacked it, and point at Lorelei for
> argument marshalling, callbacks and variadic functions.
> 
> Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>  contrib/plugins/dlcall.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

