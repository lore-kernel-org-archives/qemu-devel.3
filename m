Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E37C98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqty-0004zK-VZ; Sun, 27 Sep 2026 11:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqtw-0004z4-SA
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:34:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqtv-0002LQ-7Y
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:34:52 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QNr1WY3993216
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=; b=XpXg+Nx3+RP8HodQ
 GN7nBxYe8y7zfFPk/sRbu0yiOS6+03imWs2O3Zpo8zd+s2hDrzYK8T5LJZEWA2eo
 3goTnKdsqlio9qEzNh5SRSI221LrjGmZiFETPWEjq+asU50PviCVgNaNeQe3wAar
 Mxbc//LZOpUfBHe+qu3WDlu1ObcozW11cE2HbyJyQaiRq552DHXt9aTZDsAPnVmg
 xDMhlzmE/16F07WnXGowXghqT/GINRkPyttIbMxAqIF6A5uZ2hG9LExi2OIjUg+c
 kxuAxTJLe6ytNauGAIald0jYLLxYvhXM68v6iN1X2X/twX3htBiLzLqEz9x/j6Ia
 jNSsBg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77ju347-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:34:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93909014c85so482226985a.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790523288; x=1791128088; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=D1ofdegZHsBFajfAqYkTaDw14SuqMstYAKyuLHafI0kqr9KhfyfB009i0GwPbB2/Kg
 65Yf2au5uZ9gcpreqBzr3xpFmllmbKKaAWmhOylrt6vPCA7188o/XcAHl0bh9aWC1NvI
 ZZBwg/BIlwnXGh1T+1bT1pHWYIIzcpjXnqlPTAaykeUrNHtszB/wOxP1r0NkzEXNo4zN
 WcYGVUche8wZhE1o5w3JGEJsl4d8b6yDJe/bCUMVumin/+oI5agn6ucrKoACJIBZDvmG
 KA/WvKi4IWChe+h5hVi+LFH7ie2dUdYFMOQFEKpIhb31+cRrL4n66gXG7D68ipLq/8MV
 5tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523288; x=1791128088;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=drAxq+lzCFNgXL9nmMRBQMQ7d8DpSQtAJCR9YZ7zuc5y3x+ppYbfq/7HO48vA4g9yV
 vuZqrJoktKjtWXGhBEdoW0e0KXuheFKfYyPOhFSZQKWOwiZ2fqy1lgzRgNRkNwGcfZyj
 mKWHu19QZaOCSRi7He3bWuSKOPFm1yKqXrRE9jOBnAGJmfU9STpOWq+2VtXmkUvROnAV
 fvATL4FAT4EsvIC3nmKq2uv0MLARgBU/LrPf5TLmMQOalpfcXy8Cmpu7IZgLJtMXt1xY
 q/9W8KwqxLYcgCW0EUJlhDOxFWERMZ8H8W2woPIQsDukj1bXGIOKxKTkrQYri281cL5a
 2kAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZ+T3B01PrH1Tj8FX5857BSBelaY/dUDEZC0KCsDcA8H2VmKFeJv49/rJNNpCd76ZOhKLD8HagVJvH@nongnu.org
X-Gm-Message-State: AFuF++m9lKYCuNpo9Ktd0IMVKlIm1Fr8GBuZXcXnKBJSRm3KfPX2qQla
 O9oO+AoPQ3EV7/OipZHIRUf7Cwz5mF9f84LUqiUX10SaNVTEkFJPha7DE8S+UrZdqnk7cbQ6NFp
 3u+YzZ5esM8aHzVISCDxL2wo3e5OBtqjZtVJ2BZzxyQinUtemKWPrvwA95w==
X-Gm-Gg: AYBFou1fWnYuKbdyAagjb/Ifsla+IrG0PXOnN148NwlPc15T7RM8V4FQ52SYilJjE0m
 ofEp7ipXY/wZwYXhgVfTkFvKqmOcaMZVtUW4aggVFKrT4jNRyGAwv7/iy0qp4th6aFwI0oOgfc7
 fpY6pEs3eF5iUEWdXcvAV0NHWiMyr0Rwxaa9fJUK7umFsOm4DOv4bJ12CjCQk5sJZuapNXuTPxG
 yx7Kdjsho1zQQ7kqkFEzHBGLsN1Yj4YU/Wa3dqXJnaNaTEgRDvYeZWtAsw2/FTZAAlo/bQVRGNQ
 jtTvpG6TP6D3lWrSgBdnAgdTWvDQ95sRK6js1O4NxQ6X6ZaQmVQ/bfvLQL4ZVToRhF+0cxiW8ms
 pqbtdcFFDZJiohyAw0Npht+XXTVlfJRzETA==
X-Received: by 2002:a05:620a:1d0a:b0:93c:68f0:f098 with SMTP id
 af79cd13be357-93c68f113e2mr542376885a.20.1790523287749; 
 Sun, 27 Sep 2026 08:34:47 -0700 (PDT)
X-Received: by 2002:a05:620a:1d0a:b0:93c:68f0:f098 with SMTP id
 af79cd13be357-93c68f113e2mr542372485a.20.1790523287194; 
 Sun, 27 Sep 2026 08:34:47 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a3627a8sm23014137f8f.23.2026.09.27.08.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:34:46 -0700 (PDT)
Message-ID: <1f63e0d2-9081-4a13-9cf3-a03df3301da1@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:34:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 021/101] tcg: Generic expansion of tcg_gen_shl_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MiBTYWx0ZWRfX38BzIl8Qqhxz
 kin0o0IYI8hSgrQQ10Lu+VFcOHr96QvHqa2a7LOMhDcAn+gFj+2fJQewB4EU4b6y7gCzCbJEXvU
 IbqMjXmCJrQW0ObRwD42Kf4Q0TABDzg=
X-Proofpoint-GUID: StefqmlhAdJGwkD04qyz6pz8TFpt28V6
X-Proofpoint-ORIG-GUID: StefqmlhAdJGwkD04qyz6pz8TFpt28V6
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab93798 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MiBTYWx0ZWRfX0h+11/cg+5qh
 LRZ+kOW+QWeYTTy+dPB0pvB1twrOwB6+t1T64kkt6IN7c4NS9IC9aSQ1is6GLb+Qstnlvo59t70
 zYr0tGT6Xnv8Dzbymg7RKcPRJeOGac5lOyehMAbYuJFohSaW7nuA9C7PqnBwZWQo0lm20KMhtyT
 T47JV3YMy29K2iKwazVXiJ1ACJqzJMagQEEOp9OfAuJZy5EXGQsnB3gFPbUu5FykJCQP5WOm2Z+
 ehOxLyhZGgBuNpQ9FRKDKxtw9gteqTgaWmWqclrswEYyyoZURhcPTIRfhIDlz1aH4LYwwlGXnkW
 xnr9sa9iXx8DJ1lM7yZPsyNLmBIKmNMOu5bbLhef34IvhhPd9/l7AZjoZMelTbpb5ddBfuzkoZq
 aWv6zVxkigc4n3P4AFrV/t1HnZVIrAtX75C1/uORb2oNjcfuAR1jz1Ij7V1RAkm2fYmnYQmhxdS
 dtgcZ2K/vO9IyhjnOXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270062
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 15 +++++----------
>   3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

