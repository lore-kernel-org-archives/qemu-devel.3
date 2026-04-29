Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CC9FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDRD-0001iv-23; Wed, 29 Apr 2026 18:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDRA-0001eF-QU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:31:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDR9-0007Pj-6z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:31:20 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbmYZ256282
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ALBHviGBQ1ecze1muLqo/ztwShHmKCWFoLxc65A2qZw=; b=dDDIzLe0A1eaYo/b
 ObJHlyAic7L5e6p4DEV3BhNvJJrPH5y5UQvDHqk13eiDigO72wQB803GvbhMRt97
 B6lb4ZQ4jampZHLks7LW89job2H6ulHWyZFx7vKfD+7AhhiqBjUU1X9ZCIkjmtow
 WfNit5QHVxqvOgVdeWTbCKjVNv0iAsMqN+N8Hf97GekIF3Zv+MgYm60CT3Iw7Mdo
 pBC2KQSsAosxaTBIMtGvGQyYSagaYkrp53QMVrRL7Qxe6yK4NgvYfrG98MdrJkFq
 bBIDjfZcfuWC0Xlv2UDkiY9j8OqgE1rSCiwLBwtNoJqlmIqAEIj0uvxjRqOUnPzV
 0HycqQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dun71hbfk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:31:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2d889997495so1274147eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777501876; x=1778106676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ALBHviGBQ1ecze1muLqo/ztwShHmKCWFoLxc65A2qZw=;
 b=Cg8JVCsNs566ZljKgOmjPnmxcpEdrZds/UvdFww93OrRbVWtsvR7i4uBu29+e5mJPH
 HY4obNVBFG9U2Hi0rSxYuJr8nobvgRN4PjnD1JWz7+x6opPAPPVSun0AQ638Ncpnxktq
 I8TgKXdYPY1h+8/gl+pQADPhZN+6QU9SH0JxWdyAhcl3gDT++8YHkXJi4Eg1ZD5kJXzK
 e9cl+zDg5j59t0jQ7lsNvc/xwHNx0wzhr0jK4/qUOBk/42f9YI1KT0bj1yZuXEO1oFR1
 UZ7yHVDYVXu004sk+b8e7zBPh54ZF3MQTM+d+pxE8zEeBrvx1zmVgL+O9ntrMC9BdmYd
 eTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501876; x=1778106676;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ALBHviGBQ1ecze1muLqo/ztwShHmKCWFoLxc65A2qZw=;
 b=C5CbRiYIIFtz8oklQ1Wip/8GFmsVTq3b32bIP66zO3pmexDrD/AURZ0iCUi2ToYXXX
 1p9dBsuW2wt0juTeW+7PCBGE6ZtpLJ/h7BftJ5DLyak9wQ0rPAr0RBB0uo5ksYFjXL1y
 5bCGiZplvC6IjkpOQ3i1vovVK/6+DWXyMWQqV1F0qsJ0VVuG/mOmVaqkGNeACoKeQCGQ
 xfMzkyCK4b9ZCSd604pNXw5uNytI/14THa1tq3jVqYYWxuee1fJgJeXqwnrJ0RJYFOhp
 TA72/pSv0+bCAf+ZAFGW47iZqe0N1dgJT8eyxJuHqYNPak8sI2+OQzPhIjztP3g3VfPN
 TNHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jvNtzI3xDb0QARI2CctfedZBZTW6W/4U2AT+sx9NaRYnPQxtMXta0xDP78HWDmIkQDtEFLF8zUD7U@nongnu.org
X-Gm-Message-State: AOJu0YyWx6sbv06SC1+qNPXPKz0SUnEUzH1LuWQD2wyDQG+4t+qpN3G+
 KwCs8L0cmblfqq0SYIekZuQJYBuSiFgn+BppMntEiZWnFFeo7lVAwvp0SLZMWvRoJYeM7CWy742
 yL+dH6BgA+V1b9GSVW90xKaQOegBH7GDjhDH/PH3g5N0y9j8Kj2SChgTRjQ==
X-Gm-Gg: AeBDieuJcqgfjJj17PQPHP2RT08xhpxazdCMDmgWHtxYwkWYL3wuvd6cvShab6/sSJJ
 8WmBY4+OFgeE2TUrSHXwqmZuTs+HvI80sN1R3xF/u8MGyHh/Evv1zNyw+DBBJFGZks/zWfHkHRm
 2aQ1BEuEVq3LOe5EBi8BJe3BdJSkUONBrJGMSYklPHUhoXRxqI9sVVp5wB+Q5h99Zokjdio1qgg
 r2lKMdNz5D1AOrMoxogRWhDo2V0FnIg5Y7dTdddT60seCio5QEzI3pOpjnFGkKqAe1UUpTVW1Qa
 K9gNO2H5NCgz+loMJ2hyaAHSfgBjYY1I9m3CPOvkumYgT/y4BBmvrLwj60QH6wib/LR3vfcpgEt
 EmHAbaUMwMEnyLilrPitkCqpKXqkAt9trF3+XEhG8iZ/pJ4egAeTjJwNLImp9zfFCuJSxZ75AO7
 X9CAl/fgTuVpOqbO7wXIghGe6M
X-Received: by 2002:a05:7300:fb97:b0:2d1:a3ea:d8d4 with SMTP id
 5a478bee46e88-2ed3bfef709mr108683eec.6.1777501876458; 
 Wed, 29 Apr 2026 15:31:16 -0700 (PDT)
X-Received: by 2002:a05:7300:fb97:b0:2d1:a3ea:d8d4 with SMTP id
 5a478bee46e88-2ed3bfef709mr108654eec.6.1777501875947; 
 Wed, 29 Apr 2026 15:31:15 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c0cefc1sm4232085eec.28.2026.04.29.15.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:31:15 -0700 (PDT)
Message-ID: <a7f840b9-d24d-4710-abcd-661759b791ac@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:31:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] bsd-user: Delete sbrk and sstk system calls.
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
 <20260429-syscall-nr-v2-2-67a8d09dc13e@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-syscall-nr-v2-2-67a8d09dc13e@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zFkz03HOcFOhNRfvx9Jat19NULz8e37g
X-Proofpoint-ORIG-GUID: zFkz03HOcFOhNRfvx9Jat19NULz8e37g
X-Authority-Analysis: v=2.4 cv=TvHWQjXh c=1 sm=1 tr=0 ts=69f286b5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=UkHJCDUQ193i7898M4YA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIyNiBTYWx0ZWRfX5nUqYOpyoUS0
 a1PEU86Oio3P8cM8JK/YKuuFyWp8SnBcuXziuzad9wjurSrVjwRJhuWpLayfLd3U3U+zQBAiHUF
 9kKmC1vTaZ2N+b66Yhjm77yA1uBw97xZBCw9g9ZiIDHp+dlc7LxZbaV88MLWdHbVgv9Ly7FzXmd
 tahiXPva79MUzUh2PrrGtLYVpOzTLMKQpFmQJjKVK6yYLM8U7WkdD4IrPEjsGGQE42qtD5fWR9N
 UOnfPC0VS58fZxr9AwH8vkPUAMMxdO73SxL3c13VkGytSsK/WnzwJbzf7QboXFsBvHvZlu7cUuC
 qo3wsIb7O6I+u0j9ZyU5iat/IM3C5JkUI3giEozPUUOBd5J/wADCgVue+V8ZooOv2KCtsLI1JcV
 APc5E5SgFUsEtN6zE+HmIBH5kTGYMszFOOKS3UjB91PMc3szcLvaHoRzgUsP6FTTYsMvlMZs06A
 18yNdvMdNYYwYqbUjnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290226
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

On 4/29/2026 7:38 AM, Warner Losh wrote:
> sbrk and sstk were an experimental system call introduced in 4.2BSD, but
> with an blank implementation. They remained in subsequent 4BSD releases
> doing nothing (with 4.3-Reno and later returning not supported). FreeBSD
> 1.x imported this. They were removed in 2023. Remove them from here
> because no real, non-contrived program on FreeBSD ever had them.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/bsd-mem.h            | 2 ++
>  bsd-user/freebsd/os-syscall.c | 8 --------
>  bsd-user/freebsd/strace.list  | 4 ++++
>  3 files changed, 6 insertions(+), 8 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

