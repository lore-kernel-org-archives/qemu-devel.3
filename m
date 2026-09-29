Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44429C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZJe-0004Ys-3h; Tue, 29 Sep 2026 11:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBZJU-0004Vo-UQ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:00:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBZJS-00050p-5Z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:00:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCqlag350194
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 15:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oC6ycxct5evGf7msqSYvksrjwR+3Ojl2H7PIOG3pGA4=; b=I3uoVswzPOAVm45U
 TySoSv+ewy4ebXsFI5kGIvjFmCG2aGKTapyARHykhPziLI1dvgeJCBMgbQJM637F
 YgCVPCaEM6MRsSMgoOzaAlkb4kcLRvAIDqpP8VnjmjZP5RYb//VVIaXwT5T2jKw0
 It0z1aq+EjF4HubqI0tWmdcikjGL6pjh4EEpZO3YEFLxIc6NSdwUVNBwaBiVM8kt
 zRHFLdSyOFa98HPyUmNzIL2Gf440igV6CKRnLbOjy5SyLdTScKTRnef5n7WP7nf7
 0ycKhQRwT7HvGPWkaAOdQFUGagb073o7Z6R3zyknWd/ukp99+YuBx6X0oriOUDeB
 1qNitQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h01vkkfaq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 15:00:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c58ee2116so742463585a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790694008; x=1791298808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oC6ycxct5evGf7msqSYvksrjwR+3Ojl2H7PIOG3pGA4=;
 b=UqBxgU2QaCs5nKvp37QgUxjFEeqTOXPitUi4x7nF40J0UjezKwxd0fj7H7+CRvZzkh
 yJhymoi5fshIxagd3D2Xi0tXXfpQymhiKTCUzEoAQ75/4wPh65zSJUqJs7Burt0NH6xX
 2D3s6CfgeYSfIAKQ3fr/T82s7Wm52BWkdwc7iDVsoApJ6N44+9/6ESCSwITnUbdzdsCM
 0QnheGC6vnJv5U7V1ZM9T0cPd2gOOwEe2UsIxB9J+WU1QbAODrJqmI747D0NymLwMQ9x
 bK9Gj88yQJY03XmYwMhvGMNd28S6QkRy/hUKOZfRJHv7CpI7wH0+YSOKBLHhIZ8iXI//
 apLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790694008; x=1791298808;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oC6ycxct5evGf7msqSYvksrjwR+3Ojl2H7PIOG3pGA4=;
 b=OCPgvJVtzni6lnt7uw/DhCOj6yGroJjfS73Xh9RX/0vpwbIsw5F88KnYK7FcDBISwn
 878YwsRT72Oh1Fw7nqTzuTiwOnuw1XSje/pu3uzjbU5H6hWTl1KviEG25vPw7EHH/Hgj
 AHwM5SrEMMRkqp4NtCg8WhpswrdwG0g0NgXZvfSl/MXjU7gU+2l/tlBZfiZgZc7583Ui
 7X9NXRMAfA8RREddhRbJh/n6lV7wK1y/kiHTQvlODX1d9PaNhSNPzEmZwatSX2tMA0IP
 dw4+N9xeU3uF/6ighk0+5S8xaImbDIEDF+uhjUYR6fIF8XhiUgHVXH9fcw3LP4gnx7U1
 CdbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzp6hJp1jKXLV8UNQgyTfbZoh63yvg0OnDU+rJeRHj6zab8HcQy1jZZrT915WyWwpfgcKi8RafEHg/Q@nongnu.org
X-Gm-Message-State: AFuF++ns9NPc//zBRYZ8TV0HYU6H6Tcn9R53zLiG9h+0YTUlyop5gJeu
 nk7kRsiyHZqGEr3H1EpX/Wpn+gpt47ESDTKb5AEfTGLvaowdlYcy18uViIdO1P4qo1ek/ela55l
 Ofp82eU+prKMsQXO/lEcyEN9/SwUXUeTwB4fLCtb2S0cEdGKe92KiRn/cdA==
X-Gm-Gg: AYBFou1eQAn4kTFU4Ww+DWOoUciXG+dk2CpvrFyJoypcQvHB2SRIXfZPOK0e4cWnrQ1
 B/PpyMV6Ie19Q6NDKkgGPXRbxWqsrQVxHoZqwFiTUqBljXl/J4kaP8/lL/BQmELQy1aGfRmMTCL
 YO/VQjm1mOCOy5o5Tt1PVhIRac7M5LCySX5lRJNwLDA2cGfuYKNCzmbqooSNc9UpjQpklApYbFa
 l9+6+U4HFPPf/ynzEDeWPWT8SDdQuCWHKcIlgC9Ahvh8ZLvJ5XJrhgpo0JTx5EZhN5mRy/tBwyo
 JZhd0rRVqDr9+VZ75ZXSVykChOx7Cyx812HD75Y+7HQSAKA/IvMCoVwMVua2ZSwZcO8VKmu8w8Y
 DJnmPP9bjBKqCqEOUpkAJkKwOj2I1p/oITg==
X-Received: by 2002:a05:620a:4547:b0:93b:bc51:b40 with SMTP id
 af79cd13be357-93c47223f95mr2617134885a.2.1790694007759; 
 Tue, 29 Sep 2026 08:00:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4547:b0:93b:bc51:b40 with SMTP id
 af79cd13be357-93c47223f95mr2617120885a.2.1790694006945; 
 Tue, 29 Sep 2026 08:00:06 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a014217216sm760635e9.14.2026.09.29.08.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 08:00:06 -0700 (PDT)
Message-ID: <1391eb6b-b4e9-417e-a634-115fc1751166@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 17:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 18/25] target/arm: add cpu-models-stub.c
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, eric.auger@redhat.com
Cc: cohuck@redhat.com, peter.maydell@linaro.org, richard.henderson@linaro.org, 
 maz@kernel.org, oliver.upton@linux.dev, berrange@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, gshan@redhat.com,
 skolothumtho@nvidia.com, sebott@redhat.com, armbru@redhat.com,
 philmd@linaro.org, yangjinqian1@huawei.com, shaju.abraham@nutanix.com,
 mark.caveayland@nutanix.com, ping@khushitshah.com,
 sandesh.patel@nutanix.com
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-19-khushit.shah@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921123249.1708067-19-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1OSBTYWx0ZWRfX8xIrPy0ifRQw
 D2Fdsv7H5Q2kCvKYea9ctX0EFGxJCjhmoNZyKGLyCf4gGzGKP3CR+zjUhpNcsFOQun0aHmuXMTJ
 W0Z9Cv/RomnPeqMpEKKa92qwQLjeOyhV63+MJNmmmv1L+c/DCsfZJIZcZSEg31mVLII3VbEQWcN
 UTYLA1SdaNhAwUZYpb4ZWADJfcdTLwXi5uuVST306e3FLqDete1agIr7rUnS58FSHyte68efnA0
 Xz9Rm3L+T/gwkrT71KyE7quh5HPHdP3Si01CvOngNBspQP5hzTVge15i/15QiiEcGtf/P+lV4OG
 rAyCMlButnqjQbDjw/Zrsm/anz7mhFMqR45QYKAaDGbyxNqRhMjIWIXp008S1G4evlebyqHGlxT
 FLyconDbdZFP0Eym6s/oMJEn0qNwFDXn6yNS77d8s9qDVqgZR6+VpOgWDbHnnJHuG8i+N7h0hJD
 /CSDcvt7/pfSFr7MS9A==
X-Proofpoint-GUID: tVDDHL5TkE02d0jcj2-9rrTZTQL0V_fU
X-Authority-Analysis: v=2.4 cv=VcVir1p9 c=1 sm=1 tr=0 ts=6abbd278 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=64Cc0HZtAAAA:8 a=kBidzhC-Fu57bEbtvHYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: tVDDHL5TkE02d0jcj2-9rrTZTQL0V_fU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1OSBTYWx0ZWRfX3QAJmUuDwpFM
 DEysj4aVE7VYvSO0GpyWbs5lZscne9XqhvCspAyPGJYDj019nUaQfHtGBQAC8+8QjvSVWBsyNKE
 t/+x3q9k4LrLRBKN8ZYqMqWf1zfPEWA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290059
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

On 21/9/26 14:32, Khushit Shah wrote:
> Add cpu-models-stub.c, which will be required to add QMP support.
> 
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>   target/arm/cpu-models-stub.c | 13 +++++++++++++
>   target/arm/meson.build       |  1 +
>   2 files changed, 14 insertions(+)
>   create mode 100644 target/arm/cpu-models-stub.c

Shouldn't be needed if guarded in qmp_query_cpu_model_expansion() as:

     bool named_model = false;

     if (kvm_enabled()) {
         named_model = arm_find_model(model->name) != NULL;
     }

