Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998F1CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEP2r-0008FJ-Rs; Wed, 07 Oct 2026 06:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEP2l-0008DT-Qh
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:38:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEP2k-0007zF-BG
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:38:39 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jeta119490
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 10:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S/jMN84BbNEg9gZKA9tCtKcPgGCUe69FH2FfKgWcd/Y=; b=YKNaQtnrK+2Cq1EH
 Bdl0c6qr2f+8VcY449yPwjsM7n35wQTZWr1OtNZxVTwT2R81S2GuUmLgg82OZYwQ
 dcdJaFyDg/6tUrJZ6HzABHxtjZbaaH99x3JbmlI0AwSSHeNFIe/eBhmebZcBUq3m
 b6bRcPiJwflubakvVvPhhQKRjt6ZoMFet+b+ZqdsOBuQ7DuANT8yq77K6oFcjq7U
 OkP/cFVJpxf/KhBUvRff3UktF2lWMQifKf6YZ6RK6PS0oHtWEe9EcN26NXCBrjCu
 m3vnUXnvrzpYUP+SLE8ze0ZioQy3tt65DwkpENLjNCzsK9yWw7nvQusqH9LJTHUG
 FVrZ2A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc5928g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 10:38:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93bf4c0af4eso600604785a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 03:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791369515; x=1791974315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S/jMN84BbNEg9gZKA9tCtKcPgGCUe69FH2FfKgWcd/Y=;
 b=AxVN/uPFR3h4aL148f0dVRow3bQGHe1FO3wRx8P+B9Ang9lY8apMsd1niW0e+d6Uhk
 Y2x3x7X2P95v1ZlNXqjPekB8Sy/zfBgyfe/qGFfRI+R9+5yn6OWykdAPO2VVnVPfNwKN
 SVApdV2EVpZncDra7jd7T9omnExXvc2epWi9pqY9nydGUijttyrc5Im91hvj4Y7Y05fl
 i31OHSHdIHzpZSI9dxVasTQNe+USnUGLK9EjPY62L25ku62CFeoOA4HwXrFyocHaxiWQ
 fzWgy1lXVzxAHgFHFaQJoy22xOwK2dHJhQUD7ext8uHo0SzASrKSfALZk3ULUyobA56u
 zwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791369515; x=1791974315;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S/jMN84BbNEg9gZKA9tCtKcPgGCUe69FH2FfKgWcd/Y=;
 b=IuzKGrJ8apmrDylw1WDDyivTA7HFLtSwsySLDahfrHAcI/wv//592y3BweARimhbV7
 pyGKZaY3AfOYRMb+97ykSbnyHLOJs1EVt6780GMhYZZATQnLGEF2RrRSymC978DdDtKO
 JyMm+fvjkAYmvd2MihRTIhc7xJQN/DKNqSqMnCyEh8DIwNteI3rlP0HE/DJ9xZl/ep0E
 /RBAgo28tmeXpyYR/Y2p42FA15m64yLnT7HatnRoHL4fzuKKHHpaY6NNA+rh9FIqxoGW
 SiFcViVEQ7vj1j2mz95YlIt3NBfOscH4Umu2BPcU6ZbNunrb1jeMTVX3q5FSJpjox/hg
 pD3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0r9JjboHLbhHCJDowEWxD3Ovpjsv8fbvtf2KWTW/DrzJvPs97att8qWZB2XNCF6muR+F6Pep506iQ@nongnu.org
X-Gm-Message-State: AFuF++m/VOnAdoaFYzMdEMj2O3jBubpjj23EDv5yXP5uXHVoISYaum6d
 mn2g/fHcz2O0l+88qYBfo/owzxtd5gsoUTErPTcDXjxKiiJy4YpjP9tJIjdain4KmugtTlLd2po
 j+c03jr8LrTeofzNwKH/qITFQwECowa3rZG3YCY/CcnR4b7cERO3O6OGRbw==
X-Gm-Gg: AYBFou0ZsUBXtWseg++PwzI0CyuOy0MjUKj/GVVtrBBuLiKzrRQMJUoqtLFuCPhvKZh
 kqthXK2puI6GB00Suai+1oSOKoZXHIyyZJiAopeR5RxVMKpsAdA2j06TAaOo5R1C1iBIqZXUK6e
 iv3Ww3sN+9cKbedReuS3ky5CjxrgzeWmQ8sWED3PJ1wzcF/WBdWoZabMtxiAQuek6vCdPAY/cXz
 ahq6cGKur6ikHHMVe2NY4yThW1i4fdUSjXpgEmJS5ooycJu3HAjyMRCm+iBZtpuioaVj6M0I6O6
 oRLVJsKqSoVRbxE4SxCQnB3MlwPLml4bxtDGZXpGk4Y5SiBYcp9+ry4j46WWRipUrLivCghrpRe
 UWJI6hM2IZXAZ7RioYC4Ea0o0tW2ENVyOTg==
X-Received: by 2002:a05:620a:711c:b0:93e:5de7:fd45 with SMTP id
 af79cd13be357-93e8605d700mr1061876985a.18.1791369515500; 
 Wed, 07 Oct 2026 03:38:35 -0700 (PDT)
X-Received: by 2002:a05:620a:711c:b0:93e:5de7:fd45 with SMTP id
 af79cd13be357-93e8605d700mr1061874285a.18.1791369515077; 
 Wed, 07 Oct 2026 03:38:35 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d3d3eesm5371469f8f.53.2026.10.07.03.38.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 03:38:24 -0700 (PDT)
Message-ID: <694bf39e-dd42-4051-a41e-618506ca8b75@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:38:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/18] target/riscv: Compile riscv-qmp-cmds.c once
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, luoyonggang@gmail.com
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-13-8a2f0f296a7f@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261007-rv-dedup-v2-13-8a2f0f296a7f@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX+HnmrokV+/Rf
 8UCbV3g+GZKwBBN9xBX7EoksJfJuu68WNBlCC3o/4LPYHoUUYyquOe2BahQQDsEpsCiH6oxOANT
 TatFTGwrfOGbaLnL96KBessH0rfyPOg=
X-Proofpoint-GUID: dsWTJ0uxXOWWsPATbVF72R7PwGHkPeAb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX4npC/VLK3Tae
 x/UrvoK2yi32aoBAG2zbVe4leDqAyJxjEQhUCb+HZUWmRi5rFTb7fn3UsEFgEZRrYIcdnb5cSPj
 GYVZ8k5VHaGv8z7+DW7NbB3hgbF5KMBKNTt/Cl4ZPFmN5j7JEinByQMgNu62YQDH2kXiTMdOb1d
 0I+M1XMn9ZNNqHQla2ehp0Nu95TdVM/fDu79dN/THeH7RChSBooSsIlaYZimIlygvY0s+9MrS3X
 wctv3d8NNWpXjkTwdNmDpo8HcWx10Jz9Ont/jraJ+tvook65FVeKfw8zx2qSN5GnaX12JltW4+5
 jDcfLnkd92CUByoNg4zqACMleba+1rL6pD8m277a9xb7PEzx73bSVPkGlqSv4K8W39WT0w4CJAB
 yauJ1yTIxa7m9B1VHErkm9E/V9+JSHwIYp7cUkTRNHFBT6CYgIpPVHR5Msh/a5yxMXCCaTUusPn
 NxM4Ouh0QZfh8DmthtA==
X-Proofpoint-ORIG-GUID: dsWTJ0uxXOWWsPATbVF72R7PwGHkPeAb
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac6212c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=nFgamq1sSFmvarFgJzkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070042
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

On 7/10/26 10:43, Anton Johansson via qemu development wrote:
> File is already agnostic to target specifics at this point.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

