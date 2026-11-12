Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77576606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X/XkNWQm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HgQIdWGe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRXc0-0000W5-Pq; Thu, 12 Nov 2026 11:25:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xRXby-0000Ue-CA
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:25:18 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xRXbw-0004Hx-Id
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:25:18 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFZUmk3841249
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 16:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 omgG1UBjsLCgKqKMy6xS5JhYelzlAqIX3n7Hq9IdgCQ=; b=X/XkNWQmXymPLgxO
 Yr+a6aGdgr9S+Kfb51y+dx0ilckb18DE4wyD72PZstA0SkHJEd5jFGxXDjKrKgVL
 xIB98uucJEs7PMItOpJ/B+EtsYoaAZXptEwNHd6za8sNm1pMXMJ6cm2rCaBIrhBo
 YVojJta6N1uhrEW9SQjDbXf/ULEeGEBDD9JCIjrp1rBOt/9xmHOzUV1VzJdrccIg
 ykUGy4k2SYlqLgjvYdUaao2NhbUHp8nCPwuix1wqzHz0kFodypCkmKLRoAWLErUA
 9GWUlfDi0DD/loSo/6OyrSQsBjTdImCPiBpn9e8QNyNs2eCGW0kxFGgHnIqgNJyk
 vdV1LA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9e19vg7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 16:25:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5337ed1ba44so92172371cf.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 08:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794500713; x=1795105513; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=omgG1UBjsLCgKqKMy6xS5JhYelzlAqIX3n7Hq9IdgCQ=;
 b=HgQIdWGe1EGJxf54ubGKLgsWBS6npzEfiLu/gS8cxur+kjxpqugsX/A1eri+MH9cX8
 Fo3RWOdlW5WwKl4wOsVLth29T5qYgO2VRdQPEn38jK7IC4e+dx65lI6Z6piA9OuEyvbt
 7OfNie+N+XdRZC7MXTvdSNJn5/xiMmeJPgwJFUA3u0NGFnqInEuR+sS23tQuOFog69OY
 owa6OKsP28LuS8cwBKoqYeq4bn0fil2eskS49vWOz+9sF8EerG9ZfmkzowBegjtnnO/Y
 tLBjNIVqgdtRGVrH45akTx9rT1F9RmODrJ5o1i8u2MpLf2432yb2sJJSqbQ8h0E7YtYO
 Qyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794500713; x=1795105513;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=omgG1UBjsLCgKqKMy6xS5JhYelzlAqIX3n7Hq9IdgCQ=;
 b=YPPdCE5vWyBOiaaLC2HJNCO2Q4ujyN+2p0d6xPf6P7Kp2akBNq0cAqWi2c1UTc4Ej3
 FgINdIXDQ0FyjpzoGu3hxcUNO3AOxxIQzb/5szFUezJKu85V7j02JUk/YiJpmSNnjLGE
 jEUJpRCCl27djg0EYJ4VIa3Qa2qy5Fol7bHlpx3EtpKAJZpmkKutUXs8eemiqFVLfiZU
 iyLlQ/CBq9kAzv36yyLtMuHLHVSvGpbOZjP6XY8lfhFC3sac6J+Rf9ZgEo1GcvRWoFel
 nGg8Llu+VTk/9Bk1QuLB06tze2YtlsGP+J5BMYB1lHdvqWvSSvZu3RZlwUchTcd8orLM
 QJsg==
X-Forwarded-Encrypted: i=1;
 AL+hErF1ya/Q2zEYVb07RUCzmQQ+Cxbj+nGkYMF5EekFThKEA3ORR3oTgeHm1f1c04byHjWPtsfIMRBJV+T6@nongnu.org
X-Gm-Message-State: APuU4Z/4Uz5SlP6Nb40bI7+89Lqx/fehwdP7XrY+fzHCnk9fiLJAc4qw
 J8e6CTDgbBUPaVex80K2S4jS4vrOY/cFtzy6Efk4aoDgjCHN4fhiR9/YNmBwnTRke753hwS+nmm
 MRpOGkGaQwLB7WihDUd5VnOA2P6kU4R3IKIQtRmA9nKm5rsV1HLz49FBZhzrs5h58wA==
X-Gm-Gg: AYBFou3aGwnUzKnGLbuOI3UTk2mYH3c7/wQGCi7SntDWQ+DB7g7f3NwFj4VQRFISWQF
 IiR2vwVoDof96YjSbEe5r9HWLPfnbeJp/sY6EuRHYiPARh7x4cj0cdbpmCkumy7zT9pUjspwexI
 YYMwOI+JkdFVI61l4fYRVDrwFfoJsF0571kJCTz1CyxrWbNMAWpERAiIL05zslaz4xGIjdW/lxE
 uRrx7ec/0SYhSQbxFmb8dol/FWMm0gjvVbb24cvhMaUiAeLYOQ2kDHlsZMqKZ/4F5Rrt75ISpup
 QxoTzq/8kMN5muhFOP0rUzJgyV3bDqModhIE9s5N0kRh8oLvbcw785uarHCpafNiZzivJMvax05
 if9MNT87H2buLeccgyD+kQcBVhU8gEcGGD6oV9II3oOo2S9rLjefRNO9AHNkzQJt/7RTsBc8uaH
 gw
X-Received: by 2002:a05:622a:514a:b0:535:70b4:3f7e with SMTP id
 d75a77b69052e-556c1390750mr102959761cf.68.1794500712716; 
 Thu, 12 Nov 2026 08:25:12 -0800 (PST)
X-Received: by 2002:a05:622a:514a:b0:535:70b4:3f7e with SMTP id
 d75a77b69052e-556c1390750mr102959131cf.68.1794500712073; 
 Thu, 12 Nov 2026 08:25:12 -0800 (PST)
Received: from [172.31.27.103] ([209.52.143.85])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-556f374c4ccsm42435701cf.28.2026.11.12.08.25.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 08:25:09 -0800 (PST)
Message-ID: <463c6622-8880-4f05-8824-a094c5dc9f1b@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 10:25:07 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] roms: add H2 firmware support
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261024180657.2036255-1-brian.cain@oss.qualcomm.com>
 <20261024180657.2036255-2-brian.cain@oss.qualcomm.com>
 <4e004471-b8e2-498f-8c8b-19f0983f7082@tls.msk.ru>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <4e004471-b8e2-498f-8c8b-19f0983f7082@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NSBTYWx0ZWRfX9vKk8eBm9ctu
 EkfbU8sXsrKsNX+61Pb6OF87qRHFGHoUzenF7N7Vk2b8m2BKkDt/TQznCiHkBonOaTA5xFXI0Ai
 3FJdSmRsJBk3B78q/vdhWLGtWhRgUhhF8ItIh4OuWmTLR8WC1GsiekmkZXZO1Puxbw31ICPdmRW
 ztIXGMOrn4eeaKu0nuYc+/BHpAyb3sXfrnM9XOy/nFk+vopgOJbeotM2J6ZkQMiS/gft0OWUlAz
 V9la1F1/ENLWiF5LCjS9j9DLmx/WGtTu/Gk3s1R+Rfbrd2IemVVQuXp51c05KBTZbpXLBgOUcTb
 5UMe9a3fJzhsYZ2I7bE2idrANzgVmbGGO1namXCjtKQJ37+LaueQSDAXmqLmJNofuLGHVCXOpK8
 mzvn6xBkTTP0lwVhh6i/TjhgC8xmX/E8mCVlwkoMzgKVqLhXasd7lOQREqH8xghgJBtyTWTQ5ZL
 JAHQ5Zxf7eOTVpWerTg==
X-Proofpoint-GUID: Iw5gw-1f9QKidTP3_NJNYs9w0Hf0TN3f
X-Proofpoint-ORIG-GUID: Iw5gw-1f9QKidTP3_NJNYs9w0Hf0TN3f
X-Authority-Analysis: v=2.4 cv=F6fC5ahN c=1 sm=1 tr=0 ts=6af5e869 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=U2bLIKXb3u36GtQyNyP1yA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=GP7u6OMWVVPowWkK02IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NSBTYWx0ZWRfXzSNAAoMKqXgu
 NUG+n+7r252/fO+k1XROUuXtjhpE9RjtGRVXsLNa1SADoaYy1kxaKBHo8c5wQ4RXrb06Zv1bpUu
 Y7kfHUMF2o6guD9GDbC4J8EyCSVjeuY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/11/2026 2:09 AM, Michael Tokarev wrote:
> On 10/24/26 21:06, Brian Cain wrote:
>
>> --- a/roms/Makefile
>> +++ b/roms/Makefile
>
>> +# Needs Hexagon SDK on PATH.
>> +hexagon_h2_build := hexagon-firmware-build
>> +hexagon_h2_src := $(CURDIR)/hexagon-hypervisor
>> +hexagon_h2_out = $(CURDIR)/$(hexagon_h2_build)
>> +hexagon_h2_booters := hexagon-booter-qcs6490-cdsp \
>> +    hexagon-booter-sm8975-nsp hexagon-booter-sa8775p-cdsp \
>> +    hexagon-booter-sc8480xp-nsp0 hexagon-booter-sa8797p-nsp0
>> +hexagon_h2_loadlinux := hexagon-loadlinux-qcs6490-cdsp \
>> +    hexagon-loadlinux-sm8975-nsp hexagon-loadlinux-sa8775p-cdsp \
>> +    hexagon-loadlinux-sc8480xp-nsp0 hexagon-loadlinux-sa8797p-nsp0
>> +hexagon_h2_common_flags = USE_PKW=0 TARGET=opt NULL_ANGEL_TRAP=1 \
>> +    HMX_HLX_SUPPORT=1 \
>> +    H2K_LOAD_ADDR=0x9b800000 H2K_GUEST_START=0xa2000000 \
>> +    H2K_GIT_COMMIT=0x$(shell git -C hexagon-hypervisor rev-parse 
>> --short=8 HEAD) \
>> +    H2K_GIT_COMMIT_LONG=0x$(shell git -C hexagon-hypervisor 
>> rev-parse HEAD) \
>> +    JFLAG=-j$(shell nproc)
>
> Can we get rid of the git thing here please?
>
Sorry, I will fix it.


> When a user downloads tarball from qemu download area and extracts it,
> there's no git repository in there.  So the above `git rev-parse` fails.
>
> I dunno if there should be official releases for the hexagon firmware or
> we can create a file with some version string inside the subdir and 
> use it
> if exists (as we've done previously for some other roms, for exactly the
> same reason).  But the current version is not good :)
>
> (Testing 11.2.0-rc0 as a tarball, and noticed this immediately ;)
>
> Thanks,
>
> /mjt

