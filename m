Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88466C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgqeZ-0008PT-Hp; Mon, 06 Jul 2026 17:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgqeY-0008PJ-7P
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:14:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgqeW-0004jd-Dw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:14:57 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDpwc1650184
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 21:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6IaqiH7fAC4tbvYAh7IyIYuAWmfG0qYpIbhbTuP6Cq8=; b=EuEyl1il8IG/kanZ
 1SpG9HV1uB+H11qMbn1dkebtE1+Xgp88W9ys9iIX6zpQrh25OFJci3gXa2tCKFEJ
 K1E2JsB9gDt+pYR/JBMPx34fI8cXOoabaZNnow/h3zn1hqIXByR2+bgury9/URV9
 4CLMsLOqaHYtHFTXufzafGqXVhx+04q/JAJUlWREf5V9swQUHFV3IQ3hOLWD+KPC
 vohnbQd74sdHW4NRDZTdE85vpBH0qmnikoS3+vNRWKwJRPeJXj6bOSoANrnP6tee
 1fVfDlRwS14jymXrdLPvoNih3+v6J/jpTBD5gEg9gALoBrHo4phnwTbFY+KJJJ4I
 KgGVJw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgu2em-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 21:14:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8db414c7so48456221cf.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783372494; x=1783977294; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6IaqiH7fAC4tbvYAh7IyIYuAWmfG0qYpIbhbTuP6Cq8=;
 b=dltslqFSwXKyeugp2JD/6uE4Bw+J7hRzm3FC/9lzQbn9UUelocaGsTc0KxZfH4Kdq8
 8gkL6zPQLDAsmpXPfjsTMMumacRvvuPG/6hnuItodiiVZKSk/d9A5fV2irutPiMtmVnY
 n6GjejanoLpj3FtingAjZTmcEf+h7TlrHW9/G/dfEkcrjDc/xR3BBlq6M+I2lWaHNi/3
 +kTFld5RJzmnpeEpltIYhrx+kwd2ONeC+pICHxnC6LMbehMfIbGIp8X5/Jk69fsRuDwM
 MMLh/1l3hsNgYJsqCMp4SRUWV6WzmDB8PtWTvaVE9kqYDBYUr3IVxeSDUL2d2MICOjRH
 pEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783372494; x=1783977294;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6IaqiH7fAC4tbvYAh7IyIYuAWmfG0qYpIbhbTuP6Cq8=;
 b=VdNYkLcdGx6p18gIHebazucp/45VFsolQcDvdRT1u6IgAoSFMX15ktKG8h98j08NlF
 OXVed0HL9iZC2L/ubLgWIwmQ3EBPz+qJdJYJms3pdzR3Ytxju6ghQuxT40j4UmwdCg+3
 ojUmxA41/Xy25mzyJgDXPR0hrK4q30YluKcKUxB1PojdQashPYuFSpEiCPIgFYQL901u
 CmV1RBV1nk+8iw4HeTEqEdw1Ik3LFAquTE1+y1+J6t5nmfQx5DjlowjeZioo70lEWwed
 lxOMXtnMvJIf57tB6Ri60rxNnuPuYGATmpiCh0vmFKvrJMuMXituIe2/JQy7PrT5TUTY
 lkIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUGDF6LAwikNdEq55jt2neu+f7KjX02eVZG4t2ONT8qNJUU1mQf4yL8Md/Jj0sZAtMqH7PJJv8jQ13@nongnu.org
X-Gm-Message-State: AOJu0Yx0objzWzfUKksTqvRbVggrf9axH1322HskFjW6OZEKvb/G/JMF
 t7J16f+0E06PbzNtZRbgO7Dds4+f+YSa+nmyDrBeA+1M+/BfRhj89t5cAaWdqEy+tgdq6XVyTu+
 l/tOq5KwXmjIw13ubRzJgk3SnUJss2/iKgpTsgqy+pTYJoUFl85RJOmcNjQ==
X-Gm-Gg: AfdE7cnzx9ilUx+aHrLkuzWiCVdJwwL7d6L0tjAcL664Gf7VJ5++LiSmxPVvXf3vgQC
 pdsI5RFevYjwZo8Uwlh4evh6QkeGlouyqG14kbSsX+avnmZCpx8xweSm6cIvVzWvtnbfM9w1GBC
 O6cAO8MMXMrCFBrH14ZCnGkJyxWxuADJ5Tafz1HPv/VyphU1WD6BMd6SRF7Sh2w/bbkXyy2XdWw
 cy4jnuYr+AWB09so5ADmZzd94a+ryHeSKx/IwLjV+WenRGVvbA3idSys+OlBmqCChDKPYzncWtM
 4a4uV2hUyBVoDZa8dgdbS5KfcPOnyLYBGO1qrZq1+N6IRj5uzmrHlyUP8gRJELehNNB6b3WaxUp
 5UHKwfbjeM4ItfoGnXssSqFmR9ed0KQEFI37d4h6zXIFPKA2UgXtzdEs4eDUeSA==
X-Received: by 2002:ac8:5a50:0:b0:519:5629:20a2 with SMTP id
 d75a77b69052e-51c74878a6amr28411301cf.36.1783372493910; 
 Mon, 06 Jul 2026 14:14:53 -0700 (PDT)
X-Received: by 2002:ac8:5a50:0:b0:519:5629:20a2 with SMTP id
 d75a77b69052e-51c74878a6amr28410281cf.36.1783372492400; 
 Mon, 06 Jul 2026 14:14:52 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm28819643f8f.21.2026.07.06.14.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 14:14:51 -0700 (PDT)
Message-ID: <c875021b-51f2-40df-b2d8-cc2c00ed27af@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 23:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/9p: prevent potential error in
 do_local_xattr_limit()
Content-Language: en-US
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <E1wfg2F-001Sfn-Rr@kylie.crudebyte.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <E1wfg2F-001Sfn-Rr@kylie.crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5JpK5i9z9wvw288bkFqjEjn9RNmMlTOb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxNCBTYWx0ZWRfX9X80AuDOzjZP
 LVqjZimUyLwpJR8ECqCap+7kmTKc7j0l1dFgXZ1eWcfjNSuZUfx+bPcd60ddU0qad76zu28QXNP
 oHeKFkRDDs8qkS/2Wlp8RWxz2l7k+DH5M9jCGTXXzqhgan3lU4l5aYCNJbDy3j5EbDHUhYCMtJT
 xEyOjiphKe42issVCjYmn6LBfjYagJ9PfJRKYCYnB55M+K6Cb/QCiaUGPNE18JSdq+zZEX41EZk
 yRZOMAI7g/t7ParIWK0mWdbUCfJIflyafsDk8UylVe+omM0h6GOFtT6CwfK2xFxZG9o3X31LVlw
 zXI70hCDF28+kDcTIr8/tnpPEdOGRm1LECF8pB4XvjUGjydb7Oz6vMEeVu+7SSEdclKVaWdcrGq
 RMrL/9DDEd4IWZP4Bhv2pCamt1DR/xJqe5MTlg5rAGw1SR1p/OSTwTGIt1SD4VcSGhlDYwULTYZ
 ACZ/dPFeSTElelZW6mQ==
X-Proofpoint-ORIG-GUID: 5JpK5i9z9wvw288bkFqjEjn9RNmMlTOb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxNCBTYWx0ZWRfX8EMQblj9/P1G
 d1eJP7vTe6AvsRNP0/64upaC9NXjXKnSklXouzlN+ECTd36n3Bd1vfHOBx2wHsNxH0suD0uX7+/
 MnDFbUJIVVUsKnlvkNBy+I7TJyJZ6YA=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4c1acf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=K92WTf5yAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=X9ok8FpLfHEzVMsE4qxm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060214
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

On 3/7/26 17:38, Christian Schoenebeck wrote:
> The local fs backend driver tests require that a dummy file is
> created on the host side before running the xattr limit tests,
> otherwise the test will fail because the file is expected to exist.
> 
> The original call of g_file_set_contents() didn't check its
> return value, which might cause subsequent test checks to fail,
> making it harder to identify the root cause.
> 
> Fix this by simply wrapping the call into a g_assert().
> 
> Fixes: 04a62cdfe873 ("tests/9p: add 3 xattr FID limit test cases (local fs driver)")
> CID: 1660926
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>   tests/qtest/virtio-9p-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

