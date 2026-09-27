Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C022EC9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqt7-0003y7-BV; Sun, 27 Sep 2026 11:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqt5-0003ss-6X
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:33:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqt3-0002Gj-OS
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:33:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R1XuTT1908997
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=; b=CdB/RRoofXXEBJyL
 aRopvTQysca1BM9BLA+mUMr0qjq3L/zOOtrDNkR8ymhJMlQge9H5pPjrtI9lVkqr
 jiTaujvkbed6XiKtOmqS/56JnUhCbmfnuKohJlqKDbD8BnQx3NnaAZAspNQvTe4C
 WTRcjiX3/LH84Q7Fazyv3Ndvgpj8BT7xj1PleAmxEu8oX1dcuiM2uzEiT6X0XhK1
 VDxjdx4J+AUxUvaN8JPUjI9bf0VdNLY62Gz+Q6bA/MGPmtwuKvCtXu/THj40tV9N
 WmK1ud2DBgVY0DlESJilruiu+P3PauULorEMrHK0FC4gr/IokYKhqj1Mc6cvCxdz
 UtiApQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mwb7vx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:33:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a0c7126e7so434098585a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790523236; x=1791128036; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=j9HUehkAiEZL3bQMDxgjGDwj8NS9+KTATt/GbR5vuH5KvAxsGmaCk7oxp7ghE5aFx8
 xOCnQ6u60jZhuzvWj1OoupQxCcTAugS+sl3b+zY98SFhZRoPkMtVVuAgRMK3U8mZVLGZ
 Z0IMTsQmoygvRO7Iwew8BZZUeOPP14ieVgiYZZmTWzBDXvznIbGBdyYPs4GK1z9/Nv4N
 d8cMPdcdtFh6w5rSVJnyOcqQzQBunrvkSKkniM0lwLSjAks2k+yBVAe3S6e2euMiN1ow
 q0tZR/g6U4YIEfFgOFI+BTBHcmzo4/ohVuz04OulmWRl1WQmqlmXf/8Pp9YZSAHaFU5u
 JHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523236; x=1791128036;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=zu2kXU6sie95trrhkmHA7k9525e7BWnSgvp6KZaspfYAVZkMRnyA7LG2ZBtnJ1yUi/
 PH+8Vq45wqZCpZWtpKkh68URknpK4OHeEgEJ5V/YU9Y4kaNxw2n6kIzjE0MVbAFJLao1
 r0BDkNRXM/Phb7Ank5Oc9wnupYKrBJ06jojBxc6Sb6LfMfqOitt//liTCFBbPRddBxJm
 vEQin28PtS62XOJUUSFPveSl25NhP2Eok/xDA2bFqtijvzpWHpsjot3ouTWTA9x557cJ
 vRb3a+XhgTdlrZ0PYsHgbfkSuMIe3y1N33/zpFp4hmP7vHEcQkuOIfj+ou4x/b2XFw8E
 Z+fQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7viYEGQ4XwKoMu4r2bazOpPnJvPgySrh6gFDoTcp5GV5V3tSCaNNh88ZL5TFYcj2T94W3yTZfOJbF@nongnu.org
X-Gm-Message-State: AFuF++li0l4VsjNqblIMMomtajWNlGDC+GqbFHFj+o7/mroPbmF1Cac8
 jvjEjYp4/C/EdncuhSsy/uZtoA8dI/Ex2ABufO6149TpZ/b7YG90e0Si35E2z1rBmy1awifjjSQ
 WFRlGTJj47BINBq0RUytYgCKI3c1zxfD6n3rfMBGRR3+z4xqkE7AnS8wiAg==
X-Gm-Gg: AYBFou2Lr2kKoEnwYuriEKoAbBZJ5ltvEzYJBXuuADEWedmycumUC3Em15kgNqS8bOn
 lHpCDxqyqnIk/cvln7zKag+H7z+fd5AVQI7DZxvBRxM7rhwaAeiZ2PoSPqsf1Yi6Jb27UcRz66p
 cteB2oMNBCHETgj8Ugwos9GG8KBzV9CMyg7aM152Sbo2khfW1UPTyhQq5n3Jskajx2FlvO/lgx3
 mv8HksOQMf/HHDxcounPXicv5yV0h6mv3Hr3zYF6J62TgS861V9mcZ9bpwxKwM8kj3j95EfbwpJ
 mbSLP2zdufiusDckFsfXAW+pM5qRvee95JKWF+GmP52ltKDlyVtGyBh2sgMsAn1sGUoa3DqW5Nv
 lOcKwSktVjAxNo/NMoqB/nn371wq50aOhQA==
X-Received: by 2002:a05:620a:271d:b0:939:7fc4:fb1a with SMTP id
 af79cd13be357-93c43bf2684mr1419146885a.27.1790523236181; 
 Sun, 27 Sep 2026 08:33:56 -0700 (PDT)
X-Received: by 2002:a05:620a:271d:b0:939:7fc4:fb1a with SMTP id
 af79cd13be357-93c43bf2684mr1419142985a.27.1790523235785; 
 Sun, 27 Sep 2026 08:33:55 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f1375sm60439485e9.8.2026.09.27.08.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:33:55 -0700 (PDT)
Message-ID: <5059f277-db6c-4d55-a3f7-b36e1f84997a@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 020/101] tcg: Generic expansion of tcg_gen_xor_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-21-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MNnOK0f8_OH55EGUT5RROLClJ-aqGrFP
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab93764 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MNnOK0f8_OH55EGUT5RROLClJ-aqGrFP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX0D2/lauSOvlk
 Cad5MbhwesMR9syKgYfM2n5P62KLRFBVWxuEpUJ+T7w2buk7Nf7bARkzcWCxhSGJzYNFfuaw4VN
 dw1goU36CL8h/6tKp2+Yi9gz9sR2Nxl6ekR2FweYmdUaJSnj98eHx3c02VTjPBfa4+ZVmaYCbg/
 ARVtCmw0UDoxyPatgDipofDh99qhT3A3hmr+Kyc5lt01s77jmxofML0mD3KlAKnbC2Dkb64c+CX
 OZfehdSS6DD5fqdPXqawjK8di7LARtbr134eT/FkIqdYl+yCiypa5oxxM9uYgtKYAem+f6FIlwF
 nCRYbtXBlGuP3vMCzp5xGwz5XT9XARhw+IPWqCKs/oQrq8/jHATy05vt9xv8KNK21PzlpedU4BO
 5v8fcm3wWnvnjZYtdk+JY0FzBQHn4kvVRey/nLYsO/Il5OQ/zIzK6BcWldesoc9Pi6DQ72EK7SA
 gWhMOw4nmI15Rw080DA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfXxsHg6my726hj
 Nt5w34M6yVIsoYhEbNXRLCezyOTo6ZzrA/yFlRU/xrNm5z2jpkhWJarp6PYTVJqmoI9t7IRPZSE
 zwDFTK2egILZ7JKnfum7zne7SFWb9QU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270061
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

