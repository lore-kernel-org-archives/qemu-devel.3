Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671DB606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cgzdDrNf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YuXHHEK6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJEBv-0006h9-Fg; Tue, 20 Oct 2026 14:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJEBs-0006gZ-8l
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 14:04:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJEBq-0005Ix-B6
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 14:04:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGu3hN2797284
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 18:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fTrmGqwHO/B6pJtvQI5toOXlN8tFBTnYw2yW1GvY/kw=; b=cgzdDrNfo/4T4QEi
 9mNxJEGmOOxAHL28Xs8xYBFEK+rMjkHSgZuRisvspOO9KQDgMOst4tEf6f2u9Oeu
 6vPR8zrB5f6b8oukSm6XWhUM+2h7jMcuLRGg49PegSZ23qaFojDB0QNgF6Eq50Ep
 HHKFHs2ll+EYj9fR4goJl4Dljg5VKjXtQ8kfAZZ0vVcEKFRx3sMyMBJIEPDazYJS
 1S57y7ZYBHLGIwxCNa7+Sf2B5uk4yfxMKSKrRtLASSHSMFmI2XI4ZLEMzthXCY3O
 HkWqtMCrN8ZYHAT+nh72Nu83yEHDxqrIpMg2RRqgSne4W0V5SY98cH33SVbnJbD4
 ky0M3Q==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5pkurs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 18:03:56 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-4a7235ca3a6so2407507fac.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 11:03:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792519436; cv=none;
 d=google.com; s=arc-20260327;
 b=e49Mw4UshcHBCkR97CmaQPdmzFnc1qPB1bWmsgIFuYO5bmI90lh2UtNDhFL1nhIgtd
 JWZEdZgrD9kMNV6miExBsOy7M1gVxnbrrwPWDdgB81SNPqii3qvkSB6Ct2QX7bY7kaCE
 JPOKxWTOD9OzN0DPYa8cowaPA3Pqy/hZQ3+4cZe6HHuQek0nJAznLlwTIDdvHxbt9lc/
 zBFbkUsyjreWbYWzfEygrFb0EkdHm+jppZtR9CSL+/5RaQlG96Hl0M9mw5Dx0H+ZQkKh
 ehIkKUH1flYIWsF8iIK9wzSdfe09kLwzeNqRlhg2pkHpVdypKeELrpvPSoOVIiV5rjQj
 7//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fTrmGqwHO/B6pJtvQI5toOXlN8tFBTnYw2yW1GvY/kw=;
 fh=DkbXE4ccMsTX7HmhBC7cW9zKYDAyLxQ+nKGU9uhWHTg=;
 b=h+n3Mg+8Rq1H3kJLJVyDtmWdGU0QRDlqsj20YClnXf+7qEe/6P39xMbCqmKRqyBCDz
 Yf6O+9x3jebVyzz57/LeMCtulbEDws6RvRoZ+0Ub0anEG/bFnezrSjFqpCefRGJ85yG7
 NsOY5ZhZAlzbZv6mXNc6OdTyYIRhOOkZilXkb9bNO864KtJgWja1pgNDFUm8bAf2rDXO
 I89gCrCGDGp4Z+oYrBPVYc0+zq/h1Uz/EjBYxbff/n+elafWiB3YxEPxdmmAk8hx9H0F
 UZtZnxW/eyfPCwS4nXXtvylfcHe0D9PMVUwAVJW4L0SJXjGMYYpeItCgUZeydUEBQiaX
 V0Nw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792519436; x=1793124236; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fTrmGqwHO/B6pJtvQI5toOXlN8tFBTnYw2yW1GvY/kw=;
 b=YuXHHEK64YPo6xuRi413uueRIfcU4Bal5QG0g/ZgbRtysuUjK4yt8XTlpMWpu0NmtP
 n+UO2E5WdJYhd0UBrpSQeDZcSmidSq3mhIqMWdN+mzv7YzY3zQ9m7haubUFkbmHFbYc+
 QiY+Cb5hPWqzT/JQhRMsJLY/LWrrFgRT1d8KOHpZHdbz2v5iXiKk4Q0h9qyGMRZ25hF3
 Ver1maAacBVJqRqRc1XzwcviDPXlBmGPprzneDwdsIIiNEHvFWe4RvhlcdEnSik8bP/s
 xITRr/2fjFPUJEJ93e4SkLKzImi3CEW+Nfhqhtv97jatMST4OlhN7AEBZdTFtGMSyJIA
 BIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792519436; x=1793124236;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fTrmGqwHO/B6pJtvQI5toOXlN8tFBTnYw2yW1GvY/kw=;
 b=t4axouwstOm5sc38dQHJGwis9532vTP8YtmAiEBsUWwicpR2ke33VrCXGCJ/ZQHNe9
 sI2NfOE/4tvHYx0L6uHigAd/Y8yXMOnblG+FMqNdE1tJ5P89bantCjNiNSNW5ZOMxKQM
 dBwKXX4XVxpzf4yUmSdldo8/51CvXuJOHbWSIdNkp1tzevdzce4P++dYXtYy7ijYOKhm
 Wyva5hvj6AB/+Cw4pQi20GTKsbJkgTdN9Q/YJHaX1U3iQ0X6/AB2Rod4JGbipSA5N8K0
 XQHmCWEp/RDvXwOsXrP6D5+kgKaXMra9mu2pXvkHck46OFaOsXjmsMU36ghEdDk0qOtr
 id0w==
X-Gm-Message-State: AFq9FYInWefvVXDhLwlrrNskBOaAG1NotKKnrT9LhrCprj/fAGLDJ6dR
 8QB7Ol+gmcYsNOb6LZ9kaiG2USMq/zHa0vtysK+jDRiVfYtnX0MmUyccWKjgo+Ngr2d78HBXH7T
 6pMRcgzJBiz/QVWY4BusU7fLuDhsQRZHq2eodRaR8K3IgW1QZCkwlUEINVCdJQi7h/oy1qUo1wY
 t4/EfoJj3Yy96rPHeuPAFRvQEVjBnM4SUo
X-Gm-Gg: AYBFou0TEGL8SZDQ5SlfjKah5VULmIktWlTUJhzD8zDRULLilE2A8IvYIm4E7NsDOCa
 RYAzM+ck/QBP1ssqiEfIJbQh6Yyk766j1eKJFSCrGni9M7aWPbsS7t0L4f39xVwkjP2penEKCQl
 BrFnxV3zlnpktKMqcwJSvf7sdXayp9VzwoU2zZp1XblhoDERCtUOYwQ4jjuxPgW06SWAcfW+d4S
 IIb/KLyGYLb2UdMjQ==
X-Received: by 2002:a05:6808:4a15:b0:54f:a72e:1f28 with SMTP id
 5614622812f47-54fa72e401bmr1297144b6e.25.1792519435895; 
 Tue, 20 Oct 2026 11:03:55 -0700 (PDT)
X-Received: by 2002:a05:6808:4a15:b0:54f:a72e:1f28 with SMTP id
 5614622812f47-54fa72e401bmr1297118b6e.25.1792519435353; Tue, 20 Oct 2026
 11:03:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
 <20261019172603.2625677-9-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261019172603.2625677-9-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 13:03:42 -0500
X-Gm-Features: AclHuK-glWb67EEiyPvrBrq8c_GlPOavlqTIKvAV2BoYoGWXWrqxDcm28Yf2Hvk
Message-ID: <CAJ+KCYN989=NmygpwD3OX9aSH82oLvvFwMjwqR4mCn64_0FGKA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] target/hexagon: preserve callr target when Rs is
 LR
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=a7WlZkSF c=1 sm=1 tr=0 ts=6ad7ad0c cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=qGfIP2fYMrPsKiidr-YA:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: L33G3rp1HpbXn4ABPrL6ZK-Zexysb112
X-Proofpoint-GUID: L33G3rp1HpbXn4ABPrL6ZK-Zexysb112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3MSBTYWx0ZWRfXzicrnLhhX6hp
 ofNS3sR/moz0qDmw2P9QQMFStpPD9sRuMnyXKMZZ3hlVcd7vNsj2hppgHSI5bmjxM28QYzUGZrd
 5IgDji2HDkJJqYdozARJPU4M3TRxV/cZfCDGLSwxfFwfLskBOKqCrQNW1G+6T7fQ0hD8BBkdyPO
 aqARuopySBV6rB3eL4EoFGryivhggryQJwUgYOiYUDrAPjVJ1vGIOfv2IuZRzxmzqCGfSNzHlFN
 igY2En66fKXb5mLnHNOFe0zn/tRreLiTS5ZWm0ELw5HbADWrnwqFsTjIS2/dQxOIVdxwcvk2g4y
 tFkSgPDcIZTU3Cr0/8rRXFZlIyyMVz1aO6RVXtuvYHjCwU/lV2CgGAwwuukYSiL2jydOVgEkRs0
 eNrf6zjlfTlNRpfinan1J3vhDSUBEiiQtoVxwkp9rVfqnHtPP9SpGExrS6mtzq0h5rrjmq75Ejw
 UTUVZmi7Y03WN4u8jbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3MSBTYWx0ZWRfX+hvKuY/WdI5g
 JMWM/SgokEaEtUhtOZtLDK4QbHe35RHMoeIeNjGurtrhG07F9vs1GLQ6ogQ95ssI3V1kLqq44HT
 zw3gR9ghfuTzPxvosPyjVn4bpq5NuAc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 12:26=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> gen_callr wrote the link register before consuming the target, so
> "callr r31" jumped to the new return address instead of the old LR
> value.  Copy the target to a temporary first.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/genptr.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

