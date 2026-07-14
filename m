Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D33C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZqS-0003TE-By; Tue, 14 Jul 2026 05:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZqR-0003Si-EC
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:54:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZqP-0003TD-90
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:54:31 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6Sj4C3862214
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xTNymD3v13JWKysNguHs67dHFs4R2ICi1CmS6mGnMA8=; b=mTFx2g45aZneKvU/
 11dOjmOtSPKuC6g6QtxsWHXzwcr3OG3Uv1rOcMiBIa7/Df2gO5NOby2Z3CoYsyhM
 Q/vVg8yk/MIixP7JuSUlWrCUjJUchEVl3tmRqTib27mYQO+cVGuDVIA1jV9sHiVx
 4RI8ibgPoZuuznrwHMRN/tIqaC56mXz5cBZ8ZGe3cE2Mc4sio//5XX04vm4/h4/7
 tT2lEY6i9liW4jSJIJOxMFvRCpZxlgKmuse1K/MiANGjGwmRR5agpvZ4BHpsCjub
 rXqovu7JF1FekzUyNEzbFai9x6wbqKs+zttdYjGbDsLuJcjbsRgUF7DuAwoatlA1
 1mK1aw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44j36h6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:54:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a236220so64837721cf.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784022867; x=1784627667; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xTNymD3v13JWKysNguHs67dHFs4R2ICi1CmS6mGnMA8=;
 b=gPjWscVdDy4CPBrL4VUlbAHh7dbRDOWMFK+mwEosXdirN84VmnCeOf3OhegK1hGEtl
 ljhwX2XRyJUMVqHb4AF3EgKwERmEbsqjl+kCPVc4qO0nuvzeWwsaFeLpNBdirB3jegK8
 P49Kp+sWfrzPuqdpTc2L9lZCRHZ6kbawBRah0K+afbXTcv6MIyj0Vqs3YgWP/Ntz6oLn
 xpGI2FXUy8toV6QKTHHNI2B272UXP8e9fdJzx2M1AHpwQiRLgaH677mYkOf2MntPzll5
 PrtDC2rG8cxZYmUGVsg4zhfYk1hPrWo8p3x6AHTySIjep2BouzjUM9iPb5NrGMmdCC7X
 qILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022867; x=1784627667;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xTNymD3v13JWKysNguHs67dHFs4R2ICi1CmS6mGnMA8=;
 b=DY/CpAYJo0mryAbk0fjEkxz2290ZzaWJ8xzKznrTApW+6Jan11Ctayotcvdl7i6VGO
 wlCTtGH/htyI8anH3lEzcTG6eW8d5NLw7VY3UuFGtbWna5DgTmWUJqZT3MSOMcRJ2skU
 0nm3iazhbu1JQHQRA0zH86HZ9zo8jXjIIYmc908bB0RuHZllY84zq/CLNzWt7ZmHpfqP
 n9qugXDFd249MiH7dMhNylpMyl2Age8bgE+j2Y+8/YahAmHnb4av2F09KK26vj7Y0Zs+
 B5+X1N4X8QDlETwJt+4q0aJPBxv3eVZetkPuVWQ53Q78YVigB5pppwCA+53jKDoJToPk
 ax/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoM0ZM5e6Z4JJzsFxg2vHvOWUjLMF6dVhYA1oF6wUte3TCWrSxleBad+kYMr/lDQ14qOe3jDPAhOfqT@nongnu.org
X-Gm-Message-State: AOJu0YxY7Pwh0ONcisca4vThm0a8S/qQz3eUq2cJIxh96U380b9+B4a+
 T9tZkT3DK5aBnXrkKpr5oALRD5sFvHYoCj32DLQQ8Uz6TTJVK8SDncjvibkRpGlF9YfMTvz4JnR
 Qcwhqkk3Y56CTdEBghtnRTNcR4JaQ+Jg3scBSBzENPLSgcd5z/dQD7+3GWg==
X-Gm-Gg: AfdE7ckI0fHykRM0825AgwlbcwbrjMcw/pivlGKGjcuPQOTJSJo7WiWBI2REXd/HSlk
 FrCw6kEvxocj2sBYxzND2V3N337iIDUT11zVvGlm9vbxz0G2f4Xcqml/NlFDWYPdYCFv7P+DoQi
 hEE9DJdCZLrERMvEmzw48VEu0eaJzJvw/y8F8AY0zqaGTxg3slmLCsF5xkDV17kvyRugdKVfQAQ
 LpNgxB/ugcqbjPPqsYeR4x9CELq0fNFS+sCn2c5zgANKuEv1lzyE5mOL5ToAE7I3tTLOFcvaY2F
 G/fCI9b4JLhn4IXha7aHRygcchdHpXZypm3Xj1bTlhj9DEdJbnHTm1DjmUvZHYSixgieaUChuEC
 iuSrLSHifcnvNxkPtVx+weZaKiBowQvngWsXvspIyw4PIACgnzoTY7K++OlZ2Wg==
X-Received: by 2002:ac8:7dcf:0:b0:51c:20:aea7 with SMTP id
 d75a77b69052e-51e3c1551f9mr30569381cf.9.1784022867336; 
 Tue, 14 Jul 2026 02:54:27 -0700 (PDT)
X-Received: by 2002:ac8:7dcf:0:b0:51c:20:aea7 with SMTP id
 d75a77b69052e-51e3c1551f9mr30569301cf.9.1784022866978; 
 Tue, 14 Jul 2026 02:54:26 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69cd2878be8sm1251179a12.6.2026.07.14.02.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:54:26 -0700 (PDT)
Message-ID: <aec1a191-6f82-4551-b855-5cd481220d82@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Rework FIXMEs and fprintfs in hcd-xhci.c
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260713161406.361197-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260713161406.361197-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX7DjYj/u6hlVN
 FOnz8beblNAV5rLGiRC2PHbDZnNUegwhojdAe+ChvwaXWXYM8L+5i2c3BOTnLJSJLSqLYFG9++A
 cAXwvFhsHCHyN12sglP8r1OlIjoy3Dw=
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a560753 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=4qxsl7YUZGw6SmFp5uQA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: MYkYmLaZ522Mw--ALxQxhLIq1GuiNd87
X-Proofpoint-ORIG-GUID: MYkYmLaZ522Mw--ALxQxhLIq1GuiNd87
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX9QqSzF26717M
 LsdUZgqbnGw0PKRmkzjVxKJR3KZJNZPfQ/03Ohb7HyHokp+yY06IaYUZFbMkJbpNtiPdqvgoqvd
 Yk7v86+0AiGthjSjAf6BBKSjZgf+HfwjCO6PaOcE4/70BIpGV5Y8kRTACaeCoIPbYPedickAzRv
 jwGod03B8/D5n2iKnLPULcJcx8tS+4ixho9Vos6X456bNG983MF6ZPRN1pZkcNLZJVWcsIb2DrW
 hYUOI1olFzvEEKRV5T1br+AhilbdtrdV6lKFzzK1T7Im2tHK28rcbn8gbvwmkd9YKxbnYb1xPEh
 QAbh/s2NHXGW2Tn65YE331grUY8oHgDdkbRAh2+Kib5MfFXiLPz8pwfYnayRkpqpm7UXyj+r5qe
 eLOJDVxLecqYiZLl+CTIduDTWgBnxrslrWe/GgYulz58Rd3J0BKJJt1FRkp39pQsHT5cakjXaSB
 eU6il64/l/PGuJRJouQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 13/7/26 18:14, Thomas Huth wrote:

> Thomas Huth (3):
>    hw/usb/hcd-xhci: Turn guest-triggerable abort() into qemu_log_mask()
>    hw/usb/hcd-xhci: Remove the FIXME macro
>    hw/usb/hcd-xhci: Use qemu_log_mask() instead of fprintf() statement

Series queued, thanks.

