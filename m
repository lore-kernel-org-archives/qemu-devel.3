Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2740CCDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcre9-0006TL-2w; Thu, 25 Jun 2026 17:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcre7-0006Ru-8R
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:30:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcre5-0005Wb-EZ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:30:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFe4wZ2250176
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 21:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zDnw1GJvNBJNhKv+gCmmhdMqpQESNNaRD0cJhQIlkHE=; b=pJfiFtePREZMZ/1x
 oGLlNnV7Siu+MifRbEluW33caWGbPF/bJdUC8NrdlrvI4/tx67T3V9yJaA7RVMHi
 I7CuEwloBvC7Ke6eEDSlfaqpjgfuJ8aULxtM9YC2S3jBOmXVcwr4lUpwN0qIUr+z
 Ja4s4dQWSkrhTZSAZCm6h8DLeKIvConq9D3puwcDhzCbZhxDFofPoB7ZKucxxIyF
 Y860E4PtI/0X0Lv+EllMw0OYKhGp2rdkhXc8sxJJg0cbVwUzLooa6F5/pWgkT7qH
 BzYb90KXGLSY/XKnTo/6ksqElENvzJeA4cbUoPhKZmRSt850xbXcaLhdTg/tfdnk
 4L2K1A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f16uk9f2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 21:29:58 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139871a52c2so480698c88.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782422998; x=1783027798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zDnw1GJvNBJNhKv+gCmmhdMqpQESNNaRD0cJhQIlkHE=;
 b=g6Iw3YwGzNxE+QogYcu08rZjomiWvNhkgSAXhvoxhkjH8O/YK5lbMXm2UaLPeAFIOe
 NWy1rkJyVzW9WcD+115w2oQKb0m0KsvAgyd1j6OF2WUGXgE/9Ussy8G7cca0yQiEoKWu
 YD/alcRr6en778V4++4jH99fK8MFkFHYlwi8xzPgWz9ttFE+iko4Inavmke5KW7U1Rj4
 cSRbQZ2rOCPeIUMeVZ85gRjs+89te/e33DF9Gy+3JBzTY/ZnYRU3fevZP7P3mgfnFf/O
 gQmcvht0ctpUd1bgSsc3OmGtgof4tIuffhin8gDuTNTSQ3U4UBRDGg3xNDAEotKdQubV
 yDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782422998; x=1783027798;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zDnw1GJvNBJNhKv+gCmmhdMqpQESNNaRD0cJhQIlkHE=;
 b=kx8VDSYg18Z5sMtLWehbmVZL832EYzqPZRa8bFr2ilTUfWlMeX4unapSElrPDK+nID
 oo5ifeUdRRGflOmEWqMttDTtgWVrUBGrYh8MOD2aixRBNgBLXa4NX/nfiJkb5Su7u8fe
 suMD00nyckp4lt5ykhFgvZWua69ST03J7MqZwpiL8vRf2vZMiSCSUBQ9MZ0zQGiod7Pd
 KHKPQI/i6oLMIClKR6DzMIEh3NoKzM2Dkg4zNPESQ27a4Z+UeGLwjWaTrX9ZVXJCzuRX
 BfGMXO8OmZMKlwF0U3PJF5BlAabLtFwBq9LdkOxwMjOht4/wF4/sv5u0dyzWX43RxHMI
 +qYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+q3OlbqJUbsVY91tYvdAIygYZSYvfFO3h8Liqa33KCgxZHcsABDVsB7TMac74HVE/vvVp057AmI1b7@nongnu.org
X-Gm-Message-State: AOJu0YyrS9UNnXfT4KKtFuukUqo7wav3lvbcw2nY+zPW9wf4Ko15G7Bx
 HKL7uiqRHiP2khR2oZjWakb/wbhGOn412YHrFcaR8dJ3Zy3jgrPyNZf0oJP4Jl3FyHm6R++mG97
 fVN/ZbQpH2MQDpnNc9kwig8PrNmlEEnXxjkbrkZu905yttBvbqjIbvSEc4w==
X-Gm-Gg: AfdE7cmr32OSR1NMlRWSiFz9mRYJM4GReC6lzrkXIsQJytLr7QkQAmmMQ5qafIk3oKy
 d+wLq5ld+hBJ2kUuzdTSgz5fO2nOQBFixCxCJsjjLIhtBhZsqd3zUjf+hE5+mdkTJHPifMNnb5L
 RTOpssvOrqHMF4wqUjCyidw2usvXjARATSm/O7tAPZ6mr32hDED19Wh2xbxI1TtO1OYK4+Mawq5
 K1uGED3b3xdyYu2JxhCw1qfYwz1mfImDUb9sTf3kJWh8kUWpKNSXeu3OsBFF7144Syrsv5/SbXy
 jSXNJvxSpB3PuCmBABOD0GLa0NxXMe3dWcsiRezUBqCW9zB7L5PiYV4tUMgbxOTu2bkdS54mkT6
 7OflK5dc2z//Kd7QT6VflV794Y9v6RjL71TM1yvOaDplrtes64/h52nz88JHdpkcoURuSM7Wj3z
 rszdU=
X-Received: by 2002:a05:7022:788:b0:139:ce96:72da with SMTP id
 a92af1059eb24-139dba0dab7mr3475117c88.13.1782422997909; 
 Thu, 25 Jun 2026 14:29:57 -0700 (PDT)
X-Received: by 2002:a05:7022:788:b0:139:ce96:72da with SMTP id
 a92af1059eb24-139dba0dab7mr3475106c88.13.1782422997368; 
 Thu, 25 Jun 2026 14:29:57 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d91006afsm13513808c88.12.2026.06.25.14.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 14:29:56 -0700 (PDT)
Message-ID: <563c843b-1b77-4797-9a17-334bf36fd4ab@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 14:29:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: disable macOS jobs in forks
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260610091700.2772973-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260610091700.2772973-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VuMTxe2n c=1 sm=1 tr=0 ts=6a3d9dd6 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=RljxU7T_rXKEf4E3K2wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: JhS0vbwmSWz54-4hKHXBMka6HoxyJBWR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE4NiBTYWx0ZWRfX8hIZ0lYU9qvi
 G8mIC2IKFSBpM0pWkB4chVac88vNakvn6OfqinECFvsab0Gt11665d8w2PzCp8+thOxvhyZu4kc
 U/GN0MhcVjDtWriK8YzVw2jm8LztA6NpiPK5Ya8MUmbyOUo2CEIApbU0WjQ60nl3fFBtmfqHx8T
 JnUnJ/7iZoBnUNwEAaPCPvlvCAKDI7m263ev9APNGaKmraVJ0XPjj4KeE8dLA4b6l0my655RCPJ
 D/+9WlKid9n3bVnMvJbz1Vn2a9JfgfiiylatzYlkKvsBssCz6L3PFg3nX0lV+DI5KtxNXvm8lM3
 BzyaoeGz+k5Lagb80994O4MFwTlPDo7z3CWfGVsUDP4aj0LUIAlhzNgVQuzeCLIiyOUmfEb2maZ
 cVnft4/PSwXYjRZrw6JmJl3slK/4oO6m+cDggWElXzgDAQ7d4wokYtkajPqrAGb3d8vUYX+NN2V
 ItJmVVRYWHnF0oa2jFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE4NiBTYWx0ZWRfX1HcQLTEusgRJ
 h48xBuhlKxpGWPsDwHXPm9ZzrXmbgPR8kQrAHTplDPWoBT1+ONGujs3Yy4fazR0r2PKDRLNzrFW
 nZ4AhiApxDom1e9oYUlFb5hEw4awK9E=
X-Proofpoint-ORIG-GUID: JhS0vbwmSWz54-4hKHXBMka6HoxyJBWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250186
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 6/10/2026 2:17 AM, Daniel P. Berrangé wrote:
> The GitLab macOS runners are only available in Premium and Ultimate
> tier projects. This permits their use in QEMU upstream via the OSS
> Program membership perk, but this does not extend to forks of QEMU.
> The macOS jobs thus need to be disabled in forks, otherwise all
> pipelines will immediately report a failure due to inability to
> access a runner.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/base.yml              | 5 +++++
>  .gitlab-ci.d/macos.yml             | 2 ++
>  docs/devel/testing/ci-jobs.rst.inc | 7 +++++++
>  3 files changed, 14 insertions(+)
> 

This was merged into master (1b4d5bb3e233c9fc84663be28635d122c9a2b81e).
Thank you for your contribution!

Regards,
Pierrick

