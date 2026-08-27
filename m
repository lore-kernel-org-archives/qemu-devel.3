Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0A0C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzW2n-0004sG-R0; Thu, 27 Aug 2026 05:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzW2l-0004rQ-PT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:05:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzW2k-0003dF-4l
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:05:07 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6R0oT3834587
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z0u2ZN+JySnMwD5xORDhIWGvN5hVBx9/zscybhQWZ7k=; b=IfWLIWDSGdI1jb3a
 nAtPT/UjRQWxB27OarO7IjAwjEObGNCnlI5PpjF8qu9GMnkBJEYx0ilJvNQI384h
 nw2YObkYc/sok9ZDKAyBeJy3E/77eOpyc4h9Enyj9emTiWBHFqjAuTWRjCNYZWpS
 5ockFCHctLPmdbg3q6UP+DKu2mQsUb4F6LBdmkkT1+K5KZXLd4QqbVn1hUBcQZr2
 50vhhqBdwAsPLYQskmgRaC3qXdJ38Xa+3h3aN7oNmMcBddgCJwFNoIZ7iLpuqvCc
 GiMY3I4m2IWs5SdTfVFnYs2SAG6QITDikQ1k4d1+2iCwzloOyruQA1rMyP86RNAv
 atVzxg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0wbuwry-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:05:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52fa5c5a4a6so6094921cf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 02:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787821503; x=1788426303; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z0u2ZN+JySnMwD5xORDhIWGvN5hVBx9/zscybhQWZ7k=;
 b=gh7/kmFqsObIebic84lkXYDkLFwbg//OuRpnJ+2awOWEObIyXoL6r5gHbTCVk8Lgi6
 d01Kyw9c9eYiXLlbyxQjQ9ZLb03WfeOAovh2PNmtoWXYRuSSrsjvSGuzlzzQsCpijCvM
 4cmEJL3FBqLuerCkTCKRjcrLL0Wf7p7DwU1Yjgir71C0QBorjqPFScnYv7baj0PWe1/t
 W7XNhDvb/BYP0pPJuE6z44pA53LhvxHRTTF5T8/4aDJavHsmgqdeCFUmEDknuRQK4Fq5
 fw1h5CWfSX3lp4EIf8YC4qa10dr3l35wnu5WB0dYCfMyq6SR5p3YVs93dWAeaeJ69Paz
 UU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787821503; x=1788426303;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z0u2ZN+JySnMwD5xORDhIWGvN5hVBx9/zscybhQWZ7k=;
 b=rjkrJQk4Tq4CTTK9xqSwEdNvTJ/x4R8EHUl5d7Gv/+BYhy/HqsyBV7sVfiVL3XdgMM
 1SZxaJ9r1jl8GrJ9xA4N0yiZuZOZw4EMY1ofpWpS3WJh6AZwe8XZVxyKqavl577mO8xH
 CI6FpBS8DBFCXQyw7rtRaBsXQZ3pPke405Z+GVITTkiJyxcxpfaPQKeClqTxv4xKTYxb
 HZILxed9EDiRdFQelxnejDa/RixTYUU0ymagBh5cofswDLPXBqQzlfXwo6SQgYD3/a+j
 v1l5YB74kbfkLR5dNz5EQFZ/xfCCuS5ZY2Upok4e/XRQ/qZmXYhbFAwNfMx44ZtltHfW
 IAig==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpe5jOINLOsC6rU70iJFWB54k/DHIlDpBzA2fPg/bZc9yVDqTQFhu+m/W39O+oEAwuG72ZN6tBjFpQr@nongnu.org
X-Gm-Message-State: AFuF++lprNND7r3Thq0zdt96/QhKGv9q9hT/102gyOfGpmkH01vrZibE
 QD9vLn7GfsyMAtqH+G7KakO5lWCC+sjkIXSrIcARrcO2TzynHFt9tJ4t7NKsX9uLauImkwYluj2
 CUpIEUXM6J7T4tR8xpP1cemTjReDidB69D1uhqhQNYLAMJdWpX3GM3hVpDQ==
X-Gm-Gg: AR+sD12Y+Etgv86rKqQrReH5uTtbgd/pItgXk5UmT8bJ+9ZxftD8V/yt4zaGEY48aAl
 rLdxX15vJdgwhqlgV8RBr1DtKQZ17LXQQn17DI0bkP1EC0bFh5XX/jFK06yQrltgpg0rNKwaRXv
 dwaHyT692I68A6SdxuM3PeTuwYgN3cULnaQpEkNFl/iewDoveAskKCEwIAxRgMiR9+BsF6F0IPZ
 lN6l/ezse+kwMmwvWWtQW8MpeVuDb7iu/xsqkliJoxT0kPzvxrANELz7W1GNrkAiqEeIjO1jJRz
 RKUeNFZjTzMLUTpSSR1iHgyfZ/YkMQU4Ai+NR4UIrgo8itVZ+f6tNZ3LW5xa7FVD96ZqFTvoe57
 1YQ7Y7l5i25yW2x/0qCbMv22nYsTma2jVlS+Es2bAFfWQShnU
X-Received: by 2002:ac8:610b:0:b0:52d:f63b:94d9 with SMTP id
 d75a77b69052e-52e4236fdb5mr141093821cf.30.1787821503599; 
 Thu, 27 Aug 2026 02:05:03 -0700 (PDT)
X-Received: by 2002:ac8:610b:0:b0:52d:f63b:94d9 with SMTP id
 d75a77b69052e-52e4236fdb5mr141093441cf.30.1787821503220; 
 Thu, 27 Aug 2026 02:05:03 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b8d2ba486sm15418785e9.5.2026.08.27.02.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 02:05:02 -0700 (PDT)
Message-ID: <eba6d525-6040-427a-8019-f70ba1a85911@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 11:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: introduce
 virtio_gpu_simple_resource_new()
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com
References: <20260827070941.2875721-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260827070941.2875721-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: y3ZejKaaq0c1ddmE54EiSWVPQh--4_kT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3NCBTYWx0ZWRfXyqrKjXDS2aPg
 TmMvkNG0sEHQQCECQ6H6yccgnL8NarqR4ZUABqYV6JsaVt9yvyl349H7taB2cScZWjR9JAiJW5/
 8ymHnwuO+88uynT0aq8Qv+jNNqfnmtg=
X-Proofpoint-GUID: y3ZejKaaq0c1ddmE54EiSWVPQh--4_kT
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a8ffdc0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3NCBTYWx0ZWRfXxDqFtISSSjYj
 CI2RkL5kzBFhOX0PGyWGOc9uQ8bB84X+FfywCg5pDH3N332pqL4x9XDdiP89kAojMPyO08ARTOy
 ucKrpS1kTzCbn1ep9VZ+dF845WoMJYnA3AZ1w+fwUYghzpCOKy5nFq+YwtoGpo7Anhrppse7O+w
 Wze7yTTcVaunli6+v8ujYhVFtRNhP0iCuAmIc3uyBm8beGM/bo5NGkeEzW9NplpJXouWFtovSr8
 vx+pyZ3OQL8EEwjBdqlDcJbUMx19uQEmk5P7PW/Wix+jTShYL9StPJ4TLOTCHzB/3vnU1uWO4hy
 flICmsH/rF3DX8/tGqhf/k+7gS/87HEnJzeVQ62KXmNlltJ+AoB2QYjJ+f7x9AJRcTxoO+zYtD2
 POw5gh/QFaERfAKPQKH3AbwbOeH3EYRkUb6RBM6P7R0Bb0C5zdSs247YU1d7gfHgYPSGjVJczhB
 Kqo1Esyf/ltQ0ZepkMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270074
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 27/8/26 09:09, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> All allocation sites used g_new0() which zero-initializes fields.
> However share_handle must be SHAREABLE_NONE (-1 on Unix, NULL on
> Windows) and dmabuf_fd must be -1, not 0. Centralize allocation and
> field initialization in a single constructor to fix this and reduce
> code duplication.
> 
> This fixes -display dbus with virtio-gpu blob resources. The other
> end is currently receiving qemu fd 0.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-rutabaga.c | 20 +++++-------------
>   hw/display/virtio-gpu.c          | 35 +++++++++++++++++++++-----------
>   include/hw/virtio/virtio-gpu.h   |  4 ++++
>   3 files changed, 32 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

