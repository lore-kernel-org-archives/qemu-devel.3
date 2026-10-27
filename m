Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC261606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mD8CnZgQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AgyqD6Lm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlsa-0000SN-Ky; Tue, 27 Oct 2026 14:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLls7-0000D0-GE
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:26:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLls4-0004za-Ou
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:26:07 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHPhg3553880
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sBoNYG2/VLOCXr5s8H72Fe6tRbiTjTU85h25ejei/N0=; b=mD8CnZgQxE1oa5j9
 qoKXWXheKVZzLxGFCQd69cVdXqPCuWdkXjtlYVB1vx1TpHS4ssqwqthhF4DWGHJ0
 pvrzS9FXFH9ZIjGLBLuPqbb6Qa23faQ7wjIwvQ0CHr4TVyUctIEUdCjtiGeh27fp
 UUCi0qykQM2tjuwixbr2fuk2AVp/UwYUVoZ8+gduFzvLxTBKdLpC6pR3tM/7q2C4
 XAS+3ilcyVcxwQQxbWc/6VcuUbkm567kosgeRC1AOdYsVsLteX89eCWUAAW1YYJG
 2xB17lmoRe6Wm2/gtcgLnzc5MVnPDGHTJR3QXJpWzv/WiTRrUzm7DDu0VkE1g2zK
 HkMDrg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22p7d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:26:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb71b1443so14214585a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793125561; x=1793730361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sBoNYG2/VLOCXr5s8H72Fe6tRbiTjTU85h25ejei/N0=;
 b=AgyqD6LmeFG4/I8N6+He2XK81KUMisIupR6LpYII8/XUMfVfKzKNTM1ZI5Te7xzV5d
 U1J4y8ccEE/bPD+4BSej7CarkiLHjzHt7OrUeJyvYCpxPj9rSZnl+EN4NHrYnb99roqz
 GRh+OELCwQgkO/9Y5wODDoSRjoqfh2NtWLPNhviPQnnkt4yrgZJbtHV5YsKeKlKt68ER
 zhLdxP7OZsA710yCLkD/56s8pu9Wyd31tFSuVPOu0NobiBYXmPrkl7ACVvSgLbjf2q59
 9HfxD+mF312Hr3/vZPv8uINRMmCSPtU+mhi2B5xVFhvf0TgwUCxHUXZHFavXB17aCkqU
 6MPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793125561; x=1793730361;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sBoNYG2/VLOCXr5s8H72Fe6tRbiTjTU85h25ejei/N0=;
 b=PEuUXqLisjYQeN0CqYHULLUJUq526DatxDBq2S4h582QQPnLxSXOd6IV2WNw8SW/nA
 j3lQuuqHhfu7DMO3Jxj1rSO5xlFRmg+m+de6+Hal+ryzM4ow5hW/cvmVuuYSxmaqEx3G
 cjSRB/mAvD9Kh2xjfFUKyYR0Ak190XwU/qRmkGdX+qoi8e9qFVG5AhLyYJm8X+7OKA6I
 hh9Bma43hu7NYJg51Yhpth3fBSEED6TkjzSi1DkFIIAc4quz5+1MeCFA4auZ9rqJEUbv
 /btu06/gSnAWcrODxHHtobKLKjB6nNrxkXpK2KdCOO8P+t28rKZbp/ngWKoUsmD/yGNs
 9R6g==
X-Forwarded-Encrypted: i=1;
 AKwUvByg0yfUEbSQg0PKFL28Gm6uAXMHOJFNytMHDO5XlQiOLnQFlsWINwo8i8zRiz5G+SqU996fwsheXg5A@nongnu.org
X-Gm-Message-State: AFq9FYJiAELXoRwqhPRlTmURR6vQJmb3Y2ci/8F7Y+MnaZLL5+08UG8h
 hi+r+gkh/J0Isbl0XuUSBWdUvnWDiIignWIkReWx8Qq4yWysPwKhLHtpf0H6Q7rhEz6QRgxSPZc
 sESmL/qUw9bDamWRWtSHktZKC5loOfSR5pi4AD5BdqvWVNJNnEVe+Ct6cvw==
X-Gm-Gg: AYBFou3b/HAtcF6BrfIoRKqtb/3jxUypUaEc3rrkcWYx6qAbolFEbkqqYy02Q5CzKo7
 Qfkk/pgR9zTYnw4yKoIrpTfrNLNXdOLpk7StNLRvvqmwAjxvOOv6GHS7qyt4IHNzkkjc4jMwzLE
 s9zL7cF54qyOpakRaHFfln24voEJmN49Ovu2XZZdg7vB33BdeHQe5lLqNjrmxlf8dqcQJvR7vNe
 9XVd1JyhWU/33DUV3DCf2XHAuM7Rd35V1l31hlaagR57SXxGAzZJCQkLl5eSIV9JeHnF5kd2V++
 d1KyVoes6IqBvelRG7SeMt0NM+k27AmDAPEitircQe0DTQ43tRqIohTUUJ6RcFRZ33K5trv2Xdd
 k4Xw6axkfKaZHd0epW7beS3SY2lZhe3YgXgHZOnd1kK7EJtSB9w==
X-Received: by 2002:a05:620a:1b98:b0:93c:6f0e:8468 with SMTP id
 af79cd13be357-940ef8f0788mr1681986785a.43.1793125561005; 
 Tue, 27 Oct 2026 11:26:01 -0700 (PDT)
X-Received: by 2002:a05:620a:1b98:b0:93c:6f0e:8468 with SMTP id
 af79cd13be357-940ef8f0788mr1681982485a.43.1793125560576; 
 Tue, 27 Oct 2026 11:26:00 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94c6d9aeesm405515e9.7.2026.10.27.11.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 11:25:59 -0700 (PDT)
Message-ID: <c5a02b34-d171-4329-b8a1-ce7562752ee0@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 19:25:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] hw/nitro: mark 'nitro' machine as secure
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Chao Liu
 <chao.liu@processmission.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 xen-devel@lists.xenproject.org, Sergio Lopez <slp@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Bibo Mao <maobibo@loongson.cn>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Xianglai Li <lixianglai@loongson.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Song Gao <17746591750@163.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261027181400.1752951-1-berrange@redhat.com>
 <20261027181400.1752951-9-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027181400.1752951-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MyBTYWx0ZWRfX0El+Hf6xeyUa
 7Pu3aC1g5r5LNaI8QRha5wrFjEWkPi+CaM1uHgVY1LZvo+POAju954a7FHI9RUidBgK0ZNW5QZO
 khiF6wbHllh1ulU3IT5h8bxRMkWM9QGm+jwp2fKt2q3dSHCis1UEuUydrllCpkJvxLeHTqQt/ws
 lxpiOXglzozy5OKugwBB1Drrc1VTs5IeeVyKeWRZ8C1swGg8TAtutPwgqpHkCgi2DAoMzF62aKY
 jHkDC7Q+wm1GUi9+6oLDLFzCc0Mf0MKnbbOwRCp/2fnQA2oHFhIi4pDNXJEFc7+Zwhumm6o4nCd
 4i8Rtn4+k0k6DJqeqfRe2uRfQLDWK7IHBJ74iQTMc2LnaXaGNUK2LB+PO20Xqvqy0vOGno9IeL9
 UBS44QoZRkzCBiJjvl3FDZgzhyMsFEMii835NklJt6yCg46DaF7Zg4vu5A3Lk3o5wKCCZPUtUn6
 W3KdmvrU8GcqF86saDA==
X-Proofpoint-GUID: RfzmIpGRUyORh9vjFSrxiBC4_WtTX-_d
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MyBTYWx0ZWRfXyyOlswUKdu4Q
 yl9f65raGcOHoXpySqfH1XDdVJrx0GDimNzKVhJYRUY8dWU68HMQWxPFN/7myvucdNI3avluo0I
 EPMdXcbq9f+l0L6Svziv9iDt1WMW7Rw=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0ecb9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ZVfvRXNSK-DTiSIkpbsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: RfzmIpGRUyORh9vjFSrxiBC4_WtTX-_d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/10/26 19:13, Daniel P. BerrangÃ© wrote:
> Unlike the 'nitro-enclave' machine which provides emulation, the
> 'nitro' machine is used with a real AWS deployment and thus is
> considered to be secure.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/nitro/machine.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

