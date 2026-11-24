Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796C3606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DpmacRIh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kFiMvUNV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvrA-0001pa-1v; Tue, 24 Nov 2026 14:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVvr8-0001pG-OP
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:07:06 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVvr7-0002NZ-8G
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:07:06 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXLNh1767125
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FuGZ4tY1bZdNfZxwyJynkzUQ0ffukrvMyFaT5wLqR3U=; b=DpmacRIhIkd7ERSi
 l8U7IrDLThNmqfC9TaS0xJKql39mLBqYKpzRYBkrpuRLzGG/PiDPTa5l6lrNfJfY
 VGGkwQXugsBDRuwMh61hMIO/DQ3SnkfvCXDn9rSGW5HbETQosOfglidIPKFWxznk
 046p1K7519pBLvjkMfldFInHdmSIcKGGyWg6Ttqi+RN5ZmuNDndUtEcBZFn31st6
 YSHgY8CP9os+3i6/pCbXjsgptE03gPvpS0G/sS+4anj6DN4d//0BOEvE+1YDRwKK
 ACdJQtyLzOFwdc4FkXalfNXj/iexvaUYRL2WIcDlgaLrM3OBMbdftKZtEbd5Z+tp
 rPIPOA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5egs8n3a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:07:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-383ec96a7deso5497710eec.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795547223; x=1796152023; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FuGZ4tY1bZdNfZxwyJynkzUQ0ffukrvMyFaT5wLqR3U=;
 b=kFiMvUNVt0+y0gQER7ASE7zC0t1jcRulQZwZu4Nzq0qOy9iIhOYP9icwLr2X9mw0Kh
 cNr6UdZbPcxk8a+DinDX919VFJ7Dau3oiSnK0F3WbK2syDg7yJqMccU+n/prSet8vnGg
 hhfquQMoT4AWo1bvUc0cB9NnWLoFKZ+xC+VU7UL2J0ZnMlr30MTNy9z7ewkkx6OffBjW
 r9yFlGXrPqLHHK8C8+EN8QcwmApYR4IwEgpYdOBNscXG7szwS/QgoWW8Xc4kGFf2wnVD
 /Eb28J/1jDWsL+44zAzi1MxdFvgA4vm6ErkDC0uxbh3ym4HEvR4BLtappv1sqcMbwFXg
 Zd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547223; x=1796152023;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FuGZ4tY1bZdNfZxwyJynkzUQ0ffukrvMyFaT5wLqR3U=;
 b=rYcbJN39ksqv6tCt2XbydpSHBwl2Q69x5EAn3rIyQlgi11H4VQQEfAsCraYXv7Ax28
 igvHmrfY3x9hHCoxfTHBuvSUMpTjkzpC6UjOxvlvFZGnVrqfbIQR2PaKfnaga8Q/6bL7
 xYPY9lvGC0zaAF/rO1jdcyKN6kgnER2dtmYReccNOIWkxqJgAxYX89/7RfrRowH72ApJ
 G8cocNeTnY23ieoRysasSWnHWzyheZqgnVqkl7f4Ah/+ZNoGixLN4ry9XKEQ9d084TYs
 p204RRN4QjKpJmvnMZylywy7+AVZ0/N0Bxr1i4CgWH1gT8Q79kkx4HSDAdqmXKq6RauV
 o8rg==
X-Forwarded-Encrypted: i=1;
 AL+hErGdW1Eiz5p3vTE2ZvMCKcnqjYa3On4FLivkZqfzKdRJ+ifMtgjGtUhkLgKojpEOVQoImtbT8y8rN3q0@nongnu.org
X-Gm-Message-State: APuU4Z8c1zYuX3Sj2NiD89OPLCj3vSmIxoUijVu2+vYizWc21E6HwTrP
 y4sMcXUqh9nU0YojbMqup2Gow0zjC04f32caW304n4Goj6H5lnaf0eSuMmQx+2YWHZAiprwuqMS
 pD6ohhQg+Vaqp8nCq34OrwONdHrSR7xIr1SdIgpvIxTLzczFye6Aq/WZ3dg==
X-Gm-Gg: AZFdTZeN2rzVdj285n96UNacXg1/PSKhJSaPtBniXZ18f7CX9AaTNrov10T4O4LdWI8
 dEkYua1Lx1/T9nMHtdmK7BPs4wY4Zfyp6k0FbYLhoJTnZIX3oz8EB0kom10UyZkO10NemCfHXX3
 jfLdjhQyk+Gp9rncoMDkB5MOAweo9xUgtyhY9eZxs4V5FH2T9CkWLCBh7vBBHkhwuOatJcjAHDl
 7KvJ4UGIbl3VzQTOw5ylsuz258L/tHW4M7BRjIlW0M5bD48iahZ4i5KZXGRg+xOfbHqgCXeijJx
 IfyLwuIUEQfKzcgCGtirykKfFOgIotEZXdB0KVv85Mc6lGqJfCrJrJ/bHZTc7MY97GHsMQrAIu2
 6VStRWFTGdvhI2AlwLTpZfh9oU7c5bzybx/zKXfXu2z3grAlbBaRbFqajSXQ4lk4QLX2TvnCpQD
 NJlZUPoFtwLgWqkq1HtrBFwLEGfz/ZcENZnpQyx+bZkCw=
X-Received: by 2002:a05:7301:db86:b0:384:d59d:199c with SMTP id
 5a478bee46e88-3856c2c3fd0mr15017294eec.1.1795547222759; 
 Tue, 24 Nov 2026 11:07:02 -0800 (PST)
X-Received: by 2002:a05:7301:db86:b0:384:d59d:199c with SMTP id
 5a478bee46e88-3856c2c3fd0mr15017267eec.1.1795547222076; 
 Tue, 24 Nov 2026 11:07:02 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566fdce48sm50161918eec.14.2026.11.24.11.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 11:07:01 -0800 (PST)
Message-ID: <dd0dc52f-48c7-4a94-87e6-4c228cd802aa@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:07:00 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v3 4/7] target/hexagon: deliver floating point
 exceptions after the packet
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
 <20261124190314.3882017-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261124190314.3882017-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NSBTYWx0ZWRfX2HGsfQPS9ycI
 /TWH+MboaZaQJnczp0XTNfuZB8o+SZneZDM5LjfrOWQu6kvNTLCnl9o17C3CEHN3gNSqGd0uzoQ
 bKsOFhqqrAeX02lRAEiewgeRiL2kptI8dZJYu3hxmPIQLiCrZdlGK0QhuX6B0JdZIKugIJZh/Eo
 N+VgEbb2XblzbIOjLZ515xl8YMLQN8J1GeEXcIzj6z6kKFG+QSzAZSughc8FcokSSq4blfwr3gh
 8vuX3HD56EzTkBwmKj+szLfLFzwv7RvrnoXKqeXuq/1W/jrb5qjyTdlxCer+OCUDTW//qXc8NLy
 GHoRSoLJNppBgX0TQJd6ELYlwwV3n0w9/CQMFYmB+V8ehWnvst6CYe2AjOCVXggLvjktnesPUwy
 6Pk7YUwnHh54hujR/NuSHFLS41ELTrZJEI+T8OcMGIYk/jMefF7LBPt9kzHMsvf6t6Kh5DkjhHU
 IKkQcYY5ZLXP1mMgKTg==
X-Proofpoint-GUID: 227Mtl3FPNj9epowZVF0tzkj409V9VWa
X-Proofpoint-ORIG-GUID: 227Mtl3FPNj9epowZVF0tzkj409V9VWa
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6b05e058 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aeLbRA1U7RjvwJyXdLQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NSBTYWx0ZWRfX5B5p8aOL9KpL
 X1D2Cxx2E2m5Mtx8MAg5XtBXzIkiXWwMpYxjZU8rKFWQHw9JnbvJow5WLBPIAmihSdOdGeagUDh
 HR+djf0rRqZeXYDISEE9pitNiscsicw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240075
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

On 11/24/2026 11:03 AM, Brian Cain wrote:
> An unmasked floating point exception used to take the exception in the
> middle of the packet, with whatever PC was last written.  The
> architecture takes it after the packet commits, like trap0, so pend it
> the way the TLB pends an imprecise exception and raise it at the end of
> the packet.  Report ELR as the last word of the packet so that a handler
> resumes at the next packet by advancing ELR by one word.
> 
> This enables the float_excp systest.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/arch.c                     |  9 +++++----
>  target/hexagon/hexswi.c                   |  1 +
>  target/hexagon/translate.c                | 10 ++++++++--
>  tests/functional/hexagon/test_systests.py |  5 +++++
>  4 files changed, 19 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

