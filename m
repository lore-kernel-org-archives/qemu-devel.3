Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1EFCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDiiI-0007fj-Vc; Mon, 05 Oct 2026 09:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xDiiC-0007dt-17
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:26:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xDiiA-0004sU-Ep
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:26:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CFLKw1068084
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 13:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UVgGfElQqq72YJB4eDFJMKlG7GcShx6WHC77Em6o9hY=; b=ZC1fHKHV/qsoDmPj
 FDfEtTM1kmRRdSaeBGnLzA4meN1RJ8E2t9PCpmuXWrsF0YZ8A8XK0Pb3cIegUwc8
 OIUPAs6axekii+F2WtJvHLCihGAbNUuLvzsXQ4vTJhgKA1NfGuIfkF25mZRF/PcW
 wmyTMqR4bxOe1lNa1FA1DaDeHLw2ad2EMSxZjfrF9QI8mBWttvQPxICfcJ/MDI8c
 fJj0o5IemJXEcP+R84/ouKMskWPiIdJmOLuR8bCYs/5SAjR9F+CvElb5JNZ4Koqw
 4ho2FY/s8yFn2TE6go/hlxpZsyOK6GuzlQnexSTC+GO+8marjcIkhl28Tnuu9Aqx
 oNrVOg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2u08nysm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 13:26:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93bfb2da664so382560185a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791206791; x=1791811591; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UVgGfElQqq72YJB4eDFJMKlG7GcShx6WHC77Em6o9hY=;
 b=evdjC5n+epri7Qz3QttFuJpqeNTMwWaU+vjuxGGd00kUD8R3gn9nQszQKPju4Nm3il
 XAPMYvSdVd209+AboxGQWtMkkwNXa+jdamwCXi4DwV17ZFeP/DBiK+r2oNXjwr+PyO9p
 YOKmV1QdA4/Pdb6yuMYImy65SkmNggQyjzLAzJ/RuLsIrNjzzui8FHzkjw9dwl2gyaYH
 XF+ymrZHGACmwtY1iZ8JrnRdJJTimZ4rtcOiQFcES4rsXg/CVBfWmAPrzzGNTq4fuNHX
 n5BgxQk4a+IfjVBOVbDmgH3O9Rf2VoeosYa1CV+bhIPu4PVATvCG3hKmgZs3UeZZwOGt
 GPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791206791; x=1791811591;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UVgGfElQqq72YJB4eDFJMKlG7GcShx6WHC77Em6o9hY=;
 b=JOlwfJFoegZ9YkWIclgpdERjWAr3/3eEdM/0Pkn25auwt29Vl5i6+O37o2YAQBHfop
 YcfxP7sjvTO62GhYkUZs+Y+gG6x4+xdeN58pmhrXiq/T/qgGMixCPQ1h4mXO4PvQVH1O
 I5uqAHEtb5z0L9nRD7a7YPC1+sM79ZxfggbUjHMTJjewGzuclKgG7FG1amIdSNmnQHMT
 gl6XLhBYziM76adoGdu1YenWzyoPP+i7ysWaVHSK5Qa8hq1sGhbc0wmMQdnIo3t5oxqH
 fsJv0mFvd4J6Q7dIUV1Kl7gvA9570WBGsk707jUDAiFmh/w6gdrP/gmAZWiXpaZ9Knff
 whMA==
X-Forwarded-Encrypted: i=1;
 AKwUvByB9Uh/o2uzrGRsb3Q4CWK5yExIWx1sL/4Cw8AvBJWFwXAXk696w9vi/pe0sWzQcv9qjQBJOjfVeU4L@nongnu.org
X-Gm-Message-State: AFuF++n3dlgLrY6z14TxOeNj+shLZ0UlPqNBlsWPXN4s6iBOt9p4Ncce
 nTz6y8HayomZCCgBRAkUcwhOQO7oLhZW4KeSY/Vk0UKqqK1Z37mxHdzndQL3/VpkAdnbxfqOnEw
 pfNa1wUIwFGG+sROFN8wYiysXldUpacLQLiEZ3QHFX/CErrJy8Kw5S/uLjg==
X-Gm-Gg: AYBFou36XBmshqNlYEKYNgH9Ih4KRPzm1cvgg8JN/ljg9+jF7CTzp3+JRqk4u3DM0Fd
 92bWaN53lwsve2CNdiTr+/dTPTga5RbCF5HYPPnUpCFX8HvYghx5kYxE0OOpSHgVCmPGy7zTiDb
 IIqB8jXUe9LukHNEWNBZP84SDsX3SCOSqkmqtkpzJMJyWrwwOesFrV/fdKFrhJwlBOENfDqLTcy
 MQGLKX3sCUf/ie6IafxUp35bA5N8Jn3NHQ4WBYr8tWAoe/l66sbR8q1yu6hjAuH/v3Rq/mmFGvI
 6rHbHWFGZK0Uj2D1POCMncQ77us0nGD7QlFl7QEOSjOyltzd/j+2rO4S/YxhtbBQstv8JhMwOlm
 qyEJkag82oLzyoMKQMGfnDzg+vOa7WsMbxg==
X-Received: by 2002:a05:620a:90ca:10b0:937:d6e8:59b0 with SMTP id
 af79cd13be357-93ce7c145d0mr1342532685a.10.1791206791276; 
 Mon, 05 Oct 2026 06:26:31 -0700 (PDT)
X-Received: by 2002:a05:620a:90ca:10b0:937:d6e8:59b0 with SMTP id
 af79cd13be357-93ce7c145d0mr1342528885a.10.1791206790784; 
 Mon, 05 Oct 2026 06:26:30 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c62270751sm3609856f8f.13.2026.10.05.06.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 06:26:30 -0700 (PDT)
Message-ID: <67742103-9b40-4c02-b297-e5d46d80482b@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 15:26:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/28] accel: mark kvm and xen accelerators as secure
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260911143627.2743803-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AsYN0OwroYgPfpjCyU4FjATsVxBB7iNN
X-Proofpoint-GUID: AsYN0OwroYgPfpjCyU4FjATsVxBB7iNN
X-Authority-Analysis: v=2.4 cv=JqlkP84C c=1 sm=1 tr=0 ts=6ac3a588 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=ft2qPWJe3-GeceLKO5gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MiBTYWx0ZWRfX7EXfaZKByLCQ
 lPjh8BC1KjwcglWHqMWu+1w7EHGaSjXXXzYv6Tn4V5FNpptnxnZ6R01iKhKmd1tHqUd5RmRm6kq
 C57eiD/2LylgPmnu3m1WLEWPePTvBBw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MiBTYWx0ZWRfX33tXOr4gb530
 lABAQUQhsV4orbLS3O7gX9BJvqS9UH8CgQzgAypX0Ga9/gkrqznjBFUqPJSww8U6yzlagxktOqj
 d96r/jBffs4qF44o5T6PzKduUvKFKuwH5UCVLMSk6IQHUmubVnffEUxKUpRR606BIlzOWU66rW+
 Q6I6bYdkorNtWmJrEaaVAwYnUt8tnN3nE0zBzscgDAgreGsP2ouRI041K8h8oy2pBmroZWyhaZF
 f095yXwdlHEsXoIkVtjp5YQ55dqSrXrPXJRfYav6JuwM2W/SZISHlvEzJnrYl5zyxek3En+ikIC
 3Fbn9NqAvqoYGq0/Pp8jWsOYOwzCglD7k5xkwdmDxTfIZlt1+25Riaefp5tFfPMFCQbo5J7mYdl
 ho5ogRS7F6sbgpy+bBaLRQ+69aJ33meLpBvDBAFNGLwamQ6J9sEe2IOt+HaEcHL9rxqCc1/IIL1
 x/yqFMSj+9QoHMhaTug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050052
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/9/26 16:36, Daniel P. BerrangÃ© wrote:
> TCG is too complex to be considered to provide a security boundary
> for malicious guest workloads. QTest is only used for functional
> testing and thus is not relevant to mark secure.
> 
> KVM and Xen are servicing virtualization use cases which must
> provide security and actively maintained.
> 
> While HVF would be in scope conceptually, it is not sufficiently
> mature or maintained to claim a security boundary at this time.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   accel/accel-common.c      | 2 ++
>   accel/accel-system.c      | 1 +
>   accel/kvm/kvm-accel-ops.c | 1 +
>   accel/kvm/kvm-all.c       | 1 +

Maybe split so maintainers can Ack separately?

>   accel/xen/xen-all.c       | 2 ++
>   5 files changed, 7 insertions(+)

I think accel/nitro/ is also meant to be secure (in patch 6
you mark hw/virtio/virtio-nsm.c as secure).

