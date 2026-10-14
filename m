Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F1AC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4q0-0006S3-Kp; Wed, 14 Oct 2026 15:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4py-0006OL-Lg
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:40:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4pt-0001Sk-9y
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:40:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEagBH500328
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZepwW9DwLWmNR0DTNE/jAJUjpROOmUl8X0iE+0wU6XE=; b=VqxHTYEcqM5C5hbb
 hdrw6sAe3nIRZRFNN7afdqa09R6iOsDjDub4MbhBPSxhIKariLSmf60XdjIXeko4
 P+RIZZxxFrXtLZufWvqgioVT4MjGzCRUOJ4r0mfnrx0M2wv0VQGqevsGqabe3Iph
 Xp5ap97AMiJbvgAx7nsBatBNkE5R16h5jI3nuZyz4zB2siZP2BoVZC6iWZZKi0aR
 jHKuz90WlzRuS3vHbFqlCzevGKVZ6rpHK0YM3IEuyru3WQWM3lk2b3D+o4u/TFCr
 fEw/AGZQs3gx+kR/D1bn4Z4VUnWYPSW4Ov50zwmzEdJPvcuf/qUF9q1Kxj4Es6I6
 l1iNPw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf1g25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:40:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53514fbd4a3so15429311cf.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792006822; x=1792611622; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZepwW9DwLWmNR0DTNE/jAJUjpROOmUl8X0iE+0wU6XE=;
 b=CvhP8MpjCrYmm2Bxs+AAlhzQ8ukN7yvkuHStIrB3IuU49TG7uCbTx96eH4ES3lexS1
 azptLnc4J557PSuuwP6lkirFVGWZNtFONmZ70Pmnv5KLYB+xCxLR2ZFNXPF6vKMuoLWg
 zf0H6/snhhce25XAUcF3p5ebjmx8lGIX0VsNkmTaMPZmtWUdykjN7/k9BYY5dKaaxXyD
 61nwEudA5s6+2M6rBIVwdrO1pquQEZDDCLAE49ZZOVL6VHqt3S/6vizx1cZkRTrcYUon
 NUZsHfhpj+gk+HZ3tEvqlONdb4+0nUokj8dVJ4Nb0Q7bXjEf7oSvgHHAIP21a6XEYNgN
 5Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792006822; x=1792611622;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZepwW9DwLWmNR0DTNE/jAJUjpROOmUl8X0iE+0wU6XE=;
 b=YfCHfJ9IHQa3/VQ6Ui3yKzVQS8bkEM7mscdw9EqMvSo0TqILwoHMJ9YySz1oZEib1+
 yb/8uiGOFkCX2rh//dUgcoIDUslmXuoT3ohN+eTQKV5CNBcQhHWoW/l4oJ/lNrpNGvNG
 xzzGnXmL6w/4pbWBg2veNX/Z+Welgiw0oTADv9cIX5i+2AGYjZ0MpEiY5A73ob1oTc3w
 d8dkDmNtVGnaX6IHhZ5B/EvKx/cAFQLCXb5an8jv5uMA2wp9SkB+zrbamyMd2PQ5a9C5
 UJgIX4VuDpwiWIYnWIULJn3BZWeC4kJx5S7tSc3tm3TbA6aKZYf+T3TOpgiBndkIKgGA
 445w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+z2/qsUD2evfB7BLADIpgoXgnOFN+aUIdCXpW6c96tY/QHbKKzCikLzDMIhK49un0K1TXRJFfUQrM@nongnu.org
X-Gm-Message-State: AFq9FYJTGWdiDGHLDYPq3nFy1+s9EzwEyA7lqgqqZfekvIpkso+SGj6d
 m1TA/1ycLIePIu/9JDLoxGNUzW8bSxPnQ6MRiosywDbf4qnOF7fBIETtUT9JFgcD0qxvdm2PPuh
 Bv8WKNysbSe3MnqOPcFqGJj+BwKe2bMf+COEhncvDarhYVUMB6z4xNfjrCQ==
X-Gm-Gg: AYBFou0YcjZuhK9K8StO9fJGdl/BzLez7nO/PqCjXgz3HkYilY3NqsHSckuyccbNSVz
 ZOj501DxNvARUu1KxuPm7ZF834K/jgwRva/J0H5fmNdZQFVx5mwz3rQ+oAJQKMdAIJsAcEZRPt5
 aoUKv4Wxt0hjNMjHIrnzOBBogd55u2xWgo2XpcjAadOo7FGXteHTlPRSziRWzXtma7ny0ViUG+Y
 2aFk2jDwWOhl2WT/z25oyZpmyZpp4g8oNAsq2WbiVvaDJpKr5Cmq/aZPapVK7SYfc8WJzbmjpCq
 EWd36G1tuZqtHmPy5gFWJ5daLfhgcDp50eOd7MOXOB4jYY4Q0SKj0/2SlFi/Y1+iE7l5G6VtGZ/
 RnH9jjGlxUnt8HL1wr9BPIwPxpuKqCvrA1Q==
X-Received: by 2002:a05:620a:4692:b0:93e:95ce:539c with SMTP id
 af79cd13be357-93ebd0e4018mr2766870085a.2.1792006822099; 
 Wed, 14 Oct 2026 12:40:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4692:b0:93e:95ce:539c with SMTP id
 af79cd13be357-93ebd0e4018mr2766865285a.2.1792006821409; 
 Wed, 14 Oct 2026 12:40:21 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc6b82sm14217395f8f.51.2026.10.14.12.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 12:40:20 -0700 (PDT)
Message-ID: <932711ae-0a90-4ec1-9a11-611f248a9f6a@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 21:40:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] hw/core/cpu: restrict tcg_ops to CONFIG_TCG only
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-5-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014182543.135965-5-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX19DOzOKARttf
 oUFK6S8wOetbVd7CJfTWMx1LQ4exFh/eVaeWgb6z5ahl8jqIUCHYZ2jRBpM/vQc59KYyC1EXWVX
 skSW6EbyzTwwADi3ic4UkW7Kj46GssR1Iv/zA6VghpW8ZZHl+kbjMy2foQ6Oha4GMYazQSV4o16
 Jhk+RsNwO2It0JbBjQ9c/BeYN5dIqjTTBsuu9kHNDDnRzqcTCXAAWG1hgmZg06V4gSKWRnZBsxc
 z+2BTNt5iAmLqAUMXAbyVOpFzkzNjhcVgHYbtBoN4CCcAuUjIqcskhMmL6+2VM4fSfCbqo1ZTHC
 XabKUsZ83jKJ4BMrYzKoMelgG5gIadleDiB6s9ICNRegVSgyMDv2hsAFSpZn8Hvd99H5lEWtQ/1
 TghLZW3SLvf6ofU2QniTW20cLhJx7wRYsYwXf+o5s0zIlaryxd0QU71NnaikIxz1y2o4jQvv37n
 s8IvYWqWtNWfUz0I/NQ==
X-Proofpoint-GUID: 5a2NZbvAVr8eBPqRZJBiKnuuIOP5lFZF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX7MODyvnhTrVO
 gWT9+zc3oUvjxBuI6bBVBbxTADUcdWM7sw6RmeMwxQAvkOC3vMToWZaHwPCbIKHjxb+AidJe6t6
 vDhuvuJEtS2+QpKEMZbWTnQKbxG0PQc=
X-Proofpoint-ORIG-GUID: 5a2NZbvAVr8eBPqRZJBiKnuuIOP5lFZF
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6acfdaa7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
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

On 14/10/26 20:25, Pierrick Bouvier wrote:
> We introduce this since upcoming semihosting ops will be in the same
> ifdef.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/hw/core/cpu.h | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

