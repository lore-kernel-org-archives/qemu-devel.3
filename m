Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A6606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IaxPuvX0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YIwwK7Sl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrT5-0002dq-P3; Fri, 30 Oct 2026 14:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrT3-0002cJ-IP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:36:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrT1-000346-S3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:36:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu0pi3977368
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /APGakPJPsntUPczQoVg91r/UjlbErfJqj59LEw8DNg=; b=IaxPuvX0ccHDembo
 3ApHb5S6u8vqyIqhCp8GTNOqo6Bby/KFGVESGJSaU8fn0liShusvcc6sOH64azyp
 nZZOQlJzfELjWujdyfM5aRIhYnnHU0pSQkDAqVW9K5R4pyy5JLUGGMrSPrpX82AU
 JsjClPID/uIUT0oETIWcln58Izlw0cL/0X9a6K+AAKesK3YhvCN53ZfekWm1YneU
 UOneqbDmGPkspeMOpR7IaCBJz+xkczbJHhaH4YoVAPjpl0mgN05afoC1yxImT8YT
 raAAgs/k+x+IueiiLLjCt2pLDsxsL+qmBev2EsY/Ker6tNePidpK0AwnOcOddlox
 zOnYsw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmj66-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:36:41 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7c0f07b4e81so99446137.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793385401; x=1793990201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/APGakPJPsntUPczQoVg91r/UjlbErfJqj59LEw8DNg=;
 b=YIwwK7Slmqs2cYJ+9Szi96t1AWk200Ghkeg/wCl7C3L/9lYCKQ5KS31eBwdkUfdpxi
 w1LipiTSbDfIh3gxybyUnwU7jYzOcqO3JXu1/HK5JWqVgN0En1Tex3zQz6P5YDoFQbun
 6aETxaZ3rg4/KwKMja5AZXTzskMXdcR6crdqn7fTbleMpZLhA75CWQlqWpTbcQzmlf3C
 S+TTTNHaL3t34vS7X1ttY8SWNBDsmvWRGO3B2Mzelm3npHUFRtMb1UFe5HxgIBv97gjI
 OOspcKUo4MCV8AgUazv5XS+IndLTIvCQsd8TZuGfRn5ekRSUI+7fqQrXLsIiERn37jcs
 20qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385401; x=1793990201;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/APGakPJPsntUPczQoVg91r/UjlbErfJqj59LEw8DNg=;
 b=ahyoxJugrkGGeid2IEpx6GM03+HXb77HAeGfUYjOQ66R3Y+rl2ZK30WX5SMnaRtFGO
 qQJIkuPzM5N+me2m+RKS+rDNJK/xJiZs+CqcmqGe3fG6iisVrTkIhY1uwXbFoK6CbFB2
 94f0XiibUywf3OwRpA7hfQkSNoMd9/AGSMyl85Da5+Hae7cfqu5hizFLR5Zcng0wXa75
 8aeltoFdyIyn9+l5TCdsxB/4VRBY+LCyNycOyrb6TujpbeDOcy7C9i2/bDkvYCAYauPH
 4oqVK8su24S09u1dS8uVZQK9qlMR5b0nHT8Rh7JMNcJykYuZ0AGrr/0qN3CKkoUXDiAB
 rKUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCsXW8P1AhDe0l5CP61XmfNxJ8xzGF/dGDjuY1JfOqxqK9NFEBJ/jcug9eMRtGz7OzDYzkF/hRn92G@nongnu.org
X-Gm-Message-State: AFq9FYJUheAw3tlXD0b1ZaVFAfCpAN71E8myjmQOM3uzC79QB4gvRS74
 TQT6KXD+qN5Az5SpfeTy37tlTUCi+1eX3adB2JDMcXgsVtmgnZrN1hSFYQPbJXSe4NG3asG+PJk
 1+MSO3YauaQQnOwg0oOe/JQLouPxi7kFj5eytp9FiWl9PH7s7v5HFWYXxMA==
X-Gm-Gg: AYBFou2f6NmJXwEsKkkyUm0C0W6L5n97NXFA6OldifCsEL2QMF5mW38KeyZy5dsDRW9
 VWEBRAYMePhSYQOl0W3Jv9CkRrCXnOppI8HAMgDpZoKQnm5Uwxqu+8rUPFfwlGOQCMrjWl9Ec/d
 CitHwryvuNLYwE2LWrSlwkbdiqCsJbUAqAakid20WQAOk2kH2+8OGDmG5CjEjX90JY3cl+fQzx3
 ihwWWLmiHoYblDFgbHYWS6lC2LCy9C2DxZTHOYLlrwiZhzNwko2LUFovjHobykHL1d1JJyn639V
 Pkvy0JJhzOh18DFnGbtyrYXHkgbSrTUHcVOtkJYOJaUNTaw4tK2eON+E94q5bE9JxNjxNCbc0ZA
 E9MNBuoPgUYdB+BPm1DgNuzFeJkbcCpytBshZfc19O/1f7nhu6tzx4PHej8JvYqDQeUhohbMq0c
 3C6WSgnTFvPpWTHBLdF+uBzx4=
X-Received: by 2002:a05:6102:14a3:b0:7be:37d8:1567 with SMTP id
 ada2fe7eead31-7d0725cefa6mr1619354137.10.1793385400491; 
 Fri, 30 Oct 2026 11:36:40 -0700 (PDT)
X-Received: by 2002:a05:6102:14a3:b0:7be:37d8:1567 with SMTP id
 ada2fe7eead31-7d0725cefa6mr1619341137.10.1793385399982; 
 Fri, 30 Oct 2026 11:36:39 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8e5f4sm4686155f8f.40.2026.10.30.11.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 11:36:39 -0700 (PDT)
Message-ID: <014cfd28-5067-49f6-b96c-3687c9fd8d54@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 19:36:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] hw/sd/sd: Retype state attribute to SDCardStates
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Christian Speich <c.speich@avm.de>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20261006094447.43491-1-shentey@gmail.com>
 <20261006094447.43491-8-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006094447.43491-8-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NF9fvl-Pi85jcyf2j3rGd0KWoOefp8OL
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4e3b9 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=aQqqRJASmxK1talSaFgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3NCBTYWx0ZWRfXziBCODPW9VvH
 nAyPIcecB1dZXmFLBWZw3UL6ezJqWW3RnZ6ebPz1lLooP5G5flhrfKDWUpiQQWT04v7JjYw4/nO
 LsQwHVYjo9BR8X/GmtBomt2u0OKVCH3SZcr7WBTpxBjg6qYvgfNRGXtdOH38/7WW7dS0p1ZhQLd
 EFYHvfQ+1g693IHP+qCQEb/Mdq+qw6M2OcxRh/lVVBKKHSDgT7qFU+U30E8BWVb6eMXHlkZIO+/
 +R4OsQYcGesfe/YKCIkB+lGQYKPI5v7xtJrTg58k0iOKpQ9jYLeoynjDtQLSLo1dsFix8H81GO8
 vyUF6aB4Cnn87wYhV9yhSRC2Wu1BgGomHfpP38gCyFjXPcPkf36FONS4uWS5QgCP3vkSqBL/kmB
 MpThyD+fVVZ7L5U7qgDETWYVIOHH27n6eMCJ6IZHqg1Px1OzFCcBgUGtsWjQeh6jSslmVjaJdew
 /uhQzRaJpjUhVjMmidw==
X-Proofpoint-ORIG-GUID: NF9fvl-Pi85jcyf2j3rGd0KWoOefp8OL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3NCBTYWx0ZWRfX/GeTPKkuHFrJ
 DP0hqFttOV02pcEwn9KAsPxnH/8MAXNvwG0Sl7cPh5zS8WTElpS9e1bmpLMh+Q92j40UT7uPlr0
 zqZ8F1ORzNv4HmR5+H1ie0RMiMIb1VU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300074
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 6/10/26 11:44, Bernhard Beschow wrote:
> An enumeration is checked by the compiler, so is more robust. It also
> helps auto-completion, so is more ergonomic. Change the state attribute
> to be of type enum SDCardStates rather than int32_t to achieve both.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/sd/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

