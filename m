Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09E0C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5Lj-0001dG-1A; Tue, 07 Jul 2026 08:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5Lh-0001cm-SB
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:56:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5Lf-0005Hx-Ul
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:56:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C935q3590171
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 12:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CNicinN0JC3gMw1nnn9/4RGSuWHnh1nQXkzNwy3uO3E=; b=A0HPNcAKZuOK8bKb
 kD5nut8gJi1lByj8e+jSnipV2GduvPaKpT8I9Es50Le+lHCIyTeu0GeZP4Ti+i5x
 JdpZlZTJMOusbZy7zsQPH/pCMTaTfExdOxgSQHpiQ7JLKlF2wul/y8qBjGCZYHr/
 MJrqhwWiH8kd+h5Wjor5AWwomIlFz+zTflGBJbHfaqivRrMXI3zsmjac0oO6JCsY
 3wnyJSumUcxqwv602rE1089hZO/oagstHuJHB69C1eZf5xlERovZWFPS7zr+S2Xu
 AvTSW+e1TCs/e998AqlXkxQSOsWHaumTeSqY4ZkhkKG+jWLGsgRTALxfO+oD/V2k
 SRKPtA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2u996q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 12:56:26 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8efe7db1c42so57388476d6.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783428986; x=1784033786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CNicinN0JC3gMw1nnn9/4RGSuWHnh1nQXkzNwy3uO3E=;
 b=CeSh07YryGWNXUCjL15X4ZYb1saihzm2rvjQnMZt2mkbyumW3qjTEdof1Ow7qYPaOn
 pWILieODt6nSlMVNqnAh3I2eWHz/4aeMNUSNjhQt4l1Ce5d2DbviA7gnOnqC68cfHeIl
 JhZM3pSRMMAM2Zlr9z0voBHHwf2H71/HYx9ZpXjN/uyq75dNEwKI9PfpjfYea/i52LgL
 2jUKKwQymr+oGO2n/kRHIt7BuH35wQoD4ZY83Ipbc+tRM57xl+J3FNiO05UrTx21o51G
 i86d+HYqGDaRbcjl+b93BBNGY6nWLz6SquTc/CE8BeY12TtcmGMSFSXg75Sft/GPLfEu
 i/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783428986; x=1784033786;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CNicinN0JC3gMw1nnn9/4RGSuWHnh1nQXkzNwy3uO3E=;
 b=SWzZklqfz1MnH2tOGzmpgB798wl3y+nAFR0kwam/31G1Y6vF0J+eYaikwgSEh7U1qO
 7XxWEIvQziA9lN9Zbb1bhZpS3SHKqpBk6IEhkqeX75C/RcZ+q+/L8KC5eMKsGEc7HZSG
 4+jr7Gi4+TyaLtVY9DhunfhPBeR/GLnpRLuHJ/fGgeao42eovtD7tiG17TT0K8h/IUl7
 f3Xa5xwRu9RoKHm6nSGEn0myFyAObToVppw1RadOtu1ziT5ZFKKSMCrZQCyoz4lW7J6O
 SB+2awTvGHv9Uf0woEc7bjLLqvAlKlkxgc/J5upnVfqnTQRUa5ty7BEAzhwRvufNHXUj
 NRwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RomCq6zvwqWsso70WdsmfHfJmbH+iuWgrqg86ND9B0z7KbJ9nHyigroIzgdxo3hxWkCMFjqbFaEJxmX@nongnu.org
X-Gm-Message-State: AOJu0YySmeaau0WtXPiE4M7xcW4axZ6eDyKkNsUoO4VfYjJaoD84J5R2
 zh7L2frg7+EMkNLO8xEk2SLPsvGTd6KLQPkItHrwDTnPlgstFlljF1E6mFXE7A325eesIuowYxV
 W2fFsNZc9aZsNzkEPvlXD8ZKQjmkW6Dh7D8J9XoYHpviuGOrp6+wqlrl4TQ==
X-Gm-Gg: AfdE7ckYltjSyJCk7QWbYWLjSakuA6rqZkJIFx9mzIIT64AXYUaxbX9nCZggIxQ7LoC
 jC18iJM4r6BGk/+R6doBuOFaQAUjGm2+1OU9LR6dXD0qwq54ockh7lpzK/JkimAF4rdrgRuKzVn
 Ceph0iar1H+HJSwRiMnh7GjCXtBgkEMsPWiriOm33n17C8BSLdm1oNR/oLKNWSZkQ2scrNM0H6x
 CXwbZlB1yuo9kwCbqYk9+igfO45hBC5yQJAi1ehQXEI7rg+VqX/Ug6QVS6ESomsyw2Czo8qdG4E
 kD+ArBITssMAD8pSmNWgpdJ6Fj7G8jdqWyxiK/ca7/9ql/CzK05jKusN+ZYPn8+V8Ekb9zg7bqx
 sMKuHOeRBMUPqQ7+ULG21WSLwS3zpIiKC5nNPVTRQBEilJYWPouTESMff+T5xOw==
X-Received: by 2002:a05:622a:147:b0:51c:8fb:fa44 with SMTP id
 d75a77b69052e-51c748816d3mr53329881cf.59.1783428985701; 
 Tue, 07 Jul 2026 05:56:25 -0700 (PDT)
X-Received: by 2002:a05:622a:147:b0:51c:8fb:fa44 with SMTP id
 d75a77b69052e-51c748816d3mr53329531cf.59.1783428985151; 
 Tue, 07 Jul 2026 05:56:25 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad9bfdccsm135459066b.36.2026.07.07.05.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 05:56:24 -0700 (PDT)
Message-ID: <7a3c8e51-cede-4e14-895c-ad8171cea0b7@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 14:56:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/sparc64/sun4u: Mark unusable PCI busses as full to
 ease device plugging
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20260309181452.83702-1-thuth@redhat.com>
 <00c4ab4b-a58b-4de4-8e41-566b2cb7f920@redhat.com>
 <124bd918-f2ab-43e2-bd2d-fc824de62c40@tls.msk.ru>
 <fcbe3d7f-64d4-4b13-b930-a81e77db4784@ilande.co.uk>
 <df7a091c-a8a1-416a-acf3-28a0cbd8dd2f@redhat.com>
 <c7d6b801-449e-4f55-9c1d-ebec7a0e9595@redhat.com>
 <0b79579f-d021-4e7f-9244-125c2bee0d6c@oss.qualcomm.com>
In-Reply-To: <0b79579f-d021-4e7f-9244-125c2bee0d6c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyNSBTYWx0ZWRfX7gCaP8Y/40ku
 31EGOI3YW0mkqcDSAMOpTJk6KynkOee4GNVLA/qG4R3lT92EcEQsJ5gmO5HBX0nRHvUQgQoa8/l
 uBHB1XyNhZk/B/H8tJPC3qSOdSrZ7rg=
X-Proofpoint-GUID: w2jEsGJ3rFZcQSl9PTI7Vr6EdrONL_34
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyNSBTYWx0ZWRfX7r59yetQdpHZ
 t0rwkCUMhJYJ7D2DsJQOVZqs32TRuyPK84XilI+RVtiRONMtXPQlWpjTXeZiJI0pNTFEPS7BRu7
 an9LSNpNcK+tCegJlXa1gV1txWyVv1rQO/lUZfvEqDliyqaRD90XThok9vNAECslkDZu5jxohSk
 oruGPLIQZHDpXwK2LjmYJykSeUx0Yp7/pwK/22tXrKcP5gCgc9nQ7OBnX48wa+QYd04F3iTJNOi
 iHHlkmTnCrG63ix/4OszZaO1mlINYarr6fTdzE+QRpKVbUqP0LM2tuimS+F8KlwpZpNpkTNcwWU
 LZh4HI7l4hMz0VVbH15VrxGcFTG6CK0HImR31Pf4BrzYRKppa7Iy5dP3Pa7B+24YybavdT6S977
 ioiIy+bD+iDG9ZRwyRWGTcWpWlivd4nZMNV8W5ES3zNY3sf+4igo2pm67jqNGiXmrSXCvsDtuCV
 3jsmGuxbjd3yPMuPPRg==
X-Proofpoint-ORIG-GUID: w2jEsGJ3rFZcQSl9PTI7Vr6EdrONL_34
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4cf77a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=P8dsoeSFSmiUCL4bGtQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070125
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

Hi Thomas,

On 29/6/26 16:56, Philippe Mathieu-DaudÃ© wrote:
> On 29/6/26 15:43, Thomas Huth wrote:
> 
>> While it's not urgent, soft-freeze date is in a week, so it would be 
>> nice to get this merged before it misses another release ... WDYT?
> 
> Queued via hw-misc, thanks!

I wanted to help with what appeared to be a trivial fix, but ended
putting myself into troubles for the soft-freeze day, so I'm going
to drop this patch. As Mark noticed, the issue can still be worked
on until the hard freeze.

Regards,

Phil.

