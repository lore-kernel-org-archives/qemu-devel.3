Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0184C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vBD-0003Xz-D9; Mon, 31 Aug 2026 02:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vBC-0003Xp-1p
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:07:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0vBA-0005Ui-IM
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:07:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52w412424046
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WiXJF3DxZb/fqCuONACVZvc3FPcRbbeV91Fdb3T81tk=; b=AlpowcBgQylnqXXe
 N//MM+h1XRMT0D84dqGF7kPeLodSwW/RQjOCzTYq3qhZZ+KiAVXLFn4NGw1Pb9hS
 U3KdVE6lhEf/6cEeu3lnUgXWc2EkdRutqBI+xeeTpe5s2jxj2diZW31e6CMiQLqa
 RDh2rg4Grdt8kHQ2jyFKKMnueEr5EpOPOGPwL5Ea/CH4ybwFvLb6MwOeF14AI2m1
 cVdAJ4KVr/HxoRXt7O8bVJK331zT/KJdyDxufj7LZuCoV95dthFIfWlBZoSG92hT
 VofnKaf8KpecOzm50JRHlwVuYaj+uoQoRZiskjQSPys/5bGkYp9fIOATUixv+OTE
 Q2GATQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqe2cu45-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:07:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52f52ccd459so47007401cf.1
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 23:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788156454; x=1788761254; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WiXJF3DxZb/fqCuONACVZvc3FPcRbbeV91Fdb3T81tk=;
 b=Kk4/9WIzOHStTrjbb7UvHCs57oWlmEi5HLEoN/xNjdlbh29bcUdd5ysIFODzi3kBOl
 DZPBRfAP188O5igxK4lUyhyst8qNMJzT0tDdZiC9P9z86ea+YvZi5MS9EBAGvFtyM0LD
 oQ8KVaUqKkedhkgETLuu1yTM8113AgQiGFuvj0OkxQU2Xy2sc5kPfrParH/4q0zLyBXX
 mUYQ8Zi85VAbr4dFdOh+fB9qgZuPTABXYK7TWPdl530rJHungIONFh1Jd8QGAy70cq6O
 /S5a27s4nNckCvdxX5prIQGM0MU6h6DAjPBiIjmWynaQtnz+j4ynLgccaQcNuKpIuzfY
 iKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788156454; x=1788761254;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WiXJF3DxZb/fqCuONACVZvc3FPcRbbeV91Fdb3T81tk=;
 b=K1ZLeWvCqB4UdHs1MejKaE1Iq2R8QMQ5Bh7+hugloQOrVc7PoxrvLgXvKZ8LJpVZOa
 SnBJk5mbP78Xo2NcHbqUn/lrxX8QxOZzEeKuUNlmjqFJViu28ymYHh8rwt2hEX/dzszt
 umHHHD1EDzEmIgalTS+QIgmsAAGq8QefGlTELELMLun5ZrjC5+kxRtlEtqDHjvMt5PCb
 shNg5aHDA3AihGjKyOgdCJF262jJI62zFFtwo9piOFcmPRdqjr+dNWEQ6o40ForePim9
 YpCakpAB41OKSHRGmTuxXnNZWAL+oDblRg48Ck5XZWrcmUC3CxSQGWrxwXvjYETF/4Ug
 PRSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUG7WX/vK9fyN7jFrJ9qe+s+3ZINqc1IuRmoiUn//HiZLJniQ+VBtj1flVnxJAZV1hrIHmplhC9QTQ@nongnu.org
X-Gm-Message-State: AFuF++k2JGYxov/dfH4OgaTileB4SI0gQMlQH4PQWy0Q62FAO5WoisGr
 EGeC4qUpZ5+18AfWcWA/rx39VcAjVz5x0Q3qLav2+X7OKq43pyvSZwxlMiE/UJM9ov5HW7jBl7P
 R5dqra56Jee2d7v44qaaUBIcrl2VgGdbNhZFSf/F33zK+jSK5sS/S/GiLUBXjCEqafQ==
X-Gm-Gg: AR+sD116ZJeOYs8+IB2x0Jk+vtimtlXD6MVUWWjqj7t75eTWUQ4fAnCwoznkUy2VtVp
 OjEyyIyLlnl3yn7B/9xGxSh7yaqrP+OyCyz+BIWnvUt6nDWIJZwHeZylNWeox0DJj8bN9C8+k3r
 NeUqHnpa4+a74ShnPygUPg9k2BhvMJCTD9a5AgKx9CBqIg0JQ2TSGIvYzDcsHT4EyYqwtw4mR7T
 TI8rTZVMD/5ApINAbnCxLB+r56Y9NbA3aKTltPdjSWElnJhx4rRnw/+OgaO3E1CDQxoWguNMpTK
 7vbdkteKQ/eBIlO9GaEAAUMvg3+QlGcqLA9tIg8TSKRoh+OqiMYUTnvQ1zA0VI9R5mv1iRe/Nhw
 0LgxOw+pbP9ALM9O6BNRihcxj1Gk8KnD+dQ==
X-Received: by 2002:a05:622a:4d44:b0:52d:7b6e:4986 with SMTP id
 d75a77b69052e-52fb94aca06mr320699131cf.23.1788156449501; 
 Sun, 30 Aug 2026 23:07:29 -0700 (PDT)
X-Received: by 2002:a05:620a:6881:b0:939:4f9:bfaf with SMTP id
 af79cd13be357-939139a0b5bmr2898055085a.40.1788156064928; 
 Sun, 30 Aug 2026 23:01:04 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95018ee8sm258654755e9.15.2026.08.30.23.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 23:01:04 -0700 (PDT)
Message-ID: <e087aa35-5189-4891-94fc-6b1adbd4eccd@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 08:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] hw/riscv/cps: Map interrupt controllers in SoC
 container
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-7-joel@jms.id.au>
 <b6dde536-bc21-48b3-91c1-03bf900b1e5d@oss.qualcomm.com>
 <CACPK8XcOwv4JLrO-UnbJWoi_jgkARBZ=DMFf7_6RWs2QLiX4Mg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CACPK8XcOwv4JLrO-UnbJWoi_jgkARBZ=DMFf7_6RWs2QLiX4Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Iskutr/g c=1 sm=1 tr=0 ts=6a951a27 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=8-sKEpKnhSKuG9pYr00A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 7ZlfZta8s0Z9Q2sw5tI4sjlDk_rrPXRQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1MSBTYWx0ZWRfX/B8jw49Jihiq
 JnYg9TLazloMEcquKGdvkXv3AuZxu4+TofuHk3pDDDS+/0YXdywDgj6vBjDsoINjqQlWiCz2Hxr
 f2dr7uDph/4jlVCzkIj5NrF+8xpQ5/Wqm5bxCJhTHFQntEUzK0mF8v9OyZLqcB5amNRkoI6BaJp
 g3Kv6QBAtxPcf1uGdVyjMTroj4RPXuCaKanqWN9Yxs9Bp9dXnIOg4c13QZ2rt4dYuYjJ+YQ70U6
 z1fgkvMgBFAxoYlzwdUNY9TIr1DhRQW0sdBY180inYhzYyxrqXYvAtel2bANL4gDdQUKhKhav7o
 aOuuUmG4s/+1MTSXjKHF0iDlWZPPmhY/ADeHE+KUOC/wNlvRQdv66txu9FLcCLlTK0l82V+esKa
 IDk/hqbAUO53IdClqkOQGT+7V4r199Hjm110WECnbBNixzFG/+2uxlh2AeaVCe2WMkkyVHiuWnw
 n55GlCbauWd3KnrnNUQ==
X-Proofpoint-ORIG-GUID: 7ZlfZta8s0Z9Q2sw5tI4sjlDk_rrPXRQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1MSBTYWx0ZWRfX0VT0qdCjVbVW
 aqTECCki2rymmjJcky+3Jt7qy7sYCV0p9sfMIesin/NpdAidhjNI3qaMom5KyPW/4PM5WMqjU83
 yDCMDYTyOMmKHmrJ26MLv6pxAopq49s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310051
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 31/8/26 07:50, Joel Stanley wrote:
> On Mon, 31 Aug 2026 at 14:35, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 31/8/26 04:14, Joel Stanley wrote:
>>> The CPS device maps some devices into a container region, but the
>>> ACLINT and APLIC were mapped directly to system_memory.
>>>
>>> Pass the container memory region to the interrupt controller helpers so
>>> all CPS devices live in the container. The location of devices in memory
>>> for the boston-aia machine is unchanged.
>>>
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>> ---
>>>    hw/riscv/cps.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> (I'd have expected this as 1st patch in this series)
> 
> This is a fix that is enabled by the first four patches; only possible
> now that we can pass a MemoryRegion.

Oh right, good then!

> 
> So the first few patches modify the cps machine to pass
> system_memory() to preserve behaviour. Then this patch switches them
> over to use the container.
> 
> Usually a no-no, modifying a line that was modified in an earlier
> patch. I could fold this change into the first few patches, but then
> the change in behaviour wouldn't have been as clear to reviewers.
> 
> Cheers,
> 
> Joel
> 


