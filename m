Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1B7CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWiW-0006J9-8z; Tue, 29 Sep 2026 08:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWiT-0006Ig-G7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:13:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWiR-0002b6-Gf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:13:49 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TAjA8h3011302
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZspitzxJ5rGRDIxh3oQRERRPsfg6VGDs+xV3lgv9W1Q=; b=MNfep6CfskVOls+k
 oAPquak8gnz94UMbplZ1+kJfQbyTh2mhsfGuSdhcUiwDe4JMniN07h/9R+FDFZnO
 kXoxBN6+edKnpcuczdMeZqrdYt/9+fcArJLU6ytVYcFsd8n/qRa7KuYPvsBc61tQ
 cXq7rbjTTDKsyA6VOwUApsJGqmDZ9y7j0QN4W1qQBCYpVpMx8GEJ2ZZ1GBGzKUHg
 I9F/5iDCf6x9+qoVtgE4eKSF5XXKlS008jP/plLbshOzL9m1IwnLLSllxM4285a2
 ndZp/2smkzuzypAdRd7KRp0mOMkNDCyCCBH4iYho7ncIkZhMnVF9zfm95ng4IL2X
 Ff5aQw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mnakhr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:13:45 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-988cb71802fso25587241.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684025; x=1791288825; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZspitzxJ5rGRDIxh3oQRERRPsfg6VGDs+xV3lgv9W1Q=;
 b=IsMxXzC7Iic7SuJyOKI+pj9CXf9UA3MMXRQotzeZib/rLE9LtaLMg7Q/baFOfGKeby
 Oi0gKKZjF+eTTvh7iqzssDLLEvCaK4yg1Jz1eoTisud73vxrznZpmRWD1tWrWDRreE/i
 mLqA5B4Viys76asB8e+6dQ2XTLppf8fnZSMi/24lj7+sR3X4XDrAllnLnT538emq0/IJ
 He91YRDL0c3rKA2XJMYrYjxSRg5QXsjR57dHTH+WIfcypqndVL3Cpzd/R7OuJV3R7iYG
 Uut/bc3ogRA43mW0QWJwEo1Q+3RfA5V1oDRVyhkycw8gPoLAXe+WAw7P4ymdr5nwygvq
 1R+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684025; x=1791288825;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZspitzxJ5rGRDIxh3oQRERRPsfg6VGDs+xV3lgv9W1Q=;
 b=DaGouwrx0DRf7d1jAabl685kbip0OPQn/kBnSlEi0+zD9c8QTM+8hbzFu7RJeIM1cV
 X6fuyd5mgEHNsr1K5m7ydemYTGlQFfFLZpI9v3D9hMx7fRNs3Ee3GTVlsEadSYO6qg0A
 yV1a75+Pqqc0E2w0tuHl55tOIsbKbN/EqCuOTiguPnPceCNvvCwfHfjdkWJuZttAaE6b
 N3UzzEN0q1spEDDJsjbjxTu2v33/sarGcDAO1jaYxM8IMgK8OH1KWHI62mIgzv0AX588
 DEJSVfM1+tYoFWFFIjySOyYORlS0WPcMVXS73i2z6vsOhDsgvq7imHw/B3rvMd9cwG3c
 IIjw==
X-Forwarded-Encrypted: i=1;
 AKwUvByBfrRvQjCx6qvF7TF2oAuexlHCxkOEEucrA/yolMRiMJPGDOR/HOav/pNk7IgT+JHGa1xaHIoarAvT@nongnu.org
X-Gm-Message-State: AFq9FYIgGB0v8Xj1Hvx87p99RDAC/xiAVvjQFg5rBaDS/GfzP/rSVbDV
 /9XL5aRInb9lx/+ZCZ4CvPEoefuUnjhfIZ8PfLsjH8Hx6cYDKoHEqS/9sHSu540mMNEiV2RLugj
 MPGImVIMYdMPghDKFOdxrgmaHBLIHyRGVdlHQxBp8sCWojaRXxv72tOBggw==
X-Gm-Gg: AYBFou1P1xIqsH869ljh+0f9ofHu8yOHZzHRslspxzzXyFT/31ElV4UIN/49yRpoFSs
 V8FDPRb1ZUNDO4EGccuDVHxvEd91skfGivqHn+4y1g33eHauVfcR32sS83LwJLef+pMvAXjlRo/
 DPvOFM8HLjXOu6abqi7Vm0LaoHkEsVd5fTyY3fHbcsMJ3DJq9RiaNdo0K2GL/zZ5HSGx0WIK8wz
 N0EaagZts+2WA5y9pwGv3OPU2dtR2MEbeFCkmPacABMvCQ81G7kjO7g9CEKMZt/u8nGAjXPIuwu
 oXPShJzxO7QUb/Fv6GOXDyOm0TP/NUED6j0igam2zKWwVGpNhC7bi1IF/S39KAdEtVHSUM+Lmm8
 DoM+IYlWigjLLXPnwOxhYpUFGbhePltROog==
X-Received: by 2002:a05:6102:2928:b0:7b2:f832:49bf with SMTP id
 ada2fe7eead31-7b2f8324f4dmr3451939137.14.1790684024675; 
 Tue, 29 Sep 2026 05:13:44 -0700 (PDT)
X-Received: by 2002:a05:6102:2928:b0:7b2:f832:49bf with SMTP id
 ada2fe7eead31-7b2f8324f4dmr3451924137.14.1790684024217; 
 Tue, 29 Sep 2026 05:13:44 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00d0f68basm78509375e9.12.2026.09.29.05.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:13:43 -0700 (PDT)
Message-ID: <c665b07d-08a2-4b78-97ac-0602464db9c8@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/42] hw/arm/sabrelite: Have 4 CPUs and 1 GiB of RAM by
 default
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-7-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921214710.29422-7-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X9fHu2Te c=1 sm=1 tr=0 ts=6abbab79 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: hIM4m9QB6GwBsOFcAHZIDDznSzEMYJRV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX4T1QvO+F2qxk
 lkjvGLWY348+zvBY7oUSTDS4vdZ/GNcvFj32L/v7IwHMcsm/0Vn0smDjEwEbbIqGs+Hbd75K18i
 hBS0aItXWY1ogJfr3+ubO9/R6Yz739Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfXw7HRCVRk28be
 ZJ7sYhrgjaMFnw3cV1rj8p1Jee9572F9zRsjDXZpcavDhHSwpVOx69beyLjR04ubIvj0TqEMBh4
 K7g3Kf26rF71Ao9L4Fgy+Oy/V9B4LoBLzAUIzKoFklz4IRS7bggM6qWZkXtpd1m6Uy/WBpG8dyK
 qEOJZ+zvioW3oLZ59NQqE7OkJF9B0qILGxchGZOWTyJcqe68V/3a7m5r/O1Cb6kK+FY/gaB5JUP
 kgYuVFh0oH12KwzdQi17IMfzkp6i2UPtZvt9fIXiVTmsHFPvmvJCDnoXVLXATqFe8XoHMLH6hYq
 2sCp1etp3M9TKWRihiIFKATz/2B0FJsozm+w+kkllMV5ewkuQfj4/O07XdHwbzzcnvScn6dKM0b
 O1BCwB2dXNwOQToZIDaG4KfkHKXSmFNOUd1FyWONtc56OnqMG1/eMUFDN20Fi5BO0tDskefyF5j
 BEr3LCCb68eoqvNJR1Q==
X-Proofpoint-ORIG-GUID: hIM4m9QB6GwBsOFcAHZIDDznSzEMYJRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048
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

On 21/9/26 23:46, Bernhard Beschow wrote:
> Having four CPUs and 1 GiB of RAM matches real hardware. Fix the machine
> defaults to make its use more ergonomic and less error-prone. Also
> reflect this in the board documentation.
> 
> To reproduce the old default behavior for e.g. migration purposes,
> `-smp 1 -m 128M` needs to be passed on the command line.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   docs/system/arm/sabrelite.rst | 4 ++--
>   hw/arm/sabrelite.c            | 3 +++
>   2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

