Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B45606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mhWx35R6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IldkXJX9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLltC-0000vC-ON; Tue, 27 Oct 2026 14:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLlsb-0000VN-30
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:26:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLlsZ-000533-H4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:26:36 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHWjr1917358
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5gtNOSL9DkqGrvLv5HiCmciZ411PQzVsYtj0F/yuWWM=; b=mhWx35R6EzRfQjVN
 1xH7p7SD7YTepkSQKvJRjnJdAwgY3XESWxBjR4e7n6msb3JPozQgoQDg0IxUxvi9
 hh1y0NovGCLazoZMOvJYn2VAHMfRpp6z5/xUwqSWFKtr/SwyQiyWAJkZ36GJbrcZ
 tjsFwvJyI61eqNejUo0z1ji7yPaKzlLipLt9pj3r4nEbWVn/Fzz09FJXK9JSFAbZ
 ZzwCiBOs6tcDrhMUPVudgOC8nrmUw8KJgoNXP6ql2E1i1/5zSNRRCklwLpyCRxdA
 XYxo2Z62g5QP2nNWOWLa+A6cCrxb3JWGzPLY6TIq1iZnyMlyQiHezOf0cPJEU92M
 nJptmg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux99mnc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 18:26:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f322ef7d3so17563685a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793125593; x=1793730393; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5gtNOSL9DkqGrvLv5HiCmciZ411PQzVsYtj0F/yuWWM=;
 b=IldkXJX9GJUPJRDL0E3iTHzlryQjr0M6sN6gmNbVRAxpEg6NLhHKlCo4atW2yo9me3
 CCCOq3jGW/LrRzoWSCta1AAa7V6cPmgT7z8UPzEoeiAE5AfihZDlvMci8VEYdo5AlbXX
 Q2B6CUxofzDLyydUWWzn8ge8U8TOlxOITB0Kc/si2EtcK6LYVsAlbI7EnGQ2o45oOZF+
 YKNq5kHOElfRG141nz/G+xi0L48LdchGx/eZBwco7FLKUHFZb8340saWsaAaX2fkNNAE
 e3l3TxbbjDvBbhIknGeDOA4JfKmQZJuAyS7IRnsJf4yrbc6cLAZHyYk7SDc9Mt79NF+i
 w9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793125593; x=1793730393;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5gtNOSL9DkqGrvLv5HiCmciZ411PQzVsYtj0F/yuWWM=;
 b=dnMCJOIcwB1uxjyatBGrzEzKSI/jt/GtqyIg1gngL7ebxRYmlkvlruXVCsokyOFEY8
 680Bb8SSn5tZrRIjA1lWIdMhPzhWyFPA4VWq9aPVTu4C3/4cpzPV4l47ELw2Hk1kidwD
 ElCPNkr90LpWr6XK5I5YXoU6A0Qb9hoXrLsEEO7ljJZ/76Qr8l1K6w1J7xlOrH7gdh8i
 JNdo4TxUutRyyk32dDNP4euZRf+nyUH61Ewp8LUkdqQ4ynvh4rGXKg3zYp6uij6787Ww
 NVRPJ9NRPgVMciTAbUpZJYvBvYyzcXvuy6N4IJq6YqUibyQI/9p3PaEEXbFfCg09bNKx
 VPPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiuB48bAn7OGPf9B5C9SjH6Os+ofVQLS7WB/OiwMzR9XZcWIRPBfM8hJiUzmR2tdh7zIWHT+UyJDbj@nongnu.org
X-Gm-Message-State: AFq9FYLIV98h6CTMfHAysQXoeA4Tkk+oVSCz0mBsXIJmDOJNbHlWEiGL
 iJ/Q+AEW3hLINpyxEjFVtg9X93NrjeQX/LbMxXHVAFKzu6/7TpYDu72tzW9G/Pm/+cNzTNXteS+
 e3HDLdykIdEc2e3uGcY8Bj2LDWhCLiVMDIhbBAQ7I9DVU5OPYf5PKgBlXrg==
X-Gm-Gg: AYBFou1qxZoDv2nRMSN5LPva7Ogi/O7mnAt2315Nb6gYUYVGXM8q+S40+VA4WLyGY4D
 45DcKWqZfAfiQL62wilKMb4ipR54pJDGhob+k5WnhTXuixI2s17O0P1Jkb55No/8YAdvU2IXB0X
 J+YkxsU3UcH5aF5XUUMcmhETw8NOOLe17i6Hw9MWyUIuZWhLNnciw1X5bNxpSZ7Q3YDQcW7rlvL
 /CPAfIU22NVvsdZLOAM4PRCux0BzchN53CstxtqgaYVzZB9ShCL77bZEoQB2nCJB1Ep9YrWPfmj
 N22T16zrNBhOLVgz1HYegR0Oe/KxiskORtWda5dVkGuTj3mNiuICZjAvl4pIePcn0ISNTi3l+cG
 sKB0qMHUnYOzvQZZ4RoXjOajLLFBBJM9Yotls6QylLyVPjQFe+Q==
X-Received: by 2002:a05:620a:2b4e:b0:93f:24c5:f561 with SMTP id
 af79cd13be357-940ef9457cbmr1583433485a.33.1793125592784; 
 Tue, 27 Oct 2026 11:26:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4e:b0:93f:24c5:f561 with SMTP id
 af79cd13be357-940ef9457cbmr1583427885a.33.1793125592323; 
 Tue, 27 Oct 2026 11:26:32 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94e6b8656sm23975e9.10.2026.10.27.11.26.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 11:26:31 -0700 (PDT)
Message-ID: <5ca7722a-cd6d-47eb-b8ec-4c93ef4d4699@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 19:26:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] accel/kvm: mark kvm accelerator as secure
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
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261027181400.1752951-1-berrange@redhat.com>
 <20261027181400.1752951-10-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027181400.1752951-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0ecd9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=R0rOnUjNbK5cqpqgS9oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: f9T2lF-dgPsDUowlEmh7MLjQMs_NQxc7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MyBTYWx0ZWRfXzTeQEQjs86Ng
 g9wMxeV2YzgLUyzzybh/pL4x0DNdM8YfMGYDqpo0efp5DhZQagA97kfZvKAa4epc9MnbQWqbCpL
 smw07Vikyz4/VGSMy4SV5DzZKm5pdKZKVULl3SlE9tYUJuZ6spqVjKGJgwdcpm4QUVTn5km83Ll
 zNcZXj0jSAQG2r3b4G26NInzIoQUo4g8fZyqJF16BJcOEPERL7POMQKm0XSu8kpGMHVaI24AE0U
 FoyGdKW1wcamPEbI/gIK5hnoV/1wN7J4fcMm61hkDsw2X3ZJCiIeWk2s9Zu5qUhSpS/E0Ef7RQv
 c+Cpsi1NlrNPHgu+NBCCpTycsYLf4E60CVoTA3ZZ14GvcZhcwSnzRScfGe8gsivsgcYBFMJKwFh
 KQQy/aX+ZC9t2hAqLbSpHv75a+zLw9k1MAMPGcuPaMmQJ8yatuJ75iXZBlrG11ZtX/lFQVP8S4M
 R9zWHzt0HxX69QHc9xg==
X-Proofpoint-GUID: f9T2lF-dgPsDUowlEmh7MLjQMs_NQxc7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MyBTYWx0ZWRfX6QPcWWnk7dr4
 EGh1yqecCuF8EaXvTJ4qp+IZKArpKp1F67563+TzJ8q978I6hZf/SDQOPYB3su0VJ8V+43Ziz6c
 Myh8/0R3FGIGyRMGzAUF5p54WasAES4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/10/26 19:13, Daniel P. BerrangÃ© wrote:
> KVM is servicing virtualization use cases which must provide security
> and actively maintained.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

