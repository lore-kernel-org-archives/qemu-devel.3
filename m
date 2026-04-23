Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3281AFDEE42
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 18:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFyuZ-0006Hi-UY; Thu, 23 Apr 2026 14:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFyuY-0006HV-Vb
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:36:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wFyuX-0002y3-7D
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:36:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NFYW9A180881
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 18:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VN+/t+9TvImS9msFqdfmLGyw9ro2e+P1Cu+rSv/JEYc=; b=i16GWX43OL3O+yIj
 PqGFhsybPWV6RdU9a2REwQjlhEMLj9/7bkmf7nTACafAUFJErkqbfWAb1dSWAo8S
 HKy5NmID/4Pb3Iao2QqUQQKpvW2XTRsNMBWa21KmU0M056xXqeg7j6TJkNZFz33i
 jnUkKFLPKEIXkeOxOy59kLFAC72SWqa/f37Iu/ZqZ6ptg66nOjXhQCVOj5qFs5Yl
 eUMfH8ohS4GnZn2G9iBWJAfuo8go3QYKDbatKYGjEWKUWx9tZFBLRdk0PMp6CSUv
 fz4QL5JYXrkSYFPoDtOoekB72PABqG0ILqlsXsbTwnXnDRugf087/sLCQ862Dwz4
 JSjJgw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqe62k2ga-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 18:36:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2da19227bc1so13177605eec.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 11:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776969383; x=1777574183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VN+/t+9TvImS9msFqdfmLGyw9ro2e+P1Cu+rSv/JEYc=;
 b=cGG/pB9OF6eISZES4wlMVgjTrwp2XBheH5KaldnJ/l5ORXj0yhVKnR9Qgab8Yh7BUy
 EMHOTo7tNMeXhkaBlzVnCTXgz05XlUBrtP46VDQVTI5Ky99FiCxKzvMXsMSqsB6mzRDA
 zXM3OEMGSJXIVWQBZP/hcziemryeEon98L1symLf4TGiWYWLg8XYqUDyKZHUGC9cU7u9
 en3rpVXGK/1kTrUbfEnas0CoFJwGw5HQ2ituQPFRXIBQhAzCVjiZPRG7VH79ia6ADzi6
 LLKgGVzaCy7tqJW3eIbQ1G4Mt6PoLp6djPa3JwvrCD1lLdv7v1QHKbeq6Md8fM9g5xYK
 iWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776969383; x=1777574183;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VN+/t+9TvImS9msFqdfmLGyw9ro2e+P1Cu+rSv/JEYc=;
 b=JpIqepIHMjJQs7MJ8HZ1ahUerGnsterk25tcb6FVJTjko3yAfw+poDSw9jv0vIKIZd
 5CrHTgNmCzGzQ8gUUK/dOsEjEfq0ZTVL+LgcjGRuNmHTaQWcxVW30Py9EekTPJVBT1Nx
 Sh/VGcpXs8aoSOBDTXbsDGCKqCgs24ImKks+LRhDdM87yjKmSyRT9v96SVI6xZ5wdG44
 85ZxwFJQKFlSR2hTFWy7jDlcolDSaIT3Zm83YKT8xdBQc5oHddSlYYCsuKrApiChjPOU
 cNtEujbgwXTrdYdDvU016ahPj3+xgWQrqkE9LWMRhN5ojwQrC8r3HRoFaTEaWMA8ik2o
 yQzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Vmwkf7u+btt6PtrS5QtiyS1oEJ2/Y6zpFTBEVVrU9E43RYPtl40M2p14fMoTRwR4plYYjpZz9cvYe@nongnu.org
X-Gm-Message-State: AOJu0Ywi3K/ZZcjvwXtcB5GreuX23SgB84Aby8SUybPxW8HOkP3+UbcM
 e2O7uyi5c9iViPUAemFJDKmHtTVxxSX8vYD2vcp/SnhQmOzo1Hn9s3mUvev4NjRzD6fffkV0hl9
 jkNgS1+zNHhRTelQJ6SwmYCC4AEntm4rsuDmd2CEps8OmCYaTKOojVTaRHA==
X-Gm-Gg: AeBDiet9SYWK/tKoBdmPpmQfb9VgGkD+cDrtaEboKcOkoLxpCOuG1DVQAfyOyw/6kz/
 ehFHdjW1geEDAcCMzaMrbNvz/tUytQ/jLNqVBkaejb0hV8HffX1aD4FySL3izE05prmBNGEkcRl
 pfRBp2pl1yjDyPp8mRyCyQIiWVm6mRfl5hxBeTcToHy0aoDSQjhtKGeTcvMihPgYiaq8SU++SK+
 779hnoLgsCfzv4mHWdbaA7pcrkWSNkV1QPJjDkTI3aKTmNHZ0Ay2rRlj+iczW6i7KS98apBys3D
 SrJ/uYdhMz12/UdiaZWpXqm0PWlm/k/cXSw5KS53/aF0Q/NR0W3F+9GgDbcD6FLxSVg4s7saId2
 8vn6RK34jtYn97nMKntgClfbXUJvEOejkgv9K7ypeKWOtmu74Yr8Bn5ciZyzOYgJBnxa1qnodU3
 w58NP3Yr9KUcLlwLRkWFIE2+Bk
X-Received: by 2002:a05:7300:2d15:b0:2e7:5737:8364 with SMTP id
 5a478bee46e88-2e75746d9c9mr13979036eec.15.1776969382512; 
 Thu, 23 Apr 2026 11:36:22 -0700 (PDT)
X-Received: by 2002:a05:7300:2d15:b0:2e7:5737:8364 with SMTP id
 5a478bee46e88-2e75746d9c9mr13979017eec.15.1776969381923; 
 Thu, 23 Apr 2026 11:36:21 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm29608341eec.3.2026.04.23.11.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 11:36:21 -0700 (PDT)
Message-ID: <0355ab97-974b-4112-9f85-2bc2d7686c27@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 11:36:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer for linux-user
To: Helge Deller <deller@kernel.org>, laurent@vivier.eu, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20260423151521.3969-1-deller@kernel.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260423151521.3969-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iwR_MLOnkZXOxpoHBzZGI5Rp9dEkjz1J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE4MSBTYWx0ZWRfXw593ihQKG2A4
 L2NkjPmPG0FizuY1Q2TqXnHzz5ymgbgFew+4bG7NQMyW6Z3ySeqJ5YaSVWXnTNTdG6XGPVwA0ej
 edB6mkg2dv+59ebpX0t4tOoLhjXnMyvoVATMQQ+Jt7ZMiV1S2ityJKou+shfca95D2GPzQVcSnC
 F2aseKzDSXiYMOhqB8mJpj6cdPIEPmYI58vphJKlOBnfklI7GKSzeBzSfYHNg/+kDnIedpneIaP
 LXkui2bNsu9Gc1icldhWu63DYYGNk8q+pM86ZpHUEL/na/NxS+P8pbS5sqEDXQxCljhfhNnH/mJ
 ie7YwAC8CVW0YMIhKWARq9G+7MUsu89cXJJ0cCMObLp953zy0ryRCFaSiRkbT48eYvhS530aB5c
 2wXx4kjXlNv11w3UVAyc2x+6YjUJNfyWhJK8Z83HWvQQgvqVoKhkfKkizDEo7WMQOb/3TmeOO1e
 ZgVc12HM5WWy1yJfOJA==
X-Proofpoint-ORIG-GUID: iwR_MLOnkZXOxpoHBzZGI5Rp9dEkjz1J
X-Authority-Analysis: v=2.4 cv=Nv7htcdJ c=1 sm=1 tr=0 ts=69ea66a7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=cplnpDx6AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Zt0yZi7H8DzYYB4uuuUA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=bHwCOBSOUrNypjIvOSWD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230181
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

On 4/23/2026 8:15 AM, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> I'd like to step up as maintainer for linux-user. I'm actively using
> linux-user to emulate a HP-PARISC (hppa) linux environment on my debian
> buildd servers, so I'm very much interested that linux-user is running
> good and stable.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad215eced8..4736f5ad74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4074,6 +4074,7 @@ F: tests/vm/*bsd
>   T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
>   
>   Linux user
> +M: Helge Deller <deller@gmx.de>
>   M: Laurent Vivier <laurent@vivier.eu>
>   R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>   S: Odd Fixes

You're welcome to help on this!

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

