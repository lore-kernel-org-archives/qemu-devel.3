Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B3EC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1nlh-0002d1-Ph; Wed, 02 Sep 2026 12:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1nlg-0002cs-FY
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:24:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1nle-0005Yd-Db
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:24:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682FZ4Rl1284894
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 16:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NT7fsWn7WkRi3MBOpJK/+nI5I/HXhNLNG7oqjX/+H+s=; b=Abb6y0MimzzBCyG0
 EY28Bfk9yZ4npWX6dIootTEz0qepCroIGBtTF+Q+B+95C9BJgjeZJAHGHhC0ktL4
 i58CuWs6RFmLFz0+dj2eBMTz20M0o8hsjgSeNw6GTuVLKDwz6FptEd8nfqPXPT5o
 44H8OArCKWD7w54XoMs4Pyr1BahTepQC+q21ZZruLXSurLmjN41/cLvgBDAF0nmx
 2UqT+xfiu2+cOPhevQqG4suJ7KrRSUnp92oIz/KFcQpFN/fm86DcvpLNUGAIQ/YA
 +EpX7dNZG1DYFK3nSz6TDASKA81I2iI1aO35rpQSDWp/xG0pwSPmvmzVn6yvpXGV
 /hiubQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemb00sdh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 16:24:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e820609d9so262017285a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788366291; x=1788971091; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NT7fsWn7WkRi3MBOpJK/+nI5I/HXhNLNG7oqjX/+H+s=;
 b=KIzx4Tb75palXcY6lNSgzkFsfbgFVKtkUNYdI2E3MkfHwuy49alePDx16SEl+LL7Lu
 YL8vWF15h0gUix1QRdgo7h34/+geYMRGuqeNtRG2Hh2qkUzIoMs5Lrmn5c6UPk+0X1T9
 8QhU4RF3wmm9YI5XqQaHmHXhCSvOK7mUrDPjqfi0c9L0m6OHYXSzrywF6iGKrSxhIZDT
 fag/yUL2S/RVnwADhQ4KR00dc0MVJYF1P11pH9HMxgzNcr0Jvyt22OCm8T5Qc1XvDeKV
 ZRny7E+U7NL/nCCtOOJqXNsSRIG/F6wlITMR7M/dvcEhnJoWIuNuWzyAizAnmjM5dKr4
 P0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788366291; x=1788971091;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NT7fsWn7WkRi3MBOpJK/+nI5I/HXhNLNG7oqjX/+H+s=;
 b=eznX9BNTLbTwwr6tYZOcMLY5vNXEvkHNAJuo9Jcw9D4xBIarwsi4oz2LHsvEsU0F7J
 FDIXkWAYlQG4HLTHGwaqRw9tIWhuyzIZWXEkg4GIkiHyQfBJOnbmaV4rd/k4Xz/wZEjq
 mHHA/d/YjenThzfWwq2Z0B1uGAWV2LtLE80Vp9MmZodOVNObSEm1VAPKWt+Ayc/Pz5Jn
 WU31/eXjCdl8tIYjfpjrVQyoHm8/59elcbkWExqQxiP8DvzwXonfs9YTzfVxV1jnzGli
 OkvmQbox5UvzqTBcTl7Yu0ZQxTLg7o2IKAsGiGRKnmukmrnbzeuoGWKoW64FZm4pOgJI
 ky2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHgI+PhS0WigpDjV3Q/k8FKR+gtY3fOEi2Pw7k8KtKDE90Xevw5u53vg4qlL/Wk6HM3yFY4z2XOVtJ@nongnu.org
X-Gm-Message-State: AFuF++m8ml5qCZeLXlo+2WPTSWnPAQI33gWDOVZTdejxjnBWadJSlyC4
 3T+myYLVhLWMcSgcL1ioy8HU807TaEFxml64tmegyLwcPXGZ5OWZ+9TWeR912e0CccexDqCYVJm
 nXvy2L59yXTqHaaIb8rJQX+Fap6Ek6IgtqN6yZb5+b90vljSoBOTZaUkCZg==
X-Gm-Gg: AR+sD13a37+BRIT9Y2ZrijdSNJRCUOnFENZeIXs1O5/WZsduM5MTeTkWbsaIsXwQgQu
 9prZJL2R/C2zukmRpK1K2SgydNwGs978WosiF5BlJerZuhy2f36WhIn76drmMPDlfUic3AIwZco
 gIhmEQ+ZPaC9xV9Lpzs4mSuGiaGOOqZSgjXIuo5uas1t3CI3qvo8X5valfbRjSb6Ea+UsJIlDyh
 NRaLRsla1a6SG66R6qnDMDJPfbgZel3H6LU2hBL1igovy8QrDuI+ogA0CUwvBr/c3LbfYQZsQ0S
 FAJgYb+9HsiwoS1hV/1nvVrMxARqG3k7BAWqXMSP0sT0RCKDVWtE9E+qFoCTMDMNSH4ArhkD6sD
 4EH1ZIOBEBlgUYfnVDO1aAIXg7h7xgT6wdQ==
X-Received: by 2002:a05:620a:bd4:b0:939:4a30:975b with SMTP id
 af79cd13be357-93960de7f8emr767809585a.14.1788366291182; 
 Wed, 02 Sep 2026 09:24:51 -0700 (PDT)
X-Received: by 2002:a05:620a:bd4:b0:939:4a30:975b with SMTP id
 af79cd13be357-93960de7f8emr767803785a.14.1788366290780; 
 Wed, 02 Sep 2026 09:24:50 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eeae34sm7797182f8f.32.2026.09.02.09.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 09:24:49 -0700 (PDT)
Message-ID: <cf4a29e2-20e7-4b03-a5d9-e8b0e39f44d4@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 18:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/15] hw/riscv/fdt-common: prepend helpers with
 "riscv_"
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Palmer Dabbelt <palmer@dabbelt.com>, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-2-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828203918.350131-2-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aa0hEC7SJoWsuHfhb0Wsqpi80wi02vCL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NCBTYWx0ZWRfXxCW1tKjgL7oe
 EqGF30kPM3VMoRs1LFjQdXMpxiPETeaibFFen0GdnZIMU7dDO/hcApYIpHk28q9S/FSWz0gD3aO
 KOHWxLhsF6PT5VgbykSKW9Kj6mnghSoMeghobS4dJdWB0NvVCdr3xFdxFxbzsq6z4hN1YKvV5cP
 HrsS1ydlyV9RsNiTzxEAQC8lkUByMP2LI3xC5wIluw+q1k1K3pfw90rKOGeC+0Dw/IFvHnz70x+
 2qpWqdwXsC+MEMv7gK3QoEFJayRhpEbKHQ8xRX5GeXYVEXood/xMh5fQCEz3CZ5GVDCsNxvY6Uf
 TeXfJ3Cwl3y3AqpV676znLGbMzZMPU6AVLoRLnHW6aVo9GtsOxmPFlD2jDJL5lJZhVh79DRU2EW
 H91p5mW1fJmpcm2yAB8bRfvhNxECQk5LoPZkR9umDetfjibrfKOw4ViYWUI252V32ZL92UFtMyr
 9G0gGl7Myxjgxu7EpAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NCBTYWx0ZWRfX4cS1PzJQZnXE
 EPt5QbzWgN9+78GIHSjMFYdJ+SUgQRj3u580Zmxtei9nZ92fLXDRxaLTAvF+Uwd2Tv+msmFbqqO
 i/89d9N2lfmYij/Z/c7CB8FL0tBb2jQ=
X-Authority-Analysis: v=2.4 cv=EuPiaycA c=1 sm=1 tr=0 ts=6a984dd4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8
 a=GtS8KpC4QQmZ-MVVqrkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: aa0hEC7SJoWsuHfhb0Wsqpi80wi02vCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020144
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

Hi Daniel,

On 28/8/26 22:39, Daniel Henrique Barboza wrote:
> Given that the helpers are public API we should prefix them with
> "riscv_" to avoid conflicts when linking with different targets in the
> future, i.e. we should not use generic names like
> "create_fdt_socket_memory".
> 
> Despite the amount of lines this is a mechanical change and no real
> FDT changes are intended.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   hw/riscv/fdt-common.c         | 45 ++++++++++++++++----------------
>   hw/riscv/sifive_u.c           | 34 +++++++++++++------------
>   hw/riscv/spike.c              | 30 ++++++++++++----------
>   hw/riscv/tt_atlantis.c        | 22 ++++++++--------
>   hw/riscv/virt.c               | 42 +++++++++++++++---------------
>   include/hw/riscv/fdt-common.h | 48 ++++++++++++++++++-----------------
>   6 files changed, 117 insertions(+), 104 deletions(-)

I had the following patch tagged but it will conflict with your
series which is apparently ready (and at v5):
https://lore.kernel.org/qemu-devel/20260823150731.896-6-luoyonggang@gmail.com/
I'll let see with Yonggang what is the simpler (likely have
his patch rebased once your series is merged).

Regards,

Phil.

