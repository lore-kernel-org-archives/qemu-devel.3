Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3392CC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzthW-0002f1-Qo; Fri, 28 Aug 2026 06:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzthV-0002em-2K
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:20:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzthT-000376-Em
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:20:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SA7kMH3306371
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aX+j661dB8JTyvZbLryyFD0MRGDLFrI/YWJqg3cbhzE=; b=Ui5X1N0GtojOBa8l
 fTWDzpdsOS9C3caj8mk3bomr2E/kktnwSYKfny9hZFNh3ZGiueQYFbofb+tYN3Ut
 vYqRoa3ZF2eAxzq3fu3hDF1wSxdSj6XPdBtbNxM5vJB/96oruYXPzSGAxAayBplD
 qVpH8t6oWtT3qSH8wcsJziuR6zHA6mAO0ulF6kDUhrtT51Drb9vnvF4GNDVbbGdF
 h0XiDIfG5/Yw6aDh3JlRmLz3RHMvyvyfkV+beR+GWWlsCV9+INSThJBxC7mWV6Ze
 yinlXzsYIYqNblQ+3958CFIfkzz6spv7GX3D8znBf7QewwHhXaF1p5yxZ+V0nD7r
 AME+vA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42p94pf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:20:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso5327341cf.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787912441; x=1788517241; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aX+j661dB8JTyvZbLryyFD0MRGDLFrI/YWJqg3cbhzE=;
 b=BrV8cG4AJzRW3YWIx7DMUQdno6kAuHKcZMWA9zMUUF9sjIwJI56MZDlwVyMxwKy0hZ
 I2kzE2BnWo+mzaIslQEeH66V3dLUXN1jIgD3rESfQbjLKEWVfX1mcSC7cILfD4MZEf4+
 0oUrsz5v/CBNlbuINWfDJR0+kPpzxqvu8JTqTO/iGWF10ym4cJ/uzASNnbjEFw9QOsaD
 VMoBTPnXWz3xiBqs4EdnZQQdb2FzOxlwbBGBZzEesyMAhwH/ac8cUsxTFemL9Azbtqzf
 vElwef2VTZQXVN9Nj4Aq+TPsBFqpmwv37uc/+9+uSBQ9zDEIwh2wTm20QdPRiD83S1Xg
 Uh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787912441; x=1788517241;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aX+j661dB8JTyvZbLryyFD0MRGDLFrI/YWJqg3cbhzE=;
 b=Bvk/eTl9CDIRjcfU37isVNs5XrsM7hj4Jq9km97FYem6eXvKLzO4HPR/tbUSL0AO0u
 Jw374hhUEj92iUxHn0l9riqeJzDfH4A3WRoo7kC93RADF9xf3A8FmzeHBnB26vfo8b07
 KR4ivxqQC1NNKZpCh1ANQ6TyjbvGy3NLKY5MCZZmqP1a0XAFUf6k+8Aj2bJn4R3uso3B
 AynfQv/5EajnGw40nYefvtMF7E1InVQV3w1I0XnReQtFXpIJ7Ki/85nbdr3ZBImqe+yb
 xCUrDZvZmBkOBv8tnfIzaxSlrsoMZmmk4qedYJBDQVDyc4oyL58PYEJM2iCjK+YSx+O9
 gZzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEcCRBwDg8XAp8+TgqUbiyXXv6nzV7ZHron+/CE2gOniiX2PJ4u7yxcJbmIRL+cljcq1i15nM/dEZE@nongnu.org
X-Gm-Message-State: AFuF++kVX/2mHS72rLezqKKbt94gGIsFbHWKK3mkuBNHOCGbQTK0Q/kn
 Ju9GJM/aig3baedul+UTvL4MWqblv7Mj4wvpmX15DKEBphzAGgalDWCMZ/8dJQCFpoV63eotmQa
 bkj7rarTP79ebzSgn4qbykjqsPl7Hk05MRRrjM68HALTcl+Jl2aPECU2cJQ==
X-Gm-Gg: AR+sD11gb+y8E+xdBpGGQAt2eZuPK8T71hXk1Bfr3HFt2KXJApfKgsH0nQ0v2w+tEHM
 +uHqtGzSFQBAxTY0L6rmwBjF8dTLqoeyFjwlt2dezfn7maA9ZSm8caPcZLhQZW9a5qqPdK53WSp
 GOjcMOOY3Oj5+ro3y5HZsXtpWZnjXjvRcmCMyB8mjX90KWDGNDEJjv9pb1vI3uWxpVfkKZaz/5C
 vlCzK0zb+IhQdzLkAuQXR8kVBfEDnsh4MNgRxYWkUefxpIO+0OMXKa/8qCIqEcz8kShUbdebL1H
 NBY1R4Z8ghLvNg4eJeeKXS6vNipLeuCcqEfzWXzgQpy52ETj1REI4oOC9h4/gHOss8MiPt412Mf
 8ratx6+5g26coPQeemD/AQSGUCpLvqRErBw==
X-Received: by 2002:a05:622a:1210:b0:517:6550:2a0 with SMTP id
 d75a77b69052e-52fb95f6089mr63691231cf.19.1787912440940; 
 Fri, 28 Aug 2026 03:20:40 -0700 (PDT)
X-Received: by 2002:a05:622a:1210:b0:517:6550:2a0 with SMTP id
 d75a77b69052e-52fb95f6089mr63690841cf.19.1787912440520; 
 Fri, 28 Aug 2026 03:20:40 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dc103dsm37816525e9.1.2026.08.28.03.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 03:20:39 -0700 (PDT)
Message-ID: <8a787e42-0ead-4fac-93b5-50d3e1f1e754@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 12:20:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] docs/about: Deprecate the 'next-cube' m68k machine
Content-Language: en-US
To: Thomas Huth <th.huth@posteo.eu>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20260828095241.118458-1-th.huth@posteo.eu>
 <20260828095241.118458-3-th.huth@posteo.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828095241.118458-3-th.huth@posteo.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IOaaP7Uqkuc6NdRabWZnuQuI8BqAkXgi
X-Authority-Analysis: v=2.4 cv=ToDWQjXh c=1 sm=1 tr=0 ts=6a9160f9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bgKrIEmzAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Ifulqbl_J-1aL42CD9IR:22
X-Proofpoint-GUID: IOaaP7Uqkuc6NdRabWZnuQuI8BqAkXgi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4OCBTYWx0ZWRfXzuLu86WjuG1e
 BvGVVWVFm3UdkpPe2UuZe/Ov8VS1p+a1qx+8XbzDnQEfVuKyO60SBB2fguA4S+M8AVdUx9C5s6p
 S2P6sSzGvbgEZYpmLvzMjw3NJi1klmw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4OCBTYWx0ZWRfX+fN2uLu0G63W
 6GqINMNKXlKUaV0LFsUg9op9RmZfCM77L6pFMhMvU9AjH4K7njVVZAXSrUQwDDVAogssg/35NV7
 bULGm19RPzKxAW9J4lTV8bgqxLojxHWu/hVzY5dUumAUU9QFvgfrkwOWmSNvMiDbj8HmECmQOK9
 h5bdPCu8YVViEc5XHn4rHmcowbs1eMCzbydLtNOQVGKZT6DTSV3jL7MNPAZbAKUG60gtwbJVzwE
 9YnCKfGGMMM4qpZRZbsl2lFW+vaHy1iQAuFP63OfcajTFqb1H1LjTCr/00qkGI7bK23gNVP2n6v
 hU5bYo55KkMftuVD9jhREcH5gCTWwNLviz54QDKYx1ikZlBQdsdSO/3iohwcWX6C+Jq8nv88g13
 cTNEsE1JIPpPnKc2PJzvGG7T+nZ9cF+L++N1ilTKyxrZRsduvmz3aQAbb0374ZmgtBduYeZO1Dg
 EvN5Pp8pJmmv59lB+/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280088
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

On 28/8/26 11:53, Thomas Huth wrote:
> The machine is incomplete since years and we never managed to fully boot
> a kernel with it. So it's maybe best if we mark this machine as deprecated
> and finally remove it again in case it gets into the way of a code
> refactoring or other reasons.
> 
> Signed-off-by: Thomas Huth <th.huth@posteo.eu>
> ---
>   docs/about/deprecated.rst | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

