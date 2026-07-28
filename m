Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A49FC54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocP8-00015q-7T; Tue, 28 Jul 2026 03:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocP7-00015h-Ca
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:39:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocP5-0000Z7-Mv
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:39:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aibT1715002
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 024edsS39T7CLICZLBtSvGH2cFFPFwYCfGYVQz0br/o=; b=LVrCVABB+wYnN23i
 0RwqiqPlW52olg2NonBWmvq///1hrqp31/e0q3gSZT2tPAblqHu5G04Q6QSFWvfx
 F1ezjeukKpK/50UA0KbwgbPjziBhDKr8PId+E21G/Oi7h8Mc8erY/gl1m5GB1woQ
 Y5rhWxotxkWCcvLpyGma5nmELOqoXv/NFzCtk/ARVVITeAaaok8EYzNVRm1zTMtL
 w4K66T7dBSv00Xk2mkz9V0WeJt0F0VbkobwvAsvhmeutWO0D7jbxbwi2WWgbbues
 7t9CB7jJTTO4P+m4APf9Ez3Jbz5tUCkPn79ORrq8nuNrzBN3rDx0/QdAAvbM2vLd
 nLAMVg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkkkcx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:39:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d137a68so73610581cf.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 00:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785224345; x=1785829145; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=024edsS39T7CLICZLBtSvGH2cFFPFwYCfGYVQz0br/o=;
 b=iszY4JBlw2mBiNkD0H4KiAibTA89oYUvyiudqX5JYiDjHRvL2+x+20qjZbFJn9T9EF
 70FTAIs0CVrpK99yT/4+rdmQMF2oRXN/b1eWPQqsF1NpdiQVR6f+qZzVaRXC0J5lNUNE
 zMPKan0OLK1zIF2ztXEieBerOjGg8y5+mIQ8SQiglEuFlt/mSyRSKuvhdlpyMQnly4Ue
 M4Vh2oOZvEacs2FaNamemI1yML0CqwepCFqkHW7eJYBmws+o9MNB/hKfN4sMnXQFtVco
 8AdEgWUj7NH9bDkWWEdFr69lVfb4YzD9JKdJ785lYX3iNkk0ejVcpiWxq79ZPOulTpsm
 WRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785224345; x=1785829145;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=024edsS39T7CLICZLBtSvGH2cFFPFwYCfGYVQz0br/o=;
 b=Nehd5XzipEFjquacOETsR5N0k+jeT+qSd4h/a+ibxtfN1nr0Ed7feDVfZllTzk5Shq
 IV+IV1MAGV5QpbbTqeADJ48mgKr0yrwfA2vkHGQxIw/OmyRG+XAeahoR+zqgl91TgxTd
 89sgXid/npMXo8sdnyPOixg11zmdZy9QybOEdJ5HDdnp8A4hKp8GXa2yX5wK0PNnd4Ra
 ZOYAVDwzSDmQ0QE0GcLula4mRqOC8eZaYjnnxDFbsDKxiDiXBKhGoufRSyZCJJO1sQbT
 0u257kMkfjXK9UzMCq6iq8yhDN66kqLQ5gET77LfVvm6Ru2PIkDkTU0DjintNLIqWoqU
 5+pA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+64o+k+q95tv7E3HSzJSlGcziHBhX72CzbPv8QEUgJjVGL/2wrgt6eYvunsC/TG5/P3NyPztwkeHE@nongnu.org
X-Gm-Message-State: AOJu0YyO3UujCq4RNqSF5ga55FbII2IWKFM9cTsB9LOmd3oFkSdranea
 svykYuD2R5BNCC+GZmqjR+NHCuyLBiF7YMLgVjEQCt+iL/hWrSlpRqHTUJzviGndAO42/k4XGtV
 liMXZ+T/W5RHHkjEDuv/PzSnI7P2VIrXD+f2abmJGwJrpg7UfRGauQZqsSA==
X-Gm-Gg: AR+sD13yuO9nQpkvirffMHYwmEmyEND9d2DJjCIYmlZkqGEQd2i3o4IhRvWdOrPn2aF
 +5K4JIjVoPtgj3OqUmDDT0+aN3yUIZ7tKJK/o/qHbHWsSzR2l1RWluvwl5n4+fIcqLICCLlxmRn
 rYRSA5w5dUNezb9bO3emh4Wkc01qkTLHwbf4OgG62pdkZHQTxuPg2SRPT/+OawTuIPO1kmypGsH
 Yu/n+j8dnxqArpkthXofL2do4Wvuev/rFYhE/88I5BYzFhzwfnKWA/sCc7+WS2nvYWt03hQ35Ii
 aBXsFOJAIfGdxLszEhkfOiwltbi00vBD2h6G9z1H1wz4jBgkqx5zGDscOr1QWCcmBb3iEyPBv3n
 WyM6UjrU169yOVbn/AMEpXJXlywrAOf05er6M6DNBLl2ZKdH4bbE=
X-Received: by 2002:a05:622a:1193:b0:51c:9e2b:a79b with SMTP id
 d75a77b69052e-529d71064d2mr9658221cf.30.1785224344920; 
 Tue, 28 Jul 2026 00:39:04 -0700 (PDT)
X-Received: by 2002:a05:622a:1193:b0:51c:9e2b:a79b with SMTP id
 d75a77b69052e-529d71064d2mr9657921cf.30.1785224344417; 
 Tue, 28 Jul 2026 00:39:04 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb5127sm52598096f8f.10.2026.07.28.00.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 00:39:03 -0700 (PDT)
Message-ID: <2c415665-f86c-4640-b681-b5ee929ea184@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 09:39:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 060/103] scripts/probe-gdb-support.py: add mapping for
 mips architecture
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-61-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260728044248.137626-61-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bLD1OzyJX99hLCZ-ihSb_QZhRUvTad5i
X-Proofpoint-GUID: bLD1OzyJX99hLCZ-ihSb_QZhRUvTad5i
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a685c99 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=2oAYApyDA2SyNJB_3PYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2NCBTYWx0ZWRfXyzpEjvho5fbB
 lKMX/qvaS3JRt21dyN17CKnqULVQdaCJbtRjHIhCJ5m/QXb53Dqw+qyMnNh+Iw0UWg6/oAYevg+
 dMIZVSecSn1OmCcIc5uAbrNAJyIDSV24Ue3c8nIkm0MbewSjRvpme44gPpsdPuXErCRFkU/57Sm
 tdspwfLICGGeFT3RinzDkKS+EqoDCyB6Vk0Oen7jMbWesPG5qSDB3N+cVFZrv1vESAhHdDhlTFT
 hD0FsNrZhl1xlWLKOcs4Xwa9nJCc2ktg2T8zV+qi4XcsBeQ5Bdxat3gdPoxCl55iCsRhH6Qjyxi
 kt1AdqsSfMU1tvGFm2Ldvzk1j+Ge0rh2V1ShJ28Rpmp8BYJxaAgDuKy3FAUqDoevFRrVzod97k8
 yKk9mc182WejViHUwcsb7hlPdL+8RLvTkAuBK0RJWNbEIyLbF2zRjkN6Z5n+03jk3mGpLDq6ZCE
 zIKoh/ufpNHjm6qF8ng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2NCBTYWx0ZWRfX777SVTKmfe6K
 pRCTcizGWJ6aLoJgWBnPhKtk7GqZG5KqgKu3cIqwzeF8VFnQiw8qID2ZaO3euLnv/4eXgln/UX8
 84uDwmDYrMbsctW5XVoxsbjXZuYWlW4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280064
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

On 28/7/26 06:42, Pierrick Bouvier wrote:
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   scripts/probe-gdb-support.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
> index 43c70302873..6e3b2579770 100644
> --- a/scripts/probe-gdb-support.py
> +++ b/scripts/probe-gdb-support.py
> @@ -35,6 +35,7 @@
>       "Loongarch64" : ["loongarch64"],
>       "m68k" : ["m68k"],
>       "MicroBlaze" : ["microblaze"],
> +    "mips" : ["mips"],

IIUC we want (for still few releases):

        "mips" : ["mips", "mipsel"],

>       "mips:isa64" : ["mips64", "mips64el"],
>       "or1k" : ["or1k"],
>       "powerpc:common" : ["ppc"],


