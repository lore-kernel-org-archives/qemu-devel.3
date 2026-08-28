Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1431C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzqp3-0006x6-QP; Fri, 28 Aug 2026 03:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzqp2-0006wl-FS
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:16:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzqp0-0002Ly-S5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:16:20 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S66abF1520562
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I/OBV2qR/Dnuar0XWg/+/c9gtv9v3h1uZMH0PTJbcfo=; b=oXgCXCoQM5r+sgRT
 Z23jAzkyJjlEGWSKKrfX2axl/ixW0MWEGd7FzXOMHJyWdrKnT1Nbxrwzn692QLx/
 lbtCfQ1vby7PiCyjKfyzoCnsOFu5ybAf6P7kmsa4Tdx0EY5sMspLA6LWyBXg6QKu
 TjV4quYJv20zkCz51OXBgyy+owFzEm+p824rGLjEezL8g3DZs90zr56hxwsjKbxz
 LUJxmYgAVcvjrgG5ANITXhZwFrARQfh0QomlY6yIlTfwKYVU6jFHRaCvhUjWw0bl
 MoJmf2Md6V0EF9jKT8gK5YyiW7CbbYG3RCxN/WA2WiPh8OVIvVTEqHnj5nqmRqb7
 r99mWQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mu8h37-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:16:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5283df62d68so8717891cf.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787901376; x=1788506176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I/OBV2qR/Dnuar0XWg/+/c9gtv9v3h1uZMH0PTJbcfo=;
 b=GLIYXyB8oZupgvmfdC+awNIJju9z35Qtrz4odhp5Hgt991TGtyenr7BIzPAmvVT5KT
 o1FUAeG0yde5eX4NON8QalyMgRlSw+7VtzBig0at/dqX39JVQrXX5+hHkY1ghXTDGPN6
 fDTX2ftTdy7wCXSgwZ+2D+3L3NvwexGsUU2tOZS9H6hvvIUWXTSfiTFmC5s5x6QEh80F
 oX4Ox7wGRg6NZG8mvkJAoIdRILLf1n1QCSwZPbvZcd/fM58nDnfAqDPT6icxkFYUV41r
 7zML4DVPJFzkrpJHWm/hR8PUZekOF5u7ZsgM403Lp8F8hxfFkSof9NXiKPqZPfMLKXf6
 QwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787901376; x=1788506176;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I/OBV2qR/Dnuar0XWg/+/c9gtv9v3h1uZMH0PTJbcfo=;
 b=eiPmmwDUJnKQyWWpwQ8MrT+0M6XjViUJURjmhUt6ZhTeSIw3/qUip6Hnfol5QD2WiP
 U7R+mk7eyLSDg0tc2lpxeqwJMpSrMyhnYqJNEDNuzKndQvhZRKrzE8HyIXIWEfwvMStS
 /MpYYMpyPC5YUG0MIfO3nv4mNUI5Xcqoaue0/u16Bh2EJ7YzQZ9+mqwEBjV+7C2Ulrst
 kOgjx9xMCGf/7XX64WoULbyMdhdVdxcuuUIgoSmhshziKjELsJm7/owlbhxrrplJFDE5
 yoex0vB65gzlrzRYLPUp5usNDdPvbZzLAanIvRRlUxbnQ6lHt6mdU8N7TeKtKpmhH3hn
 BXjw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqyy0tyyWjo5pog7X+FFV9oAUqDjn60OwHkjzOemHWK04toNKM6DD34PXZj7OI/qmVwgUrdPnUZXvl/@nongnu.org
X-Gm-Message-State: AFuF++mBsv946Dx2suIyqykBZMELmerCVPD4T+NZJzU4v95uc6f6SmLz
 ylDm2XkBrA5x39v1zxX7dX/VTd7B0Ep//CwHTKuibkDjfmY4nMwrkTtmazHaw7ArVjWdpZavU20
 aAY71u66PBRcePbJUEFyj8bbuadPHk0aOd6YHw4DE9uHRSL1ABrjnmOayvw==
X-Gm-Gg: AR+sD12ArcYKtmPel7lwCQ1JLnxgSPnFT0v6kKgf0r26WoABBtkqWecGLnm2YkNEBEm
 01/+Z8DFTJYqOjnhlwI1f9GbjyPjBMPiXebXtdemnrdyHclCyM7XlBp8aQPgj1FJo57xi4Burgd
 bTUCRCWNcTHQ6mLqe2zgAft0ZgULRkyowRYE/IxxTOlTa6eDKTiAEx3avQcfPK663R1v3fD4Zvn
 o+2mxtrKu3oymRg7ZR4OZkRYWdsqu3kLOhjrb0xuSlKPAhwy7iQ6AI2YfXOqBsi3Ffy+/dN+ath
 /YYCRMHXnSnLjx4VLIArvywSdhrIczJnYhy1IZIILBllcNku0jks4DTW1Kil3hIS6HJ0nPEekA/
 6uQa664n7ka4Xc4uhnFajzKx+XAKAwMM6ZA==
X-Received: by 2002:a05:622a:40c:b0:51b:9878:8242 with SMTP id
 d75a77b69052e-52fb93b2fb3mr47257971cf.6.1787901376159; 
 Fri, 28 Aug 2026 00:16:16 -0700 (PDT)
X-Received: by 2002:a05:622a:40c:b0:51b:9878:8242 with SMTP id
 d75a77b69052e-52fb93b2fb3mr47257581cf.6.1787901375725; 
 Fri, 28 Aug 2026 00:16:15 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4e2c1af7sm108740365e9.15.2026.08.28.00.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 00:16:14 -0700 (PDT)
Message-ID: <b1102878-fbe3-4881-8d0c-a91c4425d462@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 09:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] hw/riscv/fdt-common: prepend helpers with
 "riscv_"
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Palmer Dabbelt <palmer@dabbelt.com>, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
 <20260827222608.329788-2-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260827222608.329788-2-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZbMt8MVA c=1 sm=1 tr=0 ts=6a9135c1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=GtS8KpC4QQmZ-MVVqrkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: GQWTaeqnG8DoFPJj9XSb-PnaDgSn3eMn
X-Proofpoint-GUID: GQWTaeqnG8DoFPJj9XSb-PnaDgSn3eMn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA2MSBTYWx0ZWRfX4/SKOss8/mG9
 jNkoPViZ6x7nlRah0ry3M+bQdY2A/5BJuNqaUGWuQwdzkJnliHKIPhLEointTuL+qDwh+st+JL1
 Ynqv0z9zODaEC4PyaBajVwJ5eHutRjY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA2MSBTYWx0ZWRfX7oifmaR56hz4
 gigVWZvnrvlzwH0kCI1n1JxFDNUWsevj9UVl9IxJA6ggx90UFo4W4k87HjRuhxO6ntqjTGQ2Ip7
 8ZrbnxBRFs00FUqp3aoQqSJL7NmPK6DPeUfoaZUK1jHkvQzMbjnzhoCsxoz09knxTo/uJa4ZRy6
 HNvWcGlNquXqz/UvvewAYXB3d9AFkBDLsg7nXLFufuZsV7rM2chpfNxD1+5FZ/ugqjcDyfaZ71w
 tLxfbSzAILvcPKci8VboczV22lg3G1eelXyAy+TDF/rIfEKrl3kJiiJ5aN0jNp/ccATEHl67OD0
 HXg9VkvdwznUO4v3YhXb5AboCRKavRd5XCzaS2goSPvQJy84Yeiw6jYKXfNmv9WDQ3QaWOMY/ks
 1d5PUm/h2BFveePjg2Tln09+ocSss+NAqQAvaEXKjL41earsGssVPujJBVQjaAn4TFY1bY5x9os
 eOWu4Crg//pXWKJjxAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280061
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

On 28/8/26 00:25, Daniel Henrique Barboza wrote:
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
> ---
>   hw/riscv/fdt-common.c         | 45 ++++++++++++++++----------------
>   hw/riscv/sifive_u.c           | 34 +++++++++++++------------
>   hw/riscv/spike.c              | 30 ++++++++++++----------
>   hw/riscv/tt_atlantis.c        | 22 ++++++++--------
>   hw/riscv/virt.c               | 42 +++++++++++++++---------------
>   include/hw/riscv/fdt-common.h | 48 ++++++++++++++++++-----------------
>   6 files changed, 117 insertions(+), 104 deletions(-)

Thank you!

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

