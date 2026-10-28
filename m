Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED041606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aFfwNPq8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tsgyr2qf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLxhd-0000WQ-UM; Wed, 28 Oct 2026 03:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLxhW-0000Vw-E8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:04:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLxhS-0008QQ-QH
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:03:57 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4PQrY3381222
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xRthz2x/+bhwmNJmyf+SsJrR6PwpbO0anL/USUjEnRU=; b=aFfwNPq8skh5KjvW
 Zxl9f+RdNBQJFup5toz/rEeVjGMB1AKxsDifCeBcBGyhn++V2tNzIpes60ow5VtN
 /+kWmHlKWpLQaISIOmRCuC+K54Ydj/REAdz3zDs1YlrErmd5Hbegw6uOPmfHssN/
 sq1gsd0PvtjWBX+SJV4pXsM9pLBWTp0qtjNxqfdYbbX/cfCjCADF72ENg3cJrLgS
 y3q+h/KVg9kJOX1Ka/tvtSP08RxteMR7oG6NEfQ2kVl6s2CtGD7KbNiN/5nPd7a3
 havHhdM42w4LLleZ4AEjLJJaOkeaPzIttqA2kXJ3Rz7IIaAjY8OdMiCk5hdejcOE
 cvHAYA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6f917dy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:03:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ca9b53afaso168680785a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 00:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793171030; x=1793775830; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xRthz2x/+bhwmNJmyf+SsJrR6PwpbO0anL/USUjEnRU=;
 b=Tsgyr2qfKWBM0NB5Xlc0TZNM/Sv1HcqiubFYjbJ6p4OuDHc1+oTlQE0ozuSj+x9n1Y
 OKbqTx7RPeexDMgbyLCMCESxLc8N4E3i8V/SbRA0kuUG6ZD3eeqscjWc2qdHvLVAPZS5
 bOgWNXd/vByijJW0zozIb2Ob+XwbWfpu5K47N0KAiMbB29DKC/73KDKGEf8nbWTLnkK5
 6ojG8x89on+x0MmU2j+hcPLj+zjxFLZ7EIVLBfEQgNmrdBCyfyfG4N8nLPoieSrQxGhH
 dn7xhREHQOekYJ+mT4FDUbccgKyKS4DOiiBqbuZGWlaO3KXJaWrbIXtgrlYSesIKoNkv
 jAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793171030; x=1793775830;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xRthz2x/+bhwmNJmyf+SsJrR6PwpbO0anL/USUjEnRU=;
 b=sLpBMhT3wEsogSdssFCldGF0WCrfruV1nnTw8wA9r+GFEBHRcdPirRhUdRjw32Bva5
 tWt+W4n4JCPbUg6k5RneGa0OyOeUoqLgeoU2J0ZJK5X2qOsGjBHlryEjUhlGkuVfnz8r
 AOcuXx7D9nfMmY7eV00MIHDHjEz05BGML4rAIqo+nXzBYANXtbfFfZB7mjV9lzEGFNsr
 DSCvHD+l8JRexiJC9sXINzaGj3dWB//eTWZEDKKSJVIVoR475nZ20OEMvQZgw/kR6kxp
 BKRXeeha1svJQkm31U/6jFMExxNVa9QGu5tqRKrSvpeOEgrUyKdGMrKEVNi6rlio/N5X
 8Agw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbx6F6genAqqkA5IK/VqacCBOR35kON1WpL0bj3lzc85lmEHST2BHHydlH3YWq/K0ndOct+40snnDJ@nongnu.org
X-Gm-Message-State: AFq9FYLaiWaPR5ZqNSJEskT6LfiJgwsnKGI5wKQXk5tvHnP2Zh9uqntX
 4YSyaIV3uI0uQHkLvdIoDJmpJIhVwx8L4VwO6X/jHsu5JH9sh6JWgeckIfK5IQlK0YrDUxFvTnw
 TRlswD84FYSAewijIkiz1nEhHUZmfnSW6kq0SoC7tgCiWBw3VrXu4Nr1LEQ==
X-Gm-Gg: AYBFou10s+npHumHwXQVqkwFItXcmgvybGGp0Fm1M3B0On9k2d2++mJJ5/6KZzduuvE
 KslkF76MnNbILsdQ4inaiHGZqrE4aIstsBptCUEvcN0wdqv8v1C4z0KaDNiW2hiZOfRxqXIvZAi
 P4condVbhO2ldOxnjkDJEwuK0Ei+X+WmRg19ShSLdNv2FwDsQWwBKf+3csoN46WM7E2xucrJmSe
 PwZNEF8KRZXdnCFflKBHqGYZkl/weLm83H80afZODk/29kCPVWVwQZemmf9TxuZB9QGTjcecQ7y
 A6SiBmDmEhNNv1iEa6jbOMWAQtIMOEBmtaVo1l932wMqu0DD9SW9d474mWbbdNDrLEOPrB2vlj8
 pZQt/0zmwVdMfqK1o0aOoos58d8OEeFIfXv51TR92COxK8/Q1kOOkd+14PPafF0ynjslzRRD/xL
 2laiY2W296QndvXFhAjqnqIrQ=
X-Received: by 2002:a05:620a:2a14:b0:93e:66e6:fa4 with SMTP id
 af79cd13be357-94408cf36f8mr189104485a.16.1793171029787; 
 Wed, 28 Oct 2026 00:03:49 -0700 (PDT)
X-Received: by 2002:a05:620a:2a14:b0:93e:66e6:fa4 with SMTP id
 af79cd13be357-94408cf36f8mr189102785a.16.1793171029337; 
 Wed, 28 Oct 2026 00:03:49 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97c9f1403sm25392275e9.9.2026.10.28.00.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 00:03:48 -0700 (PDT)
Message-ID: <54c73c71-6ad7-47a9-98e6-893aa1b9e6f8@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 08:03:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust/chardev: fix write errors and add write watches
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261027183823.383806-1-brian.cain@oss.qualcomm.com>
 <20261027183823.383806-3-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027183823.383806-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=frhJ914f c=1 sm=1 tr=0 ts=6ae19e56 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=iutzSQcAoqjh_2YZnUMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyNyBTYWx0ZWRfX2S72XR8GJoYI
 aHk45xzk9m6+wghSdtqjfjPJU+MiBY3ekfZIIZtPH9D1MOnXhQGvruk8gsEOn9ux5bsAjUZwP12
 22x3mY+/br4KFqbpjHIGRaWrpFVIu4I=
X-Proofpoint-GUID: DonWE3FzmjKArOUT5rDXYSOaySc2dzaV
X-Proofpoint-ORIG-GUID: DonWE3FzmjKArOUT5rDXYSOaySc2dzaV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyNyBTYWx0ZWRfX1VcLGIn3eeB+
 RjPKWQOiqNbEheURwY86F9QjUQyyVxGhZmUMCT9+lj+/ocS6RylxuikmCd1+KmlsnU2SB/pZE1f
 IWI9vD9tiJQm/hytibEyObsZwTCbtNmqlHWF0TvO2TMXUm0+efpxZ3ZXjM+Y4/MttvJ/l7jil3B
 eBzM7Mk5L5cbD09rnqC8Ilm7Cjuwds2rjQe2VLz1Wp27saiYkyKc4lbhIKK8/7oLTQUa9NGOgmb
 wtin21WTaOle7bQYL9mv69DMJ+yURVJq8V8qFIdReKff4iK/LfiutnqesU0bJ8d4K0t/dHw+k1F
 9exY6wECM6VzxXxEEeZFTAbjNY6piX0WjLpuBnUq1AMawAHUOiNSs0JmwXgqVtL/149iWZsUFgq
 KPUnWfnM7l12iOA+hT+53YQftiYJ5VFkStBrqLPVbUmbaDq4UTY1qh0bfF4tlglJHSQvkt48Ke1
 nenP6YsUaJxGG44s5BQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280027
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/10/26 19:38, Brian Cain wrote:
> qemu_chr_fe_write() reports failure as -1 with the cause in errno, not
> as a negated errno, so errno::into_io_result() turned every failure into
> EPERM and a frontend could never see EAGAIN.  Build the error from
> errno instead, in both CharFrontend::write() and the BQL-free variant.
> 
> Also add CharFrontend::add_write_watch() and remove_watch(), so that a
> device whose backend would block can retry once it is writable again.
> remove_watch() tolerates a source that the backend has already torn
> down.

Please split as 2 distinct patches. With that:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   rust/chardev/src/chardev.rs | 82 +++++++++++++++++++++++++++++--------
>   1 file changed, 66 insertions(+), 16 deletions(-)


